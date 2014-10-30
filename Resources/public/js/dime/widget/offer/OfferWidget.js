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
            console.log(this.offer);

            this.nameNode.set('value', this.offer.name);
            this.customerNode.set('value', this.offer.customer.name);
            this.statusNode.set('value', this.offer.status.id);
            this.accountantNode.set('value', this.offer.accountant.id);
            this.validToNode.set('value', this.offer.validTo.split(" ")[0]);
            this.rateGroupNode.set('value', this.offer.rateGroup.id);
            this.shortDescriptionNode.set('value', this.offer.shortDescription);
            this.descriptionNode.set('value', this.offer.description);
            this.recepientAddressLine1Node.set('value', this.offer.recepientAddressLine1);
            this.recepientAddressLine2Node.set('value', this.offer.recepientAddressLine2);
            this.recepientAddressLine3Node.set('value', this.offer.recepientAddressLine3);
            this.recepientAddressLine4Node.set('value', this.offer.recepientAddressLine4);
            this.recepientAddressLine5Node.set('value', this.offer.recepientAddressLine5);



        }

    });
});
