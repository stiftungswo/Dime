define([
    'dijit/_WidgetsInTemplateMixin',
    'dijit/_TemplatedMixin',
    'dime/common/EntityBoundWidget',
    'dojo/_base/declare',
    'dojo/text!dime/widget/timeslice/templates/TimesliceTableRowWidget.html',
    'dime/form/DateTextBox',
    'dijit/form/FilteringSelect',
    'dijit/form/Textarea',
    'dijit/form/TextBox',
    'dijit/form/NumberTextBox',
    'xstyle!dime/widget/timeslice/css/TimesliceTableRowWidget.css'
], function (WidgetsInTemplateMixin, TemplatedMixin,  EntityBoundWidget, declare,  template) {
    return declare("dime.widget.timeslice.TimesliceTableRowWidget", [EntityBoundWidget, TemplatedMixin, WidgetsInTemplateMixin], {
        templateString: template,
        baseClass: "timesliceTableRowWidget",
        collection: 'timeslices',
        independant: true,
        //Todo Make Filter for active users. (User do not have a active Property in db Yet)

        childConfig: {
            startedAtNode: {
                widgetProperty: 'value',
                entityProperty: 'startedAt',
                nullValue: new Date()
            },
            userNode: {
                widgetProperty: 'value',
                entityProperty: 'user',
                nullValue: 1,
                store: 'users',
                searchAttr: 'username',
                idProperty: 'id'
            },
            activityNode: {
                widgetProperty: 'value',
                entityProperty: 'activity',
                nullValue: 1,
                store: 'activities',
                queryPrototype: {
                    project: 'id'
                },
                resolveProto: true,
                idProperty: 'id'
            },
            valueNode: {
                widgetProperty: 'value',
                entityProperty: 'value',
                nullValue: ''
            }
        }
    });
});
