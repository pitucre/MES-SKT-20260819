<%@ Page Language="C#" MasterPageFile="~/Masters/EditHeadMaster.master" AutoEventWireup="true"
    Inherits="SKT.LeanMES.Web.SystemConfiguration.WriteBackLogView" CodeBehind="WriteBackLogView.aspx.cs" %>

<%@ MasterType VirtualPath="~/Masters/EditHeadMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <script src="../Content/js/jquery-3.1.0.min.js"></script>
    <link href="../Content/plugin/highlight/10.7.2/styles/monokai-sublime.css" rel="stylesheet" />
    <script src="../Content/plugin/highlight/10.7.2/highlight.pack.js"></script>
    <script>
        //hljs.initHighlightingOnLoad();
        var writeId = '<%=Request.QueryString["ID"]%>';

        $(function () {
            var xmlBack = $.trim($("#write-back").text());
            var xmlReceive = $.trim($("#write-receive").text());

            try {
                //xmlBack = formateXml(xmlBack);
                xmlBack = JSON.stringify(JSON.parse(xmlBack), null, 2);
            } catch (e) {
                xmlBack = $("#write-back").text();
            }
            try {
                //xmlReceive = formateXml(xmlReceive);
                xmlReceive = JSON.stringify(JSON.parse(xmlReceive), null, 2);
            } catch (e) {
                xmlReceive = $("#write-receive").text();
            }

            $("#xml-back").text(xmlBack);
            $("#xml-receive").text(xmlReceive);

            hljs.initHighlighting();

            var writeResult = $("#ERPResultName").text();
            $("#ERPResultName").css("color", (writeResult == "失败" ? "#ff0000" : "#008000"));
        })

        //新窗口打开
        function openWriteBack(flag) {
            var src = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/SystemConfiguration/WriteBackLogViewXML.aspx?ID=" + writeId + "&flag=" + flag;
            window.open(src);
        }

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
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">回写编码
            </td>
            <td class="Field2">
                <asp:Label ID="WriteBackCode" runat="server"></asp:Label>
            </td>
            <td class="Label2">回写名称
            </td>
            <td class="Field2">
                <asp:Label ID="WriteBackName" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">MES单据号
            </td>
            <td class="Field2">
                <asp:Label ID="MESBillNo" runat="server"></asp:Label>
            </td>
            <td class="Label2">ERP调用结果
            </td>
            <td class="Field2">
                <asp:Label ID="ERPResultName" runat="server" ClientIDMode="Static"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">MES消息
            </td>
            <td class="Field2" colspan="3">
                <asp:Label ID="MESMsg" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">ERP消息
            </td>
            <td class="Field2" colspan="3">
                <asp:Label ID="ERPMsg" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">创建人
            </td>
            <td class="Field2">
                <asp:Label ID="CreateBy" runat="server"></asp:Label>
            </td>
            <td class="Label2">创建时间
            </td>
            <td class="Field2">
                <asp:Label ID="CreateDateTime" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">MES回写数据
                <div>
                    <input type="button" onclick="openWriteBack(0)" value="新窗口打开" />
                </div>
            </td>
            <td class="Field2" colspan="3">
                <div style="width: 100%; max-height: 200px; overflow-y: scroll;">
                    <div id="write-back" style="display: none;">
                        <asp:Literal ID="WriteBackData" runat="server"></asp:Literal>
                    </div>
                    <pre><code class="XML" id="xml-back"></code></pre>
                </div>
            </td>
        </tr>
        <tr>
            <td class="Label2">ERP返回数据
                <div>
                    <input type="button" onclick="openWriteBack(1)" value="新窗口打开" />
                </div>
            </td>
            <td class="Field2" colspan="3">
                <div style="width: 100%; max-height: 200px; overflow-y: scroll;">
                    <div id="write-receive" style="display: none;">
                        <asp:Literal ID="ReceiveData" runat="server"></asp:Literal>
                    </div>
                    <pre><code class="XML" id="xml-receive"></code></pre>
                </div>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <div class="ListTableTitle">
        回写数据<span id="demo1"></span>
    </div>
    <asp:GridView ID="GridView1" runat="server" Width="100%" OnRowDataBound="GridView1_RowDataBound">
        <Columns>
            <asp:TemplateField HeaderText="ID" Visible="true"></asp:TemplateField>
        </Columns>
    </asp:GridView>
</asp:Content>

