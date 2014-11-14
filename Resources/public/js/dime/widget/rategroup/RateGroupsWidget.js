/**
 * Created by Till Wegmüller on 11/13/14.
 */
define([
    'dijit/_WidgetsInTemplateMixin',
    'dijit/_TemplatedMixin',
    'dime/widget/_Base',
    'dojo/_base/declare',
    'dojo/text!dime/widget/rategroup/templates/RateGroupsWidget.html',
    'dime/widget/rategroup/RateGroupGrid',
    'dijit/form/Button'
], function ( WidgetsInTemplateMixin, TemplatedMixin,  _Base, declare, template) {
    return declare("dime.widget.rategroup.RateGroupsWidget", [_Base, TemplatedMixin, WidgetsInTemplateMixin], {

        templateString: template,
        baseClass: "rategroupsWidget",
        store: window.storeManager.get('rategroups',false, true),


        _setupChildren: function(){
            this.GridNode.set('parentWidget', this);
            this.deleteNode.set('parentWidget', this);
            this.addNode.set('parentWidget', this);
        },

        _addcallbacks: function(){
            this.deleteNode.on('click', function(){
                //this in the button
                for(var id in this.parentWidget.GridNode.selection){
                    this.parentWidget.store.remove(id);
                }
            });
            this.addNode.on('click', function(){
                //this in the button
                this.parentWidget.store.add({ name:'NewRateGroup'});
            });
        }
    });
});

