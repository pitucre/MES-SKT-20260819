<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EquipmentChildList.aspx.cs" Inherits="SKT.LeanMES.Web.Equipment.EquipmentChildList" MasterPageFile="~/Masters/ListMaster.master" %>
<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <table class="EditeContentTable" width="100%">
          <tr>
            <td class="Label2">上级设备编码</td>
            <td class="Field2">
                <asp:TextBox ID="txtEquipmentCode" runat="server"   minChars="1"></asp:TextBox>
            </td>
            <td class="Label2">上级设备名称</td>
            <td class="Field2">
                <asp:TextBox ID="txtEquipmentName" runat="server"   minChars="1"></asp:TextBox>
            </td>
        </tr>
         <tr>
            <td class="Label2"><%=Resources.lang.EquipmentCode%></td>
            <td class="Field2">
                <asp:TextBox ID="txtEquipmentCodeChild" runat="server"   minChars="1"></asp:TextBox>
            </td>
            <td class="Label2"><%=Resources.lang.EquipmentName%></td>
            <td class="Field2">
                <asp:TextBox ID="txtEquipmentNameChild" runat="server"  minChars="1"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="searchConditions" runat="server" ContentPlaceHolderID="GridviewContent">
    <asp:GridView ID="GridView1" AutoGenerateColumns="false" runat="server">
        <Columns>
            <asp:BoundField DataField="EquipmentCode" HeaderText="上级设备编码" ItemStyle-Width="90px" />
            <asp:BoundField DataField="EquipmentName" HeaderText="上级设备名称" ItemStyle-Width="90px"  />
            <asp:BoundField DataField="EquipmentCodeChild" HeaderText="<%$ Resources:lang,EquipmentCode %>" ItemStyle-Width="90px" />
            <asp:BoundField DataField="EquipmentNameChild" HeaderText="<%$ Resources:lang,EquipmentName %>" ItemStyle-Width="90px" />
            <asp:BoundField DataField="ChildEquimentModel" HeaderText="型号规格" ItemStyle-Width="90px" />
             <asp:BoundField DataField="CreateBy" HeaderText="<%$ Resources:lang, CreateBy %>"  ItemStyle-Width="90px"/>
            <asp:BoundField DataField="CreateTime" HeaderText="<%$ Resources:lang,CreateDateTime %>" ItemStyle-Width="130px"  DataFormatString="{0:yyyy-MM-dd hh:mm:ss}" />
             <asp:BoundField DataField="ModifyBy" HeaderText="<%$ Resources:lang, ModifyBy %>"  ItemStyle-Width="90px"/>
            <asp:BoundField DataField="ModifyTime" HeaderText="<%$ Resources:lang,ModifyDateTime %>" ItemStyle-Width="130px"  DataFormatString="{0:yyyy-MM-dd hh:mm:ss}" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Equipment.BLL.EquipmentChild"
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
    <script type="text/javascript">
        isMultiple = false;
        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");

        //增加 
        function Add() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/EquipmentChildEdit.aspx?name=Equipment_EquipmentChildEdit&Id=-1";
            dialog({ title: "<%= Resources.Pages.Equipment_EquipmentChildAdd%>", src: openWinUrl, width: 750, height: 400, resizeable: false });
        }

        //编辑
        function Save() {
            var idStr = getOneRecordId();
            if (idStr == "") return;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/EquipmentChildEdit.aspx?name=Equipment_EquipmentChildEdit&Id=" + idStr;
            dialog({ title: "<%= Resources.Pages.Equipment_EquipmentChildEdit %>", src: openWinUrl, width: 750, height: 400, resizeable: false });
        }

        //刷新 
        function refresh() {
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
    </script>
</asp:Content>

