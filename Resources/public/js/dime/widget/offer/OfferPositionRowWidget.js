define([
    'dijit/_WidgetsInTemplateMixin',
    'dijit/_TemplatedMixin',
    'dime/widget/_Base',
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
], function (WidgetsInTemplateMixin, TemplatedMixin, _Base, declare, template) {
    return declare("dime.widget.offer.OfferPositionRowWidget", [_Base, TemplatedMixin, WidgetsInTemplateMixin], {

        templateString: template,
        baseClass: "offerPositionRowWidget",
        store: 'offerpositions',
        entitytype: 'offerpositions',
        independant: true,
        config: {
            values: {
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
                discountableNode:{
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
            events: {
                updateColors:{
                    Topic: 'widgetUpdate',
                    subTopic: 'offerpositions',
                    eventFunction: '_updateColors'
                },
                updateColors2:{
                    Topic: 'widgetCreate',
                    subTopic: 'offerpositions',
                    eventFunction: '_updateColors'
                }
            }
        },

        colorWhite: '#ffffff',
        colorBlue: '#c0c0ff',

        toCheck: ['rateValue', 'rateUnit', 'rateUnitType'],
        _updateColors: function(arg){
            var  widget = arg.widget, base = this;
            if(widget.id === base.id) {
                var sameColor = this.colorWhite, differentColor = this.colorBlue, entity = this.entity, toCheck = this.toCheck;
                for (var i=0; i<toCheck.length;i++){
                    var property = toCheck[i];
                    var serviceValue = entity.serviceRate[property];
                    var localValue = entity[property];
                    var node = property + 'Node';
                    if(serviceValue == localValue){
                        base[node].set('style', 'background-color: ' + sameColor);
                    } else {
                        base[node].set('style', 'background-color: ' + differentColor);
                    }
                }
            }
        }
    });
});
