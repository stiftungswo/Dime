define([
    'dijit/_WidgetsInTemplateMixin',
    'dijit/_TemplatedMixin',
    'dime/widget/_Base',
    'dojo/_base/declare',
    'dojo/text!dime/widget/timeslice/templates/TimesliceTableRowWidget.html',
    'dijit/form/FilteringSelect',
    'dijit/form/Textarea',
    'dijit/form/TextBox',
    'dijit/form/NumberTextBox'
], function (WidgetsInTemplateMixin, TemplatedMixin,  _Base, declare,  template) {
    return declare("dime.widget.timeslice.TimesliceTableRowWidget", [_Base, TemplatedMixin, WidgetsInTemplateMixin], {
        templateString: template,
        baseClass: "timesliceTableRowWidget",
        store: window.storeManager.get('timeslices', false, true),
        activityquery: {},

        _setupChildren: function(){
            this.startedAtNode.set('parentWidget', this);

            this.userNode.set('parentWidget', this);
            this.userNode.set('store', window.storeManager.get('users', false, true));
            this.userNode.set('searchAttr', 'username');
            //ToDo: Add Filter for active Users at some Time

            this.activityNode.set('parentWidget', this);
            this.activityNode.set('store', window.storeManager.get('activities', false, true));
            this.activityNode.set('query', this.activityquery);

            this.durationNode.set('parentWidget', this);
        },

        _addcallbacks: function(){
            this.startedAtNode.watch('value', this._watchercallback);
            this.userNode.watch('value', this._watchercallback);
            this.activityNode.watch('value', this._watchercallback);
            this.durationNode.watch('value', this._watchercallback);
        },

        _fillValues: function(){
            this.inherited(arguments);
        },

        _updateValues: function(entity){
            this.startedAtNode.set('value', entity.startedAt || new Date());
            this.activityNode.set('value', entity.activity ? entity.activity.id : 1);
            this.userNode.set('value', entity.user ? entity.user.id : 1);
            this.durationNode.set('value', entity.duration || '0h');
        },

        _watchercallback: function(property, oldvalue, newvalue){
            if(oldvalue == newvalue) return;
            if(oldvalue == "") return;
            //used because this points to caller not to THIS Widget. Above all elements were populated with parentwidget (THIS).
            var entity = this.parentWidget.entity;
            var store = this.parentWidget.store;
            var result;
            switch(this.dojoAttachPoint) {
                case "activityNode":
                    if(newvalue == entity.activity.id) return;
                    result = store.put({activity: newvalue}, {id: entity.id});
                    break;
                case "userNode":
                    if(newvalue == entity.user.id) return;
                        result = store.put({user: newvalue}, {id: entity.id} );
                    break;
                case "startedAtNode":
                    if(newvalue == entity.startedAt) return;
                    result = store.put({startedAt: newvalue}, {id: entity.id} );
                    break;
                case "durationNode":
                    if(newvalue == entity.duration) return;
                    result = store.put({duration: newvalue}, {id: entity.id} );
                    break;
                default:
                    return;
                    break;
            }
            result.then(function(data){
                window.widgetManager.update(data, 'timeslices');
            });
        }
    });
});
