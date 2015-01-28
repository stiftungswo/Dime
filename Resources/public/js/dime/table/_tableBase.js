define([
    'dojo/_base/declare',
    'dijit/_WidgetBase',
    'dojo/dom-construct',
    'dijit/registry',
    'dijit/_Container'
], function (declare, WidgetBase, domConstruct, registry, Container) {
    return declare('dime.table._tableBase', [WidgetBase, Container], {

        postCreate: function () {
            this.inherited(arguments);
        },

        buildRendering: function(){
            this.inherited(arguments);
        },

        header: null,

        value: null,

        childWidgetType: null,

        selection: [],

        getChildWidgets: function(){
            return this.containerNode ? registry.findWidgets(this.containerNode) : []; // dijit/_WidgetBase[]
        },

        getChildByEntity: function(entity){
            var children = this.getChildWidgets();
            for(var i=0; i<children.length; i++){
                var child = children[i];
                if(child.entity.id === entity.id) return child;
            }
            return null;
        },

        getChildByEntityId: function(Id){
            var children = this.getChildWidgets();
            for(var i=0; i<children.length; i++){
                var child = children[i];
                if(child.entity.id === Id) return child;
            }
            return null;
        },

        createRow: function(){
            /*
            Function to Tell the Table to create a Row with associated Entity
             _AddChildWidget takes the Role of adding the Rendering Component.
            */
            // Disabled, As the Base Table is only capable of Rendering.
            // A Store or SlaveTable Mixin is Requiered for Add Functionality
        },

        deleteRow: function(rowId){
            /*======
            Delete A Row based on its Position in the Table
            Return True if sucess false otherwise
            Todo Make sure to match Entity.id and row.id
             */
            var children = this.getChildWidgets();
            var child = children[rowId];
            if(child){
                this.removeChild(child);
                child.destroyRecursive();
                return true;
            }
            return false;
        },

        deleteRowByEntity: function(entity){
            /*======
            Delete a Row based on the Entity given
            Return True if sucess false otherwise
             */
            var child = this.getChildByEntity(entity);
            if(child){
                child.destroyRecursive();
                return true;
            }
            return false;
        },

        deleteRows: function(selection){
            selection = selection || this.get('selection');
            var table = this;
            selection.forEach(function(id){
                table.deleteRow(id);
            });
        },

        _setHeaderAttr: function(header){
            this.header = header;
            this._renderHeader(header);
        },

        _setValueAttr: function(value){
            this.value = value;
            this._updateView(value);
        },

        _addChildWidget: function(entity){
            window.widgetManager.add(entity, this.childWidgetType, this, this.disabled);
        },

        _renderHeader: function(header){
            var row = domConstruct.create('tr'), thead = this.tableHeadNode;
            for(var count=0; count < header.length; count++){
                var td = domConstruct.create('td', {
                    innerHTML: header[count]
                }, row);
            }
            if(thead.innerHTML){
                domConstruct.empty(thead);
            }
            domConstruct.place(row, thead);
        },

        _updateView: function(value){
            var table = this;
            var children = this.getChildWidgets();
            children.forEach(function(child){
                table.removeChild(child);
                child.destroyRecursive();
            });
            value.forEach(function(entity){
                table._addChildWidget(entity);
            });
        }

    });
});