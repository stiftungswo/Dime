'use strict';

/**
 * Dime - app/report/table.js
 */
(function ($, Backbone, _, App) {

    App.provide('Model.Report.Timeslice', Backbone.Model.extend({
        duration: function(precision, unit) {
            var duration = this.get('duration');
            if (precision && unit) {
                var base = 0;
                switch (unit) {
                    case 's':
                        base = 1;
                        break;
                    case 'm':
                        base = 60;
                        break;
                    case 'h':
                        base = 3600;
                        break;
                }

                if (base > 0) {
                    if (precision > 0 && precision < 60) {
                        var part = base * precision,
                            future = Math.floor(duration / part) * part,
                            second = (duration % part);

                        if (second > 0 && second < part) {
                            future += part;
                        }
                        duration = future;
                    } else {
                        App.notify('Precision out of range [1,60]', 'error');
                    }
                }
            }

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
                    return 1;
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
                    if (model && model.get('duration') && model.get('duration') > 0) {
                        that.timeslices.add(new App.Model.Report.Timeslice({
                            start: model.get('startedAt') ? moment(model.get('startedAt'), 'YYYY-MM-DD HH:mm:ss') : undefined,
                            stop: model.get('stoppedAt') ? moment(model.get('stoppedAt'), 'YYYY-MM-DD HH:mm:ss') : undefined,
                            description: model.relation('activity') ? model.relation('activity').get('description') : '',
                            duration: model.get('duration'),
                            created: model.get('createdAt') ? moment(model.get('createdAt'), 'YYYY-MM-DD HH:mm:ss') : undefined
                        }));
                    }
                });
                this.$el.html(temp({opt: this.tableOption}));
            }
            this.update();

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
            total.html(this.timeslices.formatDuration(this.tableOption.precision, this.tableOption['precision-unit']));
        }
    }));

})(jQuery, Backbone, _, Dime);
