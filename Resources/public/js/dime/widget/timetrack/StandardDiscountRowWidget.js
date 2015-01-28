define([
    'dijit/_WidgetsInTemplateMixin',
    'dijit/_TemplatedMixin',
    'dime/common/EntityBoundWidget',
    'dojo/_base/declare',
    'dojo/text!dime/widget/timetrack/templates/StandardDiscountRowWidget.html',
    'dijit/registry',
    'dijit/form/TextBox',
    'dijit/form/NumberTextBox',
    'dijit/form/CheckBox',
    'dijit/form/Button'
], function (WidgetsInTemplateMixin, TemplatedMixin, EntityBoundWidget, declare, template) {
    return declare("dime.widget.timetrack.StandardDiscountRowWidget", [EntityBoundWidget, TemplatedMixin, WidgetsInTemplateMixin], {

        templateString: template,
        baseClass: "discountWidget",
        collection: 'standarddiscounts',
        childConfig: {
            nameNode: {
                widgetProperty: 'value',
                entityProperty: 'name',
                nullValue: ''
            },
            minusNode: {
                widgetProperty: 'value',
                entityProperty: 'minus',
                nullValue: ''
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
