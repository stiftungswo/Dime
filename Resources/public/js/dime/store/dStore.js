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

        }

    });
});