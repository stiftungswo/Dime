define([
    'dojo/_base/declare',
    "dijit/layout/ContentPane",
    "dijit/registry",
], function (declare, ContentPane, registry) {
    return declare('dime.widget.widgetManager',[],{
        widgets: [],
        get: function(entity, entitytype){
            return this._findwidget(entity, entitytype);
        },
        add: function(entity, entitytype, widgettype, parent, container){
            var widget = new widgettype({entity: entity, entitytype: entitytype});
            if(parent){
                widget.parentWidget = parent;
                parent.children.push(widget);
                if(container) {
                    widget.placeAt(container);
                }
            }
            this.widgets.push(widget);
            return widget;
        },
        remove: function(entity, entitytype){
            var widget = this._findwidget(entity, entitytype);
            widget.destroyRecursive();
        },
        update: function(entity, entitytype){
            var widget = this._findwidget(entity, entitytype);
            if(widget){
                widget._updateValues(entity);
            }
        },
        addChild: function(entity, entitytype){
            for(var i=0; i < this.widgets.length; i++){
                var widget= this.widgets[i];
                widget._addChild(entity, entitytype);
            }
        },
        register: function(entity, entitytype, widget){
            widget.entitytype = entitytype;
            widget.entity = entity;
            this.widgets.push(widget);
        },
        _findwidget: function(entity, entitytype){
            for(var i=0; i < this.widgets.length; i++){
                var widget = this.widgets[i];
                if(widget.entity.id == entity.id && widget.entitytype == entitytype){
                    return widget;
                }
            }
        },
        foreach: function(entitytype, callback)
        {
            for(var i=0; this.widgets.length; i++){
                var widget = this.widgets[i];
                if(widget.entitytype == entitytype){
                    callback(widget);
                }
            }
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

            var widget = this.add(entity, entitytype, widgettype, null, null);
            tab.addChild(widget);
        }
    });
});