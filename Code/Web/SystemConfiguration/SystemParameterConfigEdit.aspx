<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="SystemParameterConfigEdit.aspx.cs" Inherits="SKT.LeanMES.Web.SystemConfiguration.SystemParameterConfigEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
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

            for (var i = 0; i < list.length; i++) {
                body += "<tr class=\"ListTableOddRow\" tid=\"" + list[i].Id + "\">";
                for (var j = 0; j < arrColNames.length; j++) {
                    var val = eval("list[" + i + "]." + arrColNames[j]);
                    if (val === null) {
                        val = "";
                    }
                    body += "<td><input type=\"text\" value=\"" + val + "\" colName=\"" + arrColNames[j] + "\"></input></td>";
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

        /*保存数据*/
        function Save() {

            var id = [];
            var value = [];

            var sql = "";
            $("#parm-config tbody tr").each(function () {
                var lid = $(this).attr("tid");
                sql = "";
                $(this).find("input[type='text']").each(function () {
                    var val = $.trim($(this).val()).replace("'", "");
                    var filed = $(this).attr("colName");
                    if (sql == "") {
                        sql += " " + filed + " = '" + val + "'";
                    } else {
                        sql += " , " + filed + " = '" + val + "'";
                    }
                });
                id.push(lid);
                value.push(sql);

            });
            var tableName = $.trim($("#<%=this.hidTableName.ClientID%>").val());
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSystemParameterConfig.Edit(tableName, id, value);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            alert('<%=Resources.Messages.SaveInSuccess%>')
            parent.window.Refresh();
        }
    </script>
</asp:Content>
