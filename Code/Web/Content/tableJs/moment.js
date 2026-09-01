(window.webpackJsonp = window.webpackJsonp || []).push([[72], {
    "/1Na": function(t, e, n) {
        "use strict";
        var i, a, s, o, r, c, l = window._global,
        u = l.hq_kdt_id,
        d = l.kdtId || l.kdt_id,
        _ = "https://mei.youzan.com/h5/home?kdtId=" + u + "&deptId=" + d,
        p = "https://mei.youzan.com/h5/voucher/list?kdtId=" + u + "&deptId=" + d,
        h = "https://mei.youzan.com/h5/voucher/list?kdtId=" + u + "&deptId=" + d,
        f = "https://mei.youzan.com/h5/member?deptId=" + d + "&kdtId=" + u,
        m = "https://mei.youzan.com/h5/order/list?orderStatus=0&kdtId=" + u + "&deptId=" + d,
        g = function(t) {
            return "https://mei.youzan.com/api/node/auth/sso/callback/phone?redirect=" + encodeURIComponent(t)
        },
        w = function() {
            return {
                homepage: {
                    url: g(_),
                    weappUrl: "/pages/home/home",
                    type: "switchTab"
                },
                points: {
                    url: g(f),
                    weappUrl: "/naturade/main-pages/index/index",
                    type: "switchTab"
                },
                coupon: {
                    url: g(p),
                    weappUrl: "/naturade/pages/card/coupon/coupon"
                },
                code: {
                    url: g(h),
                    weappUrl: "/naturade/pages/card/coupon/coupon"
                },
                present: {
                    url: g(f),
                    weappUrl: "/naturade/main-pages/index/index"
                },
                comment: {
                    url: g(m),
                    weappUrl: "/naturade/pages/order/list/list"
                }
            }
        },
        v = window._global,
        b = v.hq_kdt_id,
        y = v.kdtId || v.kdt_id,
        k = "https://mei.youzan.com/h5/home?kdtId=" + b + "&deptId=" + y,
        C = "https://mei.youzan.com/h5/member/points/store?kdtId=" + b + "&deptId=" + y,
        j = "https://mei.youzan.com/h5/voucher/list?kdtId=" + b + "&deptId=" + y,
        x = "https://mei.youzan.com/h5/voucher/list?kdtId=" + b + "&deptId=" + y,
        E = function(t) {
            return "https://mei.youzan.com/api/node/auth/sso/callback/phone?redirect=" + encodeURIComponent(t)
        },
        I = 42715213 == +b ? w: function() {
            return {
                homepage: {
                    url: E(k),
                    weappUrl: "/pages/home/home"
                },
                points: {
                    url: E(C),
                    weappUrl: "/points/pages/mall/index"
                },
                coupon: {
                    url: E(j),
                    weappUrl: "/member/pages/voucher/list/index"
                },
                code: {
                    url: E(x),
                    weappUrl: "/member/pages/voucher/list/index"
                },
                present: {
                    url: E(""),
                    weappUrl: ""
                }
            }
        },
        O = (n("rNhl"), n("rB9j"), n("UxlC"), window._global),
        P = O.kdtId,
        S = O.url,
        D = O.weappVersion,
        L = S.h5 + "/v2/home?kdt_id=" + P,
        U = S.h5 + "/v2/ump/pointsstore?kdt_id=" + P,
        T = S.h5 + "/wscump/coupon/list?kdt_id=" + P,
        M = S.h5 + "/v2/promocodes?kdt_id=" + P,
        W = S.h5 + "/wscump/presents?kdtId=" + P,
        R = "/packages/ump/presents/index"; (i = D || "0", a = "2.26.4", s = parseFloat(i), o = parseFloat(a), r = i.replace(s + ".", ""), c = a.replace(o + ".", ""), s > o || !(s < o) && r >= c) || (R = "");
        var A = function() {
            return {
                homepage: {
                    url: L,
                    weappUrl: "/pages/home/dashboard/index",
                    type: "switchTab"
                },
                points: {
                    url: U,
                    weappUrl: "/packages/user/integral/index"
                },
                coupon: {
                    url: T,
                    weappUrl: "/packages/user/coupon/list/index?type=promocard&title=我的优惠券"
                },
                code: {
                    url: M,
                    weappUrl: "/packages/user/coupon/list/index?type=promocode&title=我的优惠码"
                },
                present: {
                    url: W,
                    weappUrl: R
                }
            }
        },
        N = window._global,
        z = N.isBeautyShop,
        B = N.miniprogram.isWeapp,
        q = z ? I(B) : A(B);
        e.a = q
    },
    "0l8F": function(module, __webpack_exports__, __webpack_require__) {
        "use strict";
        __webpack_require__.d(__webpack_exports__, "a", (function() {
            return IFrameFramework
        }));
        var core_js_modules_es_array_index_of__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__("yXV3"),
        core_js_modules_es_array_index_of__WEBPACK_IMPORTED_MODULE_0___default = __webpack_require__.n(core_js_modules_es_array_index_of__WEBPACK_IMPORTED_MODULE_0__),
        core_js_modules_es_object_assign__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__("zKZe"),
        core_js_modules_es_object_assign__WEBPACK_IMPORTED_MODULE_1___default = __webpack_require__.n(core_js_modules_es_object_assign__WEBPACK_IMPORTED_MODULE_1__),
        core_js_modules_es_object_to_string__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__("07d7"),
        core_js_modules_es_object_to_string__WEBPACK_IMPORTED_MODULE_2___default = __webpack_require__.n(core_js_modules_es_object_to_string__WEBPACK_IMPORTED_MODULE_2__),
        core_js_modules_es_promise__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__("5s+n"),
        core_js_modules_es_promise__WEBPACK_IMPORTED_MODULE_3___default = __webpack_require__.n(core_js_modules_es_promise__WEBPACK_IMPORTED_MODULE_3__),
        _style_css__WEBPACK_IMPORTED_MODULE_4__ = __webpack_require__("7QqZ"),
        _style_css__WEBPACK_IMPORTED_MODULE_4___default = __webpack_require__.n(_style_css__WEBPACK_IMPORTED_MODULE_4__),
        _youzan_znb__WEBPACK_IMPORTED_MODULE_5__ = __webpack_require__("7j/v"),
        _youzan_utils_url_args__WEBPACK_IMPORTED_MODULE_6__ = __webpack_require__("f4ya"),
        _youzan_utils_url_args__WEBPACK_IMPORTED_MODULE_6___default = __webpack_require__.n(_youzan_utils_url_args__WEBPACK_IMPORTED_MODULE_6__),
        _utils__WEBPACK_IMPORTED_MODULE_7__ = __webpack_require__("EzGd"),
        IFrameFramework = function() {
            function IFrameFramework(t) {
                var e = t.appId,
                n = t.version,
                i = t.host,
                a = t.pagePath,
                s = t.loadingPic,
                o = t.logPath,
                r = t.uploadLog,
                c = t.initPath;
                this.id = Object(_utils__WEBPACK_IMPORTED_MODULE_7__.c)(16),
                this.version = n,
                this.appId = e,
                this.loadingPic = s,
                this.uploadLog = r,
                this.logPath = o,
                this.host = i,
                this.pageUrl = this.host + a,
                this.initUrl = this.host + c,
                this.successHandler = function() {},
                this.cancelHandler = function() {},
                this.options = {},
                this.ifmElmMounted = !1,
                this.containerId = e + "-iframe-container",
                this.iframeId = e + "-iframe",
                this.registerPostMessage(),
                this.registerScreenResize(),
                this.container = this.importContainer(),
                this.loading = this.importLoading(),
                this.ifmElm = null,
                this.initIfmElm = null,
                this.context = {},
                this.loadingTimer = null,
                this.platformCallBack()
            }
            var _proto = IFrameFramework.prototype;
            return _proto.toLog = function(t, e) {
                void 0 === e && (e = {}),
                this.uploadLog && -1 !== ["执行脚本失败", "loading 超时", "未知错误"].indexOf(t) && Object(_utils__WEBPACK_IMPORTED_MODULE_7__.a)({
                    url: this.host + this.logPath,
                    method: "POST",
                    data: {
                        logName: this.appId + "(v" + this.version + ")[" + this.id + "]:" + t,
                        data: Object(_utils__WEBPACK_IMPORTED_MODULE_7__.b)(e, location, {
                            pageUrl: this.pageUrl
                        })
                    }
                })
            },
            _proto.registerPostMessage = function registerPostMessage() {
                var _this = this;
                window.addEventListener("message", (function(event) {
                    if (event.data.messageSigned === _this.appId) switch (_this.ifmElmMounted = !0, event.data.type) {
                        case "framework-mounted":
                            _this.loadingShow(!1),
                            _this.postMessageToMain("framework-options", _this.options);
                            break;
                        case "framework-com-mounted":
                            _this.mainShow(!0),
                            _this.toLog("弹窗已挂载到 DOM 且已显示");
                            break;
                        case "framework-close":
                            _this.cancelHandler(event.data.data);
                        case "framework-close-auto":
                            _this.close(),
                            _this.toLog("弹窗隐藏");
                            break;
                        case "framework-success":
                            _this.toLog("业务成功"),
                            _this.successHandler(event.data.data);
                            break;
                        case "framework-eval":
                            try {
                                eval(event.data.data),
                                _this.toLog("执行脚本成功", {
                                    code: event.data.data
                                })
                            } catch(t) {
                                _this.toLog("执行脚本失败", {
                                    code: event.data.data,
                                    error: t
                                })
                            }
                            break;
                        case "navigate-to-native":
                            _youzan_znb__WEBPACK_IMPORTED_MODULE_5__.
                        default.init().then((function() {
                            return _youzan_znb__WEBPACK_IMPORTED_MODULE_5__.
                            default.navigate(event.data.data)
                        }))
                    }
                }), !1)
            },
            _proto.registerScreenResize = function() {
                var t = this;
                window.addEventListener("resize", (function() {
                    t.container.style.height = t.getHeight() + "px",
                    t.ifmElm && (t.ifmElm.height = t.getHeight() + "px")
                }), !1)
            },
            _proto.postMessageToMain = function(t, e) {
                this.ifmElm && this.ifmElmMounted && (this.ifmElm.contentWindow ? this.ifmElm.contentWindow.postMessage({
                    type: t,
                    data: e,
                    messageSigned: this.appId
                },
                "*") : this.toLog("contentWindow", {
                    href: location.href
                }))
            },
            _proto.getHeight = function() {
                var t = window.innerHeight;
                return window.outerHeight && window.outerHeight < t && (t = window.outerHeight),
                t
            },
            _proto.getWidth = function() {
                var t = window.innerWidth;
                return window.outerWidth && window.outerWidth < t && (t = window.outerWidth),
                t
            },
            _proto.importContainer = function() {
                if (!this.container) {
                    var t = document.createElement("div");
                    t.id = this.containerId,
                    t.classList.add("framework-iframe-container"),
                    t.style.height = this.getHeight() + "px",
                    t.style.zIndex = "-1",
                    this.container = t,
                    document.body.appendChild(t)
                }
                return this.container
            },
            _proto.containerShow = function(t) {
                this.container.style.zIndex = t ? "9999": "-1",
                this.postMessageToMain("framework-container", {
                    show: t
                })
            },
            _proto.importLoading = function() {
                if (!this.loading) {
                    var t = document.createElement("div");
                    t.className = "frame-loading",
                    t.innerHTML = '\n      <div class="van-toast van-toast--middle van-toast--loading">\n        <div class="van-loading van-loading--circular van-toast__loading">\n          <span class="van-loading__spinner van-loading__spinner--circular">\n            <svg viewBox="25 25 50 50" class="van-loading__circular">\n            <circle cx="50" cy="50" r="20" fill="none"></circle>\n            </svg>\n          </span>\n        </div>\n        <div class="van-toast__text">加载中...</div>\n      </div>\n      ',
                    t.style.display = "none",
                    this.loading = t,
                    this.container.appendChild(t)
                }
                return this.loading
            },
            _proto.loadingShow = function(t) {
                var e = this;
                clearTimeout(this.loadingTimer),
                t && (this.loadingTimer = setTimeout((function() {
                    e.close(),
                    e.toLog("loading 超时")
                }), 5e3)),
                this.loading.style.display = t ? "block": "none",
                this.postMessageToMain("framework-loading", {
                    show: t
                })
            },
            _proto.importMain = function() {
                if (!this.ifmElm) {
                    var t = document.createElement("iframe");
                    this.ifmElm = t,
                    t.id = this.iframeId,
                    t.frameBorder = 0,
                    t.allowFullscreen = !0,
                    t.style.visibility = "hidden",
                    t.height = this.getHeight(),
                    t.width = this.getWidth();
                    var e = {
                        version: this.version
                    };
                    t.src = _youzan_utils_url_args__WEBPACK_IMPORTED_MODULE_6___default.a.add(this.pageUrl, e),
                    this.container.appendChild(t)
                }
            },
            _proto.mainShow = function(t) {
                this.ifmElm && (this.ifmElm.style.visibility = t ? "visible": "hidden"),
                this.postMessageToMain("framework-main", {
                    show: t
                })
            },
            _proto.open = function(t) {
                var e = this;
                return void 0 === t && (t = {}),
                this.options = Object.assign({
                    pageUrl: location.href,
                    _global: _global
                },
                t),
                this.toLog("准备呼起弹窗"),
                new Promise((function(t, n) {
                    try {
                        e.cancelHandler = n,
                        e.successHandler = t,
                        e.containerShow(!0),
                        e.ifmElmMounted ? (e.toLog("二次显示弹窗"), e.containerShow(!0), e.mainShow(!0), e.postMessageToMain("framework-options", e.options), e.postMessageToMain("second-show", e.options)) : (e.toLog("首次挂载弹窗"), e.loadingShow(!0), e.importMain())
                    } catch(t) {
                        e.toLog("未知错误", {
                            error: t
                        }),
                        n()
                    }
                }))
            },
            _proto.close = function() {
                this.loadingShow(!1),
                this.mainShow(!1),
                this.containerShow(!1)
            },
            _proto.init = function(t, e) {
                void 0 === t && (t = {}),
                void 0 === e && (e = 1),
                this.context[e] = t
            },
            _proto.platformCallBack = function() {
                if (localStorage && ("1" === localStorage.getItem(this.appId + "-need-callback") && (localStorage.removeItem(this.appId + "-need-callback"), !this.initIfmElm))) {
                    var t = document.createElement("iframe");
                    this.initIfmElm = t,
                    t.id = this.appId + "-init",
                    t.frameBorder = 0,
                    t.allowFullscreen = !0,
                    t.style.visibility = "hidden",
                    t.height = 0,
                    t.width = 0;
                    var e = {
                        version: this.version
                    };
                    t.src = _youzan_utils_url_args__WEBPACK_IMPORTED_MODULE_6___default.a.add(this.initUrl, e),
                    document.body.appendChild(t)
                }
            },
            IFrameFramework
        } ()
    },
    "0s9g": function(t, e, n) {},
    "3lEi": function(t, e, n) {
        "use strict";
        n.d(e, "b", (function() {
            return u
        })),
        n.d(e, "a", (function() {
            return d
        })),
        n.d(e, "d", (function() {
            return _
        })),
        n.d(e, "c", (function() {
            return p
        }));
        var i = n("7j/v"),
        a = n("ypRW"),
        s = (window._global || {}).miniprogram,
        o = (s = void 0 === s ? {}: s).isSwanApp,
        r = s.isTTApp,
        c = s.isAliApp,
        l = s.isQQApp;
        var u = !!
        function() {
            try {
                var t = window.YzPageLogger.getCarrierParams("guang");
                return JSON.parse(t)
            } catch(t) {
                return null
            }
        } (),
        d = o || r || c || l;
        function _(t, e, n) {
            void 0 === n && (n = "navigateTo"),
            u ? a.redirect({
                kdtId: window._global.kdtId || window._global.kdt_id,
                url: t
            }) : i.
        default.navigate({
            url:
            t,
            weappUrl: e,
            type: n
        })
        }
        function p(t) {
            var e = t || {},
            n = e.url,
            s = e.weappUrl,
            o = e.type,
            r = void 0 === o ? "navigateTo": o,
            c = e.aliappUrl,
            l = e.qqUrl;
            u ? a.redirect({
                kdtId: window._global.kdtId || window._global.kdt_id,
                url: n
            }) : i.
        default.navigate({
            url:
            n,
            weappUrl: s,
            qqUrl: l,
            aliappUrl: c,
            type: r
        })
        }
    },
    "3xkE": function(t, e, n) {
        t.exports = n("yvjp")("3xkE")
    },
    42 : function(t, e, n) {
        n("Xpxr"),
        t.exports = n("NYZP")
    },
    "4Brf": function(t, e, n) {
        t.exports = n("yvjp")("4Brf")
    },
    "50Ur": function(t, e, n) {
        "use strict";
        var i = {
            name: "no-follow",
            props: {
                imgStyle: {
                    type: Object,
                    default:
                        function() {
                            return {}
                        }
                },
                textStyle: {
                    type: Object,
                    default:
                        function() {
                            return {}
                        }
                }
            }
        },
        a = (n("xCMC"), n("KHd+")),
        s = Object(a.
    default)(i, (function() {
        var t = this.$createElement,
        e = this._self._c || t;
        return e("div", {
            staticClass: "no-follow"
        },
        [e("div", {
            staticClass: "no-follow__wxid"
        },
        [e("p", {
            staticClass: "no-follow__no-weixin",
            style: this.imgStyle
        })]), e("p", {
            staticClass: "no-follow__text",
            style: this.textStyle
        },
        [this._v("商家二维码失效"), e("br"), this._v("公众号暂时无法关注")])])
    }), [], !1, null, "b7bb3db2", null);
        e.a = s.exports
    },
    "7QqZ": function(t, e, n) {},
    "9nYL": function(t, e, n) {},
    Bbwx: function(t, e, n) {},
    EzGd: function(t, e, n) {
        "use strict";
        n.d(e, "b", (function() {
            return i
        })),
        n.d(e, "a", (function() {
            return a
        })),
        n.d(e, "c", (function() {
            return s
        }));
        n("QWBl"),
        n("zKZe"),
        n("tkto"),
        n("FZtP");
        var i = function() {
            return (Object.assign ||
            function(t) {
                for (var e, n = 1,
                i = arguments.length; n < i; n++) for (var a in e = arguments[n]) Object.prototype.hasOwnProperty.call(e, a) && (t[a] = e[a]);
                return t
            }).apply(this, arguments)
        };
        function a(t) {
            var e = new XMLHttpRequest;
            e.open(t.method, t.url),
            e.setRequestHeader("Content-Type", "application/json"),
            t.headers && Object.keys(t.headers).forEach((function(n) {
                e.setRequestHeader(n, t.headers[n])
            })),
            e.withCredentials = !0,
            e.timeout = 5e3,
            e.responseType = "json",
            e.onreadystatechange = function() {
                if (4 === e.readyState) if (200 === e.status && e.response) {
                    var n = e.response;
                    "string" == typeof n && (n = JSON.parse(n)),
                    "function" == typeof t.success && t.success(n)
                } else "function" == typeof t.fail && t.fail(e.errors)
            },
            e.send(JSON.stringify(t.data))
        }
        function s(t) {
            t = t || 32;
            for (var e = "ABCDEFGHJKMNPQRSTWXYZabcdefhijkmnprstwxyz2345678",
            n = e.length,
            i = "",
            a = 0; a < t; a++) i += e.charAt(Math.floor(Math.random() * n));
            return i
        }
    },
    HAuM: function(t, e, n) {
        t.exports = n("yvjp")("HAuM")
    },
    Hy6h: function(t, e, n) {
        "use strict";
        var i = n("VC/J");
        n.n(i).a
    },
    IZWc: function(t, e, n) {
        "use strict";
        var i = 0,
        a = {
            name: "long-press",
            methods: {
                handleTouchStar: function() {
                    i = setTimeout(this.onLongPress, 500)
                },
                handleTouchEnd: function() {
                    clearTimeout(i)
                },
                handleTouchMove: function() {
                    clearTimeout(i),
                    i = 0
                },
                onLongPress: function() {
                    this.$emit("long-press")
                }
            }
        },
        s = n("KHd+"),
        o = Object(s.
    default)(a, (function() {
        var t = this,
        e = t.$createElement;
        return (t._self._c || e)("div", {
            on: {
                touchstart: function(e) {
                    return e.stopPropagation(),
                    t.handleTouchStar(e)
                },
                touchend: function(e) {
                    return e.stopPropagation(),
                    t.handleTouchEnd(e)
                },
                touchmove: function(e) {
                    return e.stopPropagation(),
                    t.handleTouchMove(e)
                }
            }
        },
        [t._t("default")], 2)
    }), [], !1, null, null, null);
        e.a = o.exports
    },
    JTJg: function(t, e, n) {
        "use strict";
        var i = n("I+eb"),
        a = n("WjRb"),
        s = n("HYAF");
        i({
            target: "String",
            proto: !0,
            forced: !n("qxPZ")("includes")
        },
        {
            includes: function(t) {
                return !! ~String(s(this)).indexOf(a(t), arguments.length > 1 ? arguments[1] : void 0)
            }
        })
    },
    NYZP: function(t, e, n) {
        "use strict";
        n.r(e);
        n("b2oc");
        var i, a, s, o, r = n("Kw5r"),
        c = n("7j/v"),
        l = (n("pNMO"), n("4Brf"), n("5+UC"), n("05lO")),
        u = (n("w6Z4"), n("rQYt")),
        d = n("yENu"),
        _ = n("V9nS"),
        p = (n("zKZe"), n("BjrV")),
        h = function(t) {
            return Object(p.a)(Object.assign({
                headers: {
                    "Cache-Control": "no-cache"
                }
            },
            t, {
                url: t.url + "?time=" + Date.now()
            }))
        },
        f = function(t) {
            return h({
                url: "/wscump/lottery/check-status.json",
                needErrorCode: !0,
                data: t
            })
        },
        m = function(t) {
            return h({
                url: "/wscump/lottery/join-lottery.json",
                needErrorCode: !0,
                data: t
            })
        },
        g = function(t) {
            return h({
                url: "/wscump/lottery/share-activity.json",
                data: t
            })
        },
        w = function(t) {
            return h({
                url: "/wscump/lottery/get-user-points.json",
                data: t
            })
        },
        v = function() {
            return h({
                url: "/wscuser/membercenter/pointsName.json",
                data: {}
            })
        },
        b = (n("2B1R"), n("ToJy"), n("rB9j"), n("UxlC"), n("asw2")),
        y = n.n(b),
        k = window._global.url.h5 + "/",
        C = {
            0 : 0,
            1 : 1,
            2 : 2,
            3 : 3,
            4 : 11,
            5 : 12,
            6 : 13,
            7 : 4,
            8 : 10,
            9 : 15,
            10 : 14,
            11 : 5,
            12 : 9,
            13 : 8,
            14 : 7,
            15 : 6
        },
        j = 1,
        x = 2,
        E = 3,
        I = 4,
        O = 5,
        P = 6,
        S = 7,
        D = 8,
        L = {
            0 : {
                text: "立即抽奖",
                disabled: !0
            },
            1 : {
                text: "活动未开始",
                disabled: !0
            },
            2 : {
                text: "立即抽奖",
                disabled: !1
            },
            3 : {
                text: "活动已结束",
                disabled: !0
            },
            4 : {
                text: "抽奖中",
                disabled: !0
            },
            5 : {
                text: "明天再来",
                disabled: !0
            },
            6 : {
                text: "已抽奖",
                disabled: !0
            },
            7 : {
                text: "分享获得1次抽奖机会",
                disabled: !1
            },
            8 : {
                text: "评价获得1次抽奖机会",
                disabled: !1
            }
        },
        U = [x, I],
        T = 150,
        M = 50,
        W = 2,
        R = 3,
        A = {
            id: 0
        },
        N = "https://img.yzcdn.cn/wsc/ump/lottery/lucky-new-bg.png",
        z = "https://img.yzcdn.cn/wsc/ump/lottery/unlucky-new-bg.png",
        B = {
            0 : "https://img.yzcdn.cn/wsc/ump/lottery/attendance.png",
            1 : "https://img.yzcdn.cn/wscump/lottery/record/coupon.png",
            2 : "https://img.yzcdn.cn/wscump/lottery/record/coupon.png",
            3 : "https://img.yzcdn.cn/wscump/lottery/record/prize.png",
            4 : "https://img.yzcdn.cn/wscump/lottery/record/point.png"
        },
        q = {
            0 : "谢谢参与",
            1 : "优惠券",
            2 : "优惠码",
            3 : "赠品",
            4 : "积分"
        },
        K = "https://img.yzcdn.cn/public_files/2019/11/06/6ced8d17e8acc56d09464a17b85105c8.png",
        H = function(t, e, n, i) {
            return Object.assign({
                awardName: t,
                awardWords: e,
                imageUrl: n || B[0],
                jumpUrl: i || {}
            },
            A)
        },
        J = function(t) {
            return window.YzPageLogger && window.YzPageLogger.log(t)
        },
        F = function(t, e) {
            return Math.floor(Math.random() * t + e)
        },
        Q = function(t) {
            return t.map((function(t) {
                var e = t.awardType,
                n = void 0 === e ? 0 : e,
                i = t.imageUrl,
                a = void 0 === i ? "": i,
                s = t.awardName,
                o = void 0 === s ? "": s;
                return t.imageUrl = a || B[n],
                t.imageUrl = y()(t.imageUrl, "!120x120.jpg"),
                t.imageUrl.replace("http:", "https:"),
                t.awardName = o || q[n],
                t
            }))
        },
        Y = function(t, e, n, i, a) {
            t.sort((function(t, e) {
                return t.awardSort - e.awardSort
            }));
            for (var s = H(e, n, i, a), o = [], r = t.length, c = 0; c < 16; c++) {
                var l = {};
                if (c < 12 && c % 2 == 1) l = Object.assign({},
                s, {
                    show: !0
                });
                else if (c < 12 && c % 2 == 0) {
                    var u = c / 2 % r;
                    l = Object.assign({},
                    t[u], {
                        show: !0
                    })
                } else l = {
                    show: !1
                };
                o.push(l)
            }
            return {
                animationList: o,
                unWinningAward: s
            }
        },
        $ = function(t) {
            return t.map((function(t, e, n) {
                var i = C[e];
                return Object.assign({
                    index: i
                },
                n[i])
            }))
        },
        Z = {
            name: "winner-list",
            props: {
                winners: {
                    type: Array,
                    default:
                        function() {
                            return []
                        }
                }
            },
            data: function() {
                return {
                    listStyle: {}
                }
            },
            watch: {
                winners: {
                    immediate: !0,
                    deep: !0,
                    handler: function(t) {
                        t.length > 3 && this.showWinnerListAnimation()
                    }
                }
            },
            methods: {
                showWinnerListAnimation: function() {
                    var t = this,
                    e = 0;
                    setInterval((function() {
                        t.listStyle = "transform: translateY(" + -20 * e + "px)",
                        e < t.winners.length - 2 ? e += 1 : e = 0
                    }), 2e3)
                }
            }
        },
        V = (n("yPf3"), n("KHd+")),
        G = Object(V.
    default)(Z, (function() {
        var t = this,
        e = t.$createElement,
        n = t._self._c || e;
        return n("div", {
            staticClass: "winner-container"
        },
        [n("h1", {
            staticClass: "winner-title"
        },
        [t._v("\n    中奖名单\n  ")]), n("div", {
            staticClass: "winner-list-wrap"
        },
        [t.winners.length ? n("ul", {
            staticClass: "winner-list",
            style: t.listStyle
        },
        t._l(t.winners, (function(e, i) {
            return n("li", {
                key: i,
                staticClass: "winner-list__record"
            },
            [n("span", {
                staticClass: "record-user"
            },
            [t._v(t._s(e.userName))]), n("span", {
                staticClass: "record-award"
            },
            [t._v(t._s(e.awardName))])])
        })), 0) : n("div", {
            staticClass: "empty-text"
        },
        [t._v("\n      暂无中奖\n    ")])])])
    }), [], !1, null, null, null).exports,
        X = (n("qePV"), n("ilju"), n("5B+z")),
        tt = n("3xkE"),
        et = n.n(tt),
        nt = {
            name: "activity-detail",
            components: (i = {},
            i[X.
        default.name] = X.
        default, i[u.
        default.name] = u.
        default, i),
        props: {
            startDate: {
                    type: Number,
                default:
                0
            },
            endDate: {
                type: Number,
            default:
                0
            },
            description: {
                type: String,
            default:
                ""
            },
            shopName: {
                type: String,
            default:
                ""
            }
        },
        data: function() {
            return {
                showDetail: !1
            }
        },
        computed: {
            formatStart: function() {
                return et()(this.startDate, "YYYY-MM-DD HH:mm:ss")
            },
            formatEnd: function() {
                return et()(this.endDate, "YYYY-MM-DD HH:mm:ss")
            }
        },
        methods: {
            hideDetail: function() {
                this.showDetail = !1
            },
            openDetail: function() {
                this.showDetail = !0
            }
        }
    },
    it = (n("Hy6h"), Object(V.
default)(nt, (function() {
    var t = this,
    e = t.$createElement,
    n = t._self._c || e;
    return n("van-popup", {
        staticClass: "rule-detail__popup",
        model: {
            value: t.showDetail,
            callback: function(e) {
                t.showDetail = e
            },
            expression: "showDetail"
        }
    },
    [n("div", {
        staticClass: "rule-detail__container"
    },
    [n("div", {
        staticClass: "rule-detail__title"
    },
    [t._v("\n      活动详情\n    ")]), n("div", {
        staticClass: "rule-detail__main"
    },
    [n("section", {
        staticClass: "rule-main__sect"
    },
    [n("p", [t._v("活动时间：")]), n("p", [t._v(t._s(t.formatStart) + " 至 " + t._s(t.formatEnd))])]), n("section", {
        staticClass: "rule-main__sect"
    },
    [n("p", [t._v("活动说明：")]), n("p", [t._v(t._s(t.description))])]), n("section", {
        staticClass: "rule-main__sect"
    },
    [n("p", [t._v("发行方：")]), n("p", [t._v(t._s(t.shopName))])])])]), n("van-icon", {
        staticClass: "close-btn",
        attrs: {
            name: "close"
        },
        on: {
            click: t.hideDetail
        }
    })], 1)
}), [], !1, null, "77523bf8", null).exports),
    at = (n("QWBl"), n("yq1k"), n("JTJg"), n("hByQ"), n("FZtP"), n("4X9F"), n("IkEG")),
    st = n("ER7R"),
    ot = n("xQBG"),
    rt = n("zpWP"),
    ct = n("cr+I"),
    lt = n.n(ct),
    ut = n("f4ya"),
    dt = n.n(ut),
    _t = n("3lEi"),
    pt = n("/1Na"),
    ht = {
        name: "lottery-result",
        components: (a = {},
        a[X.
    default.name] = X.
        default, a[u.
        default.name] = u.
        default, a),
props: {
    award: Object,
    isWinning: {
        type: Boolean,
    default:
        !1
    }
},
data: function() {
    return {
        showResult: !1
    }
},
computed: {
        bgSrc: function() {
            return this.isWinning ? "url(" + N + ")": "url(" + z + ")"
        },
        title: function() {
            var t = this.award.awardName || "谢谢参与",
            e = this.isWinning ? "恭喜中奖": t;
            return e
        },
        subTitle: function() {
            var t = this.award.awardName || "",
            e = this.award.awardWords || "";
            return this.isWinning ? t: e
        },
        postScript: function() {
            var t = this.award.jumpUrl && this.award.jumpUrl.link_url,
            e = this.isWinning ? "": t && !_t.a ? "我们为你准备了热销商品": "";
            return e
        },
        imageUrl: function() {
            var t = this.award,
            e = t.awardType,
            n = t.imageUrl;
            return n || B[e]
        },
        showJump: function() {
            var t = (this.award || {}).jumpUrl,
            e = (t = void 0 === t ? {}: t).link_url;
            return ! _t.a && e
        }
},
watch: {
        showResult: function(t) {
            t || this.$emit("close")
        }
},
methods: {
        openResult: function() {
            this.showResult = !0
        },
        closeResult: function() {
            this.showResult = !1
        },
        share: function() {
            J({
                et: "click",
                ei: "verb_windows_share",
                en: "中奖后点击分享"
            }),
            Object(st.a)("share")
        },
        navigate: function() {
            J({
                et: "click",
                ei: "verb_windows_use",
                en: "中奖后点击使用"
            });
            var t = this.award.awardType,
            e = pt.a[{
                1 : "coupon",
                2 : "code",
                3 : "present",
                4 : "points"
            } [t]],
            n = e.url,
            i = e.weappUrl,
            a = e.type,
            s = void 0 === a ? "": a;
            c.
        default.navigate({
            url:
            n,
            weappUrl: i,
            type: s
        })
        },
        wander: function() {
            J({
                et: "click",
                ei: "verb_windows_look",
                en: "未中奖点击去看看"
            });
            var t = this.award.jumpUrl.link_url,
            e = void 0 === t ? "": t,
            n = pt.a.homepage,
            i = n.type,
            a = void 0 === i ? "": i,
            s = n.url,
            o = n.weappUrl;
            c.
        default.navigate({
            url:
            e || s,
            weappUrl: o,
            type: a
        })
        }
}
},
ft = (n("TlMx"), Object(V.
default)(ht, (function() {
    var t = this,
    e = t.$createElement,
    n = t._self._c || e;
    return n("van-popup", {
        staticClass: "c-result__popup",
        style: {
            background: t.bgSrc
        },
        attrs: {
            "overlay-style": {
                zIndex: 1999
            }
        },
        model: {
            value: t.showResult,
            callback: function(e) {
                t.showResult = e
            },
            expression: "showResult"
        }
    },
    [n("div", {
        staticClass: "c-result__container"
    },
    [n("div", {
        staticClass: "c-result__title"
    },
    [t._v("\n      " + t._s(t.title) + "\n    ")]), n("div", {
        staticClass: "l-result__prize"
    },
    [n("img", {
        staticClass: "c-prize__icon",
        attrs: {
            src: t.imageUrl
        }
    }), n("p", {
        staticClass: "c-prize__name"
    },
    [t._v("\n        " + t._s(t.subTitle) + "\n      ")]), n("p", {
        staticClass: "c-prize__expire"
    },
    [t._v("\n        " + t._s(t.postScript) + "\n      ")])]), t.isWinning ? n("div", {
        staticClass: "l-btn__groups"
    },
    [n("button", {
        staticClass: "c-general__btn c-share__btn",
        on: {
            click: t.share
        }
    },
    [t._v("\n        立即分享\n      ")]), n("button", {
        staticClass: "c-general__btn c-use__btn",
        on: {
            click: t.navigate
        }
    },
    [t._v("\n        立即使用\n      ")])]) : t.showJump ? n("div", {
        staticClass: "l-btn__groups"
    },
    [n("button", {
        staticClass: "c-general__btn c-share__btn",
        on: {
            click: t.closeResult
        }
    },
    [t._v("\n        知道了\n      ")]), n("button", {
        staticClass: "c-general__btn c-use__btn",
        on: {
            click: t.wander
        }
    },
    [t._v("\n        去看看\n      ")])]) : n("button", {
        staticClass: "c-general__btn c-nav__btn",
        on: {
            click: t.closeResult
        }
    },
    [t._v("\n      知道了\n    ")]), n("van-icon", {
        staticClass: "close-btn",
        attrs: {
            name: "close"
        },
        on: {
            click: t.closeResult
        }
    })], 1)])
}), [], !1, null, "c4d99e56", null).exports),
mt = window._global,
gt = void 0 === mt ? {}: mt,
wt = gt.miniprogram.isWeapp,
vt = !!+dt.a.get("notShare"),
bt = null,
yt = {
    name: "roulette",
    components: (s = {},
    s[ft.name] = ft, s),
    props: {
        animationList: {
            type: Array,
            default:
                function() {
                    return []
                }
        },
        costPoints: {
            type: Number,
            default:
                0
        },
        activityStatus: {
            type: Number,
            default:
                0
        },
        alias: {
            type: String,
            default:
                ""
        },
        unWinningAward: {
            type: Object,
            default:
                function() {}
        },
        pointsName: {
            type: String,
            default:
                "积分"
        }
    },
    data: function() {
        return {
            scrolling: !1,
            timer: null,
            curIndex: -1,
            canJoinTomorrow: !1,
            joinTimes: 0,
            shareTimes: 0,
            commentTimeSurplus: 0,
            btnCode: 0,
            isWinning: !1,
            winningAward: [],
            joinAward: [],
            showResult: !1
        }
    },
    computed: {
        reorderAwardList: function() {
            var t = this.animationList,
            e = $(t);
            return Q(e)
        },
        creditDesc: function() {
            var t = this.costPoints,
            e = this.btnCode;
            return 0 !== t && U.includes(e) ? "-" + t + this.pointsName: ""
        },
        chanceDesc: function() {
            if (this.btnCode === E || this.btnCode === j) return "";
            var t = this.joinTimes;
            return t > 0 ? "剩余" + t + "次机会": "次数用完了"
        },
        btnStatus: function() {
            var t = this.btnCode;
            return L[t]
        },
        isSurplus: function() {
            var t = this.btnCode;
            return t === S || t === D
        },
        resultAward: function() {
            var t = this.isWinning,
            e = this.winningAward,
            n = this.unWinningAward;
            return t ? e[0] : n
        }
    },
    watch: {
        activityStatus: function(t) {
            this.activityStatus = t,
            this.resetBtnStatus()
        }
    },
    created: function() {
        this.setShareData(),
        d.a.init(this)
    },
    mounted: function() {
        this.init(),
        this.getStatus(),
        this.pageQuery = lt.a.parse(location.search)
    },
    methods: {
        init: function() {
            this.unReactiveData = {
                interval: T,
                circleNum: 0,
                currentCircle: 0,
                lastPosition: 0
            }
        },
        onTapBtn: function() {
            var t = this;
            if (!this.scrolling) {
                try {
                    J({
                        et: "click",
                        ei: "verb_index_verb",
                        en: "点击抽奖按钮"
                    })
                } catch(t) {
                    console.log(t)
                }
                d.a.open({
                    scene: "join_lottery",
                    platformCallback: {
                        method: "startGame"
                    },
                    needLogin: !0
                }).then((function() {
                    t.handleAfterLogin(),
                    t.startGame()
                }))
            }
        },
        handleAfterLogin: function() {
            this.getStatus(),
            this.$emit("login-ok")
        },
        getStatus: function() {
            var t = this,
            e = this.alias;
            f({
                alias: e
            }).then((function(e) {
                t.canJoinTomorrow = e.canJoinTomorrow || !1,
                t.joinTimes = e.joinTimeSurplus || 0,
                t.commentTimeSurplus = e.commentTimeSurplus || 0,
                t.resetBtnStatus()
            })).
            catch((function(e) {
                1605406003 === e.code ? t.btnCode = j: 1605406002 === e.code ? t.btnCode = E: Object(l.
            default)(e.msg || "获取按钮状态失败")
            }))
        },
        resetLotteryInfo: function() {
            this.winningAward = [],
            this.joinAward = [],
            this.isWinning = !1,
            this.curIndex = -1,
            this.unReactiveData.currentCircle = 0,
            this.unReactiveData.interval = T
        },
        startGame: function() {
            var t = this.btnCode;
            if (t === x) this.btnCode = I,
            this.resetLotteryInfo(),
            this.joinLottery(t);
            else if (t === S) Object(st.a)("share");
            else if (t === D) {
                var e = pt.a.comment || {},
                n = e.url,
                i = e.weappUrl;
                c.
            default.navigate({
                url:
                n,
                weappUrl: i
            })
            }
        },
        joinLottery: function(t) {
            var e = this,
            n = this.alias;
            m({
                alias: n
            }).then((function(t) {
                if (t.isWinning) {
                    var n = t.awardList[0].awardName;
                    e.setShareData(!0, n)
                }
                e.$emit("joined"),
                e.winningAward = t.awardList,
                e.joinAward = t.joinAwardList,
                e.isWinning = t.isWinning;
                var i = e.calcPosition();
                e.unReactiveData.lastPosition = i,
                e.startScroll()
            })).
            catch((function(n) {
                switch (n.code) {
                    case 1605406005:
                    case 1605406006:
                        Object(l.
                    default)("暂无抽奖机会，无法抽奖"),
                        e.btnCode = t;
                        break;
                    case 1605406012:
                        Object(l.
                    default)(e.pointsName + "不足，无法抽奖"),
                        e.btnCode = t;
                        break;
                    case 1605406007:
                        e.handleFocus(),
                        e.btnCode = t;
                        break;
                    case 1605406008:
                    case 1605406009:
                    case 1605406010:
                    case 1605406011:
                        e.btnCode = t,
                        e.handleLevel();
                        break;
                    default:
                        e.btnCode = t,
                        Object(l.
                    default)(n.msg || "抽奖失败")
                }
            }))
        },
        handleFocus: function() {
            Object(ot.a)({
                title: "需要关注公众号才可参与抽奖",
                extraData: {
                    bizCode: 2,
                    bizSubCode: 0,
                    activityKey: this.alias,
                    feature: this.pageQuery
                }
            })
        },
        handleLevel: function() {
            var t = this;
            at.
        default.confirm({
            message:
            "抱歉，当前不符合抽奖条件，请先查看活动规则",
            confirmButtonText: "立即查看",
            cancelButtonText: "知道了"
        }).then((function() {
            t.$emit("show-detail")
        })).
            catch((function() {
                console.log("关闭")
            }))
        },
        calcPosition: function() {
            var t = this.isWinning,
            e = this.winningAward,
            n = this.animationList,
            i = this.unWinningAward,
            a = t ? e[0] : i,
            s = [];
            n.forEach((function(t, e) {
                t.id === a.id && s.push(e)
            }));
            var o = F(s.length, 0);
            return s[o]
        },
        handleShareSuccess: function() {
            var t = this;
            J({
                et: "click",
                ei: "vera_index_share",
                en: "点击分享按钮"
            });
            var e = this.alias;
            this.btnCode === S && g({
                alias: e
            }).then((function(e) {
                e ? (Object(l.
            default)("分享成功"), t.getStatus()) : (Object(l.
            default)("分享无效"), t.getStatus())
            })).
            catch((function(e) {
                Object(l.
            default)(e || "分享无效"),
                t.getStatus()
            }))
        },
        startScroll: function() {
            var t = this;
            this.scrolling = !0;
            var e = this.unReactiveData.interval,
            n = F(W, R);
            this.unReactiveData.circleNum = n,
            setTimeout((function() {
                t.doAnimation()
            }), e)
        },
        doAnimation: function() {
            var t = this.curIndex,
            e = this.unReactiveData,
            n = e.circleNum,
            i = e.lastPosition,
            a = e.currentCircle;
            if (t === i && a === n) this.stopScroll();
            else {
                var s = (t + 1) % 12;
                this.curIndex = s,
                this.unReactiveData.currentCircle = 0 === s && -1 !== t ? a + 1 : a;
                var o = this.calcInterval(a, n, t, i),
                r = setTimeout(this.doAnimation, o);
                this.timer = r._id
            }
        },
        stopScroll: function() {
            var t = this;
            clearTimeout(this.timer),
            this.showLotteryResult(),
            setTimeout((function() {
                t.scrolling = !1,
                t.getStatus()
            }), 100)
        },
        resetBtnStatus: function() {
            var t = 0,
            e = this.activityStatus,
            n = this.canJoinTomorrow,
            i = this.joinTimes,
            a = this.shareTimes,
            s = this.commentTimeSurplus;
            t = e !== x ? e: i > 0 ? x: a > 0 ? S: s > 0 ? D: n ? O: P,
            this.btnCode = t
        },
        calcInterval: function(t, e, n, i) {
            var a = this.unReactiveData.interval,
            s = 12 * t + n;
            return a = s > 6 && s + 6 < 12 * e + i ? M: T,
            this.unReactiveData.interval = a,
            a
        },
        showLotteryResult: function() {
            var t = this.joinAward;
            t[0] && Object(l.
        default)("获得游戏奖励" + t[0].pointsValue + this.pointsName),
            this.$refs.result.openResult(),
            this.isWinning && this.$emit("get-award", this.winningAward[0])
        },
        hideLotteryResult: function() {
            this.showResult = !1
        },
        setShareData: function(t, e) {
            var n = this;
            if (void 0 === t && (t = !1), void 0 === e && (e = ""), vt) c.
        default.getWx().then((function() {
            c.
            default.disableShare().
                catch((function() {}))
        }));
        else {
                var i = "这里有一堆奖品,快来抽奖吧";
            t && (i = "我抽到了一个" + e + ",一起来抽奖呀");
            var a = k + "wscump/lottery/scene?alias=" + this.alias + "&kdtId=" + gt.kdtId,
            s = Object(rt.b)("native_wechat"),
            o = {
                title: "我正在抽奖,快来一起赢大奖",
                desc: i,
                link: dt.a.add(a, s),
                imgUrl: "https://img.yzcdn.cn/public_files/2019/11/06/4e8635e3c0ec1dedef67a6341c0d2318.png"
            };
            bt ? this.setShareCallback(o) : c.
            default.getWx().then((function(t) {
                bt = t,
                n.setShareCallback(o)
            })).
                catch((function() {}))
        }
    },
    setShareCallback: function(t) {
        var e = this;
        if (void 0 === t && (t = {}), wt) return c.
    default.configShare(t);
        bt.onMenuShareAppMessage(Object.assign({},
        t, {
            success: function() {
                setTimeout((function() {
                    e.handleShareSuccess()
                }), 500)
            }
        })),
        bt.onMenuShareTimeline(Object.assign({},
        t, {
            success: function() {
                setTimeout((function() {
                    e.handleShareSuccess()
                }), 500)
            }
        }))
    },
    closeResult: function() {
        this.setShareData()
    }
}
},
kt = (n("uyXN"), Object(V.
default)(yt, (function() {
    var t = this,
    e = t.$createElement,
    n = t._self._c || e;
    return n("div", {
        staticClass: "roulette-container"
    },
    [t._l(t.reorderAwardList, (function(e, i) {
        return n("div", {
            key: i,
            staticClass: "c-award__container",
            class: {
                "c-award__container--hidden": !e.show,
                "c-award__container--active": e.index === t.curIndex
            }
        },
        [e.imageUrl ? n("img", {
            staticClass: "c-award__icon",
            attrs: {
                src: e.imageUrl
            }
        }) : t._e(), n("p", {
            staticClass: "l-general__desc c-award__desc"
        },
        [t._v("\n      " + t._s(e.awardName) + "\n    ")])])
    })), n("button", {
        staticClass: "l-lottery__btn",
        class: {
            "l-lottery__btn--disable": t.btnStatus.disabled,
            "l-lottery__btn--share": t.isSurplus
        },
        attrs: {
            disabled: t.btnStatus.disabled
        },
        on: {
            click: t.onTapBtn
        }
    },
    [n("div", {
        staticClass: "c-btn__action",
        class: {
            "c-btn__action--share": t.isSurplus
        }
    },
    [t._v("\n      " + t._s(t.btnStatus.text) + "\n    ")]), n("div", {
        staticClass: "c-btn__credit"
    },
    [t._v("\n      " + t._s(t.creditDesc) + "\n    ")]), n("div", {
        staticClass: "c-btn__chance"
    },
    [t._v("\n      " + t._s(t.chanceDesc) + "\n    ")])]), n("lottery-result", {
        ref: "result",
        attrs: {
            "is-winning": t.isWinning,
            award: t.resultAward
        },
        on: {
            close: t.closeResult
        }
    })], 2)
}), [], !1, null, null, null).exports),
Ct = window._global,
jt = void 0 === Ct ? {}: Ct,
xt = {
    name: "casino",
    components: (o = {},
    o[u.
default.name] = u.
default, o[G.name] = G, o[it.name] = it, o[kt.name] = kt, o),
    data: function() {
        var t = jt.alias,
        e = jt.kdtId,
        n = jt.mp_data,
        i = void 0 === n ? {}: n,
        a = i.logo,
        s = void 0 === a ? "": a,
        o = i.shop_name;
        return {
            alias: t,
            kdtId: e,
            shopName: void 0 === o ? "": o,
            shopLogo: s,
            winners: [],
            initList: !1,
            logoImageUrl: "",
            title: "",
            credit: 0,
            endDate: 0,
            startDate: 0,
            costPoints: 0,
            description: "",
            showLogo: !1,
            activityStatus: 0,
            showWinnerList: !1,
            animationList: [],
            unWinningAward: {},
            bgImageUrl: K,
            pointsName: "积分",
            dataLoading: !0
        }
    },
    created: function() {
        var t = this,
        e = jt.user.has_login,
        n = jt.activityInfo,
        i = jt.winnerList,
        a = void 0 === i ? [] : i;
        n.title = unescape(n.title),
        e && this.getUserPoints(),
        this.winners = a,
        this.dataLoading = !0,
        l.
    default.loading(),
        v().then((function(e) {
            l.
        default.clear();
            var i = e.pointsName;
            t.pointsName = i,
            q[4] = i,
            t.dataLoading = !1,
            t.processInfo(n)
        })).
        catch((function(e) {
            l.
        default.clear(),
            t.dataLoading = !1,
            Object(l.
        default)(e.msg || "获取积分名字失败"),
            t.processInfo(n)
        }))
    },
    methods: {
        processInfo: function(t) {
            this.endDate = t.endDate,
            this.startDate = t.startDate,
            this.costPoints = t.costPoints,
            this.description = t.view.description,
            this.activityStatus = t.activityStatus,
            this.showLogo = t.view.isShowLogoImage,
            this.showWinnerList = t.view.isShowWinnerList,
            this.bgImageUrl = t.view.bgImageUrl || K,
            this.logoImageUrl = t.logoImageUrl || this.shopLogo;
            var e = Y(t.awardList, t.unWinningName, t.unWinningWords, t.unWinningImageUrl, t.unWinningJumpUrl),
            n = e.animationList,
            i = e.unWinningAward;
            this.animationList = n,
            this.unWinningAward = i
        },
        openDetailPopup: function() {
            J({
                et: "click",
                ei: "verb_index_rule",
                en: "点击活动规则"
            }),
            this.$refs.detail.openDetail()
        },
        getUserPoints: function() {
            var t = this,
            e = this.kdtId;
            w({
                kdt_id: e
            }).then((function(e) {
                t.credit = e.realPoints || 0
            })).
            catch((function(t) {
                Object(l.
            default)(t || "获取用户积分失败")
            }))
        },
        loginOk: function() {
            this.getUserPoints()
        },
        toRecord: function() {
            J({
                et: "click",
                ei: "verb_index_prize",
                en: "点击我的奖品"
            }),
            (jt.user || {}).has_login || d.a.open({
                needLogin: !0
            });
            var t = jt.url.h5 + "/wscump/lottery/record?alias=" + this.alias + "&kdt_id=" + this.kdtId;
            c.
        default.navigate({
            url:
            t
        })
        },
        clickShopName: function() {
            J({
                et: "click",
                ei: "verb_index_shop",
                en: "点击店铺名称"
            }),
            Object(_.d)()
        },
        handleJoined: function() {
            this.getUserPoints()
        },
        handleGetAward: function(t) {
            this.$set(this.winners, this.winners.length, {
                awardName: t.awardName,
                userName: jt.userNickName || "匿名用户"
            })
        }
    }
},
Et = (n("kLN0"), Object(V.
default)(xt, (function() {
    var t = this,
    e = t.$createElement,
    n = t._self._c || e;
    return n("div", {
        staticClass: "l-scene__container"
    },
    [n("img", {
        staticClass: "l-scene__background-image",
        attrs: {
            src: t.bgImageUrl
        }
    }), n("div", {
        staticClass: "l-scene__container-inner"
    },
    [n("div", {
        staticClass: "l-scene__header"
    },
    [n("div", {
        staticClass: "l-header__shop",
        on: {
            click: t.clickShopName
        }
    },
    [t.showLogo ? n("img", {
        staticClass: "c-shop__icon",
        attrs: {
            src: t.shopLogo
        }
    }) : t._e(), n("a", {
        staticClass: "c-shop__name"
    },
    [t._v("\n          " + t._s(t.shopName) + "\n          "), n("van-icon", {
        attrs: {
            name: "arrow"
        }
    })], 1)]), n("p", {
        staticClass: "c-header__detail",
        on: {
            click: t.openDetailPopup
        }
    },
    [t._v("\n        活动详情\n      ")])]), t.dataLoading ? t._e() : n("roulette", {
        ref: "roulette",
        staticClass: "l-scene__roulette",
        attrs: {
            alias: t.alias,
            "cost-points": t.costPoints,
            "animation-list": t.animationList,
            "activity-status": t.activityStatus,
            "un-winning-award": t.unWinningAward,
            "points-name": t.pointsName
        },
        on: {
            joined: t.handleJoined,
            "get-award": t.handleGetAward,
            "login-ok": t.loginOk,
            "show-detail": t.openDetailPopup
        }
    }), n("div", {
        staticClass: "l-scene__user"
    },
    [n("p", {
        staticClass: "c-user__credit"
    },
    [t._v("我的" + t._s(t.pointsName) + "：" + t._s(t.credit))]), n("a", {
        staticClass: "c-user__record",
        on: {
            click: t.toRecord
        }
    },
    [t._v("\n        我的中奖记录\n      ")])]), t.showWinnerList ? n("winner-list", {
        attrs: {
            winners: t.winners
        }
    }) : t._e(), n("activity-detail", {
        ref: "detail",
        attrs: {
            "end-date": t.endDate,
            "start-date": t.startDate,
            "shop-name": t.shopName,
            description: t.description
        }
    })], 1)])
}), [], !1, null, null, null).exports),
It = window._global,
Ot = void 0 === It ? {}: It,
Pt = Ot.isBeautyShop;
c.
    default.init({
        kdtId:
        Ot.kdtId,
        weappWebViewPath: Pt ? "/others/pages/wsc-webview-page/index": "/pages/common/webview-page/index"
    }).
        catch((function() {})),
        new r.
    default({
        el:
        "#casino-ground",
        render: function(t) {
            return t(Et)
        }
    })
},
Qkxo: function(t, e, n) {
    "use strict";
    n.d(e, "b", (function() {
        return a
    })),
    n.d(e, "a", (function() {
        return s
    }));
    var i = n("BjrV"),
    a = function(t) {
        return Object(i.a)({
            url: "/wscump/common/follow-report.json",
            data: t,
            method: "POST"
        })
    },
    s = function(t) {
        return Object(i.a)({
            url: "/wscump/common/qr-code.json",
            data: t
        })
    }
},
RNIs: function(t, e, n) {
    t.exports = n("yvjp")("RNIs")
},
TWQb: function(t, e, n) {
    t.exports = n("yvjp")("TWQb")
},
TlMx: function(t, e, n) {
    "use strict";
    var i = n("Bbwx");
    n.n(i).a
},
ToJy: function(t, e, n) {
    "use strict";
    var i = n("I+eb"),
    a = n("HAuM"),
    s = n("ewvW"),
    o = n("0Dky"),
    r = n("pkCn"),
    c = [],
    l = c.sort,
    u = o((function() {
        c.sort(void 0)
    })),
    d = o((function() {
        c.sort(null)
    })),
    _ = r("sort");
    i({
        target: "Array",
        proto: !0,
        forced: u || !d || !_
    },
    {
        sort: function(t) {
            return void 0 === t ? l.call(s(this)) : l.call(s(this), a(t))
        }
    })
},
    "V/47": function(t, e, n) {},
V9nS: function(t, e, n) {
    "use strict";
    n.d(e, "b", (function() {
        return h
    })),
    n.d(e, "c", (function() {
        return f
    })),
    n.d(e, "a", (function() {
        return m
    })),
    n.d(e, "d", (function() {
        return g
    }));
    var i = n("f4ya"),
    a = n.n(i),
    s = n("JL3r"),
    o = n.n(s),
    r = n("3lEi"),
    c = window._global,
    l = (c = void 0 === c ? {}: c).url,
    u = (l = void 0 === l ? {}: l).h5,
    d = l.trade,
    _ = c.kdtId,
    p = c.kdt_id;
    function h() {
        var t = {
            type: "reLaunch",
            url: a.a.add(u + "/wsctrade/cart", {
                kdt_id: _ || p
            }),
            weappUrl: "/pages/goods/cart/index"
        },
        e = t.type,
        n = t.url,
        i = t.weappUrl;
        Object(r.d)(n, i, e)
    }
    function f(t) {
        var e = t || {},
        n = e.alias,
        i = e.bannerId,
        s = e.algs,
        c = o()("/wscgoods/detail/" + n + "?banner_id=" + i + "&alg=" + s, "h5", _ || p, {
            isMobileSubmain: !0
        }),
        l = {
            alias: n,
            banner_id: i,
            alg: s
        },
        u = a.a.add("/packages/goods/detail/index", l);
        Object(r.c)({
            url: c,
            weappUrl: u,
            qqUrl: u,
            aliappUrl: u
        })
    }
    function m(t) {
        var e = t.buyRes,
        n = t.showWxPayTitle,
        i = e.buyUrl,
        s = void 0 === i ? "": i,
        o = e.url,
        c = void 0 === o ? "": o,
        l = e.key,
        u = void 0 === l ? "": l,
        h = s || d + c,
        f = {
            url: a.a.add(h, {
                showwxpaytitle: n,
                kdt_id: _ || p,
                book_key: u
            }),
            weappUrl: a.a.add("/packages/order/index", {
                bookKey: u
            })
        },
        m = f.url,
        g = f.weappUrl;
        Object(r.d)(m, g)
    }
    function g() {
        var t = {
            kdt_id: _ || p
        },
        e = a.a.add("/pages/home/dashboard/index", t);
        Object(r.c)({
            type: "switchTab",
            url: a.a.add(u + "/v2/showcase/homepage", t),
            weappUrl: e,
            qqUrl: e,
            aliappUrl: e
        })
    }
},
    "VC/J": function(t, e, n) {},
VDYC: function(t, e, n) {
    "use strict";
    var i = n("V/47");
    n.n(i).a
},
WJkJ: function(t, e, n) {
    t.exports = n("yvjp")("WJkJ")
},
WKiH: function(t, e, n) {
    t.exports = n("yvjp")("WKiH")
},
WjRb: function(t, e, n) {
    t.exports = n("yvjp")("WjRb")
},
ap0M: function(t, e) {
    t.exports = component_2b76317b
},
    "cr+I": function(t, e, n) {
        t.exports = n("yvjp")("cr+I")
    },
dNkx: function(t, e, n) {},
fhKU: function(t, e, n) {
    var i = n("2oRo"),
    a = n("WKiH").trim,
    s = n("WJkJ"),
    o = i.parseFloat,
    r = 1 / o(s + "-0") != -1 / 0;
    t.exports = r ?
    function(t) {
        var e = a(String(t)),
        n = o(e);
        return 0 === n && "-" == e.charAt(0) ? -0 : n
    }: o
},
hByQ: function(t, e, n) {
    t.exports = n("yvjp")("hByQ")
},
    "jz/G": function(t, e, n) {},
kLN0: function(t, e, n) {
    "use strict";
    var i = n("jz/G");
    n.n(i).a
},
pNMO: function(t, e, n) {
    t.exports = n("yvjp")("pNMO")
},
pkCn: function(t, e, n) {
    t.exports = n("yvjp")("pkCn")
},
qxPZ: function(t, e, n) {
    t.exports = n("yvjp")("qxPZ")
},
rNhl: function(t, e, n) {
    var i = n("I+eb"),
    a = n("fhKU");
    i({
        global: !0,
        forced: parseFloat != a
    },
    {
        parseFloat: a
    })
},
rkAj: function(t, e, n) {
    t.exports = n("yvjp")("rkAj")
},
uyXN: function(t, e, n) {
    "use strict";
    var i = n("9nYL");
    n.n(i).a
},
vGnb: function(t, e) {
    t.exports = framework_fa3d70ff
},
xCMC: function(t, e, n) {
    "use strict";
    var i = n("0s9g");
    n.n(i).a
},
xQBG: function(t, e, n) {
    "use strict";
    n("zKZe");
    var i, a, s = n("Kw5r"),
    o = (n("rB5s"), n("VD6T")),
    r = n("JL3r"),
    c = n.n(r),
    l = n("IZWc"),
    u = n("50Ur"),
    d = n("Qkxo"),
    _ = window._global,
    p = void 0 === _ ? {}: _,
    h = p.mp_account || {},
    f = h.qrcode_url,
    m = h.nickname,
    g = c()("/v2/weixin/scan/wximg.jpeg?s=" + encodeURIComponent(f), "h5", p.kdt_id),
    w = {
        name: "follow-component",
        components: (i = {},
        i[o.
    default.name] = o.
    default, i[l.a.name] = l.a, i[u.a.name] = u.a, i),
        props: {
            value: {
                type: Boolean,
                default:
                    !1
            },
            title: {
                type: String,
                default:
                    "你需要关注后才能购买"
            },
            isNormalType: {
                type: Boolean,
                default:
                    !1
            },
            extraData: {
                type: Object,
                default:
                    function() {
                        return {}
                    }
            }
        },
        data: function() {
            return {
                nickname: m,
                qrcode: "",
                params: {},
                showNoFollow: !f
            }
        },
        watch: {
            value: function(t) {
                t && this.init()
            }
        },
        methods: {
            init: function() {
                this.hasInited || (this.hasInited = !0, this.getQrcode())
            },
            getQrcode: function() {
                var t = this;
                if (!this.isNormalType) {
                    var e = Object.assign({},
                    this.extraData);
                    return e.feature = JSON.stringify(this.extraData.feature),
                    void Object(d.a)(e).then((function(e) {
                        t.qrcode = e || g
                    })).
                    catch((function() {
                        t.qrcode = g
                    }))
                }
                this.qrcode = g
            },
            onClose: function() {
                var t = this;
                this.$emit("input", !1),
                this.hasReportClose || this.isNormalType || Object(d.b)(Object.assign({},
                this.extraData, {
                    followWay: 1
                })).then((function() {
                    t.hasReportClose = !0
                }))
            },
            handleLongPress: function() {
                var t = this;
                this.isNormalType || this.hasLongPress || Object(d.b)(Object.assign({},
                this.extraData, {
                    followWay: 2
                })).then((function() {
                    t.hasLongPress = !0
                }))
            }
        }
    },
    v = (n("VDYC"), n("KHd+")),
    b = Object(v.
default)(w, (function() {
    var t = this,
    e = t.$createElement,
    n = t._self._c || e;
    return n("div", {
        directives: [{
            name: "show",
            rawName: "v-show",
            value: t.value,
            expression: "value"
        }],
        staticClass: "follow-component",
        on: {
            click: t.onClose
        }
    },
    [t.showNoFollow ? n("no-follow") : n("div", {
        staticClass: "content"
    },
    [n("h3", {
        staticClass: "content-title"
    },
    [t._v("\n      " + t._s(t.title) + "\n    ")]), n("long-press", {
        staticClass: "content-qrcode",
        on: {
            "long-press": t.handleLongPress
        }
    },
    [t.qrcode ? n("img", {
        attrs: {
            src: t.qrcode,
            alt: "公众号二维码"
        }
    }) : n("van-loading", {
        staticClass: "content-loadding",
        attrs: {
            type: "spinner",
            size: "40px"
        }
    })], 1), n("p", {
        staticClass: "content-text"
    },
    [t._v("\n      长按图片识别二维码\n    ")]), n("div", {
        staticClass: "content-copyright"
    },
    [n("p", {
        staticClass: "title"
    },
    [t._v("\n        无法识别？\n      ")]), n("p", {
        staticClass: "step"
    },
    [t._v("\n        1.打开微信，点击‘添加朋友’\n      ")]), n("p", {
        staticClass: "step"
    },
    [t._v("\n        2.点击“公众号”\n      ")]), n("p", {
        staticClass: "step"
    },
    [t._v("3.搜索公众号：" + t._s(t.nickname))]), n("p", {
        staticClass: "step"
    },
    [t._v("\n        4.点击“关注”，完成\n      ")])])], 1)], 1)
}), [], !1, null, "68418ce8", null).exports,
    y = {
        value: !0
    },
    k = function(t) {
        void 0 === t && (t = {}),
        a || (a = function(t) {
            return (a = new(s.
        default.extend(b))(Object.assign({
            el:
            document.createElement("div")
        },
            t))).$on("input", (function(t) {
                a.value = t
            })),
            document.body.appendChild(a.$el),
            a
        } ()),
        Object.assign(a, y, t)
    };
    k.Component = b;
    e.a = k
},
yENu: function(t, e, n) {
    "use strict";
    var i = n("0l8F"),
    a = window._userInfoAuthorize;
    a || (window._userInfoAuthorize = a = new i.a({
        appId: "user-info-authorize",
        version: "0.0.12",
        host: /youzan\.com$/.test(location.host) ? "https://passport.youzan.com": "",
        pagePath: "/passport/authorize-dialog",
        initPath: "/passport/authorize-dialog-callback",
        logPath: "/passport/log.json",
        loadingPic: "https://b.yzcdn.cn/public_files/884bca7afb1648427462e9180ecb1dcc.gif",
        uploadLog: !0
    })),
    e.a = a
},
yPf3: function(t, e, n) {
    "use strict";
    var i = n("dNkx");
    n.n(i).a
},
yq1k: function(t, e, n) {
    "use strict";
    var i = n("I+eb"),
    a = n("TWQb").includes,
    s = n("RNIs");
    i({
        target: "Array",
        proto: !0,
        forced: !n("rkAj")("indexOf", {
            ACCESSORS: !0,
            1 : 0
        })
    },
    {
        includes: function(t) {
            return a(this, t, arguments.length > 1 ? arguments[1] : void 0)
        }
    }),
    s("includes")
},
yvjp: function(t, e) {
    t.exports = library_24025f6d
},
zpWP: function(t, e, n) {
    "use strict";
    n.d(e, "b", (function() {
        return c
    })),
    n.d(e, "a", (function() {
        return l
    })),
    n.d(e, "c", (function() {
        return u
    }));
    n("zKZe"),
    n("07d7"),
    n("5s+n");
    var i = n("BjrV"),
    a = n("f4ya"),
    s = n.n(a),
    o = window.YzPageLogger,
    r = void 0 === o ? {}: o,
    c = function(t) {
        var e = {
            is_share: 1,
            share_cmpt: t
        };
        if (r.getShareParams) Object.assign(e, r.getShareParams());
        else if (r.getGlobal) {
            var n = r.getGlobal();
            if (n) {
                var i = n.context || {},
                a = n.user || {};
                i.dc_ps && (e.dc_ps = i.dc_ps),
                i.from_source && (e.from_source = i.from_source),
                i.from_params && (e.from_params = i.from_params),
                a.uuid && (e.from_uuid = a.uuid)
            }
        }
        return e
    },
    l = function(t) {
        var e = c("copylink");
        return s.a.add(t, e)
    },
    u = function(t) {
        var e = l(t.url),
        n = Object.assign({},
        t, {
            url: e
        });
        return new Promise((function(t, e) {
            Object(i.a)({
                url: "/wscump/common/short-url.json",
                data: n
            }).then((function(e) {
                return t(e)
            })).
            catch((function(t) {
                return e(t)
            }))
        }))
    }
}
},
[[42, 0]]]);