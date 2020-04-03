import {Component} from '@angular/core';
import {FormBuilder, Validators} from '@angular/forms';

@Component({
  selector: 'app-root',
  template: `
    <h1>This app demonstrates components that are used in building a form</h1>
    <form [formGroup]="group" #form="ngForm" (ngSubmit)="onSubmit()" class="mat-typography">
      <fieldset>
        <mat-form-field>
          <mat-label>Name</mat-label>
          <input matInput formControlName="name">
        </mat-form-field>
      </fieldset>
      <fieldset>
        <mat-checkbox formControlName="confirm1">
          Are you sure you want to submit?
        </mat-checkbox>
      </fieldset>
      <fieldset>
        <label for="confirm2">Are you really sure?</label>
        <mat-radio-group id="confirm2" formControlName="confirm2">
          <mat-radio-button [value]="false">No</mat-radio-button>
          <mat-radio-button [value]="true">Yes</mat-radio-button>
        </mat-radio-group>
      </fieldset>
      <fieldset>
        <mat-slide-toggle formControlName="confirm3">
          But are you really <b><i>really</i></b> sure?
        </mat-slide-toggle>
      </fieldset>
      <fieldset>
        <button mat-button [disabled]="!form.valid">Submit</button>
      </fieldset>
    </form>
  `,
  styles: [`
    form {
      width: 400px;
      border: 1px solid #333;
      border-radius: 3px;
    }

    fieldset {
      margin: 0;
      padding: 16px;
      border: none;
    }

    fieldset:not(:last-of-type) {
      border-bottom: 1px solid #ddd;
    }

    mat-radio-group, mat-radio-button {
      padding: 0 8px;
    }
  `]
})
export class AppComponent {
  group = this.builder.group({
    name: ['', Validators.required],
    confirm1: [false, Validators.requiredTrue],
    confirm2: [false, Validators.requiredTrue],
    confirm3: [false, Validators.requiredTrue],
  });

  constructor(private builder: FormBuilder) {}

  onSubmit() {
    alert(`Submitted: ${JSON.stringify(this.group.value)}`);
  }
}
