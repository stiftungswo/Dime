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
            this.serviceRateValueNode.set('parentWidget', this);
            this.offerPositionRateValueNode.set('parentWidget', this);
            this.rateUnitNode.set('parentWidget', this);
            this.VATNode.set('parentWidget', this);
            this.discountableNode.set('parentWidget', this);

        },

        _addcallbacks: function(){
            this.orderNode.watch('value', this._watchercallback);
            this.serviceNode.watch('value', this._watchercallback);
            this.serviceRateValueNode.watch('value', this._watchercallback);
            this.offerPositionRateValueNode.watch('value', this._watchercallback);
            this.VATNode.watch('value', this._watchercallback);
            this.discountableNode.watch('value', this._watchercallback);
            this.rateUnitNode.watch('value', this._watchercallback);
        },

        _fillValues: function(){
            this.inherited(arguments);
            this._updateValues();
        },

        _updateValues: function(entity){
            //todo urfr update values
            console.log("entity"+entity);
            this.orderNode.set('value', this.entity.order);
            this.serviceNode.set('value', this.entity.service.id);
            this.serviceRateValueNode.set('value', this.entity.serviceRate ? this.entity.serviceRate.rateValue : null);
            this.offerPositionRateValueNode.set('value', this.entity.rateValue);
            this.rateUnitNode.set('value', this.entity.serviceRate ? this.entity.serviceRate.rateUnit : null);
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
                    offerPositionStore.put({order: newvalue}, {id: offerPositionId});
                    break;
                case "serviceNode":
                    offerPositionStore.put({service: newvalue}, {id: offerPositionId});
                    break;
                case "offerPositionRateValueNode":
                    offerPositionStore.put({rate: newvalue}, {id: offerPositionId});
                    break;
                case "VATNode":
                    offerPositionStore.put({vat: newvalue}, {id: offerPositionId});
                    break;
                case "discountableNode":
                    offerPositionStore.put({discountable: newvalue}, {id: offerPositionId});
                    break;
                default:
                    break;
            }
        }

    });
});
