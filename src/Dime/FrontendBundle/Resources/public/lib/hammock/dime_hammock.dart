library dime_hammock;

import 'package:angular/angular.dart';
import 'package:hammock/hammock.dart';
import 'package:DimeClient/model/Entity.dart';

HammockConfig createHammockConfig(Injector inj) {
  return new HammockConfig(inj)
    ..set(
      {
        "employees" : {
          "type" : Employee,
          "serializer" : (Employee ent) {
            return ent.toResource();
          },
          "deserializer" : (Resource r) {
            if (r.content is String)return new Employee();
            return new Employee.fromMap(r.content);
          }
        },
        "timeslices" : {
          "type" : Timeslice,
          "serializer" : (Timeslice ent) {
            return ent.toResource();
          },
          "deserializer" : (Resource r) {
            if (r.content is String)return new Timeslice();
            return new Timeslice.fromMap(r.content);
          }
        },
        "activities" : {
          "type" : Activity,
          "serializer" : (Activity ent) {
            return ent.toResource();
          },
          "deserializer" : (Resource r) {
            if (r.content is String)return new Activity();
            return new Activity.fromMap(r.content);
          }
        },
        "projects" : {
          "type" : Project,
          "serializer" : (Project ent) {
            return ent.toResource();
          },
          "deserializer" : (Resource r) {
            if (r.content is String)return new Project();
            return new Project.fromMap(r.content);
          }
        },
        "settings" : {
          "type" : Setting,
          "serializer" : (Setting ent) {
            return ent.toResource();
          },
          "deserializer" : (Resource r) {
            if (r.content is String)return new Setting();
            return new Setting.fromMap(r.content);
          }
        },
        "offers" : {
          "type" : Offer,
          "serializer" : (Offer ent) {
            return ent.toResource();
          },
          "deserializer" : (Resource r) {
            if (r.content is String)return new Offer();
            return new Offer.fromMap(r.content);
          }
        },
        "offerpositions" : {
          "type" : OfferPosition,
          "serializer" : (OfferPosition ent) {
            return ent.toResource();
          },
          "deserializer" : (Resource r) {
            if (r.content is String)return new OfferPosition();
            return new OfferPosition.fromMap(r.content);
          }
        },
        "offerdiscounts" : {
          "type" : OfferDiscount,
          "serializer" : (OfferDiscount ent) {
            return ent.toResource();
          },
          "deserializer" : (Resource r) {
            if (r.content is String)return new OfferDiscount();
            return new OfferDiscount.fromMap(r.content);
          }
        },
        "offerstatusucs" : {
          "type" : OfferStatusUC,
          "serializer" : (OfferStatusUC ent) {
            return ent.toResource();
          },
          "deserializer" : (Resource r) {
            if (r.content is String)return new OfferStatusUC();
            return new OfferStatusUC.fromMap(r.content);
          }
        },
        "standarddiscounts" : {
          "type" : StandardDiscount,
          "serializer" : (StandardDiscount ent) {
            return ent.toResource();
          },
          "deserializer" : (Resource r) {
            if (r.content is String)return new StandardDiscount();
            return new StandardDiscount.fromMap(r.content);
          }
        },
        "invoices" : {
          "type" : Invoice,
          "serializer" : (Invoice ent) {
            return ent.toResource();
          },
          "deserializer" : (Resource r) {
            if (r.content is String)return new Invoice();
            return new Invoice.fromMap(r.content);
          }
        },
        "invoiceitems" : {
          "type" : InvoiceItem,
          "serializer" : (InvoiceItem ent) {
            return ent.toResource();
          },
          "deserializer" : (Resource r) {
            if (r.content is String)return new InvoiceItem();
            return new InvoiceItem.fromMap(r.content);
          }
        },
        "invoicediscounts" : {
          "type" : InvoiceDiscount,
          "serializer" : (InvoiceDiscount ent) {
            return ent.toResource();
          },
          "deserializer" : (Resource r) {
            if (r.content is String)return new InvoiceDiscount();
            return new InvoiceDiscount.fromMap(r.content);
          }
        },
        "services" : {
          "type" : Service,
          "serializer" : (Service ent) {
            return ent.toResource();
          },
          "deserializer" : (Resource r) {
            if (r.content is String)return new Service();
            return new Service.fromMap(r.content);
          }
        },
        "rates" : {
          "type" : Rate,
          "serializer" : (Rate ent) {
            return ent.toResource();
          },
          "deserializer" : (Resource r) {
            if (r.content is String)return new Rate();
            return new Rate.fromMap(r.content);
          }
        },
        "rategroups" : {
          "type" : RateGroup,
          "serializer" : (RateGroup ent) {
            return ent.toResource();
          },
          "deserializer" : (Resource r) {
            if (r.content is String)return new RateGroup();
            return new RateGroup.fromMap(r.content);
          }
        },
        "rateunittypes" : {
          "type" : RateUnitType,
          "serializer" : (RateUnitType ent) {
            return ent.toResource();
          },
          "deserializer" : (Resource r) {
            if (r.content is String)return new RateUnitType();
            return new RateUnitType.fromMap(r.content);
          }
        },
        "customers" : {
          "type" : Customer,
          "serializer" : (Customer ent) {
            return ent.toResource();
          },
          "deserializer" : (Resource r) {
            if (r.content is String)return new Customer();
            return new Customer.fromMap(r.content);
          }
        },
        "periods" : {
          "type" : Period,
          "serializer" : (Period ent) {
            return ent.toResource();
          },
          "deserializer" : (Resource r) {
            if (r.content is String)return new Period();
            return new Period.fromMap(r.content);
          }
        },
        "holidays" : {
          "type" : Holiday,
          "serializer" : (Holiday ent) {
            return ent.toResource();
          },
          "deserializer" : (Resource r) {
            if (r.content is String)return new Holiday();
            return new Holiday.fromMap(r.content);
          }
        },
        "expensereports" : {
          "type" : ExpenseReport,
          "serializer" : (ExpenseReport ent) {
            return ent.toResource();
          },
          "deserializer" : (Resource r) {
            if (r.content is String) return new ExpenseReport();
            return new ExpenseReport.fromMap(r.content);
          }
        },
        "projectcategories" : {
          "type" : ProjectCategory,
          "serializer" : (ProjectCategory ent) {
            return ent.toResource();
          },
          "deserializer" : (Resource r) {
            if (r.content is String)return new ProjectCategory();
            return new ProjectCategory.fromMap(r.content);
          }
        }

      }
  )
    ..urlRewriter.baseUrl = '/api/v1';
}