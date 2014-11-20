define([
    '../../../dijit/_WidgetsInTemplateMixin',
    'dijit/_TemplatedMixin',
    'dime/widget/_Base',
    'dojo/_base/declare',
    'dojo/text!dime/widget/timetrack/templates/StandardDiscountWidget.html',
    'dijit/registry',
    'dijit/form/TextBox',
    'dijit/form/NumberTextBox',
    'dijit/form/CheckBox',
    'dijit/Dialog',
    'dojo/when',
    'dijit/form/Button',
    'xstyle!dime/widget/timetrack/css/StandardDiscountWidget.css',
], function (WidgetsInTemplateMixin, TemplatedMixin, _Base, declare,
             template, registry, Textbox, NumberTextBox, CheckBox,  Dialog , when) {
    return declare("dime.widget.timetrack.StandardDiscountWidget", [_Base, TemplatedMixin, WidgetsInTemplateMixin], {

        templateString: template,
        baseClass: "discountWidget",
        store: null,
        entity: null,

        _setupChildren: function(){
            this.store = window.storeManager.get('discounts', false, true);

            this.nameNode.set('parentWidget', this);
            this.minusNode.set('parentWidget', this);
            this.percentageNode.set('parentWidget', this);
            this.valueNode.set('parentWidget', this);
            this.deleteNode.set('parentWidget', this);
        },

        _addcallbacks: function(){
            this.nameNode.watch('value', this._watchercallback);
            this.minusNode.watch('value', this._watchercallback);
            this.percentageNode.watch('value', this._watchercallback);
            this.valueNode.watch('value', this._watchercallback);

            this.deleteNode.on('click', function(){

                //the widget is on the offer widget and has to remove himselve from the offer
                var offerId = null;
                if(this.parentWidget.parentWidget.baseClass === "offerWidget")
                    offerId = this.parentWidget.parentWidget.entity.id;
                if(offerId)
                {
                    var discoutIdToRemove = this.parentWidget.entity.id;
                    var offerStore = window.storeManager.get('offers', true, false);
                    var result = offerStore.get(offerId);
                    var newStandardDisocunts = [];

                    when(result, function(offer){
                        offer.standardDiscounts.forEach(function(discount){
                            if(!(discount.id == discoutIdToRemove))
                                newStandardDisocunts.push(discount.id);
                        });
                        //after put an update of the widget is necessary...
                        var update = offerStore.put({standardDiscounts: newStandardDisocunts},{id:offerId})

                        when(update, function(entity){
                            //... the update happens here!
                            window.widgetManager.update(entity, "offers");
                            window.widgetManager.update(entity, "offers");
                        });
                    });
                }
                window.widgetManager.remove(this.parentWidget.entity, 'standarddiscounts');
            });
        },

        _updateValues: function(entity){
            this.inherited(arguments);

            this.nameNode.set('value', entity.name);
            this.minusNode.set('value', entity.minus);
            this.percentageNode.set('value', entity.percentage);

            if(entity.percentage){
                this.valueNode.constraints = {
                        min: 0,
                        max: 100,
                        pattern: "#0.##%"
                };
            }
            else{
                this.valueNode.constraints = {
                    min: 0,
                    max: 10000000,
                    pattern: "#######0.##"
                };
            }
            this.valueNode.set('value', entity.value);
        },

        _watchercallback: function(property, oldvalue, newvalue){
            if(oldvalue == "") return;
            var entityid = this.parentWidget.entity.id;
            var store = this.parentWidget.store;
            var result = null;
            switch(this.dojoAttachPoint) {
                case "nameNode":
                    result = store.put({order: newvalue}, {id: entityid});
                    break;
                case "minusNode":
                    result = store.put({service: newvalue}, {id: entityid});
                    break;
                case "percentageNode":
                    result = store.put({rateValue: newvalue}, {id: entityid});
                    break;
                case "valueNode":
                    result = store.put({vat: newvalue}, {id: entityid});
                    break;
                default:
                    break;
            }
            result.then(function(data){
                window.widgetManager.update(data, 'discounts');
            });
        },

        _disable: function(){
            this.nameNode.set('disabled', true);
            this.minusNode.set('disabled', true);
            this.percentageNode.set('disabled', true);
            this.valueNode.set('disabled', true);
        }

    });
});
