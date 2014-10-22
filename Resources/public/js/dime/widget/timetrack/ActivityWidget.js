define([
    'dijit/_WidgetsInTemplateMixin',
    'dijit/_TemplatedMixin',
    'dime/widget/timetrack/_TimetrackerWidgetBase',
    'dojo/_base/declare',
    'dojo/text!dime/widget/timetrack/templates/ActivityWidget.html',
    "dime/widget/timetrack/TimesliceWidget",
    'dijit/registry',
    "dijit/form/FilteringSelect",
    "dijit/form/Button",
    "dijit/form/CheckBox",
    "dijit/form/Textarea",
    "xstyle!dime/widget/timetrack/css/ActivityWidget.css"
], function (WidgetsInTemplateMixin, TemplatedMixin, _TimetrackerWidgetBase, declare, template, TimesliceWidget, registry) {
    return declare("dime.widget.timetrack.ActivityWidget", [_TimetrackerWidgetBase, TemplatedMixin, WidgetsInTemplateMixin], {
        templateString: template,
        baseClass: "activityWidget",
        store: window.activityStore,
        newtimesliceDialog: null,

        _setupChildren: function(){
            this.customerNode.set('parentWidget', this);
            this.customerNode.set('store', window.customerStore);
            this.projectNode.set('parentWidget', this);
            this.projectNode.set('store', window.projectStore);
            this.serviceNode.set('parentWidget', this);
            this.serviceNode.set('store', window.serviceStore);
            this.descriptionNode.set('parentWidget', this);
            this.deleteNode.set('parentWidget', this);
            //this.chargeableNode.set('parentWidget', this);
            this.addtimesliceNode.set('parentWidget', this);
            this.customerNode.watch('value', this._watchercallback);
            this.projectNode.watch('value', this._watchercallback);
            this.serviceNode.watch('value', this._watchercallback);
            this.descriptionNode.watch('value', this._watchercallback);
            //this.chargeableNode.watch('checked', this._watchercallback);
            this.deleteNode.on('click', this._destroyParentHandler);
            this.newtimesliceDialog = this._requiredialogonce('newTimesliceForm', this, 'Zeiterfassen', '/api/v1/timeslices/new');
            this.addtimesliceNode.on('click', function(){
                var p = this.parentWidget;
                p.newtimesliceDialog.show();
            });
        },

        _fillValues: function(){
            this.inherited(arguments);
            var results = window.timesliceStore.query({filter: {activity: this.entity.id}});
            results.forEach(function(entity){
                this._addChildWidget(entity, TimesliceWidget, this.timesliceContainer)
            });
            this.observeHandle = results.observe(function(object, removedFrom, insertedInto){
                var parentWidget = registry.byId("personalTimetrackWidgetMonth");
                parentWidget._updateHandler(object, removedFrom, insertedInto, TimesliceWidget, this.timesliceContainer)
            });
        },

        _updateValues: function(entity){
            this.customerNode.set('value', entity.customer.id);
            this.projectNode.set('value', entity.project.id);
            this.serviceNode.set('value', entity.service.id);
            this.descriptionNode.set('value', entity.description);
            //this.chargeableNode.set('value', activity.chargeable);
        },

        _watchercallback: function(property, oldvalue, newvalue){
            if(oldvalue == "") return;
            var activityId = this.parentWidget.entity.id;
            var activityStore = this.parentWidget.store;
            switch(this.dojoAttachPoint) {
                case "customerNode":
                    activityStore.put({id: activityId, customer: newvalue});
                    break;
                case "projectNode":
                    activityStore.put({id: activityId, project: newvalue});
                    break;
                case "serviceNode":
                    activityStore.put({id: activityId, service: newvalue});
                    break;
                case "descriptionNode":
                    activityStore.put({id: activityId, description: newvalue});
                    break;
                case "chargeableNode":
                    activityStore.put({id: activityId, chargeable: newvalue});
                    break;
                default:
                    break;
            }
        }
    });
});
