<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true"
    CodeBehind="PartHistory.aspx.cs" Inherits="SKT.LeanMES.Web.Sparepart.PartHistory" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label3">
                操作类型
            </td>
            <td class="Field3">
                <asp:DropDownList ID="ddlOption" runat="server" > 
                    <asp:ListItem Text='请选择' Value='-1'></asp:ListItem>
                    <asp:ListItem Text='出库' Value="出库"></asp:ListItem>
                    <asp:ListItem Text='入库' Value="入库"></asp:ListItem>
                    <asp:ListItem Text='报废' Value="报废"></asp:ListItem>
                    <asp:ListItem Text='保养' Value="保养"></asp:ListItem>
                    <asp:ListItem Text='期限变更' Value="期限变更"></asp:ListItem>
                </asp:DropDownList>
            </td>
            <td class="Label3">
                 操作<%=Resources.lang.StartTime%>
            </td>
            <td class="Field3">
                <asp:TextBox ID="tbBeginTime" CssClass="DateTimeBox" runat="server" ></asp:TextBox>
            </td>
            <td class="Label3">
                操作<%=Resources.lang.EndTime%>
            </td>
            <td class="Field3">
                <asp:TextBox ID="tbEndTime" CssClass="DateTimeBox"  runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label3">
                工具编码
            </td>
            <td class="Field3">
                 <asp:TextBox ID="txtPartMachine" CssClass="TextBox"  runat="server"></asp:TextBox>
            </td>
            <td class="Label3">
                 工具名称
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtPartCategory" CssClass="TextBox"  runat="server"></asp:TextBox>
            </td>
            <td class="Label3">
                操作人
            </td>
            <td class="Field3">
               <asp:TextBox ID="txtRequestor" CssClass="TextBox"  runat="server"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" ClientIDMode="Static">
        <Columns>
            <asp:BoundField DataField="PartNickName" HeaderText="工具编码" />
            <asp:BoundField DataField="PartName" HeaderText="工具名称" />
            <asp:BoundField DataField="Requestor" HeaderText="操作类型" />
            <asp:BoundField DataField="PartQty" HeaderText="数量" />
            <asp:BoundField DataField="Remark" HeaderText="备注信息" />
            <asp:BoundField DataField="CreateBy" HeaderText="操作人" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="操作时间"  DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Sparepart.BLL.PartsHistory"
        SelectMethod="GetAllNew" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value=""  />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <script type="text/javascript"> 
        isMultiple = false;
        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");

        function Import() {
            hdnOperate.val("ExportExcel");
            document.forms[0].submit();
            hdnOperate.val("");
        }
    </script>
</asp:Content>
