define([
    'dijit/_WidgetsInTemplateMixin',
    'dijit/_TemplatedMixin',
    'dime/widget/_Base',
    'dojo/_base/declare',
    'dojo/text!dime/widget/timetrack/templates/ActivityWidget.html',
    "dime/widget/timetrack/TimesliceWidget",
    'dijit/registry',
    "dijit/form/FilteringSelect",
    "dijit/form/Button",
    "dijit/form/CheckBox",
    "dijit/form/Textarea",
    "xstyle!dime/widget/timetrack/css/ActivityWidget.css"
], function (WidgetsInTemplateMixin, TemplatedMixin, Base, declare, template, TimesliceWidget, registry) {
    return declare("dime.widget.timetrack.ActivityWidget", [Base, TemplatedMixin, WidgetsInTemplateMixin], {
        templateString: template,
        baseClass: "activityWidget",
        store: window.storeManager.get('activities', false, true),

        _setupChildren: function(){
            this.projectNode.set('parentWidget', this);
            this.projectNode.set('store', window.storeManager.get('projects', true));
            this.serviceNode.set('parentWidget', this);
            this.serviceNode.set('store', window.storeManager.get('services', true));
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
            var parentWidget = this, timesliceContainer = this.timesliceContainer;
            this.inherited(arguments);
            var timeslicestore = window.storeManager.get('timeslices', false, true);
            var results = timeslicestore.query({activity: this.entity.id});
            results.forEach(function(entity){
                window.widgetManager.add(entity, 'timeslices', TimesliceWidget, parentWidget, timesliceContainer)
            });
        },

        _updateValues: function(entity){
            this.inherited(arguments);
            this.customerNode.set('value', entity.project.customer.name);
            this.projectNode.set('value', entity.project.id);
            this.serviceNode.set('value', entity.service.id);
            this.descriptionNode.set('value', entity.description);
            //this.chargeableNode.set('value', entity.chargeable);
        },

        _watchercallback: function(property, oldvalue, newvalue){
            if(oldvalue == "") return;
            var activityId = this.parentWidget.entity.id;
            var activityStore = this.parentWidget.store;
            var result;
            switch(this.dojoAttachPoint) {
                case "projectNode":
                    result = activityStore.put({project: newvalue}, {id: activityId});
                    break;
                case "serviceNode":
                    result = activityStore.put({service: newvalue}, {id: activityId});
                    break;
                case "descriptionNode":
                    result = activityStore.put({description: newvalue}, {id: activityId});
                    break;
                case "chargeableNode":
                    result = activityStore.put({chargeable: newvalue}, {id: activityId});
                    break;
                default:
                    break;
            }
            result.then(function(data){
                window.widgetManager.update(data, 'activities');
            });
        }
    });
});
