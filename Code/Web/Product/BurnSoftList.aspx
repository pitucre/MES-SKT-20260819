<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true"
    CodeBehind="BurnSoftList.aspx.cs" Inherits="SKT.LeanMES.Web.Product.BurnSoftList" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1">
                软件名称
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtSoftName" ClientIDMode="Static" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1">
        <Columns>
            <asp:BoundField DataField="SoftName" HeaderText="软件名称" />
            <asp:BoundField DataField="TestMachine" HeaderText="测试仪器" />
            <asp:BoundField DataField="Customer" HeaderText="适用客户" />
            <asp:BoundField DataField="SoftMan" HeaderText="给软件的人" />
            <asp:BoundField DataField="ReceiveDate" HeaderText="接收日期" />
            <asp:BoundField DataField="updatContent" HeaderText="更改内容" />
            <asp:BoundField DataField="Ramark" HeaderText="<%$Resources:lang,Remark %>" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="<%$Resources:lang,CreateDateTime %>" />
            <asp:TemplateField HeaderText="软件下载链接">
                <ItemTemplate>
                    <%# Eval("SoftPath").ToString()==""?"":Eval("SoftPath").ToString().Replace(Eval("SoftPath").ToString().Substring(0, Eval("SoftPath").ToString().LastIndexOf("\\") + 1), "Http://10.10.20.6/TempFile/")%>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="VerifyCode" HeaderText="校验码" />
            <asp:BoundField DataField="DOwnloadDir" HeaderText="默认下载目录" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Material.BLL.BurnSoft"
        SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
</asp:Content>
