define([
    'dijit/_WidgetsInTemplateMixin',
    'dijit/_TemplatedMixin',
    'dojo/_base/declare',
    'dime/common/EntityOverviewWidget',
    'dojo/text!dime/widget/offer/templates/OffersWidget.html',
    'dojo/request',
    'dime/common/Grid'
], function ( WidgetsInTemplateMixin, TemplatedMixin, declare, EntityOverviewWidget, template, request) {
    return declare("dime.widget.offer.OffersWidget", [
        EntityOverviewWidget,
        TemplatedMixin,
        WidgetsInTemplateMixin
    ], {
        templateString: template,
        baseClass: "offersWidget",
        editTitleProperty: 'Offerte',
        editWidget: 'dime/widget/offer/OfferDetailWidget',
        collection: 'offers',
        dGrid: {
            sort: 'name',
            columns: [
                {label: 'ID', field: 'id', sortable: true},
                {label: 'Name', field: 'name', sortable: true},
                {label: 'Kunde', field: 'customer', formatter: function(data){
                    return data ? data.name+" ("+data.alias+")" : null;
                }},
                {label: 'Status', field: 'status', formatter: function(data){
                    return data? data.text : null;
                }},
                {label: 'Verantwortlich', field: 'accountant', sortable: true, formatter: function(data){
                    return data ? data.firstname +" "+data.lastname : null;
                }}
            ]
        },
        childConfig: {},
        baseConfig:{},
        callbacks: {
            projectNode: {
                callbackName: 'click',
                callbackFunction: function() {
                    var base = this.getParent();
                    base.selection.forEach(function(id){
                        request.get( '/api/v1/projects/offer/' + id, {handleAs: 'xml'} ).then(function (data) {
                            window.widgetManager.addTab(
                                data,
                                'projects',
                                'dime/widget/project/ProjectDetailWidget',
                                'contentTabs',
                                'Projekt'+' (' + data.id + ')',
                                true
                            );
                        });
                    });
                }
            }
        }
    });
});
