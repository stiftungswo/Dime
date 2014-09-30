/**
 * Created by toast on 9/30/14.
 */
define(
    [
        'dojo/_base/declare',
        'dgrid/OnDemandGrid',
        'dgrid/extensions/DijitRegistry',
        'dgrid/Selection',
        'dgrid/Keyboard'
    ],
    function(declare, OnDemandGrid, DijitRegistry, Selection, Keyboard) {
        return declare('dime.Grid', [OnDemandGrid, DijitRegistry, Selection, Keyboard], {
        })
    }
);