// ignore_for_file: strong_mode_implicit_dynamic_parameter
import 'dart:async';
import 'dart:html';

import 'package:angular/angular.dart';
import 'package:js/js.dart';
import 'package:pikaday/pikaday.dart';
import 'package:pikaday/pikaday_dart_helpers.dart';

import 'package:pikaday_datepicker_angular/src/conversion.dart';

/// AngularDart component wrapper around the Pikaday-js lib. You will have to
/// link to pikaday.js (Get the latest version from it's
/// [GitHub page](https://github.com/dbushell/Pikaday) and if you want
/// a custom date format (which is highly likable) also to [moment.js](http://momentjs.com/)).
///
/// Attribute documentation adapted from the
/// [pikaday.js documentation](https://github.com/dbushell/Pikaday).
///
/// You can't set a container DOM node nore a callback, but you can listen to
/// dayChange to be informed about selected days (DateTime instances).

@Component(
    selector: 'pikaday',
    template:
        '<input type="text" #refid id="{{id}}" class="{{cssClasses}}" placeholder="{{placeholder}}" [disabled]="readonly" style="{{ cssText }}">')
class PikadayComponent implements AfterViewInit {
  static int _componentCounter = 0;
  final String id = "pikadayInput${++_componentCounter}";

  @ViewChild('refid')
  HtmlElement ref;

  /// css-classes to be set on the pikaday-inputfield via <input class="{{cssClasses}}>
  @Input()
  String cssClasses = "";

  /// Sets the placeholder of the pikaday-inputfield.
  @Input()
  String placeholder;

  Pikaday _pikaday;
  // default options
  final PikadayOptions _options = new PikadayOptions(
      showTime: false, autoClose: true, use24hour: false, incrementMinuteBy: 15, incrementSecondBy: 10, showSeconds: false);

  bool get _isInitPhase => _pikaday == null;

  /// Emits selected dates (day and time).
  final _dayChange = new StreamController<DateTime>();
  @Output()
  Stream<DateTime> get dayChange => _dayChange.stream;

  /// The initially selected day and time
  /// Combines [PikadayOptions.defaultDate] with [PikadayOptions.setDefaultDate].
  @Input()
  void set day(DateTime day) {
    if (_isInitPhase) {
      _options.defaultDate = day;
      _options.setDefaultDate = day != null;
    } else {
      if (day != null) {
        var dayMillies = day?.millisecondsSinceEpoch;
        setPikadayMillisecondsSinceEpoch(_pikaday, dayMillies);
      } else {
        _pikaday.setDate(null);
      }
    }
  }

  /// Optional boolean property to specify whether to show time controls with calendar or not.
  /// <bool> or <String>. default: false. Forwards to [PikadayOptions.showTime].
  @Input()
  void set showTime(value) {
    _options.showTime = boolValue(value);
  }

  /// Optional numeric property to prevent calendar from auto-closing after date is selected.
  /// <bool> or <String>. default: true. Should probably be false if showTime: true. Forwards to [PikadayOptions.autoClose].
  @Input()
  void set autoClose(value) {
    _options.autoClose = boolValue(value);
  }

  /// Optional boolean property to specify whether to use 24 hours format or not.
  /// <bool> or <String>. default: false. Forwards to [PikadayOptions.use24hour].
  @Input()
  void set use24hour(value) {
    _options.use24hour = boolValue(value);
  }

  /// Optional string added to left of time select.
  /// Forwards to [PikadayOptions.timeLabel].
  @Input()
  void set timeLabel(String value) {
    _options.timeLabel = value;
  }

  /// Optional boolean property to specify whether to show minute controls with calendar or not.  /// <bool> or <String>. default: true. Forwards to [PikadayOptions.showMinutes].
  @Input()
  void set showMinutes(value) {
    _options.showMinutes = boolValue(value);
  }

  /// Optional boolean property to specify whether to show second controls with calendar or not.
  /// <bool> or <String>. default: false. Forwards to [PikadayOptions.showSeconds].
  @Input()
  void set showSeconds(value) {
    _options.showSeconds = boolValue(value);
  }

