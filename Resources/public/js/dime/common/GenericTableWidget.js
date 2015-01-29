define([
    'dijit/_WidgetsInTemplateMixin',
    'dijit/_TemplatedMixin',
    'dime/table/_tableBase',
    'dojo/_base/declare',
    'dojo/text!dime/common/templates/GenericTableWidget.html'
], function (WidgetsInTemplateMixin, TemplatedMixin, tableBase, declare, template) {
    return declare('dime.common.GenericTableWidget', [
        tableBase,
        TemplatedMixin,
        WidgetsInTemplateMixin
    ], {
        templateString: template,
        independant: true
    });
});
