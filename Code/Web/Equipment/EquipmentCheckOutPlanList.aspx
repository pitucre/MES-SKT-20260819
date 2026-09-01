<%@ Page Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="True"
    CodeBehind="EquipmentCheckOutPlanList.aspx.cs" Inherits="SKT.LeanMES.Web.Equipment.EquipmentCheckOutPlanList" Title="EquipmentCheckOutPlan List Page" %>
<%@ Import Namespace="NPOI.SS.Formula.Functions" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">

        <tr>
            <td class="Label2"><%=Resources.lang.EquimentCode %></td>
            <td class="Field2">
                <asp:TextBox ID="txtEqCode" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label2"><%= Resources.lang.EquipmentName %></td>
            <td class="Field2">
                <asp:TextBox ID="txtEqName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">校验类型</td>
            <td class="Field2">
                <asp:DropDownList runat="server" ID="txtCheckType">
                    <asp:ListItem Value="-1">全部</asp:ListItem>
                    <asp:ListItem Value="1">内检</asp:ListItem>
                    <asp:ListItem Value="2">外检</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td class="Label2">校验项目</td>
            <td class="Field2">
                <asp:TextBox ID="txtCheckProject" runat="server" CssClass="TextBox" MaxLength="50" 
                    ClientIDMode="Static">
                </asp:TextBox>
                <input type="button" value="..." class="ButtonBox" onclick="selectCheckProject()" />
              
            </td>
        </tr>
        <tr>
             <td class="Label2">是否预警</td>
              <td class="Field2">
                  <select id="selectWarning" runat="server">
                      <option value="">全部</option>
                      <option value="1">是</option>
                      <option value="0">否</option>
                  </select>
               </td>
        </tr>
       
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" OnRowDataBound="GridView1_RowDataBound">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="EqCode" HeaderText="<%$ Resources:lang, EquipmentCode %>" />
            <asp:BoundField DataField="EqName" HeaderText="<%$ Resources:lang, EquipmentName %>" />
            <asp:BoundField DataField="CheckTypeName" HeaderText="校验类型" />
            <asp:BoundField DataField="CheckProjectName" HeaderText="校验项目" />
            <asp:BoundField DataField="CycleTypeName" HeaderText="<%$ Resources:lang, CycleType %>" />
            <asp:BoundField DataField="Cycle" HeaderText="<%$ Resources:lang, Cycle %>" />
            <asp:TemplateField HeaderText="<%$ Resources:lang, LastTime %>">
                <ItemTemplate>
               
                     <%#string.Format("{0:yyyy-MM-dd hh:mm:ss}",Eval("LastTime")).Trim()=="9999-12-31 12:00:00"?"":string.Format("{0:yyyy-MM-dd HH:mm:ss}",Eval("LastTime"))%>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="NextTime" HeaderText="<%$ Resources:lang, NextTime %>" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
             <asp:BoundField DataField="IsWarning" HeaderText="是否预警">
            </asp:BoundField>
            <asp:BoundField DataField="CreateBy" HeaderText="<%$ Resources:lang, CreateBy %>" />
            <asp:BoundField DataField="CreateTime" HeaderText="<%$ Resources:lang, CreateTime %>" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}"/>
            <asp:BoundField DataField="ModifyBy" HeaderText="<%$ Resources:lang, ModifyBy %>" />
            <asp:BoundField DataField="ModifyTime" HeaderText="<%$ Resources:lang, ModifyDateTime %>"  DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true"
        StartRowIndexParameterName="startRow" MaximumRowsParameterName="maxRows" SortParameterName="sortExpression"
        TypeName="SKT.LeanMES.Equipment.BLL.EquipmentCheckOutPlan" SelectMethod="GetAll" SelectCountMethod="GetCount">
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
        function Add() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/EquipmentCheckOutPlanEdit.aspx?name=EquipmentCheckOutPlanListAdd&ID=-1";
            dialog({ title: "<%=Resources.Pages.EquipmentCheckOutPlanListAdd %>", src: openWinUrl, width: 800, height: 450 });
        }

        function Save() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/EquipmentCheckOutPlanEdit.aspx?name=EquipmentCheckOutPlanListEdit&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.EquipmentCheckOutPlanListEdit %>", src: openWinUrl, width: 800, height: 450 });
        }
        //校验
        function CheckOut() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/EquipmentCheckOutHistoryEdit.aspx?name=EquipmentCheckOutPlanListCheckOut&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.EquipmentCheckOutPlanListEdit %>", src: openWinUrl, width: 800, height: 600 });
        }
        function Delete() {
            var idStr = getDeletingRecordIdString();
            if (idStr == "") return false;

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEquipmentCheckOutPlan.Delete(idStr);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert("删除成功");
            //hdnOperate.val("delete");
            //hdnIdString.val(idStr);
            document.forms[0].submit();
        }

        function Refresh() {
            document.forms[0].submit();
        }

        var temp = 0;
        function selectCheckProject() {
            temp = 2;
            var PaC = " IsEnable =1 ";
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=673&PageCondition=" + PaC + "&Multiple=false&rnd=" + Math.random(), width: 600, height: 300 });
        }
        function getChooseValue(list) {
            if (temp == 2) {

                $("#<%=this.txtCheckProject.ClientID%>").val(list[0][2]);
              
           }
       }
    </script>
</asp:Content>

