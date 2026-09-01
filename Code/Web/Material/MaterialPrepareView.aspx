<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ViewMaster.master" AutoEventWireup="true"
    CodeBehind="MaterialPrepareView.aspx.cs" Inherits="SKT.LeanMES.Web.Material.MaterialPrepareView" %>

<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="server">
    <table id="tblExpand" cellspacing="0" cellpadding="4" style="border-width: 0px; width: 100%;
        border-collapse: collapse; margin-top: 5px;" class="EditeContentTable">
        <tr class="ListTableHeader">
            <th scope="col" style="width: 12%;">
                GRN
            </th>
            <th scope="col" style="width: 5%;">
                数量
            </th>
            <th scope="col" style="width: 15%;">
                批次号
            </th>
            <th scope="col" style="width: 18%;">
                入库时间
            </th>
            <th scope="col" style="width: 18%;">
                生产日期
            </th>
            <th scope="col" style="width: 18%;">
                库位
            </th>
        </tr>
        <tr id="trNewInfo" class="ListTableOddRow">
            <td colspan="4" style="text-align: center;">
                暂无数据
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        var ItemId = '<%=Request.QueryString["ID"]%>'; //物料ID

        $(function () {
            showGRNInfo();
        });
        //根据物料ID查询GRN信息
        function showGRNInfo() {
            var entity = {};
            entity.ItemId = ItemId;
            //var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspGetMaterialPrepareGRN", JSON.stringify(entity));
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.GetMaterialPrepareGRN("uspGetMaterialPrepareGRN", JSON.stringify(entity));
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

        function addDetail(entity) {
            if (entity == null) {
                entity = {};
                entity.GRN = -1;
                entity.StorageQty = "";
                entity.CreateDateTime = "";
                entity.LotCode = "";
                entity.StorageDate = "";
                entity.DateCode = "";
                entity.cBarCode = '';
            }

            $("#trNewInfo").remove();
            var row, cell;
            rowNewIdx = tab.rows.length;
            row = tab.insertRow(rowNewIdx);
            row.className = "ListTableOddRow";

            //GRN
            cell = row.insertCell(0);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = entity.GRN;

            //可用数量
            cell = row.insertCell(1);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = parseFloat(entity.StorageQty);
             
            //批次号
            cell = row.insertCell(2);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = entity.LotCode;

            //入库时间
            cell = row.insertCell(3);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = (entity.StorageDate == "1900/1/1 0:00:00" ? "" : entity.StorageDate);

            //生产日期
            cell = row.insertCell(4);
            cell.align = "center";
            cell.className = "Field";
            //cell.innerHTML = (entity.DateCode == "1900/1/1 0:00:00" ? "" : entity.DateCode);
            cell.innerHTML = (entity.DateCode == "1900/1/1" ? "" : /\d{4}\/\d{1,2}\/\d{1,2}/g.exec(entity.DateCode));

            //库位
            cell = row.insertCell(5);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = (entity.cBarCode);
        }
    </script>
</asp:Content>
