define([
    'dijit/_WidgetsInTemplateMixin',
    'dijit/_TemplatedMixin',
    'dime/common/EntityBoundWidget',
    'dojo/_base/declare',
    'dojo/text!dime/widget/invoice/templates/InvoiceItemTableRowWidget.html',
    'dijit/form/TextBox'
], function (WidgetsInTemplateMixin, TemplatedMixin,  EntityBoundWidget, declare,  template) {
    return declare("dime.widget.invoice.InvoiceItemTableRowWidget", [EntityBoundWidget, TemplatedMixin, WidgetsInTemplateMixin], {
        templateString: template,
        baseClass: "invoiceItemTableRowWidget",
        collection: 'invoiceitems',
        independant: false,
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
