/**
 * Created by Till Wegmüller on 11/13/14.
 */
define([
    'dijit/_WidgetsInTemplateMixin',
    'dijit/_TemplatedMixin',
    'dime/common/EntityBoundWidget',
    'dojo/_base/declare',
    'dojo/text!dime/widget/project/templates/ProjectDetailWidget.html',
    'dojo/request',
    'dime/common/GenericStoreTableWidget',
    'dime/common/DateFilteredTableWidget',
    'dijit/form/TextBox',
    'dijit/form/Button',
    'dime/form/DateTextBox',
    'dijit/form/FilteringSelect',
    'dijit/form/CheckBox',
    'dijit/layout/TabContainer',
    'dijit/layout/ContentPane',
    'xstyle!dime/widget/project/css/ProjectDetailWidget.css'
], function ( WidgetsInTemplateMixin, TemplatedMixin,  EntityBoundWidget, declare,  template, request) {
    return declare("dime.widget.project.ProjectDetailWidget", [EntityBoundWidget, TemplatedMixin, WidgetsInTemplateMixin], {

        templateString: template,
        baseClass: "projectDetailWidget",
        collection: 'projects',
        independant: true,
        childConfig: {
            nameNode: {
                widgetProperty: 'value',
                entityProperty: 'name',
                nullValue: ''
            },
            aliasNode: {
                widgetProperty: 'value',
                entityProperty: 'alias',
                nullValue: ''
            },
            descriptionNode: {
                widgetProperty: 'value',
                entityProperty: 'description',
                nullValue: ''
            },
            deadlineNode: {
                widgetProperty: 'value',
                entityProperty: 'deadline',
                nullValue: new Date()
            },
            customerNode: {
                widgetProperty: 'value',
                entityProperty: 'customer',
                nullValue: '',
                store: 'customers',
                idProperty: 'id'
            },
            rateGroupNode: {
                widgetProperty: 'value',
                entityProperty: 'rateGroup',
                nullValue: '',
                store: 'rategroups',
                idProperty: 'id'
            },
            budgetPriceNode: {
                widgetProperty: 'value',
                entityProperty: 'budgetPrice',
                nullValue: '',
                disabled: true
            },
            currentPriceNode: {
                widgetProperty: 'value',
                entityProperty: 'currentPrice',
                nullValue: '',
                disabled: true
            },
            budgetTimeNode: {
                widgetProperty: 'value',
                entityProperty: 'budgetTime',
                nullValue: '',
                disabled: true
            },
            currentTimeNode: {
                widgetProperty: 'value',
                entityProperty: 'currentTime',
                nullValue: '',
                disabled: true
            },
            fixedPriceNode: {
                widgetProperty: 'value',
                entityProperty: 'fixedPrice',
                nullValue: '',
                disabled: true
            },
            chargeableNode: {
                widgetProperty: 'value',
                entityProperty: 'chargeable',
                nullValue: true,
                disabled: true
            },
            activitiesNode: {
                childWidgetType: 'dime/widget/activity/ActivitiesTableRowWidget',
                header: ['Service', 'Projekt', 'Mitarbeiter', 'Beschreibung', 'Anzahl', 'Einheit', 'Preis per Einheit', 'Preis'],
                queryPrototype: {
                    project: 'id'
                },
                collection: 'activities',
                creatable: true,
                deleteable: true,
                parentprop: 'project'
            },
            timeslicesNode: {
                childWidgetType: 'dime/widget/timeslice/TimesliceTableRowWidget',
                queryPrototype: {
                    project: 'id'
                },
                header: ['Datum', 'Mitarbeiter', 'Aktivität', 'Menge'],
                collection: 'timeslices',
                creatable: true,
                deleteable: true,
                parentprop: 'project'
            }
        },
        callbacks:{
            invoiceNode:{
                callbackName: 'click',
                callbackFunction: function() {
                    request('/api/v1/invoices/project/' + this.getParent().entity.id, {handleAs: "json"}).then(function(entity){
                        window.widgetManager.addTab(entity, 'invoices', 'dime/widget/invoice/InvoiceDetailWidget', 'contentTabs', 'Rechnung ('+entity.id+')', true);
                    });
                }
            }
        },

        startup: function(){
            this.inherited(arguments);
            var base = this;
            var activityCollection = window.storeManager.get('activities'),
                timesliceCollection = window.storeManager.get('timeslices');
            activityCollection.on('add, update, delete', function(event){
                base.forceViewUpdate();
            });
            timesliceCollection.on('add, update, delete', function(event){
                base.forceViewUpdate();
            });
        },

        resize: function(){
            this.tabContainer.resize();
        }

    });
});
