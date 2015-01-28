define([
    'dojo/_base/declare',
    'dojo/when'
], function (declare, when) {
    return declare(null, {
        /*====
        A Mixin That Automates the Creation of a Edit Widget in a new Tab
        Requires:
            A dijit/form/Button on the attachPoint editEntityNode
            An Array named selection with all the ids to display
            A Property named editWidget with the AMD Module Name of the Widget which handles the editing of the Entity
            A Property named editTitleProperty
         */

        selection: [],

        editTitleProperty: null,

        editWidget: null,

        editTabBar: 'contentTabs',

        startup: function(){
            this.inherited(arguments);
            var base = this;
            if(base.editEntityNode) {
                base.editEntityNode.on('click', function () {
                    base.editEntity();
                });
            }
        },

        editEntity: function(){
            var editWidget = this.get('editWidget'),
                selection = this.get('selection'),
                collection = this.get('collection'),
                editTitleProperty = this.get('editTitleProperty'),
                editTabBar = this.get('editTabBar');
            selection.forEach(function(id){
                when(collection.get(id)).then(function(item){
                    var tabtitle = editTitleProperty +'(' + item.id + ')';
                    window.widgetManager.addTab(item, collection.entity, editWidget, editTabBar, tabtitle, true);
                });
            });
        }
    });
});