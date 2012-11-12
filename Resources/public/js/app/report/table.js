'use strict';

/**
 * Dime - app/report/table.js
 */
(function ($, Backbone, _, App) {

    App.provide('Model.Report.Timeslice', Backbone.Model.extend({
        duration: function(precision, unit) {
            var duration = this.get('duration');

            return duration;
        },
        formatDuration:function (precision, unit) {
            return App.Helper.Format.Duration(this.duration(precision, unit));
        }
    }));

    App.provide('Collection.Report.Timeslices', Backbone.Collection.extend({
        duration: function(precision, unit) {
            var duration = 0;
            this.each(function(item) {
                if (item.get('duration')) {
                    duration += item.duration(precision, unit)
                }
            });
            return duration;
        },
        formatDuration:function (precision, unit) {
            return App.Helper.Format.Duration(this.duration(precision, unit));
        }
    }));

    App.provide('Views.Report.Table', Backbone.View.extend({
        template: '#tpl-report-table',
        el: '#report-results',
        initialize: function() {
            _.bindAll(this);

            if (this.collection) {
                this.collection.on('add', this.render, this);
                this.collection.on('reset', this.render, this);
            }

            this.reset();
            this.tableOption = {};
        },
        reset: function() {
            this.timeslices = new App.Collection.Report.Timeslices();
            this.timeslices.comparator = function(first, second) {
                var firstDate = first.get('start'),
                    secondDate = second.get('start');

                if (firstDate && secondDate) {
                    if (firstDate.unix() > secondDate.unix()) {
                        return 1;
                    } else if (firstDate.unix() < secondDate.unix()) {
                        return -1;
                    } else {
                        return 0;
                    }
                } else {
                    return 0;
                }
            };
        },
        setTableOptions: function(options) {
            this.tableOption =  options;
        },
        render: function() {
            var that = this,
                temp = _.template($(this.template).html());

            if (this.timeslices.length > 0) {
                this.reset();
            }
            if (this.collection && this.collection.length > 0) {
                this.collection.each(function(model) {
                    if (model && model.relation('timeslices')) {
                        model.relation('timeslices').each(function(timeslice) {
                            if (timeslice.get('duration') && timeslice.get('duration') > 0) {
                                that.timeslices.add(new App.Model.Report.Timeslice({
                                    start: timeslice.get('startedAt') ? moment(timeslice.get('startedAt'), 'YYYY-MM-DD HH:mm:ss') : undefined,
                                    stop: timeslice.get('stoppedAt') ? moment(timeslice.get('stoppedAt'), 'YYYY-MM-DD HH:mm:ss') : undefined,
                                    description: model.get('description'),
                                    duration: timeslice.get('duration')
                                }));
                            }
                        });
                    }
                });
                this.$el.html(temp({opt: this.tableOption}));
                this.update();
            }

            return this;
        },
        update: function() {
            var that = this,
                temp = _.template($(this.template + '-data').html()),
                tbody = $('#report-table-data', this.$el),
                total = $('#report-table-total', this.$el);

            // reset
            tbody.html('');
            this.timeslices.each(function (model) {
                tbody.append(temp({ opt: that.tableOption, model: model }));
            });
            total.html(this.timeslices.formatDuration());
        }
    }));

})(jQuery, Backbone, _, Dime);
