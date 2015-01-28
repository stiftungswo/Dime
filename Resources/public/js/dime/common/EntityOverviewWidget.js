define([
    'dojo/_base/declare',
    'dijit/_WidgetBase',
    'dime/_base/ConfigMixin',
    'dime/_base/stringCollectionMixin',
    'dime/_base/AddEntityMixin',
    'dime/_base/EditEntityMixin',
    'dime/_base/DeleteEntityMixin',
    'dime/_base/dGridMixin'
], function (declare, WidgetBase, ConfigMixin, stringCollectionMixin, AddEntityMixin, EditEntityMixin, DeleteEntityMixin, dGridMixin) {
    return declare('dime.common.EntityOverviewWidget', [
        WidgetBase,
        ConfigMixin,
        stringCollectionMixin,
        AddEntityMixin,
        EditEntityMixin,
        DeleteEntityMixin,
        dGridMixin
    ], {
    });
});