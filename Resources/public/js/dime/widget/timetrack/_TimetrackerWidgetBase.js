define([
    'dojo/_base/declare',
    'dijit/_WidgetBase',
    'dijit/Dialog'
], function (declare, WidgetBase, Dialog) {
    return declare('dime.widget.timetrack._TimetrackerWidgetBase', [WidgetBase], {
        //Inherited Default Functions
        postMixInProperties: function () {
            this.inherited(arguments);
        },

        buildRendering: function () {
            this.inherited(arguments);
            this._setupChildren();
        },

        postCreate: function () {
            this.inherited(arguments);
            this._fillValues();
        },

        startup: function () {
            this.inherited(arguments);
        },

        //The Entity the Widget Displays as Javascript Object
        entity: null,

        //The Store the Widget uses to Query for children
        store: null,

        //Array to store the Child Widgets
        children: [],

        //Refernce to the parent if exists
        parentWidget: null,

        //Functions for Setting up a Widget
        //Function for this Widget
        _updateValues: function(entity){},

        _fillValues: function(){
            this._updateValues(this.entity);
        },

        //Function for the Children Handling
        _updateChildren: function(results){
            results.forEach(function(entity){
                this._findChildWidget(entity.id)._updateValues(entity);
            });
        },
        _updateOneChildWidget: function(widget, entity){
            widget._updateValues(entity);
        },
        _updateHandler: function(object, removedFrom, insertedInto, type, container){
            var widget = this._findChildWidget(object.id);
            if (widget == null) {
                if (insertedInto > -1) { // new object inserted
                    this._addChildWidget(object, type, container);
                }
            }
            else{ //updated or deleted Object
                if (removedFrom > -1) { // existing object removed
                    this._removeChildWidget(widget);
                }
                else {
                    this._updateOneChildWidget(widget, object);
                }
            }
        },
        _addChildWidget: function(entity, type, container){
            var childwidget = new type({entity: entity, parentWidget: this});
            childwidget.placeAt(container);
            this.children.push(childwidget);
        },
        _removeChildWidget: function(widget){
            widget.destroy();
        },
        _findChildWidget: function(entityId){
            this.children.forEach(function(widget){
                if(widget.entity.id == entityId) return widget;
            });
            return null;
        },

        //Function for Setting up the Widgets Children with the correct Parents and Stores
        _setupChildren: function(){},


        //Callback fo a Child to destroy its Parent and the Entity Associated.
        _destroyParentHandler: function(){
            var store = this.parentWidget.store, parentWidget = this.parentWidget;
            store.remove(parentWidget.entity.id);
            parentWidget.destroy();
        },

        //Generic Callback for the watch function with a switch case on the Attach node of the Widget to determine the Action
        _watchValueHandler: function(property, oldvalue, newvalue){},

        //Functions for FormDialog Handling
        _requiredialogonce: function(formdomid, parent, title, href){
            var formDialog = registry.byId(formdomid);
            if (typeof formDialog  == 'undefined'){
                formDialog = new Dialog({
                    title: title,
                    href: href
                });
            }
            formDialog.set('parentWidget', parent);
            return formDialog;
        }
    })
});