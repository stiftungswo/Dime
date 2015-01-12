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
        'dijit/form/TextBox'

    ],
    function(declare, OnDemandGrid, DijitRegistry, Selection, Keyboard) {
        return declare('dime.widget.user.UserGrid', [OnDemandGrid, DijitRegistry, Selection, Keyboard], {
            store: null,
            sort: 'username',
            columns: [
                {label: 'Benutzername', field: 'username'},
                {label: 'Vorname', field: 'firstname'},
                {label: 'Nachname', field: 'lastname'},
                {label: 'e-Mail', field: 'email'},
                {label: 'Login', field: 'enabled'},
                {label: 'Gesperrt', field: 'locked'}
            ]
        })
    }
);