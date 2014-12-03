define([
    'dojo/_base/declare',
    'dijit/_WidgetBase',
    'dojo/dom-construct',
    'dojo/when',
    'dijit/registry'
], function (declare, WidgetBase, domConstruct, when, registry) {
    return declare('dime.widget._ListBase', [WidgetBase], {
        //A List Widget Groups a Number of Child widgets into a List and handles their addition and removal
        postCreate: function () {
            this.inherited(arguments);
            if(this.doStartup){
                this.customStartup();
            }
        },
        //Todo Add Support for add and Delete Unidirectional and bidirectional

        //Todo Add Complete Support for dependant Widgets.

        //
        unidirectional: false,
        //Prevents Startup if false
        doStartup: true,
        //The Value we get set from out Parent
        value: null,
        //Tell the Logic to not watch value
        independant: false,
        //The Widget which we use as our child
        childWidgetType: '',
        //If Set make a Query to the store with this Prototype
        query: null,
        //The Titles to put into the Table Header
        header: null,
        //The Store to query if we do so
        store: '',
        //The Type of Entity this Table Handles
        entitytype: '',

        //Disable all Children?
        disabled: false,

        prototype: null,

        //Make one Childwidget for every Entity found i either Value or queried from store
        _InitTable: function(){
            if(this.entity){
                this.value = this.entity;
                delete this.entity;
            }
            var header = this.header, row = domConstruct.create('tr'), thead = this.tableHead, base = this;
            for(var count=0; count < header.length; count++){
                var td = domConstruct.create('td', {
                    innerHTML: header[count]
                }, row);
            }
            domConstruct.place(row, thead);
            this.addRowNode.set('getParent()', this);
            this.delRowNode.set('getParent()', this);
            this.selectEntNode.set('getParent()', this);
            if(this.selectable){
                for(var selectPropKey in this.selectable){
                    var selectProp = this.selectable[selectPropKey];
                    if (selectPropKey === 'store') {
                        if (typeof(selectProp == "String")) {
                            var mystore = window.storeManager.get(selectProp, false, true);
                        } else {
                            var mystore = selectProp;
                        }
                        this.selectEntNode.set(selectPropKey, mystore);
                    } else {
                        this.selectEntNode.set(selectPropKey, selectProp);
                    }

                }
            } else {
                this.selectEntNode.destroyRecursive();
            }
        },

        _updateValues: function(value){
            var table = this, childWidgetType = this.childWidgetType, entitytype = this.entitytype, disabled = this.disabled;
            this.value = value;
            var children = this.getChildWidgets();
            for (var i = 0; i < value.length; i++) {
                var entity = value[i];
                var child = this.getChildWidgetByEntity(entity);
                if(child){
                    if(child.independant === false) {
                        child.updateValues(entity);
                    }
                } else {
                    window.widgetManager.add(entity,entitytype, childWidgetType, table, disabled)
                }
            }
            for(var l =0; l < children.length; l++){
                var childwidget = children[l];
                var ent = this.getEntityByChildWidget(childwidget);
                if(!ent){
                    this.removeChildWidget(childwidget);
                }
            }
        },

        _addcallbacks: function(){
            //Function to add an entity in a List
            this.addRowNode.on('click', function(){
                var table = this.getParent(), prototype = table.prototype, selectNode = table.selectEntNode, store = table.getStore(), entityType = table.entitytype;
                var entity = table._getParentEntity(), entityProperty = table.entityProperty, initialobject, unidirectional = table.unidirectional;
                var parentStore = table.getParent().getStore();
                var parentEntityType = table.getParent().entitytype;
                if(prototype) {
                    initialobject = table._resolvePrototype(prototype);
                } else {
                    //Todo Find better solution to get object of id, as dojo.when would require async programming
                    initialobject = when(store.get(selectNode.get('value')), function(entity){return entity;})
                }
                if(!unidirectional){
                    store.put(initialobject).then(function(result){
                        window.eventManager.fire('entityCreate', entityType, {
                            entity: result
                        });
                    });
                    return;
                }
                var ids = [], oldids = [], hash = {}, entities = entity[entityProperty];
                for(var i=0; i < entities.length ; i++){
                    var subent = entities[i];
                    ids.push(subent.id);
                }
                oldids = ids.slice(0);
                ids.push(initialobject.id);
                hash[entityProperty] = ids;
                parentStore.put(hash, {id: entity.id}).then(function(result){
                    window.eventManager.fire('entityUpdate', parentEntityType, {
                        entity: result,
                        changedProperty: entityProperty,
                        oldValue: oldids,
                        newValue: ids,
                        fromStore: true
                    });
                });
            });

            this.delRowNode.on('click', function(){
                //Take Selection

                //Take parent and Update Relation
                //Fire EntityUpdate on sucess

                //If not Unidirectional use entity CleanDestroy

                //Else use destroyWidget

            });

        },

        _startEventListeners: function(){

        },

        getStore: function(){
            var store = this.store;
            if(typeof(store) == "String"){
                return window.storeManager.get(store, false, true);
            }
            return store;
        },

        _getParentEntity: function(){
            return this.getParent().entity;
        },

        _resolvePrototype: function(prototype){
            var entity = this._getParentEntity();
            for(var protoKey in prototype){
                var protoVal = prototype[protoKey];
                if(typeof protoVal === 'string'){
                    if(protoVal.indexOf(':') > -1){
                        var ref = protoVal.split(':');
                        switch(ref[0]){
                            case 'entityref':
                                prototype[protoKey] = entity[ref[1]];
                                break;
                            default:
                                break;
                        }
                    }
                }
            }
            return prototype;
        },

        customStartup: function(){
            this._InitTable();
            this._addcallbacks();
            this._startEventListeners();
        },

        //Function to disable all Childwidgets
        _disable: function(){
            var disabled = this.disabled;
            this.children.forEach(function(child){
                child.set('disabled', disabled);
            });
        },

        getChildWidgetByEntity: function(entity){
            var children = this.getChildWidgets();
            for(var i=0; i < children.length; i++){
                var child = children[i];
                if(child.entity.id === entity.id){
                    return child;
                }
            }
            return null;
        },

        getEntityByChildWidget: function(widget){
            var values = this.value;
            for(var i=0; i < values.length; i++){
                var value = values[i];
                if(widget.entity.id === value.id){
                    return value;
                }
            }
            return null;
        },

        getChildWidgets: function(){
            return this.containerNode ? registry.findWidgets(this.containerNode) : []; // dijit/_WidgetBase[]
        }

    });
});