  /// default: 1. Forwards to [PikadayOptions.incrementHourBy].
  @Input()
  void set incrementHourBy(num value) {
    _options.incrementHourBy = value;
  }

  /// default: 15. Forwards to [PikadayOptions.incrementMinuteBy].
  @Input()
  void set incrementMinuteBy(num value) {
    _options.incrementMinuteBy = value;
  }

  /// default: 10. Forwards to [PikadayOptions.incrementSecondBy].
  @Input()
  void set incrementSecondBy(num value) {
    _options.incrementSecondBy = value;
  }

  /// Automatically show/hide the datepicker on field focus.
  /// Default: true if field is set.
  /// <bool> or <String>. Forwards to [PikadayOptions.bound].
  @Input()
  void set bound(bound) {
    _options.bound = boolValue(bound);
  }

  /// Preferred position of the datepicker relative to the form field
  /// (e.g. 'top right'). Automatic adjustment may occur to avoid
  /// displaying outside the viewport. Default: 'bottom left'.
  /// Forwards to [PikadayOptions.position].
  @Input()
  void set position(String position) {
    _options.position = position;
  }

  /// Can be set to false to not reposition the datepicker within the
  /// viewport, forcing it to take the configured position. Default: true.
  /// <bool> or <String>. Forwards to [PikadayOptions.reposition].
  @Input()
  void set reposition(reposition) {
    _options.reposition = boolValue(reposition);
  }

  /// The default output format for toString() and field value.
  /// Requires Moment.js for custom formatting.
  /// Forwards to [PikadayOptions.format].
  @Input()
  void set format(String format) {
    _options.format = format;
  }

  /// First day of the week (0: Sunday, 1: Monday, etc).
  /// <int> or <String>. Forwards to [PikadayOptions.firstDay].
  @Input()
  void set firstDay(firstDay) {
    _options.firstDay = intValue(firstDay);
  }

  /// <DateTime> or <String> with format YYYY-MM-DD. Forwards to [PikadayOptions.minDate].
  @Input()
  void set minDate(minDate) {
    final minDateAsDateTime = dayValue(minDate);
    if (_isInitPhase) {
      _options.minDate = minDateAsDateTime;
    } else {
      var minDateMillies = minDateAsDateTime?.millisecondsSinceEpoch;
      setPikadayMinDateAsMillisecondsSinceEpoch(_pikaday, minDateMillies);
    }
  }

  /// <DateTime> or <String> with format YYYY-MM-DD. Forwards to [PikadayOptions.maxDate].
  @Input()
  void set maxDate(maxDate) {
    final maxDateAsDateTime = dayValue(maxDate);
    if (_isInitPhase) {
      _options.maxDate = maxDateAsDateTime;
    } else {
      var maxDateMillies = maxDateAsDateTime?.millisecondsSinceEpoch;
      setPikadayMaxDateAsMillisecondsSinceEpoch(_pikaday, maxDateMillies);
    }
  }

  /// Disallow selection of Saturdays and Sundays.
  /// Forwards to [PikadayOptions.disableWeekends].
  @Input()
  void set disableWeekends(disableWeekends) {
    _options.disableWeekends = boolValue(disableWeekends);
  }

  /// <int>, <List<int>> or <String> (single '1990' or double '1980,2020').
  /// Forwards to [PikadayOptions.yearRange].
  @Input()
  void set yearRange(yearRange) {
    _options.yearRange = yearRangeValue(yearRange);
  }

  /// Show the ISO week number at the head of the row. Default: false.
  /// <bool> or <String>. Forwards to [PikadayOptions.showWeekNumber].
  @Input()
  void set showWeekNumber(showWeekNumber) {
    _options.showWeekNumber = boolValue(showWeekNumber);
  }

  /// Reverse the calendar for right-to-left languages. Default: false.
  /// <bool> or <String>. Forwards to [PikadayOptions.isRTL].
  @Input()
  void set isRTL(isRTL) {
    _options.isRTL = boolValue(isRTL);
  }

