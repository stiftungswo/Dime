/**
 * Created by Till Wegmüller on 11/13/14.
 */
define([
    'dijit/_WidgetsInTemplateMixin',
    'dijit/_TemplatedMixin',
    'dime/widget/_Base',
    'dojo/_base/declare',
    'dojo/text!dime/widget/customer/templates/CustomerDetailWidget.html',
    'dime/widget/swocommons/PhoneWidget',
    'dime/widget/swocommons/AddressWidget',
    'dijit/form/TextBox',
    'dijit/form/FilteringSelect',
    'dijit/form/CheckBox',
    'dijit/form/Button'
], function ( WidgetsInTemplateMixin, TemplatedMixin,  _Base, declare,  template, PhoneWidget) {
    return declare("dime.widget.customer.CustomerDetailWidget", [_Base, TemplatedMixin, WidgetsInTemplateMixin], {

        templateString: template,
        baseClass: "customerDetailWidget",
        store: window.storeManager.get('customers', false, true),
        entity: null,
        childtypes: ['phones'],
        minimal: false,
        allowEdit: true,

        _setupChildren: function(){
                this.nameNode.set('parentWidget', this);
                this.aliasNode.set('parentWidget', this);
                this.chargeableNode.set('parentWidget', this);
                this.addressNode.set('parentWidget', this);
                this.addPhoneNode.set('parentWidget', this);
                this.rateGroupNode.set('parentWidget', this);
                this.rateGroupNode.set('store', window.storeManager.get('rategroups', false, true));
            if(this.minimal){
                this.chargeableNode.destroyRecursive();
                this.addPhoneNode.destroyRecursive();
                this.rateGroupNode.destroyRecursive();
            }
        },

        _handleaddChild: function(entity, entitytype){
            var parentWidget = this, timesliceContainer = this.PhoneContainer;
            if(entitytype == 'phones'){
                if(entity.activity.id == this.entity.id){
                    window.widgetManager.add(entity, 'phones', PhoneWidget, parentWidget, timesliceContainer)
                }
            }
        },

        _addcallbacks: function(){
            if(this.allowEdit){
                if(this.minimal) {
                    this.nameNode.watch('value', this._watchercallback);
                    this.aliasNode.watch('value', this._watchercallback);
                    this.addressNode.watch('entity', this._watchercallback);
                } else {
                    this.nameNode.watch('value', this._watchercallback);
                    this.aliasNode.watch('value', this._watchercallback);
                    this.chargeableNode.watch('value', this._watchercallback);
                    this.addressNode.watch('entity', this._watchercallback);
                    this.rateGroupNode.watch('value', this._watchercallback);
                    this.addPhoneNode.on('click', function(){
                        var phonestore = window.storeManager('phones', false, true), customerstore = this.parentWidget.store;
                        var entity = this.parentWidget.entity;
                        var newPhone = { Number: 0000000, Type: 'Default'};
                        phonestore.put(newPhone).then(function(phone){
                            entity.phones.push(phone.id);
                            customerstore.put({phones: entity.phones}, {id: entity.id}).then(function(customer){
                                window.widgetManager.update(customer, 'customers');
                                window.widgetManager.addChild(phone, 'phones');
                            });
                        });
                    });
                }
            }
            //ToDo: DeletePhone Action (Unlink Phone From Customer then Delete the Entity from DB.)
        },

        _fillValues: function(){
            this.inherited(arguments);
            if(this.minimal === false){
                var parentWidget = this, PhoneContainer = this.PhoneContainer;
                this.entity.phones.forEach(function(phone){
                  window.widgetManager.add(phone, 'phones', PhoneWidget, parentWidget, PhoneContainer)
                });
            }
        },

        _updateValues: function(entity){
            this.inherited(arguments);
            this.nameNode.set('value', entity.name);
            this.aliasNode.set('value', entity.alias);
            this.addressNode._updateValues(entity.address || null);
            if(this.minimal === false){
                this.rateGroupNode.set('value', entity.rateGroup ? entity.rateGroup.id : 1);
                this.chargeableNode.set('value', entity.chargeable || true);
            }
        },

        _watchercallback: function(property, oldvalue, newvalue){
            if(oldvalue == newvalue) return;
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
                case "rateGroupNode":
                    if(newvalue != (entity.rateGroup ? entity.rateGroup.id : 0))
                        result = store.put({rateGroup: newvalue}, {id: entity.id} );
                    break;
                case "chargeableNode":
                    if(newvalue != entity.chargeable)
                        if(newvalue == false)
                            result = store.put({chargeable: '0'}, {id: entity.id} );
                        else
                            result = store.put({chargeable: '1'}, {id: entity.id} );
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
