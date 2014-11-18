define([
    'dijit/_WidgetsInTemplateMixin',
    'dijit/_TemplatedMixin',
    'dime/widget/_Base',
    'dojo/_base/declare',
    'dojo/text!dime/widget/offer/templates/OfferDiscountWidget.html',
    'dijit/registry',
    'dijit/form/TextBox',
    'dijit/form/NumberTextBox',
    'dijit/form/CheckBox',
    'dijit/Dialog',
    'dijit/form/Button',
    'xstyle!dime/widget/offer/css/OfferDiscountWidget.css'
], function (WidgetsInTemplateMixin, TemplatedMixin, _Base, declare,
             template, registry, Textbox, NumberTextBox, CheckBox,  Dialog ) {
    return declare("dime.widget.timetrack.OfferDiscountWidget", [_Base, TemplatedMixin, WidgetsInTemplateMixin], {

        templateString: template,
        baseClass: "offerDiscountWidget",
        store: null,
        entity: null,

        _setupChildren: function(){
            this.store = window.storeManager.get('offerdiscounts', false, true);

            this.nameNode.set('parentWidget', this);
            this.minusNode.set('parentWidget', this);
            this.minusNode.set('intermediateChanges', this);
            this.percentageNode.set('parentWidget', this);
            this.valueNode.set('parentWidget', this);
            this.deleteNode.set('parentWidget', this);
        },

        _addcallbacks: function(){

            this.nameNode.watch('value', this._watchercallback);
            this.minusNode.watch('checked', this._watchercallback);
            this.percentageNode.watch('checked', this._watchercallback);
            this.valueNode.watch('value', this._watchercallback);

            this.deleteNode.on('click', function(){
                this.parentWidget.store.remove(this.parentWidget.entity.id);
                window.widgetManager.remove(this.parentWidget.entity, 'offerdiscounts');
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
            console.log(property+" "+oldvalue+" "+newvalue);
            if(oldvalue == "") return;
            var entityid = this.parentWidget.entity.id;
            var store = this.parentWidget.store;
            var result = null;
            console.log(this.dojoAttachPoint);
            switch(this.dojoAttachPoint) {
                case "nameNode":
                    result = store.put({name: newvalue}, {id: entityid});
                    break;
                case "minusNode":
                    result = store.put({minus: newvalue}, {id: entityid});
                    break;
                case "percentageNode":
                    result = store.put({percentage: newvalue}, {id: entityid});
                    break;
                case "valueNode":
                    result = store.put({value: newvalue}, {id: entityid});
                    break;
                default:
                    break;
            }
            result.then(function(data){
                window.widgetManager.update(data, 'offerdiscounts');
            });
        }

    });
});
