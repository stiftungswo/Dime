/**
 * Created by Till Wegmüller on 11/13/14.
 */
define([
    'dijit/_WidgetsInTemplateMixin',
    'dijit/_TemplatedMixin',
    'dime/widget/_Base',
    'dojo/_base/declare',
    'dojo/text!dime/widget/invoice/templates/InvoiceDetailWidget.html',
    'dime/widget/invoice/InvoiceItemTableWidget',
    'dojo/dom-prop',
    'dojo/request',
    'dime/widget/timetrack/StandardDiscountWidget',
    'dijit/form/TextBox',
    'dijit/form/Button',
    //'dime/widget/customer/CustomerDetailWidget',
    'dijit/form/FilteringSelect'
], function ( WidgetsInTemplateMixin, TemplatedMixin,  _Base, declare,  template, InvoiceItemTableWidget, domProp, request, StandardDiscountWidget) {
    return declare("dime.widget.invoice.InvoiceDetailWidget", [_Base, TemplatedMixin, WidgetsInTemplateMixin], {

        templateString: template,
        baseClass: "invoiceDetailWidget",
        store: window.storeManager.get('invoices', false, true),
        itemtable: null,

        _setupChildren: function(){
            this.nameNode.set('parentWidget', this);
            this.aliasNode.set('parentWidget', this);
            this.descriptionNode.set('parentWidget', this);
            this.projectNode.set('disabled', true);
            this.projectNode.set('store', window.storeManager.get('projects', false, true));
            this.grossNode.set('disabled', this);
            this.netNode.set('disabled', this);
            this.updateNode.set('parentWidget', this);

            //Standard Discounts
            this.addStandardDiscountSelectNode.set('parentWidget', this);
            this.addStandardDiscountSelectNode.set('store', window.storeManager.get('standarddiscounts', true));
            this.addStandardDiscountNode.set('parentWidget', this);
        },

        _addcallbacks: function(){
            this.nameNode.watch('value', this._watchercallback);
            this.aliasNode.watch('value', this._watchercallback);
            this.descriptionNode.watch('value', this._watchercallback);
            this.updateNode.on('click', function(){
                var id = this.parentWidget.entity.id, parent = this.parentWidget;
                request.get('/api/v1/invoices/'+id+'/update', {handleAs: 'json'}).then(function(data){
                    parent._updateValues(data);
                });
            });

            //StandardDiscount
            this.addStandardDiscountNode.on('click', function(){
                if(!this.parentWidget.addStandardDiscountSelectNode.item)
                {
                    alert("No discount selected");
                    return;
                }

                var standardDiscounts = [];

                if(this.parentWidget.entity.standardDiscounts){
                    this.parentWidget.entity.standardDiscounts.forEach(function(discount){
                        standardDiscounts.push(discount.id);
                    });
                }

                var newDiscountId = this.parentWidget.addStandardDiscountSelectNode.item.id;
                standardDiscounts.push(newDiscountId);

                var parentWidget = this.parentWidget;
                var discountsContainer = this.parentWidget.discountsContainer;

                //put requires to update the widget, every time...
                this.parentWidget.store.put({ standardDiscounts: standardDiscounts}, {id: this.parentWidget.entity.id}).then(function(invoice){
                    //...update hapeens here!
                    window.widgetManager.update(invoice, 'invoices');
                    invoice.standardDiscounts.forEach(function(discount){
                        if(discount.id == newDiscountId ){
                            window.widgetManager.add(discount,'standarddiscounts',StandardDiscountWidget, parentWidget, discountsContainer).set("disabled", true);
                        }
                    });
                });
            });
        },

        _fillValues: function(){
            this.itemtable = new InvoiceItemTableWidget({items: this.entity.items});
            this.itemtable.placeAt(this.itemNode);
            this.itemtable.startup();
            //Standard Discounts
            var standardDiscounts = this.entity.standardDiscounts, parentWidget = this, discountsContainer = this.discountsContainer;
            if(standardDiscounts){
                this.entity.standardDiscounts.forEach(function(entity){
                    var widget = window.widgetManager.add(entity,'standarddiscounts',StandardDiscountWidget, parentWidget, discountsContainer);
                    widget.set('disabled', true);
                    widget.set('offerId', parentWidget.entity.id);
                });
            }
            this._updateValues(this.entity);
        },

        _updateValues: function(entity){
            this.inherited(arguments);
            this.nameNode.set('value', entity.name);
            this.aliasNode.set('value', entity.alias);
            this.descriptionNode.set('value', entity.description || '');
            this.projectNode.set('value', entity.project ? entity.project.id : 1);
            //this.customerNode.set('entity', entity.customer);
            this.grossNode.set('value', entity.gross || 0);
            this.netNode.set('value', entity.net || 0);
            this.itemtable._updateValues(entity.items);
            domProp.set(this.printNode, 'href', '/api/v1/invoices/'+entity.id+'/print')
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
                default:
                    break;
            }
            result.then(function(data){
                window.widgetManager.update(data, 'invoices');
            });
        }
    });
});
