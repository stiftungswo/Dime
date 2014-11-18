define([
    'dijit/_WidgetsInTemplateMixin',
    'dijit/_TemplatedMixin',
    'dime/widget/_Base',
    'dojo/_base/declare',
    'dojo/text!dime/widget/offer/templates/OfferWidget.html',
    'dime/widget/offer/OfferPositionWidget',
    'dijit/registry',
    'dijit/form/TextBox',
    'dijit/form/DateTextBox',
    'dijit/form/Textarea',
    'dijit/Dialog',
    "dijit/form/FilteringSelect",
    'dijit/form/Button',
    'dime/widget/timetrack/StandardDiscountWidget',
    'dime/widget/offer/OfferDiscountWidget',
    'dojo/when',
    'xstyle!dime/widget/offer/css/OfferWidget.css'
], function ( WidgetsInTemplateMixin, TemplatedMixin,  _Base, declare,  template,
              OfferPositionWidget, registry, Textbox, DateTextBox, Textarea, Dialog,  FilteringSelect, Button, StandardDiscountWidget, OfferDiscountWidget,  when) {
    return declare("dime.widget.offer.OfferWidget", [_Base, TemplatedMixin, WidgetsInTemplateMixin], {

        templateString: template,
        baseClass: "offerWidget",
        store: window.storeManager.get('offers', false, true),
        dialogprops: {},


        _setupChildren: function(){

            //Offer
            this.nameNode.set('parentWidget', this);
            this.customerNode.set('parentWidget', this);
            this.customerNode.set('store', window.storeManager.get('customers', true));
            this.statusNode.set('searchAttr','name');
            this.statusNode.set('parentWidget', this);
            this.statusNode.set('store', window.storeManager.get('offerstatusucs', true));
            this.statusNode.set('searchAttr','text');
            this.accountantNode.set('parentWidget', this);
            this.accountantNode.set('store', window.storeManager.get('users', true));
            this.accountantNode.set('searchAttr','lastname');
            this.validToNode.set('parentWidget', this);
            this.rateGroupNode.set('parentWidget', this);
            this.rateGroupNode.set('store', window.storeManager.get('rategroups', true));
            this.rateGroupNode.set('searchAttr','name');
            this.shortDescriptionNode.set('parentWidget', this);
            this.descriptionNode.set('parentWidget', this);
            //TODO urfr refactor concept of addresslines after till added customer address in model
            this.recepientAddressLine1Node.set('parentWidget', this);
            this.recepientAddressLine2Node.set('parentWidget', this);
            this.recepientAddressLine3Node.set('parentWidget', this);
            this.recepientAddressLine4Node.set('parentWidget', this);
            this.recepientAddressLine5Node.set('parentWidget', this);

            //OfferPositions
            this.addOfferPositionNode.set('parentWidget', this);

            //Standard Discounts
            this.addStandardDiscountSelectNode.set('parentWidget', this);
            this.addStandardDiscountSelectNode.set('store', window.storeManager.get('standarddiscounts', true))
            this.addStandardDiscountNode.set('parentWidget', this);

            //OfferDiscounts
            this.addOfferDiscountNode.set('parentWidget', this);

        },

        _addcallbacks: function(){

            //Offer
            this.nameNode.watch('value', this._watchercallback);
            this.customerNode.watch('value', this._watchercallback);
            this.statusNode.watch('value', this._watchercallback);
            this.accountantNode.watch('value', this._watchercallback);
            this.validToNode.watch('value', this._watchercallback);
            this.rateGroupNode.watch('value', this._watchercallback);
            this.shortDescriptionNode.watch('value', this._watchercallback);
            this.descriptionNode.watch('value', this._watchercallback);
            //TODO urfr refactor concept of addresslines after till added customer address in model
            this.recepientAddressLine1Node.watch('value', this._watchercallback);
            this.recepientAddressLine2Node.watch('value', this._watchercallback);
            this.recepientAddressLine3Node.watch('value', this._watchercallback);
            this.recepientAddressLine4Node.watch('value', this._watchercallback);
            this.recepientAddressLine5Node.watch('value', this._watchercallback);


            var parentWidget = this.parentWidget;

            //Offer Positions
            this.addOfferPositionNode.on('click', function(){
                var offerPositionsContainer = this.parentWidget.offerPositionsContainer;

                var offerPositionsStore = window.storeManager.get('offerpositions', false, true)
                var newOfferPosition = {order:0, offer:this.parentWidget.entity.id, service:1, discountable:true, vat:8};

                offerPositionsStore.put(newOfferPosition).then(function(data){
                    window.widgetManager.add(data, 'offerpositions', OfferPositionWidget, parentWidget, offerPositionsContainer);
                });
            });

            //StandardDiscount
            this.addStandardDiscountNode.on('click', function(){
                var standardDiscounts = [];
                this.parentWidget.entity.standardDiscounts.forEach(function(discount){
                    standardDiscounts.push(discount.id);
                });

                var newDiscountId = this.parentWidget.addStandardDiscountSelectNode.item.id;
                standardDiscounts.push(newDiscountId);

                var parentWidget = this.parentWidget;
                var discountsContainer = this.parentWidget.discountsContainer;

                //put requires to update the widget, every time...
                var result = this.parentWidget.store.put({ standardDiscounts:standardDiscounts}, {id: this.parentWidget.entity.id});

                when(result,function(offer){
                    //...update hapeens here!
                    window.widgetManager.update(offer, 'offers');
                    offer.standardDiscounts.forEach(function(discount){
                        if(discount.id == newDiscountId ){
                            var widget = window.widgetManager.add(discount,'standarddiscounts',StandardDiscountWidget, parentWidget, discountsContainer).set("disabled", true);
                        }
                    });
                });
            });

            //OfferDiscount

            this.addOfferDiscountNode.on('click', function(){
                var parentWidget = this.parentWidget;
                var offerDiscountsContainer = this.parentWidget.offerDiscountsContainer;
                var offerDiscountStore = window.storeManager.get('offerdiscounts', false, true)
                var newOfferDiscount = {name:"New...", percentage:false, minus:true, value:0, offer:this.parentWidget.entity.id};

                offerDiscountStore.put(newOfferDiscount).then(function(discount){
                    window.widgetManager.add(discount,'offerdiscounts',OfferDiscountWidget, parentWidget, offerDiscountsContainer)
                });
            });
        },

        _fillValues: function(){

            //Offer Positions
            var parentWidget = this, offerPositionsContainer = this.offerPositionsContainer, discountsContainer = this.discountsContainer;
            this.inherited(arguments);
            var results = window.storeManager.get('offerpositions', true).query({offer: this.entity.id});
            results.forEach(function(entity){
                window.widgetManager.add(entity, 'offerpositions', OfferPositionWidget, parentWidget, offerPositionsContainer);
            });

            //Standard Discounts
            var standardDiscounts = this.entity.standardDiscounts;
            if(standardDiscounts){
                this.entity.standardDiscounts.forEach(function(entity){
                    var widget = window.widgetManager.add(entity,'standarddiscounts',StandardDiscountWidget, parentWidget, discountsContainer);
                    widget.set('disabled', true);
                    widget.set('offerId', parentWidget.entity.id);
                });
            }

            //Offer Discounts
            var offerDiscounts = this.entity.offerDiscounts;
            var offerDiscountsContainer = this.offerDiscountsContainer;
            if(offerDiscounts){
                this.entity.offerDiscounts.forEach(function(discount){
                    window.widgetManager.add(discount,'offerdiscounts',OfferDiscountWidget, parentWidget, offerDiscountsContainer);
                });
            }


        },

        _updateValues: function(entity){
            this.inherited(arguments);
            this.nameNode.set('value', entity.name);
            this.customerNode.set('value', entity.customer ? entity.customer.name : null);
            this.statusNode.set('value', entity.status ? entity.status.id : null);
            this.accountantNode.set('value', entity.accountant ? entity.accountant.id : null);
            this.validToNode.set('value', entity.validTo ? entity.validTo.split(" ")[0] : null); //separate time from timestamp and only pass date
            this.rateGroupNode.set('value', entity.rateGroup ? entity.rateGroup.id : null);
            this.shortDescriptionNode.set('value', entity.shortDescription);
            this.descriptionNode.set('value', entity.description);
            //TODO urfr refactor concept of addresslines after till added customer address in model
            this.recepientAddressLine1Node.set('value', entity.recepientAddressLine1);
            this.recepientAddressLine2Node.set('value', entity.recepientAddressLine2);
            this.recepientAddressLine3Node.set('value', entity.recepientAddressLine3);
            this.recepientAddressLine4Node.set('value', entity.recepientAddressLine4);
            this.recepientAddressLine5Node.set('value', entity.recepientAddressLine5);
        },

        _watchercallback: function(property, oldvalue, newvalue){
            if(oldvalue == "") return;
            //used because this points to caller not to THIS Widget. Above all elements were populated with parentwidget (THIS).
            var offerId = this.parentWidget.entity.id;
            var offerStore = this.parentWidget.store;
            var result;
            switch(this.dojoAttachPoint) {
                case "nameNode":
                    offerStore.put({name: newvalue}, {id: offerId} );
                    break;
                case "customerNode":
                    offerStore.put({customer: newvalue}, {id: offerId});
                    break;
                case "statusNode":
                    offerStore.put({status: newvalue}, {id: offerId});
                    break;
                case "accountantNode":
                    offerStore.put({accountant: newvalue}, {id: offerId});
                    break;
                case "validToNode":
                    offerStore.put({validTo: newvalue}, {id: offerId});
                    break;
                case "rateGroupNode":
                    result = offerStore.put({rateGroup: newvalue}, {id: offerId});
                    break;
                case "shortDescriptionNode":
                    offerStore.put({shortDescription: newvalue}, {id: offerId});
                    break;
                case "descriptionNode":
                    offerStore.put({description: newvalue}, {id: offerId});
                    break;
                case "recepientAddressLine1Node":
                    offerStore.put({recepientAddressLine1: newvalue}, {id: offerId});
                    break;
                case "recepientAddressLine2Node":
                    offerStore.put({recepientAddressLine2: newvalue}, {id: offerId});
                    break;
                case "recepientAddressLine3Node":
                    offerStore.put({recepientAddressLine3: newvalue}, {id: offerId});
                    break;
                case "recepientAddressLine4Node":
                    offerStore.put({recepientAddressLine4: newvalue}, {id: offerId});
                    break;
                case "recepientAddressLine5Node":
                    offerStore.put({recepientAddressLine5: newvalue}, {id: offerId});
                    break;
                default:
                    break;
            }
            result.then(function(data){
                window.widgetManager.update(data, 'offers');
                for(var i=0; i<data.offerPositions.length; i++) {
                    window.widgetManager.update(data.offerPositions[i],'offerpositions');
                }
            });
        }

    });
});
