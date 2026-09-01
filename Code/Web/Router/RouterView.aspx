<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RouterView.aspx.cs" MasterPageFile="~/Masters/EditMaster.master"
    Inherits="SKT.LeanMES.Web.Router.RouterView" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div class="wrap_tb">
        <ul class="tb">
            <li class="current">
                <%= Resources.lang.BaseInfo%></li>
            <li>已绑定产品</li>
            <li>已绑定工单</li>
        </ul>
        <div class="tb_c">
            <table class="EditeContentTable" width="100%">
                <tr>
                    <td class="Label1">
                        <%=Resources.lang.RouterName%>
                    </td>
                    <td class="Field1">
                        <asp:Label ID="txtRouterName" runat="server" Text="Label"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="Label1">
                        <%=Resources.lang.Status %>
                    </td>
                    <td class="Field1">
                    <asp:Label ID="lblRouterStatus" runat="server" Text="Label"></asp:Label>                        
                    </td>
                </tr>
                <tr>
                    <td class="Label1">
                        <%=Resources.lang.Description%>
                    </td>
                    <td class="Field1">
                        <asp:Label ID="txtDescription" runat="server" Text="Label"></asp:Label>
                    </td>
                </tr>
            </table>
        </div>
        <div>
            <table class="ListTable" cellspacing="0" cellpadding="4" style="border-width: 0px;
                width: 100%; border-collapse: collapse;" id="tblExpand">
                <tr class="ListTableHeader" id="trItemBindList">
                    <th scope="col" style="width: 40%;">
                        <%=Resources.lang.ItemsName%>
                    </th>
                    <th scope="col" style="width: 30%;">
                        <%=Resources.lang.ItemCode%>
                    </th>
                    <th scope="col" style="width: 40%;">
                        <%=Resources.lang.Revision%>
                    </th>
                </tr>
            </table>
        </div>
        <div>
            <table class="ListTable" cellspacing="0" cellpadding="5" style="border-width: 0px;
                width: 100%; border-collapse: collapse;" id="tbOrderBindList">
                <tr class="ListTableHeader">
                    <th scope="col">
                        工单号
                    </th>
                </tr>
            </table>
        </div>
    </div>
    <script type="text/javascript">
        var fromPage = '<%=Request.QueryString["From"] %>';
        fromPage = (fromPage=="") ? "" : "designer";
        var itemName = "";
        var rid = '<%=Request.QueryString["ID"] %>';
        var tab = document.getElementById("tblExpand");

        $(function () {
            if (parseInt(rid) > -1) {
                initItemBind(rid);
                initOrderBind(rid);
            }
        });

        var rowIndex = -1;
        var rowObj = null;
        function addDetail(entity) {
            if (entity == null || entity.length == 0) {
                $("#tblExpand").append("<tr class='ListTableEmptyDataRow'><td colspan='3'>" + mesLang("暂无数据") +"</td></tr>");
                return false;
            }

            var row, cell;
            rowNewIdx = tab.rows.length;
            row = tab.insertRow(rowNewIdx);
            row.className = "ListTableOddRow";

            cell = row.insertCell(0);
            cell.align = "center";
            cell.innerHTML = "<span>" + entity.ItemName + "</span><span></span>";
            //cell.innerHTML = "<input type=\"text\" name=\"txtItems\" class=\"TextBox\" value=\""+entity.ItemName+"\" disabled=\"disabled\">"
            //+ "<input type=\"button\" id=\"btnSelectItems\" onclick=\"selectItems(this);\" class=\"ButtonBox\" value=\"...\" />"
+"<input type=\"hidden\" name=\"hdnItemId\" value=\"" + entity.ItemId + "\" />";

            /*item code*/
            cell = row.insertCell(1);
            cell.align = "center";
            cell.innerHTML = "<input type=\"hidden\" name=\"hdnItemCode\" value=\"" + entity.ItemCode + "\"  /><span>" + entity.ItemCode + "</span>";

            /*item rev*/
            cell = row.insertCell(2);
            cell.align = "center";
            cell.innerHTML = "<input type=\"hidden\" name=\"hdnVersion\" value=\"" + entity.ItemRev + "\"  /><span>" + entity.ItemRev + "</span>";

        }

        function initItemBind(rids) {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxRouter.GetItemBind(rids);
            if (ajax.error == null) {
                var entityAry = ajax.value;
                if (entityAry.length == 0)
                {
                    $("#tblExpand").append("<tr class='ListTableEmptyDataRow'><td colspan='3'>" + mesLang("暂无数据")+"</td></tr>");
                    return false;
                }

                for (var i = 0; i < entityAry.length; i++) {
                    addDetail(entityAry[i]);
                }
            } else {
                alert(ajax.error.Message);
            }
        }

        function initOrderBind(rids) {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxRouter.GetOrderBind(rids);
            if (ajax.error == null) {
                var entityAry = ajax.value;
                if (entityAry.length == 0) {
                    $("#tbOrderBindList").append("<tr class='ListTableEmptyDataRow'><td>" + mesLang("暂无数据") +"</td></tr>");
                    return false;
                }

                var html = "";
                for (var i = 0; i < entityAry.length; i++) {
                    html += "<tr  class='ListTableOddRow'><td>" + entityAry[i] + "</td></tr>";
                }
                $("#tbOrderBindList").append(html);

            } else {
                alert(ajax.error.Message);
            }


        }

        function Edit() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Router/RouterEdit.aspx?name=Router_RouterEdit&ID=" + '<%= Request.QueryString["ID"] %>' + "&inMenu=true";
            location.href = openWinUrl;
        }
    </script>
</asp:Content>
