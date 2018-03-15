import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';

import 'percentage_input.dart';

@Component(
  selector: "discount-input",
  template: """
    <div class="input-group">
      <percentage-input *ngIf="percentage" [(value)]="displayValue" [showAddon]="false"></percentage-input>
      <input *ngIf="!percentage" type="number" [(ngModel)]="displayValue" class="form-control" aria-label="...">
      <div class="input-group-btn">
        <button type="button" class="btn" [class.btn-default]='!percentage' [class.btn-primary]="percentage" (click)='percentage = true'>%</button>
        <button type="button" class="btn" [class.btn-default]='percentage' [class.btn-primary]="!percentage" (click)='percentage = false'>CHF</button>
      </div>
    </div>
  """,
  directives: const [formDirectives, CORE_DIRECTIVES, PercentageInputComponent],
)
class DiscountInputComponent {
  bool _percentage;
  bool get percentage => _percentage;
  @Input()
  void set percentage(bool percentage) {
    _percentage = percentage;
    _percentageChange.add(percentage);
  }

  final StreamController<bool> _percentageChange = new StreamController<bool>();
  @Output()
  Stream<bool> get percentageChange => _percentageChange.stream;

  @Input()
  num value;
  final StreamController<num> _valueChange = new StreamController<num>();
  @Output()
  Stream<num> get valueChange => _valueChange.stream;

  num get displayValue {
    if (value == null) {
      return null;
    }

    return value;
  }

  void set displayValue(num displayValue) {
    value = displayValue;
    _valueChange.add(value);
  }
}
