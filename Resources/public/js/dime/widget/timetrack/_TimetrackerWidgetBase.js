define([
    'dojo/_base/declare',
    'dijit/_WidgetBase'
], function (declare, WidgetBase) {
    return declare('dime.widget.timetrack._TimetrackerWidgetBase', [], {
        activityStore: null,
        date: new Date()
    })
});