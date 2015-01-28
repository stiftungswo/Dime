/**
 * Created by Till Wegmüller on 11/13/14.
 */
define([
    'dijit/_WidgetsInTemplateMixin',
    'dijit/_TemplatedMixin',
    'dime/common/EntityBoundWidget',
    'dojo/_base/declare',
    'dojo/text!dime/widget/user/templates/UserDetailWidget.html',
    'dijit/form/TextBox',
    'dijit/form/CheckBox',
    'xstyle!dime/widget/user/css/UserDetailWidget.css'
], function ( WidgetsInTemplateMixin, TemplatedMixin,  EntityBoundWidget, declare,  template) {
    return declare("dime.widget.user.UserDetailWidget", [EntityBoundWidget, TemplatedMixin, WidgetsInTemplateMixin], {

        templateString: template,
        baseClass: "userDetailWidget",
        store:'users',
        entityType: 'users',
        independant: true,
        config: {
            values: {
                usernameNode: {
                    widgetProperty: 'value',
                    entityProperty: 'username',
                    nullValue: ''
                },
                emailNode: {
                    widgetProperty: 'value',
                    entityProperty: 'email',
                    nullValue: ''
                },
                firstnameNode: {
                    widgetProperty: 'value',
                    entityProperty: 'firstname',
                    nullValue: ''
                },
                lastnameNode: {
                    widgetProperty: 'value',
                    entityProperty: 'lastname',
                    nullValue: ''
                },
                plainpasswordNode: {},
                enabledNode: {
                    widgetProperty: 'checked',
                    entityProperty: 'enabled',
                    nullValue: ''
                },
                lockedNode: {
                    widgetProperty: 'checked',
                    entityProperty: 'locked',
                    nullValue: ''
                }
            }
        },
        _setupWatchers: function(){
            this.inherited(arguments);
            this.plainpasswordNode.watch('value', function(property, oldvalue, newvalue, caller){
                //dojo watch api seems quite Trigger Happy Return if nothing has changed
                caller = caller || this.dojoAttachPoint;
                if(oldvalue == newvalue) return;
                var handler;
                var hash = {}, optionhash = {};
                //Get The Widget who puts the Values into the Store(handler)
                if(this.handlesEntity){
                    //Seldom the case but you can have a Widget whos been watched by its parent but still handles its entity seperate from the Parent
                    handler = this;
                } else {
                    //Normal Case. eg, A Textbox inside a compound widget got updated and the compund widget puts the Values into the store
                    handler = this.getParent();
                }
                var store = handler.getStore(), entity = handler.entity;
                if(handler._blockwatcherCallback) return;
                hash['plainpassword'] = newvalue;
                optionhash['id'] = entity['id'];
                store.put(hash, optionhash).then(function (data) {
                    window.eventManager.fire('entityUpdate', handler.entitytype, {
                        entity: data,
                        changedProperty: 'plainpassword',
                        oldValue: oldvalue,
                        newValue: newvalue,
                        fromStore: true
                    });
                });
            });
        },
        _updateValues: function(entity){
            this.inherited(arguments);
            this._blockwatcherCallback = true;
            this.plainpasswordNode.set('value', '');
            this._blockwatcherCallback = false;
        }
    });
});
