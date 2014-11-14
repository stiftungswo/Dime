/**
 * Created by Till Wegmüller on 11/13/14.
 */
define([
    'dijit/_WidgetsInTemplateMixin',
    'dijit/_TemplatedMixin',
    'dime/widget/_Base',
    'dojo/_base/declare',
    'dojo/text!dime/widget/tag/templates/TagsWidget.html',
    'dojo/when',
    'dime/widget/tag/TagGrid',
    'dijit/form/Button'
], function ( WidgetsInTemplateMixin, TemplatedMixin,  _Base, declare, template, when) {
    return declare("dime.widget.tag.TagsWidget", [_Base, TemplatedMixin, WidgetsInTemplateMixin], {

        templateString: template,
        baseClass: "tagsWidget",
        store: window.storeManager.get('tags',false, true),


        _setupChildren: function(){
            this.GridNode.set('parentWidget', this);
            this.deleteNode.set('parentWidget', this);
            this.addNode.set('parentWidget', this);

        },

        _addcallbacks: function(){
            this.deleteNode.on('click', function(){
                //this in the button
                for(var id in this.parentWidget.GridNode.selection){
                    when(this.parentWidget.store.remove(id));
                }
            });
            this.addNode.on('click', function(){
                //this in the button
                this.parentWidget.store.add({ name:'NewTag'});
            });
        }
    });
});

