/**
 * Created by Till Wegmüller on 11/13/14.
 */
define([
    'dijit/_WidgetsInTemplateMixin',
    'dijit/_TemplatedMixin',
    'dime/widget/_Base',
    'dojo/_base/declare',
    'dojo/text!dime/widget/rate/templates/RateRowWidget.html',
    'dijit/form/TextBox',
    'dijit/form/NumberTextBox',
    "dijit/form/FilteringSelect",
    'dijit/form/Button'
], function ( WidgetsInTemplateMixin, TemplatedMixin,  _Base, declare,  template) {
    return declare("dime.widget.rate.RateRowWidget", [_Base, TemplatedMixin, WidgetsInTemplateMixin], {

        templateString: template,
        baseClass: "rateWidget",
        store: 'rates',
        independant: true,
        config: {
            values: {
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
                    store: 'rateunittypes',
                    idProperty: 'id'
                }
            }
        }
    });
});
