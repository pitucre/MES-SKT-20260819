<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" CodeBehind="MslList.aspx.cs" Inherits="SKT.LeanMES.Web.MSD.MslList" %>
<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1">
                湿度等级
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtMSL" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
            </td>            
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" >
        <Columns>
            <asp:BoundField DataField="MSL" HeaderText="湿度等级" SortExpression="MSL" />
            
              <asp:TemplateField HeaderText="系统内置" HeaderStyle-Width="70px" >
                <ItemTemplate>
                    <%#Convert.ToInt32(Eval("MslId"))<0  ? "是" : "否"%>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="FloorLife" HeaderText="暴露时长(小时)"  SortExpression="FloorLife" />
            <asp:BoundField DataField="BakeCount" HeaderText="烘烤次数"  SortExpression="BakeCount" />
            <%--<asp:BoundField DataField="ShelfLife" HeaderText="存储期限(天)" SortExpression="ShelfLife" />--%>
             <asp:BoundField DataField="CreateBy" HeaderText="创建人" HeaderStyle-Width="60px" SortExpression="CreateBy" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="创建时间" HeaderStyle-Width="140px" SortExpression="CreateDateTime" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}"/>
            <asp:BoundField DataField="ModifyBy" HeaderText="修改人" HeaderStyle-Width="60px" SortExpression="ModifyBy" />
            <asp:BoundField DataField="ModifyDateTime" HeaderText="修改时间" HeaderStyle-Width="140px" SortExpression="ModifyDateTime" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}"/>
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.MSD.BLL.Msl"
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
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/MSD/MslEdit.aspx?name=Production_MslAdd&ID=-1";
            dialog({ title: "<%=Resources.Pages.Production_MslAdd %>", src: openWinUrl, width: 600, height: 400, resizeable: false });
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;

            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/MSD/MslEdit.aspx?name=Production_MslEdit&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.Production_MslEdit %>", src: openWinUrl, width: 600, height: 400, resizeable: false });
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
