import { Component } from '@angular/core';

@Component({
  selector: 'app-root',
  template: `
    <mat-chip-list #chipList>
      <mat-chip>Apple</mat-chip>
      <mat-chip>Orange</mat-chip>
      <input [matChipInputFor]="chipList">
    </mat-chip-list>
  `,
  styles: []
})
export class AppComponent { }
