<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MaintenanceRecordList.aspx.cs" Inherits="SKT.LeanMES.Web.Maintenance.MaintenanceRecordList"  MasterPageFile="~/Masters/ListMaster.master"%>
<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1">
                <%=Resources.lang.EquipmentCode%>
            </td>
            <td class="Field1">
                <input type="text" id="txtEquipmentCode" class="TextBox" runat="server" />
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="searchConditions" runat="server" ContentPlaceHolderID="GridviewContent">
    <asp:GridView ID="GridView1" AutoGenerateColumns="false" runat="server">
        <Columns>
            <asp:BoundField DataField="PlanName" HeaderText="<%$ Resources:lang,PlanName %>" ItemStyle-Width="90px" />
            <asp:BoundField DataField="EquipmentCode" HeaderText="<%$ Resources:lang,EquipmentCode %>" ItemStyle-Width="90px" />
            <asp:BoundField DataField="EquipmentName" HeaderText="<%$ Resources:lang,EquipmentName %>" ItemStyle-Width="90px" />
            <asp:BoundField DataField="MaintainDetail" HeaderText="<%$ Resources:lang,MaintenanceDemo %>" ItemStyle-Width="90px" />
            <asp:BoundField DataField="DemoSubName" HeaderText="<%$ Resources:lang,MaintenanceDemoName %>" ItemStyle-Width="90px" />
            <asp:BoundField DataField="MaintainActionPerson" HeaderText="<%$ Resources:lang,MaintainActionPerson %>" ItemStyle-Width="90px" />
            <asp:BoundField DataField="MaintainDateTime" HeaderText="<%$ Resources:lang,MaintainTime %>" ItemStyle-Width="90px" />
              <asp:TemplateField HeaderText="保养图片">  
               <ItemTemplate>
                   <a href='javascript:void(0);' onclick="LoadZhenShu('<%#Eval("FileSaveName")%>')"><%# Eval("FileSaveName") %> </a>  
              </ItemTemplate>  
     </asp:TemplateField>  
            <asp:BoundField DataField="Remark" HeaderText="<%$ Resources:lang,Remark %>" ItemStyle-Width="90px" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Maintenance.BLL.MaintenanceRecord"
        SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>

    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <script type="text/javascript">
        isMultiple = false;
        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");


        //刷新 
        function refresh() {
            document.forms[0].submit();
        }

        function Delete() {
            var idStr = getDeletingRecordIdString();
            if (idStr == "") return false;
            $(hdnOperate).val("Delete");
            $(hdnIdString).val(idStr);
            document.forms[0].submit();
        }

        function UpdateList(equipmentCode) {
            $("#<%=this.txtEquipmentCode.ClientID%>").val(equipmentCode);
            document.forms[0].submit();
        }

        function LoadZhenShu(data) {
            if (data == "未载入") {
                alert("未上传文件!");
                return false;
            }
            var path = GetFilePath("EquipmentFailure", data);
            window.open(path);
        }
    </script>
</asp:Content>

