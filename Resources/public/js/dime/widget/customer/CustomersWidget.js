/**
 * Created by Till Wegmüller on 11/13/14.
 */
define([
    'dijit/_WidgetsInTemplateMixin',
    'dijit/_TemplatedMixin',
    'dime/widget/_Base',
    'dojo/_base/declare',
    'dojo/text!dime/widget/customer/templates/CustomersWidget.html',
    'dime/widget/customer/CustomerDetailWidget',
    'dojo/when',
    'dime/widget/customer/CustomerGrid',
    'dijit/form/Button'
], function ( WidgetsInTemplateMixin, TemplatedMixin,  _Base, declare, template, CustomerDetailWidget, when) {
    return declare("dime.widget.customer.CustomersWidget", [_Base, TemplatedMixin, WidgetsInTemplateMixin], {

        templateString: template,
        baseClass: "customersWidget",
        store: window.storeManager.get('customers',false, true),


        _setupChildren: function(){
            this.GridNode.set('parentWidget', this);
            this.GridNode.set('store', this.store);
            this.editNode.set('parentWidget', this);
            this.deleteNode.set('parentWidget', this);
            this.addNode.set('parentWidget', this);

        },

        _addcallbacks: function(){
            this.editNode.on('click', function(){
                //this in the button
                for(var id in this.parentWidget.GridNode.selection){
                    when(this.parentWidget.store.get(id)).then(function(item){
                        window.widgetManager.addTab(item, 'customers', CustomerDetailWidget, 'contentTabs', 'Kunde ('+item.id+')', true);
                    });
                }
            });
            this.deleteNode.on('click', function(){
                //this in the button
                for(var id in this.parentWidget.GridNode.selection){
                    this.parentWidget.store.remove(id);
                }
            });
            this.addNode.on('click', function(){
                //this in the button
                this.parentWidget.store.add({ name:'New Customer', alias:'new'});
            });
        }
    });
});

