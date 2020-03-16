#!/bin/bash

set -ex

# MDC currently has an issue where it does not work with webpackLoader
# (see https://github.com/webpack-contrib/sass-loader/issues/804)
webpack_style_config="node_modules/@angular-devkit/build-angular/src/angular-cli-files/models/webpack-configs/styles.js"
fix="webpackImporter: false,"
if ! grep "$fix" "$webpack_style_config"
then
  chmod a+w "$webpack_style_config"
  sed -i "/implementation: sassImplementation/a $fix" "$webpack_style_config"
fi
