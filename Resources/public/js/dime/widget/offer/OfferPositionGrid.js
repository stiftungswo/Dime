/**
 * Created by toast on 9/30/14.
 */
define(
    [
        'dojo/_base/declare',
        'dojo/store/Memory',
        'dojo/store/Observable',
        'dgrid/CellSelection',
        'dgrid/Keyboard',
        'dgrid/OnDemandGrid',
        'dgrid/editor',
        "dijit/InlineEditBox",
        'dijit/form/FilteringSelect'
    ],
    function(declare, Memory, Observable, CellSelection, Keyboard, OnDemandGrid, editor, InlineEditBox, FilteringSelect) {
        return declare('dime.widget.offer.OfferPositionGrid', [OnDemandGrid, CellSelection, Keyboard], {
            //jsonrest stores
            //store: window.storeManager.get('offerpositions', false, true),
            //servicesStore: window.storeManager.get('services', true),

            //in memory stores
            servicesStore : new Memory({
                idProperty: "id",
                data: [
                    { id: 1, name: "Büro Zivi" },
                    { id: 2, name: "Feld Zivi" },
                    { id: 3, name: "Sozialmitarbeiter" },
                    { id: 4, name: "Fachperson 1" },
                    { id: 10, name: "Fachperson 2" }
                ]
            }),

            store : new Observable(new Memory({
                data: [
                    { id: "1", order: 10, service:1, rate: 50, vat:8, discountable:false },
                    { id: "2", order: 20, service:2, rate: 55, vat:8, discountable:false },
                    { id: "3", order: 30, service:2, rate: 80, vat:8, discountable:false },
                    { id: "4", order: 40, service:3, rate: 120, vat:8, discountable:false },
                ]
            })),

            columns: [
                {label: 'ID', field: 'id', autoSave: true, sortable: true},
                {label: 'Reihenfolge', field: 'order', autoSave: true, sortable: true},
                editor({label: 'Service', field: 'service', autoSave: true, sortable: false, editor:FilteringSelect, editorArgs: {store: this.servicesStore}}),
                //{label: 'Service', field: 'service', autoSave: true, sortable: false},
                {label: 'Tarif', field: 'rate', autoSave: true, sortable: true },
                {label: 'Mwst', field: 'vat', autoSave: true, sortable: true},
                {label: 'Rabattierbar', field: 'discountable', autoSave: true}
            ]



        })
    }
);