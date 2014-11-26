/**
 * Created by Till Wegmüller on 11/13/14.
 */
define([
    'dijit/_WidgetsInTemplateMixin',
    'dijit/_TemplatedMixin',
    'dime/widget/_Base',
    'dojo/_base/declare',
    'dojo/text!dime/widget/invoice/templates/InvoicesWidget.html',
    'dime/widget/invoice/InvoiceDetailWidget',
    'dojo/when',
    'dime/widget/invoice/InvoiceGrid',
    'dijit/form/Button'
], function ( WidgetsInTemplateMixin, TemplatedMixin,  _Base, declare, template, InvoiceDetailWidget, when) {
    return declare("dime.widget.invoice.InvoicesWidget", [_Base, TemplatedMixin, WidgetsInTemplateMixin], {

        templateString: template,
        baseClass: "invoicesWidget",
        store: window.storeManager.get('invoices',false, true),


        _setupChildren: function(){
            this.GridNode.set('parentWidget', this);
            this.GridNode.set('store', this.store);
            this.editNode.set('parentWidget', this);
        },

        _addcallbacks: function(){
            this.editNode.on('click', function(){
                //this in the button
                for(var id in this.parentWidget.GridNode.selection){
                    when(this.parentWidget.store.get(id)).then(function(item){
                        window.widgetManager.addTab(item, 'invoices', InvoiceDetailWidget, 'contentTabs', 'Rechnung ('+item.id+')', true);
                    });
                }
            });
        }
    });
});

