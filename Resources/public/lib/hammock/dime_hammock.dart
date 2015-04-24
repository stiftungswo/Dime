library dime_hammock;

import 'package:angular/angular.dart';
import 'package:hammock/hammock.dart';
import 'package:hammock_mapper/hammock_mapper.dart';
import 'package:DimeClient/model/dime_entity.dart';

HammockConfig createHammockConfig(Injector inj) {
  return new HammockConfig(inj)
    ..set(mappers()
  .resource('projects', Project)
  .resource('customers', Customer)
  .resource('activities', Activity)
  .resource('timeslices', Timeslice)
  .resource('services', Service)
  .resource('rates', Rate)
  .resource('rategroups', RateGroup)
  .resource('address', Address)
  .resource('phones', Phone)
  .resource('users', User)
  .resource('tags', Tag)
  .resource('settings', Setting)
  .resource('employees', Employee)
  .resource('workingperiods', WorkingPeriod)
  .resource('freeperiods', FreePeriod)
  .resource('offers', Offer)
  .resource('offerpositions', OfferPosition)
  .resource('offerdiscounts', OfferDiscount)
  .resource('offerstatusucs', OfferStatusUC)
  .resource('invoices', Invoice)
  .resource('invoiceitems', InvoiceItem)
  .resource('invoicediscounts', InvoiceDiscount)
  .resource('standarddiscounts', StandardDiscount)
  .resource('rateunittypes', RateUnitType)
  .mapper(DateTime, new DateTimeMapper())
  .createHammockConfig())
    ..urlRewriter.baseUrl = '/api/v1';
}