/**
 * Created by Till Wegmüller on 11/13/14.
 */
define([
    'dijit/_WidgetsInTemplateMixin',
    'dijit/_TemplatedMixin',
    'dime/widget/_Base',
    'dojo/_base/declare',
    'dojo/text!dime/widget/invoice/templates/InvoicesWidget.html',
    'dojo/when',
    'dime/widget/invoice/InvoiceGrid',
    'dijit/form/Button'
], function ( WidgetsInTemplateMixin, TemplatedMixin,  _Base, declare, template, when) {
    return declare("dime.widget.invoice.InvoicesWidget", [_Base, TemplatedMixin, WidgetsInTemplateMixin], {

        templateString: template,
        baseClass: "invoicesWidget",
        store: 'invoices',
        config: {
            values: {
                GridNode:{
                    store: 'invoices'
                },
                editNode: {}
            },
            callbacks:{
                editNode:{
                    callbackName: 'click',
                    callbackFunction: function(){
                        //this in the button
                        for(var id in this.getParent().GridNode.selection){
                            when(this.getParent().getStore().get(id)).then(function(item){
                                window.widgetManager.addTab(item, 'invoices', 'dime/widget/invoice/InvoiceDetailWidget', 'contentTabs', 'Rechnung ('+item.id+')', true);
                            });
                        }
                    }
                }
            }
        }
    });
});

