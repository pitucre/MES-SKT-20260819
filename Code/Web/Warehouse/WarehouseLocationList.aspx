<%@ Page Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="True"
    CodeBehind="WarehouseLocationList.aspx.cs" Inherits="SKT.LeanMES.Web.Warehouse.WarehouseLocationList"
    Title="WarehouseLocation List Page" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label4">
                <%= Resources.lang.WarehouseStorageCode%>
            </td>
            <td class="Field4">
                <asp:TextBox ID="txtScode" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label4">
                <%= Resources.lang.WarehouseStorageName%>
            </td>
            <td class="Field4">
                <asp:TextBox ID="txtSname" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label4">
                <%= Resources.lang.WarehouseGoodsCode%>
            </td>
            <td class="Field4">
                <asp:TextBox ID="txtPcode" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label4">
                <%= Resources.lang.WarehouseGoodsName%>
            </td>
            <td class="Field4">
                <asp:TextBox ID="txtPname" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label4">库位条码
            </td>
            <td class="Field4">
                <asp:TextBox ID="txtCbarcode" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>

            <td class="Label4">仓库编码
            </td>
            <td class="Field4">
                <asp:TextBox ID="txtCWhCode" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label4">仓库名称
            </td>
            <td class="Field4">
                <asp:TextBox ID="txtCWhName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label4">料架编码</td>
            <td class="Field4"><asp:TextBox ID="txtShiftCode" runat="server" CssClass="TextBox"></asp:TextBox></td>

        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" OnRowDataBound="GridView1_RowDataBound">
        <Columns>
            <asp:BoundField DataField="CWhCode" HeaderText="<%$ Resources:lang,WarehouseCode%>"
                SortExpression="CWhCode" />
            <asp:BoundField DataField="cBarCode" HeaderText="<%$ Resources:lang,WarehouseBarCode%>"
                SortExpression="cBarCode" />
            <asp:BoundField DataField="CWhName" HeaderText="<%$ Resources:lang,WarehouseName%>"
                SortExpression="CWhName" />
            <asp:BoundField DataField="CProperty" HeaderText="<%$ Resources:lang,WarehouseTypeName%>"
                SortExpression="CProperty" />
            <asp:BoundField DataField="cStoreCode" HeaderText="<%$ Resources:lang,WarehouseStorageCode%>"
                SortExpression="cStoreCode" />
            <asp:BoundField DataField="cStoreName" HeaderText="<%$ Resources:lang,WarehouseStorageName%>"
                SortExpression="cStoreName" />
            <asp:BoundField DataField="cPosCode" HeaderText="<%$ Resources:lang,WarehouseGoodsCode%>"
                SortExpression="cPosCode" />
            <asp:BoundField DataField="cPosName" HeaderText="<%$ Resources:lang,WarehouseGoodsName%>"
                SortExpression="cPosName" />
       
            <asp:BoundField DataField="LocationType" HeaderText="货位类型"
                SortExpression="LocationType" />
         
         

            <asp:BoundField DataField="CreateBy" HeaderText="<%$ Resources:lang,CreateBy%>"
                SortExpression="CreateBy" HeaderStyle-Width="60px" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="<%$ Resources:lang,CreateDateTime%>"
                SortExpression="CreateDateTime" HeaderStyle-Width="140px" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
            <asp:BoundField DataField="ModifyBy" HeaderText="<%$ Resources:lang,ModifyBy%>"
                SortExpression="ModifyBy" HeaderStyle-Width="60px" />
            <asp:BoundField DataField="ModifyDateTime" HeaderText="<%$ Resources:lang,ModifyDateTime%>"
                SortExpression="ModifyDateTime" HeaderStyle-Width="140px" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Warehouse.BLL.WarehouseLocation"
        SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
     <script type="text/javascript" src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/layui/layui.all.js"></script>
    <link href="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/layui/css/layui.css" rel="stylesheet" />
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/ws.js" type="text/javascript"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.utility.printer.js?v=3" type="text/javascript"></script>
    <script type="text/javascript">
        isMultiple = false;
        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");
        $(document).ready(function () {
            $("#<%= txtScode.ClientID %>").blur(function () {
                CheckSqlSpecialChar("#<%= txtScode.ClientID %>");
            });
            $("#<%= txtSname.ClientID %>").blur(function () {
                CheckSqlSpecialChar("#<%= txtSname.ClientID %>");
            });
            $("#<%= txtPcode.ClientID %>").blur(function () {
                CheckSqlSpecialChar("#<%= txtPcode.ClientID %>");
            });
            $("#<%= txtPname.ClientID %>").blur(function () {
                CheckSqlSpecialChar("#<%= txtPname.ClientID %>");
            });
        });

        function CheckSqlSpecialChar(obj) {
            var re = "'|*|%|; |-|+|,|=|@";
            var charArr = re.split("|");
            for (i = 0; i < charArr.length; i++) {
                if ($(obj).val().indexOf(charArr[i]) >= 0) {
                    
                    $(obj).val("");
                    $(obj).focus();
                }
            }
        }

        function Add() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>"
            + "/Warehouse/WarehouseLocationEdit.aspx?name=Warehouse_WarehouseLocationAdd&ID=-1";
            dialog({ title: "<%= Resources.lang.WarehouseLocationAdd%>", src: openWinUrl, width: 750, height: 460 });
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>"
            + "/Warehouse/WarehouseLocationEdit.aspx?name=Warehouse_WarehouseLocationEdit&ID=" + idStr;
            dialog({ title: "<%= Resources.lang.WarehouseLocationEdit%>", src: openWinUrl, width: 750, height: 460 });
        }

        function Delete() {
            var idStr = getDeletingRecordIdString();
            if (idStr == "") return false;
            hdnOperate.val("delete");
            hdnIdString.val(idStr);
            document.forms[0].submit();
        }

        function View() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>"
            + "/Warehouse/WarehouseLocationView.aspx?name=Warehouse_WarehouseLocationView&ID=" + idStr;
            dialog({ title: "<%= Resources.lang.WarehouseLocationView%>", src: openWinUrl, width: 750, height: 460 });
        }

        function SyncWarehouseLocation() {
            //var type = getOneRecordCellText("LocationType");
            //if (type!="电子料架") {
            //    alert("非电子料架，不可操作");
            //    return false;
            //}
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>"
            + "/Warehouse/WarehouseLocationSyncRW.aspx?name=WarehouseLocationSyncRW";
            dialog({ title: "同步料架库位（瑞微）", src: openWinUrl, width: 750, height: 460 });
        }
        function UpdateList(namestr) {
            $("#<%=this.txtScode.ClientID %>").val(namestr);
            document.forms[0].submit();
        }

        //导出Excel 
        function Import() {
            hdnOperate.val("exportExcel");
            document.forms[0].submit();
            hdnOperate.val("");
        }

        //下载Excel模板
        function Download() {
            return downLoadField('<%=SKT.LeanMES.Web.WebHelper.ExcelTemplateRoot+"货架货位模板.xlsx" %>');
        }
        function downLoadField(fieldPath) {
            window.open(fieldPath);
            return null;
        }

        //导入Excel
        function ImportToExcel() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Warehouse/WarehouseLocationImport.aspx?name=Warehouse_WarehouseLocationAdd&ID=-1";
            dialog({ title: "导入货位货位", src: openWinUrl, width: (windowWidth - 200), height: (windowHeigth - 200) });
        }
        function Print() {
            var idStr = getSelectedValues();
            if (idStr == "") {
                alert("至少选择一个选项");
                return false;
            }
            var strArray = idStr.split(",");
            for (var i = 0; i < strArray.length; i++) {
                labelStr = strArray[i];
                labelType = -35;
                //获取标签文档的配置信息，并且根据标签文档配置的打印类型，进行打印插件的验证。插件引用成功，则初始化打印插件对象。
                getDocumentInfo();
                PrintLabContent();
            }
        }

        /********************************************标签打印 开始  （zhibin.Chen 2016-03-11 整理）************************************************/

        var ibs;                    //秒
        var labelDocumentId = -1    //Label文档Id
        var lableTypeQty = 1;       //连板数量
        var printName = "";         //打印机名称
        var labelItemId = -1;    //ItemId
        var labelStationId = -1;    //工位Id
        var labelType = -3;          //标签类型 (-2：SN，-3：GRN)
        var labelSequence = 2;      //标签序号 (1产品，2GRN, 3单号......)
        var labelPrintWayId = -1;   //打印方式 78=Lab  79=ZPL

        var lableArr = null;        //标签信息的SN序列号集合对象
        var SNInfo;                 //当前释放标签的信息集合对象
        var tempatePath = "";       //Lab模板文件路径
        var labelStr = "";

        //根据打印方式决定 调用ZPL还是Lab打印
        function getDocumentInfo() {

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPrint.GetLabelDocumentInfo(labelItemId, -1, labelType, labelSequence);
            if (ajax.error == null) {
                var entity = ajax.value;
                labelDocumentId = entity.LabelDocumentId;
                lableTypeQty = entity.PlateQty;
                //获取打印机名称值
                printName = entity.PrinterName;
                labelPrintWayId = entity.PrintWayId;
                tempatePath = entity.TemplatePath.replace("\\", "\\\\");

            }
            else {
                alert(ajax.error.Message);
                return false;
            }
        }

        var printCount = 1;


        function PrintLabContent() {
            try {
                var printdata = [];

                var ajaxLabContent = SKT.LeanMES.Web.AjaxServices.AjaxPrint.returnLabelInfoForLab(labelDocumentId, labelStr, -1, -1, -1, -1, -1);

                if (ajaxLabContent.error == null) {
                    var list = ajaxLabContent.value;
                    if (list.length > 0) {
                        var page = { LabelContent: [] };
                        for (var k = 0; k < list.length; k++) {
                            page.LabelContent.push({ name: list[k].LabelName, value: list[k].LabelValue });
                        }
                        printdata.push(page);
                    }
                }

                if (printdata.length == 0)
                    return;
                sendPrintContent(JSON.stringify(printdata), printName, printCount, labelDocumentId);
            } catch (e) {
                alert(e);
                return false;
            }
        }
    </script>
</asp:Content>
