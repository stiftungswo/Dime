define([
    'dijit/_WidgetsInTemplateMixin',
    'dijit/_TemplatedMixin',
    'dijit/_WidgetBase',
    'dojo/_base/declare',
    'dojo/text!dime/widget/timetrack/templates/ActivityWidget.html',
    "dime/widget/timetrack/TimesliceWidget",
    "dijit/form/FilteringSelect",
    "dijit/form/Button",
    "dijit/form/CheckBox",
    "dijit/form/Textarea",
    "xstyle!dime/widget/timetrack/css/ActivityWidget.css"
], function (WidgetsInTemplateMixin, TemplatedMixin, WidgetBase, declare, template, TimesliceWidget) {
    return declare("dime.widget.timetrack.ActivityWidget", [WidgetBase, TemplatedMixin, WidgetsInTemplateMixin], {
        templateString: template,
        baseClass: "activityWidget",
        activty: null,
        postMixInProperties: function () {
            this.inherited(arguments);
        },

        buildRendering: function () {
            this.inherited(arguments);
            this._setupChildWidgets();
        },

        _setupChildWidgets: function(){
            this.customerNode.set('store', window.customerStore);
            this.projectNode.set('store', window.projectStore);
            this.serviceNode.set('store', window.serviceStore);
        },

        _fillInitialValues: function(){
            this.customerNode.set('value', this.activity.customer.id);
            this.projectNode.set('value', this.activity.project.id);
            this.serviceNode.set('value', this.activity.service.id);
            this.descriptionNode.set('value', this.activity.description);
            this.chargeableNode.set('value', this.activity.chargeable);
            var containerid = this.timesliceContainer;
            dojo.forEach(this.activity.timeslices, function(timeslice) {
                //Make a new Activity Widget for each Activity in the Store
                var timeslicewidget = new TimesliceWidget({timeslice: timeslice});
                timeslicewidget.placeAt(containerid);
            });
        },

        postCreate: function () {
            this.inherited(arguments);
            this._fillInitialValues();
        },

        startup: function () {
            this.inherited(arguments);
        },

        putActivity: function(changes){

        }
    });
});
