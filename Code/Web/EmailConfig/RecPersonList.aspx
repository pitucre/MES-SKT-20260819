<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RecPersonList.aspx.cs"
    Inherits="SKT.LeanMES.Web.EmailConfig.RecPersonList" MasterPageFile="~/Masters/ListMaster.master" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1">
                <%=Resources.lang.RecPerson%>
            </td>
            <td class="Field1">
                <input type="text" id="txtPersonName" class="TextBox" runat="server" />
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="searchConditions" runat="server" ContentPlaceHolderID="GridviewContent">
    <asp:GridView ID="GridView1" AutoGenerateColumns="false" runat="server">
        <Columns>
            <asp:BoundField DataField="PersonName" HeaderText="<%$ Resources:lang,RecPerson %>"
                HeaderStyle-Width="90px" SortExpression="PersonName" />
            <asp:BoundField DataField="MailAddress" HeaderText="<%$ Resources:lang,EmailAddress %>"
                HeaderStyle-Width="150px" SortExpression="MailAddress" />
            <asp:BoundField DataField="CreateBy" HeaderText="<%$ Resources:lang,CreateBy %>"
                HeaderStyle-Width="90px" SortExpression="CreateBy" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="<%$ Resources:lang,CreateDateTime %>"
                HeaderStyle-Width="150px" SortExpression="CreateDateTime" />
            <asp:BoundField DataField="ModifyBy" HeaderText="<%$ Resources:lang,ModifyBy %>"
                HeaderStyle-Width="90px" SortExpression="ModifyBy" />
            <asp:TemplateField HeaderText="<%$ Resources:lang,ModifyDateTime %>" ItemStyle-Wrap="false"
                SortExpression="ModifyDateTime">
                <ItemTemplate>
                    <%#Eval("ModifyDateTime", "{0:yyyy-MM-dd HH:mm:ss}").ToString().Replace("9999-12-31 00:00:00", "")%>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="Remark" HeaderText="<%$ Resources:lang,Remark %>" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.EmailConfig.BLL.EmailRecPerson"
        SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <script type="text/javascript">
        isMultiple = true;
        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");

        //增加 
        function Add() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/EmailConfig/RecPersonEdit.aspx?name=EmailConfig_RecPersonAdd&Id=-1";
            dialog({ title: "<%= Resources.Pages.EmailConfig_RecPersonAdd %>", src: openWinUrl, width: 500, height: 320, resizeable: false });
        }

        //编辑
        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/EmailConfig/RecPersonEdit.aspx?name=EmailConfig_RecPersonEdit&Id=" + idStr;
            dialog({ title: "<%= Resources.Pages.EmailConfig_RecPersonEdit %>", src: openWinUrl, width: 500, height: 320, resizeable: false });
        }

        //查看
//        function View() {
//            var idStr = getOneRecordId();
//            if (idStr == "") return;
//            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/EmailConfig/RecPersonEdit.aspx?name=EmailConfig_RecPersonEdit&Id=" + idStr;
//            dialog({ title: "<%= Resources.Pages.EmailConfig_RecPersonEdit %>", src: openWinUrl, width: 500, height: 320, resizeable: false });
//        }

        //刷新 
        function refresh() {
            document.forms[0].submit();
        }

        function Delete() {
            var idStr = getDeletingRecordIdString();
            if (idStr == "") return false;
            $(hdnOperate).val("Delete");
            $(hdnIdString).val(idStr);
            document.forms[0].submit();
        }

        function UpdateList(personName) {
            $("#<%=this.txtPersonName.ClientID %>").val(personName);
            document.forms[0].submit();
        }
    </script>
</asp:Content>
