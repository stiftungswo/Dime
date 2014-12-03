define([
    'dijit/_WidgetsInTemplateMixin',
    'dijit/_TemplatedMixin',
    'dime/widget/_Base',
    'dojo/_base/declare',
    'dojo/text!dime/widget/offer/templates/OffersWidget.html',
    'dojo/when',
    'dojo/request',
    'dijit/registry',
    'dime/widget/offer/OfferDetailWidget',
    'dime/widget/offer/OfferGrid',
    'dijit/form/TextBox',
    'dijit/form/DateTextBox',
    'dijit/form/Textarea',
    'dijit/Dialog',
    'dijit/form/FilteringSelect'
], function ( WidgetsInTemplateMixin, TemplatedMixin,  _Base, declare, template, when, request) {
    return declare("dime.widget.offer.OffersWidget", [_Base, TemplatedMixin, WidgetsInTemplateMixin], {

        templateString: template,
        baseClass: "offersWidget",
        store: 'offers',
        config: {
            values: {
                GridNode: {
                    store: 'offers'
                },
                addNode: {},
                editNode: {},
                deleteNode: {},
                projectNode: {}
            },
            callbacks: {
                editNode:{
                    callbackName: 'click',
                    callbackFunction: function(){
                        for(var id in this.getParent().GridNode.selection){
                            when(this.getParent().getStore().get(id)).then(function(item){
                                window.widgetManager.addTab(item, 'offers', 'dime/widget/offer/OfferDetailWidget', 'contentTabs', 'Offerte ('+item.id+')', true);
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
                        this.getParent().getStore().add({name:'New Offer', accountant:1});
                    }
                },
                projectNode: {
                    callbackName: 'click',
                    callbackFunction: function() {
                        for (var id in this.getParent().GridNode.selection) {
                            request.get('/api/v1/projects/offer/' + id, {handleAs: 'json'}).then(function (data) {
                                window.widgetManager.addTab(data, 'projects', 'dime/widget/project/ProjectDetailWidget', 'contentTabs', 'Projekt (' + data.id + ')', true);
                            });
                        }
                    }
                }
            }
        }
    });
});
