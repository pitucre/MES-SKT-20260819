<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" CodeBehind="MsdContainerList.aspx.cs" Inherits="SKT.LeanMES.Web.MSD.MsdContainerList" %>
<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label3">
                容器编码
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtContainerCode" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
            </td>  
           
             <td class="Label3">
                容器类型
            </td>
            <td class="Field3">
                   <asp:DropDownList ID="ddlContainerType" runat="server">
                    <asp:ListItem Value="-1" Text="所有"> </asp:ListItem>
                    <asp:ListItem Value="1" Text="恒温箱"> </asp:ListItem>
                    <asp:ListItem Value="2" Text="烘烤箱"> </asp:ListItem>
                </asp:DropDownList>
            </td>      
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" >
        <Columns>
        <asp:BoundField DataField="ContainerName" HeaderText="容器名称" SortExpression="ContainerName" />
            <asp:BoundField DataField="ContainerCode" HeaderText="容器编码" SortExpression="ContainerCode" />
            <asp:TemplateField HeaderText="容器类型" SortExpression="ContainerType">
                <ItemTemplate>
                    <%#Eval("ContainerType").ToString() == "1" ? "恒温箱" : "烘烤箱"%>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="MaxQty" HeaderText="最大装载数量"  SortExpression="MaxQty" />
            <asp:BoundField DataField="UseQty" HeaderText="已装载数量" SortExpression="UseQty" />
<%--            <asp:BoundField DataField="MaxTemp" HeaderText="上限温度(℃)" SortExpression="MaxTemp" />
            <asp:BoundField DataField="MinTemp" HeaderText="下限温度(℃)" SortExpression="MinTemp" />--%>
             <asp:BoundField DataField="Remark" HeaderText="描述" />
             <asp:BoundField DataField="CreateBy" HeaderText="创建人" HeaderStyle-Width="60px" SortExpression="CreateBy" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="创建时间" HeaderStyle-Width="140px" SortExpression="CreateDateTime" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
             <asp:BoundField DataField="ModifyBy" HeaderText="修改人" HeaderStyle-Width="60px" SortExpression="ModifyBy" />
            <asp:BoundField DataField="ModifyDateTime" HeaderText="修改时间" HeaderStyle-Width="140px" SortExpression="ModifyDateTime" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
           
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.MSD.BLL.MsdContainer"
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
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/MSD/MsdContainerEdit.aspx?name=Production_MsdContainerAdd&ID=-1";
            dialog({ title: "<%=Resources.Pages.Production_MsdContainerAdd %>", src: openWinUrl, width: 600, height: 400, resizeable: false });
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;

            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/MSD/MsdContainerEdit.aspx?name=Production_MsdContainerEdit&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.Production_MsdContainerEdit %>", src: openWinUrl, width: 600, height: 400, resizeable: false });
        }

        function Delete() {
            var idStr = getDeletingRecordIdString();
            if (idStr == "") return false;
            hdnOperate.val("delete");
            hdnIdString.val(idStr);
            document.forms[0].submit();
        }

        function UpdateList() {
            document.forms[0].submit();
        }    
    </script>
</asp:Content>