#!/bin/bash

set -ex

if [[ -z "$1" ]]; then
    echo "Need to specify component name."
    exit 1
fi

# Useful path aliases.
workspace_root="$(realpath "$(dirname "$0")"/..)"
projects_dir="$workspace_root/projects"

# Generate a project for the MDC based and non-MDC based version of the component.
yarn ng generate application --minimal=true --style=scss --interactive=false --routing=false "mat-$1"
yarn ng generate application --minimal=true --style=scss --interactive=false --routing=false "mat-mdc-$1"

# Update the angular.json file with the correct Sass include paths for the new projects.
angular_json_tmp=$(mktemp)
jq ". * {projects: {\"mat-$1\": {architect: {build: {options: {stylePreprocessorOptions: {includePaths: [\"node_modules/\"]}}}}}}}" "$workspace_root/angular.json" > "$angular_json_tmp"
jq ". * {projects: {\"mat-mdc-$1\": {architect: {build: {options: {stylePreprocessorOptions: {includePaths: [\"node_modules/\"]}}}}}}}" "$angular_json_tmp" > "$workspace_root/angular.json"
rm "$angular_json_tmp"

# Add TODOs to module files.
perl -i -pe "s/^((\s+)BrowserModule)/\1,\n\2\/\/ TODO: Add modules for non-MDC based $1./" "$projects_dir/mat-$1/src/app/app.module.ts"
perl -i -pe "s/^((\s+)BrowserModule)/\1,\n\2\/\/ TODO: Add modules for MDC based $1./" "$projects_dir/mat-mdc-$1/src/app/app.module.ts"

# Add TODOs to component files and remove unnecessary code.
perl -i -0pe "s/((\s+)template: \`).*(\`)/\1\2  <!-- TODO: Add template for non-MDC based $1. -->\2\3/s" "$projects_dir/mat-$1/src/app/app.component.ts"
perl -i -0pe "s/\n\s+title =.*;\n/ /s" "$projects_dir/mat-$1/src/app/app.component.ts"
perl -i -0pe "s/((\s+)template: \`).*(\`)/\1\2  <!-- TODO: Add template for MDC based $1. -->\2\3/s" "$projects_dir/mat-mdc-$1/src/app/app.component.ts"
perl -i -0pe "s/\n\s+title =.*;\n/ /s" "$projects_dir/mat-mdc-$1/src/app/app.component.ts"

# Add TODOs to styles files and remove unnecessary code.
echo -n "\
@import '@angular/material/theming';

\$primary: mat-palette(\$mat-indigo);
\$accent: mat-palette(\$mat-pink, A200, A100, A400);
\$theme: mat-light-theme(\$primary, \$accent);

// TODO: Add any styles needed for the non-MDC based $1 that aren't already included in the
//  $1's base styles. This might include:
//  - ripples and other styles from mat-core
//  - theme and typography styles
//  - any other styles needed for the component to render normally
" > "$projects_dir/mat-$1/src/styles.scss"

echo -n "\
@import '@angular/material/theming';
@import '@angular/material-experimental/mdc-theming/all-theme';

\$primary: mat-palette(\$mat-indigo);
\$accent: mat-palette(\$mat-pink, A200, A100, A400);
\$theme: mat-light-theme(\$primary, \$accent);

// TODO: Add any styles needed for the MDC based $1 that aren't already included in the
//  $1's base styles. This might include:
//  - ripples and other styles from mat-core
//  - theme and typography styles
//  - any other styles needed for the component to render normally
" > "$projects_dir/mat-mdc-$1/src/styles.scss"

echo "
Created a mat-$1 project for the non-MDC based $1, and a mat-mdc-$1 project for the MDC based $1.
Please complete the open TODOs in the following files and commit when ready:
- projects/mat-$1/src/app/app.component.ts
- projects/mat-$1/src/app/app.module.ts
- projects/mat-$1/src/styles.scss
- projects/mat-mdc-$1/src/app/app.component.ts
- projects/mat-mdc-$1/src/app/app.module.ts
- projects/mat-mdc-$1/src/styles.scss
"

