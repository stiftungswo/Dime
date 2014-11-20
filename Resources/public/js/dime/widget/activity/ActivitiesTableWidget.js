define([
    'dijit/_WidgetsInTemplateMixin',
    'dijit/_TemplatedMixin',
    'dime/widget/_Base',
    'dojo/_base/declare',
    'dojo/text!dime/widget/activity/templates/ActivitiesTableWidget.html',
    'dime/widget/activity/ActivitiesTableRowWidget'
], function (WidgetsInTemplateMixin, TemplatedMixin,  _Base, declare,  template, ActivitiesTableRowWidget) {
    return declare("dime.widget.activity.ActivitiesTableWidget", [_Base, TemplatedMixin, WidgetsInTemplateMixin], {
        templateString: template,
        baseClass: "activitiesTableWidget",
        activities: [],

        _setupChildren: function(){

        },

        _addcallbacks: function(){

        },

        _fillValues: function(){
            for(var i=0; i < this.activities.length; i++){
                var activity = this.activities[i];
                window.widgetManager.add(activity, 'activities', ActivitiesTableRowWidget, this, this.tableBody);
            }
        }
    });
});
