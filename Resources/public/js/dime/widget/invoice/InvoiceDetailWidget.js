/**
 * Created by Till Wegmüller on 11/13/14.
 */
define([
    'dijit/_WidgetsInTemplateMixin',
    'dijit/_TemplatedMixin',
    'dime/common/EntityBoundWidget',
    'dojo/_base/declare',
    'dojo/text!dime/widget/invoice/templates/InvoiceDetailWidget.html',
    'dojo/request',
    //'dojo/dom-prop',
    'dijit/form/TextBox',
    'dijit/form/Button',
    'dijit/form/FilteringSelect',
    'dime/form/DateTextBox',
    'dijit/form/NumberTextBox',
    'dime/common/GenericTableWidget',
    'dime/common/GenericStoreTableWidget',
    'dime/common/SelectableSubEntityTableWidget',
    'xstyle!dime/widget/invoice/css/InvoiceDetailWidget.css'
], function ( WidgetsInTemplateMixin, TemplatedMixin,  EntityBoundWidget, declare,  template, request) {
    return declare("dime.widget.invoice.InvoiceDetailWidget", [EntityBoundWidget, TemplatedMixin, WidgetsInTemplateMixin], {

        templateString: template,
        baseClass: "invoiceDetailWidget",
        collection: 'invoices',
        baseConfig: {
            independant: true
        },
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
            projectNode: {
                widgetProperty: 'value',
                entityProperty: 'project',
                nullValue: 1,
                store: 'projects',
                idProperty: 'id',
                disabled: true
            },
            subtotalNode: {
                widgetProperty: 'value',
                entityProperty: 'subtotal',
                nullValue: '',
                disabled: true
            },
            totalVATNode: {
                widgetProperty: 'value',
                entityProperty: 'totalVAT',
                nullValue: '',
                disabled: true
            },
            totalDiscountsNode: {
                widgetProperty: 'value',
                entityProperty: 'totalDiscounts',
                nullValue: '',
                disabled: true
            },
            totalNode: {
                widgetProperty: 'value',
                entityProperty: 'total',
                nullValue: '',
                disabled: true
            },
            updateNode: {},
            itemsNode: {
                childWidgetType: 'dime/widget/invoice/InvoiceItemRowWidget',
                header: [ 'Typ', 'Anzahl', 'Ansatz', 'Einheit', 'Mwst.', 'Kosten' ],
                queryPrototype: {
                    invoice: 'id'
                },
                collection: 'invoiceitems',
                creatable: true,
                deleteable: true,
                parentprop: 'invoice'
            },
            discountsNode: {
                childWidgetType: 'dime/widget/timetrack/StandardDiscountRowWidget',
                widgetProperty: 'value',
                entityProperty: 'standardDiscounts',
                header: [ 'Name', 'Reduktion', 'Prozent', 'Wert' ],
                disabled: true,
                selectionBox: {
                    store: window.storeManager.adapt('standarddiscounts')
                },
                creatable: true,
                deleteable: true,
                parentprop: 'invoice'
            }
            //invoiceDiscountsNode: {
            //    childWidgetType: 'dime/widget/invoice/InvoiceDiscountRowWidget',
            //    header: [ 'Name', 'Reduktion', 'Prozent', 'Wert' ],
            //    widgetProperty: 'value',
            //    entityProperty: 'invoiceDiscounts',
            //    queryPrototype: {
            //        invoice: 'id'
            //    },
            //    creatable: true,
            //    deleteable: true,
            //    collection: 'invoicediscounts',
            //    parentprop: 'invoice'
            //}
        },
        callbacks:{
            updateNode:{
                callbackName: 'click',
                callbackFunction:function(){
                    var id = this.getParent().entity.id, parent = this.getParent();
                    request.get('/api/v1/invoices/'+id+'/update', {handleAs: 'json'}).then(function(data){
                        parent._updateView(data);
                    });
                }
            },
            printNode:{
                callbackName: 'click',
                callbackFunction: function(){
                    this.getParent().printInvoice();
                }
            }
        },

        printInvoice: function(){
            window.open('/api/v1/invoices/'+this.entity.id+'/print');
        }
    });
});
