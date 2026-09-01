/************************************
文件描述：保存方法验证页面数据格式
创建时间：2015-04-25
创建人员：Starry Cheng
版本号码：1.0.0.0

IsRequired='1'     --必填控件，不能为空
MaxLength='50'	   --最大长度不能超过50
IsNumber='1'	   --输入值必须是数字型
MinValue='12'	   --输入值不得小于12
MaxValue='20'	   --输入值不得大于20

************************************/
eval(function (p, a, c, k, e, r) { e = function (c) { return (c < a ? '' : e(parseInt(c / a))) + ((c = c % a) > 35 ? String.fromCharCode(c + 29) : c.toString(36)) }; if (!''.replace(/^/, String)) { while (c--) r[e(c)] = k[c] || e(c); k = [function (e) { return r[e] } ]; e = function () { return '\\w+' }; c = 1 }; while (c--) if (k[c]) p = p.replace(new RegExp('\\b' + e(c) + '\\b', 'g'), k[c]); return p } ('3 f=[];8 B(){e(3 i=0;i<f.7;i++){f[i].q("v-x","")}f=[];3 a=$("[A=\'1\']");e(3 i=0;i<a.7;i++){4(!p($(a[i]))){2 5}}a=$("[w]");3 b=l;e(3 i=0;i<a.7;i++){b=$(a[i]);4(!m(b)){2 5}}a=$("[z=\'1\']");3 c=l;e(3 i=0;i<a.7;i++){c=$(a[i]);4(c.6()==""){j}4(!h(c)){2 5}}a=$("[r]");e(3 i=0;i<a.7;i++){c=$(a[i]);4(c.6()==""){j}4(!s(c)){2 5}}a=$("[t]");e(3 i=0;i<a.7;i++){c=$(a[i]);4(c.6()==""){j}4(!u(c)){2 5}}2 d}8 p(a){4($.y(a.6())==""){g("带*不可为空.");9(a);2 5}2 d}8 s(a){4(!h(a)){2}3 b=a.6();3 c=a.k("r");4(n(b)<c){g("当前输入不能小于最小值:"+c+"");9(a);2 5}2 d}8 u(a){4(!h(a)){2}3 b=a.6();3 c=a.k("t");4(n(b)>c){g("当前输入不能大于最大值:"+c+"");9(a);2 5}2 d}8 m(a){3 b=a.6().7;3 c=a.k("w");4(o(b)>o(c)){g("输入字符不能大于:"+c+"");9(a);2 5}2 d}8 9(a){f.C(a);a.q("v-x","D");a.E();a.F()}8 h(a){3 b=a.6();4(G(b)){g("请输入正确的数字类型.");9(a);2 5}2 d}', 43, 43, '||return|var|if|false|val|length|function|ExceptionStyle||||true|for|aryErrorCtrls|alert|isNumbers||continue|attr|null|CheckValLength|parseFloat|parseInt|CheckRequired|css|MinValue|CheckMinValue|MaxValue|CheckMaxValue|background|MaxLength|color|trim|isNumber|IsRequired|SubmitValidation|push|yellow|select|focus|isNaN'.split('|'), 0, {}))