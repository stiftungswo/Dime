define([
    'dijit/_WidgetsInTemplateMixin',
    'dijit/_TemplatedMixin',
    'dime/widget/_Base',
    'dojo/_base/declare',
    'dojo/text!dime/widget/invoice/templates/InvoiceItemTableRowWidget.html',
    'dijit/form/TextBox'
], function (WidgetsInTemplateMixin, TemplatedMixin,  _Base, declare,  template) {
    return declare("dime.widget.invoice.InvoiceItemTableRowWidget", [_Base, TemplatedMixin, WidgetsInTemplateMixin], {
        templateString: template,
        baseClass: "invoiceItemTableRowWidget",
        independant: false,
        _setupwatchers: false,
        config: {
            //Because of Some Unknown Reason the typeNode is undefined when Openening the Widget more than once. Somehow it tries to set the Variable and then Fails.
            values: {
                typeNode: {
                    widgetProperty: 'value',
                    entityProperty: 'type',
                    nullValue: 0,
                    disabled: true
                },
                valueNode: {
                    widgetProperty: 'value',
                    entityProperty: 'value',
                    nullValue: 0,
                    disabled: true
                },
                rateNode: {
                    widgetProperty: 'value',
                    entityProperty: 'rate',
                    nullValue: 0,
                    disabled: true
                },
                rateUnitNode: {
                    widgetProperty: 'value',
                    entityProperty: 'rateUnit',
                    nullValue: 0,
                    disabled: true
                },
                chargeNode: {
                    widgetProperty: 'value',
                    entityProperty: 'charge',
                    nullValue: 0,
                    disabled: true
                }
            }
        }
    });
});
