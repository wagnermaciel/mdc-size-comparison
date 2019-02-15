import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { MatMdcCheckboxModule } from '@angular/material-experimental';

import { AppComponent } from './app.component';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';

@NgModule({
  declarations: [
    AppComponent
  ],
  imports: [
    BrowserModule,
    BrowserAnimationsModule,
    MatMdcCheckboxModule,
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
