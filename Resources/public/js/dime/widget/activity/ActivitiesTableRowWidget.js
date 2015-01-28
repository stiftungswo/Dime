define([
    'dijit/_WidgetsInTemplateMixin',
    'dijit/_TemplatedMixin',
    'dime/common/EntityBoundWidget',
    'dojo/_base/declare',
    'dojo/text!dime/widget/activity/templates/ActivitiesTableRowWidget.html',
    'dijit/form/FilteringSelect',
    'dijit/form/Textarea',
    'dijit/form/TextBox',
    'dijit/form/NumberTextBox',
    'xstyle!dime/widget/activity/css/ActivitiesTableRowWidget.css'
], function (WidgetsInTemplateMixin, TemplatedMixin,  EntityBoundWidget, declare,  template) {
    return declare("dime.widget.activity.ActivitiesTableRowWidget", [EntityBoundWidget, TemplatedMixin, WidgetsInTemplateMixin], {
        templateString: template,
        baseClass: "activitiesTableRowWidget",
        collection: 'activities',
        independant: true,
        childConfig: {
            chargeNode: {
                widgetProperty: 'value',
                entityProperty: 'charge',
                nullValue: 0,
                disabled: true
            },
            rateUnitNode: {
                widgetProperty: 'value',
                entityProperty: 'rateUnit',
                nullValue: '',
                disabled: true
            },
            rateNode: {
                widgetProperty: 'value',
                entityProperty: 'rate',
                nullValue: 0,
                disabled: true
            },
            serviceNode: {
                widgetProperty: 'value',
                entityProperty: 'service',
                nullValue: 1,
                store: 'services',
                idProperty: 'id'
            },
            userNode: {
                widgetProperty: 'value',
                entityProperty: 'user',
                nullValue: 1,
                store: 'users',
                searchAttr: 'fullname',
                idProperty: 'id'
            },
            projectNode: {
                widgetProperty: 'value',
                entityProperty: 'project',
                nullValue: 1,
                store: 'projects',
                idProperty: 'id'
            },
            descriptionNode: {
                widgetProperty: 'value',
                entityProperty: 'description',
                nullValue: ''
            },
            valueNode: {
                widgetProperty: 'value',
                entityProperty: 'value',
                nullValue: '',
                disabled: true
            }
        }
    });
});
