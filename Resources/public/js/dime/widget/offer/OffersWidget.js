define([
    'dijit/_WidgetsInTemplateMixin',
    'dijit/_TemplatedMixin',
    'dime/widget/_Base',
    'dojo/_base/declare',
    'dime/widget/offer/OfferGrid',
    'dojo/text!dime/widget/offer/templates/OffersWidget.html',
    'dime/widget/offer/OfferWidget',
    'dijit/registry',
    'dijit/form/TextBox',
    'dijit/form/DateTextBox',
    'dijit/form/Textarea',
    'dijit/Dialog',
    'dijit/form/FilteringSelect',
    'dojo/when',
    'dojo/request',
    'dime/widget/project/ProjectDetailWidget'
], function ( WidgetsInTemplateMixin, TemplatedMixin,  _Base, declare,  OfferGrid, template,
              OfferWidget, registry, Textbox, DateTextBox, Textarea, Dialog,  FilteringSelect, when, request, ProjectDetailWidget) {
    return declare("dime.widget.offer.OfferWidget", [_Base, TemplatedMixin, WidgetsInTemplateMixin], {

        templateString: template,
        baseClass: "offersWidget",
        store: null,


        _setupChildren: function(){
            this.offerGridNode.store = this.store;
            this.editOfferNode.offersWidget = this;
            this.editOfferNode.offerGrid = this.offerGridNode;
            this.deleteOfferNode.offerGrid = this.offerGridNode;
            this.createprojectNode.offerGrid = this.offerGridNode;
        },

        _addcallbacks: function(){
            this.editOfferNode.on('click', function(){
                //this in the button
                for(var id in this.offerGrid.selection){
                    when(this.offersWidget.store.get(id)).then(function(item){
                        window.widgetManager.addTab(item, 'offers', OfferWidget, 'contentTabs', 'Offerte ('+item.id+')', true);
                        //window.widgetManager.add(entity, 'activities', ActivityWidget, parentWidget, activityContainer)
                    });
                }
            });
            this.deleteOfferNode.on('click', function(){
                //this in the button
                for(var id in this.offerGrid.selection){
                    when(window.storeManager.get('offers', true, false).remove(id));
                }
            });
            this.addOfferNode.on('click', function(){
                //this in the button
                window.storeManager.get('offers',true,false).add({name:'New Offer', accountant:1});
            });
            //Create Project from Offer
            this.createprojectNode.on('click', function(){
                for(var id in this.offerGrid.selection) {
                    request.get('/api/v1/projects/offer/' + id, {handleAs: 'json'}).then(function (data) {
                        window.widgetManager.addTab(data, 'projects', ProjectDetailWidget, 'contentTabs', 'Projekt (' + data.id + ')', true);
                    });
                }
            });
        },


        _fillValues: function(){
            var parentWidget = this, offerPositionsContainer = this.offerPositionsContainer;
            this.inherited(arguments);
        },

        _updateValues: function(entity){
        },

        _watchercallback: function(property, oldvalue, newvalue){
            if(oldvalue == "") return;
            //used because this points to caller not to THIS Widget. Above all elements were populated with parentwidget (THIS).
            var offerId = this.parentWidget.entity.id;
            var offerStore = this.parentWidget.store;
            var result;
            switch(this.dojoAttachPoint) {
                case "offerGridNode":
                    offerStore.put({name: newvalue}, {id: offerId} );
                    break;
                case "editOfferNode":
                    offerStore.put({customer: newvalue}, {id: offerId});
                    break;
                default:
                    break;
            }
            result.then(function(data){
                window.widgetManager.update(data, 'offers');
            });
        }
    });
});
