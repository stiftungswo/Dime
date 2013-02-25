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
                widgets: {
                    dateperiod: new App.Views.Core.Widget.DatePeriod({
                        el: '#tab-date',
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
            });
            this.form.render();

            return this;
        }
    }));


})(jQuery, Backbone, _, Dime);
