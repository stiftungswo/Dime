'use strict';

/**
 * Dime - app/report/form.js
 */
(function ($, Backbone, _, App) {

    App.provide('Views.Report.Form', App.Views.Core.Form.Filter.extend({
        submit: function(e) {
            if (e) {
                e.preventDefault();
            }

            if (this.collection) {
                var data = this.serialize(true);

                if ("undefined" == typeof(data.limit)) {
                    // avoid limits
                    data.limit="";
                }

                // push show options to table
                if (data.show && this.options.callback) {
                    var show = data.show;
                    this.options.callback(show);
                    delete data.show;
                }

                this.collection.removeFetchData('filter');
                if (data) {
                    this.collection.addFetchData('filter', data);
                }
                this.collection.load();
            }
        }
    }));

})(jQuery, Backbone, _, Dime);
