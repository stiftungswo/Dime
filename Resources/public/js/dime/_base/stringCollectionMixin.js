define([
    'dojo/_base/declare'
], function (declare) {
    return declare(null, {

        collection : null,

        _setCollectionAttr: function(collection){
            if (typeof(collection == "String")) {
                this.collection = window.storeManager.get(collection);
            } else {
                this.collection = collection;
            }
        }
    });
});