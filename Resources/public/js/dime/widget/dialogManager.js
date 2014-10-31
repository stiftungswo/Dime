define([
    'dojo/_base/declare',
    'dijit/Dialog'
], function (declare, Dialog) {
    return declare('dime.widget.dialogManager', [], {
        dialogs: {},
        basepath: '/api/v1',
        get: function(entity, title, type){
            type = type || 'new';
            //Search if store is already defined
            var dialog;
            if(this._hasdialog(entity+'_'+type)){
                dialog = this.dialogs[entity+'_'+type]
            }
            else {
                dialog = this._mkdialog(entity, title, type);
                this.dialogs[entity+'_'+type] = dialog;
            }
            return dialog;
        },
        _hasdialog: function(search){
            for (var key in this.dialogs) {
                if(key == search)return true;
            }
        },
        _mkdialog: function(entity, title, type){
            return new Dialog({
                title: title,
                href: this.basepath+'/'+entity+'/'+type,
                onHide: function(){
                    this.getChildren().forEach(function(child){
                        if(typeof child.reset == 'function') child.reset();
                    });
                }
            });
        }
    });
});