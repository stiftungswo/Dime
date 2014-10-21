define([
    'dijit/_WidgetsInTemplateMixin',
    'dijit/_TemplatedMixin',
    'dijit/_WidgetBase',
    'dojo/_base/declare',
    'dime/widget/timetrack/_TimetrackerWidgetBase',
    'dojo/text!dime/widget/timetrack/templates/PersonalTimetrackerWidgetMonth.html',
    'dime/widget/timetrack/ActivityWidget',
    'dijit/form/DateTextBox',
    'dijit/registry',
    'dijit/Dialog',
    "xstyle!dime/widget/timetrack/css/PersonalTimetrackerWidgetMonth.css"
], function (WidgetsInTemplateMixin, TemplatedMixin, WidgetBase, declare, TimetrackerWidgetBase, template, ActivityWidget, DateTextBox, registry, Dialog) {
    return declare("dime.widget.timetrack.PersonalTimetrackerWidgetMonth", [WidgetBase, TemplatedMixin, WidgetsInTemplateMixin, TimetrackerWidgetBase], {
        templateString: template,
        selectedMonth: "",
        monthNames: [ "Januar", "Februar", "März", "April", "Mai", "Juni",
            "Juli", "August", "September", "Oktober", "November", "Dezember" ],
        baseClass: "personalTimetrackerWidgetMonth",
        registry: null,
        activityWidgets: [],
        setMonth: function(){
            this.selectedMonth = this.monthNames[this.date.getMonth()];
        },

        postMixInProperties: function () {
            this.inherited(arguments);
        },

        buildRendering: function () {
            this.setMonth();
            this.inherited(arguments);
        },

        postCreate: function () {
            this.inherited(arguments);
            this.dateSelectNode.set('value', this.date);
            var results = activityStore.query();
            results.forEach(this._addActivityWidget);
            var observeHandle = results.observe(this._observeHandler);
            this.addButtonNode.set('parentWidget', this);
            this.addButtonNode.on('click', this._addButtonHandler);
        },

        _observeHandler: function(object, removedFrom, insertedInto){
            var parentWidget = registry.byId("personalTimetrackWidgetMonth");
            var widget = parentWidget._findActivityWidget(object.id);
            if (widget == null) {
                if (insertedInto > -1) { // new object inserted
                    parentWidget._addActivityWidget(object);
                }
            }
            else{ //updated or delted Object
                if (removedFrom > -1) { // existing object removed
                    parentWidget._removeActivityWidget(widget);
                }
                else {
                    parentWidget._updateActivityWidget(widget, object);
                }
            }
        },

        _addButtonHandler: function(){
            var p = this.parentWidget;
            if (typeof p.newactivityDialog == 'undefined'){
                p.newactivityDialog = new Dialog({
                    title: "Neue Aktivität",
                    href: '/api/v1/activities/new'
                });
            }
            p.newactivityDialog.show();
        },

        _updateActivityWidget: function(widget, activity){
            widget._updateValues(activity);
        },

        _addActivityWidget: function(item){
            var parentWidget = registry.byId("personalTimetrackWidgetMonth");
            var container = parentWidget.activityContainer;
            var activitywidget = new ActivityWidget({activityId: item.id});
            activitywidget.placeAt(container);
            parentWidget.activityWidgets.push(activitywidget);
        },

        _removeActivityWidget: function(widget){
            widget.destroy();
        },

        _findActivityWidget: function(activityId){
            this.activityWidgets.forEach(function(widget){
                if(widget.activityId == activityId) return widget;
            });
            return null;
        },

        startup: function () {
            this.inherited(arguments);
        }
    });
});
