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
        store: window.timesliceStore,
        postMixInProperties: function () {
            this.inherited(arguments);
        },

        buildRendering: function () {
            this.inherited(arguments);
        },

        postCreate: function () {
            this.inherited(arguments);
            this._updateValues(this.timeslice);
            this._setParentsonChildren();
            this.delNode.set('parentWidget', this);
            this.delNode.on('click', this._DelHandler);
            this._setupwatchers();
        },

        startup: function () {
            this.inherited(arguments);
        },

        _updateValues: function(timeslice){
            //ToDo: Proper Formating in the Backend.
            var datestr = timeslice.startedAt.split(" ")[0];
            this.startedAtNode.set('value', datestr);
            this.durationNode.set('value', timeslice.duration);
        },

        _setParentsonChildren: function(){
            this.durationNode.set('parentWidget', this);
            this.startedAtNode.set('parentWidget', this);
        },

        _DelHandler: function(){
            var p = this.parentWidget;
            window.timesliceStore.remove(p.timeslice.id);
            p.destroy();
        },

        _setupwatchers: function(){
            var _watchercallback = this._watchercallback;
            this.durationNode.watch('value', _watchercallback);
            this.startedAtNode.watch('value', _watchercallback);
        },

        _watchercallback: function(property, oldvalue, newvalue){
            if(oldvalue == "") return;
            var timesliceId = this.parentWidget.timeslice.id;
            var timesliceStore = this.parentWidget.store;
            switch(this.dojoAttachPoint) {
                case "startedAtNode":
                    timesliceStore.put({id: timesliceId, startedAt: newvalue});
                    break;
                case "durationNode":
                    timesliceStore.put({id: timesliceId, duration: newvalue});
                    break;
                default:
                    break;
            }
        }
    });
});
