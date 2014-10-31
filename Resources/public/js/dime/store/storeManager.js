define([
    'dojo/_base/declare',
    'dime/store/dStore',
    'dstore/legacy/DstoreAdapter'
], function (declare, dStore, DstoreAdapter) {
    return declare('dime.store.storeManager', [], {
        stores: {},
        get: function(entity, legacy, trailingslash){
            if(trailingslash) entity = entity+'/';
            //Search if store is already defined
            var store;
            if(this._hasstore(entity)){
                store = this.stores[entity]
            }
            else {
                store = new dStore({entity: entity})
                this.stores[entity] = store;
            }
            if(legacy) store = this._makelegacy(store);
            return store;
        },

        _makelegacy: function(store){
            return new DstoreAdapter(store);
        },

        _hasstore: function(entity){
            for (var key in this.stores) {
                if(key == entity)return true;
            }
        }
    })
});