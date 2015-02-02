define([
    'dojo/_base/declare',
    'dijit/form/Button'
], function (declare) {
    return declare(null, {

        selection: [],

        constructor: function(){
            this.selection = [];
        },

        startup: function(){
            var base = this;
            if(base.addEntityNode) {
                base.addEntityNode.on('click', function () {
                    base.addEntity();
                });
            }
        },

        addEntity: function(){
            var collection = this.get('collection');
            var query = this.get('query') || {};
            collection.newEntity({query: query});
        }
    });
});