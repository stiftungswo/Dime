define([
    'dijit/_WidgetsInTemplateMixin',
    'dijit/_TemplatedMixin',
    'dime/table/_tableBase',
    'dime/table/_subEntityMixin',
    'dime/table/AddRowButtonMixin',
    'dime/table/DeleteRowButtonMixin',
    'dime/table/CheckBoxSelectionMixin',
    'dojo/_base/declare',
    'dojo/text!dime/common/templates/GenericTableWidget.html',
    'dijit/form/FilteringSelect',
    'dijit/form/Button'
], function (WidgetsInTemplateMixin, TemplatedMixin, tableBase, subEntityMixin, AddRowButtonMixin, DeleteRowButtonMixin, CheckBoxSelectionMixin, declare, template) {
    return declare('dime.common.GenericSubEntityTableWidget', [
        tableBase,
        subEntityMixin,
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
