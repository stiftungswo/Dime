/**
 * Created by Till Wegmüller on 11/13/14.
 */
define([
    'dime/common/EntityOverviewWidget',
    'dijit/_WidgetsInTemplateMixin',
    'dijit/_TemplatedMixin',
    'dojo/_base/declare',
    'dojo/text!dime/widget/project/templates/ProjectsWidget.html'
], function (EntityOverviewWidget, WidgetsInTemplateMixin, TemplatedMixin, declare, template){
    return declare("dime.widget.project.ProjectsWidget", [EntityOverviewWidget, TemplatedMixin, WidgetsInTemplateMixin], {

        templateString: template,
        baseClass: "projectsWidget",
        editTitleProperty: 'Projekt',
        editWidget: 'dime/widget/project/ProjectDetailWidget',
        collection: 'projects',
        dGrid: {
            sort: 'name',
            columns: [
                {label: 'Name', field: 'name'},
                {label: 'Alias', field: 'alias'},
                {label: 'Beschreibung', field: 'description'},
                {label: 'Verechenbar', field: 'chargeable'},
                {label: 'Deadline', field: 'deadline'}
            ]
        },
        childConfig: {},
        callbacks: {
            projectNode: {
                callbackName: 'click',
                callbackFunction: function() {
                    var base = this.getParent();
                    var targetUrl = '/api/v1/invoice/project/',
                        options = {handleAs: 'json'},
                        editWidget = 'dime/widget/invoice/InvoiceDetailWidget',
                        entitytype = 'invoices',
                        tabContainer = 'contentTabs',
                        titleProperty = 'Rechnung';
                    base.selection.forEach(function(id){
                        request.get( targetUrl + id, options ).then(function (data) {
                            window.widgetManager.addTab(
                                data,
                                entitytype,
                                editWidget,
                                tabContainer,
                                titleProperty+' (' + data.id + ')',
                                true
                            );
                        });
                    });
                }
            }
        }
    });
});

