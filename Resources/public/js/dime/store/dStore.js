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