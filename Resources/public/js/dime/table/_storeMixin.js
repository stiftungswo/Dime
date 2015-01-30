define([
    'dojo/_base/declare'
], function (declare) {
    return declare(null, {

        collection: null,

        queryPrototype: null,

        query: {},

        _started: false,

        blockUpdate: false,

        startup: function(){
            if(!this.blockUpdate) {
                this._updateView();
            }
        },

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
            this.collection = collection;
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
        },

        _setQueryPrototypeAttr: function(queryPrototype) {
            this.queryPrototype = queryPrototype;
            this.set('query', this._renderQuery(queryPrototype));
        },

        _renderQuery: function(queryPrototype){
            var query = {};
            var parentEntity = this.get('parentEntity');
            for(var propKey in queryPrototype){
                if(queryPrototype.hasOwnProperty(propKey)) {
                    var prop = queryPrototype[propKey];
                    query[propKey] = parentEntity[prop];
                }
            }
            return query;
        },

        _updateView: function(){
            var table = this;
            var collection;
            if(this.query){
                collection = this.collection.filter(this.query);
            } else {
                collection = this.collection;
            }
            this.getChildWidgets().forEach(function(child){
                table.removeChild(child);
                child.destroyRecursive();
            });
            collection.forEach(function(entity){
                table._addChildWidget(entity);
            });
        }

    });
});