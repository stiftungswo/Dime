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
        'dijit/form/TextBox',

    ],
    function(declare, OnDemandGrid, DijitRegistry, Selection, Keyboard) {
        return declare('dime.widget.offer.OfferGrid', [OnDemandGrid, DijitRegistry, Selection, Keyboard], {

            sort: 'name',
            columns: [
                {label: 'ID', field: 'id', autoSave: true, sortable: true},
                {label: 'Name', field: 'name', autoSave: true, sortable: true, editOn: 'dblclick', editor: 'dijit/form/TextBox'},
                {label: 'Kunde', field: 'customer', autoSave: true,  formatter: function(data){
                    return data ? data.name+" ("+data.alias+")" : null;
                }},
                {label: 'Status', field: 'status', autoSave: true, formatter: function(data){
                    return data? data.text : null;
                }},
                {label: 'Verantwortlich', field: 'accountant', autoSave: true, sortable: true, formatter: function(data){
                    return data ? data.firstname +" "+data.lastname : null;
                }}
            ]
        })
    }
);