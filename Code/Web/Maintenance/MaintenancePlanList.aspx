<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MaintenancePlanList.aspx.cs" Inherits="SKT.LeanMES.Web.Maintenance.MaintenancePlanList" MasterPageFile="~/Masters/ListMaster.master" %>
<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" Runat="Server">

    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">
              <%=Resources.lang.PlanName%>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtPlanName" runat="server" CssClass="TextBox"></asp:TextBox> 
            </td>
          <%--  <td class="Label2">
                <%=Resources.lang.EquipmentCode%>
            </td>
            <td class="Field2"> 
                <asp:TextBox ID="txtEquipmentCode" runat="server" CssClass="TextBox"></asp:TextBox> 
            </td>--%>
            
           <%--  <td class="Label2">  <%=Resources.lang.PlanObject%></td>
            <td class="Field2">
                 <asp:DropDownList runat="server" ID="ddlObject">
                    <asp:ListItem Value="-1">请选择</asp:ListItem>
                    <asp:ListItem Value="1">设备</asp:ListItem>
                    <asp:ListItem Value="2">设备类型</asp:ListItem>
                </asp:DropDownList>
            </td>--%>
        </tr>
         <tr>
           <%--   <td class="Label2"><%=Resources.lang.EquipmentTypeName%></td>
            <td class="Field2">
                <asp:TextBox ID="txtEquimentType" runat="server"  minChars="1"></asp:TextBox>   <input type="button" value="..." class="ButtonBox" onclick="selectEqType()" />
            </td>--%>
             
              
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" Runat="Server">
     
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" > 
        <Columns>
               <asp:BoundField DataField="PlanName" HeaderText="<%$Resources:lang,PlanName %>" HeaderStyle-Width="80px"/>
            <asp:BoundField DataField="MaintainWayStr" HeaderText="<%$Resources:lang,MaintainWay %>" HeaderStyle-Width="80px"/>
            <asp:BoundField DataField="CycleTypeStr" HeaderText="<%$Resources:lang,CycleType %>" HeaderStyle-Width="80px"/>
            <asp:BoundField DataField="CycleTime" HeaderText="<%$Resources:lang,CycleTime  %>" HeaderStyle-Width="50px"/>
          <%--  <asp:BoundField DataField="Usage" HeaderText="<%$Resources:lang,EquipmentUsedTimes %>" HeaderStyle-Width="50px"/>--%>
           <%-- <asp:BoundField DataField="LifeTime" HeaderText="<%$Resources:lang,EquipmentLifeTime %>" HeaderStyle-Width="50px"/>--%>
            <asp:BoundField DataField="PrewarningStr" HeaderText="<%$Resources:lang,PreWarning %>" HeaderStyle-Width="50px"/>
            <asp:BoundField DataField="MaintainPerson" HeaderText="<%$Resources:lang,MaintainActionPerson %>" HeaderStyle-Width="60px"/>
            <asp:BoundField DataField="WarningTo" HeaderText="<%$Resources:lang,PreWarningReceivePerson %>" HeaderStyle-Width="60px"/>
        <%--    <asp:BoundField DataField="WarningEmail" HeaderText="<%$Resources:lang,PreWarningReceiveEmail %>" HeaderStyle-Width="100px"/>--%>
            <%--<asp:BoundField DataField="StatusStr" HeaderText="<%$Resources:lang,WarningStatus %>" HeaderStyle-Width="80px"/>--%>
            <asp:BoundField DataField="CreateBy" HeaderText="<%$ Resources:lang, CreateBy %>" HeaderStyle-Width="100px"/>
            <asp:BoundField DataField="CreateDateTime" HeaderText="<%$ Resources:lang, CreateDateTime %>" HeaderStyle-Width="100px" DataFormatString="{0:yyyy-MM-dd hh:mm:ss}" />

            <asp:BoundField DataField="ModifyBy" HeaderText="<%$ Resources:lang, ModifyBy %>" HeaderStyle-Width="100px"/>
            <asp:BoundField DataField="ModifyDateTime" HeaderText="<%$ Resources:lang, ModifyDateTime %>" HeaderStyle-Width="100px" DataFormatString="{0:yyyy-MM-dd hh:mm:ss}" />

        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Maintenance.BLL.MaintenancePlan"
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

        //添加
        function Add() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Maintenance/MaintenancePlanEdit.aspx?name=Maintenance_MaintenancePlanAdd&Id=-1";
            dialog({ title: "<%=Resources.Pages.Maintenance_MaintenancePlanAdd %>", src: openWinUrl, width: 880, height: 520 });
        }

        //编辑
        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Maintenance/MaintenancePlanEdit.aspx?name=Maintenance_MaintenancePlanEdit&Id=" + idStr;
            dialog({ title: "<%=Resources.Pages.Maintenance_MaintenancePlanEdit %>", src: openWinUrl, width: 880, height: 520 });
        }

        //查看
        function View() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Maintenance/MaintenancePlanView.aspx?name=Maintenance_MaintenancePlanView&Id=" + idStr;
            dialog({ title: "<%=Resources.Pages.Maintenance_MaintenancePlanView %>", src: openWinUrl, width: 880, height: 520 });
        }

        function Delete() {
            var idStr = getDeletingRecordIdString();
            if (idStr == "") return false;
            hdnOperate.val("delete");
            hdnIdString.val(idStr);
            document.forms[0].submit();
        }

        //计划保养确认
        function Confirm() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Maintenance/PlanMaintainConfirm.aspx?name=Maintenance_PlanMaintainConfirm&Id=" + idStr;
            dialog({ title: "<%=Resources.Pages.Maintenance_PlanMaintainConfirm%>", src: openWinUrl, width: 720, height: 420 });
        }
        //保养
        function Ckeck() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Maintenance/MaintenanceCheck.aspx?name=Maintenance_PlanMaintainCkeck&Id=" + idStr;
            dialog({ title: "<%=Resources.Pages.Maintenance_PlanMaintainCkeck%>", src: openWinUrl, width: 720, height: 420 });
        }
        function UpdateList(planName) {
            $("#<%=this.txtPlanName.ClientID %>").val(planName);
            document.forms[0].submit();
        }    
          function selectEqType() {
              var openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/EquimentTypeDialog.aspx?name=QC_InspectionItemDialog&controlId=controlId";
            dialog({ title: "设备类型", src: openWinUrl, width: 255, height: 350 });
            }
        <%-- SetValue = function (list) {
             closeDialog();
            $("#<%=txtEquimentType.ClientID%>").val(list[0].name);
        }--%>
    </script>
</asp:Content>

