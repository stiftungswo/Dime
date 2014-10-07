/**
 * Created by toast on 9/30/14.
 */
define(
    [
        'dojo/_base/declare',
        "dgrid/GridFromHtml",
        'dgrid/OnDemandGrid',
        'dgrid/extensions/DijitRegistry',
        'dgrid/Selection',
        'dgrid/Keyboard'
    ],
    function(declare, GridFromHtml, OnDemandGrid, DijitRegistry, Selection, Keyboard) {
        return declare('dime.Grid', [OnDemandGrid, GridFromHtml, DijitRegistry, Selection, Keyboard], {
        })
    }
);