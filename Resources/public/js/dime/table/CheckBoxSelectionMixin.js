define([
    'dojo/_base/declare',
    'dijit/form/CheckBox'
], function (declare, CheckBox) {
    return declare(null, {

        selection: [],

        _addSelectionCheckBox: function(){
            this.set('_selected', false);
            var selectioncheckBox = new CheckBox({
                checked: false,
                onChange: function(b){
                    this.getParent().set('_selected', b);
                }
            });
            selectioncheckBox.placeAt(this);
            selectioncheckBox.startup();
        },

        _addChildWidget: function(entity){
            window.widgetManager.add(entity, this.childWidgetType, this, this.disabled, this._addSelectionCheckBox);
        },

        _getSelectionAttr: function(){
            var children = this.getChildWidgets(), selection = this.selection;
            children.forEach(function(child){
                if(child._selected){
                    selection.push(child.entity.id);
                }
            });
            return selection;
        }
    });
});