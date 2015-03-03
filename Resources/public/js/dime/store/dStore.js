/**
 * Created by toast on 10/10/14.
 */
define([
    "dojo/_base/declare",
    "dstore/Rest",
    "dstore/Cache",
    "dstore/Trackable",
    "dojo/request",
    "dojo/_base/lang",
    "dojo/when"
], function(declare, Rest, Cache, Trackable, request, lang, when){
    return declare("dime.store.dStore", [Rest, Cache, Trackable], {
        entity: null,
        basepath: '/api',
        apiversion: '1',
        constructor: function(args) {
            dojo.safeMixin(this,args);
            this.inherited(arguments);
            //this.setModel();
            this.setTarget();
        },

        setModel: function(){
            var requestUrl = this.getBasepath()+'/schemas/'+this.entity+'.json';
            var headers = lang.delegate(this.headers, { Accept: this.accepts });
            var schema = request.get(requestUrl, {
                method: 'GET',
                headers: headers
            });
            this.model = jsonSchema(schema);
        },

        getBasepath: function(){
            return this.basepath+'/v'+this.apiversion;
        },

        setTarget: function(target) {
            this.target = target || this.getBasepath() + '/' + this.entity;
        },

        newEntity: function(options) {
            options = options || {};
            var headers = lang.mixin({ Accept: this.accepts }, this.headers, options.headers);
            var query = options.query || {};
            var store = this;
            var initialResponse = request(this.target + '/new', {
                headers: headers,
                query: query
            });
            return initialResponse.then(function (response) {
                var event = {};

                var result = event.target = store._restore(store.parse(response), true);

                when(initialResponse.response, function (httpResponse) {
                    if(httpResponse.status === 200) {
                        store.emit('add', event);
                    }
                });
                return result;
            });

        },

        duplicate: function(id, options){
            options = options || {};
            var headers = lang.mixin({ Accept: this.accepts }, this.headers, options.headers);
            var store = this;
            var initialResponse = request(this.target + '/' + id + '/duplicate', {
                headers: headers,
                method: 'PATCH'
            });
            return initialResponse.then(function (response) {
                var event = {};

                var result = event.target = store._restore(store.parse(response), true);

                when(initialResponse.response, function (httpResponse) {
                    if(httpResponse.status === 200) {
                        store.emit('add', event);
                    }
                });
                return result;
            });
        },

        patch: function (object, options) {
            // summary:
            //		Stores an object. This will trigger a PUT request to the server
            //		if the object has an id, otherwise it will trigger a POST request.
            // object: Object
            //		The object to store.
            // options: __PutDirectives?
            //		Additional metadata for storing the data.  Includes an 'id'
            //		property if a specific id is to be used.
            // returns: dojo/_base/Deferred
            options = options || {};
            var id = ('id' in options) ? options.id : this.getIdentity(object);
            var hasId = typeof id !== 'undefined';
            var store = this;

            var positionHeaders = 'beforeId' in options
                ? (options.beforeId === null
                ? {'Put-Default-Position': 'end'}
                : {'Put-Before': options.beforeId})
                : (!hasId || options.overwrite === false
                ? {'Put-Default-Position': (this.defaultNewToStart ? 'start' : 'end')}
                : null);

            var initialResponse = request(hasId ? this.target + '/' + id : this.target, {
                method: 'PATCH',
                data: this.stringify(object),
                headers: lang.mixin({
                    'Content-Type': 'application/json',
                    Accept: this.accepts,
                    'If-Match': options.overwrite === true ? '*' : null,
                    'If-None-Match': options.overwrite === false ? '*' : null
                }, positionHeaders, this.headers, options.headers)
            });
            return initialResponse.then(function (response) {
                var event = {};

                if ('beforeId' in options) {
                    event.beforeId = options.beforeId;
                }

                var result = event.target = store._restore(store.parse(response), true) || object;

                when(initialResponse.response, function (httpResponse) {
                    if(httpResponse.status === 200) {
                        store.emit('update', event);
                    }
                });

                return result;
            });
        }
    });
});