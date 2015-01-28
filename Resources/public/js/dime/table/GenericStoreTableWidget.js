define([
    'dijit/_WidgetsInTemplateMixin',
    'dijit/_TemplatedMixin',
    'dime/table/_tableBase',
    'dime/table/_storeMixin',
    'dime/table/AddRowButtonMixin',
    'dime/table/DeleteRowButtonMixin',
    'dime/table/CheckBoxSelectionMixin',
    'dojo/_base/declare',
    'dojo/text!dime/table/templates/GenericTableWidget.html',
    'dijit/form/FilteringSelect',
    'dijit/form/Button'
], function (WidgetsInTemplateMixin, TemplatedMixin, tableBase, storeMixin, AddRowButtonMixin, DeleteRowButtonMixin, CheckBoxSelectionMixin, declare, template) {
    return declare('dime.table.GenericTableWidget', [
        tableBase,
        storeMixin,
        AddRowButtonMixin,
        DeleteRowButtonMixin,
        CheckBoxSelectionMixin,
        TemplatedMixin,
        WidgetsInTemplateMixin
    ], {
        templateString: template,
        independant: true
    });
});
