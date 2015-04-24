// Copyright (C) 2013 - 2015 Angular Dart UI authors. Please see AUTHORS.md.
// https://github.com/akserg/angular.dart.ui
// All rights reserved.  Please see the LICENSE.md file.
part of angular.ui.accordion;

@Component(
    selector: 'accordion-group',
//    templateUrl: 'packages/angular_ui/accordion/accordion_group.html',
    template: r'''
<div class="panel panel-default">
  <div class="panel-heading">
    <h4 class="panel-title">
      <a class="accordion-toggle" ng-click="toggleOpen()" accordion-transclude="heading"><span ng-class="{'text-muted': isDisabled}">{{heading}}</span></a>
    </h4>
  </div>
  <div class="panel-collapse" collapse="collapse">
    <div class="panel-body"><content></content></div>
  </div>
</div>
''',
    useShadowDom: false
)
class AccordionGroupComponent implements DetachAware, ScopeAware {

  @NgAttr('heading') 
  var heading;
  
  final AccordionComponent accordion;
  final DblClickPreventer dblClickPreventer;
  final Timeout timeout;

  AccordionGroupComponent(this.accordion, this.dblClickPreventer, this.timeout) {
    accordion.addGroup(this);
  }
  
  void set scope(Scope scope) {
    //
    timeout(() {
      scope.watch('isOpen', (value, old){
        collapse = !value;
      });
    }, delay:500);
  }
  
  bool _isOpen = false;
  @NgTwoWay('is-open') 
  set isOpen(value) {
    _isOpen = utils.toBool(value);
    if (_isOpen) {
      accordion.closeOthers(this);
    }
  }
  get isOpen => _isOpen;
  
  bool collapse = false;
  
  bool _isDisabled = false;
  @NgTwoWay('is-disabled') 
  get isDisabled => _isDisabled;
  set isDisabled(var newValue) {
    _isDisabled = utils.toBool(newValue);
  }
  
  toggleOpen() {
    dblClickPreventer(() {
      if ( !isDisabled ) {
        isOpen = !isOpen;
      }
    });
  }
  
  @override
  void detach() {
    this.accordion.removeGroup(this);
  }
}

/*
 * Use accordion-heading below an accordion-group to provide a heading containing HTML
 * <accordion-group>
 *   <accordion-heading>Heading containing HTML - <img src="..."></accordion-heading>
 * </accordion-group>
 */
@Decorator(selector: 'accordion-heading')
class AccordionHeadingComponent {
  AccordionHeadingComponent(dom.Element elem, AccordionGroupComponent acc) {
    elem.remove();
    acc.heading = elem;
  }
}

/**
 * This decorator update heading depends on 
 * presence of [AccordionHeadingComponent] in [AccordionGroupComponent]
 */
@Decorator(selector: '[accordion-transclude]')
class AccordionTransclude implements ScopeAware {
  dom.Element elem;
  
  AccordionTransclude(this.elem);

  void set scope(Scope scope) {
    scope.watch("heading", (value, previousValue) {
      if (value != null && value is dom.Element && value.tagName == 'ACCORDION-HEADING') {
        // We adding text belogns to 'accordion-heading' element to span element
        dom.SpanElement span = elem.firstChild as dom.SpanElement;
        span.children.clear();
        span.appendHtml(value.innerHtml.trim());
        // Other elements like icons must move separatelly into the element itself 
        while (value.children.length > 0) {
          elem.append(value.children[0]);
        }
      }
    });
  }
}