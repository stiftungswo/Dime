define([
    '../../../dijit/_WidgetsInTemplateMixin',
    'dijit/_TemplatedMixin',
    'dime/widget/_Base',
    'dojo/_base/declare',
    'dojo/text!dime/widget/timetrack/templates/StandardDiscountRowWidget.html',
    'dijit/registry',
    'dijit/form/TextBox',
    'dijit/form/NumberTextBox',
    'dijit/form/CheckBox',
    'dojo/when',
    'dijit/form/Button'
], function (WidgetsInTemplateMixin, TemplatedMixin, _Base, declare, template) {
    return declare("dime.widget.timetrack.StandardDiscountRowWidget", [_Base, TemplatedMixin, WidgetsInTemplateMixin], {

        templateString: template,
        baseClass: "discountWidget",
        store: 'standarddiscounts',
        entitytype: 'standarddiscounts',
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
