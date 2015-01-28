define([
    'dojo/_base/declare',
    'dime/common/Grid'
], function (declare, Grid) {
    return declare(null, {

        selection: [],

        postCreate: function(){
            this.inherited(arguments);
            var base = this;
            //Checks if we have to Programatically instanciate a dGrid and does it.
            if(this.dGrid && this.GridNode){
                var gridoptions = dojo.safeMixin({collection: this.collection}, this.dGrid);
                var grid = new Grid(gridoptions, this.GridNode);
                grid.startup();
                grid.on('dgrid-select', function (event) {
                    // Report the item from the selected row to the console.
                    base.selection.push(event.rows[0].id);
                });
                grid.on('dgrid-deselect', function (event) {
                    var id = event.rows[0].id;
                    if(base.selection.indexOf(id)>-1){
                        base.selection.slice(base.selection.indexOf(id), 1);
                    }
                });
            }
        },

        _getSelectionAttr: function(){
            return this.selection;
        }
    });
});