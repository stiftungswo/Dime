define([
    'dijit/_WidgetsInTemplateMixin',
    'dijit/_TemplatedMixin',
    'dijit/_WidgetBase',
    'dojo/_base/declare',
    'dojo/text!dime/widget/timetrack/templates/ActivityWidget.html',
    "dime/widget/timetrack/TimesliceWidget",
    'dijit/Dialog',
    'dijit/registry',
    "dijit/form/FilteringSelect",
    "dijit/form/Button",
    "dijit/form/CheckBox",
    "dijit/form/Textarea",
    "xstyle!dime/widget/timetrack/css/ActivityWidget.css"
], function (WidgetsInTemplateMixin, TemplatedMixin, WidgetBase, declare, template, TimesliceWidget, Dialog, registry) {
    return declare("dime.widget.timetrack.ActivityWidget", [WidgetBase, TemplatedMixin, WidgetsInTemplateMixin], {
        templateString: template,
        baseClass: "activityWidget",
        activityId: null,
        timelsiceWidgets: [],
        store: window.activityStore,
        postMixInProperties: function () {
            this.inherited(arguments);
        },

        buildRendering: function () {
            this.inherited(arguments);
            this._setupChildWidgets();
        },


        postCreate: function () {
            this.inherited(arguments);
            var activity = this.store.get(this.activityId);
            this._fillInitialValues(activity);
            this._setupwatchers();
        },

        startup: function () {
            this.inherited(arguments);
        },

        _setupChildWidgets: function(){
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
        },

        _fillInitialValues: function(activity){
            this._updateValues(activity);
            this._createTimeslices(activity);
        },

        _createTimeslices: function(activity){
            var containerid = this.timesliceContainer, timesliceregistry = this.timelsiceWidgets;
            dojo.forEach(activity.timeslices, function(timeslice) {
                //Create new Timeslice Widget Children for each Timeslice
                var timeslicewidget = new TimesliceWidget({timeslice: timeslice});
                timeslicewidget.placeAt(containerid);
                timesliceregistry.push(timeslicewidget);
            });
        },

        _updateValues: function(activity){
            this.customerNode.set('value', activity.customer.id);
            this.projectNode.set('value', activity.project.id);
            this.serviceNode.set('value', activity.service.id);
            this.descriptionNode.set('value', activity.description);
            //this.chargeableNode.set('value', activity.chargeable);
        },

        _setupwatchers: function(){
            var _watchercallback = this._watchercallback, _destroycallback = this._destroycallback;
            this.customerNode.watch('value', _watchercallback);
            this.projectNode.watch('value', _watchercallback);
            this.serviceNode.watch('value', _watchercallback);
            this.descriptionNode.watch('value', _watchercallback);
            //this.chargeableNode.watch('checked', _watchercallback);
            this.deleteNode.on('click', _destroycallback);
            this.addtimesliceNode.on('click', this._AddTimesliceHandler);
        },

        _destroycallback: function(){
            var store = this.parentWidget.store, parentWidget = this.parentWidget;
            store.remove(parentWidget.activityId);
            parentWidget.destroy();
        },

        _AddTimesliceHandler: function(){
            var timesliceDialog = registry.byId('newTimesliceForm');
            if (typeof timesliceDialog  == 'undefined'){
                timesliceDialog = new Dialog({
                    title: "Zeiterfassen",
                    href: '/api/v1/timeslices/new'
                });
            }
            timesliceDialog.set('parentWidget', this.parentWidget);
            timesliceDialog.on('hide', this.parentWidget._updateTimeslices);
            timesliceDialog.show();
        },

        _updateTimeslices: function(){
            var p = this.parentWidget, timesliceregistry = p.timelsiceWidgets, activityId = p.activityId, container = p.timesliceContainer;
            window.timesliceStore.query({activity: activityId}).forEach(function(item){
                var widget = p._findTimesliceWidget(item.id);
                if(widget == null){
                    widget = new TimesliceWidget({timeslice: item});
                    widget.placeAt(container);
                    timesliceregistry.push(widget);
                }
                else{
                    widget._updateValues(item);
                }
            });
        },

        _findTimesliceWidget: function(timesliceId){
            this.timelsiceWidgets.forEach(function(widget){
                if(widget.timeslice.id == timesliceId) return widget;
            });
            return null;
        },

        _watchercallback: function(property, oldvalue, newvalue){
            if(oldvalue == "") return;
            var activityId = this.parentWidget.activityId;
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
