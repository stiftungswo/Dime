define([
    'dijit/_WidgetsInTemplateMixin',
    'dijit/_TemplatedMixin',
    'dime/widget/timetrack/_TimetrackerWidgetBase',
    'dojo/_base/declare',
    'dojo/text!dime/widget/timetrack/templates/PersonalTimetrackerWidgetMonth.html',
    'dime/widget/timetrack/ActivityWidget',
    'dijit/form/DateTextBox',
    'dijit/registry',
    'dijit/Dialog',
    "xstyle!dime/widget/timetrack/css/PersonalTimetrackerWidgetMonth.css"
], function (WidgetsInTemplateMixin, TemplatedMixin, _TimetrackerWidgetBase, declare, template, ActivityWidget, DateTextBox, registry, Dialog) {
    return declare("dime.widget.timetrack.PersonalTimetrackerWidgetMonth", [_TimetrackerWidgetBase, TemplatedMixin, WidgetsInTemplateMixin], {
        templateString: template,
        selectedMonth: "",
        monthNames: [ "Januar", "Februar", "März", "April", "Mai", "Juni",
            "Juli", "August", "September", "Oktober", "November", "Dezember" ],
        baseClass: "personalTimetrackerWidgetMonth",
        date: new Date(),
        observeHandle: null,

        setMonth: function(){
            this.selectedMonth = this.monthNames[this.date.getMonth()];
        },

        buildRendering: function () {
            this.setMonth();
            this.inherited(arguments);
        },

        _fillValues: function(){
            this.dateSelectNode.set('value', this.date);
            var results = activityStore.query({filter: {date: ['startdate', 'enddate']}});
            results.forEach(function(entity){
                this._addChildWidget(entity, ActivityWidget, this.activityContainer)
            });
            this.observeHandle = results.observe(function(object, removedFrom, insertedInto){
                var parentWidget = registry.byId("personalTimetrackWidgetMonth");
                parentWidget._updateHandler(object, removedFrom, insertedInto, ActivityWidget, this.activityContainer)
            });
        },

        _setupChildren: function(){
            this.newActivityDialog = this._requiredialogonce('newActivityDialog', this, 'Neue Aktivität', '/api/v1/activities/new');
            this.addButtonNode.set('parentWidget', this);
            this.addButtonNode.on('click', function(){
                var p = this.parentWidget;
                p.newActivityDialog.show();
            });
        },

        destroy: function(){
            this.observeHandle.cancel();
            this.inherited(arguments);
        }
    });
});
