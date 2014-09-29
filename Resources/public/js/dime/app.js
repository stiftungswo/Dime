define([
        "dojo/dom",
        "dojo/dom-style",
        "dojo/dom-class",
        "dojo/dom-construct",
        "dojo/dom-geometry",
        "dojo/string",
        "dojo/on",
        "dojo/aspect",
        "dojo/keys",
        "dojo/_base/config",
        "dojo/_base/lang",
        "dojo/_base/fx",
        "dijit/registry",
        "dojo/parser",
        "dojo/store/Memory",
        "dijit/tree/ObjectStoreModel",
        "dime/module",
        // Modules referenced by the parser
        "dijit/Menu", "dijit/PopupMenuItem", "dijit/ColorPalette", "dijit/layout/BorderContainer", "dijit/MenuBar",
        "dijit/PopupMenuBarItem", "dijit/layout/AccordionContainer", "dijit/layout/ContentPane", "dijit/TooltipDialog",
        "dijit/Tree", "dijit/layout/TabContainer", "dijit/form/ComboButton", "dijit/form/ToggleButton",
        "dijit/form/CheckBox", "dijit/form/RadioButton", "dijit/form/CurrencyTextBox", "dijit/form/NumberSpinner",
        "dijit/form/Select", "dijit/Editor", "dijit/form/VerticalSlider", "dijit/form/VerticalRuleLabels",
        "dijit/form/VerticalRule", "dijit/form/HorizontalSlider", "dijit/form/HorizontalRuleLabels",
        "dijit/form/HorizontalRule", "dijit/TitlePane", "dijit/ProgressBar", "dijit/InlineEditBox", "dojo/dnd/Source",
        "dijit/Dialog"
    ],
    function(dom, domStyle, domClass, domConstruct, domGeometry, string, on, aspect, keys, config, lang, baseFx, registry, parser,
             Memory, ObjectStoreModel) {

        var store = null,
            preloadDelay = 500,

            itemClass = 'item',
            itemsById = {},


        startup = function() {

            // create the data store
            //ToDo: Connect to DimeRestApi

            // build up and initialize the UI
            initUi();

            // put up the loading overlay when the 'fetch' method of the store is called
            //aspect.before(store, "fetch", function() {
            //    startLoading(registry.byId("tabs").domNode);
            //});

        },

        initUi = function() {
            // summary:
            // 		create and setup the UI with layout and widgets


            // set up ENTER keyhandling for the search keyword input field
            //on(dom.byId("searchTerms"), "keydown", function(evt){
            //    if(evt.keyCode == keys.ENTER){
            //        evt.preventDefault();
            //        doSearch();
            //    }
            //});

            // set up click handling for the search button
            //on(dom.byId("searchBtn"), "click", doSearch);
        },
        endLoading = function() {
            // summary:
            // 		Indicate not-loading state in the UI

            baseFx.fadeOut({
                node: dom.byId("loader"),
                onEnd: function(node){
                    domStyle.set(node, "display", "none");
                }
            }).play();
        },

        startLoading = function(targetNode) {
            // summary:
            // 		Indicate a loading state in the UI

            var overlayNode = dom.byId("loader");
            if("none" == domStyle.get(overlayNode, "display")) {
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
        };

        // Data for Tree, ComboBox, InlineEditBox
        var data = [
            { id: "earth", name: "The earth", type: "planet", population: "6 billion"},
            { id: "AF", name: "Africa", type: "continent", population: "900 million", area: "30,221,532 sq km",
                timezone: "-1 UTC to +4 UTC", parent: "earth"},
            { id: "EG", name: "Egypt", type: "country", parent: "AF" },
            { id: "KE", name: "Kenya", type: "country", parent: "AF" },
            { id: "Nairobi", name: "Nairobi", type: "city", parent: "KE" },
            { id: "Mombasa", name: "Mombasa", type: "city", parent: "KE" },
            { id: "SD", name: "Sudan", type: "country", parent: "AF" },
            { id: "Khartoum", name: "Khartoum", type: "city", parent: "SD" },
            { id: "AS", name: "Asia", type: "continent", parent: "earth" },
            { id: "CN", name: "China", type: "country", parent: "AS" },
            { id: "IN", name: "India", type: "country", parent: "AS" },
            { id: "RU", name: "Russia", type: "country", parent: "AS" },
            { id: "MN", name: "Mongolia", type: "country", parent: "AS" },
            { id: "OC", name: "Oceania", type: "continent", population: "21 million", parent: "earth"},
            { id: "AU", name: "Australia", type: "country", population: "21 million", parent: "OC"},
            { id: "EU", name: "Europe", type: "continent", parent: "earth" },
            { id: "DE", name: "Germany", type: "country", parent: "EU" },
            { id: "FR", name: "France", type: "country", parent: "EU" },
            { id: "ES", name: "Spain", type: "country", parent: "EU" },
            { id: "IT", name: "Italy", type: "country", parent: "EU" },
            { id: "NA", name: "North America", type: "continent", parent: "earth" },
            { id: "MX", name: "Mexico", type: "country", population: "108 million", area: "1,972,550 sq km",
                parent: "NA" },
            { id: "Mexico City", name: "Mexico City", type: "city", population: "19 million", timezone: "-6 UTC", parent: "MX"},
            { id: "Guadalajara", name: "Guadalajara", type: "city", population: "4 million", timezone: "-6 UTC", parent: "MX" },
            { id: "CA", name: "Canada", type: "country", population: "33 million", area: "9,984,670 sq km", parent: "NA" },
            { id: "Ottawa", name: "Ottawa", type: "city", population: "0.9 million", timezone: "-5 UTC", parent: "CA"},
            { id: "Toronto", name: "Toronto", type: "city", population: "2.5 million", timezone: "-5 UTC", parent: "CA" },
            { id: "US", name: "United States of America", type: "country", parent: "NA" },
            { id: "SA", name: "South America", type: "continent", parent: "earth" },
            { id: "BR", name: "Brazil", type: "country", population: "186 million", parent: "SA" },
            { id: "AR", name: "Argentina", type: "country", population: "40 million", parent: "SA" }
        ];

        // Create test store.
        continentStore = new Memory({
            data: data
        });

        // Since dojo.store.Memory doesn't have various store methods we need, we have to add them manually
        continentStore.getChildren = function(object){
            // Add a getChildren() method to store for the data model where
            // children objects point to their parent (aka relational model)
            return this.query({parent: this.getIdentity(object)});
        };

        // Create the model for the Tree
        continentModel = new ObjectStoreModel({store: continentStore, query: {id: "earth"}});


        return {
            init: function() {
                startLoading();

                // register callback for when dependencies have loaded
                startup();

                endLoading();
            }
        };

    });