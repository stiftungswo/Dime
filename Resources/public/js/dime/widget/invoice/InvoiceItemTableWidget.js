define([
    'dijit/_WidgetsInTemplateMixin',
    'dijit/_TemplatedMixin',
    'dime/widget/_Base',
    'dojo/_base/declare',
    'dojo/text!dime/widget/invoice/templates/InvoiceItemTableWidget.html',
    'dime/widget/invoice/InvoiceItemTableRowWidget'
], function (WidgetsInTemplateMixin, TemplatedMixin,  _Base, declare,  template, InvoiceItemTableRowWidget) {
    return declare("dime.widget.invoice.InvoiceItemTableWidget", [_Base, TemplatedMixin, WidgetsInTemplateMixin], {
        templateString: template,
        baseClass: "invoiceItemTableWidget",
        items: [],

        _setupChildren: function(){

        },

        _addcallbacks: function(){

        },

        _updateValues: function(items){
            this.items = items;
            for(var i=0; i < this.items.length; i++) {
                var item = this.items[i];
                window.widgetManager.update(item, 'invoiceitems');
            }
        },

        _fillValues: function(){
            for(var i=0; i < this.items.length; i++){
                var item = this.items[i];
                window.widgetManager.add(item, 'invoiceitems', InvoiceItemTableRowWidget, this, this.tableBody);
            }
        }
    });
});
