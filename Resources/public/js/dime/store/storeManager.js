define([
    'dojo/_base/declare',
    'dime/store/dStore',
    'dstore/legacy/DstoreAdapter',
    'dojo/store/JsonRest',
    'dojo/store/Memory',
    'dojo/store/Observable',
    'dojo/store/Cache'
], function (declare, dStore, DstoreAdapter, JsonRest, Memory, Observable, Cache) {
    return declare('dime.store.storeManager', [], {
        stores: {},
        get: function(entity, compat, legacy){
            //Search if store is already defined
            var store;
            if(this._hasstore(entity)){
                store = this.stores[entity]
            }
            else {
                if(legacy) {
                    store = this._makelegacy(entity);
                }
                else{
                    store = new dStore({entity: entity});
                }
                this.stores[entity] = store;
            }
            if(compat) store = this._compat(store);
            return store;
        },

        make: function(entity, compat, legacy){
            //Search if store is already defined
            var store;
            if(legacy) {
                store = this._makelegacy(entity);
            }
            else{
                store = new dStore({entity: entity});
            }
            this.stores[entity] = store;
            if(compat) store = this._compat(store);
            return store;
        },

        _compat: function(store){
            return new DstoreAdapter(store);
        },

        _makelegacy: function(entity){
            var target = '/api/v1/'+entity;
            return new Observable(new Cache(new JsonRest({target: target}), new Memory({})));
        },

        _hasstore: function(entity){
            for (var key in this.stores) {
                if(key == entity)return true;
            }
        }
    })
});