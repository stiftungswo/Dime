define([
    'dojo/_base/declare',
    'dijit/form/DateTextBox',
    'moment/moment'
], function (declare, DateTextBox, moment) {
    return declare('dime.form.DateTextBox', [DateTextBox], {
        _setValueAttr: function(value){
            if (typeof(value == "String") && value !== 'Invalid Date') {
                value = moment(value).toDate();
            }
            this.inherited(arguments);
        }
    });
});