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
        store: 'rategroups',
        config: {
            values: {
                GridNode:{
                    collection: window.storeManager.get('rategroups')
                },
                addNode: {},
                deleteNode: {}
            },
            callbacks:{
                deleteNode:{
                    callbackName: 'click',
                    callbackFunction: function(){
                        //this in the button
                        for(var id in this.getParent().GridNode.selection){
                            this.getParent().getStore().remove(id);
                        }
                    }
                },
                addNode: {
                    callbackName: 'click',
                    callbackFunction: function(){
                        //this in the button
                        //this.getParent().getStore().add({ name:'NewRateGroup'});
                        app.newEntity('rateGroups');
                    }
                }
            }
        }
    });
});

