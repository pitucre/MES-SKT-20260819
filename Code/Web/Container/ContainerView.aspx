<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/ViewMaster.master"
    CodeBehind="ContainerView.aspx.cs" Inherits="SKT.LeanMES.Web.Container.ContainerView" %>

<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="Server">
    <div class="wrap_tb" style="min-width: 780px;">
        <ul class="tb">
            <li class="current">基本信息</li>
            <li>包装内容</li>
            <li>包装箱标签</li>
        </ul>
        <div class="tb_c" style="min-height: 335px; overflow: auto;">
            <table width="100%" class="ContentTable">
                <tr>
                    <td class="Label2">
                        容器名称
                    </td>
                    <td class="Field2">
                        <asp:Label ID="labName" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="Label2">
                        容器类型
                    </td>
                    <td class="Field2">
                        <asp:Label ID="lblDataTypeName" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="Label2">
                        <%= Resources.lang.Status %>
                    </td>
                    <td class="Field2">
                        <asp:Label ID="lblStatus" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="Label1">
                        <%= Resources.lang.MixShopOrders%>
                    </td>
                    <td class="Field1">
                        <asp:Label ID="lblMixShopOrders" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="Label1">
                        产品混合包装
                    </td>
                    <td class="Field1">
                        <asp:Label ID="lblMixItems" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
                 <tr>
                    <td class="Label1">
                        是否顺序包装
                    </td>
                    <td class="Field1">
                        <asp:Label ID="lblSequence" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="Label2">
                        高
                    </td>
                    <td class="Field2">
                        <asp:Label ID="lblHeight" runat="server"></asp:Label>
                        (mm)
                    </td>
                </tr>
                <tr>
                    <td class="Label2">
                        宽
                    </td>
                    <td class="Field2">
                        <asp:Label ID="lblWidth" runat="server"></asp:Label>
                        (mm)
                    </td>
                </tr>
                <tr>
                    <td class="Label2">
                        长
                    </td>
                    <td class="Field2">
                        <asp:Label ID="lblLength" runat="server"></asp:Label>
                        (mm)
                    </td>
                </tr>
                <tr>
                    <td class="Label2">
                        最大重量
                    </td>
                    <td class="Field2">
                        <asp:Label ID="lblMaxFillWeight" runat="server"></asp:Label>
                        (kg)
                    </td>
                </tr>
                <tr>
                    <td class="Label2">
                        容器本身重量
                    </td>
                    <td class="Field2">
                        <asp:Label ID="lblContainerWeight" runat="server"></asp:Label>
                        (kg)
                    </td>
                </tr>
                <tr>
                    <td class="Label1">
                        <%= Resources.lang.Description%>
                    </td>
                    <td class="Field1">
                        <asp:Label ID="lblDescription" runat="server"></asp:Label>
                    </td>
                </tr>
            </table>
        </div>
        <div style="min-height: 335px; overflow: auto;">
            <table class="ListTable" cellspacing="0" cellpadding="4" style="border-width: 0px;
                width: 100%; border-collapse: collapse;" id="tbPackLevel">
                <tr class="ListTableHeader">
                    <th scope="col" align="center">
                        包装类型
                    </th>
                    <th scope="col" align="center">
                        包装内容
                    </th>
                    <th scope="col" align="center">
                        <%= Resources.lang.Revision%>
                    </th>
                    <th scope="col" align="center">
                        <%= Resources.lang.ShopOrder%>
                    </th>
                    <th scope="col" align="center">
                        最小数量
                    </th>
                    <th scope="col" align="center">
                        最大数量
                    </th>
                </tr>
            </table>
        </div>
        <div style="min-height: 335px; overflow: auto;">
            <table class="ListTable" cellspacing="0" cellpadding="4" style="border-width: 0px;
                width: 100%; border-collapse: collapse;" id="Documents">
                <tr class="ListTableHeader">
                    <th scope="col" style="width:50px" align="center">
                        <%=Resources.lang.Sequence%>
                    </th>
                    <th scope="col"  align="center">
                        文档
                    </th>
                </tr>
            </table>
        </div>
    </div>
    <script type="text/javascript">
        var cONTAINERId = '<%= Request.QueryString["ID"] %>';
        var tab = document.getElementById("tbPackLevel");
        var tabDocument = document.getElementById("Documents");
        var condition = ""; //ShopOrderID查询条件

        $(function () {
            if (parseInt(cONTAINERId) > -1) {
                initItemOnHold(cONTAINERId);
            }
            if (tab.rows.length < 2) {
                addPackLevelDetail(null);
            }
            if (tabDocument.rows.length < 2) {
                addContainerDocument(null);
            }
        });

        var option = 0;
        var flag = -1;
        var rowObj = null;
        //增加PackLevel
        function addPackLevelDetail(entity) {
            if (entity == null) {
                $("#tbPackLevel").append("<tr class='ListTableEmptyDataRow'><td colspan='7'>该包装箱还没有设置任何包装内容。</td></tr>");
                return false;
            }
            var row, cell, optionvalue, disabled;
            rowNewIdx = tab.rows.length;
            row = tab.insertRow(rowNewIdx);
            
            if (entity != null) {
                row.className = "ListTableOddRow";
            }
            optionvalue = entity.PackingLevel;

            cell = row.insertCell(0);
            cell.align = "center";
            cell.innerHTML = optionvalue;

            cell = row.insertCell(1);
            cell.align = "center";
            cell.innerHTML = entity.PackingLevelValue;

            cell = row.insertCell(2);
            cell.align = "center";
            cell.innerHTML = entity.Revision;

            cell = row.insertCell(3);
            cell.align = "center";
            cell.innerHTML = entity.ProdOrderName;

            cell = row.insertCell(4);
            cell.align = "center";
            cell.innerHTML = entity.MinQty;

            cell = row.insertCell(5);
            cell.align = "center";
            cell.innerHTML = entity.MaxQty;
        }

        //增加ContainerDocument
        var rowDocument = null;
        function addContainerDocument(entityDocument) {
            if (entityDocument == null) {
                $("#Documents").append("<tr class='ListTableEmptyDataRow'><td colspan='2'>该包装箱还没有设置任何标签。</td></tr>");
                return false;
            }
            var row, cell;
            rowNewIdx = tabDocument.rows.length;
            row = tabDocument.insertRow(rowNewIdx);
            row.className = "ListTableOddRow";

            cell = row.insertCell(0);
            cell.align = "center";
            cell.innerHTML = entityDocument.Seauence;

            cell = row.insertCell(1);
            cell.align = "center";
            cell.innerHTML = entityDocument.DocumentName;

        }

        function initItemOnHold(ContainerId) {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxContainer.GetContainerPackingLevel(ContainerId.toString());
            if (ajax.error == null) {
                var entityAry = ajax.value;
                for (var i = 0; i < entityAry.length; i++) {
                    addPackLevelDetail(entityAry[i]);
                }
            } else {
                alert(ajax.error.Message);
            }

            var ajaxDocument = SKT.LeanMES.Web.AjaxServices.AjaxContainer.GetContainerDocument(ContainerId.toString());
            if (ajaxDocument.error == null) {
                var entityAry = ajaxDocument.value;
                for (var i = 0; i < entityAry.length; i++) {
                    addContainerDocument(entityAry[i]);
                }
            } else {
                alert(ajax.error.Message);
            }
        }

        function toDecimal(x) {
            var f = parseFloat(x);
            if (isNaN(f)) {
                return 0;
            }
            else {
                return f;
            }
        }

        function Edit() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Container/ContainerEdit.aspx?name=ContainerEdit&ID=" + '<%= Request.QueryString["ID"] %>';
            location.href = openWinUrl;
        }
     
    </script>
</asp:Content>
