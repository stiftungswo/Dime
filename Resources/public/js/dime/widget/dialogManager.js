define([
    'dojo/_base/declare',
    'dijit/Dialog',
    'dime/widget/storeForm'
], function (declare, Dialog) {
    return declare('dime.widget.dialogManager', [], {
        dialogs: {},
        basepath: '/api/v1',
        get: function(entity, title, props, type){
            type = type || 'new';
            //Search if dialog is already defined
            var dialog;
            if(this._hasdialog(entity+'_'+type)){
                dialog = this.dialogs[entity+'_'+type]
            }
            else {
                dialog = this._mkdialog(entity, title, type, props);
                this.dialogs[entity+'_'+type] = dialog;
            }
            return dialog;
        },
        _hasdialog: function(search){
            for (var key in this.dialogs) {
                if(key == search)return true;
            }
        },
        _mkdialog: function(entity, title, type, props){
            query = this._renderprops(props);
            return new Dialog({
                title: title,
                href: this.basepath+'/'+entity+'/'+type+query,
                onHide: function(){
                    this.getChildren().forEach(function(child){
                        if(typeof child.reset == 'function') child.reset();
                    });
                }
            });
        },
        _renderprops: function (props){
            var result = '';
            if(props) {
                result = result+'?';
                for(var key in props){
                    if( props.hasOwnProperty( key ) ) {
                        var value = props[key];
                        result = result+key+'='+value+'&';
                    }
                }
                result = result.substring(0, result.length - 1);
            }
            return result;
        }
    });
});