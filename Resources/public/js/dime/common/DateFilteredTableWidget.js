define([
    'dime/table/_tableBase',
    'dime/table/_storeMixin',
    'dime/table/AddRowButtonMixin',
    'dime/table/DeleteRowButtonMixin',
    'dime/table/CheckBoxSelectionMixin',
    'dijit/_WidgetsInTemplateMixin',
    'dijit/_TemplatedMixin',
    'dojo/_base/declare',
    'dojo/text!dime/widget/templates/DateFilteredTableWidget.html',
    'dijit/form/Button',
    'dijit/form/DateTextBox'
], function (tableBase, storeMixin, AddRowButtonMixin, DeleteRowButtonMixin, CheckBoxSelectionMixin,  WidgetsInTemplateMixin, TemplatedMixin, declare, template) {
    return declare('dime.common.DateFilteredTableWidget', [
        tableBase,
        storeMixin,
        AddRowButtonMixin,
        DeleteRowButtonMixin,
        CheckBoxSelectionMixin,
        TemplatedMixin,
        WidgetsInTemplateMixin
    ], {
        templateString: template,
        independant: true,
        dateRange: {
            from: new Date(),
            to: new Date()
        },
        blockUpdate: false,
        startup: function() {
            this.inherited(arguments);
            var thisweek = app.getDateRange('Week', new Date());
            this.dateRange.from = thisweek[0];
            this.dateRange.to = thisweek[1];
            this.dateFromNode.set('value', this.dateRange.from);
            this.dateToNode.set('value', this.dateRange.to);
            this._UpdateDateQuery();
            this._InitActions();
        },

        _UpdateDateQuery: function(){
            this.query.date = app.date('Y-m-d', this.dateRange.from) + ',' + app.date('Y-m-d', this.dateRange.to);
        },

        _StepOne: function(direction, type){
            var base = this, dateRange = base.dateRange;
            base.blockUpdate = true;
            var newFromDate = app.StepDate(direction, type, 1, dateRange.from), newToDate = app.StepDate(direction, type, 1, dateRange.to);
            base.dateFromNode.set('value', newFromDate);
            dateRange.from = newFromDate;
            base.dateToNode.set('value', newToDate);
            dateRange.to = newToDate;
            base._UpdateDateQuery();
            base._updateValues();
            base.blockUpdate = false;
        },

        _InitActions: function(){
            var base = this, dateRange = base.dateRange;
            base.dateFromNode.watch('value', function(property, oldvalue, newvalue){
                if(!base.blockUpdate) {
                    dateRange.from = newvalue;
                    base._UpdateDateQuery();
                    base._updateValues();
                }
            });
            base.dateToNode.watch('value', function(property, oldvalue, newvalue){
                if(!base.blockUpdate) {
                    dateRange.to = newvalue;
                    base._UpdateDateQuery();
                    base._updateValues();
                }
            });

            base.monthbackButton.on('click', function(){
                base._StepOne('back', 'Month');
            });

            base.weekbackButton.on('click', function(){
                base._StepOne('back', 'Week');
            });

            base.daybackButton.on('click', function(){
                base._StepOne('back', 'Day');
            });

            base.monthadvanceButton.on('click', function(){
                base._StepOne('advance', 'Month');
            });

            base.weekadvanceButton.on('click', function(){
                base._StepOne('advance', 'Week');
            });

            base.dayadvanceButton.on('click', function(){
                base._StepOne('advance', 'Day');
            });
        }
    });
});
