import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';

import 'percentage_input_component.dart';

@Component(
  selector: "discount-input",
  template: """
    <div class="input-group">
      <!-- precision is 0 because the backend rounds -->
      <percentage-input *ngIf="percentage" [(ngModel)]="displayValue" [showAddon]="false" [precision]='0'></percentage-input>
      <input *ngIf="!percentage" type="number" [(ngModel)]="displayValue" class="form-control" aria-label="...">
      <div class="input-group-btn">
        <button type="button" class="btn" [class.btn-default]='!percentage' [class.btn-primary]="percentage" (click)='percentage = true'>%</button>
        <button type="button" class="btn" [class.btn-default]='percentage' [class.btn-primary]="!percentage" (click)='percentage = false'>CHF</button>
      </div>
    </div>
  """,
  directives: const [formDirectives, coreDirectives, PercentageInputComponent],
  providers: const [const ExistingProvider.forToken(ngValueAccessor, DiscountInputComponent, multi: true)],
)
class DiscountInputComponent implements ControlValueAccessor<num> {
  ChangeFunction<num> _onValueChange;

  /// DiscountInput is weird because it has two values instead of one: `value`(num) and `percentage`(bool). `value` is bound via the
  /// [ControlValueAccessor] interface and `[ngFormControl]` as usual, but since we cannot implement [ControlValueAccessor] twice,
  /// we pass the Control for [percentage] explicitly and manipulate it manually.
  @Input()
  Control percentageControl;

  bool get percentage => (percentageControl?.value ?? true) as bool;
  set percentage(bool p) {
    percentageControl.updateValue(p, emitEvent: true);
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
  void registerOnChange(ChangeFunction<num> f) {
    _onValueChange = f;
  }

  @override
  void registerOnTouched(TouchFunction f) {}

  @override
  void writeValue(num val) {
    this.value = val;
  }

  @override
  void onDisabledChanged(bool isDisabled) {
    // TODO: implement onDisabledChanged
  }
}
