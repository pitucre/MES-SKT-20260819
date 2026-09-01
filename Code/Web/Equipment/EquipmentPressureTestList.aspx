<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" CodeBehind="EquipmentPressureTestList.aspx.cs" Inherits="SKT.LeanMES.Web.Equipment.EquipmentPressureTestList" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label3">压机编码
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtEquipmentCode" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">最近测试人
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtTestor" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">状态
            </td>
            <td class="Field3">
                <asp:DropDownList ID="ddlTestStatus" runat="server">
                    <asp:ListItem Text="--请选择--" Value=""></asp:ListItem>
                    <asp:ListItem Text="正常" Value="正常"></asp:ListItem>
                    <asp:ListItem Text="待测试" Value="待测试"></asp:ListItem>
                    <asp:ListItem Text="已超期" Value="已超期"></asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>

    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1"  OnRowDataBound="GridView1_RowDataBound">
        <Columns>
            <asp:BoundField DataField="EquipmentCode" HeaderText="设备编码" />
            <asp:BoundField DataField="EquipmentName" HeaderText="设备名称" />
            <asp:BoundField DataField="TestCycle" HeaderText="测试周期（天）" />
            <asp:BoundField DataField="Pressure" HeaderText="机台标称压力" />
            <asp:BoundField DataField="TestTime" HeaderText="最近测试时间" />            
            <asp:BoundField DataField="Tester" HeaderText="最近测试人" />
            <asp:BoundField DataField="NextTestTime" HeaderText="下次测试时间" />    
            <asp:BoundField DataField="CreateBy" HeaderText="创建人" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="创建时间" />    
            <asp:BoundField DataField="ModifyBy" HeaderText="修改人" />
            <asp:BoundField DataField="ModifyDateTime" HeaderText="修改时间" />    
             <asp:BoundField DataField="TestStatus" HeaderText="状态"  ItemStyle-Font-Bold="true"/>           
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Equipment.BLL.EquipmentPressureTest"
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

        function Add() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/EquipmentPressureTestEdit.aspx?name=EquipmentPressureTestAdd&ID=-1";
            dialog({ title: mesLang("<%=Resources.Pages.EquipmentPressureTestAdd%>"), src: openWinUrl, width: 600, height: 350 });
        }
        
        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/EquipmentPressureTestEdit.aspx?name=EquipmentPressureTestEdit&ID=" + idStr;
            dialog({ title: mesLang("<%=Resources.Pages.EquipmentPressureTestEdit%>"), src: openWinUrl, width: 600, height: 350 });
        }

        function Test() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/EquipmentPressureTest.aspx?name=EquipmentPressureTestTest&ID=" + idStr;
            dialog({ title: mesLang("<%=Resources.Pages.EquipmentPressureTestTest%>"), src: openWinUrl, width: 600, height: 350 });
         }

        function Remove() {
             var idStr = getDeletingRecordIdString();
             if (idStr == "") return false;
             hdnOperate.val("delete");
             hdnIdString.val(idStr);
             document.forms[0].submit();
         }
        
         function ImportToExcel() {
             hdnOperate.val("ExportExcel");
             document.forms[0].submit();
             hdnOperate.val("");
         }

         function View() {
             var idStr = getOneRecordId();
             if (idStr == "") return false;
             openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/EquipmentPressureTestView.aspx?name=EquipmentPressureTestView&ID=" + idStr;
             dialog({ title: mesLang("查看"), src: openWinUrl, width: 800, height: 650 });
        }

        function Refresh() {
            document.forms[0].submit();
        }

    </script>
</asp:Content>
