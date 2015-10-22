library percentage_input;

import 'package:angular/angular.dart';

@Component(
    selector: 'input-percentage',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/percent-input/percent_input.html',
    useShadowDom: false,
    map: const {
      'htmlclass': '=>!htmlclass',
      'precision': '=>!precision',
      'safecalc': '=>!useSafeCalc',
      'value': '<=>model'
    }
)
class PercentageInputField {

  double _model;

  int precision = 2;

  set model(double m) {
    _model = m;
    if (useSafeCalc == true) {
      text = _toPercentage(m);
    } else {
      text = (m * 100).truncate().toString() + '%';
    }
  }

  bool useSafeCalc = true;

  get model => _model;

  String htmlclass;

  String text = '';

  String _toPercentage(double val) {
    if (val != null) {
      int position = val.toString().indexOf('.');
      String str = val.toString().replaceAll('.', '');
      for (int i = 0;i < 2;i++) {
        if (str.startsWith('0')) {
          str = str.replaceFirst('0', '');
          str = str + '0';
        } else {
          str = str + '0';
        }
      }
      String resString = '';
      for (int i = 0;i < str.length;i++) {
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
    _model = _toNumber(text);
  }
}