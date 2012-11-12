'use strict';

/**
 * Dime - app/report/index.js
 */
(function ($, Backbone, _, App) {

    App.menu({
        name:"report",
        title:"Report",
        route:"report",
        weight: 0,
        callback:function () {
            App.UI.menu.activateItem('report');
            App.UI.router.switchView(new App.Views.Report.Index());
        }
    });

    App.provide('Views.Report.Index', App.Views.Core.Content.extend({
        template:'DimeReportBundle:Reports:index',
        events: {
            'submit #report-form': 'generate',
            'change #period': 'period'
        },
        initialize:function () {
            // Bind all to this, because you want to use
            // "this" view in callback functions
            _.bindAll(this);

            this.activities = new App.Collection.Activities();

            this.customers = App.session.get('customer-filter-collection', function () {
                return new App.Collection.Customers();
            });
            this.projects = App.session.get('project-filter-collection', function () {
                return new App.Collection.Projects();
            });
            this.services = App.session.get('service-filter-collection', function () {
                return new App.Collection.Services();
            });
        },
        render: function() {
            // Render a customer select list

            this.customerFilter = new App.Views.Core.Select({
                el: '#customer',
                collection:this.customers,
                defaults:{
                    blankText:'by customer'
                }
            }).render();
            this.customers.fetch();

            // Render a project select list
            this.projectFilter = new App.Views.Core.Select({
                el:'#project',
                collection:this.projects,
                defaults:{
                    blankText:'by project'
                }
            }).render();
            this.projects.fetch();

            // Render a service select list
            this.serviceFilter = new App.Views.Core.Select({
                el:'#service',
                collection:this.services,
                defaults:{
                    blankText:'by service'
                }
            }).render();
            this.services.fetch();

            this.tableView = new App.Views.Report.Table({
                collection: this.activities
            }).render();

            return this;
        },
        generate: function(e) {
            e.preventDefault();
            e.stopPropagation();


            var formData = $('#report-form').form().data(true),
                filter = {}, show = {};

            if (formData) {
                if (formData.customer) {
                    filter.customer = formData.customer;
                }

                if (formData.project) {
                    filter.project = formData.project;
                }

                if (formData.service) {
                    filter.service = formData.service;
                }

                // TODO Tags

                if (formData.period) {
                    var from = $('#from'),
                        to = $('#to'),
                        date = moment(from.data('date')).clone(),
                        dayFormat = 'YYYY-MM-DD';

                    switch (formData.period) {
                        case 'this-month':
                            filter.date = moment().format('YYYY-MM');
                            break;
                        case 'this-week':
                            date = moment();
                            if (date.day() === 0) {
                                date = date.subtract('days', 1);
                            }
                            filter.date = [date.day(1).format(dayFormat), date.day(7).format(dayFormat)];
                            break;
                        case 'today':
                            filter.date = moment().format(dayFormat);
                            break;
                        case 'last-month':
                            filter.date = moment().subtract('months', 1).format('YYYY-MM');
                            break;
                        case 'last-week':
                            date = moment().subtract('weeks', 1);
                            if (date.day() === 0) {
                                date = date.subtract('days', 1);
                            }
                            filter.date = [date.day(1).format(dayFormat), date.day(7).format(dayFormat)];
                            break;
                        case 'yesterday':
                            filter.date = moment().subtract('days', '1').format(dayFormat);
                            break;
                        case 'D':
                            filter.date = date.format(dayFormat);
                            break;
                        case 'W':
                            if (date.day() === 0) {
                                date = date.subtract('days', 1);
                            }
                            filter.date = [date.day(1).format(dayFormat), date.day(7).format(dayFormat)];
                            break;
                        case 'M':
                            filter.date = date.format('YYYY-MM');
                            break;
                        case 'Y':
                            filter.date = date.format('YYYY');
                            break;
                    }
                }

                if (formData['show-date']) {
                    show.date = true;
                }
                if (formData['show-start']) {
                    show.start = true;
                }
                if (formData['show-stop']) {
                    show.stop = true;
                }
                if (formData['show-duration']) {
                    show.duration = true;
                }
                if (formData['show-description']) {
                    show.description = true;
                }
            }

            this.tableView.setTableOptions(show);
            this.activities.fetch({
                data: {
                    filter: filter
                },
                wait: true
            });
        },
        period: function(e) {
            e.preventDefault();
            e.stopPropagation();
            var fromGroup = $('#from-group'),
                from = $('#from', fromGroup),
                toGroup = $('#to-group');

            if (e.currentTarget) {
                switch (e.currentTarget.value) {
                    case 'D':
                        from.attr({
                            placeholder: 'YYYY-MM-DD'
                        }).data({
                            'date-format': 'YYYY-MM-DD',
                            'date-period': 'D'
                        });
                        if (from.data('datepicker')) {
                            from.data('datepicker').update();
                            from.data('datepicker').setValue();
                        }
                        fromGroup.show();
                        toGroup.hide();
                        break;
                    case 'W':
                        from.attr({
                            placeholder: 'YYYY-MM-DD'
                        }).data({
                            'date-format': 'YYYY-MM-DD',
                            'date-period': 'W'
                        });
                        if (from.data('datepicker')) {
                            from.data('datepicker').update();
                            from.data('datepicker').setValue();
                        }
                        fromGroup.show();
                        toGroup.hide();
                        break;
                    case 'M':
                        from.attr({
                            placeholder: 'YYYY-MM'
                        }).data({
                            'date-format': 'YYYY-MM',
                            'date-period': 'M'
                        });
                        if (from.data('datepicker')) {
                            from.data('datepicker').update();
                            from.data('datepicker').setValue();
                        }
                        fromGroup.show();
                        toGroup.hide();
                        break;
                    case 'Y':
                        from.attr({
                            placeholder: 'YYYY'
                        }).data({
                            'date-format': 'YYYY',
                            'date-period': 'Y'
                        });
                        if (from.data('datepicker')) {
                            from.data('datepicker').update();
                            from.data('datepicker').setValue();
                        }
                        fromGroup.show();
                        toGroup.hide();
                        break;
                    case 'R':
                        from.attr({
                            placeholder: 'YYYY-MM-DD'
                        }).data({
                            'date-format': 'YYYY-MM-DD',
                            'date-period': 'D'
                        });
                        if (from.data('datepicker')) {
                            from.data('datepicker').update();
                            from.data('datepicker').setValue();
                        }
                        fromGroup.show();
                        toGroup.show();
                        break;
                    default:
                        fromGroup.hide();
                        toGroup.hide();
                }
            }
        }
    }));


})(jQuery, Backbone, _, Dime);
