/**
 * Created by toast on 9/30/14.
 */
define(
    [
        'dojo/_base/declare',
        'dgrid/OnDemandGrid',
        'dgrid/extensions/DijitRegistry',
        'dgrid/Selection',
        'dgrid/Keyboard',
        'dgrid/editor',
        'dijit/form/TextBox'
    ],
    function(declare, OnDemandGrid, DijitRegistry, Selection, Keyboard, editor) {
        return declare('dime.widget.tag.TagGrid', [OnDemandGrid, DijitRegistry, Selection, Keyboard], {
            store: window.storeManager.get('tags',false, true),
            sort: 'name',
            columns: [
                editor({label: 'Name', field: 'name', autoSave: true}, 'dijit/form/TextBox', 'dblclick')
            ]
        })
    }
);