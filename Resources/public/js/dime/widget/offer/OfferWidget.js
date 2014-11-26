define([
    'dijit/_WidgetsInTemplateMixin',
    'dijit/_TemplatedMixin',
    'dime/widget/_Base',
    'dojo/_base/declare',
    'dojo/text!dime/widget/offer/templates/OfferWidget.html',
    'dime/widget/offer/OfferPositionWidget',
    'dime/widget/timetrack/StandardDiscountWidget',
    'dime/widget/offer/OfferDiscountWidget',
    'dojo/when',
    'dojo/dom-prop',
    'dime/widget/project/ProjectDetailWidget',
    'dojo/request',
    'dime/widget/swocommons/AddressWidget',
    'dijit/form/TextBox',
    'dijit/form/NumberTextBox',
    'dijit/form/DateTextBox',
    'dijit/form/Textarea',
    'dijit/Dialog',
    "dijit/form/FilteringSelect",
    'dijit/form/Button',
    'xstyle!dime/widget/offer/css/OfferWidget.css'
], function ( WidgetsInTemplateMixin, TemplatedMixin,  _Base, declare,  template,
              OfferPositionWidget, StandardDiscountWidget, OfferDiscountWidget,  when, domProp, ProjectDetailWidget, request) {
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
            this.addressNode.set('parentWidget', this);
            this.createprojectNode.set('parentWidget', this);

            //OfferPositions
            this.addOfferPositionNode.set('parentWidget', this);

            //Standard Discounts
            this.addStandardDiscountSelectNode.set('parentWidget', this);
            this.addStandardDiscountSelectNode.set('store', window.storeManager.get('standarddiscounts', true));
            this.addStandardDiscountNode.set('parentWidget', this);

            //OfferDiscounts
            this.addOfferDiscountNode.set('parentWidget', this);

            //Calculation
            this.subtotalNode.set('parentWidget', this);
            this.subtotalNode.set('disabled', true);
            this.totalVATNode.set('parentWidget', this);
            this.totalVATNode.set('disabled', true);
            this.totalDiscountsNode.set('parentWidget', this);
            this.totalDiscountsNode.set('disabled', true);
            this.totalNode.set('parentWidget', this);
            this.totalNode.set('disabled', true);

            this.fixedPriceNode.set('parentWidget', this);

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
            this.addressNode.watch('entity', this._watchercallback);


            this.fixedPriceNode.watch('value', this._watchercallback);

            //Offer Positions
            this.addOfferPositionNode.on('click', function(){
                var parentWidget = this.parentWidget;
                var offerPositionsContainer = this.parentWidget.offerPositionsContainer;

                var offerPositionsStore = window.storeManager.get('offerpositions', false, true);
                var newOfferPosition = {order:0, offer:this.parentWidget.entity.id, service:1, discountable:true, vat:0.08};

                var offerPositionResult = offerPositionsStore.put(newOfferPosition);

                when(offerPositionResult, function(data){
                    window.widgetManager.add(data, 'offerpositions', OfferPositionWidget, parentWidget, offerPositionsContainer);
                });
            });

            //StandardDiscount
            this.addStandardDiscountNode.on('click', function(){
                if(!this.parentWidget.addStandardDiscountSelectNode.item)
                {
                    alert("No discount selected");
                    return;
                }

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
                            window.widgetManager.add(discount,'standarddiscounts',StandardDiscountWidget, parentWidget, discountsContainer).set("disabled", true);
                        }
                    });
                });
            });


            //OfferDiscount

            this.addOfferDiscountNode.on('click', function(){
                var parentWidget = this.parentWidget;
                var offerDiscountsContainer = this.parentWidget.offerDiscountsContainer;
                var offerDiscountStore = window.storeManager.get('offerdiscounts', false, true);
                var newOfferDiscount = {name:"New...", percentage:0, minus:1, value:0, offer:this.parentWidget.entity.id};

                offerDiscountStore.put(newOfferDiscount).then(function(discount){
                    window.widgetManager.add(discount,'offerdiscounts',OfferDiscountWidget, parentWidget, offerDiscountsContainer)
                });
            });

            //Create Project from Offer
            this.createprojectNode.on('click', function(){
                var OfferId = this.parentWidget.entity.id;
                request.get('/api/v1/projects/offer/'+OfferId, {handleAs: 'json'}).then(function(data){
                    window.widgetManager.addTab(data, 'projects', ProjectDetailWidget, 'contentTabs', 'Projekt ('+data.id+')', true);
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
            this.customerNode.set('value', entity.customer ? entity.customer.id : null);
            this.statusNode.set('value', entity.status ? entity.status.id : null);
            this.accountantNode.set('value', entity.accountant ? entity.accountant.id : null);
            this.validToNode.set('value', entity.validTo ? entity.validTo.split(" ")[0] : null); //Todo separate time from timestamp and only pass date
            this.rateGroupNode.set('value', entity.rateGroup ? entity.rateGroup.id : null);
            this.shortDescriptionNode.set('value', entity.shortDescription);
            this.descriptionNode.set('value', entity.description);
            this.addressNode._updateValues(entity.customer.address || null);
            //Calculation

            this.subtotalNode.set('value', entity.subtotal);
            this.totalVATNode.set('value', entity.totalVAT);
            this.totalDiscountsNode.set('value', entity.totalDiscounts);
            this.totalNode.set('value', entity.total);

            this.fixedPriceNode.set('value', entity.fixedPrice);
            domProp.set(this.printNode, 'href', '/api/v1/offers/'+entity.id+'/print')
        },

        _watchercallback: function(property, oldvalue, newvalue){
            if(oldvalue == "") return;
            //used because this points to caller not to THIS Widget. Above all elements were populated with parentwidget (THIS).
            var entity = this.parentWidget.entity;
            var store = this.parentWidget.store;
            var result;
            switch(this.dojoAttachPoint) {
                case "nameNode":
                    result = store.put({name: newvalue}, {id: entity.id} );
                    break;
                case "customerNode":
                    result = store.put({customer: newvalue}, {id: entity.id});
                    break;
                case "statusNode":
                    result = store.put({status: newvalue}, {id: entity.id});
                    break;
                case "accountantNode":
                    result = store.put({accountant: newvalue}, {id: entity.id});
                    break;
                case "validToNode":
                    result = store.put({validTo: newvalue}, {id: entity.id});
                    break;
                case "rateGroupNode":
                    result = store.put({rateGroup: newvalue}, {id: entity.id});
                    break;
                case "shortDescriptionNode":
                    result = store.put({shortDescription: newvalue}, {id: entity.id});
                    break;
                case "descriptionNode":
                    result = store.put({description: newvalue}, {id: entity.id});
                    break;
                case "fixedPriceNode":
                    result = store.put({fixedPrice: newvalue}, {id: entity.id});
                    break;
                case "addressNode":
                    if(newvalue == entity.address) return;
                    result = store.put({address: newvalue}, {id: entity.id} );
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
