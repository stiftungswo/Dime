define([
    'dojo/_base/declare',
    'dijit/form/Button'
], function (declare) {
    return declare(null, {
        startup: function(){
            var base = this;
            if(base.addEntityNode) {
                base.addEntityNode.on('click', function () {
                    base.addEntity();
                });
            }
        },

        addEntity: function(){
            var collection = this.collection;
            var query = this.query || {};
            collection.newEntity({query: query});
        }
    });
});