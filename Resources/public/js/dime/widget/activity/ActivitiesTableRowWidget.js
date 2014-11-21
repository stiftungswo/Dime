define([
    'dijit/_WidgetsInTemplateMixin',
    'dijit/_TemplatedMixin',
    'dime/widget/_Base',
    'dojo/_base/declare',
    'dojo/text!dime/widget/activity/templates/ActivitiesTableRowWidget.html',
    'dijit/form/FilteringSelect',
    'dijit/form/Textarea',
    'dijit/form/TextBox',
    'dijit/form/NumberTextBox'
], function (WidgetsInTemplateMixin, TemplatedMixin,  _Base, declare,  template) {
    return declare("dime.widget.activity.ActivitiesTableRowWidget", [_Base, TemplatedMixin, WidgetsInTemplateMixin], {
        templateString: template,
        baseClass: "activitiesTableRowWidget",
        store: window.storeManager.get('activities', false, true),

        _setupChildren: function(){

            this.chargeNode.set('disabled', true);
            this.rateUnitNode.set('disabled', true);
            this.rateNode.set('disabled', true);

            this.serviceNode.set('parentWidget', this);
            this.serviceNode.set('store', window.storeManager.get('services', false, true));
            this.userNode.set('parentWidget', this);
            this.userNode.set('store', window.storeManager.get('users', false, true));
            this.userNode.set('searchAttr', 'username');
            this.projectNode.set('parentWidget', this);
            this.projectNode.set('store', window.storeManager.get('projects', false, true));
            this.descriptionNode.set('parentWidget', this);
            this.valueNode.set('parentWidget', this);
        },

        _addcallbacks: function(){
            this.serviceNode.watch('value', this._watchercallback);
            this.projectNode.watch('value', this._watchercallback);
            this.userNode.watch('value', this._watchercallback);
            this.descriptionNode.watch('value', this._watchercallback);
            this.valueNode.watch('value', this._watchercallback);
        },

        _fillValues: function(){
            this.inherited(arguments);
            if(this.entity.rateUnitType != 0){
                this.valueNode.set('disabled', true);
            }
        },

        _updateValues: function(entity){
            this.chargeNode.set('value', entity.charge || 0);
            this.rateUnitNode.set('value', entity.rateUnit || '');
            this.rateNode.set('value', entity.rate || 0);
            this.serviceNode.set('value', entity.service ? entity.service.id : 1);
            this.userNode.set('value', entity.user ? entity.user.id : 1);
            this.projectNode.set('value', entity.project ? entity.project.id : 1);
            this.descriptionNode.set('value', entity.description || '');
            this.valueNode.set('value', entity.value || '');
        },

        _watchercallback: function(property, oldvalue, newvalue){
            if(oldvalue == newvalue) return;
            if(oldvalue == "") return;
            //used because this points to caller not to THIS Widget. Above all elements were populated with parentwidget (THIS).
            var entity = this.parentWidget.entity;
            var store = this.parentWidget.store;
            var result;
            switch(this.dojoAttachPoint) {
                case "serviceNode":
                    if(newvalue == entity.service.id) return;
                    result = store.put({service: newvalue}, {id: entity.id});
                    break;
                case "userNode":
                    if(newvalue == entity.user.id) return;
                        result = store.put({user: newvalue}, {id: entity.id} );
                    break;
                case "projectNode":
                    if(newvalue == entity.project.id) return;
                    result = store.put({project: newvalue}, {id: entity.id} );
                    break;
                case "descriptionNode":
                    if(newvalue == entity.description) return;
                    result = store.put({description: newvalue}, {id: entity.id} );
                    break;
                case "valueNode":
                    if(newvalue == entity.value) return;
                    result = store.put({value: newvalue}, {id: entity.id} );
                    break;
                default:
                    return;
                    break;
            }
            result.then(function(data){
                window.widgetManager.update(data, 'activities');
            });
        }
    });
});
