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
        store: window.timesliceStore,

        _setupChildren: function(){
            this.durationNode.set('parentWidget', this);
            this.durationNode.watch('value', this._watchercallback);
            this.startedAtNode.set('parentWidget', this);
            this.startedAtNode.watch('value', this._watchercallback);
            this.delNode.set('parentWidget', this);
            this.delNode.on('click', this._DelHandler);
        },

        _updateValues: function(entity){
            //ToDo: Proper Formating in the Backend.
            var datestr = entity.startedAt.split(" ")[0];
            this.startedAtNode.set('value', datestr);
            this.durationNode.set('value', entity.duration);
        },

        _watchercallback: function(property, oldvalue, newvalue){
            if(oldvalue == "") return;
            var timesliceId = this.parentWidget.entity.id;
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
