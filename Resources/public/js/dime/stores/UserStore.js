/**
 * Created by toast on 9/30/14.
 */
require([
    "dojo/_base/declare",
    "dojo/store/JsonRest",
    "dojo/store/Memory",
    "dojo/store/Cache",
    "dojo/store/Observable",
], function(declare, JsonRest, Memory, Cache, Observable){
    return declare('dime.stores.UserStore', [Cache],{

        "-chains-":
        {
            constructor: "manual"
        },
        constructor: function()
        {
            this.masterStore = new JsonRest({
                target: 'api/v1/users'
            });
            this.cacheStore = new Memory({});
            this.inherited(arguments, [this.masterStore, this.cacheStore]);
        }

    })
});