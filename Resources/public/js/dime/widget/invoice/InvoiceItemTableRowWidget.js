define([
    'dijit/_WidgetsInTemplateMixin',
    'dijit/_TemplatedMixin',
    'dime/widget/_Base',
    'dojo/_base/declare',
    'dojo/text!dime/widget/invoice/templates/InvoiceItemTableRowWidget.html',
    'dijit/form/TextBox'
], function (WidgetsInTemplateMixin, TemplatedMixin,  _Base, declare,  template) {
    return declare("dime.widget.invoice.InvoiceItemTableRowWidget", [_Base, TemplatedMixin, WidgetsInTemplateMixin], {
        templateString: template,
        baseClass: "invoiceItemTableRowWidget",

        _setupChildren: function(){
            this.typeNode.set('disabled', true);
            this.valueNode.set('disabled', true);
            this.rateNode.set('disabled', true);
            this.rateUnitNode.set('disabled', true);
            this.chargeNode.set('disabled', true);
        },

        _addcallbacks: function(){

        },

        _fillValues: function(){
            this.inherited(arguments);
        },

        _updateValues: function(entity){
            this.inherited(arguments);
            //Because of Some Unknown Reason the typeNode is undefined when Openening the Widget more than once. Somehow it tries to set the Variable and then Fails.
            //As a workaraound this if has been introduced
            //Todo Refactor GUI to new Standard.
            if(this.typeNode){
                this.typeNode.set('value', entity.type || '');
                this.valueNode.set('value', entity.value || '');
                this.rateNode.set('value', entity.rate || '');
                this.rateUnitNode.set('value', entity.rateUnit || '');
                this.chargeNode.set('value', entity.charge || '');
            }
        }
    });
});
