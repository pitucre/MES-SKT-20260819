<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ViewMaster.master" AutoEventWireup="true" CodeBehind="MaterialIQCView.aspx.cs" Inherits="SKT.LeanMES.Web.Material.MaterialIQCView" %>

<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="server">
    <table id="tblExpand" cellspacing="0" cellpadding="4" style="border-width: 0px; width: 100%;
        border-collapse: collapse; margin-top: 5px;" class="EditeContentTable">
        <tr class="ListTableHeader">
            <th scope="col" align="center" style="width: 12%;">
                采购单
            </th>
            <th scope="col" align="center" style="width: 8%;">
                采购单行号
            </th>
            <th scope="col" align="center" style="width: 12%;">
                GRN条码
            </th>
            <th scope="col" align="center" style="width: 12%;">
                物料编码
            </th>
            <th scope="col" align="center" style="width: 5%;">
                物料数量
            </th>
            <th scope="col" align="center" style="width: 5%;">
                合格数量
            </th>
            <th scope="col" align="center" style="width: 5%;">
                不合格数量
            </th>
            <th scope="col" align="center" style="width: 18%;">
                不良描述
            </th>
        </tr>
        <tr id="trNewInfo" class="ListTableOddRow">
            <td colspan="7" style="text-align: center;">
                暂无数据
            </td>
        </tr>
    </table>
    <style type="text/css">
        .td_Color_Red{
            color:red;
        }
    </style>
    <script type="text/javascript">
        var IQCBatchId = '<%=Request.QueryString["IQCBatchId"]%>'; //退货ID
        $(function () {
            showMaterialRequestInfo();
        });
        //根据检验单号查询GRN信息
        function showMaterialRequestInfo() {
            //var entity = {};
            //entity.ReturnFormId = IQCBatchId;
            //var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("upsGetIQCFormGrnBack", JSON.stringify(entity));
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialIQC.GetIqcFormGrnBack(IQCBatchId);

            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var List = $.parseJSON(ajax.value).data1;
            for (var i = 0; i < List.length; i++) {
                addDetail(List[i], i);
            }
        }

        var tab = document.getElementById("tblExpand");
        var i = 0;
        function addDetail(entity) {
            if (entity == null) {
                return;
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
            cell.innerHTML = entity.POCode;

            //行号
            cell = row.insertCell(1);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = entity.AutoId;

            cell = row.insertCell(2);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = entity.GRN;

            cell = row.insertCell(3);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = entity.ItemCode;

            cell = row.insertCell(4);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = parseFloat(entity.TotalQty);
            
            cell = row.insertCell(5);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = parseFloat(entity.OKQty);

            cell = row.insertCell(6);
            cell.align = "center";
            if (entity.NgQty == 0) {
                cell.className = "Field";
            }
            else {
                cell.className = "Field td_Color_Red";
            }
            cell.innerHTML = parseFloat(entity.NgQty);

            cell = row.insertCell(7);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = entity.Remark;
        }
    </script>
</asp:Content>

