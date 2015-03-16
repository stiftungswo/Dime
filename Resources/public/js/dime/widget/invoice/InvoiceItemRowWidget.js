define([
    'dijit/_WidgetsInTemplateMixin',
    'dijit/_TemplatedMixin',
    'dime/common/EntityBoundWidget',
    'dojo/_base/declare',
    'dojo/text!dime/widget/invoice/templates/InvoiceItemRowWidget.html',
    'dijit/form/TextBox',
    'xstyle!dime/widget/invoice/css/InvoiceItemRowWidget.css'
], function (WidgetsInTemplateMixin, TemplatedMixin,  EntityBoundWidget, declare,  template) {
    return declare("dime.widget.invoice.InvoiceItemRowWidget", [EntityBoundWidget, TemplatedMixin, WidgetsInTemplateMixin], {
        templateString: template,
        baseClass: "invoiceItemRowWidget",
        collection: 'invoiceitems',
        baseConfig: {
            independant: true
        },
        childConfig: {
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
    });
});
