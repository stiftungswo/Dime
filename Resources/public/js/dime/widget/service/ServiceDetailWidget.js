/**
 * Created by Till Wegmüller on 11/13/14.
 */
define([
    'dijit/_WidgetsInTemplateMixin',
    'dijit/_TemplatedMixin',
    'dime/common/EntityBoundWidget',
    'dojo/_base/declare',
    'dojo/text!dime/widget/service/templates/ServiceDetailWidget.html',
    'dijit/form/TextBox',
    'dime/common/GenericStoreTableWidget',
    'dijit/form/NumberTextBox',
    'dijit/form/CheckBox'
], function ( WidgetsInTemplateMixin, TemplatedMixin,  EntityBoundWidget, declare,  template) {
    return declare("dime.widget.service.ServiceDetailWidget", [EntityBoundWidget, TemplatedMixin, WidgetsInTemplateMixin], {

        templateString: template,
        baseClass: "serviceDetailWidget",
        collection:'services',
        independant: true,
        childConfig: {
            nameNode: {
                widgetProperty: 'value',
                entityProperty: 'name',
                nullValue: ''
            },
            aliasNode: {
                widgetProperty: 'value',
                entityProperty: 'alias',
                nullValue: ''
            },
            descriptionNode: {
                widgetProperty: 'value',
                entityProperty: 'description',
                nullValue: ''
            },
            chargeableNode: {
                widgetProperty: 'value',
                entityProperty: 'chargeable',
                nullValue: true
            },
            vatNode: {
                widgetProperty: 'value',
                entityProperty: 'vat',
                nullValue: '',
                constraints: {
                    min: 0,
                    max: 100,
                    pattern: "#0.####%"
                }
            },
            ratesNode: {
                childWidgetType: 'dime/widget/rate/RateRowWidget',
                header: ['Tarif Gruppe', 'Ansatz', 'Einheit', 'EinheitenTyp'],
                queryPrototype: {
                    service: 'id'
                },
                collection: 'rates',
                creatable: true,
                deleteable: true
            }
        }
    });
});
