define([
    'dijit/_WidgetsInTemplateMixin',
    'dijit/_TemplatedMixin',
    'dime/widget/_Base',
    'dojo/_base/declare',
    'dojo/text!dime/widget/offer/templates/OfferDetailWidget.html',
    'dojo/request',
    'dime/widget/GenericTableWidget',
    'dijit/form/TextBox',
    'dijit/form/NumberTextBox',
    'dijit/form/DateTextBox',
    'dijit/form/Textarea',
    'dime/widget/swocommons/AddressWidget',
    'dijit/form/FilteringSelect',
    'dijit/form/Button',
    'xstyle!dime/widget/offer/css/OfferDetailWidget.css'
], function ( WidgetsInTemplateMixin, TemplatedMixin,  _Base, declare,  template, request) {
    return declare("dime.widget.offer.OfferDetailWidget", [_Base, TemplatedMixin, WidgetsInTemplateMixin], {

        templateString: template,
        baseClass: "offerDetailWidget",
        store: 'offers',
        entitytype: 'offers',
        independant: true,
        config: {
            values: {
                nameNode: {
                    widgetProperty: 'value',
                    entityProperty: 'name',
                    nullValue: ''
                },
                customerNode: {
                    widgetProperty: 'value',
                    entityProperty: 'customer',
                    nullValue: '',
                    store: 'customers',
                    idProperty: 'id'
                },
                statusNode: {
                    widgetProperty: 'value',
                    entityProperty: 'status',
                    nullValue: '',
                    store: 'offerstatusucs',
                    searchAttr: 'text',
                    idProperty: 'id'
                },
                accountantNode: {
                    widgetProperty: 'value',
                    entityProperty: 'accountant',
                    nullValue: '',
                    store: 'users',
                    searchAttr: 'fullname',
                    idProperty: 'id'
                },
                validToNode: {
                    widgetProperty: 'value',
                    entityProperty: 'validTo',
                    nullValue: ''
                },
                rateGroupNode: {
                    widgetProperty: 'value',
                    entityProperty: 'rateGroup',
                    nullValue: '',
                    store: 'rategroups',
                    searchAttr: 'name',
                    idProperty: 'id'
                },
                shortDescriptionNode: {
                    widgetProperty: 'value',
                    entityProperty: 'shortDescription',
                    nullValue: ''
                },
                descriptionNode: {
                    widgetProperty: 'value',
                    entityProperty: 'description',
                    nullValue: ''
                },
                addressNode: {
                    widgetProperty: 'value',
                    entityProperty: 'address',
                    nullValue: ''
                },
                projectNode: {},
                subtotalNode: {
                    widgetProperty: 'value',
                    entityProperty: 'subtotal',
                    nullValue: '',
                    disabled: true
                },
                totalVATNode: {
                    widgetProperty: 'value',
                    entityProperty: 'totalVAT',
                    nullValue: '',
                    disabled: true
                },
                totalDiscountsNode: {
                    widgetProperty: 'value',
                    entityProperty: 'totalDiscounts',
                    nullValue: '',
                    disabled: true
                },
                totalNode: {
                    widgetProperty: 'value',
                    entityProperty: 'total',
                    nullValue: '',
                    disabled: true
                },
                fixedPriceNode: {
                    widgetProperty: 'value',
                    entityProperty: 'fixedPrice',
                    nullValue: ''
                },
                offerPositionsNode: {
                    childWidgetType: 'dime/widget/offer/OfferPositionRowWidget',
                    header: [ 'Reihenfolge', 'Service', 'Tarif', 'Tarif Einheit', 'Einheits-Typ', 'Menge', 'MwSt.', 'Rabatierbar', 'Total' ],
                    widgetProperty: 'updateValues',
                    prototype:  {
                        order: 0,
                        offer: 'entityref:id',
                        service: 1,
                        discountable: true,
                        vat: 0.08
                    },
                    createable: true,
                    linkable: false,
                    store: 'offerpositions',
                    entityProperty: 'offerPositions',
                    entitytype: 'offerpositions'
                },
                discountsNode: {
                    childWidgetType: 'dime/widget/timetrack/StandardDiscountRowWidget',
                    header: [ 'Name', 'Reduktion', 'Prozent', 'Wert' ],
                    widgetProperty: 'updateValues',
                    entityProperty: 'standardDiscounts',
                    createable: false,
                    linkable: true,
                    selectable: {
                        store: 'standarddiscounts'
                    },
                    store: 'standarddiscounts',
                    entitytype: 'standarddiscounts',
                    disabled: true
                },
                offerDiscountsNode: {
                    childWidgetType: 'dime/widget/offer/OfferDiscountRowWidget',
                    header: [ 'Name', 'Reduktion', 'Prozent', 'Wert' ],
                    widgetProperty: 'updateValues',
                    createable: true,
                    linkable: false,
                    store: 'offerdiscounts',
                    entityProperty: 'offerDiscounts',
                    entitytype: 'offerdiscounts'
                },
                printNode:{
                    domProp: {
                        href: '/api/v1/offers/{id}/print'
                    }
                }
            },
            callbacks: {
                projectNode:{
                    callbackName: 'click',
                    callbackFunction: function(){
                        var OfferId = this.getParent().entity.id;
                        request.get('/api/v1/projects/offer/'+OfferId, {handleAs: 'json'}).then(function(data){
                            window.widgetManager.addTab(data, 'projects', 'dime/widget/project/ProjectDetailWidget', 'contentTabs', 'Projekt ('+data.id+')', true);
                        });
                    }
                }
            },
            events:{
                updateOfferPositions:{
                    Topic: 'entityUpdate',
                    subTopic: 'offerpositions',
                    eventFunction: 'updateOfferPositions'
                },
                createOfferPositions:{
                    Topic: 'entityCreate',
                    subTopic: 'offerpositions',
                    eventFunction: 'updateOfferPositions'
                }
            }
        },

        updateOfferPositions: function(arg){
            var offerpostition = arg.entity, changedProperty = arg.changedProperty, oldValue = arg.oldValue;
            var newValue = arg.newValue, base = this, offer = this.entity;
            if(offerpostition.offer.id === offer.id){
                base.forceUpdate();
            }
        }

    });
});
