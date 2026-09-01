<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" CodeBehind="SupplierExameResultList.aspx.cs" Inherits="SKT.LeanMES.Web.Warehouse.SupplierExameResultList" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
     <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label3">
                考核时间
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtExameDate" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
            </td>       
            <td class="Label3">
                考核类型
            </td>
            <td class="Field3">
                 <asp:DropDownList runat="server" ID="ddlSupplierExameTempletType" Width="160" ClientIDMode="Static">
                    <asp:ListItem Value="" Selected="True">请选择</asp:ListItem>
                    <asp:ListItem Value="月度">月度</asp:ListItem>
                    <asp:ListItem Value="季度">季度</asp:ListItem>
                    <asp:ListItem Value="年度">年度</asp:ListItem>
                </asp:DropDownList> 
            </td>       
            <td class="Label3">
                供应商
            </td>
            <td class="Field3">
                <input type="text" id="txtVenCode" class="TextBox" runat="server"/>
                <input type="button" class="ButtonBox" value="..." onclick="chooseVendorCode()" />
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1">
        <Columns>
            <asp:BoundField DataField="SupplierExameTempletType" HeaderText="考核类型"   />
            <asp:BoundField DataField="ExameDate" HeaderText="考核时间" />
            <asp:BoundField DataField="VendorCode" HeaderText="供应商编码" />
            <asp:BoundField DataField="VendorName" HeaderText="供应商名称" />
            <asp:BoundField DataField="TotalGrades" HeaderText="合计得分" />
            <asp:BoundField DataField="SupplierExameTempletName" HeaderText="使用模板" />
            <asp:BoundField DataField="SupplierExameTempletCode" HeaderText="模板编码" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Warehouse.BLL.SupplierExameResult"
        SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <script type="text/javascript">
        $(document).ready(function () {

        });

        function chooseVendorCode(obj) {
            dialog({
                title: "<%=Resources.Common.ChooseWindow %>"
                , src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=34&CallBackFunc=getChooseValue&Multiple=true&rnd="
                    + Math.random(), width: 600, height: 300
            });
        }

        function getChooseValue(list) {
            $("#<%=txtVenCode.ClientID %>").val(list[0][1]);
        }

        //考核
        function Add() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Warehouse/SupplierExameResultEdit.aspx?name=Warehouse_SupplierExameResultEdit&ID=-1&rnd=" + Math.random()
            dialog({ title: "<%= Resources.lang.SupplierExamTempletAdd%>", src: openWinUrl, width: 950, height: 550 });
        }

        //编辑
        function View() {
             var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Warehouse/SupplierExameResultView.aspx?name=Warehouse_SupplierExameResultView&ID=" + idStr + "&rnd=" + Math.random()
            dialog({ title: "<%= Resources.lang.SupplierExamTempletEdit%>", src: openWinUrl, width: 850, height: 550 });
        }

        //重算
        function ReExam() {            
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Warehouse/SupplierExameResultReExam.aspx?name=Warehouse_SupplierExameResultReExam&rnd=" + Math.random()
            dialog({ title: "<%= Resources.lang.SupplierExamTempletEdit%>", src: openWinUrl, width: 850, height: 550 });
        }

        function UpdateList() {
            document.forms[0].submit();
        }
    </script>
</asp:Content>
