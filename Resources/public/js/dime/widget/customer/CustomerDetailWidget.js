/**
 * Created by Till Wegmüller on 11/13/14.
 */
define([
    'dijit/_WidgetsInTemplateMixin',
    'dijit/_TemplatedMixin',
    'dime/common/EntityBoundWidget',
    'dojo/_base/declare',
    'dojo/text!dime/widget/customer/templates/CustomerDetailWidget.html',
    'dime/common/GenericSubEntityTableWidget',
    'dime/widget/swocommons/AddressWidget',
    'dijit/form/TextBox',
    'dijit/form/FilteringSelect',
    'dijit/form/CheckBox',
    'dijit/form/Button'
], function ( WidgetsInTemplateMixin, TemplatedMixin,  EntityBoundWidget, declare,  template) {
    return declare("dime.widget.customer.CustomerDetailWidget", [EntityBoundWidget, TemplatedMixin, WidgetsInTemplateMixin], {

        templateString: template,
        baseClass: "customerDetailWidget",
        collection: 'customers',
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
            chargeableNode: {
                widgetProperty: 'value',
                entityProperty: 'chargeable',
                nullValue: ''
            },
            addressNode: {
                widgetProperty: 'entity',
                entityProperty: 'address',
                nullValue: ''
            },
            rateGroupNode: {
                widgetProperty: 'value',
                entityProperty: 'rateGroup',
                nullValue: 1,
                store: 'rategroups',
                idProperty: 'id'
            },
            phonesNode: {
                childWidgetType: 'dime/widget/swocommons/PhoneRowWidget',
                header: [ 'Nummer', 'Typ' ],
                widgetProperty: 'value',
                entityProperty: 'phones',
                creatable: true,
                deleteable: true
            }
        }
    });
});
