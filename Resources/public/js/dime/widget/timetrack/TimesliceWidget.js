define([
    'dijit/_WidgetsInTemplateMixin',
    'dijit/_TemplatedMixin',
    'dijit/_WidgetBase',
    'dojo/_base/declare',
    'dojo/text!dime/widget/timetrack/templates/TimesliceWidget.html',
    'dijit/form/DateTextBox',
    "dijit/form/NumberSpinner",
    "xstyle!dime/widget/timetrack/css/TimesliceWidget.css"
], function (WidgetsInTemplateMixin, TemplatedMixin, WidgetBase, declare, template) {
    return declare("dime.widget.timetrack.TimesliceWidget", [WidgetBase, TemplatedMixin, WidgetsInTemplateMixin], {
        templateString: template,
        baseClass: "timesliceWidget",
        timeslice: null,
        postMixInProperties: function () {
            this.inherited(arguments);
        },

        buildRendering: function () {
            this.inherited(arguments);
        },

        postCreate: function () {
            this.inherited(arguments);
            this.startedAtNode.set('value', this.timeslice.startedAt);
            this.durationNode.set('value', this.timeslice.duration);
        },

        startup: function () {
            this.inherited(arguments);
        }
    });
});
