import 'dart:async';
import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';

@Component(
  selector: "percentage-input",
  template: """
    <div class="input-group">
      <input type="number" [(ngModel)]="displayValue" class="form-control" aria-label="...">
      <span class="input-group-addon" id="basic-addon2">%</span>
    </div>
  """,
  directives: const[formDirectives, CORE_DIRECTIVES]

)
class PercentageInputComponent{

  @Input() num value;
  final StreamController<num> _valueChange = new StreamController<num>();
  @Output()
  Stream<num> get valueChange => _valueChange.stream;

  num get displayValue => value != null ? value * 100 : null;

  void set displayValue(num displayValue) {
    value = displayValue != null ? displayValue / 100 : null;
    _valueChange.add(value);
  }
}
