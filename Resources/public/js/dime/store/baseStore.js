/**
 * Created by toast on 10/8/14.
 */
define([
    "dojo/_base/declare",
    "dstore/Rest",
    "dstore/Cache",
    "dstore/Trackable",
    "dstore/extensions/jsonSchema",
    "dojo/request",
    "dojo/_base/lang"
], function(declare, Rest, Cache, Trackable, jsonSchema, request, lang){
    return declare("dime.widget.baseStore", [Rest, Cache, Trackable], {
        //base Store Class for the DimERP Frontend see https://github.com/SitePen/dstore/blob/master/Rest.js for details
        // ToDo: Test this thing
        entity: null,
        basepath: '/api',
        apiversion: '1',
        constructor: function(args) {
            dojo.safeMixin(this,args);
            this.inherited(arguments);
            this.setModel();
            this.setTarget();
        },
        getBasepath: function(){
            return this.basepath+'/v'+this.apiversion;
        },
        setModel: function(){
            var requestUrl = this.getBasepath()+'/schema/'+this.entity;
            var headers = lang.delegate(this.headers, { Accept: this.accepts });
            var schema = request.get(requestUrl, {
                method: 'GET',
                headers: headers
            });
            this.model = jsonSchema(schema);
        },
        setTarget: function(target) {
            this.target = target || this.getBasepath() + '/' + this.entity;
        }

    });
});
