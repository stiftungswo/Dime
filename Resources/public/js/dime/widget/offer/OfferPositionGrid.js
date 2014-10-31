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
    function(declare, OnDemandGrid, DijitRegistry, Selection, Keyboard, TextBox) {
        return declare('dime.widget.offer.OfferPositionGrid', [OnDemandGrid, DijitRegistry, Selection, Keyboard], {
            store: window.storeManager.get('offerpositions', false, true),
            columns: [
                {label: 'ID', field: 'id', autoSave: true, sortable: true},
                {label: 'Reihenfolge', field: 'order', autoSave: true, sortable: true},
                {label: 'Service', field: 'service', autoSave: true, sortable: true},
                {label: 'Tariv', field: 'rate', autoSave: true, sortable: true},
                {label: 'Mwst', field: 'vat', autoSave: true, sortable: true},
                {label: 'Rabattierbar', field: 'discountable', autoSave: true}
            ]
        })
    }
);