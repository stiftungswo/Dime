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
], function ( WidgetsInTemplateMixin, TemplatedMixin,  _Base, declare,  OfferGrid, template,
              OfferWidget, registry, Textbox, DateTextBox, Textarea, Dialog,  FilteringSelect, when) {
    return declare("dime.widget.offer.OfferWidget", [_Base, TemplatedMixin, WidgetsInTemplateMixin], {

        templateString: template,
        baseClass: "offersWidget",
        store: null,


        _setupChildren: function(){
            this.offerGridNode.store = this.store;
            this.editButtonNode.offersWidget = this;
            this.editButtonNode.offerGrid = this.offerGridNode;

        },

        _addcallbacks: function(){
            this.editButtonNode.on('click', function(){
                //this in the button
                for(var id in this.offerGrid.selection){
                    when(this.offersWidget.store.get(id)).then(function(item){
                        console.log(item);
                        window.widgetManager.addTab(item, 'offers', OfferWidget, 'contentTabs', 'Offerte ('+item.id+')', true);
                        //window.widgetManager.add(entity, 'activities', ActivityWidget, parentWidget, activityContainer)
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
                case "editButtonNode":
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
