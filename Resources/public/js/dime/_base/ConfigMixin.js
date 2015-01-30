define([
    'dojo/_base/declare'
], function (declare) {
    function getStore(store, compat){
        if (typeof(store == "String")) {
            if(compat === true){
                store = window.storeManager.adapt(store);
            }
            else {
                store = window.storeManager.get(store);
            }
        } else {
            if(compat === true && store.fetch){
                store = window.storeManager.compat(store);
            }
        }
        return store;
    }

    return declare(null, {
        //This Mixin Takes a Config Object and applies it to the Children of the Widget

        childConfig: {},

        baseConfig:{},

        events: {},

        callbacks: {},

        postMixInProperties: function () {
            this.inherited(arguments);
            this._configBase();
        },

        postCreate: function(){
            this.inherited(arguments);
            this._configChildren();
        },

        startup: function(){
            this.inherited(arguments);
            this._configEvents();
            this._configCallbacks();
        },

        _configResolvePrototype: function(proto){
            var query = {};
            var entity = this.get('entity');
            for(var propKey in proto){
                if(proto.hasOwnProperty(propKey)) {
                    var prop = proto[propKey];
                    query[propKey] = entity[prop];
                }
            }
            return query;
        },

        _configBase: function(){
            this._config(this.baseConfig, this);
        },

        _configChildren: function(){
            var base = this, config = this.childConfig;
            for(var nodeKey in config) {
                if (config.hasOwnProperty(nodeKey)) {
                    try {
                        var attachPoint = base[nodeKey];
                        var node = config[nodeKey];
                        this._config(node, attachPoint);
                    }
                    catch (err) {
                        console.error('Error while configuring attachPoint ' + nodeKey);
                        console.error(err);
                    }
                }
            }
        },

        _config: function(node, attachPoint){
            // Parse the Properties defined in the Node Object and Apply them to attachPoint
            if(!attachPoint.set) return;
            for (var propKey in node) {
                if(node.hasOwnProperty(propKey)) {
                    var prop = node[propKey];
                    try {
                        if (propKey === 'store') {
                            attachPoint.set('store', getStore(prop, true));
                        } else if (propKey === 'collection') {
                            attachPoint.set('collection', getStore(prop));
                        } else {
                            attachPoint.set(propKey, prop);
                        }
                    }
                    catch (err) {
                        console.error('Unable to set property ' + propKey + ' on attachPoint ' + attachPoint.id);
                        console.error(err);
                    }
                }
            }
        },

        _configEvents: function(){
            //Listen for Update Event of own entity
            var base = this, events = this.events;
            if(events) {
                for (var eventKey in events) {
                    if(events.hasOwnProperty(eventKey)) {
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
            }
        },

        //Setup all Callbacks in the Config object
        _configCallbacks: function(){
            var base = this, callbacks = this.callbacks;
            for(var nodeKey in callbacks){
                if(callbacks.hasOwnProperty(nodeKey)) {
                    try {
                        var attachPoint = base[nodeKey], node = callbacks[nodeKey];
                        if (attachPoint) {
                            attachPoint.on(node.callbackName, node.callbackFunction)
                        }
                    }
                    catch (err) {
                        if (node) {
                            console.error('Error While Configuring callback ' + node.callbackName + ' for attachPoint ' + nodeKey);
                        } else {
                            console.error('Error While Configuring attachPoint ' + nodeKey);
                        }
                        console.error(err);
                    }
                }
            }
        }
    });
});