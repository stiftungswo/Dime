define([
    'dojo/_base/declare'
], function (declare) {
    return declare(null, {
        //If Widget is disabled.
        disabled: false,

        //Function to disable all Childwidgets
        _setDisabledAttr: function(){
            var base = this, disabled = this.disabled;
            this._attachPoints.forEach(function(node){
                var attachPoint = base[node];
                if(attachPoint.set) {
                    attachPoint.set('disabled', disabled);
                }
            });
        }
    });
});