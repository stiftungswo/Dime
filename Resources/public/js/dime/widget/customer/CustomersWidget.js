/**
 * Created by Till Wegmüller on 11/13/14.
 */
define([
    'dijit/_WidgetsInTemplateMixin',
    'dijit/_TemplatedMixin',
    'dime/common/EntityBoundWidget',
    'dojo/_base/declare',
    'dojo/text!dime/widget/customer/templates/CustomersWidget.html',
    'dojo/when',
    'dime/widget/customer/CustomerGrid',
    'dijit/form/Button'
], function ( WidgetsInTemplateMixin, TemplatedMixin,  EntityBoundWidget, declare, template, when) {
    return declare("dime.widget.customer.CustomersWidget", [EntityBoundWidget, TemplatedMixin, WidgetsInTemplateMixin], {

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

