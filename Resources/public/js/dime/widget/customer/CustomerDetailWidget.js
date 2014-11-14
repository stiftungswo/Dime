/**
 * Created by Till Wegmüller on 11/13/14.
 */
define([
    'dijit/_WidgetsInTemplateMixin',
    'dijit/_TemplatedMixin',
    'dime/widget/_Base',
    'dojo/_base/declare',
    'dojo/text!dime/widget/customer/templates/CustomerDetailWidget.html',
    //'dime/widget/swocommons/PhoneWidget',
    'dime/widget/swocommons/AddressWidget',
    'dijit/form/TextBox',
    'dijit/form/FilteringSelect',
    'dijit/form/CheckBox',
    'dijit/form/Button'
], function ( WidgetsInTemplateMixin, TemplatedMixin,  _Base, declare,  template) {
    return declare("dime.widget.customer.CustomerDetailWidget", [_Base, TemplatedMixin, WidgetsInTemplateMixin], {

        templateString: template,
        baseClass: "customerDetailWidget",
        store: window.storeManager.get('customers', false, true),


        _setupChildren: function(){
            this.nameNode.set('parentWidget', this);
            this.aliasNode.set('parentWidget', this);
            //this.rateGroupNode.set('parentWidget', this);
            //this.rateGroupNode.set('parentWidget', window.storeManager.get('rategroups', false, true));
            this.chargeableNode.set('parentWidget', this);
            this.addressNode.set('parentWidget', this);
            this.addPhoneNode.set('parentWidget', this);
        },

        _addcallbacks: function(){
            this.nameNode.watch('value', this._watchercallback);
            this.aliasNode.watch('value', this._watchercallback);
            //this.rateGroupNode.watch('value', this._watchercallback);
            this.chargeableNode.watch('value', this._watchercallback);
            this.addressNode.watch('entity', this._watchercallback);
            //ToDo: Add Action (Make new Phone and then add link to Customer)
            //this.addPhoneNode.on('click', function(){
            //    var PhoneContainer = this.parentWidget.PhoneContainer;
            //    var parentWidget = this.parentWidget;
            //    var store = window.storeManager.get('phones', false, true);
            //    var newEntity = { customer: this.parentWidget.entity.id, phoneGroup: 1};
            //    store.put(newEntity).then(function(data){
            //        window.widgetManager.add(data, 'phones', PhoneWidget, parentWidget, PhoneContainer);
            //    });
            //});
            //ToDo: DeletePhone Action (Unlink Phone From Customer then Delete the Entity from DB.)
        },

        _fillValues: function(){
            //var parentWidget = this, PhoneContainer = this.PhoneContainer;
            this.inherited(arguments);
            //this.entity.phones.forEach(function(phone){
            //  window.widgetManager.add(phone, 'phones', PhoneWidget, parentWidget, PhoneContainer)
            //});
        },

        _updateValues: function(entity){
            this.inherited(arguments);
            this.nameNode.set('value', entity.name);
            this.aliasNode.set('value', entity.alias);
            //this.rateGroupNode.set('value', entity.rateGroup ? entity.rateGroup : '');
            this.chargeableNode.set('value', entity.chargeable ? entity.chargeable : false);
            this.addressNode._updateValues(entity.address ? entity.address : null);
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
                //case "rateGroupNode":
                //    if(newvalue != entity.rateGroup)
                //        result = store.put({rateGroup: newvalue}, {id: entity.id} );
                //    break;
                case "chargeableNode":
                    if(newvalue != entity.chargeable)
                        result = store.put({chargeable: newvalue}, {id: entity.id} );
                    break;
                case "addressNode":
                    if(newvalue != entity.address)
                        result = store.put({address: newvalue}, {id: entity.id} );
                    break;
                default:
                    break;
            }
            result.then(function(data){
                window.widgetManager.update(data, 'customers');
            });
        }

    });
});
