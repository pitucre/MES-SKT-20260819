<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="PrepareMaterialView.aspx.cs" Inherits="SKT.LeanMES.Web.Material.PrepareMaterialView" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
        <table id="FTable" class="EditeContentTable" width="100%">
        <tr>
            <td class="Label3">
               生产订单
            </td>
            <td class="Field3">
               <asp:Label ID="Label1" runat="server" Text=""></asp:Label>          
            </td>
            <td class="Label2">
                物料编码                
            </td>
            <td class="Field2">
               <asp:Label ID="lblItemCode" runat="server" Text=""></asp:Label>               
            </td>
        </tr>
        <tr>
            <td class="Label2">
                备料部门
            </td>
            <td class="Field2">
             <asp:Label ID="lblDeptName" runat="server" Text=""></asp:Label>
            </td>
            <td class="Label2">
                备料仓库
            </td>
            <td class="Field2">
            <asp:Label ID="lblWhName" runat="server" Text=""></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                使用日期
            </td>
            <td class="Field2" >
             <asp:Label ID="lblUserDate" runat="server" Text=""></asp:Label>
            </td>
             <td class="Label2">
                 备注
            </td>
            <td class="Field2" >
             <asp:Label ID="lblRemark" runat="server" Text=""></asp:Label>
            </td>
        </tr>
    </table>
    <table id="tblExpand" cellspacing="0" cellpadding="4" style="border-width: 0px; width: 100%;
        border-collapse: collapse; margin-top: 5px;" class="EditeContentTable">
        <tr class="ListTableHeader">
            <th scope="col" style="width: 10%;">
                序号
            </th>
            <th scope="col" style="width: 15%;">
                生产工单
            </th>
            <th scope="col" style="width: 15%;">
                物料编码
            </th>
            <th scope="col" style="width: 15%;">
                物料名称
            </th>
            <th scope="col" style="width: 15%;">
                工单标准用量
            </th>
            <th scope="col" style="width: 15%;">
                可备料数量
            </th>
            <th scope="col" style="width: 15%;">
                备注
            </th>
        </tr>
        <tr id="trNewInfo" class="ListTableOddRow">
            <td colspan="10" style="text-align: center;">
                暂无数据
            </td>
        </tr>
    </table>
    <asp:HiddenField ID="hdnFormSource" runat="server" Value=""  ClientIDMode="Static" />
      <asp:HiddenField ID="hdnAllocateIdStr" runat="server" Value="" ClientIDMode="Static" />
    <script type="text/javascript">
        var prepareListId = '<%=Request.QueryString["ID"]%>';
        var allocateIdStr = "";
        $(function () {
            //编辑模式显示对应的信息
            if (prepareListId != '-1') {
                showMoallocateDetailInfo(prepareListId);
            }
        });
        //显示子件明细
        var tableList = document.getElementById("tblExpand");
        function showMoallocateDetailInfo(prepareListId) {
            $("#tblExpand tr:not(:first)").each(function () {
                $(this).remove();
            });
            var sourceCode = $("#hdnFormSource").val();
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.ShowMoallocateDetail(prepareListId);
            if (ajax.error != null) {
                return false;
            }
            else {
                var entity = ajax.value;
                if (entity != null && entity.length > 0) {
                    $("#trNewInfo").remove();
                    var row, cel
                    for (var i = 0; i < entity.length; i++) {
                        row = tableList.insertRow(i + 1);
                        row.className = i % 2 == 0 ? "ListTableEvenRow" : "ListTableOddRow";

                        cel = row.insertCell(0);
                        cel.innerHTML = i + 1;
                        cel.align = "center";
                        cel.className = "Field";

                        cel = row.insertCell(1);
                        cel.align = "center";
                        cel.className = "Field";
                        cel.innerHTML = entity[i].MOCode;

                        cel = row.insertCell(2);
                        cel.align = "center";
                        cel.className = "Field";
                        cel.innerHTML = entity[i].ItemCode;

                        cel = row.insertCell(3);
                        cel.align = "center";
                        cel.className = "Field";
                        cel.innerHTML = entity[i].ItemName;

                        cel = row.insertCell(4);
                        cel.align = "center";
                        cel.className = "Field";
                        cel.innerHTML = entity[i].SourceQty.toString();

                        cel = row.insertCell(5);
                        cel.align = "center";
                        cel.className = "Field";
                        cel.innerHTML = entity[i].Qty.toString();

                        cel = row.insertCell(6);
                        cel.align = "center";
                        cel.className = "Field";
                        cel.innerHTML = entity[i].Remark.toString();
                    }
                }
            }
        }       
    </script>
</asp:Content>
