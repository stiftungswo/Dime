/**
 * Created by toast on 10/10/14.
 */
define([
    "dojo/_base/declare",
    "dstore/Rest",
    "dstore/Cache",
    "dstore/extensions/jsonSchema",
    "dojo/request",
    "dstore/legacy/DstoreAdapter",
    "dojo/_base/lang",
    "dime/store/baseStore"
], function(declare, Rest, Cache, jsonSchema, request, DstoreAdapter, lang, baseStore){
    return declare("dime.store.dStore", [Rest, Cache, baseStore], {
        constructor: function(args) {
            dojo.safeMixin(this,args);
            this.inherited(arguments);
            this.setModel();
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
        legacy: function(){
            return new DstoreAdapter(this);
        }
    });
});