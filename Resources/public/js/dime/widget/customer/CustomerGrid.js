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
        return declare('dime.widget.customer.CustomerGrid', [OnDemandGrid, DijitRegistry, Selection, Keyboard], {
            store: null,
            sort: 'name',
            columns: [
                {label: 'Name', field: 'name'},
                {label: 'Alias', field: 'alias'},
                {label: 'Tarif Gruppe', field: 'rateGroup'},
                {label: 'Verechenbar', field: 'chargeable'}
            ]
        })
    }
);