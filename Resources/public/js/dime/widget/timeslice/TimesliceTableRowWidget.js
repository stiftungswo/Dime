define([
    'dijit/_WidgetsInTemplateMixin',
    'dijit/_TemplatedMixin',
    'dime/widget/_Base',
    'dojo/_base/declare',
    'dojo/text!dime/widget/timeslice/templates/TimesliceTableRowWidget.html',
    'dijit/form/FilteringSelect',
    'dijit/form/Textarea',
    'dijit/form/TextBox',
    'dijit/form/NumberTextBox',
    'xstyle!dime/widget/timeslice/css/TimesliceTableRowWidget.css'
], function (WidgetsInTemplateMixin, TemplatedMixin,  _Base, declare,  template) {
    return declare("dime.widget.timeslice.TimesliceTableRowWidget", [_Base, TemplatedMixin, WidgetsInTemplateMixin], {
        templateString: template,
        baseClass: "timesliceTableRowWidget",
        store: 'timeslices',
        independant: true,
        //Todo Make Filter for active users. (User do not have a active Property in db Yet)

        config: {
            values: {
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
                    idProperty: 'id'
                },
                valueNode: {
                    widgetProperty: 'value',
                    entityProperty: 'value',
                    nullValue: '0h'
                }
            }
        }
    });
});
