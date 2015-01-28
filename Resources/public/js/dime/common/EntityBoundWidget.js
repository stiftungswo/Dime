define([
    'dojo/_base/declare',
    'dijit/_WidgetBase',
    'dime/_base/ConfigMixin',
    'dime/_base/stringCollectionMixin',
    'dime/_base/EntityBindMixin',
    'dime/_base/RecursiveDisableMixin'
], function (declare, WidgetBase, ConfigMixin, stringCollectionMixin, EntityBindMixin, RecursiveDisableMixin) {
    return declare('dime.common.EntityBoundWidget', [
        WidgetBase,
        ConfigMixin,
        stringCollectionMixin,
        EntityBindMixin,
        RecursiveDisableMixin
    ], {

    });
});