/**
 * Created by Till Wegmüller on 11/13/14.
 */
define([
    'dime/common/EntityOverviewWidget',
    'dijit/_WidgetsInTemplateMixin',
    'dijit/_TemplatedMixin',
    'dojo/_base/declare',
    'dojo/text!dime/widget/service/templates/ServicesWidget.html'
], function (EntityOverviewWidget, WidgetsInTemplateMixin, TemplatedMixin, declare, template) {
    return declare("dime.widget.service.ServicesWidget", [EntityOverviewWidget, TemplatedMixin, WidgetsInTemplateMixin], {

        templateString: template,
        baseClass: "servicesWidget",
        editTitleProperty: 'Service',
        editWidget: 'dime/widget/service/ServiceDetailWidget',
        collection: 'services',
        dGrid: {
            sort: 'name',
            columns: [
                {label: 'Name', field: 'name'},
                {label: 'Alias', field: 'alias'},
                {label: 'Beschreibung', field: 'description'},
                {label: 'Verechenbar', field: 'chargeable'},
                {label: 'MwSt', field: 'vat'}
            ]
        },
        childConfig: {}
    });
});

