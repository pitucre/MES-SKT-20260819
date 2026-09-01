<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" CodeBehind="EquipmentInspectionTemplateItemList.aspx.cs" Inherits="SKT.LeanMES.Web.Equipment.EquipmentInspectionTemplateItemList" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">模板名称
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtInspectionTemplateName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label2">设备编码
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtEquipmentCode" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
    <asp:GridView ID="GridView1" AutoGenerateColumns="false" runat="server" OnRowDataBound="GridView1_OnRowDataBound" style="table-layout:fixed;word-wrap:break-word;word-break:break-all">
        <Columns>
            <asp:BoundField DataField="EquipmentCode" HeaderText="设备编码" HeaderStyle-Width="120px" />
            <asp:BoundField DataField="EquipmentTypeName" HeaderText="设备类型" HeaderStyle-Width="150px" />
            <asp:BoundField DataField="EquipmentName" HeaderText="设备名称" HeaderStyle-Width="150px" />
            <asp:BoundField DataField="InspectionTemplateName" HeaderText="模板名称" HeaderStyle-Width="150px" />            
            <asp:BoundField DataField="CycleTypeStr" HeaderText="周期类型" HeaderStyle-Width="70px" />
            <asp:BoundField DataField="CycleTime" HeaderText="周期间隔" HeaderStyle-Width="70px" />
            <asp:BoundField DataField="PrewarningStr" HeaderText="警报提前" HeaderStyle-Width="70px" />
            <asp:BoundField DataField="OperionUserName" HeaderText="点检角色" HeaderStyle-Width="60px" />
            <asp:BoundField DataField="ReportingUserName" HeaderText="预警接收人" HeaderStyle-Width="170px" />
            <asp:BoundField DataField="MaintainTime" HeaderText="下一次点检时间"  DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" HeaderStyle-Width="170px" />
            <asp:BoundField DataField="LastTime" HeaderText="上一次点检时间"  DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" HeaderStyle-Width="170px" />
            <asp:BoundField DataField="CreateBy" HeaderText="创建人" HeaderStyle-Width="70px" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="<%$Resources:lang,CreateDateTime %>"  DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" HeaderStyle-Width="170px" />
             <asp:BoundField DataField="ModifyBy" HeaderText="修改人" HeaderStyle-Width="70px" />
            <asp:BoundField DataField="ModifyDateTime" HeaderText="<%$Resources:lang,ModifyDateTime %>"  DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" HeaderStyle-Width="170px" />
            <%--<asp:BoundField DataField="GenerateNumberTypeName" HeaderText="<%$Resources:lang,NextNumberType %>"  HeaderStyle-Width="150px"/>--%>
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Equipment.BLL.EquipmentInspectionTemplateItem"
        SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />

    <script language="javascript" type="text/javascript">
        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");

        function Add() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/EquipmentInspectionTemplateItemEdit.aspx?name=Equipment_InspectionTemplateItemAdd&ID=-1";
            dialog({ title: mesLang("新增模板关联"), src: openWinUrl, width: 800, height: 450 });
     }

     function Edit() {
         var idStr = getOneRecordId();
         if (idStr === "") return false;
         openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/EquipmentInspectionTemplateItemEdit.aspx?name=Equipment_InspectionTemplateItemEdit&ID=" + idStr;
         dialog({ title: mesLang("编辑模板关联"), src: openWinUrl, width: 800, height: 450 });
        }

        function Delete() {
            var idStr = getDeletingRecordIdString();

            if (idStr === "") return false;
            hdnOperate.val("delete");
            hdnIdString.val(idStr);
            document.forms[0].submit();
        }

        function UpdateList(itemName) {
            document.forms[0].submit();
        }
    </script>
</asp:Content>
