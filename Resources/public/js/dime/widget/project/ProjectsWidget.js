/**
 * Created by Till Wegmüller on 11/13/14.
 */
define([
    'dijit/_WidgetsInTemplateMixin',
    'dijit/_TemplatedMixin',
    'dime/widget/_Base',
    'dojo/_base/declare',
    'dojo/text!dime/widget/project/templates/ProjectsWidget.html',
    'dojo/when',
    'dojo/request',
    'dime/widget/project/ProjectGrid',
    'dijit/form/Button'
], function ( WidgetsInTemplateMixin, TemplatedMixin,  _Base, declare, template, when, request){
    return declare("dime.widget.project.ProjectsWidget", [_Base, TemplatedMixin, WidgetsInTemplateMixin], {

        templateString: template,
        baseClass: "projectsWidget",
        store: 'projects',
        config: {
            values: {
                GridNode:{
                    store: 'projects'
                },
                editNode: {},
                addNode: {},
                invoiceNode: {}
            },
            callbacks:{
                editNode:{
                    callbackName: 'click',
                    callbackFunction: function(){
                        //this in the button
                        for(var id in this.getParent().GridNode.selection){
                            when(this.getParent().getStore().get(id)).then(function(item){
                                window.widgetManager.addTab(item, 'projects', 'dime/widget/project/ProjectDetailWidget', 'contentTabs', 'Projekt ('+item.id+')', true);
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
                        //this.getParent().getStore().add({ name:'New Project', alias:'new'});
                        app.newEntity('projects');
                    }
                },
                invoiceNode: {
                    callbackName: 'click',
                    callbackFunction: function(){
                        for(var id in this.getParent().GridNode.selection) {
                            request('/api/v1/invoices/project/' + id, {handleAs: "json"}).then(function(entity){
                                window.widgetManager.addTab(entity, 'invoices', 'dime/widget/invoice/InvoiceDetailWidget', 'contentTabs', 'Rechnung ('+entity.id+')', true);
                            });
                        }
                    }
                }
            },
            events: {
                //Called after an entity has been sucessfully posted
                storeCreateNotify: {
                    //Which Topic to subscribe to.
                    Topic: 'entityCreate',
                    //Which subtopic to subscribe to
                    subTopic: 'projects',
                    //The Function to execute should event be fired.
                    eventFunction: 'storeCreateNotify'
                    //arg contains the Following Properties
                    //entity: The created Entity
                }
            }
        },

        storeCreateNotify: function(args){
            this.GridNode.store.notify(args.entity);
        }
    });
});

