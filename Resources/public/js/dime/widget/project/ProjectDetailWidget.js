/**
 * Created by Till Wegmüller on 11/13/14.
 */
define([
    'dijit/_WidgetsInTemplateMixin',
    'dijit/_TemplatedMixin',
    'dime/widget/_Base',
    'dojo/_base/declare',
    'dojo/text!dime/widget/project/templates/ProjectDetailWidget.html',
    'dojo/request',
    'dime/widget/GenericTableWidget',
    'dijit/form/TextBox',
    'dijit/form/Button',
    'dijit/form/DateTextBox',
    'dijit/form/FilteringSelect',
    'dijit/form/CheckBox',
    'dijit/layout/TabContainer',
    'dijit/layout/ContentPane',
    'xstyle!dime/widget/project/css/ProjectDetailWidget.css'
], function ( WidgetsInTemplateMixin, TemplatedMixin,  _Base, declare,  template, request) {
    return declare("dime.widget.project.ProjectDetailWidget", [_Base, TemplatedMixin, WidgetsInTemplateMixin], {

        templateString: template,
        baseClass: "projectDetailWidget",
        store: 'projects',
        entityType: 'projects',
        independant: true,
        config: {
            values: {
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
                    disabled: true,
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
                    header: [ 'Service', 'Projekt', 'Mitarbeiter', 'Beschreibung', 'Anzahl', 'Einheit', 'Preis per Einheit', 'Preis' ],
                    store: 'activities',
                    entitytype: 'activities',
                    createable: true,
                    widgetProperty: 'updateValues',
                    prototype:  {
                        project: 'entityref:id',
                        service: 1
                    },
                    queryPrototype: {
                        project: 'id'
                    }
                },
                timeslicesNode: {
                    childWidgetType: 'dime/widget/timeslice/TimesliceTableRowWidget',
                    queryPrototype: {
                        project: 'id'
                    },
                    prototype:  {
                        project: 'entityref:id'
                    },
                    createable: true,
                    header: [ 'Datum', 'Mitarbeiter', 'Aktivität', 'Zeit' ],
                    store: 'timeslices',
                    entitytype: 'timeslices'
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
            events:{
                updateActivities:{
                    Topic: 'entityUpdate',
                    subTopic: 'activities',
                    eventFunction: 'updateActivities'
                },
                createActivities:{
                    Topic: 'entityCreate',
                    subTopic: 'activities',
                    eventFunction: 'updateActivities'
                },
                updateTimeslices:{
                    Topic: 'entityUpdate',
                    subTopic: 'timeslices',
                    eventFunction: 'updateTimeslices'
                },
                createTimeslices:{
                    Topic: 'entityCreate',
                    subTopic: 'timeslices',
                    eventFunction: 'updateTimeslices'
                }
            }
        },

        resize: function(){
            this.tabContainer.resize();
        },

        updateActivities: function(arg){
            var activity = arg.entity, changedProperty = arg.changedProperty, oldValue = arg.oldValue;
            var newValue = arg.newValue, base = this, project = this.entity;
            if(activity.project.id === project.id){
                base.forceUpdate();
            }
        },

        updateTimeslices: function(arg){
            var timeslice = arg.entity, changedProperty = arg.changedProperty, oldValue = arg.oldValue;
            var newValue = arg.newValue, base = this, project = this.entity;
            if(timeslice.project.id === project.id){
                base.forceUpdate();
            }
        }

    });
});
