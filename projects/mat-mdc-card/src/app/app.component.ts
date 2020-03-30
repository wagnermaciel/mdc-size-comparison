import { Component } from '@angular/core';

@Component({
  selector: 'app-root',
  template: `
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
  `,
  styles: []
})
export class AppComponent { }
