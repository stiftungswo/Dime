define([
    'dojo/_base/declare',
    'dijit/form/FilteringSelect'
], function (declare, FilteringSelect) {
    return declare(null, {

        selectionBox: {},

        startup: function(){
            this.inherited(arguments);
            var SelectionBox = this.selectionBox = new FilteringSelect(this.selectionBox);
            SelectionBox.placeAt(this.actionNode);
            SelectionBox.startup();
        },

        createRow: function(){
            var ids = this._getAllSubEntIds(), selectedID = this.selectionBox.get('value');
            if(selectedID) {
                ids.push(selectedID);
                this._putSubEntitties(ids);
            }
        }
    });
});