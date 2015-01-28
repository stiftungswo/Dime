define([
    'dojo/_base/declare',
    'dijit/form/Button'
], function (declare, Button) {
    return declare(null, {

        deleteable: false,

        startup: function(){
            this.inherited(arguments);
            if(this.deleteable) {
                var myButton = new Button({
                    label: "-",
                    class: 'danger',
                    onClick: function () {
                        this.getParent().deleteRows();
                    }
                });
                myButton.placeAt(this.actionNode);
                myButton.startup();
            }
        }
    });
});