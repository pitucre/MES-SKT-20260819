<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ViewMaster.master" AutoEventWireup="true" CodeBehind="TransferApplyView.aspx.cs" Inherits="SKT.LeanMES.Web.Transfers.TransferApplyView" %>

<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="server">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">
                调拨类型
            </td>
            <td class="Field2">
                <asp:Label ID="txtApplyType" runat="server"></asp:Label>
            </td>
            <td class="Label2" style="width:200px;">
                调拨单号
            </td>
            <td class="Field2">
                <asp:Label ID="txtTransfersNo" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2" style="width:200px;">
                来源单号
            </td>
            <td class="Field2">
                <asp:Label ID="txtMOCode" runat="server"></asp:Label>
            </td>
            <td class="Label2">
                调拨补充说明 
            </td>
            <td class="Field2">
                <asp:Label ID="txtRemark" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                制单人
            </td>
            <td class="Field2">
                <asp:Label ID="txtUser" runat="server"></asp:Label>
            </td>
            <td class="Label2">
                调拨日期
            </td>
            <td class="Field2">
                <asp:Label ID="txtDate" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                调入仓库
            </td>
            <td class="Field2">
                <asp:Label ID="txtInWhName" runat="server"></asp:Label>
            </td>
            <td class="Label2">
                调出仓库
            </td>
            <td class="Field2">
                <asp:Label ID="txtOutWhName" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                调拨部门
            </td>
            <td class="Field2">
               <asp:Label ID="txtDep" runat="server"></asp:Label>
            </td>        
        </tr>
    </table>
    <table id="tblExpand" cellspacing="0" cellpadding="4" style="border-width: 0px; width: 100%;
        border-collapse: collapse; margin-top: 5px;" class="EditeContentTable">
        <tr class="ListTableHeader">
            <th scope="col" style="width: 40px;">
                行号
            </th>
            <th scope="col" style="width: 110px;">
                产品编码
            </th>
            <th scope="col">
                产品名称
            </th>
            <th scope="col">
                调入仓库
            </th>
            <th scope="col">
                调出仓库
            </th>
            <th scope="col" style="width: 80px;">
                调拨数量
            </th>
            <th scope="col" style="width: 240px;">
                备注
            </th>
        </tr>
        <tr id="trNewInfo" class="ListTableOddRow">
            <td colspan="5" style="text-align: center;">
                暂无数据
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        var transfersId = '<%=Request.QueryString["ID"]%>';

        $(function () {
            showMaterialRequestInfo(transfersId);
        });

        function showMaterialRequestInfo(transfersId) {
            var entity = {};
            entity.TransfersId = transfersId; //调拨单ID
            var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("upsGetTransfersById", JSON.stringify(entity));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var en = $.parseJSON(ajax.value);
            if (en != null && en.data.length > 0) {
                $("#<%=this.txtApplyType.ClientID%>").text(en.data[0].TransfersTypeName);
                $("#<%=this.txtMOCode.ClientID%>").text(en.data[0].SourceNo);
                $("#<%=this.txtTransfersNo.ClientID%>").text(en.data[0].TransfersNo);
                $("#<%=this.txtRemark.ClientID%>").text(en.data[0].Remark);
                $("#<%=this.txtUser.ClientID %>").text(en.data[0].CName);
                $("#<%=this.txtDate.ClientID %>").text(en.data[0].CreateDateTime);
                $("#<%=this.txtDep.ClientID %>").text(en.data[0].DepartName);
                $("#<%=this.txtInWhName.ClientID %>").text(en.data[0].InWhName + "(" + en.data[0].InWhouse + ")");
                $("#<%=this.txtOutWhName.ClientID %>").text(en.data[0].OutWhName + "(" + en.data[0].OutWhouse + ")");
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
                entity.InWhouse = "";
                entity.OutWhouse = "";
                entity.InWhName = "";
                entity.OutWhName = "";
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

            //调入仓库
            cell = row.insertCell(3);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = entity.InWhouse ? entity.InWhName + "(" + entity.InWhouse + ")" : "";

            //调出仓库
            cell = row.insertCell(4);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = entity.OutWhouse ? entity.OutWhName + "(" + entity.OutWhouse + ")" : "";

            //领料数量
            cell = row.insertCell(5);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = entity.ApplyQty;

            //备注
            cell = row.insertCell(6);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = entity.Remark;
        }
    </script>
</asp:Content>
