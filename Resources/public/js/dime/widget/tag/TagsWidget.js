/**
 * Created by Till Wegmüller on 11/13/14.
 */
define([
    'dijit/_WidgetsInTemplateMixin',
    'dijit/_TemplatedMixin',
    'dime/widget/_Base',
    'dojo/_base/declare',
    'dojo/text!dime/widget/tag/templates/TagsWidget.html',
    'dime/widget/tag/TagGrid',
    'dijit/form/Button'
], function ( WidgetsInTemplateMixin, TemplatedMixin,  _Base, declare, template) {
    return declare("dime.widget.tag.TagsWidget", [_Base, TemplatedMixin, WidgetsInTemplateMixin], {

        templateString: template,
        baseClass: "tagsWidget",
        store: 'tags',
        config: {
            values: {
                GridNode:{
                    store: 'tags'
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
                        this.getParent().getStore().add({ name:'NewTag'});
                    }
                }
            }
        }
    });
});