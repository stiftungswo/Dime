part of entity_select;

@Component(
    selector: 'roundmode-select',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/select/roundmode_select.html',
    useShadowDom: false)
class RoundModeSelect implements ScopeAware {
  @NgTwoWay('model')
  set model(int roundMode) {
    if (roundMode != null) {
      this.selector = getModeName(roundMode);
      this._model = roundMode;
    }
  }

  int _model;

  get model => _model;

  @NgCallback('callback')
  Function callback;
  @NgOneWayOneTime('field')
  String field;
  String selector;
  Scope scope;
  dom.Element element;
  bool open = false;

  List<Map<String, dynamic>> modes = [
    {'name': 'Halbe Aufrunden', 'value': 1},
    {'name': 'Halbe Abrunden', 'value': 2},
    {'name': 'Halbe auf gerade runden', 'value': 3},
    {'name': 'Halbe auf ungerade runden', 'value': 4},
    {'name': 'Forciertes Abrunden', 'value': 5},
    {'name': 'Forciertes Aufrunden', 'value': 6},
    {'name': 'Halbe Schritte', 'value': 7},
    {'name': 'Halbe Schritte abgerundet', 'value': 8},
    {'name': 'Halbe Schritte aufgerundet', 'value': 9},
  ];

  getModeName(int value) {
    for (var mode in modes) {
      if (mode['value'] == value) {
        return mode['name'];
      }
    }
    return null;
  }

  RoundModeSelect(this.element);

  select(mode) {
    this.model = mode['value'];
    this.open = false;
    if (this.callback != null) {
      callback({"name": this.field});
    }
  }

  toggleSelectionBox() {
    if (this.open) {
      this.closeSelectionBox();
    } else {
      this.openSelectionBox();
    }
  }

  openSelectionBox() {
    if (!this.open) {
      this.selector = '';
      this.open = true;
    }
  }

  closeSelectionBox() {
    if (this.open) {
      this.selector = getModeName(this.model);
      this.open = false;
    }
  }
}
