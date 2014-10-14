define([
    'dijit/_WidgetsInTemplateMixin',
    'dijit/_TemplatedMixin',
    'dijit/_WidgetBase',
    'dojo/_base/declare',
    'dime/widget/timetrack/_TimetrackerWidgetBase',
    'dojo/text!dime/widget/timetrack/templates/PersonalTimetrackerWidgetMonth.html',
    'dime/widget/timetrack/ActivityWidget',
    'dijit/form/DateTextBox'
], function (WidgetsInTemplateMixin, TemplatedMixin, WidgetBase, declare, TimetrackerWidgetBase, template, ActivityWidget, DateTextBox) {
    return declare("dime.widget.timetrack.PersonalTimetrackerWidgetMonth", [WidgetBase, TemplatedMixin, WidgetsInTemplateMixin, TimetrackerWidgetBase], {
        templateString: template,
        selectedMonth: "",
        monthNames: [ "Januar", "Februar", "März", "April", "Mai", "Juni",
            "Juli", "August", "September", "Oktober", "November", "Dezember" ],
        baseClass: "personalTimetrackerWidgetMonth",
        stylesheet: "bundles/dimefrontend/js/dime/widget/timetrack/css/PersonalTimetrackerWidgetMonth.css",
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
            app.require_css(this.stylesheet);
            this.dateSelectNode.set('value', this.date);
            var containerid = this.activityContainer;
            this.activityStore.query().then(function(results){
                dojo.forEach(results, function(item) {
                    //Make a new Activity Widget for each Activity in the Store
                    var activity = new ActivityWidget(item);
                    activity.placeAt(containerid)
                });
            });
        },

        startup: function () {
            this.inherited(arguments);
        }
    });
});
