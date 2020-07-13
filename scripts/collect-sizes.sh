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
echo -e "\
Component\t\
ES2015 (non-MDC)\t\
ES2015 (MDC)\t\
Theme CSS (non-MDC)\t\
Theme CSS (MDC)\t\
Base CSS (non-MDC)\t\
Base CSS (MDC)\
" > "$results_dir/size-summary.tsv"

# Loop over each component and gather results (assumes each component has a project named mat-mdc-<component>).
for component in $(basename -a "$projects_dir"/mat-mdc-* | sed "s/mat-mdc-//g")
do
  # Gather results for each project (assumes the component has 2 projects: mat-<component> and mat-mdc-component>).
  for project in "mat-$component" "mat-mdc-$component"
  do
    echo "Collecting size data for $project..."

    # Delete old results for this project.
    rm -rf "${results_dir:?}/$project"

    # Setup browserslist from root.
    cp ${workspace_root}/browserslist ${projects_dir}/${project}/browserslist

    # Build the project and create a directory for the results.
    yarn ng build "$project" --prod --source-map
    mkdir -p "$results_dir/$project"

    # Copy over the built JS and CSS to the results folder for manual analysis if needed.
    mkdir -p "$results_dir/$project/chunks/"
    cp "$dist_dir/$project"/main*.js "$results_dir/$project/chunks/"
    cp "$dist_dir/$project"/styles*.css "$results_dir/$project/chunks/"

    # Create a directory to save the more granularly split up code.
    mkdir -p "$results_dir/$project/split"

    # Extract CSS inlined in the ES2015 JS, e.g. styles:["<CSS_CODE>"], and save it.
    {
      grep -oP "(?<=styles:\[\").*?(?=\"])" "$dist_dir/$project"/main-es2015*.js || true
      grep -oP "(?<=styles:\[').*?(?='])" "$dist_dir/$project"/main-es2015*.js || true
    } | tr -d "\n" > "$results_dir/$project/split/base.css"

    # Delete the inlined CSS from the JS bundle and save it.
    sed -E "s/styles:\[\"(.*?)\"]/styles:[\"\"]/g" "$dist_dir/$project"/main-es2015*.js |
      sed -E "s/styles:\['(.*?)']/styles:[\"\"]/g" > "$results_dir/$project/split/main-es2015.js"

    # Copy over the unchanged theme CSS.
    cp "$dist_dir/$project"/styles*.css "$results_dir/$project/split/theme.css"

    # Generate treemap for output JS.
    "$source_map_explorer" "$dist_dir/$project"/main-es2015*.js --html \
      "$results_dir/$project/js-size-es2015-visualized.html"
  done

  # Add the size info for the component to the summary tsv.
  {
    echo "$component"
    stat -c %s "$results_dir/mat-$component/split/main-es2015.js"
    stat -c %s "$results_dir/mat-mdc-$component/split/main-es2015.js"
    stat -c %s "$results_dir/mat-$component/split/theme.css"
    stat -c %s "$results_dir/mat-mdc-$component/split/theme.css"
    stat -c %s "$results_dir/mat-$component/split/base.css"
    stat -c %s "$results_dir/mat-mdc-$component/split/base.css"
  } | paste -sd "\t" >> "$results_dir/size-summary.tsv"
done
