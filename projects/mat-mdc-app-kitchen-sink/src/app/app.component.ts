import { Component } from '@angular/core';

@Component({
  selector: 'app-root',
  template: `
    <h1>This app demonstrates all components with a non-MDC and MDC version</h1>
    <div class="component">
      <h2>Button</h2>
      <button mat-button>Click me!</button>
    </div>

    <div class="component">
      <h2>Card</h2>
      <mat-card>
        <mat-card-subtitle>Subtitle</mat-card-subtitle>
        <mat-card-title>Title</mat-card-title>
        <mat-card-content>
          <p>This is the content</p>
        </mat-card-content>
        <mat-card-actions>
          <button>Like</button>
        </mat-card-actions>
      </mat-card>
    </div>

    <div class="component">
      <h2>Checkbox</h2>
      <mat-checkbox>Check me</mat-checkbox>
    </div>

    <div class="component">
      <h2>Chips</h2>
      <mat-chip-listbox #chipList>
        <mat-chip>Apple</mat-chip>
        <mat-chip>Orange</mat-chip>
        <input [matChipInputFor]="chipList">
      </mat-chip-listbox>
    </div>

    <div class="component">
      <h2>Form Field</h2>
      <mat-form-field>
        <mat-label>Hello</mat-label>
        <input matInput>
      </mat-form-field>
    </div>

    <div class="component">
      <h2>Menu</h2>
      <button [matMenuTriggerFor]="main">Menu</button>
      <mat-menu #main="matMenu">
        <button mat-menu-item [matMenuTriggerFor]="submenu">Sub-menu</button>
        <button mat-menu-item>Item</button>
      </mat-menu>
      <mat-menu #submenu="matMenu">
        <button mat-menu-item>Sub-menu Item</button>
      </mat-menu>
    </div>

    <div class="component">
      <h2>Progress Bar</h2>
      <mat-progress-bar mode="indeterminate"></mat-progress-bar>
    </div>

    <div class="component">
      <h2>Radio</h2>
      <mat-radio-group>
        <mat-radio-button value="1">Option 1</mat-radio-button>
        <mat-radio-button value="2">Option 2</mat-radio-button>
      </mat-radio-group>
    </div>

    <div class="component">
      <h2>Slide Toggle</h2>
      <mat-slide-toggle>Slide me!</mat-slide-toggle>
    </div>

    <div class="component">
      <h2>Slider</h2>
      <mat-slider></mat-slider>
    </div>

    <div class="component">
      <h2>Table</h2>
      <table mat-table [dataSource]="dataSource">
        <ng-container matColumnDef="name">
          <th mat-header-cell *matHeaderCellDef>Name</th>
          <td mat-cell *matCellDef="let element">{{element.name}}</td>
        </ng-container>
        <ng-container matColumnDef="symbol">
          <th mat-header-cell *matHeaderCellDef>Symbol</th>
          <td mat-cell *matCellDef="let element">{{element.symbol}}</td>
        </ng-container>
        <tr mat-header-row *matHeaderRowDef="displayedColumns"></tr>
        <tr mat-row *matRowDef="let row; columns: displayedColumns;"></tr>
      </table>
    </div>

    <div class="component">
      <h2>Tabs</h2>
      <mat-tab-group>
        <mat-tab label="First">Content 1</mat-tab>
        <mat-tab label="Second">Content 2</mat-tab>
      </mat-tab-group>
    </div>
  `,
  styles: []
})
export class AppComponent {
  displayedColumns = ['name', 'symbol'];
  dataSource = [{name: 'Hydrogen', symbol: 'H'}];
}
