/**
 * Created by toast on 9/30/14.
 */
define([
    "dojo/_base/declare",
    "dijit/_WidgetBase",
    "dijit/_TemplatedMixin",
    "dojo/text!./templates/UserProfileWidget.html"
], function(declare,_WidgetBase, _TemplatedMixin, template){
        return declare([_WidgetBase, _TemplatedMixin], {
            // Some default values for our author
            // These typically map to whatever you're passing to the constructor
            firstname: "No",
            lastname: "Name",
            username: "username",
            email: "Empty@mail.com",
            roles: "{}",

            // Our template - important!
            templateString: template,

            // A class to be applied to the root node in our template
            baseClass: "userprofileWidget",

            // A reference to our background animation
            mouseAnim: null,

            // Colors for our background animation
            baseBackgroundColor: "#fff",
            mouseBackgroundColor: "#def"
        });
    });