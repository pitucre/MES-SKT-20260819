<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ViewMaster.master" AutoEventWireup="true" CodeBehind="ScrapOutView.aspx.cs" Inherits="SKT.LeanMES.Web.Scrap.ScrapOutView" %>
<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="server">
    <table id="tblExpand" cellspacing="0" cellpadding="4" style="border-width: 0px; width: 100%;
        border-collapse: collapse; margin-top: 5px;" class="EditeContentTable">
        <tr class="ListTableHeader">
            <th scope="col" style="width: 40px;">
                行号
            </th>
            <th scope="col" style="width: 110px;">
                产品编码
            </th>
            <th scope="col" style="width: 110px;">
                产品名称
            </th>
            <th scope="col" style="width: 140px;">
                GRN条码
            </th>
            <th scope="col" style="width: 80px;">
                报废数量
            </th>
            <th scope="col" style="width: 120px;">
                库位
            </th>
        </tr>
        <tr id="trNewInfo" class="ListTableOddRow">
            <td colspan="6" style="text-align: center;">
                暂无数据
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        $(function () {
            showMaterialRequestInfo();
        });

        var ScrapId = '<%=Request.QueryString["ScrapId"]%>';
        var scrapDateTime = '<%=Request.QueryString["ScrapDateTime"]%>';
        var cName = '<%=Request.QueryString["CName"]%>';
        function showMaterialRequestInfo() {
            var scrapId = ScrapId; //报废单ID
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxScrapStorage.GetScrapStorageById(scrapId, scrapDateTime, cName);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var en = $.parseJSON(ajax.value);
            var List = en.data;
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
                entity.SerialNumber = "";
                entity.ScrapQty = "";
                entity.BarCodeOut = "";
                entity.BarCode = "";
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

            cell = row.insertCell(3);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = entity.SerialNumber;

            cell = row.insertCell(4);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = entity.ScrapQty;

            cell = row.insertCell(5);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = entity.BarCode;
        }
    </script>
</asp:Content>
