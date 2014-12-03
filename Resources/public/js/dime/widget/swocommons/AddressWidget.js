define([
    'dijit/_WidgetsInTemplateMixin',
    'dijit/_TemplatedMixin',
    'dime/widget/_Base',
    'dojo/_base/declare',
    'dojo/text!dime/widget/swocommons/templates/AddressWidget.html',
    'dijit/form/NumberTextBox',
    'dijit/form/TextBox'
], function (WidgetsInTemplateMixin, TemplatedMixin, Base, declare, template) {
    return declare("dime.widget.swocommons.AddressWidget", [Base, TemplatedMixin, WidgetsInTemplateMixin], {
        templateString: template,
        baseClass: "addressWidget",
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
