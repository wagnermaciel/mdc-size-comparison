import { Component } from '@angular/core';

@Component({
  selector: 'app-root',
  template: `
    <mat-chip-listbox #chipList>
      <mat-chip>Apple</mat-chip>
      <mat-chip>Orange</mat-chip>
      <input [matChipInputFor]="chipList">
    </mat-chip-listbox>
  `,
  styles: []
})
export class AppComponent { }
