import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';

@Component(
  selector: "percentage-input",
  template: """
    <div class="input-group" *ngIf="showAddon">
      <input type="text" [(ngModel)]="text" (change)="onChange()" class="form-control" aria-label="...">
      <span class="input-group-addon">%</span>
    </div>
    <input *ngIf="!showAddon" type="text" [(ngModel)]="text" (change)="onChange()" class="form-control" aria-label="...">
  """,
  directives: const [formDirectives, CORE_DIRECTIVES],
  providers: const [const Provider(NG_VALUE_ACCESSOR, useExisting: PercentageInputComponent, multi: true)],
)
class PercentageInputComponent implements ControlValueAccessor<double> {
  String text = '';

  @Input()
  int precision = 2;

  ChangeFunction<double> _onchange;

  double _model;

  set model(double m) {
    _model = m;
    text = _toPercentage(m);
  }

  double get model => _model;

  @Input('showAddon')
  bool showAddon = true;

  onChange() {
    model = _toNumber(text);
    _onchange(model);
  }

  String _toPercentage(double val) {
    if (val == null) {
      return '';
    }
    return (100 * val).toStringAsFixed(precision);
  }

  double _toNumber(String percentage) {
    if (percentage == null || percentage == '') {
      return null;
    }
    return (double.parse(percentage) / 100);
  }

  @override
  void registerOnChange(ChangeFunction<double> f) {
    _onchange = f;
  }

  @override
  void registerOnTouched(TouchFunction f) {}

  @override
  void writeValue(double val) {
    model = val;
  }
}
