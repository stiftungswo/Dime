define([
    'dijit/_WidgetsInTemplateMixin',
    'dijit/_TemplatedMixin',
    'dime/widget/timetrack/_TimetrackerWidgetBase',
    'dojo/_base/declare',
    'dojo/text!dime/widget/timetrack/templates/TimesliceWidget.html',
    'dijit/form/DateTextBox',
    "dijit/form/NumberSpinner",
    "xstyle!dime/widget/timetrack/css/TimesliceWidget.css"
], function (WidgetsInTemplateMixin, TemplatedMixin, _TimetrackerWidgetBase, declare, template) {
    return declare("dime.widget.timetrack.TimesliceWidget", [_TimetrackerWidgetBase, TemplatedMixin, WidgetsInTemplateMixin], {
        templateString: template,
        baseClass: "timesliceWidget",
        store: window.storeManager.get('timeslices', true),

        _setupChildren: function(){
            this.durationNode.set('parentWidget', this);
            this.startedAtNode.set('parentWidget', this);
            this.delNode.set('parentWidget', this);
        },

        _addcallbacks: function(){
            this.durationNode.watch('value', this._watchercallback);
            this.startedAtNode.watch('value', this._watchercallback);
            this.delNode.on('click', this._destroyParentHandler);
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
