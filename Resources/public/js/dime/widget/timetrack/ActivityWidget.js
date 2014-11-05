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
        store: window.storeManager.get('activities', true),

        _setupChildren: function(){
            this.projectNode.set('parentWidget', this);
            this.projectNode.set('store', window.storeManager.get('projects', true, false, true));
            this.serviceNode.set('parentWidget', this);
            this.serviceNode.set('store', window.storeManager.get('services', true, false, true));
            this.descriptionNode.set('parentWidget', this);
            this.deleteNode.set('parentWidget', this);
            //this.chargeableNode.set('parentWidget', this);
            this.addtimesliceNode.set('parentWidget', this);
        },

        _addcallbacks: function(){
            this.projectNode.watch('value', this._watchercallback);
            this.serviceNode.watch('value', this._watchercallback);
            this.descriptionNode.watch('value', this._watchercallback);
            //this.chargeableNode.watch('checked', this._watchercallback);
            this.deleteNode.on('click', this._destroyParentHandler);
            this.addtimesliceNode.on('click', function(){
                var dialog = window.dialogManager.get('timeslices', 'Zeiterfassen');
                dialog.show();
            });
        },

        _fillValues: function(){
            var addchildwidget = this._addChildWidget, parentWidget = this, timesliceContainer = this.timesliceContainer;
            this.inherited(arguments);
            var results = window.storeManager.get('timeslices', true).query({activity: this.entity.id});
            results.forEach(function(entity){
                addchildwidget(entity, TimesliceWidget, timesliceContainer, parentWidget)
            });
            this.observeHandle = results.observe(function(object, removedFrom, insertedInto){
                parentWidget._updateHandler(object, removedFrom, insertedInto, TimesliceWidget, timesliceContainer, parentWidget)
            });
        },

        _updateValues: function(entity){
            this.customerNode.innerHTML(entity.project.customer.name);
            this.projectNode.set('value', entity.project.id);
            this.serviceNode.set('value', entity.service.id);
            this.descriptionNode.set('value', entity.description);
            //this.chargeableNode.set('value', entity.chargeable);
        },

        _watchercallback: function(property, oldvalue, newvalue){
            if(oldvalue == "") return;
            var activityId = this.parentWidget.entity.id;
            var activityStore = this.parentWidget.store;
            switch(this.dojoAttachPoint) {
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
