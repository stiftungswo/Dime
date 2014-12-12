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

        //Todo Add Complete Support for dependant Widgets.
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

        createable: false,

        linkable: false,

        subentity: false,

        //Make one Childwidget for every Entity found i either Value or queried from store
        _InitTable: function(){
            if(this.entity){
                this.value = this.entity;
                delete this.entity;
            }
            var header = this.header, row = domConstruct.create('tr'), thead = this.tableHead, base = this, entityType = this.entitytype;
            for(var count=0; count < header.length; count++){
                var td = domConstruct.create('td', {
                    innerHTML: header[count]
                }, row);
            }
            domConstruct.place(row, thead);
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
                this.selectEntNode.destroy();
            }
            if(! this.createable && !this.linkable && !this.subentity){
                this.addRowNode.destroy();
                this.delRowNode.destroy();
            }
            window.eventManager.subscribe('widgetCreate', entityType, base.id, function(arg){
                var widget = arg.widget, parent = widget.getParent();
                if(parent.id === base.id) {
                    window.widgetManager.add(widget.entity, entityType, 'dijit/form/CheckBox', widget)
                }
            });
        },

        _updateValues: function(value){
            var table = this, childWidgetType = this.childWidgetType, entitytype = this.entitytype, disabled = this.disabled, query = table.query, store = table.getStore();
            if(query && value == null){
                store.query(query).then(function(result){
                    table._updateValues(result);
                });
                return;
            }
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
            //Todo Clone Function via Select Checkbox.
            this.addRowNode.on('click', function(){
                var table = this.getParent();
                //if(table.getSelectedChildren()){
                //  table.cloneSelectedChildren();
                //} else {
                table.addNewChild();
                //}
            });

            this.delRowNode.on('click', function(){
                var table = this.getParent();
                table.removeSelectedChildren();
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

        addNewChild: function(prototype){
            var table = this, entity;
            prototype = prototype || table.prototype;
            var createable = table.createable, linkable = table.linkable, subentity = table.subentity;
            if(prototype) {
                entity = table._resolvePrototype(prototype);
            } else {
                //Todo Find better solution to get object of id, as dojo.when would require async programming
                entity = when(store.get(selectNode.get('value')), function(entity){return entity;})
            }
            if(createable){
                table.putEntity(entity, linkable);
            } else if(linkable) {
                table.linkEntity(entity);
            } else if(subentity){
                table.addEntityToParent(entity);
            } else {
                console.log('Table ' + table.id + ' does not know what to do, as neither creatable, linkable or subentity are true');
            }
        },

        getSelectedChildren: function(){
            var children = this.getChildren();
            var selectedchildren = [];
            for(var i=0; i<children.length; i++){
                var child = children[i];
                var childrenschildren = child.getChildren();
                for(var l=0; l<childrenschildren.length; l++){
                    var childChild = childrenschildren[l];
                    var childChildtype = this.ifget(childChild, 'type'), childChildValue = this.ifget(childChild, 'value');
                    if(childChildtype === 'checkbox' && childChildValue === 'on'){
                        selectedchildren.push(child);
                    }
                }
            }
            return selectedchildren;
        },

        ifget: function(widget, property){
            if(widget) {
                if (widget.get) {
                    return widget.get(property);
                }
            }
        },

        removeSelectedChildren: function(){
            var children = this.getSelectedChildren();
            var createable = this.createable, linkable = this.linkable, subentity = this.subentity;
            var table = this, parentEntity = table._getParentEntity();
            children.forEach(function(child){
                if(createable) {
                    child.cleanDestroy();
                } else if(linkable || subentity) {
                    table.unlinkEntity(child.entity, parentEntity);
                }
            });
        },

        cloneSelectedChildren: function(){

        },

        _getParentEntity: function(){
            var hasentity = false, entity;
            var parent = this.getParent();
            while(!hasentity){
                if(parent.entity){
                    entity = parent.entity;
                    hasentity = true;
                }
                parent = parent.getParent();
            }
            return entity;
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
        },

        putEntity: function(entity, link){
            link = link || false;
            var entityType = this.entitytype, store = this.getStore();
            store.put(entity).then(function(result){
                window.eventManager.fire('entityCreate', entityType, {
                    entity: result
                });
                if(link){
                    this.linkEntity(result);
                }
            });
        },

        linkEntity: function(entity, parent){
            var table = this;
            var parentStore = table.getParent().getStore();
            var parentEntityType = table.getParent().entitytype;
            var entityProperty = table.entityProperty;
            parent = parent || table._getParentEntity();
            var ids = [], oldids = [], hash = {}, entities = table.value;
            for(var i=0; i < entities.length ; i++){
                var subent = entities[i];
                ids.push(subent.id);
            }
            oldids = ids.slice(0);
            ids.push(entity.id);
            hash[entityProperty] = ids;
            parentStore.put(hash, {id: parent.id}).then(function(result){
                window.eventManager.fire('entityUpdate', parentEntityType, {
                    entity: result,
                    changedProperty: entityProperty,
                    oldValue: oldids,
                    newValue: ids,
                    fromStore: true
                });
            });
        },

        unlinkEntity: function(entity, parent){
            var table = this;
            var parentStore = table.getParent().getStore();
            var parentEntityType = table.getParent().entitytype;
            var entityProperty = table.entityProperty;
            parent = parent || table._getParentEntity();
            var ids = [], oldids = [], hash = {}, entities = table.value;
            for(var i=0; i < entities.length ; i++){
                var subent = entities[i];
                oldids.push(subent.id);
            }
            for(var l=0; l < entities.length ; l++){
                var subent2 = entities[l];
                if(subent2.id !== entity.id) {
                    ids.push(subent2.id);
                }
            }
            hash[entityProperty] = ids;
            parentStore.put(hash, {id: parent.id}).then(function(result){
                window.eventManager.fire('entityUpdate', parentEntityType, {
                    entity: result,
                    changedProperty: entityProperty,
                    oldValue: oldids,
                    newValue: ids,
                    fromStore: true
                });
            });
        },

        addEntityToParent: function(subEntity, parent){
            var table= this;
            parent = parent || table._getParentEntity();
            var parentStore = table.getParent().getStore();
            var parentEntityType = table.getParent().entitytype;
            var entityProperty = table.entityProperty;
            var entities = table.value;
            var oldentities = entities.slice(0);
            entities.push(subEntity);
            var hash = {};
            hash[entityProperty] = entities;
            parentStore.put(hash, {id: parent.id}).then(function(result) {
                window.eventManager.fire('entityUpdate', parentEntityType, {
                    entity: result,
                    changedProperty: entityProperty,
                    oldValue: oldentities,
                    newValue: entities,
                    fromStore: true
                });
            });
        }

    });
});