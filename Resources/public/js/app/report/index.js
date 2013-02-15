'use strict';

/**
 * Dime - app/report/index.js
 */
(function ($, Backbone, _, App) {

    App.menu.add({
        id:"report",
        title:"Report",
        route:"report",
        weight: 0,
        callback:function () {
            App.menu.activateItem('report');
            App.router.switchView(new App.Views.Report.Index());
        }
    });

    App.provide('Views.Report.Index', App.Views.Core.Content.extend({
        template:'DimeReportBundle:Reports:index',
        initialize:function () {
            this.timeslices = new App.Collection.Timeslices();
        },
        render: function() {
            var that = this;

            this.tableView = new App.Views.Report.Table({
                collection: this.timeslices
            }).render();

            this.form = new App.Views.Report.Form({
                el: '#report-form',
                collection: this.timeslices,
                options: {
                    widgets: {
                        dateperiod: new App.Views.Core.Widget.DatePeriod({
                            el: '#tab-date',
                            options: {
                                ui: {
                                    period: '#period',
                                    from: '#period-from',
                                    fromGroup: '#period-from-group',
                                    to: '#period-to',
                                    toGroup: '#period-to-group'
                                },
                                events:{
                                    'change #period': 'periodChange'
                                }
                            }
                        }),
                        customer: new App.Views.Core.Widget.Select({
                            el: '#customer',
                            collection: App.session.get('customer-filter-collection', function () {
                                return new App.Collection.Customers();
                            })
                        }),
                        project: new App.Views.Core.Widget.Select({
                            el: '#project',
                            collection: App.session.get('project-filter-collection', function () {
                                return new App.Collection.Projects();
                            })
                        }),
                        service: new App.Views.Core.Widget.Select({
                            el: '#service',
                            collection: App.session.get('service-filter-collection', function () {
                                return new App.Collection.Services();
                            })
                        }),
                        withTags: new App.Views.Core.Widget.Select({
                            el: '#withTags',
                            collection: App.session.get('tag-filter-collection', function () {
                                return new App.Collection.Tags();
                            })
                        }),
                        withoutTags: new App.Views.Core.Widget.Select({
                            el: '#withoutTags',
                            collection: App.session.get('tag-filter-collection', function () {
                                return new App.Collection.Tags();
                            })
                        })
                    },
                    callback: function(show) {
                        that.tableView.setTableOptions(show);
                    }
                }
            });
            this.form.render();

            return this;
        }
//        generate: function(e) {
//            e.preventDefault();
//            e.stopPropagation();
//
//
//            var formData = $('#report-form').form().data(true),
//                filter = {}, show = {};
//
//            if (formData) {
//                for (var name in formData) {
//                    if (formData.hasOwnProperty(name)) {
//                        if (name.search(/show-/) >= 0) {
//                            show[name.replace('show-', '')] = formData[name];
//                        } else {
//                            switch (name) {
//                                case 'period':
//                                    var from = $('#from'),
//                                        to = $('#to'),
//                                        date = moment(from.data('date')).clone(),
//                                        dayFormat = 'YYYY-MM-DD';
//
//                                    switch (formData.period) {
//                                        case 'this-month':
//                                            filter.date = moment().format('YYYY-MM');
//                                            break;
//                                        case 'this-week':
//                                            date = moment();
//                                            if (date.day() === 0) {
//                                                date = date.subtract('days', 1);
//                                            }
//                                            filter.date = [date.day(1).format(dayFormat), date.day(7).format(dayFormat)];
//                                            break;
//                                        case 'today':
//                                            filter.date = moment().format(dayFormat);
//                                            break;
//                                        case 'last-month':
//                                            filter.date = moment().subtract('months', 1).format('YYYY-MM');
//                                            break;
//                                        case 'last-week':
//                                            date = moment().subtract('weeks', 1);
//                                            if (date.day() === 0) {
//                                                date = date.subtract('days', 1);
//                                            }
//                                            filter.date = [date.day(1).format(dayFormat), date.day(7).format(dayFormat)];
//                                            break;
//                                        case 'yesterday':
//                                            filter.date = moment().subtract('days', '1').format(dayFormat);
//                                            break;
//                                        case 'D':
//                                            filter.date = date.format(dayFormat);
//                                            break;
//                                        case 'W':
//                                            if (date.day() === 0) {
//                                                date = date.subtract('days', 1);
//                                            }
//                                            filter.date = [date.day(1).format(dayFormat), date.day(7).format(dayFormat)];
//                                            break;
//                                        case 'M':
//                                            filter.date = date.format('YYYY-MM');
//                                            break;
//                                        case 'Y':
//                                            filter.date = date.format('YYYY');
//                                            break;
//                                    }
//                                    break;
//                                case 'from':
//                                case 'to':
//                                    continue;
//                                    break;
//                                default:
//                                    filter[name] = formData[name];
//                            }
//                        }
//                    }
//                }
//            }
//
//            this.tableView.setTableOptions(show);
//            this.timeslices.fetch({
//                data: {
//                    filter: filter
//                },
//                wait: true
//            });
//        }
    }));


})(jQuery, Backbone, _, Dime);
