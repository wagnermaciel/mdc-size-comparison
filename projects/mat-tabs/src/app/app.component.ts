import { Component } from '@angular/core';

@Component({
  selector: 'app-root',
  template: `
    <mat-tab-group>
      <mat-tab label="First">Content 1</mat-tab>
      <mat-tab label="Second">Content 2</mat-tab>
    </mat-tab-group>
  `,
  styles: []
})
export class AppComponent { }
