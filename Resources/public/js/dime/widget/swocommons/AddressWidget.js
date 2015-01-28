define([
    'dijit/_WidgetsInTemplateMixin',
    'dijit/_TemplatedMixin',
    'dime/common/EntityBoundWidget',
    'dojo/_base/declare',
    'dojo/text!dime/widget/swocommons/templates/AddressWidget.html',
    'dijit/form/NumberTextBox',
    'dijit/form/TextBox',
    'xstyle!dime/widget/swocommons/css/AddressWidget.css'
], function (WidgetsInTemplateMixin, TemplatedMixin, EntityBoundWidget, declare, template) {
    return declare("dime.widget.swocommons.AddressWidget", [EntityBoundWidget, TemplatedMixin, WidgetsInTemplateMixin], {
        templateString: template,
        baseClass: "addressWidget",
        entitytype: 'address',
        independant: false,
        config: {
            values: {
                streetnumberNode: {
                    widgetProperty: 'value',
                    entityProperty: 'streetnumber',
                    nullValue: ''
                },
                streetNode: {
                    widgetProperty: 'value',
                    entityProperty: 'street',
                    nullValue: ''
                },
                plzNode: {
                    widgetProperty: 'value',
                    entityProperty: 'plz',
                    nullValue: ''
                },
                cityNode: {
                    widgetProperty: 'value',
                    entityProperty: 'city',
                    nullValue: ''
                },
                stateNode: {
                    widgetProperty: 'value',
                    entityProperty: 'state',
                    nullValue: ''
                },
                countryNode: {
                    widgetProperty: 'value',
                    entityProperty: 'country',
                    nullValue: ''
                }
            }
        }
    });
});
