/**
 * Created by toast on 9/30/14.
 */
define(
    [
        'dojo/_base/declare',
        'dime/common/Grid',
        'dgrid/Editor',
        'dijit/form/TextBox'
    ],
    function(declare, Grid, Editor) {
        return declare('dime.widget.tag.TagGrid', [Grid, Editor], {

            sort: 'name',
            collection: window.storeManager.get('tags'),
            columns: [
                {
                    label: 'Name',
                    field: 'name',
                    autoSave: true,
                    editor: 'dijit/form/TextBox',
                    editOn: 'dblclick'
                }
            ]
        })
    }
);