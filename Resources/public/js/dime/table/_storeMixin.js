define([
    'dojo/_base/declare'
], function (declare) {
    return declare(null, {

        collection: null,

        queryPrototype: null,

        query: {},

        _started: false,

        createRow: function(){
            this.collection.newEntity({ query: this.query });
        },

        deleteRow: function(rowId){
            this.collection.remove(rowId);
        },

        deleteRowByEntity: function(entity){
            this.collection.remove(entity.id);
        },

        _setCollectionAttr: function(collection){
            if(this.query){
                this.collection = collection.filter(this.query);
            } else {
                this.collection = collection;
            }
            var table = this;
            this.collection.on('add', function(event){
                table._addChildWidget(event.target);
            });
            this.collection.on('delete', function(event){
                if(event.target) {
                    table._removeChildByEntity(event.target);
                } else if(event.id){
                    table._removeChildByEntityId(event.id);
                }
            });
            this._updateView();
        },

        _setQueryAttr: function(query) {
            this.query = query;
            if(this.collection){
                this.set('collection', this.get('collection'));
            }
        },

        _setQueryPrototypeAttr: function(queryPrototype) {
            this.queryPrototype = queryPrototype;
            this.set('query', this._renderQuery(queryPrototype));
        },

        _renderQuery: function(queryPrototype){
            var parent = this.getParent(), query = {};
            var entity = parent.entity;
            for(var propKey in queryPrototype){
                if(queryPrototype.hasOwnProperty(propKey)) {
                    var prop = queryPrototype[propKey];
                    query[propKey] = entity[prop];
                }
            }
            return query;
        },

        _updateView: function(){
            var table = this;
            this.getChildWidgets().forEach(function(child){
                this.removeChild(child);
                child.destroyRecursive();
            });
            this.collection.forEach(function(entity){
                table._addChildWidget(entity);
            });
        }

    });
});