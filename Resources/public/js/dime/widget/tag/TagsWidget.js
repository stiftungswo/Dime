/**
 * Created by Till Wegmüller on 11/13/14.
 */
define([
    'dijit/_WidgetsInTemplateMixin',
    'dijit/_TemplatedMixin',
    'dime/common/EntityBoundWidget',
    'dojo/_base/declare',
    'dojo/text!dime/widget/tag/templates/TagsWidget.html',
    'dime/widget/tag/TagGrid',
    'dijit/form/Button'
], function ( WidgetsInTemplateMixin, TemplatedMixin,  EntityBoundWidget, declare, template) {
    return declare("dime.widget.tag.TagsWidget", [EntityBoundWidget, TemplatedMixin, WidgetsInTemplateMixin], {

        templateString: template,
        baseClass: "tagsWidget",
        store: 'tags',
        config: {
            values: {
                GridNode:{
                    collection: window.storeManager.get('tags')
                },
                addNode: {},
                deleteNode: {}
            },
            callbacks:{
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
                        //this.getParent().getStore().add({ name:'NewTag'});
                        app.newEntity('tags');
                    }
                }
            },
            events: {
                //Called after an entity has been sucessfully posted
                storeCreateNotify: {
                    //Which Topic to subscribe to.
                    Topic: 'entityCreate',
                    //Which subtopic to subscribe to
                    subTopic: 'tags',
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