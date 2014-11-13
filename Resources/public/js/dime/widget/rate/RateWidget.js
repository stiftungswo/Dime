/**
 * Created by Till Wegmüller on 11/13/14.
 */
define([
    'dijit/_WidgetsInTemplateMixin',
    'dijit/_TemplatedMixin',
    'dime/widget/_Base',
    'dojo/_base/declare',
    'dojo/text!dime/widget/rate/templates/RateWidget.html',
    'dijit/form/TextBox',
    'dijit/form/NumberTextBox',
    "dijit/form/FilteringSelect",
    'dijit/form/Button'
], function ( WidgetsInTemplateMixin, TemplatedMixin,  _Base, declare,  template) {
    return declare("dime.widget.rate.RateWidget", [_Base, TemplatedMixin, WidgetsInTemplateMixin], {

        templateString: template,
        baseClass: "rateWidget",
        store: window.storeManager.get('rates', false, true),


        _setupChildren: function(){
            this.rateGroupNode.set('parentWidget', this);
            this.rateGroupNode.set('store', window.storeManager.get('rategroups', false, true));
            this.rateValueNode.set('parentWidget', this);
            this.rateUnitNode.set('parentWidget', this);
            this.rateUnitTypeNode.set('parentWidget', this);
            this.delNode.set('parentWidget', this);
        },

        _addcallbacks: function(){
            this.rateGroupNode.watch('value', this._watchercallback);
            this.rateValueNode.watch('value', this._watchercallback);
            this.rateUnitNode.watch('value', this._watchercallback);
            this.rateUnitTypeNode.watch('value', this._watchercallback);
            this.delNode.on('click', this._destroyParentHandler);
        },

        _updateValues: function(entity){
            this.inherited(arguments);
            this.rateGroupNode.set('value', entity.rateGroup ? entity.rateGroup.id : 1);
            this.rateValueNode.set('value', entity.rateValue ? entity.rateValue : 0);
            this.rateUnitNode.set('value', entity.rateUnit ? entity.rateUnit : '');
            this.rateUnitTypeNode.set('value', entity.rateUnitType ? entity.rateUnitType : '');
        },

        _watchercallback: function(property, oldvalue, newvalue){
            if(oldvalue == newvalue) return;
            //used because this points to caller not to THIS Widget. Above all elements were populated with parentwidget (THIS).
            var entity = this.parentWidget.entity;
            var store = this.parentWidget.store;
            var result;
            switch(this.dojoAttachPoint) {
                case "rateGroupNode":
                    if(newvalue != entity.rateGroup.id)
                        result = store.put({rateGroup: newvalue}, {id: entity.id} );
                    break;
                case "rateValueNode":
                    if(newvalue != entity.rateValue)
                        result = store.put({rateValue: newvalue}, {id: entity.id} );
                    break;
                case "rateUnitNode":
                    if(newvalue != entity.rateUnit)
                        result = store.put({rateUnit: newvalue}, {id: entity.id} );
                    break;
                case "rateUnitTypeNode":
                    if(newvalue != entity.rateUnitType)
                        result = store.put({rateUnitType: newvalue}, {id: entity.id} );
                    break;
                default:
                    break;
            }
            result.then(function(data){
                window.widgetManager.update(data, 'rates');
            });
        }

    });
});
