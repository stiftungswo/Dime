/**
 * Created by Till Wegmüller on 11/13/14.
 */
define([
    'dijit/_WidgetsInTemplateMixin',
    'dijit/_TemplatedMixin',
    'dime/widget/_Base',
    'dojo/_base/declare',
    'dojo/text!dime/widget/project/templates/ProjectDetailWidget.html',
    'dime/widget/activity/ActivitiesTableWidget',
    'dime/widget/timeslice/TimesliceTableWidget',
    'dijit/form/TextBox',
    'dijit/form/Button',
    'dijit/form/DateTextBox',
    'dijit/form/FilteringSelect',
    'dijit/form/CheckBox',
    'xstyle!dime/widget/project/css/ProjectDetailWidget.css'
], function ( WidgetsInTemplateMixin, TemplatedMixin,  _Base, declare,  template, ActivitiesTableWidget, TimesliceTableWidget) {
    return declare("dime.widget.project.ProjectDetailWidget", [_Base, TemplatedMixin, WidgetsInTemplateMixin], {

        templateString: template,
        baseClass: "projectDetailWidget",
        store: window.storeManager.get('projects', false, true),


        _setupChildren: function(){
            this.nameNode.set('parentWidget', this);
            this.aliasNode.set('parentWidget', this);
            this.descriptionNode.set('parentWidget', this);
            this.deadlineNode.set('parentWidget', this);

            this.customerNode.set('disabled', true);
            this.customerNode.set('store', window.storeManager.get('customers', false, true));

            this.budgetPriceNode.set('disabled', true);
            this.currentPriceNode.set('disabled', true);
            this.budgetTimeNode.set('disabled', true);
            this.currentTimeNode.set('disabled', true);
            this.fixedPriceNode.set('disabled', true);

            this.rateGroupNode.set('parentWidget', this);
            this.rateGroupNode.set('store', window.storeManager.get('rategroups', false, true));

            this.chargeableNode.set('parentWidget', this);
        },

        _addcallbacks: function(){
            this.nameNode.watch('value', this._watchercallback);
            this.aliasNode.watch('value', this._watchercallback);
            this.descriptionNode.watch('value', this._watchercallback);
            this.rateGroupNode.watch('value', this._watchercallback);
            this.chargeableNode.watch('checked', this._watchercallback);
        },

        _fillValues: function(){
            this._updateValues(this.entity);
            var entity = this.entity;
            var activityStore = window.storeManager.get('activities', false, true), activityNode = this.activitiesNode;
            var timesliceStore = window.storeManager.get('timeslices', false, true), timesliceNode = this.timesliceNode;
            activityStore.query({project: entity.id}).then(function(activities){
                var activitytable = new ActivitiesTableWidget({activities: activities});
                activitytable.placeAt(activityNode);
                activitytable.startup();
            });
            timesliceStore.query({project: entity.id}).then(function(timeslices){
                var timeslicetable = new TimesliceTableWidget({timeslices: timeslices, activityquery: {project: entity.id}});
                timeslicetable.placeAt(timesliceNode);
                timeslicetable.startup();
            });
        },

        _updateValues: function(entity){
            this.inherited(arguments);
            this.nameNode.set('value', entity.name);
            this.aliasNode.set('value', entity.alias);
            this.descriptionNode.set('value', entity.description || '');
            this.rateGroupNode.set('value', entity.rateGroup ? entity.rateGroup.id : 1);
            this.customerNode.set('value', entity.customer ? entity.customer.id : 1);
            this.budgetPriceNode.set('value', entity.budgetPrice || '');
            this.currentPriceNode.set('value', entity.currentPrice || '');
            this.budgetTimeNode.set('value', entity.budgetTime || '');
            this.currentTimeNode.set('value', entity.currentTime || '');
            this.fixedPriceNode.set('value', entity.fixedPrice || '');
            this.chargeableNode.set('checked', entity.chargeable || true);
        },

        _watchercallback: function(property, oldvalue, newvalue){
            if(oldvalue == '') return;
            if(oldvalue == newvalue) return;
            //used because this points to caller not to THIS Widget. Above all elements were populated with parentwidget (THIS).
            var entity = this.parentWidget.entity;
            var store = this.parentWidget.store;
            var result;
            switch(this.dojoAttachPoint) {
                case "nameNode":
                    if(newvalue == entity.name) return;
                    result = store.put({name: newvalue}, {id: entity.id} );
                    break;
                case "aliasNode":
                    if(newvalue == entity.alias) return;
                    result = store.put({alias: newvalue}, {id: entity.id} );
                    break;
                case "descriptionNode":
                    if(newvalue == entity.description) return;
                    result = store.put({description: newvalue}, {id: entity.id} );
                    break;
                case "rateGroupNode":
                    if(newvalue == (entity.rateGroup ? entity.rateGroup.id : 0)) return;
                    result = store.put({rateGroup: newvalue}, {id: entity.id} );
                    break;
                case "chargeableNode":
                    if(newvalue == entity.chargeable) return;
                    if(newvalue == false)
                        result = store.put({chargeable: '0'}, {id: entity.id} );
                    else
                        result = store.put({chargeable: '1'}, {id: entity.id} );
                    break;
                default:
                    break;
            }
            result.then(function(data){
                window.widgetManager.update(data, 'projects');
            });
        },

        resize: function(){
            this.tabContainer.resize();
        }

    });
});
