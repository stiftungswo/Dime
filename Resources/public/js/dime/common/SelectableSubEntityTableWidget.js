define([
    'dijit/_WidgetsInTemplateMixin',
    'dijit/_TemplatedMixin',
    'dime/table/_tableBase',
    'dime/table/_subEntityMixin',
    'dime/table/_subEntitySelectionMixin',
    'dime/table/AddRowButtonMixin',
    'dime/table/DeleteRowButtonMixin',
    'dime/table/CheckBoxSelectionMixin',
    'dojo/_base/declare',
    'dojo/text!dime/common/templates/GenericTableWidget.html',
    'dijit/form/FilteringSelect',
    'dijit/form/Button'
], function (WidgetsInTemplateMixin, TemplatedMixin, tableBase, subEntityMixin, subEntitySelectionMixin, AddRowButtonMixin, DeleteRowButtonMixin, CheckBoxSelectionMixin, declare, template) {
    return declare('dime.common.GenericSubEntityTableWidget', [
        tableBase,
        subEntityMixin,
        AddRowButtonMixin,
        DeleteRowButtonMixin,
        subEntitySelectionMixin,
        CheckBoxSelectionMixin,
        TemplatedMixin,
        WidgetsInTemplateMixin
    ], {
        templateString: template,
        independant: true
    });
});
