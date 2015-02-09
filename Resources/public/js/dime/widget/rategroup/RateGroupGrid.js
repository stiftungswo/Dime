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
        'dgrid/Editor',
        'dijit/form/TextBox'
    ],
    function(declare, OnDemandGrid, DijitRegistry, Selection, Keyboard, Editor) {
        return declare('dime.widget.rategroup.RateGroupGrid', [OnDemandGrid, DijitRegistry, Selection, Keyboard, Editor], {

            sort: 'name',
            collection: window.storeManager.get('rategroups'),
            columns: [
                {label: 'ID', field: 'id', sortable: true},
                {
                    label: 'Name',
                    field: 'name',
                    autoSave: true,
                    editor: 'dijit/form/TextBox',
                    editOn: 'dblclick'
                },
                {
                    label: 'Beschreibung',
                    field: 'description',
                    autoSave: true,
                    editor: 'dijit/form/TextBox',
                    editOn: 'dblclick'
                }
            ]
        })
    }
);