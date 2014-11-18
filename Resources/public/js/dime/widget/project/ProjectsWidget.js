/**
 * Created by Till Wegmüller on 11/13/14.
 */
define([
    'dijit/_WidgetsInTemplateMixin',
    'dijit/_TemplatedMixin',
    'dime/widget/_Base',
    'dojo/_base/declare',
    'dojo/text!dime/widget/project/templates/ProjectsWidget.html',
    'dime/widget/project/ProjectDetailWidget',
    'dojo/when',
    'dime/widget/project/ProjectGrid',
    'dijit/form/Button'
], function ( WidgetsInTemplateMixin, TemplatedMixin,  _Base, declare, template, ProjectDetailWidget, when) {
    return declare("dime.widget.project.ProjectsWidget", [_Base, TemplatedMixin, WidgetsInTemplateMixin], {

        templateString: template,
        baseClass: "projectsWidget",
        store: window.storeManager.get('projects',false, true),


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
                        window.widgetManager.addTab(item, 'projects', ProjectDetailWidget, 'contentTabs', 'Projekt ('+item.id+')', true);
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
                this.parentWidget.store.add({ name:'New Project', alias:'new'});
            });
        }
    });
});

