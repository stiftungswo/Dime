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
    int position = val.toString().indexOf('.');
    String str = val.toString().replaceAll('.', '');
    for (int i = 0; i < 2; i++) {
      if (str.startsWith('0')) {
        str = str.replaceFirst('0', '');
        str = str + '0';
      } else {
        str = str + '0';
      }
    }
    String resString = '';
    for (int i = 0; i < str.length; i++) {
      if (i == position) {
        resString = resString + '.';
      }
      resString = resString + str.substring(i, i + 1);
    }
    return resString;
  }

  double _toNumber(String percentage) {
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
