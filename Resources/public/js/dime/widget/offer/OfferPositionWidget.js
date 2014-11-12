define([
    'dijit/_WidgetsInTemplateMixin',
    'dijit/_TemplatedMixin',
    'dime/widget/_Base',
    'dojo/_base/declare',
    'dojo/text!dime/widget/offer/templates/OfferPositionWidget.html',
    'dijit/registry',
    'dijit/form/TextBox',
    'dijit/form/DateTextBox',
    'dijit/form/Textarea',
    'dijit/form/CheckBox',
    'dijit/Dialog',
    'dijit/form/CheckBox',
    'dijit/form/Button',
    'xstyle!dime/widget/offer/css/OfferPositionWidget.css'
], function (WidgetsInTemplateMixin, TemplatedMixin, _Base, declare,
             template, registry, Textbox, DateTextBox, Textarea, CheckBox,  Dialog ) {
    return declare("dime.widget.offer.OfferPositionWidget", [_Base, TemplatedMixin, WidgetsInTemplateMixin], {

        templateString: template,
        baseClass: "offerPositionWidget",
        store: null,
        entity: null,

        _setupChildren: function(){
            this.store = window.storeManager.get('offerpositions', false, true);
            //todo urfr change types to selection list, where editin ist necessary e.g. customer, accountant
            this.orderNode.set('parentWidget', this);
            this.serviceNode.set('parentWidget', this);
            this.serviceNode.set('store', window.storeManager.get('services', true));
            this.serviceNode.set('searchAttr','name');
            this.serviceRateValueNode.set('parentWidget', this);
            this.serviceRateValueNode.set('disabled',true);
            this.offerPositionRateValueNode.set('parentWidget', this);
            this.rateUnitNode.set('parentWidget', this);
            this.rateUnitNode.set('disabled',true);
            this.VATNode.set('parentWidget', this);
            this.discountableNode.set('parentWidget', this);
            this.deleteNode.set('parentWidget', this);

        },

        _addcallbacks: function(){
            this.orderNode.watch('value', this._watchercallback);
            this.serviceNode.watch('value', this._watchercallback);
            this.serviceRateValueNode.watch('value', this._watchercallback);
            this.offerPositionRateValueNode.watch('value', this._watchercallback);
            this.VATNode.watch('value', this._watchercallback);
            this.discountableNode.watch('value', this._watchercallback);
            this.rateUnitNode.watch('value', this._watchercallback);
            this.deleteNode.on('click', function(){
                this.parentWidget.store.remove(this.parentWidget.entity.id);
                window.widgetManager.remove(this.parentWidget.entity, 'offerpositions');
            });
        },

        _updateValues: function(entity){
            this.inherited(arguments);
            this.orderNode.set('value', entity.order);
            this.serviceNode.set('value', entity.service ? entity.service.id : null);
            this.serviceRateValueNode.set('value', entity.serviceRate ? entity.serviceRate.rateValue : null);
            this.offerPositionRateValueNode.set('value', entity.rateValue);
            this.rateUnitNode.set('value', entity.serviceRate ? entity.serviceRate.rateUnit : null);
            this.VATNode.set('value', entity.vat);
            this.discountableNode.set('value', entity.discountable);

        },

        _watchercallback: function(property, oldvalue, newvalue){
            if(oldvalue == "") return;
            //used because this points to caller not to THIS Widget. Above all elements were populated with parentwidget (THIS).
            var offerPositionId = this.parentWidget.entity.id;
            var offerPositionStore = this.parentWidget.store;
            var result = null;
            switch(this.dojoAttachPoint) {
                case "orderNode":
                    result = offerPositionStore.put({order: newvalue}, {id: offerPositionId});
                    break;
                case "serviceNode":
                    result = offerPositionStore.put({service: newvalue}, {id: offerPositionId});
                    break;
                case "offerPositionRateValueNode":
                    result = offerPositionStore.put({rateValue: newvalue}, {id: offerPositionId});
                    break;
                case "VATNode":
                    result = offerPositionStore.put({vat: newvalue}, {id: offerPositionId});
                    break;
                case "discountableNode":
                    result = offerPositionStore.put({discountable: newvalue}, {id: offerPositionId});
                    break;
                default:
                    break;
            }
            result.then(function(data){
                window.widgetManager.update(data, 'offerpositions');
            });
        }

    });
});
