define([
    'dojo/_base/declare',
    'dijit/form/Button'
], function (declare, Button) {
    return declare(null, {

        creatable: false,

        startup: function(){
            this.inherited(arguments);
            if(this.creatable) {
                var myButton = new Button({
                    label: "+",
                    class: 'primary',
                    onClick: function () {
                        this.getParent().createRow();
                    }
                });
                myButton.placeAt(this.actionNode);
                myButton.startup();
            }
        }
    });
});