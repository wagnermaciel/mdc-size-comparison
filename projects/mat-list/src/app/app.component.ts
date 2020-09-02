import { Component } from '@angular/core';

@Component({
  selector: 'app-root',
  template: `
    <mat-list>
      <mat-list-item>First</mat-list-item>
      <mat-list-item>Second</mat-list-item>
      <mat-list-item>Third</mat-list-item>
    </mat-list>

    <mat-action-list>
      <button mat-list-item>First</button>
      <button mat-list-item>Second</button>
    </mat-action-list>

    <mat-nav-list>
      <a mat-list-item href="#">First</a>
      <a mat-list-item href="#">Second</a>
    </mat-nav-list>

    <mat-selection-list>
      <mat-list-option value="first">First</mat-list-option>
      <mat-list-option value="second">Second</mat-list-option>
    </mat-selection-list>
  `,
})
export class AppComponent {}
