<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EquipmentList.aspx.cs" Inherits="SKT.LeanMES.Web.Equipment.EquipmentList" MasterPageFile="~/Masters/ListMaster.master" %>
<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <table class="EditeContentTable" width="100%">
         <tr>
            <td class="Label2"><%=Resources.lang.EquipmentCode%></td>
            <td class="Field2">
                <asp:TextBox ID="txtEquipmentCode" runat="server" minChars="1"></asp:TextBox>
            </td>
            <td class="Label2"><%=Resources.lang.EquipmentName%></td>
            <td class="Field2">
                <asp:TextBox ID="txtEquipmentName" runat="server" minChars="1"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2"><%=Resources.lang.LineName%></td>
            <td class="Field2">
                <asp:TextBox ID="txtlineName" runat="server"  minChars="1"></asp:TextBox>
            </td>
           <td class="Label2"><%=Resources.lang.EquipmentStatus%></td>
            <td class="Field2">
                
                 <asp:DropDownList runat="server" ID="ddlEquipmentStatus">
                    <asp:ListItem Value="-1">请选择</asp:ListItem>
                    <asp:ListItem Value="0">新购买</asp:ListItem>
                    <asp:ListItem Value="1">生产中</asp:ListItem>
                    <asp:ListItem Value="2">待机中</asp:ListItem>
                    <asp:ListItem Value="3">换线中</asp:ListItem>
                    <asp:ListItem Value="4">维修中</asp:ListItem>
                    <asp:ListItem Value="5">已报废</asp:ListItem>
                    <asp:ListItem Value="6">故障中</asp:ListItem>
                </asp:DropDownList>
               
            </td>
        </tr>
         <tr>
            <td class="Label2"><%=Resources.lang.EquipmentTypeName%></td>
            <td class="Field2" colspan="3">
                <asp:TextBox ID="txtEquimentType" runat="server"  minChars="1"></asp:TextBox>   <input type="button" value="..." class="ButtonBox" onclick="selectEqType()" />
            </td>
           
        </tr>
    </table>
</asp:Content>
<asp:Content ID="searchConditions" runat="server" ContentPlaceHolderID="GridviewContent">
    <asp:GridView ID="GridView1" AutoGenerateColumns="false" runat="server" OnRowDataBound="GridView1_RowDataBound">
        <Columns>
            <asp:BoundField DataField="EquipmentCode" HeaderText="<%$ Resources:lang,EquipmentCode %>" ItemStyle-Width="90px" />
            <asp:BoundField DataField="EquipmentName" HeaderText="<%$ Resources:lang,EquipmentName %>" ItemStyle-Width="90px" />
            <asp:BoundField DataField="EquipmentModel" HeaderText="<%$ Resources:lang,EquipmentModels %>" ItemStyle-Width="90px" />
            <asp:BoundField DataField="EquipmentTypeName" HeaderText="<%$ Resources:lang,EquipmentTypeName %>" ItemStyle-Width="90px" />
            <asp:BoundField DataField="LineName" HeaderText="<%$ Resources:lang,LineName %>" ItemStyle-Width="90px" />
            <asp:BoundField DataField="StationName" HeaderText="<%$ Resources:lang,StationName %>" ItemStyle-Width="90px" />
            <asp:BoundField DataField="StatusDesc" HeaderText="<%$ Resources:lang,EquipmentStatus %>" ItemStyle-Width="90px" />
            <asp:BoundField DataField="VenCode" HeaderText="<%$ Resources:lang,venCode %>" ItemStyle-Width="90px" />
      <%--      <asp:BoundField DataField="ProduceDate" HeaderText="<%$ Resources:lang,ProduceDate %>" ItemStyle-Width="130px" />--%>
            <asp:BoundField DataField="FactoryDate" HeaderText="<%$ Resources:lang,EnterFactoryDate %>" ItemStyle-Width="130px" DataFormatString="{0:yyyy-MM-dd}" />
             <asp:BoundField DataField="CreateBy" HeaderText="<%$ Resources:lang, CreateBy %>"  ItemStyle-Width="90px"/>
            <asp:BoundField DataField="CreateDateTime" HeaderText="<%$ Resources:lang, CreateDateTime %>"  ItemStyle-Width="130px" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}"/>
             <asp:BoundField DataField="ModifyBy" HeaderText="<%$ Resources:lang, ModifyBy %>" />
            <asp:BoundField DataField="ModifyDateTime" HeaderText="<%$ Resources:lang, ModifyDateTime %>" ItemStyle-Width="130px" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}"/>
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Equipment.BLL.Equipments"
        SelectMethod="GetAll" SelectCountMethod="GetCount"> 
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>

    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
  <%--  <object classid="clsid:62DEBC7F-D316-49E1-86EA-79B5D75E8A87" id="printerDemo" width="0"
        height="0" codebase="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/Component/RouterDesigner/RouterDesigner.cab#version=1,0,0,0">
    </object>--%>
     <script type="text/javascript" src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/layui/layui.all.js"></script>
    <link href="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/layui/css/layui.css" rel="stylesheet" />
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/ws.js" type="text/javascript"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.utility.printer.js?v=3" type="text/javascript"></script>
    <script type="text/javascript">
        isMultiple = false;
        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");

        //增加 
        function Add() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/EquipmentEdit.aspx?name=Equipment_EquipmentAdd&Id=-1";
            dialog({ title: "<%= Resources.Pages.Equipment_EquipmentAdd %>", src: openWinUrl, width: 950, height: 400, resizeable: false });
        }

        //编辑
        function Save() {
            var idStr = getOneRecordId();
            if (idStr == "") return;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/EquipmentEdit.aspx?name=Equipment_EquipmentEdit&Id=" + idStr;
            dialog({ title: "<%= Resources.Pages.Equipment_EquipmentEdit %>", src: openWinUrl, width: 950, height: 400, resizeable: false });
        }

        //刷新 
        function refresh() {
            document.forms[0].submit();
        }


        //查看
        function View() {
            var idStr = getOneRecordId();
            if (idStr == "") return;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/EquipmentView.aspx?name=Equipment_EquipmentView&Id=" + idStr;
            dialog({ title: "<%=Resources.Pages.Equipment_EquipmentView%>", src: openWinUrl, width: 1000, height: 600, resizeable: false });
        }

        function Scrap(){
            
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            if (!confirm("是否确认报废？")) return false;
            hdnOperate.val("scrap");
            hdnIdString.val(idStr);
            document.forms[0].submit();
        }
        //删除
        function Delete() {
            var idStr = getDeletingRecordIdString();
            if (idStr == "") return false;
            $(hdnOperate).val("Delete");
            $(hdnIdString).val(idStr);
            document.forms[0].submit();
        }

        //更新列表
        function UpdateList(equipmentCode) {
            $("#<%=this.txtEquipmentCode.ClientID %>").val(equipmentCode);
            document.forms[0].submit();
        }
        function Import() {
            hdnOperate.val("ExportExcel");
            document.forms[0].submit();
            hdnOperate.val("");
        }
        function selectEqType() {
            var openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/EquimentTypeDialog.aspx?name=Equipment_EquimentTypeDialog&controlId=controlId";
            dialog({ title: "设备类型", src: openWinUrl, width: 255, height: 350 });
        }
        SetValue = function (list) {
            closeDialog();
            $("#<%=txtEquimentType.ClientID%>").val(list[0].name);
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
                labelType = -34;
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

