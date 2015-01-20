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

            sort: 'name',
            columns: [
                {label: 'Name', field: 'name'},
                {label: 'Alias', field: 'alias'},
                {label: 'Tarif Gruppe', field: 'rateGroup', formatter: function(data){
                    return data? data.name : null;
                }},
                {label: 'Verechenbar', field: 'chargeable'}
            ]
        })
    }
);