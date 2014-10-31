define([
    'dojo/_base/declare',
    'dijit/_WidgetBase',
    'dijit/registry'
], function (declare, WidgetBase, registry) {
    return declare('dime.widget.timetrack._TimetrackerWidgetBase', [WidgetBase], {
        //Inherited Default Functions
        postCreate: function () {
            this.inherited(arguments);
            this._setupChildren();
            this._fillValues();
            this._addcallbacks();
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
        _updateChildren: function(results, parent){
            results.forEach(function(entity){
                parent._findChildWidget(entity.id)._updateValues(entity);
            });
        },
        _updateOneChildWidget: function(widget, entity){
            widget._updateValues(entity);
        },
        _updateHandler: function(object, removedFrom, insertedInto, type, container, parent){
            var widget = this._findChildWidget(object.id, parent);
            if (widget == null) {
                if (insertedInto > -1) { // new object inserted
                    this._addChildWidget(object, type, container, parent);
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
        _addChildWidget: function(entity, type, container, parent){
            var childwidget = new type({entity: entity, parentWidget: parent});
            childwidget.placeAt(container);
            parent.children.push(childwidget);
        },
        _removeChildWidget: function(widget){
            widget.destroy();
        },
        _findChildWidget: function(entityId, parent){
            parent.children.forEach(function(widget){
                if(widget.entity.id == entityId) return widget;
            });
            return null;
        },

        //Function for Setting up the Widgets Children with the correct Parents and Stores
        _setupChildren: function(){},
        _addcallbacks: function(){},

        //Callback fo a Child to destroy its Parent and the Entity Associated.
        _destroyParentHandler: function(){
            var store = this.parentWidget.store, parentWidget = this.parentWidget;
            store.remove(parentWidget.entity.id);
            parentWidget.destroy();
        },

        //Generic Callback for the watch function with a switch case on the Attach node of the Widget to determine the Action
        _watchValueHandler: function(property, oldvalue, newvalue){}
    })
});