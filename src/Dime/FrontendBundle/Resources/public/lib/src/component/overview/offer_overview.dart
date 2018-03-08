import 'dart:async';
import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';
import 'package:angular_router/src/router.dart';

import '../../component/overview/entity_overview.dart';
import '../../model/Entity.dart';
import '../../pipes/dime_pipes.dart';
import '../../service/data_cache.dart';
import '../../service/entity_events_service.dart';
import '../../service/setting_manager.dart';
import '../../service/status.dart';
import '../../service/user_auth.dart';
import '../../service/user_context.dart';
import '../elements/dime_directives.dart';

@Component(
  selector: 'offer-overview',
  templateUrl: 'offer_overview.html',
  directives: const [CORE_DIRECTIVES, formDirectives, dimeDirectives],
  pipes: const [dimePipes],
)
class OfferOverviewComponent extends EntityOverview<Offer> {
  OfferOverviewComponent(DataCache store, this.context, Router router, SettingsManager manager, StatusService status, UserAuthProvider auth,
      EntityEventsService entityEventsService)
      : super(Offer, store, 'OfferEdit', manager, status, entityEventsService, auth: auth, router: router) {
    sortType = "id";
    sortReverse = true;
  }

  UserContext context;

  @override
  Offer cEnt({Offer entity}) {
    if (entity != null) {
      return new Offer.clone(entity);
    }
    Offer newOffer = new Offer();
    newOffer.accountant = this.context.employee;
    newOffer.addFieldtoUpdate('accountant');
    return newOffer;
  }

  OfferPosition cEntPos(OfferPosition entity) {
    if (entity != null) {
      return new OfferPosition.clone(entity);
    }
    return new OfferPosition();
  }

  @override
  Future duplicateEntity() async {
    print("duplicate usdf offer now");
    var ent = this.selectedEntity;

    if (ent != null) {
      this.statusservice.setStatusToLoading();

      Offer duplicateOffer = (await this.store.one(Offer, ent.id)) as Offer;

      for (OfferPosition _ in duplicateOffer.offerPositions) {
        print("offer position item now");
      }

      Offer newOffer = this.cEnt();

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
        Offer resultOffer = await this.store.create(newOffer);

        // create offerpositions with new offer
        for (OfferPosition offerPosition in newOffer.offerPositions) {
          print("duplicate position now");
          OfferPosition newOfferPosition = this.cEntPos(offerPosition);
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
