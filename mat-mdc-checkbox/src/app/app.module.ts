import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { MatMdcCheckboxModule } from '@angular/material-experimental';

import { AppComponent } from './app.component';

@NgModule({
  declarations: [
    AppComponent
  ],
  imports: [
    BrowserModule,
    MatMdcCheckboxModule,
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
