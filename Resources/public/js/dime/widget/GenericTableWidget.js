define([
    'dijit/_WidgetsInTemplateMixin',
    'dijit/_TemplatedMixin',
    'dijit/_WidgetBase',
    'dojo/_base/declare',
    'dojo/text!dime/widget/templates/GenericTableWidget.html',
    'dime/widget/_ListBase',
    'dijit/form/FilteringSelect',
    'dijit/form/Button'
], function (WidgetsInTemplateMixin, TemplatedMixin, WidgetBase, declare, template, ListBase) {
    return declare('dime.widget.GenericTableWidget', [ListBase, WidgetBase, TemplatedMixin, WidgetsInTemplateMixin], {
        templateString: template,
        independant: true
    });
});
