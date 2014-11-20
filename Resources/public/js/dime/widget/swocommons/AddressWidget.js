define([
    'dijit/_WidgetsInTemplateMixin',
    'dijit/_TemplatedMixin',
    'dime/widget/_Base',
    'dojo/_base/declare',
    'dojo/text!dime/widget/swocommons/templates/AddressWidget.html',
    'dijit/form/NumberTextBox',
    'dijit/form/TextBox'
], function (WidgetsInTemplateMixin, TemplatedMixin, Base, declare, template) {
    return declare("dime.widget.swocommons.AddressWidget", [Base, TemplatedMixin, WidgetsInTemplateMixin], {
        templateString: template,
        baseClass: "addressWidget",

        _setupChildren: function(){
            this.streetnumberNode.set('parentWidget', this);
            this.streetNode.set('parentWidget', this);
            this.plzNode.set('parentWidget', this);
            this.cityNode.set('parentWidget', this);
            this.stateNode.set('parentWidget', this);
            this.countryNode.set('parentWidget', this);
        },

        _addcallbacks: function(){
            this.streetnumberNode.watch('value', this._watchercallback);
            this.streetNode.watch('value', this._watchercallback);
            this.plzNode.watch('value', this._watchercallback);
            this.cityNode.watch('value', this._watchercallback);
            this.stateNode.watch('value', this._watchercallback);
            this.countryNode.watch('value', this._watchercallback);
        },

        _updateValues: function(entity){
            if(entity != null){
                this.streetnumberNode.set('value', entity.streetnumber || '');
                this.streetNode.set('value', entity.street || '');
                this.plzNode.set('value', entity.plz || 0);
                this.cityNode.set('value', entity.city || '');
                this.stateNode.set('value', entity.state || '');
                this.countryNode.set('value', entity.country || '');
                this.inherited(arguments);
            }
        },

        _watchercallback: function(property, oldvalue, newvalue){
            if(oldvalue == newvalue) return;
            var entity = this.parentWidget.entity;
            if(entity != null){
                switch(this.dojoAttachPoint) {
                    case "streetnumberNode":
                        if(newvalue != entity.streetnumber)
                            entity.streetnumber = newvalue;
                        break;
                    case "streetNode":
                        if(newvalue != entity.street)
                            entity.street = newvalue;
                        break;
                    case "plzNode":
                        if(newvalue != entity.plz)
                            entity.plz = newvalue;
                        break;
                    case "cityNode":
                        if(newvalue != entity.city)
                            entity.city = newvalue;
                        break;
                    case "stateNode":
                        if(newvalue != entity.state)
                            entity.state = newvalue;
                        break;
                    case "countryNode":
                        if(newvalue != entity.country)
                            entity.country = newvalue;
                        break;
                    default:
                        break;
                }
            }
        }
    });
});
