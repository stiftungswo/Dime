/**
 * Created by toast on 10/7/14.
 */
define([
    "dojo/_base/declare",
    "dojox/form/Manager"
], function(declare, Manager){
    return declare("dime.widget.storeForm", [Manager], {
        store: null,
        storetype: null,
        constructor: function(args) {
            dojo.safeMixin(this,args);
            this.inherited(arguments);
            this.store = window.storeManager.get(this.storetype, false, true);
        },
        onSubmit: function(){
            var result = this.store.put(this.FormatVals(this.gatherFormValues())), storetype = this.storetype;
            result.then(function(data){
                window.widgetManager.addChild(data, storetype);
            });
            this.reset();
            this.getParent().hide();
            return false;
        },
        onReset: function(){
            this.reset();
            this.getParent().hide();
            return true;
        },
        FormatVals: function(vals){
            var returnArr = new Object();
            for (var key in vals) {
                if(typeof key == 'string' || key instanceof String){
                    if(key.indexOf("[") > -1 && key.indexOf("]") > -1) {
                        var newkey = key.split("[")[1].split("]")[0];
                        returnArr[newkey] = vals[key];
                    }
                }
            }
            return returnArr;
        }
    });
});