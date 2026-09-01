<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true"
    CodeBehind="ESOPMacList.aspx.cs" Inherits="SKT.LeanMES.Web.ESOP.ESOPMacList" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">
                设备名称
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtMacName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label2">
                MAC地址
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtESOPMac" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>          
        </tr>
        <tr>
          <td class="Label2">
                是否默认工序
            </td>
            <td class="Field3">
                <asp:DropDownList ID="ddlIsDefault" runat="server">
                <asp:ListItem Value="">全
                    部</asp:ListItem>
                <asp:ListItem Value="1">是</asp:ListItem>
                <asp:ListItem Value="0">否</asp:ListItem>
                </asp:DropDownList>                   
            </td>
          <td class="Label2">
                备注
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtRemark" runat="server" CssClass="TextBox"></asp:TextBox>                
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" OnRowDataBound="GridView1_RowDataBound">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="MacName" HeaderText="设备名称" HeaderStyle-Width="120px" />
            <asp:BoundField DataField="MAC" HeaderText="MAC地址" HeaderStyle-Width="160px" />
            <asp:BoundField DataField="Station" HeaderText="工序" HeaderStyle-Width="120px" />
            <asp:BoundField DataField="LineName" HeaderText="线别" HeaderStyle-Width="120px" />
            <asp:BoundField DataField="ResName" HeaderText="资源" HeaderStyle-Width="120px" />
             <asp:TemplateField HeaderText="是否默认工序" HeaderStyle-Width="80px">
                <ItemTemplate>
                    <%#Eval("IsDefault").ToString().ToLower()=="true"?"是":"否"%>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="是否切换工序" HeaderStyle-Width="80px">
                <ItemTemplate>
                    <%#Eval("IsSwitch").ToString().ToLower()=="true"?"是":"否"%>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="CreateBy" HeaderText="创建人" HeaderStyle-Width="120px" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="创建时间" HeaderStyle-Width="120px"  DataFormatString="{0:yyyy-MM-dd HH:mm:ss}"/>
            <asp:BoundField DataField="ModifyBy" HeaderText="修改人" HeaderStyle-Width="120px" />
            <asp:BoundField DataField="ModifyDateTime" HeaderText="修改时间" HeaderStyle-Width="120px"  DataFormatString="{0:yyyy-MM-dd HH:mm:ss}"/>
            <asp:BoundField DataField="Remark" HeaderText="备注" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.ESOP.BLL.ESOPMac"
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
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/ESOP/ESOPMacEdit.aspx?name=Production_ESOPMacAdd&ID=-1";
            dialog({ title: "<%=Resources.Pages.Production_ESOPMacAdd %>", src: openWinUrl, width: 850, height: 400 });
        }

        function Edit() {
            var idStr = getOneRecordId();

            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/ESOP/ESOPMacEdit.aspx?name=Production_ESOPMacEdit&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.Production_ESOPMacEdit %>", src: openWinUrl, width: 850, height: 400 });
        }

        function Copy() {
            var idStr = getOneRecordId();
            if (idStr == "") return;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/ESOP/ESOPMacEdit.aspx?name=Production_ESOPMacEdit&ID=" + idStr + "&Action=Copy"
            dialog({ title: "<%=Resources.Pages.Production_ESOPMacCopy %>", src: openWinUrl, width: 850, height: 400, resizeable: true });

        }

        function Delete() {
            var idStr = getDeletingRecordIdString();
            if (idStr == "") return false;
            hdnOperate.val("delete");
            hdnIdString.val(idStr);
            document.forms[0].submit();
        }

        function Refresh() {
            document.forms[0].submit();
        }
    </script>
</asp:Content>
