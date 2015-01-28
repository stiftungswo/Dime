define([
    'dijit/_WidgetsInTemplateMixin',
    'dijit/_TemplatedMixin',
    'dime/common/EntityBoundWidget',
    'dojo/_base/declare',
    'dojo/text!dime/widget/swocommons/templates/PhoneRowWidget.html',
    'dijit/form/TextBox'
], function (WidgetsInTemplateMixin, TemplatedMixin, EntityBoundWidget, declare, template) {
    return declare("dime.widget.swocommons.PhoneRowWidget", [EntityBoundWidget, TemplatedMixin, WidgetsInTemplateMixin], {
        templateString: template,
        baseClass: "phoneRowWidget",
        entityType: 'phones',
        independant: false,
        config: {
            values: {
                telnrNode: {
                    widgetProperty: 'value',
                    entityProperty: 'Number',
                    nullValue: ''
                },
                teltypeNode: {
                    widgetProperty: 'value',
                    entityProperty: 'Type',
                    nullValue: ''
                }
            }
        }
    });
});
