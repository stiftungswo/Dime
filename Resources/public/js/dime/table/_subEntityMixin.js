define([
    'dojo/_base/declare'
], function (declare) {
    return declare(null, {

        entityProperty: null,

        collection: null,

        _setValueAttr: function(){
            this.inherited(arguments);
            var parent = this.getParent();
            this.set('collection', parent.get('collection'));
        },

        createRow: function(){
            //Todo make a Function in the Store that does the request against the Backend.
            this.collection.newSubEntity({ entityProperty: this.entityProperty });
        },

        deleteRow: function(rowId){
            var ids = this._getAllSubEntIds(), index = ids.indexOf(rowId);
            if(index >- 1){
                ids.splice(index, 1);
            }
            this._putSubEntitties(ids);
        },

        deleteRowByEntity: function(entity){
            this.deleteRow(entity.id);
        },

        _putSubEntitties: function(ids){
            var ParentID = this.getParent().get('entity').id, hash = {}, optionhash = {};
            hash[this.entityProperty] = ids;
            optionhash.id = ParentID;
            this.collection.put(hash, optionhash);
        },

        _getAllSubEntIds: function(){
            var ids = [];
            this.get('value').forEach(function(entity){
                ids.push(entity.id);
            });
            return ids;
        }
    });
});