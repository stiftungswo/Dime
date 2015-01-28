define([
    'dijit/_WidgetsInTemplateMixin',
    'dijit/_TemplatedMixin',
    'dime/common/EntityBoundWidget',
    'dojo/_base/declare',
    'dojo/text!dime/widget/offer/templates/OfferPositionRowWidget.html',
    'dijit/registry',
    'dijit/form/TextBox',
    'dijit/form/NumberTextBox',
    'dijit/form/DateTextBox',
    'dijit/form/CheckBox',
    'dijit/form/FilteringSelect',
    'dijit/form/Button',
    'xstyle!dime/widget/offer/css/OfferPositionRowWidget.css'
], function (WidgetsInTemplateMixin, TemplatedMixin, EntityBoundWidget, declare, template) {
    return declare("dime.widget.offer.OfferPositionRowWidget", [EntityBoundWidget, TemplatedMixin, WidgetsInTemplateMixin], {

        templateString: template,
        baseClass: "offerPositionRowWidget",
        collection: 'offerpositions',
        independant: true,
        childConfig: {
            orderNode: {
                widgetProperty: 'value',
                entityProperty: 'order',
                nullValue: ''
            },
            serviceNode: {
                widgetProperty: 'value',
                entityProperty: 'service',
                nullValue: '',
                store: 'services',
                searchAttr: 'name',
                idProperty: 'id'
            },
            rateValueNode: {
                widgetProperty: 'value',
                entityProperty: 'rateValue',
                nullValue: ''
            },
            rateUnitNode: {
                widgetProperty: 'value',
                entityProperty: 'rateUnit',
                nullValue: '',
                store: 'rateunittypes',
                searchAttr: 'name'
            },
            rateUnitTypeNode: {
                widgetProperty: 'value',
                entityProperty: 'rateUnitType',
                nullValue: 0,
                store: 'rateunittypes'
            },
            amountNode: {
                widgetProperty: 'value',
                entityProperty: 'amount',
                nullValue: ''
            },
            VATNode: {
                widgetProperty: 'value',
                entityProperty: 'vat',
                nullValue: '',
                constraints: {
                    min: 0,
                    max: 100,
                    pattern: "#0.##%"
                }
            },
            discountableNode: {
                widgetProperty: 'value',
                entityProperty: 'discountable',
                nullValue: ''
            },
            totalNode: {
                widgetProperty: 'value',
                entityProperty: 'total',
                nullValue: '',
                disabled: true
            }
        },

        colorWhite: '#ffffff',
        colorBlue: '#c0c0ff',

        toCheck: ['rateValue', 'rateUnit', 'rateUnitType'],
        _setEntityAttr: function(entity){
            this.inherited(arguments);
            if(!entity.serviceRate) return;
            var sameColor = this.colorWhite, differentColor = this.colorBlue, toCheck = this.toCheck;
            for (var i=0; i<toCheck.length;i++){
                var property = toCheck[i];
                var serviceValue = entity.serviceRate[property];
                var localValue = entity[property];
                var node = property + 'Node';
                if (serviceValue === localValue) {
                    this[node].set('style', 'background-color: ' + sameColor);
                } else {
                    this[node].set('style', 'background-color: ' + differentColor);
                }
            }
        }
    });
});
