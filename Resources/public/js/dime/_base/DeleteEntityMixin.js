define([
    'dojo/_base/declare'
], function (declare) {
    return declare(null, {
        /*====
        Handles the Removal of Entities
        Requires:
            A dijit/form/Button on the attachPoint deleteEntityNode
            An Array Named Selection with the ids to remove.
         */

        selection: [],

        startup: function(){
            this.inherited(arguments);
            var base = this;
            if(base.deleteEntityNode) {
                base.deleteEntityNode.on('click', function () {
                    base.deleteEntity();
                });
            }
        },

        deleteEntity: function(){
            var selection = this.get('selection'),
                store = this.get('collection');
            selection.forEach(function(id){
                store.remove(id);
            });
        }
    });
});