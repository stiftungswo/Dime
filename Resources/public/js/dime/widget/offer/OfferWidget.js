define([
    'dojo/_base/declare',
    'dijit/_WidgetBase',
    'dijit/_WidgetsInTemplateMixin',
    'dijit/_TemplatedMixin',
    'dojo/_base/declare',
    'dojo/text!dime/widget/offer/templates/OfferWidget.html',
    "dijit/form/TextBox",
    "dijit/form/FilteringSelect",
    "dijit/form/DateTextBox",
    "dijit/form/Textarea",
    'dijit/registry',
    'dijit/Dialog'
], function (declare, WidgetBase, WidgetsInTemplateMixin, TemplatedMixin, declare, template, Textbox, FilteringSelect, DateTextBox, Textarea, registry, Dialog) {
    return declare("dime.widget.timetrack.PersonalTimetrackerWidgetMonth", [WidgetBase, TemplatedMixin, WidgetsInTemplateMixin], {

        templateString: template,

        baseClass: "offerWidget",

        name: "Name",

        editOfferId: -1,

        offer: null,

        buildRendering: function () {
            this.inherited(arguments);

            this.offer = window.offerStore.get(this.editOfferId);
            this.nameNode.set('value', this.offer.name);
            this.customerNode.set('value', this.offer.customer.name);
            this.statusNode.set('value', this.offer.status.id);
            this.accountantNode.set('value', this.offer.accountant.id);
            this.validToNode.set('value', this.offer.validTo);
        }

    });
});
