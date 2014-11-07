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
], function ( WidgetsInTemplateMixin, TemplatedMixin,  _Base, declare,  template,
              OfferPositionWidget, registry, Textbox, DateTextBox, Textarea, Dialog,  FilteringSelect) {
    return declare("dime.widget.offer.OfferWidget", [_Base, TemplatedMixin, WidgetsInTemplateMixin], {

        templateString: template,
        baseClass: "offerWidget",
        store: window.storeManager.get('offers', false, true),


        _setupChildren: function(){
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
            //TODO urfr refactor concept of addresslines after till added customer address in model
            this.recepientAddressLine1Node.set('parentWidget', this);
            this.recepientAddressLine2Node.set('parentWidget', this);
            this.recepientAddressLine3Node.set('parentWidget', this);
            this.recepientAddressLine4Node.set('parentWidget', this);
            this.recepientAddressLine5Node.set('parentWidget', this);
        },

        _addcallbacks: function(){
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

            //TODO urfr make grid view for offer positions editable
        },

        _fillValues: function(){
            var parentWidget = this, offerPositionsContainer = this.offerPositionsContainer;
            this.inherited(arguments);
            var results = window.storeManager.get('offerpositions', true).query({offer: this.entity.id});
            results.forEach(function(entity){
                window.widgetManager.add(entity, 'offerpositions', OfferPositionWidget, parentWidget, offerPositionsContainer)
            });
        },

        _updateValues: function(entity){
            this.inherited(arguments);
            this.nameNode.set('value', entity.name);
            this.customerNode.set('value', entity.customer.name);
            this.statusNode.set('value', entity.status.id);
            this.accountantNode.set('value', entity.accountant.id);
            this.validToNode.set('value', entity.validTo.split(" ")[0]); //separate time from timestamp and only pass date
            this.rateGroupNode.set('value', entity.rateGroup.id);
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
                for(var i=0; i<data.offerPositions.length; i++) {
                    window.widgetManager.update(data.offerPositions[i],'offerpositions');
                }
            });
        }

    });
});
