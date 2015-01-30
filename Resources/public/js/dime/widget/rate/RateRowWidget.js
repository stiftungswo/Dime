/**
 * Created by Till Wegmüller on 11/13/14.
 */
define([
    'dijit/_WidgetsInTemplateMixin',
    'dijit/_TemplatedMixin',
    'dime/common/EntityBoundWidget',
    'dojo/_base/declare',
    'dojo/text!dime/widget/rate/templates/RateRowWidget.html',
    'dijit/form/TextBox',
    'dijit/form/NumberTextBox',
    "dijit/form/FilteringSelect"
], function ( WidgetsInTemplateMixin, TemplatedMixin,  EntityBoundWidget, declare,  template) {
    return declare("dime.widget.rate.RateRowWidget", [EntityBoundWidget, TemplatedMixin, WidgetsInTemplateMixin], {

        templateString: template,
        baseClass: "rateWidget",
        collection: 'rates',
        independant: true,
        childConfig: {
            rateGroupNode: {
                widgetProperty: 'value',
                entityProperty: 'rateGroup',
                nullValue: 1,
                store: 'rategroups',
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
                nullValue: ''
            },
            rateUnitTypeNode: {
                widgetProperty: 'value',
                entityProperty: 'rateUnitType',
                nullValue: 0,
                store: 'rateunittypes'
            }
        }
    });
});
