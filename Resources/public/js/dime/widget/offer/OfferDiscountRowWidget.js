define([
    'dijit/_WidgetsInTemplateMixin',
    'dijit/_TemplatedMixin',
    'dime/common/EntityBoundWidget',
    'dojo/_base/declare',
    'dojo/text!dime/widget/offer/templates/OfferDiscountRowWidget.html',
    'dijit/registry',
    'dijit/form/TextBox',
    'dijit/form/NumberTextBox',
    'dijit/form/CheckBox',
    'dijit/form/Button',
    'xstyle!dime/widget/offer/css/OfferDiscountRowWidget.css'
], function (WidgetsInTemplateMixin, TemplatedMixin, EntityBoundWidget, declare, template) {
    return declare("dime.widget.offer.OfferDiscountRowWidget", [EntityBoundWidget, TemplatedMixin, WidgetsInTemplateMixin], {

        independant: true,
        templateString: template,
        baseClass: "offerDiscountWidget",
        collection: 'offerdiscounts',
        childConfig: {
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
        },
        _updateView: function(entity){
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
