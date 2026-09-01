<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ViewMaster.master" AutoEventWireup="true" CodeBehind="ScrapApplyView.aspx.cs" Inherits="SKT.LeanMES.Web.Scrap.ScrapApplyView" %>

<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="server">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2" style="width: 200px;">报废单号
            </td>
            <td class="Field2">
                <asp:Label ID="txtScrapsNo" runat="server"></asp:Label>
            </td>
            <td class="Label2">报废部门
            </td>
            <td class="Field2">
                <asp:Label ID="txtDepName" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">创建人
            </td>
            <td class="Field2">
                <asp:Label ID="txtUser" runat="server"></asp:Label>
            </td>
            <td class="Label2">报废时间
            </td>
            <td class="Field2">
                <asp:Label ID="txtDate" runat="server"></asp:Label>
            </td>
        </tr>

        <tr id="trDep">
            <td class="Label2">报废仓库
            </td>
            <td class="Field2">
                <asp:Label ID="txtWhName" runat="server"></asp:Label>
            </td>
            <td class="Label2">报废补充说明 
            </td>
            <td class="Field2">
                <asp:Label ID="txtRemark" runat="server"></asp:Label>
            </td>
        </tr>
    </table>
    <table id="tblExpand" cellspacing="0" cellpadding="4" style="border-width: 0px; width: 100%; border-collapse: collapse; margin-top: 5px;"
        class="EditeContentTable">
        <tr class="ListTableHeader">
            <th scope="col" style="width: 40px;">行号
            </th>
            <th scope="col" style="width: 180px;">产品编码
            </th>
            <th scope="col">产品名称
            </th>
            <th scope="col" style="width: 80px;">报废数量
            </th>
            <th scope="col" style="width: 240px;">备注
            </th>
        </tr>
        <tr id="trNewInfo" class="ListTableOddRow">
            <td colspan="5" style="text-align: center;">暂无数据
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        var scrapId = '<%=Request.QueryString["ID"]%>';

        $(function () {
            showMaterialRequestInfo(scrapId);
        });

        function showMaterialRequestInfo(scrapId) {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxScrapApply.GetScrapInfoById(scrapId);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var en = $.parseJSON(ajax.value);
            if (en != null && en.data.length > 0) {
                $("#<%=this.txtScrapsNo.ClientID%>").text(en.data[0].ScrapNo);
                $("#<%=this.txtRemark.ClientID%>").text(en.data[0].Remark);
                $("#<%=this.txtUser.ClientID %>").text(en.data[0].CName);
                $("#<%=this.txtDate.ClientID %>").text(en.data[0].CreateDateTime);
                $("#<%=this.txtDepName.ClientID %>").text(en.data[0].DepartName);
                $("#<%=this.txtWhName.ClientID %>").text(en.data[0].InWhName + "(" + en.data[0].Whouse + ")");
            }
            var List = en.data1;
            var row, cel;
            rowCount = 0;
            for (var i = 0; i < List.length; i++) {
                rowCount++;
                addDetail(List[i], i);
            }
        }

        var tab = document.getElementById("tblExpand");
        var i = 0;
        function addDetail(entity) {
            if (entity == null) {
                entity = {};
                entity.ItemCode = "";
                entity.ItemName = "";
                entity.ApplyQty = "";
                entity.Remark = "";
            }

            i += 1;
            $("#trNewInfo").remove();
            var row, cell;
            rowNewIdx = tab.rows.length;
            row = tab.insertRow(rowNewIdx);
            row.className = "ListTableOddRow";
            //行号
            cell = row.insertCell(0);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = i.toString();

            //产品编码
            cell = row.insertCell(1);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = entity.ItemCode;

            //产品名称
            cell = row.insertCell(2);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = entity.ItemName;

            //领料数量
            cell = row.insertCell(3);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = entity.ApplyQty;

            //备注
            cell = row.insertCell(4);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = entity.Remark;
        }
    </script>
</asp:Content>
