/**
 * Created by Till Wegmüller on 11/13/14.
 */
define([
    'dime/common/EntityOverviewWidget',
    'dijit/_WidgetsInTemplateMixin',
    'dijit/_TemplatedMixin',
    'dojo/_base/declare',
    'dojo/text!dime/widget/customer/templates/CustomersWidget.html'
], function (EntityOverviewWidget, WidgetsInTemplateMixin, TemplatedMixin, declare, template) {
    return declare("dime.widget.customer.CustomersWidget", [EntityOverviewWidget, TemplatedMixin, WidgetsInTemplateMixin], {

        templateString: template,
        baseClass: "customersWidget",
        editTitleProperty: 'Kunde',
        editWidget: 'dime/widget/customer/CustomerDetailWidget',
        collection: 'customers',
        dGrid: {
            sort: 'name',
            columns: [
                {label: 'Name', field: 'name'},
                {label: 'Alias', field: 'alias'},
                {label: 'Tarif Gruppe', field: 'rateGroup', formatter: function(data){
                    return data? data.name : null;
                }},
                {label: 'Verechenbar', field: 'chargeable'}
            ]
        },
        childConfig: {}
    });
});

