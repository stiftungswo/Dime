define([
    'dojo/_base/declare',
    'dijit/_WidgetBase',
    'dojo/dom-prop'
], function (declare, WidgetBase, domProp) {
    return declare('dime.widget._Base', [WidgetBase], {
        //Inherited Default Functions
        postCreate: function () {
            this.inherited(arguments);
            this._setupChildren();
            this._fillValues();
            this._setupWatchers();
            this._addcallbacks();
            this._startEventListeners();
        },

        configdefaults: {
            idProperty: 'id'
        },

        //Sample Confguration Object for Widgets
        config: {
            values: {
                //Sample of a Simple TextBox Widget
                blahNode: {
                    //The Property in the Widget to set, update and watch
                    widgetProperty: 'value',
                    //The Property from which to extract the Value form the Entity Object
                    entityProperty: 'name',
                    //The Value to use if $entityProperty does not exist in Entity Object
                    nullValue: ''
                },
                //Sample of a more Coplex widget(FilteringSelect), with aditional Properties that can be set.
                blubNode: {

                    //The Property in the Widget to set, update and watch
                    widgetProperty: 'value',
                    //The Property from which to extract the Value form the Entity Object
                    entityProperty: 'customer',
                    //The Value to use if $entityProperty does not exist in Entity Object
                    nullValue: 1,
                    //The Store for the FilteringSelect. If A string is Provided dime/store/storeManager is used to get the store.
                    store: 'customers',
                    //Tells the Logic to use this Property from the $entityProperty as the value to insert into $widgetProperty
                    idProperty: 'id',
                    //The Query Prototype to tell how should be filtered
                    queryPrototype: {
                        //This Results in ?project=1 asuming the id of entity is 1
                        project: 'id'
                    }
                },
                //Sample of a configuration of a List Widget
                fooNode:{
                    //The Widget to use to Render the Child Entity use AMD Syntax Module gets autorequired
                    childWidgetType: 'dime/widget/timeslice/TimesliceTableRowWidget',
                    //The Query Prototype to tell how should be filtered
                    queryPrototype: {
                        //This Results in ?project=1 asuming the id of entity is 1
                        project: 'id'
                    },
                    //The Header Column of the Table (Titles)
                    header: [ 'Datum', 'Mitarbeiter', 'Aktivität', 'Zeit' ],
                    //Store to use for child
                    store: 'timeslices',
                    //Type of entities the Child Renders
                    entitytype: 'timeslices'
                }
            },
            //This Configuration Property Lists Function Callbacks which should be exceuted on certain events
            callbacks: {
                //Sample Configuration of a Button that alerts Hello World
                barNode:{
                    //The Event that this callback should be bound on see dojo.on for names
                    callbackName: 'click',
                    //The Function Definition.
                    callbackFunction: function() {
                        alert('Hallo Welt!')
                    }
                },
                //Sample Configuration to show how the context of the Callback is set.
                fooNode:{
                    callbackName: 'change',
                    callbackFunction: function(){
                        //Dojo Takes Care that the context of the Callback is alway on the Widget executing the callback.
                        //Thus this refers to the TextBox which calls the Callback
                        var test = this.get('value');

                        //If you want to access the Widget in which this widget resides, use the reference getParent().
                        this.getParent().entity.test = test;
                    }
                }
            },
            //This Property Defines on which events of the dime/event/eventManager
            //The Event Manager takes care that the context is set to the Object that is listening to the Event.
            //Thus this refers to the Class in which the Config array resides.
            events:{
                //Called when entity has been sucessfully put
                event1:{
                    //Which Topic to subscribe to.
                    Topic: 'entityUpdate',
                    //Which subtopic to subscribe to
                    subTopic: 'projects',
                    //The Function to execute should event be fired.
                    eventFunction: 'somefunctionintheclassiwantexecuted'
                    //arg contains the Following Properties
                    //entity: The updated Entity
                    //changedProperty: the Property that has changed
                    //oldValue: the old Value of property
                    //newValue: the new new value of Property
                    //fromStore: if true entity has been updated via store
                },
                //Called after an entity has been sucessfully posted
                event2:{
                    //Which Topic to subscribe to.
                    Topic: 'entityCreate',
                    //Which subtopic to subscribe to
                    subTopic: 'projects',
                    //The Function to execute should event be fired.
                    eventFunction: 'somefunctionintheclassiwantexecuted'
                    //arg contains the Following Properties
                    //entity: The updated Entity
                },
                //Called after an entity has been successfully deleted
                event3:{
                    //Which Topic to subscribe to.
                    Topic: 'entityDelete',
                    //Which subtopic to subscribe to
                    subTopic: 'projects',
                    //The Function to execute should event be fired.
                    eventFunction: 'somefunctionintheclassiwantexecuted'
                    //arg contains the Following Properties
                    //entity: The updated Entity
                },
                //Called when a widget has updated its rendering
                event4:{
                    //Which Topic to subscribe to.
                    Topic: 'widgetUpdate',
                    //Which Widget has updated
                    subTopic: 'widgetid',
                    //The Function to execute should event be fired.
                    eventFunction: 'somefunctionintheclassiwantexecuted'
                    //arg contains the Following Properties
                    //widget: the widget which has been updated
                },
                //Called when a widget has been created
                event5:{
                    //Which Topic to subscribe to.
                    Topic: 'widgetCreate',
                    //Which Widget has updated
                    subTopic: 'widgetid',
                    //The Function to execute should event be fired.
                    eventFunction: 'somefunctionintheclassiwantexecuted'
                    //arg contains the Following Properties
                    //widget: the widget which has been updated
                },
                //Called when a widget has been removed
                event6:{
                    //Which Topic to subscribe to.
                    Topic: 'widgetDelete',
                    //Which Widget has updated
                    subTopic: 'widgetid',
                    //The Function to execute should event be fired.
                    eventFunction: 'somefunctionintheclassiwantexecuted'
                    //arg contains the Following Properties
                    //widget: the widget which has been updated
                    //Recursive if delete or delete Recursuve have been used to delete the Widget.
                }
            }
        },

        _blockwatcherCallback: false,

        //The Entity the Widget Displays as Javascript Object
        entity: null,

        //If the Widget handles the Entity or not
        handlesEntity: true,

        //The Store the Widget uses to Query for children
        store: null,

        //Array to store the Child Widgets
        children: [],

        //Refernce to the parent if exists
        //getParent(): null,

        //For wich types of Entity do i Want to Listen?
        //childtypes: [],

        //Tell the Logic if we watch our values ourselves, or if the parent should watch out properties.
        independant: false,

        //If Widget is disabled.
        disabled: false,

        entitytype: null,

        //Setup all Base References and the Aditional Properties defines in config Object
        _setupChildren: function(){
            var base = this, config = this.config, configdefaults = this.configdefaults, entity = this.entity;
            for(var nodeKey in config.values) {
                var attachPoint = base[nodeKey], node = config.values[nodeKey];
                if (attachPoint) {
                    if(attachPoint.set) {
                        //attachPoint.set('getParent()', base);
                        attachPoint.set('disabled', base.disabled);
                    }
                    for (var propKey in node) {
                        var prop = node[propKey];
                        if (propKey === 'store') {
                            if (typeof(prop == "String")) {
                                var store = window.storeManager.get(prop, false, true);
                            } else {
                                var store = prop;
                            }
                            attachPoint.set('store', store);
                        }
                        else if (propKey === 'queryPrototype') {
                            var query = {};
                            for (var querypropKey in prop) {
                                var queryprop = prop[querypropKey];
                                query[querypropKey] = entity[queryprop];
                            }
                            attachPoint.set('query', query);
                        }
                        else if(prop === 'base' ){
                            attachPoint.set(propKey, base);
                        }
                        else if(propKey === 'domProp'){
                            for(var domPropKey in prop){
                                var domPropVal = base._parsedomProp(prop[domPropKey]);
                                domProp.set(attachPoint, domPropKey, domPropVal);
                            }
                        }
                        else {
                            attachPoint.set(propKey, prop);
                        }
                    }
                    if (attachPoint.doStartup == false) {
                        attachPoint.set('doStartup', true);
                        attachPoint.customStartup();
                    }
                } else {
                    console.log('Wrong attachPoint '+ nodeKey);
                }
            }
        },

        //Setup all Callbacks in the Config object
        _addcallbacks: function(){
            var base = this, config = this.config, configdefaults = this.configdefaults;
            for(var nodeKey in config.callbacks){
                var attachPoint = base[nodeKey], node = config.callbacks[nodeKey];
                if(attachPoint) {
                    attachPoint.on(node.callbackName, node.callbackFunction)
                }
            }
        },

        //Setup all Watchers for the Values in the Config Object
        _setupWatchers: function(){
            var base = this, config = this.config, configdefaults = this.configdefaults;
            for (var nodeKey in config.values) {
                var attachPoint = base[nodeKey], node = config.values[nodeKey];
                if (attachPoint) {
                    if (node.independant || attachPoint.independant) {
                        //Do Nothing for Independant Nodes
                    } else {
                        attachPoint.watch(node.widgetProperty, node.watchercallback || base._watcherCallback);
                    }
                }
            }
            this.watch('disabled', this._disable);
        },

        //Called to update the Rendering
        _updateValues: function(entity){
            this.entity = entity;
            var base = this, config = this.config, configdefaults = this.configdefaults;
            base._blockwatcherCallback = true;
            for (var nodeKey in config.values) {
                var attachPoint = base[nodeKey], node = config.values[nodeKey];
                if(attachPoint) {
                    if(attachPoint.get) {
                        var focused = attachPoint.get('focused');
                    }
                    if (node.widgetProperty) {
                        if (node.widgetProperty === 'updateValues') {
                            if(node.entityProperty) {
                                attachPoint._updateValues(entity[node.entityProperty]);
                            } else {
                                attachPoint._updateValues(null);
                            }
                        } else if (node.idProperty) {
                            var value = entity[node.entityProperty];
                            if (value) {
                                if(!focused) {
                                    attachPoint.set(node.widgetProperty, value[node.idProperty]);
                                }
                            } else {
                                if(!focused) {
                                    attachPoint.set(node.widgetProperty, node.nullValue);
                                }
                            }
                        } else {
                            if(!focused) {
                                attachPoint.set(node.widgetProperty, entity[node.entityProperty] || node.nullValue);
                            }
                        }
                    }
                }
            }
            base._blockwatcherCallback = false;
        },

        //Called to tell the Widget to start filling in the Values
        _fillValues: function(){
            if(this.entity){
                this.handlesEntity = true;
                this._updateValues(this.entity);
            }
        },

        //Function to disable all Childwidgets
        _disable: function(){
            var base = this, disabled = this.disabled;
            this._attachPoints.forEach(function(node){
                var attachPoint = base[node];
                if(attachPoint.set) {
                    attachPoint.set('disabled', disabled);
                }
            });
        },

        _startEventListeners: function(){
            //Listen for Update Event of own entity
            var base = this, events = this.config.events;
            window.eventManager.subscribe('entityUpdate', base.entitytype, base.id, function(arg){
                if(arg.entity.id === base.entity.id){
                    base.updateValues(arg.entity);
                }
            });
            window.eventManager.subscribe('entityDelete', base.entitytype, base.id, function(arg){
                if(arg.entity.id === base.entity.id){
                    base.widgetDestroy();
                }
            });
            if(events) {
                for (var eventKey in events) {
                    var event = events[eventKey];
                    var topic = event.Topic, subtopic = event.subTopic, eventFunction = event.eventFunction;
                    if (topic && subtopic && eventFunction) {
                        window.eventManager.subscribe(topic, subtopic, base.id, function (arg) {
                            base[eventFunction](arg);
                        });
                    } else {
                        console.log('Configuration Error in event:');
                        console.log(event);
                    }
                }
            }
        },

        //Generic Callback for the watch function which uses the config object to update the entity if needed.
        _watcherCallback: function(property, oldvalue, newvalue, caller){
            //dojo watch api seems quite Trigger Happy Return if nothing has changed
            caller = caller || this.dojoAttachPoint;
            if(oldvalue == newvalue) return;
            var handler;
            //Get The Widget who puts the Values into the Store(handler)
            if(this.handlesEntity){
                //Seldom the case but you can have a Widget whos been watched by its parent but still handles its entity seperate from the Parent
                handler = this;
            } else {
                //Normal Case. eg, A Textbox inside a compound widget got updated and the compund widget puts the Values into the store
                handler = this.getParent();
            }
            var store = handler.getStore(), entity = handler.entity;
            var config = handler.config, configdefaults = handler.configdefaults, independant = handler.independant;
            var node = config.values[caller];
            //As dojo.watch is triggerhappy, there is a variable, which allows to manual block execution. (used by updateValues)
            if(handler._blockwatcherCallback) return;
            if (node.widgetProperty === property) {
                var hash = {}, optionhash = {};
                var idProperty = node.idProperty || configdefaults.idProperty;
                var entityProperty = node.entityProperty;
                //Check to reduce Trigger Happines i.e we got triggered because of updateValues()
                if (entity[entityProperty] == newvalue) return;
                if(node.idProperty){
                    //Same as above but for subentities
                    var subEnt = entity[entityProperty];
                    //There is some case where The Property might not be defined. We thus then want to post the default Value
                    if(subEnt) {
                        //Otherwise break trigger Happiness
                        if (subEnt[idProperty] === newvalue) return;
                    }
                }
                hash[entityProperty] = newvalue;
                if (independant) {
                    //If we manage our entity Ourselves
                    if(newvalue === false) newvalue = '0';
                    if(newvalue === true) newvalue ='1';
                    hash[entityProperty] = newvalue;
                    optionhash[idProperty] = entity[idProperty];
                    store.put(hash, optionhash).then(function (data) {
                        window.eventManager.fire('entityUpdate', handler.entitytype, {
                            entity: data,
                            changedProperty: entityProperty,
                            oldValue: oldvalue,
                            newValue: newvalue,
                            fromStore: true
                        });
                    });
                } else {
                    //If our Parent must watch what we do and then update itself, to change eg. address.
                    //Apparently In one Case it would be usefull dojo.watch is not triggerhappy. I.e when a attr of a watched object changes.
                    //So We Call the Watchercallback of our Parent
                    handler.getParent()._watcherCallback(handler.widgetProperty, null, hash, handler.dojoAttachPoint);
                }
            }
        },

        cloneEntity: function(){
            return this.clone(this.entity);
        },

        clone: function(obj){
            var copy;

            // Handle the 3 simple types, and null or undefined
            if (null == obj || "object" != typeof obj) return obj;

            // Handle Date
            if (obj instanceof Date) {
                copy = new Date();
                copy.setTime(obj.getTime());
                return copy;
            }

            // Handle Array
            if (obj instanceof Array) {
                return obj.slice(0);
            }

            // Handle Object
            if (obj instanceof Object) {
                copy = {};
                for (var attr in obj) {
                    if (obj.hasOwnProperty(attr)) copy[attr] = this.clone(obj[attr]);
                }
                return copy;
            }

            throw new Error("Unable to copy obj! Its type isn't supported.");
        },

        _parsedomProp: function(domPropVal){
            var entity = this.entity;
            if(typeof domPropVal === 'string'){
                if(domPropVal.indexOf('{') > -1){
                    if(domPropVal.split('{').length > 1 && domPropVal.split('}').length > 1) {
                        var frontofvar = domPropVal.split('{')[0];
                        var backofvar = domPropVal.split('}')[1];
                        var vartogetfromentity = domPropVal.split('{')[1].split('}')[0];
                        domPropVal = frontofvar + entity[vartogetfromentity] + backofvar;
                    } else if(domPropVal.split('{').length > 1) {
                        var frontofvar = domPropVal.split('{')[0];
                        var vartogetfromentity = domPropVal.split('{')[1];
                        domPropVal = frontofvar + entity[vartogetfromentity];
                    } else {
                        var backofvar = domPropVal.split('}')[1];
                        var vartogetfromentity = domPropVal.split('}')[0];
                        domPropVal = entity[vartogetfromentity] + backofvar;
                    }
                }
            }
            return domPropVal;
        },

        //Function to Destroy the Widget and its entity in the Remote Store.
        cleanDestroy: function(){
            var store = this.getStore(), entity = this.entity, base = this;
            if(store && entity){
                store.remove(entity.id).then(function(result){
                    window.eventManager.fire('entityDelete', base.entitytype, {result: result, entity: entity});
                    base.destroyRecursive();
                    window.eventManager.fire('widgetRemove', base.entitytype, {widget: base});
                });
            }
        },

        widgetDestroy: function(){
            var base = this;
            base.destroyRecursive();
            window.eventManager.fire('widgetRemove', base.entitytype, {widget: base});
        },

        //External Function used to tell the Widget to update its rendering
        updateValues: function(entity){
            this._updateValues(entity);
            window.eventManager.fire('widgetUpdate', this.entitytype, {widget: this });
        },

        getStore: function(){
            var store = this.store;
            if(typeof store === 'string'){
                return window.storeManager.get(store, false, true);
            }
            return store;
        },

        forceUpdate: function(){
            var store = this.getStore(), entity = this.entity, base = this;
            store.evict(entity.id);
            store.get(entity.id).then(function(result){
                base.updateValues(result);
            });
        }
    })
});