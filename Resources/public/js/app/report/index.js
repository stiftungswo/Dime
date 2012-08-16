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
        active:true,
        callback:function () {
            App.UI.menu.activateItem('report');
            App.UI.router.switchView(new App.Views.Report.Index());
        }
    });

    App.provide('Views.Report.Index', App.Views.Core.Content.extend({
        template:'DimeReportBundle:Reports:index',
        initialize:function () {
            // Bind all to this, because you want to use
            // "this" view in callback functions
            _.bindAll(this);

        }
    }));


})(jQuery, Backbone, _, Dime);
