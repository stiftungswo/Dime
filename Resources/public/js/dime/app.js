
define([
        "dojo/_base/declare",
        "dojo/dom",
        "dojo/dom-style",
        "dojo/dom-geometry",
        "dojo/_base/fx",
        "dojo/store/JsonRest",
        "dojo/store/Memory",
        "dojo/store/Cache",
        "dojo/store/Observable",
        "dime/module"
    ],
    function(declare, dom, domStyle, domGeometry, baseFx, JsonRest, Memory, Cache, Observable) {
        return declare('dime.app', [], {
                startup: function () {
                    // create the data stores
                    this.initStores();
                },

                endLoading: function () {
                    // summary:
                    // 		Indicate not-loading state in the UI

                    baseFx.fadeOut({
                        node: dom.byId("loader"),
                        onEnd: function (node) {
                            domStyle.set(node, "display", "none");
                        }
                    }).play();
                },

                startLoading: function (targetNode) {
                    // summary:
                    // 		Indicate a loading state in the UI

                    var overlayNode = dom.byId("loader");
                    if ("none" == domStyle.get(overlayNode, "display")) {
                        var coords = domGeometry.getMarginBox(targetNode || document.body);
                        domGeometry.setMarginBox(overlayNode, coords);

                        // N.B. this implementation doesn't account for complexities
                        // of positioning the overlay when the target node is inside a
                        // position:absolute container
                        domStyle.set(dom.byId("loader"), {
                            display: "block",
                            opacity: 1
                        });
                    }
                },

                initStores: function () {
                    window.userStore = new Cache(new Observable(new JsonRest({target: 'api/v1/users'})), new Memory({}));
                    window.timesliceStore = new Cache(new Observable(new JsonRest({target: 'api/v1/timeslices'})), new Memory({}));
                    window.tagStore = new Cache(new Observable(new JsonRest({target: 'api/v1/tags'})), new Memory({}));
                    window.settingStore = new Cache(new Observable(new JsonRest({target: 'api/v1/settings'})), new Memory({}));
                    window.serviceStore = new Cache(new Observable(new JsonRest({target: 'api/v1/services'})), new Memory({}));
                    window.projectStore = new Cache(new Observable(new JsonRest({target: 'api/v1/projects'})), new Memory({}));
                    window.customerStore = new Cache(new Observable(new JsonRest({target: 'api/v1/customers'})), new Memory({}));
                    window.activityStore = new Cache(new Observable(new JsonRest({target: 'api/v1/activities'})), new Memory({}));
                },

                init: function () {
                    this.startLoading();

                    // register callback for when dependencies have loaded
                    this.startup();

                    this.endLoading();
                }
        })

    }
);