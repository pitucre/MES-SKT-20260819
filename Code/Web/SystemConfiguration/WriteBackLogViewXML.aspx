<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WriteBackLogViewXML.aspx.cs" Inherits="SKT.LeanMES.Web.SystemConfiguration.WriteBackLogViewXML" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <script src="../Content/js/jquery-3.1.0.min.js"></script>
    <link href="../Content/plugin/highlight/10.7.2/styles/monokai-sublime.css" rel="stylesheet" />
    <script src="../Content/plugin/highlight/10.7.2/highlight.pack.js"></script>
    <script>
        //hljs.initHighlightingOnLoad();

        $(function () {
            var xmlBack = $.trim($("#xml-data").text());

            try {
                //xmlBack = formateXml(xmlBack);
                xmlBack = JSON.stringify(JSON.parse(xmlBack), null, 2);
            } catch (e) {
                xmlBack = $("#xml-data").text();
            }

            $("#xml-back").text(xmlBack);
            hljs.initHighlighting();
        })

        //格式化xml代码
        function formateXml(xmlStr) {
            text = xmlStr;
            //使用replace去空格
            text = '\n' + text.replace(/(<\w+)(\s.*?>)/g, function ($0, name, props) {
                return name + ' ' + props.replace(/\s+(\w+=)/g, " $1");
            }).replace(/>\s*?</g, ">\n<");
            //处理注释
            text = text.replace(/\n/g, '\r').replace(/<!--(.+?)-->/g, function ($0, text) {
                var ret = '<!--' + escape(text) + '-->';
                return ret;
            }).replace(/\r/g, '\n');
            //调整格式  以压栈方式递归调整缩进
            var rgx = /\n(<(([^\?]).+?)(?:\s|\s*?>|\s*?(\/)>)(?:.*?(?:(?:(\/)>)|(?:<(\/)\2>)))?)/mg;
            var nodeStack = [];
            var output = text.replace(rgx, function ($0, all, name, isBegin, isCloseFull1, isCloseFull2, isFull1, isFull2) {
                var isClosed = (isCloseFull1 == '/') || (isCloseFull2 == '/') || (isFull1 == '/') || (isFull2 == '/');
                var prefix = '';
                if (isBegin == '!') {//!开头
                    prefix = setPrefix(nodeStack.length);
                } else {
                    if (isBegin != '/') {///开头
                        prefix = setPrefix(nodeStack.length);
                        if (!isClosed) {//非关闭标签
                            nodeStack.push(name);
                        }
                    } else {
                        nodeStack.pop();//弹栈
                        prefix = setPrefix(nodeStack.length);
                    }
                }
                var ret = '\n' + prefix + all;
                return ret;
            });
            var prefixSpace = -1;
            var outputText = output.substring(1);
            //还原注释内容
            outputText = outputText.replace(/\n/g, '\r').replace(/(\s*)<!--(.+?)-->/g, function ($0, prefix, text) {
                if (prefix.charAt(0) == '\r')
                    prefix = prefix.substring(1);
                text = unescape(text).replace(/\r/g, '\n');
                var ret = '\n' + prefix + '<!--' + text.replace(/^\s*/mg, prefix) + '-->';
                return ret;
            });
            outputText = outputText.replace(/\s+$/g, '').replace(/\r/g, '\r\n');
            return outputText;
        }

        //计算头函数 用来缩进
        function setPrefix(prefixIndex) {
            var result = '';
            var span = '    ';//缩进长度
            var output = [];
            for (var i = 0; i < prefixIndex; ++i) {
                output.push(span);
            }
            result = output.join('');
            return result;
        }

    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div id="xml-data" style="display: none;">
            <asp:Literal ID="XMLData" runat="server"></asp:Literal>
        </div>
        <pre><code class="XML" id="xml-back"></code></pre>
    </form>
</body>
</html>
