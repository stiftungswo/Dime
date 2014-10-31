
define([
        "dojo/_base/declare",
        "dojo/parser",
        "dojo/dom",
        "dojo/dom-style",
        "dojo/dom-geometry",
        "dojo/_base/fx",
        "dijit/layout/ContentPane",
        "dijit/registry",
        "dgrid/editor",
        "dime/store/storeManager",
        "dime/widget/dialogManager",
        "dojo/NodeList-manipulate",
        "dojo/NodeList-traverse",
        "dime/module"
    ],
    function(declare, parser, dom, domStyle, domGeometry, baseFx, ContentPane, registry, editor, storeManager, dialogManager) {
        return declare('dime.app', [], {


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

                basename: function(path, suffix) {
                    // Returns the filename component of the path
                    //
                    // version: 1109.2015
                    // discuss at: http://phpjs.org/functions/basename
                    // +   original by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
                    // +   improved by: Ash Searle (http://hexmen.com/blog/)
                    // +   improved by: Lincoln Ramsay
                    // +   improved by: djmix
                    // *     example 1: basename('/www/site/home.htm', '.htm');
                    // *     returns 1: 'home'
                    // *     example 2: basename('ecra.php?p=1');
                    // *     returns 2: 'ecra.php?p=1'
                    var b = path.replace(/^.*[\/\\]/g, '');

                    if (typeof(suffix) == 'string' && b.substr(b.length - suffix.length) == suffix) {
                        b = b.substr(0, b.length - suffix.length);
                    }

                    return b;
                },

                addTab: function(tabContainer, href, title, closable){
                    if (typeof tabContainer === "string"){
                        tabContainer = registry.byId(tabContainer);
                    }
                    var tabName = "tab" + this.basename(href,".html"),
                        tab = registry.byId(tabName);
                    if (typeof tab === "undefined"){
                        tab = new ContentPane({
                            id: tabName,
                            title: title,
                            href: href,
                            closable: closable,
                            style: "padding: 0;"
                        });
                        tabContainer.addChild(tab);
                    }
                    tabContainer.selectChild(tab);
                },

                initStores: function () {
                    window.storeManager = new storeManager();
                    window.dialogManager = new dialogManager();
                },

                //createStore: function(target){
                //    return new Observable(new Cache(new JsonRest({target: target}), Memory({})));
                //},

                init: function () {
                    this.startLoading();

                    this.initStores();
                    window.dgrid = {
                        editor: editor
                    };
                    parser.parse();

                    this.endLoading();
                }
        })

    }
);