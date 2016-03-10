part of entity_overview;

@Component(
    selector: 'offer-overview',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/overview/offer_overview.html',
    useShadowDom: false)
class OfferOverviewComponent extends EntityOverview {
  OfferOverviewComponent(DataCache store, this.context, Router router, SettingsManager manager, StatusService status, UserAuthProvider auth)
      : super(Offer, store, 'offer_edit', manager, status, auth: auth, router: router);

  String sortType = "name";
  UserContext context;

  cEnt({Offer entity}) {
    if (entity != null) {
      return new Offer.clone(entity);
    }
    Offer newOffer = new Offer();
    newOffer.accountant = this.context.employee;
    newOffer.addFieldtoUpdate('accountant');
    return newOffer;
  }

  cEntPos(OfferPosition entity) {
    if (entity != null) {
      return new OfferPosition.clone(entity);
    }
    return new OfferPosition();
  }

  duplicateEntity() async {
    var ent = this.selectedEntity;
    if (ent != null) {
      this.statusservice.setStatusToLoading();

      var duplicateOffer = (await this.store.one(Offer, ent.id));
      var newOffer = this.cEnt();

      newOffer = duplicateOffer;
      newOffer.id = null;

      newOffer.addFieldtoUpdate('name');
      newOffer.addFieldtoUpdate('shortDescription');
      newOffer.addFieldtoUpdate('description');
      newOffer.addFieldtoUpdate('status');
      newOffer.addFieldtoUpdate('customer');
      newOffer.addFieldtoUpdate('address');
      newOffer.addFieldtoUpdate('accountant');
      newOffer.addFieldtoUpdate('rateGroup');
      newOffer.addFieldtoUpdate('validTo');

      try {
        var resultOffer = await this.store.create(newOffer);

        // create offerpositions with new offer
        for (OfferPosition offerPosition in newOffer.offerPositions) {
          var newOfferPosition = this.cEntPos(offerPosition);
          newOfferPosition.offer = resultOffer;

          var resultOfferPosition = await this.store.create(newOfferPosition);
        }

        if (needsmanualAdd) {
          this.entities.add(resultOffer);
        }

        resultOffer.cloneDescendants(ent);

        for (var entity in result.descendantsToUpdate) {
          await this.store.create(entity);
        }
        this.statusservice.setStatusToSuccess();
        this.rootScope.emit(this.type.toString() + 'Duplicated');
      } catch (e) {
        print("Unable to duplicate entity ${this.type.toString()}::${newOffer.id} because ${e}");
        this.statusservice.setStatusToError(e);
      }
    }
  }
}
