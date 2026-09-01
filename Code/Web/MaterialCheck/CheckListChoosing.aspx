<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CheckListChoosing.aspx.cs"
    MasterPageFile="~/Masters/ViewMaster.master" Inherits="SKT.LeanMES.Web.MaterialCheck.CheckListChoosing" %>


<%@ MasterType VirtualPath="~/Masters/ViewMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="server">
    <div class="EditeContentTable" id="infotab" width="100%">
    </div>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="search" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <script type="text/javascript">
        var startRow = 0; //从第几行开始查询
        var maxRow = 1000; //每次查询多少行
        var sortExpression = ""; //排序列
        var warehouseCheckOrderId = '<%=Request.QueryString["OrderID"]%>';
        $(function () {
            doSearch();
        });


        function getSelectedValues() {
            var selValues = "";
            var checkboxs = document.getElementsByName("chkSelect");
            var checkboxCount = checkboxs.length;

            for (var i = 0; i < checkboxCount; i++) {
                if (checkboxs[i].checked) {
                    if (selValues != "") {
                        selValues += ",";
                    }

                    selValues += checkboxs[i].value;
                }
            }
            return selValues;
        }
        //全选 反选
        function Allclick(obj) {
            $("input[name='chkSelect']").each(function () {
                if ($(this).prop("checked")) {
                    $(this).prop("checked", false);
                    $(obj).prop("checked", false);
                } else {
                    $(this).prop("checked", true);
                    $(obj).prop("checked", true);
                }
            });
        }


        function Clear() {
            $("#infotab").html("");
            startRow = 0; //从第几行开始查询
            maxRow = 1000; //每次查询多少行
            sortExpression = ""; //排序列
            searchSettings = ""; //查询条件
        }
        //查询加载数据
        function doSearch() {
            Clear();
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxWarehouseCheck.GetMaterialChecking(startRow, maxRow, sortExpression, warehouseCheckOrderId);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            else {
                var htmlstr = "<table width='100% ' class='ListTable' id='tbBuyOrderDetail'><thead><tr class='ListTableHeader'>"
                + "<th> <input type='checkbox' id='CheckAll' name ='selectall' onclick ='Allclick(this)'/></th><th>行号</th><th>货位条码</th><th>物料编码</th><th>物料描述</th><th>GRN</th></tr></thead>";
                var list = ajax.value;
                //如果查询的条数<最大行数据，说明一次性已经查询出来，maxRow = 1 
                for (var i = 0; i < list.length; i++) {
                    if (i % 2 == 0) {
                        htmlstr += "<tr class='ListTableEvenRow'  id=" + list[i].GRN + ">";
                    }
                    else {

                        htmlstr += "<tr class='ListTableOddRow' id=" + list[i].GRN + ">";
                    }
                    htmlstr += "<td><input type='checkbox' id='checkBox'" + list[i].GRN + "'' name ='chkSelect' "
                           + " value =" + list[i].GRN + " /></td>"
                           + "<td>" + (i + 1) + "</td>"
                           + "<td>" + list[i].WhBarcode + "</td>"
                           + "<td>" + list[i].ItemCode + "</td>"
                           + "<td>" + list[i].Item + "</td>"
                           + "<td>" + list[i].GRN + "</td>"
                    + "</tr>";
                }
                $("#infotab").html(htmlstr + "</table>");
            }
        }

    </script>
</asp:Content>
