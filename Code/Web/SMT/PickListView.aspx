<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PickListView.aspx.cs" MasterPageFile="~/Masters/ViewMaster.master"
    Inherits="SKT.LeanMES.Web.SMT.PickListView" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ViewContent" runat="Server">
    <table class="EditeContentTable" width="100%">
        <tr>
             <td class="Label2">
                上料清单名
            </td>
            <td class="Field2">
                <asp:Label ID="lblSetupName" runat="server" ClientIDMode="Static"></asp:Label>
            </td>
            <td class="Label2">
                是否全套
            </td>
            <td class="Field2" >
                <asp:CheckBox ID="cbFullSet" runat="server" Checked="true" />
            </td>
        </tr>
        <tr>
            <td class="Label2">
                产品名称
            </td>
            <td class="Field2">
                <asp:Label ID="lblItemName" runat="server" ClientIDMode="Static"></asp:Label>
            </td>   
            <td class="Label2">
                版本
            </td>
            <td class="Field2">
                <asp:Label ID="lblRevison" runat="server" ClientIDMode="Static"></asp:Label>
            </td>           
        </tr>       
        <tr>
            <td class="Label2">
                状态
            </td>
            <td class="Field2">
                <asp:Label ID="lblStatus" runat="server" ClientIDMode="Static"></asp:Label>
            </td>
            <td class="Label2">
            </td>
            <td class="Field2">
            </td>
        </tr>
        <tr>
           
            <td class="Label2">
                备注
            </td>
            <td class="Field2" colspan="3">
                <asp:Label ID="lblRemark" runat="server" ClientIDMode="Static"></asp:Label>
            </td>
        </tr>
    </table>
    <table id="tblRecHistory" cellspacing="0" cellpadding="4" style="border-width: 0px;
        width: 100%; border-collapse: collapse; margin-top: 5px;" class="EditeContentTable">
        <tr class="ListTableHeader">
            <th scope="col" style="width: 8%;">
                序号
            </th>
            <th scope="col" style="width: 20%;">
                产品编码
            </th>
            <th scope="col" style="width: 10%;">
                数量
            </th>
            <th scope="col" style="width: 10%;">
                扣料组编码
            </th>
            <th scope="col" style="width: 20%;">
                扣料组描述
            </th>
            <th scope="col">
                备注
            </th>
        </tr>
        <tr id="trNewInfo" class="ListTableOddRow">
            <td colspan="6" style="text-align: center;">
                暂无数据
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        var pickListId = <%= Request.QueryString["ID"] == null ? -1 : Convert.ToInt32(Request.QueryString["ID"].ToString())%>;

        $(document).ready(function () {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPickList.GetPickListDetailInfo(parseInt(pickListId));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            else {
                var entityAry = ajax.value;
                for (var i = 0; i < entityAry.length; i++) {
                    addDetail(entityAry[i]);
                }
                var j = 0;
                $("#tblRecHistory tr").each(function () {
                    $(this).children("td:eq(0)").html(j.toString());
                    j++;
                });
            }
        });


        var tab = document.getElementById("tblRecHistory");
        var rowNewIdx = null;
        function addDetail(entity) {
            $("#trNewInfo").remove();
            var row, cell;
            rowNewIdx = tab.rows.length;
            row = tab.insertRow(rowNewIdx);
            row.className = "ListTableOddRow";

            cell = row.insertCell(0);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = "";

            cell = row.insertCell(1);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = entity.ItemCode;

            cell = row.insertCell(2);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = entity.Qty;

            cell = row.insertCell(3);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = entity.GroupCode;

            cell = row.insertCell(4);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = entity.GroupDesc;

            cell = row.insertCell(5);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = entity.Remark;
        }
    </script>
</asp:Content>
