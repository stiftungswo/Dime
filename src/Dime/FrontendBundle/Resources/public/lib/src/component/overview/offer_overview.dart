part of entity_overview;

@Component(
  selector: 'offer-overview',
  templateUrl: 'offer_overview.html',
  directives: const [CORE_DIRECTIVES, formDirectives, dimeDirectives],
  pipes: const [FilterPipe, OrderByPipe, LimitToPipe],
)
class OfferOverviewComponent extends EntityOverview {
  OfferOverviewComponent(DataCache store, this.context, Router router, SettingsManager manager, StatusService status, UserAuthProvider auth,
      EntityEventsService entityEventsService)
      : super(Offer, store, 'OfferEdit', manager, status, entityEventsService, auth: auth, router: router) {
    sortType = "id";
    sortReverse = true;
  }

  UserContext context;

  cEnt({Entity entity}) {
    if (entity != null) {
      if (entity is Offer) {
        return new Offer.clone(entity);
      } else {
        throw new Exception("Invalid Type; Offer expected!");
      }
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
    print("duplicate usdf offer now");
    var ent = this.selectedEntity;

    if (ent != null) {
      this.statusservice.setStatusToLoading();

      var duplicateOffer = (await this.store.one(Offer, ent.id));

      for (OfferPosition _ in duplicateOffer.offerPositions) {
        print("offer position item now");
      }

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
          print("duplicate position now");
          var newOfferPosition = this.cEntPos(offerPosition);
          newOfferPosition.offer = resultOffer;

          await this.store.create(newOfferPosition);
        }

        if (needsmanualAdd) {
          this.entities.add(resultOffer);
        }

        resultOffer.cloneDescendants(ent);

        for (var entity in resultOffer.descendantsToUpdate) {
          await this.store.create(entity);
        }
        this.statusservice.setStatusToSuccess();
        // this.rootScope.emit(this.type.toString() + 'Duplicated');
      } catch (e, stack) {
        print("Unable to duplicate entity ${this.type.toString()}::${newOffer.id} because ${e}");
        this.statusservice.setStatusToError(e, stack);
      }
    }
  }
}
