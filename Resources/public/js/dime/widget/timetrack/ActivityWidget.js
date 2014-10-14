define([
    'dijit/_WidgetsInTemplateMixin',
    'dijit/_TemplatedMixin',
    'dijit/_WidgetBase',
    'dojo/_base/declare',
    'dojo/text!dime/widget/timetrack/templates/ActivityWidget.html',
    "dijit/form/FilteringSelect",
    "dijit/form/Button",
    "dijit/form/CheckBox",
    "dijit/form/Textarea"
], function (WidgetsInTemplateMixin, TemplatedMixin, WidgetBase, declare, template) {
    return declare("dime.widget.timetrack.ActivityWidget", [WidgetBase, TemplatedMixin, WidgetsInTemplateMixin], {
        templateString: template,
        baseClass: "activityWidget",
        stylesheet: "bundles/dimefrontend/js/dime/widget/timetrack/css/ActivityWidget.css",
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
