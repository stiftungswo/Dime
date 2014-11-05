define([
    'dijit/_WidgetsInTemplateMixin',
    'dijit/_TemplatedMixin',
    'dime/widget/timetrack/_TimetrackerWidgetBase',
    'dojo/_base/declare',
    'dojo/text!dime/widget/offer/templates/OfferPositionWidget.html',
    'dijit/registry',
    'dijit/form/TextBox',
    'dijit/form/DateTextBox',
    'dijit/form/Textarea',
    'dijit/form/CheckBox',
    'dijit/Dialog',
    "dijit/form/CheckBox",
], function (WidgetsInTemplateMixin, TemplatedMixin, _TimetrackerWidgetBase, declare,
             template, registry, Textbox, DateTextBox, Textarea, CheckBox,  Dialog ) {
    return declare("dime.widget.offer.OfferPositionWidget", [_TimetrackerWidgetBase, TemplatedMixin, WidgetsInTemplateMixin], {

        templateString: template,
        baseClass: "offerPositionWidget",
        store: window.storeManager.get('offerpositions', true),
        entity: null,

        _setupChildren: function(){

            //todo urfr change types to selection list, where editin ist necessary e.g. customer, accountant
            this.orderNode.set('parentWidget', this);
            this.serviceNode.set('parentWidget', this);
            this.serviceNode.set('store', window.storeManager.get('services', true));
            this.serviceNode.set('searchAttr','name');
            this.rateNode.set('parentWidget', this);
            this.VATNode.set('parentWidget', this);
            this.discountableNode.set('parentWidget', this);
        },

        _addcallbacks: function(){
            this.orderNode.watch('value', this._watchercallback);
            this.serviceNode.watch('value', this._watchercallback);
            this.rateNode.watch('value', this._watchercallback);
            this.VATNode.watch('value', this._watchercallback);
            this.discountableNode.watch('value', this._watchercallback);
        },

        _fillValues: function(){
            this.inherited(arguments);
            this._updateValues();
        },

        _updateValues: function(entity){
            //todo urfr update values
            this.orderNode.set('value', this.entity.order);
            this.serviceNode.set('value', this.entity.service.id);
            this.rateNode.set('value', this.entity.rate);
            this.VATNode.set('value', this.entity.vat);
            this.discountableNode.set('value', this.entity.discountable);
        },

        _watchercallback: function(property, oldvalue, newvalue){
            if(oldvalue == "") return;
            //used because this points to caller not to THIS Widget. Above all elements were populated with parentwidget (THIS).
            var offerPositionId = this.parentWidget.entity.id;
            var offerPositionStore = this.parentWidget.store;
            switch(this.dojoAttachPoint) {
                case "orderNode":
                    offerPositionStore.put({id: offerPositionId, order: newvalue});
                    break;
                case "serviceNode":
                    offerPositionStore.put({id: offerPositionId, service: newvalue});
                    break;
                case "rateNode":
                    offerPositionStore.put({id: offerPositionId, rate: newvalue});
                    break;
                case "VATNode":
                    offerPositionStore.put({id: offerPositionId, vat: newvalue});
                    break;
                case "discountableNode":
                    offerPositionStore.put({id: offerPositionId, discountable: newvalue});
                    break;
                default:
                    break;
            }
        }

    });
});
