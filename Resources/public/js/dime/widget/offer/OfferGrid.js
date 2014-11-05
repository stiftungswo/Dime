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
            store: window.storeManager.get('offers', false, true),
            sort: 'name',
            columns: [
                {label: 'ID', field: 'id', autoSave: true, sortable: true},
                {label: 'Name', field: 'name', autoSave: true, sortable: true, editOn: 'dblclick', editor: 'dijit/form/TextBox'},
                {label: 'Kunde', field: 'customer', autoSave: true,  formatter: function(data){
                    return data.name+" ("+data.alias+")";
                }},
                {label: 'Status', field: 'status', autoSave: true, formatter: function(data){
                    return data.text;
                }},
                {label: 'Verantwortlich', field: 'accountant', autoSave: true, sortable: true, formatter: function(data){
                    return data.firstname +" "+data.lastname;
                }},
            ]


        })
    }
);