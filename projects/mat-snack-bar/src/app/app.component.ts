import { Component } from '@angular/core';
import {MatSnackBar} from '@angular/material/snack-bar';

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
