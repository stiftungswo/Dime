/**
 * Created by toast on 10/8/14.
 */
define([
    "dojo/_base/declare"
], function(declare){
    return declare("dime.store.baseStore", [], {
        //base Store Class for the DimERP Frontend see https://github.com/SitePen/dstore/blob/master/Rest.js for details
        // ToDo: Test this thing
        entity: null,
        basepath: '/api',
        apiversion: '1',
        constructor: function(args) {
            dojo.safeMixin(this,args);
            this.inherited(arguments);
            this.setTarget();
        },
        getBasepath: function(){
            return this.basepath+'/v'+this.apiversion;
        },
        setTarget: function(target) {
            this.target = target || this.getBasepath() + '/' + this.entity;
        }
    });
});
