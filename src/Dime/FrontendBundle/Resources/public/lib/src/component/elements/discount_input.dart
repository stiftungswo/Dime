import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';

import 'percentage_input.dart';

@Component(
  selector: "discount-input",
  template: """
    <div class="input-group">
      <percentage-input *ngIf="percentage" [(ngModel)]="displayValue" [showAddon]="false"></percentage-input>
      <input *ngIf="!percentage" type="number" [(ngModel)]="displayValue" class="form-control" aria-label="...">
      <div class="input-group-btn">
        <button type="button" class="btn" [class.btn-default]='!percentage' [class.btn-primary]="percentage" (click)='percentage = true'>%</button>
        <button type="button" class="btn" [class.btn-default]='percentage' [class.btn-primary]="!percentage" (click)='percentage = false'>CHF</button>
      </div>
    </div>
  """,
  directives: const [formDirectives, CORE_DIRECTIVES, PercentageInputComponent],
  providers: const[const Provider(NG_VALUE_ACCESSOR, useExisting: DiscountInputComponent, multi: true)],
)
class DiscountInputComponent implements ControlValueAccessor<double>{
  bool _percentage;

  ChangeFunction<double> _onValueChange;
  bool get percentage => _percentage;
  @Input()
  void set percentage(bool percentage) {
    _percentage = percentage;
    //FIXME(106): this triggers the dirty check of the including views too soon; this field is always saved, even without changes
    _percentageChange.add(percentage);
  }

  final StreamController<bool> _percentageChange = new StreamController<bool>();
  @Output()
  Stream<bool> get percentageChange => _percentageChange.stream;

  num value;

  num get displayValue {
    if (value == null) {
      return null;
    }

    return value;
  }

  void set displayValue(num displayValue) {
    value = displayValue;
    _onValueChange(value);
  }
  @override
  void registerOnChange(ChangeFunction<double> f) {
    _onValueChange = f;
  }

  @override
  void registerOnTouched(TouchFunction f) { }

  @override
  void writeValue(double val) {
    this.value = val;
  }
}
