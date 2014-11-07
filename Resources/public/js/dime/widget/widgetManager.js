define([
    'dojo/_base/declare'
], function (declare) {
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
        }
    });
});