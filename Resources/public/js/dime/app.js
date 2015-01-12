
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
        "dime/widget/widgetManager",
        "dime/event/eventManager",
        "dojo/NodeList-manipulate",
        "dojo/NodeList-traverse",
        "dime/module"
    ],
    function(declare, parser, dom, domStyle, domGeometry, baseFx, ContentPane, registry,
             editor, storeManager, dialogManager, widgetManager, eventManager) {
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

                date: function(format, timestamp) {
                    //  discuss at: http://phpjs.org/functions/date/
                    // original by: Carlos R. L. Rodrigues (http://www.jsfromhell.com)
                    // original by: gettimeofday
                    //    parts by: Peter-Paul Koch (http://www.quirksmode.org/js/beat.html)
                    // improved by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
                    // improved by: MeEtc (http://yass.meetcweb.com)
                    // improved by: Brad Touesnard
                    // improved by: Tim Wiel
                    // improved by: Bryan Elliott
                    // improved by: David Randall
                    // improved by: Theriault
                    // improved by: Theriault
                    // improved by: Brett Zamir (http://brett-zamir.me)
                    // improved by: Theriault
                    // improved by: Thomas Beaucourt (http://www.webapp.fr)
                    // improved by: JT
                    // improved by: Theriault
                    // improved by: Rafał Kukawski (http://blog.kukawski.pl)
                    // improved by: Theriault
                    //    input by: Brett Zamir (http://brett-zamir.me)
                    //    input by: majak
                    //    input by: Alex
                    //    input by: Martin
                    //    input by: Alex Wilson
                    //    input by: Haravikk
                    // bugfixed by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
                    // bugfixed by: majak
                    // bugfixed by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
                    // bugfixed by: Brett Zamir (http://brett-zamir.me)
                    // bugfixed by: omid (http://phpjs.org/functions/380:380#comment_137122)
                    // bugfixed by: Chris (http://www.devotis.nl/)
                    //        note: Uses global: php_js to store the default timezone
                    //        note: Although the function potentially allows timezone info (see notes), it currently does not set
                    //        note: per a timezone specified by date_default_timezone_set(). Implementers might use
                    //        note: this.php_js.currentTimezoneOffset and this.php_js.currentTimezoneDST set by that function
                    //        note: in order to adjust the dates in this function (or our other date functions!) accordingly
                    //   example 1: date('H:m:s \\m \\i\\s \\m\\o\\n\\t\\h', 1062402400);
                    //   returns 1: '09:09:40 m is month'
                    //   example 2: date('F j, Y, g:i a', 1062462400);
                    //   returns 2: 'September 2, 2003, 2:26 am'
                    //   example 3: date('Y W o', 1062462400);
                    //   returns 3: '2003 36 2003'
                    //   example 4: x = date('Y m d', (new Date()).getTime()/1000);
                    //   example 4: (x+'').length == 10 // 2009 01 09
                    //   returns 4: true
                    //   example 5: date('W', 1104534000);
                    //   returns 5: '53'
                    //   example 6: date('B t', 1104534000);
                    //   returns 6: '999 31'
                    //   example 7: date('W U', 1293750000.82); // 2010-12-31
                    //   returns 7: '52 1293750000'
                    //   example 8: date('W', 1293836400); // 2011-01-01
                    //   returns 8: '52'
                    //   example 9: date('W Y-m-d', 1293974054); // 2011-01-02
                    //   returns 9: '52 2011-01-02'

                    var that = this;
                    var jsdate, f;
                    // Keep this here (works, but for code commented-out below for file size reasons)
                    // var tal= [];
                    var txt_words = [
                        'Sonntag', 'Montag', 'Dienstag', 'Mittwoch', 'Donnerstag', 'Freitag', 'Samstag',
                        'Januar', 'Februar', 'März', 'April', 'Mai', 'Juni',
                        'Juli', 'August', 'September', 'Oktober', 'November', 'Dezember'
                    ];
                    // trailing backslash -> (dropped)
                    // a backslash followed by any character (including backslash) -> the character
                    // empty string -> empty string
                    var formatChr = /\\?(.?)/gi;
                    var formatChrCb = function (t, s) {
                        return f[t] ? f[t]() : s;
                    };
                    var _pad = function (n, c) {
                        n = String(n);
                        while (n.length < c) {
                            n = '0' + n;
                        }
                        return n;
                    };
                    f = {
                        // Day
                        d: function () {
                            // Day of month w/leading 0; 01..31
                            return _pad(f.j(), 2);
                        },
                        D: function () {
                            // Shorthand day name; Mon...Sun
                            return f.l()
                                .slice(0, 3);
                        },
                        j: function () {
                            // Day of month; 1..31
                            return jsdate.getDate();
                        },
                        l: function () {
                            // Full day name; Monday...Sunday
                            return txt_words[f.w()];
                        },
                        N: function () {
                            // ISO-8601 day of week; 1[Mon]..7[Sun]
                            return f.w() || 7;
                        },
                        S: function () {
                            // Ordinal suffix for day of month; st, nd, rd, th
                            var j = f.j();
                            var i = j % 10;
                            if (i <= 3 && parseInt((j % 100) / 10, 10) == 1) {
                                i = 0;
                            }
                            return ['st', 'nd', 'rd'][i - 1] || 'th';
                        },
                        w: function () {
                            // Day of week; 0[Sun]..6[Sat]
                            return jsdate.getDay();
                        },
                        z: function () {
                            // Day of year; 0..365
                            var a = new Date(f.Y(), f.n() - 1, f.j());
                            var b = new Date(f.Y(), 0, 1);
                            return Math.round((a - b) / 864e5);
                        },

                        // Week
                        W: function () {
                            // ISO-8601 week number
                            var a = new Date(f.Y(), f.n() - 1, f.j() - f.N() + 3);
                            var b = new Date(a.getFullYear(), 0, 4);
                            return _pad(1 + Math.round((a - b) / 864e5 / 7), 2);
                        },

                        // Month
                        F: function () {
                            // Full month name; January...December
                            return txt_words[6 + f.n()];
                        },
                        m: function () {
                            // Month w/leading 0; 01...12
                            return _pad(f.n(), 2);
                        },
                        M: function () {
                            // Shorthand month name; Jan...Dec
                            return f.F()
                                .slice(0, 3);
                        },
                        n: function () {
                            // Month; 1...12
                            return jsdate.getMonth() + 1;
                        },
                        t: function () {
                            // Days in month; 28...31
                            return (new Date(f.Y(), f.n(), 0))
                                .getDate();
                        },

                        // Year
                        L: function () {
                            // Is leap year?; 0 or 1
                            var j = f.Y();
                            return j % 4 === 0 & j % 100 !== 0 | j % 400 === 0;
                        },
                        o: function () {
                            // ISO-8601 year
                            var n = f.n();
                            var W = f.W();
                            var Y = f.Y();
                            return Y + (n === 12 && W < 9 ? 1 : n === 1 && W > 9 ? -1 : 0);
                        },
                        Y: function () {
                            // Full year; e.g. 1980...2010
                            return jsdate.getFullYear();
                        },
                        y: function () {
                            // Last two digits of year; 00...99
                            return f.Y()
                                .toString()
                                .slice(-2);
                        },

                        // Time
                        a: function () {
                            // am or pm
                            return jsdate.getHours() > 11 ? 'pm' : 'am';
                        },
                        A: function () {
                            // AM or PM
                            return f.a()
                                .toUpperCase();
                        },
                        B: function () {
                            // Swatch Internet time; 000..999
                            var H = jsdate.getUTCHours() * 36e2;
                            // Hours
                            var i = jsdate.getUTCMinutes() * 60;
                            // Minutes
                            // Seconds
                            var s = jsdate.getUTCSeconds();
                            return _pad(Math.floor((H + i + s + 36e2) / 86.4) % 1e3, 3);
                        },
                        g: function () {
                            // 12-Hours; 1..12
                            return f.G() % 12 || 12;
                        },
                        G: function () {
                            // 24-Hours; 0..23
                            return jsdate.getHours();
                        },
                        h: function () {
                            // 12-Hours w/leading 0; 01..12
                            return _pad(f.g(), 2);
                        },
                        H: function () {
                            // 24-Hours w/leading 0; 00..23
                            return _pad(f.G(), 2);
                        },
                        i: function () {
                            // Minutes w/leading 0; 00..59
                            return _pad(jsdate.getMinutes(), 2);
                        },
                        s: function () {
                            // Seconds w/leading 0; 00..59
                            return _pad(jsdate.getSeconds(), 2);
                        },
                        u: function () {
                            // Microseconds; 000000-999000
                            return _pad(jsdate.getMilliseconds() * 1000, 6);
                        },

                        // Timezone
                        e: function () {
                            // Timezone identifier; e.g. Atlantic/Azores, ...
                            // The following works, but requires inclusion of the very large
                            // timezone_abbreviations_list() function.
                            /*              return that.date_default_timezone_get();
                             */
                            throw 'Not supported (see source code of date() for timezone on how to add support)';
                        },
                        I: function () {
                            // DST observed?; 0 or 1
                            // Compares Jan 1 minus Jan 1 UTC to Jul 1 minus Jul 1 UTC.
                            // If they are not equal, then DST is observed.
                            var a = new Date(f.Y(), 0);
                            // Jan 1
                            var c = Date.UTC(f.Y(), 0);
                            // Jan 1 UTC
                            var b = new Date(f.Y(), 6);
                            // Jul 1
                            // Jul 1 UTC
                            var d = Date.UTC(f.Y(), 6);
                            return ((a - c) !== (b - d)) ? 1 : 0;
                        },
                        O: function () {
                            // Difference to GMT in hour format; e.g. +0200
                            var tzo = jsdate.getTimezoneOffset();
                            var a = Math.abs(tzo);
                            return (tzo > 0 ? '-' : '+') + _pad(Math.floor(a / 60) * 100 + a % 60, 4);
                        },
                        P: function () {
                            // Difference to GMT w/colon; e.g. +02:00
                            var O = f.O();
                            return (O.substr(0, 3) + ':' + O.substr(3, 2));
                        },
                        T: function () {
                            // Timezone abbreviation; e.g. EST, MDT, ...
                            // The following works, but requires inclusion of the very
                            // large timezone_abbreviations_list() function.
                            /*              var abbr, i, os, _default;
                             if (!tal.length) {
                             tal = that.timezone_abbreviations_list();
                             }
                             if (that.php_js && that.php_js.default_timezone) {
                             _default = that.php_js.default_timezone;
                             for (abbr in tal) {
                             for (i = 0; i < tal[abbr].length; i++) {
                             if (tal[abbr][i].timezone_id === _default) {
                             return abbr.toUpperCase();
                             }
                             }
                             }
                             }
                             for (abbr in tal) {
                             for (i = 0; i < tal[abbr].length; i++) {
                             os = -jsdate.getTimezoneOffset() * 60;
                             if (tal[abbr][i].offset === os) {
                             return abbr.toUpperCase();
                             }
                             }
                             }
                             */
                            return 'UTC';
                        },
                        Z: function () {
                            // Timezone offset in seconds (-43200...50400)
                            return -jsdate.getTimezoneOffset() * 60;
                        },

                        // Full Date/Time
                        c: function () {
                            // ISO-8601 date.
                            return 'Y-m-d\\TH:i:sP'.replace(formatChr, formatChrCb);
                        },
                        r: function () {
                            // RFC 2822
                            return 'D, d M Y H:i:s O'.replace(formatChr, formatChrCb);
                        },
                        U: function () {
                            // Seconds since UNIX epoch
                            return jsdate / 1000 | 0;
                        }
                    };
                    this.date = function (format, timestamp) {
                        that = this;
                        jsdate = (timestamp === undefined ? new Date() : // Not provided
                            (timestamp instanceof Date) ? new Date(timestamp) : // JS Date()
                                new Date(timestamp * 1000) // UNIX timestamp (auto-convert to int)
                        );
                        return format.replace(formatChr, formatChrCb);
                    };
                    return this.date(format, timestamp);
                },

                getDateRange: function(range, date){
                    if(range == 'Month'){
                        return [ new Date(date.getFullYear(), date.getMonth(), 1), new Date(date.getFullYear(), date.getMonth() + 1, 0)];
                    } else if(range == 'Week'){
                        var d1 = new Date();
                        var weekNo = app.date('W', eval(date.getTime()/1000));
                        //Reset d1 to Last Monday
                        var numOfdaysPastSinceLastMonday = eval(d1.getDay()- 1);
                        d1.setDate(d1.getDate() - numOfdaysPastSinceLastMonday);
                        //Calculate Delta of Weeks between the Week Today and the Target Week
                        var weekNoToday = app.date('W', eval(d1.getTime()/1000));
                        var weeksInTheFuture = eval( weekNo - weekNoToday );
                        //Add the Week Delta to Date in Days
                        d1.setDate(d1.getDate() + eval( 7 * weeksInTheFuture ));
                        //This Results in the Monday which is Delta Weeks Past or Future of Today
                        var startdate = new Date(d1.getFullYear(), d1.getMonth(), d1.getDate());
                        //Now Add Six to get the Coresponding Sunday
                        d1.setDate(d1.getDate() + 6);
                        var enddate = new Date(d1.getFullYear(), d1.getMonth(), d1.getDate());
                        return [ startdate, enddate ];
                    } else {
                        return [date, date];
                    }
                },

                StepDate: function(direction, type, amount, date){
                    var returndate = new Date(date.getTime());
                    if (direction === 'advance') {
                        if(type == 'Year'){
                            returndate.setFullYear(date.getFullYear() + amount);
                        } else if (type == 'Month') {
                            returndate.setMonth(date.getMonth() + amount);
                        } else if (type == 'Week') {
                            returndate.setDate(date.getDate() + eval( 7 * amount));
                        } else {
                            returndate.setDate(date.getDate() + amount);
                        }
                    } else {
                        if(type == 'Year'){
                            returndate.setFullYear(date.getFullYear() - amount);
                        } else if (type == 'Month') {
                            returndate.setMonth(date.getMonth() - amount);
                        } else if (type == 'Week') {
                            returndate.setDate(date.getDate() - (7 * amount));
                        } else {
                            returndate.setDate(date.getDate() - amount);
                        }
                    }
                    return returndate;
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

                initManager: function () {
                    window.storeManager = new storeManager();
                    window.dialogManager = new dialogManager();
                    window.widgetManager = new widgetManager();
                    window.eventManager = new eventManager();
                },

                init: function () {
                    this.startLoading();

                    this.initManager();
                    window.dgrid = {
                        editor: editor
                    };

                    this.endLoading();
                }
        })

    }
);