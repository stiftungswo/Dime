define([
    'dojo/_base/declare',
    'dijit/layout/ContentPane',
    'dijit/registry'
], function (declare, ContentPane, registry) {
    return declare('dime.widget.widgetManager',[],{
        add: function(entity, entitytype, widgettype, container, disabled){
            disabled  = disabled || false;
            require([widgettype], function(WidgetType){
                var widget = new WidgetType({entity: entity, entitytype: entitytype, disabled: disabled});
                if(container) {
                    if(container.addChild){
                        container.addChild(widget);
                    } else {
                        widget.placeAt(container);
                    }
                }
                window.eventManager.fire('widgetCreate', entitytype, {widget: widget});
            });
        },
        addTab: function(entity, entitytype, widgettype, tabContainer, title, closable){

            if (typeof tabContainer === "string"){
                tabContainer = registry.byId(tabContainer);
            }
            var tabName = "tab_" + entitytype + "_"+entity.id,
                tab = registry.byId(tabName);

            if (typeof tab === "undefined"){
                tab = new ContentPane({
                    id: tabName,
                    title: title,
                    closable: closable,
                    style: "padding: 0;"
                });
                tabContainer.addChild(tab);
            }
            tabContainer.selectChild(tab);
            //tab.on('close', function(){
                //this.destroyRecursive();
                //window.widgetManager.destroyRecursive(this);
            //});

            this.add(entity, entitytype, widgettype, tab);
        }
    });
});