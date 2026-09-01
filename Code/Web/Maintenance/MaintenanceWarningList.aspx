<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MaintenanceWarningList.aspx.cs" Inherits="SKT.LeanMES.Web.Maintenance.MaintenanceWarningList" MasterPageFile="~/Masters/ListMaster.master" %>
<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" Runat="Server">

    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">
                <%=Resources.lang.EquipmentCode%>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtEquipmentCode" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label2">
                保养人工号
            </td>
            <td class="Field2">
                <asp:TextBox ID="MaintainPerson" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" Runat="Server">
     
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" OnRowDataBound="GridView1_RowDataBound">
        <Columns>
             <asp:BoundField DataField="PlanName" HeaderText="<%$Resources:lang,PlanName %>" HeaderStyle-Width="60px"/>
            <asp:BoundField DataField="EquipmentCode" HeaderText="<%$Resources:lang,EquipmentCode %>" HeaderStyle-Width="60px"/>
            <asp:BoundField DataField="EquipmentName" HeaderText="<%$Resources:lang,EquipmentName %>" HeaderStyle-Width="60px"/>
            <asp:BoundField DataField="MaintainWayStr" HeaderText="<%$Resources:lang,MaintainWay %>" HeaderStyle-Width="60px"/>
            <asp:BoundField DataField="CycleTypeStr" HeaderText="<%$Resources:lang,CycleType %>" HeaderStyle-Width="60px"/>
            <asp:BoundField DataField="CycleTime" HeaderText="<%$Resources:lang,CycleTime  %>" HeaderStyle-Width="40px"/>
            <asp:BoundField DataField="UsedTimes" HeaderText="<%$Resources:lang,EquipmentUsedTimes %>" HeaderStyle-Width="40px"/>
            <asp:BoundField DataField="LifeTime" HeaderText="<%$Resources:lang,EquipmentLifeTime %>" HeaderStyle-Width="40px"/>

            <asp:BoundField DataField="MaintainPerson" HeaderText="<%$Resources:lang,MaintainActionPerson %>" HeaderStyle-Width="50px"/>
            <asp:BoundField DataField="MaintainPersonName" HeaderText="<%$Resources:lang,MaintainActionPerson %>" HeaderStyle-Width="60px" />
            <asp:BoundField DataField="WarningTo" HeaderText="<%$Resources:lang,PreWarningReceivePerson %>" HeaderStyle-Width="50px"/>

            <asp:BoundField DataField="StatusStr" HeaderText="<%$Resources:lang,WarningStatus %>" HeaderStyle-Width="80px"/>
            <asp:BoundField DataField="LastDateTime" HeaderText="<%$Resources:lang,LastMaintainTime %>" HeaderStyle-Width="140px"  DataFormatString="{0:yyyy-MM-dd hh:mm:ss}" />

            <asp:BoundField DataField="NextMaintainTime" HeaderText="<%$Resources:lang,NextMaintainTime %>" HeaderStyle-Width="140px"  DataFormatString="{0:yyyy-MM-dd hh:mm:ss}" />
       
            <asp:BoundField DataField="TimeoutWarning" HeaderText="<%$Resources:lang,TimeoutPreWarning  %>" HeaderStyle-Width="80px"/>

        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Maintenance.BLL.MaintenanceWarning"
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

        //兼容列表的行双击事件！
        function Edit() {
            View();
        }

        function View() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Maintenance/MaintenanceWarningView.aspx?name=Maintenance_MaintenanceWarningView&Id=" + idStr;
            dialog({ title: "<%=Resources.Pages.Maintenance_MaintenanceWarningView %>", src: openWinUrl, width: 750, height: 400 });
        }

        function Delete() {
            var idStr = getDeletingRecordIdString();
            if (idStr == "") return false;
            hdnOperate.val("delete");
            hdnIdString.val(idStr);
            document.forms[0].submit();
        }


        function UpdateList(txtEquipmentCode) {
            $("#<%=this.txtEquipmentCode.ClientID %>").val(txtEquipmentCode);
            document.forms[0].submit();
        }    
        
    </script>
</asp:Content>