  /// Language defaults for month and weekday names.
  /// Forwards to [PikadayOptions.i18n].
  @Input()
  void set i18n(PikadayI18nConfig i18n) {
    _options.i18n = i18n;
  }

  /// Additional text to append to the year in the title.
  /// Forwards to [PikadayOptions.yearSuffix].
  @Input()
  void set yearSuffix(String yearSuffix) {
    _options.yearSuffix = yearSuffix;
  }

  /// Render the month after the year in the title. Default: false.
  /// <bool> or <String>. Forwards to [PikadayOptions.showMonthAfterYear].
  @Input()
  void set showMonthAfterYear(showMonthAfterYear) {
    _options.showMonthAfterYear = boolValue(showMonthAfterYear);
  }

  /// Render days of the calendar grid that fall in the next or previous months to the current month instead of rendering an empty table cell. Default: false.
  /// <bool> or <String>. Forwards to [PikadayOptions.showDaysInNextAndPreviousMonths].
  @Input()
  void set showDaysInNextAndPreviousMonths(showDaysInNextAndPreviousMonths) {
    _options.showDaysInNextAndPreviousMonths = boolValue(showDaysInNextAndPreviousMonths);
  }

  /// Number of visible calendars.
  /// <int> or <String>. Forwards to [PikadayOptions.numberOfMonths].
  @Input()
  void set numberOfMonths(numberOfMonths) {
    _options.numberOfMonths = intValue(numberOfMonths);
  }

  /// When numberOfMonths is used, this will help you to choose where the
  /// main calendar will be (default left, can be set to right). Only used
  /// for the first display or when a selected date is not already visible.
  /// Forwards to [PikadayOptions.mainCalendar].
  /// permitted values: "left", "right";
  @Input()
  void set mainCalendar(String mainCalendar) {
    if (mainCalendar == "right" || mainCalendar == "left") {
      _options.mainCalendar = mainCalendar;
    }
    throw new ArgumentError("should only be 'left' or 'right', but was: $mainCalendar");
  }

  /// Define a class name that can be used as a hook for styling different
  /// themes. Default: null.
  /// Forwards to [PikadayOptions.theme].
  @Input()
  void set theme(String theme) {
    _options.theme = theme;
  }

  /// readonly attribute to be set on the pikaday-inputfield via <input [readonly]="readonly">
  @Input()
  bool readonly = false;

  /// cssText to be set on the pikaday-inputfield via <input style="{{ cssText }}">
  @Input()
  String cssText = "";

  @override
  ngAfterViewInit() {
    // todo use dom element ref
    _options.field = ref;
    _options.onSelect = allowInterop((dateTimeOrDate) {
      var day =
          dateTimeOrDate is DateTime ? dateTimeOrDate : new DateTime.fromMillisecondsSinceEpoch(getPikadayMillisecondsSinceEpoch(_pikaday));

      if (day != _options.defaultDate) {
        _options.defaultDate = day;
        _dayChange.add(day);
      }
    });

    _pikaday = new Pikaday(_options);

    _options.field.onChange.listen((dynamic e) {
      if ((_options.field as InputElement).value.trim().isEmpty && _pikaday.getDate() != null) {
        this.day = null;
        _dayChange.add(null);
      }
    });

    // Currently Dart's DateTime is not correctly mapped to JS's Date
    // so they are converted to millies as transferred as int values.
    workaroundDateTimeConversionIssue(
      DateTime day,
      DateTime minDate,
      DateTime maxDate,
    ) {
      if (day != null) {
        var millies = day.millisecondsSinceEpoch;
        setPikadayMillisecondsSinceEpoch(_pikaday, millies);
      }
      if (minDate != null) {
        var millies = minDate.millisecondsSinceEpoch;
        setPikadayMinDateAsMillisecondsSinceEpoch(_pikaday, millies);
      }
      if (maxDate != null) {
        var millies = maxDate.millisecondsSinceEpoch;
        setPikadayMaxDateAsMillisecondsSinceEpoch(_pikaday, millies);
      }
    }

    workaroundDateTimeConversionIssue(_options.defaultDate, _options.minDate, _options.maxDate);
  }
}
