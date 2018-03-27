import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';
import 'package:angular_router/src/router.dart';

import '../../model/entity_export.dart';
import '../../pipe/dime_pipes.dart';
import '../../service/caching_object_store_service.dart';
import '../../service/entity_events_service.dart';
import '../../service/settings_service.dart';
import '../../service/status_service.dart';
import '../../service/user_auth_service.dart';
import '../../service/user_context_service.dart';
import '../../util/page_title.dart' as page_title;
import '../common/dime_directives.dart';
import 'entity_overview.dart';

@Component(
  selector: 'offer-overview',
  templateUrl: 'offer_overview_component.html',
  directives: const [CORE_DIRECTIVES, formDirectives, dimeDirectives],
  pipes: const [dimePipes],
)
class OfferOverviewComponent extends EntityOverview<Offer> implements OnActivate {
  OfferOverviewComponent(CachingObjectStoreService store, this.context, Router router, SettingsService manager, StatusService status,
      UserAuthService auth, EntityEventsService entityEventsService)
      : super(Offer, store, 'OfferEdit', manager, status, entityEventsService, auth: auth, router: router) {
    sortType = "id";
    sortReverse = true;
  }

  UserContextService context;

  @override
  routerOnActivate(ComponentInstruction nextInstruction, ComponentInstruction prevInstruction) {
    page_title.setPageTitle('Offerten');
  }

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

      Offer duplicateOffer = await this.store.one(Offer, ent.id);

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
      } catch (e, stack) {
        print("Unable to duplicate entity ${this.type.toString()}::${newOffer.id} because ${e}");
        this.statusservice.setStatusToError(e, stack);
      }
    }
  }
}
