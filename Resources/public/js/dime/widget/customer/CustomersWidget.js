/**
 * Created by Till Wegmüller on 11/13/14.
 */
define([
    'dijit/_WidgetsInTemplateMixin',
    'dijit/_TemplatedMixin',
    'dime/widget/_Base',
    'dojo/_base/declare',
    'dojo/text!dime/widget/customer/templates/CustomersWidget.html',
    'dojo/when',
    'dime/widget/customer/CustomerGrid',
    'dijit/form/Button'
], function ( WidgetsInTemplateMixin, TemplatedMixin,  _Base, declare, template, when) {
    return declare("dime.widget.customer.CustomersWidget", [_Base, TemplatedMixin, WidgetsInTemplateMixin], {

        templateString: template,
        baseClass: "customersWidget",
        store: 'customers',
        config: {
            values: {
                GridNode:{
                    collection: window.storeManager.get('customers')
                },
                editNode: {},
                addNode: {},
                deleteNode: {}
            },
            callbacks:{
                editNode:{
                    callbackName: 'click',
                    callbackFunction: function(){
                        //this in the button
                        for(var id in this.getParent().GridNode.selection){
                            when(this.getParent().getStore().get(id)).then(function(item){
                                window.widgetManager.addTab(item, 'customers', 'dime/widget/customer/CustomerDetailWidget', 'contentTabs', 'Kunde ('+item.id+')', true);
                            });
                        }
                    }
                },
                deleteNode:{
                    callbackName: 'click',
                    callbackFunction: function(){
                        //this in the button
                        for(var id in this.getParent().GridNode.selection){
                            this.getParent().getStore().remove(id);
                        }
                    }
                },
                addNode: {
                    callbackName: 'click',
                    callbackFunction: function(){
                        //this in the button
                        //this.getParent().getStore().add({ name:'New Customer', alias:'newcust'});
                        app.newEntity('customers');
                    }
                }
            },
            events: {
                //Called after an entity has been sucessfully posted
                storeCreateNotify: {
                    //Which Topic to subscribe to.
                    Topic: 'entityCreate',
                    //Which subtopic to subscribe to
                    subTopic: 'customers',
                    //The Function to execute should event be fired.
                    eventFunction: 'storeCreateNotify'
                    //arg contains the Following Properties
                    //entity: The created Entity
                }
            }
        },

        storeCreateNotify: function(args){
            this.GridNode.collection.emit('add', args.entity);
        }
    });
});

