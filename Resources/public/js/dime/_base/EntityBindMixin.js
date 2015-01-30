define([
    'dojo/_base/declare'
], function (declare) {
    return declare(null, {

        postCreate: function () {
            this.inherited(arguments);
        },

        startup: function(){
            this.inherited(arguments);
            this._started = true;
            this._updateView(this.entity);
            this._setupWatchers();
        },

        _started: false,

        _blockwatcherCallback: false,

        //The Entity the Widget Displays as Javascript Object
        entity: null,

        //The Store/Collection the Widget uses to Update the Changes on the Entity
        //Use Parent if null
        collection: null,

        //Setup all Watchers for the Values in the Config Object
        _setupWatchers: function(){
            var base = this;
            base._attachPoints.forEach(function(attachPoint){
                var node = base[attachPoint];
                try {
                    if(node.widgetProperty){
                        node.watch(node.widgetProperty, base._watcherCallback);
                    }
                } catch(err){
                    console.error('Error While Configuring Watcher for attachPoint '+attachPoint);
                    console.error(err);
                }
            });
        },

        _setCollectionAttr: function(collection){
            this.inherited(arguments);
            var base = this;
            this.collection.on('update', function(event){
                if(event.target.id === base.get('entity').id) {
                    base.set('entity', event.target);
                }
            });
        },

        //Called to update the Rendering
        _updateView: function(entity){
            if(!entity) return;
            var base = this;
            base._blockwatcherCallback = true;
            base._attachPoints.forEach(function(attachPoint){
                var node = base[attachPoint];
                if(attachPoint === 'containerNode') return;
                if(!node.set) return;
                try {
                    var focused = node.get('focused');
                    if(node.widgetProperty){
                        if(node.queryPrototype && node.resolveProto){
                            node.set('query', base._configResolvePrototype(node.queryPrototype));
                        }
                        var value = entity[node.entityProperty];
                        if (node.idProperty) {
                            if (value) {
                                if (!focused) {
                                    node.set(node.widgetProperty, value[node.idProperty]);
                                }
                            } else {
                                if (!focused) {
                                    node.set(node.widgetProperty, node.nullValue);
                                }
                            }
                        } else {
                            if (!focused) {
                                node.set(node.widgetProperty, value || node.nullValue);
                            }
                        }
                    }
                } catch (err){
                    console.error('Error while updating rendering of '+attachPoint);
                    console.error(err);
                }
            });
            base._blockwatcherCallback = false;
        },

        //Generic Callback for the watch function
        _watcherCallback: function(property, oldvalue, newvalue, caller){
            //dojo watch api seems quite Trigger Happy Return if nothing has changed
            caller = caller || this.dojoAttachPoint;
            if(oldvalue == newvalue) return;
            var handler;
            //Get The Widget who puts the Values into the Store(handler)
            if(this.entity){
                //Seldom the case but you can have a Widget whos been watched by its parent but still handles its entity seperate from the Parent
                handler = this;
            } else {
                //Normal Case. eg, A Textbox inside a compound widget got updated and the compund widget puts the Values into the collection
                handler = this.getParent();
            }
            var collection = handler.collection, entity = handler.entity;
            var independant = handler.independant;
            var node = handler[caller];
            //As dojo.watch is triggerhappy, there is a variable, which allows to manual block execution. (used by updateValues)
            if(handler._blockwatcherCallback) return;
            if (node.widgetProperty === property) {
                var hash = {}, optionhash = {};
                var entityProperty = node.entityProperty;
                //Check to reduce Trigger Happines i.e we got triggered because of updateView()
                if (entity[entityProperty] == newvalue) return;
                if(node.idProperty){
                    //Same as above but for subentities
                    var subEnt = entity[entityProperty];
                    //There is some case where The Property might not be defined. We thus then want to post the default Value
                    if(subEnt) {
                        //Otherwise break trigger Happiness
                        if (subEnt[node.idProperty] === newvalue) return;
                    }
                }
                hash[entityProperty] = newvalue;
                if (independant) {
                    //If we manage our entity Ourselves
                    if(newvalue === false) newvalue = '0';
                    if(newvalue === true) newvalue ='1';
                    hash[entityProperty] = newvalue;
                    optionhash.id = entity.id;
                    collection.put(hash, optionhash);
                } else {
                    //If our Parent must watch what we do and then update itself, to change eg. address.
                    //Apparently In one Case it would be usefull dojo.watch is not triggerhappy. I.e when a attr of a watched object changes.
                    //So We Call the Watchercallback of our Parent
                    if(handler.widgetProperty) {
                        handler.getParent()._watcherCallback(handler.widgetProperty, null, hash, handler.dojoAttachPoint);
                    }
                }
            }
        },

        _setEntityAttr: function(entity){
            this.entity = entity;
            if(this._started) {
                this._updateView(this.entity);
            }
        },

        forceViewUpdate: function(){
            var collection = this.collection, entity = this.entity, base = this;
            collection.evict(entity.id);
            collection.get(entity.id).then(function(result){
                base.set('entity', result);
            });
        }
    });
});