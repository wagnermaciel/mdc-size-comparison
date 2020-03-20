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

## To add a new component
```sh
yarn new <component-name>
```

The command will create 2 new projects under the `projects/` directory:
- `mat-<component-name>` for the non-MDC based version
- `mat-mdc-<component-name>` for the MDC based version

After completion the command will output a lit of files with open TODOs that should be completed before committing.

## To update the size results for all projects
```sh
yarn collect-sizes
```
