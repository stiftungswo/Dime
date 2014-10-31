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
            var addchildwidgets = this._addChildWidget, parentWidget = this, activityContainer = this.activityContainer;
            var startdate = new Date(this.date.getFullYear(), this.date.getMonth(), 1), enddate = new Date(this.date.getFullYear(), this.date.getMonth() + 1, 0);
            var startdatestr = startdate.getFullYear()+'-'+('0' + (startdate.getMonth()+1)).slice(-2)+'-'+('0' + startdate.getDate()).slice(-2), enddatestr = enddate.getFullYear()+'-'+('0' + (enddate.getMonth()+1)).slice(-2)+'-'+('0' + enddate.getDate()).slice(-2);
            this.dateSelectNode.set('value', this.date);
            var results = this.store.query({date: [startdatestr, enddatestr]});
            results.forEach(function(entity){
                addchildwidgets(entity, ActivityWidget, activityContainer, parentWidget)
            });
            this.observeHandle = results.observe(function(object, removedFrom, insertedInto){
                parentWidget._updateHandler(object, removedFrom, insertedInto, ActivityWidget, activityContainer, parentWidget)
            });
        },

        _addcallbacks: function(){
            this.addButtonNode.on('click', function(){
                var dialog = window.dialogManager.get('activities', 'Neue Aktivität');
                dialog.show();
            });
        },

        _setupChildren: function(){
            this.addButtonNode.set('parentWidget', this);
        },

        destroy: function(){
            this.observeHandle.cancel();
            this.inherited(arguments);
        }
    });
});
