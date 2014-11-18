define([
    'dojo/_base/declare',
    'dijit/_WidgetBase',
    'dijit/registry',
], function (declare, WidgetBase, registry) {
    return declare('dime.widget._Base', [WidgetBase], {
        //Inherited Default Functions
        postCreate: function () {
            this.inherited(arguments);
            this._setupChildren();
            this._fillValues();
            this._addcallbacks();
            this.watch('disabled', this._disable);
        },

        //The Entity the Widget Displays as Javascript Object
        entity: null,

        //The Store the Widget uses to Query for children
        store: null,

        //Array to store the Child Widgets
        children: [],

        //Refernce to the parent if exists
        parentWidget: null,

        //For WicTypes of Entity do i Want to Listen?
        childtypes: [],

        //Functions for Setting up a Widget

        //Called to update the Rendering overwirte in children
        _updateValues: function(entity){
            this.entity = entity;
        },

        //Called to Fill all Values from the Entity
        _fillValues: function(){
            this._updateValues(this.entity);
        },

        //Called By the widgetManager to tell the Widget to make a new Childwidget based on the Entity
        _addChild: function(entity, entitytype){
            for(var i=0; i < this.childtypes.length; i++){
                var childtype = this.childtypes[i];
                if(childtype == entitytype){
                    this._handleaddChild(entity, entitytype);
                }
            }
        },

        //Function to overwrite by the Widget
        _handleaddChild: function(entity, entitytype){

        },

        //Function for Setting up the Widgets Children with the correct Parents and Stores
        //Overwrite and set stores and parent refernces here
        _setupChildren: function(){},

        //Overwrite and Setup Callbacks Here
        _addcallbacks: function(){},

        _disable: function(){
            var base = this;
            this._attachPoints.forEach(function(node){
                var attachPoint = base[node];
                    attachPoint.set('disabled',true);
            });
        },

        //Function to Destroy the Widget and its entity in the Remote Store.
        cleandestroy: function(){
            if(this.store && this.entity){
                this.store.remove(this.entity.id);
                this.destroy();
            }
        },

        _destroyParentHandler: function(){
            this.parentWidget.cleandestroy();
        },

        //Generic Callback for the watch function with a switch case on the Attach node of the Widget to determine the Action
        _watchValueHandler: function(property, oldvalue, newvalue){}
    })
});