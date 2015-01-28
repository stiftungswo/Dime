define([
    'dijit/_WidgetsInTemplateMixin',
    'dijit/_TemplatedMixin',
    'dijit/_WidgetBase',
    'dojo/_base/declare',
    'dojox/calendar/Calendar',
    'moment/moment',
    'dojo/text!dime/widget/timetrack/templates/Personal.html',
    'xstyle!dojox/calendar/themes/dbootstrap/Calendar.css'
], function (WidgetsInTemplateMixin, TemplatedMixin, WidgetBase, declare, Calendar, moment, template) {
    return declare([WidgetBase, TemplatedMixin, WidgetsInTemplateMixin], {
        templateString: template,

        postMixInProperties: function () {
            this.inherited(arguments);
        },

        buildRendering: function () {
            this.inherited(arguments);
        },

        postCreate: function () {
            this.inherited(arguments);
        },

        startup: function () {
            this.inherited(arguments);
            var calendar = new Calendar({
                date: new Date(),
                startTimeAttr: "startedAt",
                endTimeAttr: "stoppedAt",
                store: window.storeManager.get('timeslices', true),
                dateInterval: "month",
                decodeDate: function(s){
                    return moment(s).toDate();
                }
                //style: "position:relative;width:500px;height:500px"
            }, this.calendarNode);
        }
    });
});
