import 'dart:async';
import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';

@Component(
  selector: "discount-input",
  template: """
    <div class="input-group">
      <input type="number" [(ngModel)]="displayValue" class="form-control" aria-label="...">
      <div class="input-group-btn">
        <button type="button" class="btn" [class.btn-default]='!percentage' [class.btn-primary]="percentage" (click)='percentage = true'>%</button>
        <button type="button" class="btn" [class.btn-default]='percentage' [class.btn-primary]="!percentage" (click)='percentage = false'>CHF</button>
      </div>
    </div>
  """,
  directives: const[formDirectives, CORE_DIRECTIVES]

)
class DiscountInputComponent{

  bool _percentage;
  bool get percentage => _percentage;
  @Input() void set percentage(bool percentage) {
    _percentage = percentage;
    _percentageChange.add(percentage);
  }
  final StreamController<bool> _percentageChange = new StreamController<bool>();
  @Output()
  Stream<bool> get percentageChange => _percentageChange.stream;

  @Input() num value;
  final StreamController<num> _valueChange = new StreamController<num>();
  @Output()
  Stream<num> get valueChange => _valueChange.stream;

  num get displayValue{
    if(value == null){
      return null;
    }
    if(percentage){
      return value * 100;
    } else {
      return value;
    }
  }

  void set displayValue(num displayValue) {
    if(percentage){
      value = displayValue / 100;
    } else {
      value = displayValue;
    }
    _valueChange.add(value);
  }
}
