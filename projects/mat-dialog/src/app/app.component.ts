import {Component, TemplateRef, ViewChild} from '@angular/core';
import {MatDialog} from '@angular/material/dialog';

@Component({
  selector: 'app-root',
  template: `
    <button (click)="open()">Open</button>

    <ng-template>
      <h2 matDialogTitle>Title</h2>
      <mat-dialog-content>Content</mat-dialog-content>
      <mat-dialog-actions>
        <button matDialogClose>Close</button>
      </mat-dialog-actions>
    </ng-template>
  `,
})
export class AppComponent {
  @ViewChild(TemplateRef) template: TemplateRef<never>;

  constructor(private dialog: MatDialog) {}

  open() {
    this.dialog.open(this.template);
  }
}
