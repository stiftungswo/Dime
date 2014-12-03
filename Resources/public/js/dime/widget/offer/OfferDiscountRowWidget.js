define([
    'dijit/_WidgetsInTemplateMixin',
    'dijit/_TemplatedMixin',
    'dime/widget/_Base',
    'dojo/_base/declare',
    'dojo/text!dime/widget/offer/templates/OfferDiscountRowWidget.html',
    'dijit/registry',
    'dijit/form/TextBox',
    'dijit/form/NumberTextBox',
    'dijit/form/CheckBox',
    'dijit/form/Button'
], function (WidgetsInTemplateMixin, TemplatedMixin, _Base, declare, template) {
    return declare("dime.widget.offer.OfferDiscountRowWidget", [_Base, TemplatedMixin, WidgetsInTemplateMixin], {

        templateString: template,
        baseClass: "offerDiscountWidget",
        store: 'offerdiscounts',
        entitytype: 'offerdiscounts',
        config: {
            values: {
                nameNode: {
                    widgetProperty: 'value',
                    entityProperty: 'name',
                    nullValue: ''
                },
                minusNode: {
                    widgetProperty: 'value',
                    entityProperty: 'minus',
                    nullValue: '',
                    intermediateChanges: 'base'
                },
                percentageNode: {
                    widgetProperty: 'value',
                    entityProperty: 'percentage',
                    nullValue: ''
                },
                valueNode: {
                    widgetProperty: 'value',
                    entityProperty: 'value',
                    nullValue: ''
                }
            }
        },
        _updateValues: function(entity){
            if(entity.percentage){
                this.valueNode.set('constraints', {
                    min: 0,
                    max: 100,
                    pattern: "#0.##%"
                });
            } else {
                this.valueNode.set('constraints', {
                    min: 0,
                    max: 10000000,
                    pattern: "#######0.##"
                });
            }
            this.inherited(arguments);
        }
    });
});
