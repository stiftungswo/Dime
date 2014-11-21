define([
    'dijit/_WidgetsInTemplateMixin',
    'dijit/_TemplatedMixin',
    'dime/widget/_Base',
    'dojo/_base/declare',
    'dojo/text!dime/widget/offer/templates/OfferPositionWidget.html',
    'dijit/registry',
    'dijit/form/TextBox',
    'dijit/form/NumberTextBox',
    'dijit/form/DateTextBox',
    'dijit/form/Textarea',
    'dijit/form/CheckBox',
    'dijit/form/FilteringSelect',
    'dijit/form/Button',
    'xstyle!dime/widget/offer/css/OfferPositionWidget.css'
], function (WidgetsInTemplateMixin, TemplatedMixin, _Base, declare,template, registry, Textbox, NumberTextBox, DateTextBox, Textarea, CheckBox, FilteringSelect, Button ) {
    return declare("dime.widget.offer.OfferPositionWidget", [_Base, TemplatedMixin, WidgetsInTemplateMixin], {

        templateString: template,
        baseClass: "offerPositionWidget",
        store: null,
        entity: null,

        _setupChildren: function(){
            this.store = window.storeManager.get('offerpositions', false, true);

            this.orderNode.set('parentWidget', this);
            this.serviceNode.set('parentWidget', this);
            this.serviceNode.set('store', window.storeManager.get('services', true));
            this.serviceNode.set('searchAttr','name');
            this.rateValueNode.set('parentWidget', this);
            this.rateUnitNode.set('parentWidget', this);
            this.rateUnitTypeNode.set('parentWidget', this);
            this.rateUnitTypeNode.set('store', window.storeManager.get('rateunittypes', true));
            this.rateUnitTypeNode.set('searchAttr','name');
            this.VATNode.set('parentWidget', this);
            this.VATNode.constraints = {
                min: 0,
                max: 100,
                pattern: "#0.##%"
            };
            this.discountableNode.set('parentWidget', this);
            this.amountNode.set('parentWidget', this);
            this.totalNode.set('parentWidget', this);
            this.totalNode.set('disabled', true);
            this.deleteNode.set('parentWidget', this);
        },

        _addcallbacks: function(){
            this.orderNode.watch('value', this._watchercallback);
            this.serviceNode.watch('value', this._watchercallback);
            this.rateValueNode.watch('value', this._watchercallback);
            this.rateUnitTypeNode.watch('value', this._watchercallback);
            this.rateUnitNode.watch('value', this._watchercallback);
            this.VATNode.watch('value', this._watchercallback);
            this.discountableNode.watch('value', this._watchercallback);
            this.rateUnitNode.watch('value', this._watchercallback);
            this.amountNode.watch('value', this._watchercallback);
            this.deleteNode.on('click', this._destroyParentHandler);
        },

        _updateValues: function(entity){
            this.inherited(arguments);
            this.orderNode.set('value', entity.order);
            this.serviceNode.set('value', entity.service ? entity.service.id : null);
            this.rateValueNode.set('value', entity.rateValue);
            this.rateUnitNode.set('value', entity.rateUnit);
            this.rateUnitTypeNode.set('value', entity.rateUnitType);
            this.amountNode.set('value', entity.amount);
            this.VATNode.set('value', entity.vat);
            this.discountableNode.set('value', entity.discountable);
            this.totalNode.set('value', entity.total);

            var sameColor = '#ffffff';
            var differentColor = '#c0c0ff';

            if(this.rateValueNode.get('value') != entity.serviceRate.rateValue)
                this.rateValueNode.set('style','background-color: '+differentColor);
            else
                this.rateValueNode.set('style','background-color: '+sameColor);

            if(this.rateUnitNode.get('value') != entity.serviceRate.rateUnit)
                this.rateUnitNode.set('style','background-color: '+differentColor);
            else
                this.rateUnitNode.set('style','background-color: '+sameColor);

            console.log(this.rateUnitTypeNode.get('value'));
            console.log(entity.serviceRate.rateUnitType);
            if(this.rateUnitTypeNode.get('value') != entity.serviceRate.rateUnitType)
                this.rateUnitTypeNode.set('style','background-color: '+differentColor);
            else
                this.rateUnitTypeNode.set('style','background-color: '+sameColor);
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
                    result = offerPositionStore.put({service: newvalue, rateUnit:null, rateUnitType:null, rateValue:null}, {id: offerPositionId});
                    break;
                case "rateValueNode":
                    result = offerPositionStore.put({rateValue: newvalue}, {id: offerPositionId});
                    break;
                case "rateUnitNode":
                    result = offerPositionStore.put({rateUnit: newvalue }, {id: offerPositionId});
                    break;
                case "rateUnitTypeNode":
                    result = offerPositionStore.put({rateUnitType: newvalue}, {id: offerPositionId});
                    break;
                case "rateUnitNode":
                    result = offerPositionStore.put({rateUnit: newvalue}, {id: offerPositionId});
                    break;
                case "amountNode":
                    result = offerPositionStore.put({amount: newvalue}, {id: offerPositionId});
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
                window.widgetManager.update(data.offer, 'offers');
            });
        }

    });
});
