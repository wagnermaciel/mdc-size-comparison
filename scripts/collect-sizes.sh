#!/bin/bash

set -ex

# Useful path aliases.
workspace_root="$(realpath "$(dirname "$0")"/..)"
projects_dir="$workspace_root/projects"
results_dir="$workspace_root/results"
dist_dir="$workspace_root/dist"
source_map_explorer="$workspace_root/node_modules/.bin/source-map-explorer"

# Ensure results are based on versions shown in yarn.lock.
yarn --frozen-lockfile --non-interactive

# Delete previous build.
rm -rf "$dist_dir"

# Write headers for the summary tsv file.
echo -e "Component\tES5 (non-MDC)\tES5 (MDC)\tES2015 (non-MDC)\tES2015 (MDC)\tCSS (non-MDC)\tCSS (MDC)" > "$results_dir/size-summary.tsv"

# Loop over each component and gather results (assumes each component has a project named mat-mdc-<component>).
for component in $(basename -a "$projects_dir"/mat-mdc-* | sed "s/mat-mdc-//g")
do
  # Gather results for each project (assumes the component has 2 projects: mat-<component> and mat-mdc-component>).
  for project in "mat-$component" "mat-mdc-$component"
  do
    echo "Collecting size data for $project..."

    # Delete old results for this project.
    rm -rf "${results_dir:?}/$project"

    # Build the project and create a directory for the results.
    yarn ng build "$project" --prod --source-map
    mkdir -p "$results_dir/$project"

    # Generate treemaps for ES5 and ES2015 JS.
    "$source_map_explorer" "$dist_dir/$project"/main-es5*.js --html "$results_dir/$project/js-size-es5-visualized.html"
    "$source_map_explorer" "$dist_dir/$project"/main-es2015*.js --html "$results_dir/$project/js-size-es2015-visualized.html"

    # Copy over the built JS and CSS to the results folder for manual analysis if needed.
    mkdir -p "$results_dir/$project/chunks/"
    mkdir -p "$results_dir/$project/styles/"
    cp "$dist_dir/$project"/main*.js "$results_dir/$project/chunks/"
    cp "$dist_dir/$project"/styles*.css "$results_dir/$project/styles/"
  done

  # Add the size info for the component to the summary tsv.
  {
    echo "$component"
    du -b "$dist_dir/mat-$component"/main-es5*.js | cut -f 1
    du -b "$dist_dir/mat-mdc-$component"/main-es5*.js | cut -f 1
    du -b "$dist_dir/mat-$component"/main-es2015*.js | cut -f 1
    du -b "$dist_dir/mat-mdc-$component"/main-es2015*.js | cut -f 1
    du -b "$dist_dir/mat-$component"/styles*.css | cut -f 1
    du -b "$dist_dir/mat-mdc-$component"/styles*.css | cut -f 1
  } | paste -sd "\t" >> "$results_dir/size-summary.tsv"
done
