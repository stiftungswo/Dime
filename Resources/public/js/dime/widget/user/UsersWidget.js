/**
 * Created by Till Wegmüller on 11/13/14.
 */
define([
    'dijit/_WidgetsInTemplateMixin',
    'dijit/_TemplatedMixin',
    'dime/widget/_Base',
    'dojo/_base/declare',
    'dojo/text!dime/widget/user/templates/UsersWidget.html',
    'dojo/when',
    'dojo/request',
    'dime/widget/user/UserGrid',
    'dijit/form/Button'
], function ( WidgetsInTemplateMixin, TemplatedMixin,  _Base, declare, template, when){
    return declare("dime.widget.user.UsersWidget", [_Base, TemplatedMixin, WidgetsInTemplateMixin], {

        templateString: template,
        baseClass: "usersWidget",
        store: 'users',
        config: {
            values: {
                GridNode:{
                    store: 'users'
                },
                editNode: {},
                addNode: {}
            },
            callbacks:{
                editNode:{
                    callbackName: 'click',
                    callbackFunction: function(){
                        //this in the button
                        for(var id in this.getParent().GridNode.selection){
                            when(this.getParent().getStore().get(id)).then(function(item){
                                window.widgetManager.addTab(item, 'users', 'dime/widget/user/UserDetailWidget', 'contentTabs', 'Mitarbeiter ('+item.id+')', true);
                            });
                        }
                    }
                },
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
                        //this.getParent().getStore().add({ username:'New User', email:'new@user.com', plainpassword:''});
                    }
                }
            }
        }
    });
});

