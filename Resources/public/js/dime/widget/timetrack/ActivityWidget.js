define([
    'dijit/_WidgetsInTemplateMixin',
    'dijit/_TemplatedMixin',
    'dime/widget/_Base',
    'dojo/_base/declare',
    'dojo/text!dime/widget/timetrack/templates/ActivityWidget.html',
    'dime/widget/timetrack/TimesliceWidget',
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
        dialogprops: {},
        childtypes: [ 'timeslices' ],
        //ToDo: Refactor to newest standards.
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

        _handleaddChild: function(entity, entitytype){
            var parentWidget = this, timesliceContainer = this.timesliceContainer;
            if(entitytype == 'timeslices'){
                if(entity.activity.id == this.entity.id){
                    window.widgetManager.add(entity, 'timeslices', TimesliceWidget, parentWidget, timesliceContainer)
                }
            }
        },

        _addcallbacks: function(){
            this.projectNode.watch('value', this._watchercallback);
            this.serviceNode.watch('value', this._watchercallback);
            this.descriptionNode.watch('value', this._watchercallback);
            //this.chargeableNode.watch('checked', this._watchercallback);
            this.deleteNode.on('click', this._destroyParentHandler);
            this.addtimesliceNode.on('click', function(){
                var props = this.parentWidget.dialogprops;
                var dialog = window.dialogManager.get('timeslices', 'Zeiterfassen', props);
                dialog.show();
            });
        },

        _fillValues: function(){
            var parentWidget = this, timesliceContainer = this.timesliceContainer;
            this.inherited(arguments);
            this.dialogprops = {activity: this.entity.id, duration: '8.5h'};
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
            var entity = this.parentWidget.entity;
            var activityStore = this.parentWidget.store;
            var result;
            switch(this.dojoAttachPoint) {
                case "projectNode":
                    if(newvalue != entity.project.id)
                        result = activityStore.put({project: newvalue}, {id: entity.id});
                    break;
                case "serviceNode":
                    if(newvalue != entity.service.id)
                        result = activityStore.put({service: newvalue}, {id: entity.id});
                    break;
                case "descriptionNode":
                    if(newvalue != entity.description)
                        result = activityStore.put({description: newvalue}, {id: entity.id});
                    break;
                case "chargeableNode":
                    if(newvalue != entity.chargeable){
                        if(newvalue == false)
                            result = store.put({chargeable: '0'}, {id: entity.id} );
                        else
                            result = store.put({chargeable: '1'}, {id: entity.id} );
                    }
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
