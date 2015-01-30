/**
 * Created by Till Wegmüller on 11/13/14.
 */
define([
    'dime/common/EntityOverviewWidget',
    'dijit/_WidgetsInTemplateMixin',
    'dijit/_TemplatedMixin',
    'dojo/_base/declare',
    'dojo/text!dime/widget/rategroup/templates/RateGroupsWidget.html',
    'dime/widget/rategroup/RateGroupGrid'
], function (EntityOverviewWidget, WidgetsInTemplateMixin, TemplatedMixin, declare, template) {
    return declare("dime.widget.rategroup.RateGroupsWidget", [EntityOverviewWidget, TemplatedMixin, WidgetsInTemplateMixin], {

        templateString: template,
        baseClass: "rategroupsWidget",
        collection: 'rategroups'
    });
});

