#!/bin/bash

set -ex

if [[ -z "$1" ]]; then
    echo "Need to specify project name."
    exit 1
fi

yarn ng generate application --minimal=true --style=scss --interactive=false --routing=false "$1"

# TODO(mmalerba): Create some schematics to automate this
echo "
Project skeleton created, please make the following edits:
1. Open \"angular.json\" and edit the build config for the \"$1\" project to include:
   \"stylePreprocessorOptions\": {
     \"includePaths\": [\"node_modules/\"]
   }
2. Open \"projects/$1/src/app/app.component.ts\" and add the template for your component.
3. Open \"projects/$1/src/app/app.module.ts\" and add the module for your component.
4. Open \"projects/$1/src/styles.scss\" and add the theme styles for your component.
"

