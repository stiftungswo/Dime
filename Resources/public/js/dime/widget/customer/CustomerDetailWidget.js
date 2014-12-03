/**
 * Created by Till Wegmüller on 11/13/14.
 */
define([
    'dijit/_WidgetsInTemplateMixin',
    'dijit/_TemplatedMixin',
    'dime/widget/_Base',
    'dojo/_base/declare',
    'dojo/text!dime/widget/customer/templates/CustomerDetailWidget.html',
    'dime/widget/swocommons/PhoneRowWidget',
    'dime/widget/swocommons/AddressWidget',
    'dijit/form/TextBox',
    'dijit/form/FilteringSelect',
    'dijit/form/CheckBox',
    'dijit/form/Button'
], function ( WidgetsInTemplateMixin, TemplatedMixin,  _Base, declare,  template) {
    return declare("dime.widget.customer.CustomerDetailWidget", [_Base, TemplatedMixin, WidgetsInTemplateMixin], {

        templateString: template,
        baseClass: "customerDetailWidget",
        store: 'customers',
        entityType: 'customers',
        independant: true,
        config: {
            values: {
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
                    widgetProperty: 'updateValues',
                    entityProperty: 'address',
                    nullValue: ''
                },
                rateGroupNode: {
                    widgetProperty: 'value',
                    entityProperty: 'rategroup',
                    nullValue: 1,
                    store: 'rategroups',
                    idProperty: 'id'
                },
                phonesNode: {
                    childWidgetType: 'dime/widget/swocommons/PhoneRowWidget',
                    queryPrototype: {
                        customer: 'id'
                    },
                    prototype: {
                        Number: '000000',
                        Type: 'Mobile'
                    },
                    header: [ 'Nummer', 'Typ' ],
                    store: 'phones',
                    entityType: 'phones',
                    widgetProperty: 'updateValues',
                    entityProperty: 'phones',
                    unidirectional: true,
                    entitytype: 'phones'
                }
            }
        }
    });
});
