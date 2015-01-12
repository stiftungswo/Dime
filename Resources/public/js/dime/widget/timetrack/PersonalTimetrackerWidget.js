define([
    'dijit/_WidgetsInTemplateMixin',
    'dijit/_TemplatedMixin',
    'dime/widget/_Base',
    'dojo/_base/declare',
    'dojo/text!dime/widget/timetrack/templates/PersonalTimetrackerWidget.html',
    'dime/widget/timetrack/ActivityWidget',
    'dijit/form/DateTextBox',
    'dijit/registry',
    'dijit/Dialog',
    "xstyle!dime/widget/timetrack/css/PersonalTimetrackerWidget.css"
], function (WidgetsInTemplateMixin, TemplatedMixin, Base, declare, template, ActivityWidget, DateTextBox, registry, Dialog) {
    return declare("dime.widget.timetrack.PersonalTimetrackerWidget", [Base, TemplatedMixin, WidgetsInTemplateMixin], {
        templateString: template,
        baseClass: 'personalTimetrackerWidget',
        monthNames: [ "Januar", "Februar", "März", "April", "Mai", "Juni",
            "Juli", "August", "September", "Oktober", "November", "Dezember" ],
        date: new Date(),
        observeHandle: null,
        childtypes: [ 'activities' ],
        entity: {id: 1},
        entitytype: 'entityless',
        viewtype: 'Week',
        titlebase: 'Meine aktivitäten',
        //Todo twm Refactor to newest Standards.
        _setTitle: function(){
            var titlevalue;
            switch(this.viewtype){
                case 'Week':
                    titlevalue = 'in Woche '+app.date('W', eval(this.date.getTime()/1000));
                    break;
                case 'Month':
                    titlevalue = 'im '+this.monthNames[this.date.getMonth()];
                    break;
                case 'Day':
                    titlevalue = 'am '+this.date.getDay()+'.'+this.date.getMonth()+'.'+this.date.getFullYear();
                    break;
                default:
                    titlevalue = 'Heute';
                    break;
            }
            var title = this.titlebase+' '+titlevalue;
            this.titleNode.innerHTML = title;
            this.getParent().set('title', title);
        },

        buildRendering: function () {
            window.widgetManager.register(this.entity, this.entitytype, this);
            this.inherited(arguments);
        },

        _handleaddChild: function(entity, entitytype){
            var parentWidget = this, activityContainer = this.activityContainer;
            if(entitytype == 'activities'){
                window.widgetManager.add(entity, 'activities', ActivityWidget, parentWidget, activityContainer)
            }
        },

        _fillValues: function(){
            this.dateSelectNode.set('value', this.date);
            this.inherited(arguments);
        },

        _updateValues: function(){
            var parentWidget = this, activityContainer = this.activityContainer;
            this._setTitle();
            var daterange = app.getDateRange(this.viewtype, this.date);
            var results = this.store.query({date: app.date('Y-m-d', daterange[0])+','+app.date('Y-m-d', daterange[1])});
            results.forEach(function(entity){
                window.widgetManager.add(entity, 'activities', ActivityWidget, parentWidget, activityContainer)
            });
        },

        _addcallbacks: function(){
            this.addButtonNode.on('click', function(){
                var dialog = window.dialogManager.get('activities', 'Neue Aktivität');
                dialog.show();
            });
            this.dateSelectNode.watch('value', this._watchercallback);
        },

        _setupChildren: function(){
            this.addButtonNode.set('parentWidget', this);
            this.dateSelectNode.set('parentWidget', this);
        },

        _watchercallback: function(property, oldvalue, newvalue){
            var parent = this.parentWidget;
            var date = parent.date;
            parent.date = newvalue;
            window.widgetManager.removeChildren(parent);
            parent._updateValues();
        }
    });
});
