/**
 * Created by Till Wegmüller on 11/13/14.
 */
define([
    'dijit/_WidgetsInTemplateMixin',
    'dijit/_TemplatedMixin',
    'dime/widget/_Base',
    'dojo/_base/declare',
    'dojo/text!dime/widget/service/templates/ServiceDetailWidget.html',
    'dijit/form/TextBox',
    'dime/widget/GenericTableWidget',
    'dijit/form/NumberTextBox',
    'dijit/form/CheckBox'
], function ( WidgetsInTemplateMixin, TemplatedMixin,  _Base, declare,  template) {
    return declare("dime.widget.service.ServiceDetailWidget", [_Base, TemplatedMixin, WidgetsInTemplateMixin], {

        templateString: template,
        baseClass: "serviceDetailWidget",
        store:'services',
        entityType: 'services',
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
                chargeableNode: {
                    widgetProperty: 'value',
                    entityProperty: 'chargeable',
                    nullValue: true
                },
                vatNode: {
                    widgetProperty: 'value',
                    entityProperty: 'vat',
                    nullValue: '',
                    constraints: {
                        min: 0,
                        max: 100,
                        pattern: "#0.####%"
                    }
                },
                ratesNode: {
                    childWidgetType: 'dime/widget/rate/RateRowWidget',
                    header: [ 'Tarif Gruppe', 'Ansatz', 'Einheit', 'EinheitenTyp' ],
                    queryPrototype: {
                        service: 'id'
                    },
                    prototype:  {
                        service: 'entityref:id'
                    },
                    store: 'rates',
                    entitytype: 'rates',
                    unidirectional: false,
                    entityProperty: 'rates',
                    widgetProperty: 'updateValues'
                }
            },
            events:{
                updateRates:{
                    Topic: 'entityUpdate',
                    subTopic: 'rates',
                    eventFunction: 'updateRates'
                },
                createOfferPositions:{
                    Topic: 'entityCreate',
                    subTopic: 'rates',
                    eventFunction: 'updateRates'
                }
            }
        },

        updateRates: function(arg){
            this.forceUpdate();
        }
    });
});
