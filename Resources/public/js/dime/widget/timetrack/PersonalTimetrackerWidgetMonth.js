define([
    'dijit/_WidgetsInTemplateMixin',
    'dijit/_TemplatedMixin',
    'dime/widget/_Base',
    'dojo/_base/declare',
    'dojo/text!dime/widget/timetrack/templates/PersonalTimetrackerWidgetMonth.html',
    'dime/widget/timetrack/ActivityWidget',
    'dijit/form/DateTextBox',
    'dijit/registry',
    'dijit/Dialog',
    "xstyle!dime/widget/timetrack/css/PersonalTimetrackerWidgetMonth.css"
], function (WidgetsInTemplateMixin, TemplatedMixin, Base, declare, template, ActivityWidget, DateTextBox, registry, Dialog) {
    return declare("dime.widget.timetrack.PersonalTimetrackerWidgetMonth", [Base, TemplatedMixin, WidgetsInTemplateMixin], {
        templateString: template,
        selectedMonth: "",
        monthNames: [ "Januar", "Februar", "März", "April", "Mai", "Juni",
            "Juli", "August", "September", "Oktober", "November", "Dezember" ],
        baseClass: "personalTimetrackerWidgetMonth",
        date: new Date(),
        observeHandle: null,
        childtypes: [ 'activities' ],
        entity: {id: 1},
        entitytype: 'entityless',

        setMonth: function(){
            this.selectedMonth = this.monthNames[this.date.getMonth()];
        },

        buildRendering: function () {
            this.setMonth();
            window.widgetManager.register(this.entity, this.entitytype, this);
            this.inherited(arguments);
        },

        _handleaddChild: function(entity, entitytype){
            var parentWidget = this, activityContainer = this.activityContainer;
            if(entitytype == 'activities'){
                window.widgetManager.add(entity, 'activities', ActivityWidget, parentWidget, activityContainer)
            }
        },

        _fillValues: function(){
            var parentWidget = this, activityContainer = this.activityContainer;
            var startdate = new Date(this.date.getFullYear(), this.date.getMonth(), 1), enddate = new Date(this.date.getFullYear(), this.date.getMonth() + 1, 0);
            var startdatestr = startdate.getFullYear()+'-'+('0' + (startdate.getMonth()+1)).slice(-2)+'-'+('0' + startdate.getDate()).slice(-2), enddatestr = enddate.getFullYear()+'-'+('0' + (enddate.getMonth()+1)).slice(-2)+'-'+('0' + enddate.getDate()).slice(-2);
            this.dateSelectNode.set('value', this.date);
            var results = this.store.query({date: startdatestr+','+enddatestr});
            results.forEach(function(entity){
                window.widgetManager.add(entity, 'activities', ActivityWidget, parentWidget, activityContainer)
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
        }
    });
});
