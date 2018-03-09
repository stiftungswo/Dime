import 'dart:async';
import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';

@Component(
  selector: 'input-percentage',
  templateUrl: 'percent_input.html',
  directives: const [CORE_DIRECTIVES, formDirectives],
)
//TODO(98) remove this as it is replaced with percentage-input
class PercentageInputField {
  double _model;

  @Input('precision')
  int precision = 2;

  @Input('value')
  set model(double m) {
    _model = m;
    if (useSafeCalc == true) {
      text = _toPercentage(m);
    } else {
      text = (m * 100).truncate().toString() + '%';
    }
    _modelChange.add(_model);
  }

  double get model => _model;

  final StreamController<double> _modelChange = new StreamController<double>();
  @Output('valueChange')
  Stream<double> get modelChange => _modelChange.stream;

  @Input('safecalc')
  bool useSafeCalc = true;

  @Input('htmlclass')
  String htmlclass;

  String text = '';

  String _toPercentage(double val) {
    if (val != null) {
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
      return resString + '%';
    }
    return '';
  }

  double _toNumber(String percentage) {
    return (double.parse(percentage.replaceAll('%', '')) / 100);
  }

  onFocus() {
    text = text.replaceAll('%', '');
  }

  onChange() {
    model = _toNumber(text);
  }
}
