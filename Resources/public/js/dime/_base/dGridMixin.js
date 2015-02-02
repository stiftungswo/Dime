define([
    'dojo/_base/declare',
    'dime/common/Grid'
], function (declare, Grid) {
    return declare(null, {

        selection: [],

        constructor: function(){
            this.selection = [];
        },

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
                    var selection = base.get('selection');
                    event.rows.forEach(function(row){
                        selection.push(row.id);
                    });
                });
                grid.on('dgrid-deselect', function (event) {
                    var selection = base.get('selection');
                    event.rows.forEach(function(row) {
                        var index = selection.indexOf(row.id);
                        if (index > -1) {
                            selection.splice(index, 1);
                        }
                    });
                });
            }
        }
    });
});