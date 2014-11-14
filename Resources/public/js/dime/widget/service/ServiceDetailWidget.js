/**
 * Created by Till Wegmüller on 11/13/14.
 */
define([
    'dijit/_WidgetsInTemplateMixin',
    'dijit/_TemplatedMixin',
    'dime/widget/_Base',
    'dojo/_base/declare',
    'dojo/text!dime/widget/service/templates/ServiceDetailWidget.html',
    'dime/widget/rate/RateWidget',
    'dijit/form/TextBox',
    'dijit/form/Button'
], function ( WidgetsInTemplateMixin, TemplatedMixin,  _Base, declare,  template, RateWidget) {
    return declare("dime.widget.service.ServiceDetailWidget", [_Base, TemplatedMixin, WidgetsInTemplateMixin], {

        templateString: template,
        baseClass: "serviceDetailWidget",
        store: window.storeManager.get('services', false, true),


        _setupChildren: function(){
            this.nameNode.set('parentWidget', this);
            this.aliasNode.set('parentWidget', this);
            this.descriptionNode.set('parentWidget', this);
            this.chargeableNode.set('parentWidget', this);
            this.vatNode.set('parentWidget', this);
            this.vatNode.set('constraints', {
                min: 0,
                max: 100,
                pattern: "#0.####%"
            });
            this.addRateNode.set('parentWidget', this);
        },

        _addcallbacks: function(){
            this.nameNode.watch('value', this._watchercallback);
            this.aliasNode.watch('value', this._watchercallback);
            this.descriptionNode.watch('value', this._watchercallback);
            this.chargeableNode.watch('value', this._watchercallback);
            this.vatNode.watch('value', this._watchercallback);
            this.addRateNode.on('click', function(){
                var RateContainer = this.parentWidget.RateContainer;
                var parentWidget = this.parentWidget;
                var store = window.storeManager.get('rates', false, true);
                var newEntity = { service: this.parentWidget.entity.id, rateGroup: 1};
                store.put(newEntity).then(function(data){
                    window.widgetManager.add(data, 'rates', RateWidget, parentWidget, RateContainer);
                });
            });
        },

        _fillValues: function(){
            var parentWidget = this, RateContainer = this.RateContainer;
            this.inherited(arguments);
            var results = window.storeManager.get('rates', true).query({service: this.entity.id});
            results.forEach(function(entity){
                window.widgetManager.add(entity, 'rates', RateWidget, parentWidget, RateContainer)
            });
        },

        _updateValues: function(entity){
            this.inherited(arguments);
            this.nameNode.set('value', entity.name);
            this.aliasNode.set('value', entity.alias);
            this.descriptionNode.set('value', entity.description ? entity.description : '');
            this.chargeableNode.set('value', entity.chargeable ? entity.chargeable : false);
            this.vatNode.set('value', entity.vat ? entity.vat : '');
        },

        _watchercallback: function(property, oldvalue, newvalue){
            if(oldvalue == newvalue) return;
            //used because this points to caller not to THIS Widget. Above all elements were populated with parentwidget (THIS).
            var entity = this.parentWidget.entity;
            var store = this.parentWidget.store;
            var result;
            switch(this.dojoAttachPoint) {
                case "nameNode":
                    if(newvalue != entity.name)
                        result = store.put({name: newvalue}, {id: entity.id} );
                    break;
                case "aliasNode":
                    if(newvalue != entity.alias)
                        result = store.put({alias: newvalue}, {id: entity.id} );
                    break;
                case "descriptionNode":
                    if(newvalue != entity.description)
                        result = store.put({description: newvalue}, {id: entity.id} );
                    break;
                case "chargeableNode":
                    if(newvalue != entity.chargeable)
                        result = store.put({chargeable: newvalue}, {id: entity.id} );
                    break;
                case "vatNode":
                    if(newvalue != entity.vat)
                        result = store.put({vat: newvalue}, {id: entity.id} );
                    break;
                default:
                    break;
            }
            result.then(function(data){
                window.widgetManager.update(data, 'services');
            });
        }

    });
});
