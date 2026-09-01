<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EquipmentOnLineMouldList.aspx.cs" Inherits="SKT.LeanMES.Web.Equipment.EquipmentOnLineMouldList" MasterPageFile="~/Masters/ListMaster.master" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">设备编码</td>
            <td class="Field2">
                <asp:TextBox ID="txtEquipmentCode" runat="server" minChars="1"></asp:TextBox>
            </td>
            <td class="Label2">设备名称</td>
            <td class="Field2">
                <asp:TextBox ID="txtEquipmentName" runat="server" minChars="1"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">模具编码</td>
            <td class="Field2">
                <asp:TextBox ID="txtMouldCode" runat="server" minChars="1"></asp:TextBox>
            </td>
            <td class="Label2"><%=Resources.lang.MouldName%></td>
            <td class="Field2">
                <asp:TextBox ID="txtMouldName" runat="server" minChars="1"></asp:TextBox>
            </td>
        </tr>

       <%-- <tr>
            <td class="Label2">构件名称</td>
            <td class="Field2" colspan="3">
                <asp:TextBox ID="txtEquipmentTypeName" runat="server" minChars="1"></asp:TextBox>
            </td>

        </tr>--%>
    </table>
</asp:Content>
<asp:Content ID="searchConditions" runat="server" ContentPlaceHolderID="GridviewContent">
    <asp:GridView ID="GridView1" AutoGenerateColumns="false" runat="server" OnRowDataBound="GridView1_RowDataBound">
        <Columns>
            <asp:BoundField DataField="EquipmentCode" HeaderText="机台编码" ItemStyle-Width="90px" />
            <asp:BoundField DataField="EquipmentName" HeaderText="机台名称" ItemStyle-Width="90px" />
            <asp:BoundField DataField="MoudleCode" HeaderText="在机模具编码" ItemStyle-Width="90px" />
            <asp:BoundField DataField="MoudleName" HeaderText="在机模具名称" ItemStyle-Width="130px" />
            <asp:BoundField DataField="CreateBy" HeaderText="换模人" ItemStyle-Width="130px" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="换模时间" ItemStyle-Width="130px" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Equipment.BLL.MoludApply"
        SelectMethod="GetEquimentMouldAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>

    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <%--  <object classid="clsid:62DEBC7F-D316-49E1-86EA-79B5D75E8A87" id="printerDemo" width="0"
        height="0" codebase="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/Component/RouterDesigner/RouterDesigner.cab#version=1,0,0,0">
    </object>--%>
    <script type="text/javascript">
        isMultiple = false;
        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");

        //增加 
        function Add() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/MouldBomEdit.aspx?name=Equipment_MouldBomAdd&Id=-1";
            dialog({ title: "新增模具Bom", src: openWinUrl, width: 950, height: 600, resizeable: false });
        }

        //编辑
        function Save() {
            var idStr = getOneRecordId();
            if (idStr == "") return;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/MouldBomEdit.aspx?name=Equipment_MouldBomEdit&Id=" + idStr;
            dialog({ title: "编辑模具Bom", src: openWinUrl, width: 950, height: 600, resizeable: false });
        }

        //刷新 
        function refresh() {
            document.forms[0].submit();
        }


 <%--       //查看
        function View() {
            var idStr = getOneRecordId();
            if (idStr == "") return;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/MouldView.aspx?name=Equipment_EquipmentView&Id=" + idStr;
            dialog({ title: "查看模具", src: openWinUrl, width: 1000, height: 600, resizeable: false });
        }--%>



        //删除
        function Delete() {
            var idStr = getDeletingRecordIdString();
            if (idStr == "") return false;
            $(hdnOperate).val("Delete");
            $(hdnIdString).val(idStr);
            document.forms[0].submit();
        }

        function In() {
            var idStr = getRecordIdString();
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/MouldInStock.aspx?name=Equipment_MouldIn&type=1&Id=" + idStr;
            dialog({ title: "模具入库", src: openWinUrl, width: 455, height: 355, resizeable: false });
        }

        function Out() {

            var idStr = getRecordIdString();
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/MouldInStock.aspx?name=Equipment_MouldOut&type=0&Id=" + idStr;
            dialog({ title: "模具出库", src: openWinUrl, width: 455, height: 355, resizeable: false });
           <%-- var idStr = getRecordIdString();
            var equipmentCode = $('input[name="chkSelect"]:checked').parent().parent().find("td:eq(1)").html();
          
            if (idStr != "") {
                if (!window.confirm("确认出库？")) {
                    return "";
                }
            }

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEquipment.UpdateStock(idStr, 0);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
           alert('<%=Resources.Messages.SaveSuccess%>');
            window.UpdateList(equipmentCode);--%>
        }


        function Import() {
            hdnOperate.val("ExportExcel");
            document.forms[0].submit();
            hdnOperate.val("");
        }
        function selectEqType() {
            var openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/EquimentTypeDialog.aspx?name=QC_InspectionItemDialog&controlId=-4";
            dialog({ title: "模具类型", src: openWinUrl, width: 255, height: 350 });
        }
        SetValue = function (list) {
            closeDialog();

        }
        var chooseFlag = -1;

        /*选择供应商*/
        function selectSupplier() {
            chooseFlag = 34;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=34&Multiple=false&rnd=" + Math.random(), width: 600, height: 300 });
        }
        /*单位*/
        function selectItem() {
            chooseFlag = 1;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=1&Multiple=false&rnd=" + Math.random(), width: 600, height: 400 });
        }
        function selectCustomer() {
            chooseFlag = 10;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=10&Multiple=false&rnd=" + Math.random(), width: 600, height: 300 });
        }

        function getChooseValue(list) {
           <%-- if (chooseFlag == 1) {
                $("#<%=this.txtItemCode.ClientID %>").val(list[0][2]);
            } else if (chooseFlag == 34) {
                $("#<%=this.txtSupplier.ClientID %>").val(list[0][2]);
            }else if (chooseFlag == 10) {
                $("#<%=this.txtCustomer.ClientID %>").val(list[0][1]);
              
            }--%>
        }
    </script>
</asp:Content>

