This repo contains a set of apps that can be used to compare the size of the traditional
Angular Material components to their MDC wrapper equivalents. Currently this repo contains two
separate apps:
* mat-checkbox - an Angular application that contains a single standard mat-checkbox
* mat-mdc-checkbox - an Angular application that contains a single MDC wrapped checkbox

A summary of the JS and CSS size for each can be found in `results/size-summary.txt`. In addition
the `results/` directory also contains the source-map-explorer output for the main JS bundle of each
application. To re-generate the results, run `yarn size` in the root directory.
