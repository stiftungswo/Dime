/**
 * Created by Till Wegmüller on 11/13/14.
 */
define([
    'dime/common/EntityOverviewWidget',
    'dijit/_WidgetsInTemplateMixin',
    'dijit/_TemplatedMixin',
    'dojo/_base/declare',
    'dojo/text!dime/widget/user/templates/UsersWidget.html'
], function (EntityOverviewWidget, WidgetsInTemplateMixin, TemplatedMixin, declare, template){
    return declare("dime.widget.user.UsersWidget", [EntityOverviewWidget, TemplatedMixin, WidgetsInTemplateMixin], {

        templateString: template,
        baseClass: "usersWidget",
        collection: 'users',
        editTitleProperty: 'Mitarbeiter',
        editWidget: 'dime/widget/user/UserDetailWidget',
        dGrid: {
            sort: 'username',
            columns: [
                {label: 'Benutzername', field: 'username'},
                {label: 'Vorname', field: 'firstname'},
                {label: 'Nachname', field: 'lastname'},
                {label: 'e-Mail', field: 'email'},
                {label: 'Login', field: 'enabled'},
                {label: 'Gesperrt', field: 'locked'}
            ]
        }
    });
});

