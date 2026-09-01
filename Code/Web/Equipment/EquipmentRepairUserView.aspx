<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/ViewMaster.master" CodeBehind="EquipmentRepairUserView.aspx.cs" Inherits="SKT.LeanMES.Web.Equipment.EquipmentRepairUserView" %>

<asp:Content runat="server" ContentPlaceHolderID="viewcontent">
    <table width="100%" class="EditeContentTable">
        <tr class="edituser">
            <td class="Label2">用户名<em>*</em>
            </td>
            <td class="Field2">
                <asp:Label ID="lblUserName" runat="server" Text="" ClientIDMode="Static"></asp:Label>
            </td>
            <td class="Label2">中文名
            </td>
            <td class="Field2">
                <asp:Label ID="lblCName" runat="server" Text="" ClientIDMode="Static"></asp:Label>
            </td>
        </tr>
        <tr>
          <%--  <td class="Label2">班次
            </td>
            <td class="Field2">
                <asp:Label ID="lblWorkshift" runat="server" Text="" ClientIDMode="Static"></asp:Label>
            </td>--%>
            <td class="Label2">邮箱
            </td>
            <td class="Field2">
                <asp:Label ID="lblEmail" runat="server" Text="" ClientIDMode="Static"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">电话
            </td>
            <td class="Field2" colspan="3">
                <asp:Label ID="lblPhone" runat="server" Text="" ClientIDMode="Static"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">部门
            </td>
            <td class="Field2" colspan="3">
                <asp:Label ID="lblDepartName" runat="server" Text="" ClientIDMode="Static"></asp:Label>
            </td>
        </tr>
    </table>
    <div><span>工序</span></div>
    <table class="ListTable" width="100%" id="station-list">
        <thead>
            <tr class="ListTableHeader">
                <th>工序
                </th>
                <th>工序类型
                </th>
                <th>工序描述
                </th>
                <th>操作
                </th>
            </tr>
        </thead>
        <tbody></tbody>
    </table>
    <%--<div>异常类型</div>
    <table class="ListTable" width="100%" id="anormal-list">
        <thead>
            <tr class="ListTableHeader">
                <th>异常类型分组名称
                </th>
                <th>异常类型名称
                </th>
                <th>异常类型代码
                </th>
            </tr>
        </thead>
        <tbody></tbody>
    </table>--%>

    <script type="text/javascript">
        var equipmentRepairUserId = parseInt('<%=Request.QueryString["ID"]%>');

        $(document).ready(function () {
            if (equipmentRepairUserId > 0) {
                //getAnormalList();
                getStationList();
            }
        });

        // function getAnormalList() {
        //    var entity = {};
        //    entity.EquipmentRepairUserId = parseInt(equipmentRepairUserId);
        //    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEquipment.GetEquipmentRepairUserAnormalTypeList(entity);
        //    if (ajax.error != null) {
        //        alert(ajax.error.Message);
        //        return false;
        //    }
        //    var list = ajax.value;
        //    var hl = "";
        //    for (var i = 0; i < list.length; i++) {
        //        hl += "<tr class=\"ListTableOddRow\" id=\"" + list[i].EquipmentRepairAnormalTypeId + "\">" +
        //            "<td>" + list[i].AnormalGroupName + "</td>" +
        //            "<td>" + list[i].AnormalTypeName + "</td>" +
        //            "<td>" + list[i].AnormalTypeCode + "</td>" +
        //            "</tr>";
        //    }
        //    $("#anormal-list tbody").append(hl);
        //}

        function getStationList() {
            var entity = {};
            entity.EquipmentRepairUserId = parseInt(equipmentRepairUserId);
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEquipment.GetEquipmentRepairUserStationList(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var list = ajax.value;
            var hl = "";
            for (var i = 0; i < list.length; i++) {
                hl += "<tr class=\"ListTableOddRow\" id=\"" + list[i].StationId + "\">" +
                    "<td>" + list[i].Station + "</td>" +
                    "<td>" + list[i].StationType + "</td>" +
                    "<td>" + list[i].StationDesc + "</td>" +
                    "<td><a href=\"#\" class=\"delete-station\">" + mesLang("删除") + "</a></td>" +
                    "</tr>";
            }
            $("#station-list tbody").append(hl);
        }
    </script>
</asp:Content>
