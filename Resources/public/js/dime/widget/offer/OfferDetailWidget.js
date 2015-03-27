define([
    'dijit/_WidgetsInTemplateMixin',
    'dijit/_TemplatedMixin',
    'dime/common/EntityBoundWidget',
    'dojo/_base/declare',
    'dojo/text!dime/widget/offer/templates/OfferDetailWidget.html',
    'dojo/request',
    'dime/common/SelectableSubEntityTableWidget',
    'dime/common/GenericStoreTableWidget',
    'dijit/form/TextBox',
    'dijit/form/NumberTextBox',
    'dime/form/DateTextBox',
    'dijit/form/Textarea',
    'dime/widget/swocommons/AddressWidget',
    'dijit/form/FilteringSelect',
    'dijit/form/Button',
    'xstyle!dime/widget/offer/css/OfferDetailWidget.css'
], function ( WidgetsInTemplateMixin, TemplatedMixin,  EntityBoundWidget, declare,  template, request) {
    return declare("dime.widget.offer.OfferDetailWidget", [EntityBoundWidget, TemplatedMixin, WidgetsInTemplateMixin], {

        templateString: template,
        baseClass: "offerDetailWidget",
        collection: 'offers',

        baseConfig: {
            independant: true
        },
        childConfig: {
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
                widgetProperty: 'entity',
                entityProperty: 'address',
                nullValue: null
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
                queryPrototype: {
                    offer: 'id'
                },
                collection: 'offerpositions',
                creatable: true,
                deleteable: true,
                parentprop: 'offer'
            },
            discountsNode: {
                childWidgetType: 'dime/widget/timetrack/StandardDiscountRowWidget',
                widgetProperty: 'value',
                entityProperty: 'standardDiscounts',
                header: [ 'Name', 'Reduktion', 'Prozent', 'Wert' ],
                disabled: true,
                selectionBox: {
                    store: window.storeManager.adapt('standarddiscounts')
                },
                creatable: true,
                deleteable: true,
                parentprop: 'offer'
            },
            offerDiscountsNode: {
                childWidgetType: 'dime/widget/offer/OfferDiscountRowWidget',
                header: [ 'Name', 'Reduktion', 'Prozent', 'Wert' ],
                queryPrototype: {
                    offer: 'id'
                },
                collection: 'offerdiscounts',
                creatable: true,
                deleteable: true,
                parentprop: 'offer'
            }
        },
        callbacks: {
            projectNode:{
                callbackName: 'click',
                callbackFunction: function(){
                    var OfferId = this.getParent().entity.id;
                    request('/api/v1/projects/offer/'+OfferId, {handleAs: 'json'}).then(function(data){
                        window.widgetManager.addTab(data, 'projects', 'dime/widget/project/ProjectDetailWidget', 'contentTabs', 'Projekt ('+data.id+')', true);
                    });
                }
            },
            printNode:{
                callbackName: 'click',
                callbackFunction: function(){
                    this.getParent().printOffer();
                }
            }
        },

        startup: function(){
            this.inherited(arguments);
            var base = this;
            var offerPositionCollection = window.storeManager.get('offerpositions'),
                offerDiscountCollection = window.storeManager.get('offerdiscounts');
            offerPositionCollection.on('add, update, delete', function(event){
                base.forceViewUpdate();
            });
            offerDiscountCollection.on('add, update, delete', function(event){
                base.forceViewUpdate();
            });
        },

        printOffer: function(){
            window.open('/api/v1/offers/'+this.entity.id+'/print');
        }

    });
});
