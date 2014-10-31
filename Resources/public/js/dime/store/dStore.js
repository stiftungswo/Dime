/**
 * Created by toast on 10/10/14.
 */
define([
    "dojo/_base/declare",
    "dstore/Rest",
    "dstore/Cache",
    "dstore/extensions/jsonSchema",
    "dojo/request",
    "dojo/_base/lang"
], function(declare, Rest, Cache, jsonSchema, request, lang){
    return declare("dime.store.dStore", [Rest, Cache], {
        entity: null,
        basepath: '/api',
        apiversion: '1',
        constructor: function(args) {
            dojo.safeMixin(this,args);
            this.inherited(arguments);
            //this.setModel();
            this.setTarget();
        },
        get: function (id, options) {
            // summary:
            //		Retrieves an object by its identity. This will trigger a GET request to the server using
            //		the url `this.target + id`.
            // id: Number
            //		The identity to use to lookup the object
            // options: Object?
            //		HTTP headers. For consistency with other methods, if a `headers` key exists on this
            //		object, it will be used to provide HTTP headers instead.
            // returns: Object
            //		The object in the store that matches the given id.
            options = options || {};
            var headers = lang.mixin({ Accept: this.accepts }, this.headers, options.headers || options);
            var store = this;
            return request(this.target + '/' + id, {
                headers: headers
            }).then(function (response) {
                return store._restore(store.parse(response), true);
            });
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
        }
    });
});