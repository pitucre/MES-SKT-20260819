<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ViewMaster.master" AutoEventWireup="true"
    CodeBehind="MaterialApplyView.aspx.cs" Inherits="SKT.LeanMES.Web.Material.MaterialApplyView" %>

<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="server">
    <style>
        .dtlTable 
        {
            position: absolute;
            left: 20%;
            z-index:10;
            width: 60%;
            background-color: #c6ddff;
            text-align: center;
        }
    </style>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">
                类型
            </td>
            <td class="Field2">
                <asp:Label ID="txtApplyType" runat="server"></asp:Label>
            </td>
            <td class="Label2">
                领料单号
            </td>
            <td class="Field2">
                <asp:Label ID="blbApplyNo" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                工单号
            </td>
            <td class="Field2">
                <asp:Label ID="txtMOCode" runat="server"></asp:Label>
            </td>
            <td class="Label2">
                生产部门
            </td>
            <td class="Field2">
                <asp:Label ID="txtDeptName" runat="server"></asp:Label>
            </td>            
        </tr>
        <tr>
            <td class="Label2">
                仓库
            </td>
            <td class="Field2">
                <asp:Label ID="txtWhName" runat="server"></asp:Label>
            </td>
            <td class="Label2">
                使用日期
            </td>
            <td class="Field2">
                <asp:Label ID="txtUserDate" runat="server"></asp:Label>
            </td>            
        </tr>
        <tr>
            <td class="Label2">
                备注
            </td>
            <td class="Field2">
                <asp:Label ID="txtRemark" runat="server"></asp:Label>
            </td>
            <td class="Label2">
                发料类型
            </td>
            <td class="Field2">
                <asp:Label ID="txtApplyClass" runat="server"></asp:Label>
            </td>
        </tr>
    </table>
    <table id="tblExpand" cellspacing="0" cellpadding="4" style="border-width: 0px; width: 100%; position: relative;
                                          border-collapse: collapse; margin-top: 5px;" class="EditeContentTable">
        <tr class="ListTableHeader">
            <th scope="col" style="width: 4%; text-align: center">
                行号
            </th>
            <th scope="col" style="width: 15%; text-align: center">
                产品编码
            </th>
            <th scope="col" style="width: 20%;text-align: center ">
                产品名称
            </th>
            <th scope="col" style="width: 8%; text-align: center">
                领料数量
            </th>
            <th scope="col" style="width: 8%; text-align: center">
                已备数量
            </th>
            <th scope="col" style="width: 13%; text-align: center">
                备注
            </th>
            <th scope="col" style="width: 8%; text-align: center">
                备料明细
            </th>
        </tr>
        <tr id="trNewInfo" class="ListTableOddRow">
            <td colspan="5" style="text-align: center;">
                暂无数据
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        var applyId = '<%=Request.QueryString["ID"]%>';

        $(function () {
            showMaterialRequestInfo(applyId);
        });

        function showMaterialRequestInfo(applyId) {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialApply.GetMaterialApply(applyId);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var en = $.parseJSON(ajax.value);
            var data = $.parseJSON(ajax.value).data;

            if (data != null && data.length > 0) {

                var entity = data[0];
                if (entity["ApplyType"] == "1") {
                    $("#<%=this.txtApplyType.ClientID%>").text("工单领料");
                }
                else {
                    $("#<%=this.txtApplyType.ClientID%>").text("手工增加");
                }
                $("#<%=this.blbApplyNo.ClientID%>").text(entity["ApplyNo"]);
                $("#<%=this.txtMOCode.ClientID%>").text(entity["MOCode"]);
                $("#<%=this.txtDeptName.ClientID %>").text(entity["DepName"] + "(" + entity["DepCode"] + ")");
                $("#<%=this.txtWhName.ClientID %>").text(entity["WhName"] + "(" + entity["WhCode"] + ")");
                $("#<%=this.txtUserDate.ClientID %>").text(entity["UseDateTime"]);
                $("#<%=this.txtRemark.ClientID%>").text(entity["Remark"]);
                if (entity["ApplyClass"] == 0) {
                    $("#<%=this.txtApplyClass.ClientID%>").text("合并子单");
                    $("#<%=this.txtApplyClass.ClientID%>").css("color","red")
                }
                else if (entity["ApplyClass"] == 1) {
                    $("#<%=this.txtApplyClass.ClientID%>").text("合并母单");
                }
                else {
                    $("#<%=this.txtApplyClass.ClientID%>").text("独立发料");
                }
                
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
                entity.ItemID = -1;
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
            cell.innerHTML = parseFloat(entity.ApplyQty);
            //已备数量
            cell = row.insertCell(4);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = parseFloat(entity.ActiQty) !== '' ? parseFloat(entity.ActiQty) : 0;
            //备注
            cell = row.insertCell(5);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = entity.Remark;

            //备料明细
            cell = row.insertCell(6);
            cell.align = "center";
            cell.className = "Field";
            if (entity.ActiQty * 1 === 0 || entity.ActiQty==='') {
                cell.innerHTML = "";
            } else {
                cell.innerHTML = "<span class='showDetail' style=\"CURSOR: pointer; COLOR: #0000ff;\" onclick=\"showDetail(this,'" + entity.ItemId + "')\">显示/隐藏</span>";
            }
        }

        //BirongLiang  2017-2-9
        function showDetail(objDom,itemId) {
            var applyId = window.applyId;
            var thisTr = $(objDom).parent().parent();
            if (thisTr.next().is("table")) {
                thisTr.next().remove();
                return false;
            }
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialApply.GetMaterialPrepareGrn(applyId *1, itemId *1);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var dtlData = JSON.parse(ajax.value).data;
            thisTr.parent().find("table").remove();
            if (dtlData.length === 0) {
                alert('找不到匹配的GRN信息');
                return false;
            }
            var dtlHtml = "<table class='dtlTable'><tr class=''><th>序列号</th><th>数量</th></tr>";
            for (var i = 0; i < dtlData.length; i++) {
                dtlHtml += "<tr class='.ListTableOddRow'>" +
                    "<td class=''>" + dtlData[i].SerialNumber + "</td>" +
                    "<td class=''>" + dtlData[i].BalanceQty + "</td>" +
                    "</tr>";
            }
            dtlHtml += "</table>";
            thisTr.after(dtlHtml);
        }
    </script>
</asp:Content>
