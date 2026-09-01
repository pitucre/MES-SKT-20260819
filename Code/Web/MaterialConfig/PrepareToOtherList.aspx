<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/ListMaster.master"
     CodeBehind="PrepareToOtherList.aspx.cs" Inherits="SKT.LeanMES.Web.MaterialConfig.PrepareToOtherList" %>


<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1">
                接收地点
            </td>
            <td class="Field1">
                 <asp:TextBox runat="server" ID="txtPrepareTo" CssClass="TextBox"></asp:TextBox>
            </td>

        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" >
        <Columns>
            <asp:BoundField DataField="PrepareDesc" HeaderText="接收地点" SortExpression ="PrepareDesc" />
            <asp:BoundField DataField="Remark" HeaderText="备注" />
             <asp:BoundField DataField="CreateBy" HeaderText="<%$ Resources:lang,CreateBy%>"
                SortExpression="CreateBy"  HeaderStyle-Width="60px" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="<%$ Resources:lang,CreateDateTime%>"
                SortExpression="CreateDateTime" HeaderStyle-Width="140px"  DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
             <asp:BoundField DataField="ModifyBy" HeaderText="<%$ Resources:lang,ModifyBy%>"
                SortExpression="ModifyBy"  HeaderStyle-Width="60px" />
            <asp:BoundField DataField="ModifyDateTime" HeaderText="<%$ Resources:lang,ModifyDateTime%>"
                SortExpression="ModifyDateTime" HeaderStyle-Width="140px"  DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
            
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Material.BLL.PrepareToOther"
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
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/MaterialConfig/PrepareToOtherConfig.aspx?name=PrepareToOtherConfigAdd&ID=-1";
            dialog({ title: mesLang("增加备料接收地点"), src: openWinUrl, width: 650, height: 400 });
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/MaterialConfig/PrepareToOtherConfig.aspx?name=PrepareToOtherConfigEdit&ID=" + idStr;
            dialog({ title: mesLang("编辑备料接收地点"), src: openWinUrl, width: 600, height: 400 });
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
        
        function UpdateList(text) {
            $("#<%=this.txtPrepareTo.ClientID %>").val(text);
            document.forms[0].submit();
        }
    </script>
</asp:Content>