# Overview
This repo contains a set of projects that can be used to compare the size of the traditional
Angular Material components to their MDC-based equivalents.

The results of the size comparison can be found in the `results/` directory. Each project
has a directory under the results directory that contains a `size-summary.txt` showing the
overall JS and CSS sizes as well as the source-map-explorer output for both the es5 and es2015 JS.

# Working with the projects
The current list of projects can be found in the `projects/` directory.

## To build a project
```sh
yarn build <project-name>
```

## To run a project
```sh
yarn start <project-name>
```

## To update the size results for a project
```sh
yarn collec-size <project-name>
```

## To add a new project
```sh
yarn new <project-name>
```

After creating the project:
1. Open `angular.json` and edit the build config for the `<project-name>` project to include:
 ```js
"stylePreprocessorOptions": {
  "includePaths": ["node_modules/"]
}
```
2. Open `projects/<project-name>/src/app/app.component.ts` and add the template for your component.
3. Open `projects/<project-name>/src/app/app.module.ts` and add the module for your component.
4. Open `projects/<project-name>/src/styles.scss` and add the theme styles for your component.
