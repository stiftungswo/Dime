part of entity_overview;

@Component(
    selector: 'standarddiscount-overview',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/overview/standarddiscount_overview.html',
    useShadowDom: false,
    map: const {'discounts': '<=>entities'})
class StandardDiscountOverviewComponent extends EntityOverview {
  StandardDiscountOverviewComponent(SettingsManager manager, StatusService status) : super(StandardDiscount, null, '', manager, status);

  cEnt({StandardDiscount entity}) {
    if (entity != null) {
      return new StandardDiscount.clone(entity);
    }
    return new StandardDiscount();
  }

  StandardDiscount newDiscount;

  @NgCallback('callback')
  Function callback;

  reload({Map<String, dynamic> params, bool evict: false});

  attach();

  createEntity({var newEnt, Map<String, dynamic> params: const {}}) {
    if (this.newDiscount != null && !this.entities.contains(this.newDiscount)) {
      this.entities.add(this.newDiscount);
      if (this.callback != null) {
        callback({"name": 'standardDiscounts'});
      }
    }
  }

  deleteEntity([int entId]) {
    if (window.confirm("Wirklich löschen?")) {
      entId = this.selectedEntId;
      this.entities.removeWhere((enty) => enty.id == entId);
      this.newDiscount = null;
      if (this.callback != null) {
        callback({"name": 'standardDiscounts'});
      }
    }
  }

  void saveAllEntities([ScopeEvent e]) {}
}
