/**
 * Created by Till Wegmüller on 11/13/14.
 */
define([
    'dijit/_WidgetsInTemplateMixin',
    'dijit/_TemplatedMixin',
    'dime/widget/_Base',
    'dojo/_base/declare',
    'dojo/text!dime/widget/service/templates/ServicesWidget.html',
    'dime/widget/service/ServiceDetailWidget',
    'dojo/when',
    'dime/widget/service/ServiceGrid',
    'dijit/form/Button'
], function ( WidgetsInTemplateMixin, TemplatedMixin,  _Base, declare, template, ServiceDetailWidget, when) {
    return declare("dime.widget.service.ServicesWidget", [_Base, TemplatedMixin, WidgetsInTemplateMixin], {

        templateString: template,
        baseClass: "servicesWidget",
        store: window.storeManager.get('services',false, true),


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
                        window.widgetManager.addTab(item, 'services', ServiceDetailWidget, 'contentTabs', 'Service ('+item.id+')', true);
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
                this.parentWidget.store.add({ name:'New Service', alias:'new'});
            });
        }
    });
});

