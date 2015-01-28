define([
    'dojo/_base/declare'
], function (declare) {
    return declare(null, {



        //Todo Merge with Function from _base.js
        _resolvePrototype: function(prototype){
            var entity = this._getParentEntity();
            var result = {};
            for(var protoKey in prototype){
                if(prototype.hasOwnProperty(protoKey)) {
                    var protoVal = prototype[protoKey];
                    if (typeof protoVal === 'string') {
                        if (protoVal.indexOf(':') > -1) {
                            var ref = protoVal.split(':');
                            switch (ref[0]) {
                                case 'entityref':
                                    result[protoKey] = entity[ref[1]];
                                    break;
                                default:
                                    break;
                            }
                        } else {
                            result[protoKey] = prototype[protoKey];
                        }
                    } else {
                        result[protoKey] = prototype[protoKey];
                    }
                }
            }
            return result;
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



        _uploadEntity: function(entity){
            var table = this;
            var createable = table.createable, linkable = table.linkable, subentity = table.subentity;
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