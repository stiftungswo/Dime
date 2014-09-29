//>>built
define("dojox/app/controllers/Layout",["dojo/_base/declare","dojo/_base/lang","dojo/_base/array","dojo/_base/window","dojo/query","dojo/dom-geometry","dojo/dom-attr","dojo/dom-style","dijit/registry","./LayoutBase","../utils/layout","../utils/constraints"],function(_1,_2,_3,_4,_5,_6,_7,_8,_9,_a,_b,_c){
return _1("dojox.app.controllers.Layout",_a,{constructor:function(_d,_e){
},onResize:function(){
this._doResize(this.app);
this.resizeSelectedChildren(this.app);
},resizeSelectedChildren:function(w){
for(var _f in w.selectedChildren){
if(w.selectedChildren[_f]&&w.selectedChildren[_f].domNode){
this.app.log("in Layout resizeSelectedChildren calling resizeSelectedChildren calling _doResize for w.selectedChildren[hash].id="+w.selectedChildren[_f].id);
this._doResize(w.selectedChildren[_f]);
_3.forEach(w.selectedChildren[_f].domNode.children,function(_10){
if(_9.byId(_10.id)&&_9.byId(_10.id).resize){
_9.byId(_10.id).resize();
}
});
this.resizeSelectedChildren(w.selectedChildren[_f]);
}
}
},initLayout:function(_11){
this.app.log("in app/controllers/Layout.initLayout event=",_11);
this.app.log("in app/controllers/Layout.initLayout event.view.parent.name=[",_11.view.parent.name,"]");
if(!_11.view.domNode.parentNode){
if(this.app.useConfigOrder){
_11.view.parent.domNode.appendChild(_11.view.domNode);
}else{
this.addViewToParentDomByConstraint(_11);
}
}
_7.set(_11.view.domNode,"data-app-constraint",_11.view.constraint);
this.inherited(arguments);
},addViewToParentDomByConstraint:function(_12){
var _13=_12.view.constraint;
if(_13==="bottom"){
_12.view.parent.domNode.appendChild(_12.view.domNode);
}else{
if(_13==="top"){
_12.view.parent.domNode.insertBefore(_12.view.domNode,_12.view.parent.domNode.firstChild);
}else{
if(_12.view.parent.domNode.children.length>0){
for(var _14 in _12.view.parent.domNode.children){
var _15=_12.view.parent.domNode.children[_14];
var dir=_8.get(_12.view.parent.domNode,"direction");
var _16=(dir==="ltr");
var _17=_16?"left":"right";
var _18=_16?"right":"left";
if(_15.getAttribute&&_15.getAttribute("data-app-constraint")){
var _19=_15.getAttribute("data-app-constraint");
if(_19==="bottom"||(_19===_18)||(_19!=="top"&&(_13===_17))){
_12.view.parent.domNode.insertBefore(_12.view.domNode,_15);
break;
}
}
}
}
}
}
if(!_12.view.domNode.parentNode){
_12.view.parent.domNode.appendChild(_12.view.domNode);
}
},_doResize:function(_1a){
var _1b=_1a.domNode;
if(!_1b){
this.app.log("Warning - View has not been loaded, in Layout _doResize view.domNode is not set for view.id="+_1a.id+" view=",_1a);
return;
}
var mb={};
if(!("h" in mb)||!("w" in mb)){
mb=_2.mixin(_6.getMarginBox(_1b),mb);
}
if(_1a!==this.app){
var cs=_8.getComputedStyle(_1b);
var me=_6.getMarginExtents(_1b,cs);
var be=_6.getBorderExtents(_1b,cs);
var bb=(_1a._borderBox={w:mb.w-(me.w+be.w),h:mb.h-(me.h+be.h)});
var pe=_6.getPadExtents(_1b,cs);
_1a._contentBox={l:_8.toPixelValue(_1b,cs.paddingLeft),t:_8.toPixelValue(_1b,cs.paddingTop),w:bb.w-pe.w,h:bb.h-pe.h};
}else{
_1a._contentBox={l:0,t:0,h:_4.global.innerHeight||_4.doc.documentElement.clientHeight,w:_4.global.innerWidth||_4.doc.documentElement.clientWidth};
}
this.inherited(arguments);
},layoutView:function(_1c){
if(_1c.view){
this.inherited(arguments);
if(_1c.doResize){
this._doResize(_1c.parent||this.app);
this._doResize(_1c.view);
}
}
},_doLayout:function(_1d){
if(!_1d){
console.warn("layout empty view.");
return;
}
this.app.log("in Layout _doLayout called for view.id="+_1d.id+" view=",_1d);
var _1e;
var _1f=_c.getSelectedChild(_1d,_1d.constraint);
if(_1f&&_1f.isFullScreen){
console.warn("fullscreen sceen layout");
}else{
_1e=_5("> [data-app-constraint]",_1d.domNode).map(function(_20){
var w=_9.getEnclosingWidget(_20);
if(w){
w._constraint=_7.get(_20,"data-app-constraint");
return w;
}
return {domNode:_20,_constraint:_7.get(_20,"data-app-constraint")};
});
if(_1f){
_1e=_3.filter(_1e,function(c){
return c.domNode&&c._constraint;
},_1d);
}
}
if(_1d._contentBox){
_b.layoutChildren(_1d.domNode,_1d._contentBox,_1e);
}
}});
});
