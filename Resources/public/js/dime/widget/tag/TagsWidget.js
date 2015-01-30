/**
 * Created by Till Wegmüller on 11/13/14.
 */
define([
    'dijit/_WidgetsInTemplateMixin',
    'dijit/_TemplatedMixin',
    'dime/common/EntityOverviewWidget',
    'dojo/_base/declare',
    'dojo/text!dime/widget/tag/templates/TagsWidget.html',
    'dime/widget/tag/TagGrid'
], function ( WidgetsInTemplateMixin, TemplatedMixin,  EntityOverviewWidget, declare, template) {
    return declare("dime.widget.tag.TagsWidget", [EntityOverviewWidget, TemplatedMixin, WidgetsInTemplateMixin], {

        templateString: template,
        baseClass: "tagsWidget",
        collection: 'tags'
    });
});