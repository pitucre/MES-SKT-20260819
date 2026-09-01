<%@ Page Language="C#" MasterPageFile="~/Masters/ViewMaster.master" AutoEventWireup="true" CodeBehind="SystemParameterConfigView.aspx.cs" Inherits="SKT.LeanMES.Web.SystemConfiguration.SystemParameterConfigView" %>

<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="Server">
    <table id="parm-config" class="ListTable" cellspacing="0" cellpadding="2" style="border-width: 0px; width: 100%; border-collapse: collapse;">
    </table>

    <asp:HiddenField ID="hidTableName" runat="server" />
    <script type="text/javascript">
        var arrColVals = [];//表头
        var arrColNames = [];//字段名

        $(function () {
            //根据表名获取列
            var tableName = $.trim($("#<%=this.hidTableName.ClientID%>").val());
            if (tableName == "") {
                return;
            }
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSystemParameterConfig.GetInfo(tableName, true);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var item = ajax.value;
            getFileds(item, "Alpha");
            getFileds(item, "Numeric");
            var head = "";
            for (var i = 0; i < arrColVals.length; i++) {
                head += "<th>" + arrColVals[i] + "</th>";
            }
            $("#parm-config").html("<thead><tr class=\"ListTableHeader\">" + head + "</tr></thead>");

            //获取内容
            ajax = SKT.LeanMES.Web.AjaxServices.AjaxSystemParameterConfig.GetLookupByCondition(tableName, null);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var list = ajax.value;
            var body = "";
            var css = "";
            for (var i = 0; i < list.length; i++) {
                css = i % 2 == 0 ? "ListTableOddRow" : "ListTableEvenRow";
                body += "<tr class=\"" + css + "\">";
                for (var j = 0; j < arrColNames.length; j++) {
                    var val = eval("list[" + i + "]." + arrColNames[j]);
                    if (val === null) {
                        val = "";
                    }
                    body += "<td>" + val + "</td>";
                }
                body += "</tr>";
            }
            $("#parm-config").append("<tbody>" + body + "</tbody>");
        });

        //动态获取属性值
        function getFileds(item, filedPrefix) {
            for (var i = 1; i <= 40; i++) {
                var val = eval("item." + filedPrefix + i + "Desc");
                if (val != undefined && val != null && val != "") {
                    arrColVals.push(val);
                    arrColNames.push(filedPrefix + i);
                }
            }
        }

        function Edit() {
            var tableName = $.trim($("#<%=this.hidTableName.ClientID%>").val());
            var openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SystemConfiguration/SystemParameterConfigEdit.aspx?name=SystemParameterConfigEdit&TableName=" + tableName + "";
            location.href = openWinUrl;
        }
    </script>
</asp:Content>
