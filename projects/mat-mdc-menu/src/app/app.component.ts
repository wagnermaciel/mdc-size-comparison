import { Component } from '@angular/core';

@Component({
  selector: 'app-root',
  template: `
    <button [matMenuTriggerFor]="main">Menu</button>

    <mat-menu #main="matMenu">
      <button mat-menu-item [matMenuTriggerFor]="submenu">Sub-menu</button>
      <button mat-menu-item>Item</button>
    </mat-menu>

    <mat-menu #submenu="matMenu">
      <button mat-menu-item>Sub-menu Item</button>
    </mat-menu>
  `,
  styles: []
})
export class AppComponent { }
