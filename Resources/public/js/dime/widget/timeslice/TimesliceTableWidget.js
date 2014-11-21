define([
    'dijit/_WidgetsInTemplateMixin',
    'dijit/_TemplatedMixin',
    'dime/widget/_Base',
    'dojo/_base/declare',
    'dojo/text!dime/widget/timeslice/templates/TimesliceTableWidget.html',
    'dime/widget/timeslice/TimesliceTableRowWidget'
], function (WidgetsInTemplateMixin, TemplatedMixin,  _Base, declare,  template, TimesliceTableRowWidget) {
    return declare("dime.widget.timeslice.TimesliceTableWidget", [_Base, TemplatedMixin, WidgetsInTemplateMixin], {
        templateString: template,
        baseClass: "timesliceTableWidget",
        timeslices: [],

        _setupChildren: function(){

        },

        _addcallbacks: function(){
            //ToDO: Editing Capabilities.
        },

        _fillValues: function(){
            for(var i=0; i < this.timeslices.length; i++){
                var timeslice = this.timeslices[i];
                window.widgetManager.add(timeslice, 'timeslices', TimesliceTableRowWidget, this, this.tableBody);
            }
        }
    });
});
