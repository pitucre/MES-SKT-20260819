<%@ Page Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" CodeBehind="MaterialIQCConfigList.aspx.cs" Inherits="SKT.LeanMES.Web.MaterialConfig.MaterialIQCConfigList" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1">
                检验结果
            </td>
            <td class="Field1">
               <asp:TextBox runat="server" ID="txtCheckResult" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" 
        onrowdatabound="GridView1_RowDataBound">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="CheckType" HeaderText="处理方式" />
            <asp:BoundField DataField="MaterialStatus" HeaderText="物料状态" />
            <asp:BoundField DataField="IsGlobal" HeaderText="系统内置" />
            <asp:BoundField DataField="Remark" HeaderText="备注" />
            <asp:BoundField DataField="ModifyBy" HeaderText="<%$ Resources:lang,CreateBy%>"
                SortExpression="ModifyBy"  HeaderStyle-Width="60px" />
            <asp:BoundField DataField="ModifyDateTime" HeaderText="<%$ Resources:lang,CreateDateTime%>"
                SortExpression="ModifyDateTime" HeaderStyle-Width="140px"  DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.MaterialConfig.BLL.MaterialIQCConfig"
        SelectMethod="GetMRB" SelectCountMethod="GetCount">
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
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/MaterialConfig/MaterialIQCConfigEdit.aspx?name=MaterialIQCConfigAdd&ID=-1";
            dialog({ title: "<%=Resources.Pages.MaterialIQCConfigAdd %>", src: openWinUrl, width: 650, height: 400 });
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/MaterialConfig/MaterialIQCConfigEdit.aspx?name=MaterialIQCConfigEdit&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.MaterialIQCConfigEdit %>", src: openWinUrl, width: 600, height: 400 });
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

        function UpdateList(checkResult) {
            $("#<%=this.txtCheckResult.ClientID %>").val(checkResult);
            document.forms[0].submit();
        }
    </script>
</asp:Content>
