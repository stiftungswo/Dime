/**
 * Created by Till Wegmüller on 11/13/14.
 */
define([
    'dijit/_WidgetsInTemplateMixin',
    'dijit/_TemplatedMixin',
    'dime/widget/_Base',
    'dojo/_base/declare',
    'dojo/text!dime/widget/invoice/templates/InvoiceDetailWidget.html',
    'dojo/request',
    //'dojo/dom-prop',
    'dijit/form/TextBox',
    'dijit/form/Button',
    'dijit/form/FilteringSelect',
    'dime/widget/GenericTableWidget'
], function ( WidgetsInTemplateMixin, TemplatedMixin,  _Base, declare,  template, request) {
    return declare("dime.widget.invoice.InvoiceDetailWidget", [_Base, TemplatedMixin, WidgetsInTemplateMixin], {

        templateString: template,
        baseClass: "invoiceDetailWidget",
        store:'invoices',
        entityType: 'invoices',
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
                descriptionNode: {
                    widgetProperty: 'value',
                    entityProperty: 'description',
                    nullValue: ''
                },
                projectNode: {
                    widgetProperty: 'value',
                    entityProperty: 'project',
                    nullValue: 1,
                    store: 'projects',
                    idProperty: 'id',
                    disabled: true
                },
                grossNode: {
                    widgetProperty: 'value',
                    entityProperty: 'gross',
                    nullValue: 0
                },
                netNode:{
                    widgetProperty: 'value',
                    entityProperty: 'net',
                    nullValue: 0
                },
                updateNode: {},
                itemsNode: {
                    childWidgetType: 'dime/widget/invoice/InvoiceItemTableRowWidget',
                    header: [ 'Typ', 'Anzahl', 'Ansatz', 'Einheit', 'Kosten' ],
                    queryPrototype: {
                        invoice: 'id'
                    },
                    store: 'invoiceitems',
                    entitytype: 'invoiceitems',
                    widgetProperty: 'updateValues',
                    entityProperty: 'items',
                    unidirectional: false
                },
                discountsNode: {
                    childWidgetType: 'dime/widget/timetrack/StandardDiscountRowWidget',
                    header: [ 'Name', 'Reduktion', 'Prozent', 'Wert' ],
                    widgetProperty: 'updateValues',
                    entityProperty: 'standardDiscounts',
                    unidirectional: true,
                    selectable: {
                        store: 'standarddiscounts'
                    },
                    store: 'standarddiscounts',
                    entitytype: 'standarddiscounts',
                    disabled: true
                },
                //invoiceDiscountsNode: {
                //    childWidgetType: 'dime/widget/offer/OfferDiscountRowWidget',
                //    header: [ 'Name', 'Reduktion', 'Prozent', 'Wert' ],
                //    widgetProperty: 'updateValues',
                //    unidirectional: false,
                //    store: 'offerdiscounts',
                //    entityProperty: 'offerDiscounts',
                //    entitytype: 'offerdiscounts'
                //},
                printNode:{
                    domProp: {
                        href: 'api/v1/invoices/{id}/print'
                    }
                }
            },
            callbacks:{
                updateNode:{
                    callbackName: 'click',
                    callbackFunction:function(){
                        var id = this.getParent().entity.id, parent = this.getParent();
                        request.get('/api/v1/invoices/'+id+'/update', {handleAs: 'json'}).then(function(data){
                            parent._updateValues(data);
                        });
                    }
                }
            },
            events:{
                updateInvoiceItems:{
                    Topic: 'entityUpdate',
                    subTopic: 'invoiceitems',
                    eventFunction: 'updateInvoiceItems'
                },
                createInvoiceItems:{
                    Topic: 'entityCreate',
                    subTopic: 'invoiceitems',
                    eventFunction: 'updateInvoiceItems'
                }
            }
        },

        updateInvoiceItems: function(arg){
            var item = arg.entity, changedProperty = arg.changedProperty, oldValue = arg.oldValue;
            var newValue = arg.newValue, base = this, invoice = this.entity;
            if(item.invoice.id === item.id){
                base.forceUpdate();
            }
        }
    });
});
