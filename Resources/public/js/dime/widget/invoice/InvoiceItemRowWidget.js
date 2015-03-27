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
            nameNode: {
                widgetProperty: 'value',
                entityProperty: 'name',
                nullValue: '',
                disabled: true
            },
            rateValueNode: {
                widgetProperty: 'value',
                entityProperty: 'rateValue',
                nullValue: '',
                disabled: true
            },
            rateUnitNode: {
                widgetProperty: 'value',
                entityProperty: 'rateUnit',
                nullValue: '',
                disabled: true
            },
            amountNode: {
                widgetProperty: 'value',
                entityProperty: 'amount',
                nullValue: '',
                disabled: true
            },
            VATNode: {
                widgetProperty: 'value',
                entityProperty: 'vat',
                nullValue: '',
                constraints: {
                    min: 0,
                    max: 100,
                    pattern: "#0.##%"
                },
                disabled: true
            },
            totalNode: {
                widgetProperty: 'value',
                entityProperty: 'total',
                nullValue: '',
                disabled: true
            }
        }
    });
});
