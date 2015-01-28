/**
 * Created by Till Wegmüller on 11/13/14.
 */
define([
    'dijit/_WidgetsInTemplateMixin',
    'dijit/_TemplatedMixin',
    'dime/common/EntityBoundWidget',
    'dojo/_base/declare',
    'dojo/text!dime/widget/invoice/templates/InvoicesWidget.html',
    'dojo/when',
    'dime/widget/invoice/InvoiceGrid',
    'dijit/form/Button'
], function ( WidgetsInTemplateMixin, TemplatedMixin,  EntityBoundWidget, declare, template, when) {
    return declare("dime.widget.invoice.InvoicesWidget", [EntityBoundWidget, TemplatedMixin, WidgetsInTemplateMixin], {

        templateString: template,
        baseClass: "invoicesWidget",
        collection: 'invoices',
        editTitleProperty: 'Rechnung',
        editWidget: 'dime/widget/invoice/InvoiceDetailWidget',
        dGrid: {
            sort: 'name',
            columns: [
                {label: 'Name', field: 'name'},
                {label: 'Alias', field: 'alias'},
                {label: 'Beschreibung', field: 'description'}
            ]
        }
    });
});

