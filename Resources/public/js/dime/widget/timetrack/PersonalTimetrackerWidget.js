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
            var daterange = this._getDateRange(this.viewtype, this.date);
            var results = this.store.query({date: this._dateFormat(daterange[0])+','+this._dateFormat(daterange[1])});
            results.forEach(function(entity){
                window.widgetManager.add(entity, 'activities', ActivityWidget, parentWidget, activityContainer)
            });
        },

        _dateFormat: function(date){
            return date.getFullYear()+'-'+('0' + (date.getMonth()+1)).slice(-2)+'-'+('0' + date.getDate()).slice(-2);
        },

        _getDateRange: function(range, date){
            if(range == 'Month'){
                return [ new Date(date.getFullYear(), date.getMonth(), 1), new Date(date.getFullYear(), date.getMonth() + 1, 0)];
            } else if(range == 'Week'){
                var d1 = new Date();
                var weekNo = app.date('W', eval(date.getTime()/1000));
                //Reset d1 to Last Monday
                var numOfdaysPastSinceLastMonday = eval(d1.getDay()- 1);
                d1.setDate(d1.getDate() - numOfdaysPastSinceLastMonday);
                //Calculate Delta of Weeks between the Week Today and the Target Week
                var weekNoToday = app.date('W', eval(d1.getTime()/1000));
                var weeksInTheFuture = eval( weekNo - weekNoToday );
                //Add the Week Delta to Date in Days
                d1.setDate(d1.getDate() + eval( 7 * weeksInTheFuture ));
                //This Results in the Monday which is Delta Weeks Past or Future of Today
                var startdate = new Date(d1.getFullYear(), d1.getMonth(), d1.getDate());
                //Now Add Six to get the Coresponding Sunday
                d1.setDate(d1.getDate() + 6);
                var enddate = new Date(d1.getFullYear(), d1.getMonth(), d1.getDate());
                return [ startdate, enddate ];
            } else {
                return [date, date];
            }
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
