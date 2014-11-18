define([
    'dijit/_WidgetsInTemplateMixin',
    'dijit/_TemplatedMixin',
    'dime/widget/_Base',
    'dojo/_base/declare',
    'dojo/text!dime/widget/swocommons/templates/PhoneWidget.html',
    'dijit/form/TextBox'
], function (WidgetsInTemplateMixin, TemplatedMixin, Base, declare, template) {
    return declare("dime.widget.swocommons.PhoneWidget", [Base, TemplatedMixin, WidgetsInTemplateMixin], {
        templateString: template,
        baseClass: "phoneWidget",

        _setupChildren: function(){
            this.telnrNode.set('parentWidget', this);
            this.teltypeNode.watch('parentWidget', this);
        },

        _addcallbacks: function(){
            this.telnrNode.watch('value', this._watchercallback);
            this.teltypeNode.watch('value', this._watchercallback);
        },

        _updateValues: function(entity){
            if(entity != null){
                this.telnrNode.set('value', entity.Number ? entity.Number : '');
                this.teltypeNode.set('value', entity.Type ? entity.Type : '');
                this.inherited(arguments);
            }
        },

        _watchercallback: function(property, oldvalue, newvalue){
            if(oldvalue == newvalue) return;
            var entity = this.parentWidget.entity;
            if(entity != null){
                switch(this.dojoAttachPoint) {
                    case "telnrNode":
                        if(newvalue != entity.number)
                            entity.number = newvalue;
                        break;
                    case "teltypeNode":
                        if(newvalue != entity.type)
                            entity.type = newvalue;
                        break;
                    default:
                        break;
                }
            }
        }
    });
});
