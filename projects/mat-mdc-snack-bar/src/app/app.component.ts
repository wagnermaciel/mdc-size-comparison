import { Component } from '@angular/core';
import {MatSnackBar} from '@angular/material-experimental/mdc-snack-bar';

@Component({
  selector: 'app-root',
  template: ``,
  styles: []
})
export class AppComponent {
  constructor(snackbar: MatSnackBar) {
    snackbar.open('Hello world!', 'Ok');
  }
}
