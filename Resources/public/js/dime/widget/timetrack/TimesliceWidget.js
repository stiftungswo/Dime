define([
    'dijit/_WidgetsInTemplateMixin',
    'dijit/_TemplatedMixin',
    'dijit/_WidgetBase',
    'dojo/_base/declare',
    'dojo/text!dime/widget/timetrack/templates/TimesliceWidget.html',
    'dijit/form/DateTextBox',
    "dijit/form/NumberSpinner"
], function (WidgetsInTemplateMixin, TemplatedMixin, WidgetBase, declare, template) {
    return declare("dime.widget.timetrack.TimesliceWidget", [WidgetBase, TemplatedMixin, WidgetsInTemplateMixin], {
        templateString: template,
        baseClass: "timesliceWidget",
        stylesheet: "bundles/dimefrontend/js/dime/widget/timetrack/css/TimesliceWidget.css",
        postMixInProperties: function () {
            this.inherited(arguments);
        },

        buildRendering: function () {
            this.inherited(arguments);
        },

        postCreate: function () {
            this.inherited(arguments);
            app.require_css(this.stylesheet);
        },

        startup: function () {
            this.inherited(arguments);
        }
    });
});
