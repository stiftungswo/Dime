/**
 * Created by Till Wegmüller on 11/13/14.
 */
define([
    'dime/common/EntityOverviewWidget',
    'dijit/_WidgetsInTemplateMixin',
    'dijit/_TemplatedMixin',
    'dojo/_base/declare',
    'dojo/text!dime/widget/invoice/templates/InvoicesWidget.html'
], function (EntityOverviewWidget, WidgetsInTemplateMixin, TemplatedMixin, declare, template) {
    return declare("dime.widget.invoice.InvoicesWidget", [EntityOverviewWidget, TemplatedMixin, WidgetsInTemplateMixin], {

        templateString: template,
        baseClass: "invoicesWidget",
        collection: 'invoices',
        editTitleProperty: 'Rechnung',
        editWidget: 'dime/widget/invoice/InvoiceDetailWidget',
        dGrid: {
            sort: 'name',
            columns: [
                {label: 'ID', field: 'id', sortable: true},
                {label: 'Name', field: 'name'},
                {label: 'Alias', field: 'alias'},
                {label: 'Beschreibung', field: 'description'}
            ]
        }
    });
});

