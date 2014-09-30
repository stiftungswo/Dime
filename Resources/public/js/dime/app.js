
define([
        "dojo/_base/declare",
        "dojo/dom",
        "dojo/dom-style",
        "dojo/dom-geometry",
        "dojo/_base/fx",
        "dime/Grid",
        "dime/stores/UserStore",
        "dime/module"
    ],
    function(declare, dom, domStyle, domGeometry, baseFx, Grid, UserStore) {
        return declare('dime.app', [], {
                startup: function () {

                    // create the data store
                    //ToDo: Connect to DimeRestApi
                    this.initStores();

                    // build up and initialize the UI
                    this.initUi();

                    // put up the loading overlay when the 'fetch' method of the store is called
                    //aspect.before(store, "fetch", function() {
                    //    startLoading(registry.byId("tabs").domNode);
                    //});

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
                    this.userStore = new UserStore();
                },

                initUi: function () {
                    // summary:
                    // 		create and setup the UI with layout and widgets
                    this.initDataGrid();
                },

                initDataGrid: function () {
                    this.simpleGrid = new Grid({
                        store: this.userStore,
                        columns: {
                            username: "Username",
                            firstname: "Firstname",
                            lastname: "Lastname",
                            email: "e-mail"
                        }
                    }, 'userContainer');
                    this.simpleGrid.startup();
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