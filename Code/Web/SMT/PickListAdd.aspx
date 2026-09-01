<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PickListAdd.aspx.cs" MasterPageFile="~/Masters/EditMaster.master"
    Inherits="SKT.LeanMES.Web.SMT.PickListAdd" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div class="infoTips" >
        <%=Resources.Messages.WithAsteriskIsRequired %></div>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">
                <%= Resources.lang.FielLoadPath %><em>*</em>
            </td>
            <td class="Field2" style="text-align: left">
                <asp:FileUpload ID="fuPickList" runat="server"   onchange="uploadFile(this.value)"/>
                <asp:LinkButton ID="linkUploadFile" runat="server" OnClick="linkUploadFile_Click"></asp:LinkButton>
            </td>
            <td class="Label2">
                <%= Resources.lang.FullSet%> 
            </td>
            <td class="Field2">
                <asp:CheckBox ID="cbFullSet" runat="server" Checked="true" />
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.ItemsName %><em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtModelName" name="ModelName" runat="server" CssClass="TextBox"
                    Enabled="false" ClientIDMode="Static" Width="64%" isrequired="1"></asp:TextBox>
                <input type="button" id="btnSelectItems" onclick="selectItems(this);" class="ButtonBox" value="..." />
                <asp:HiddenField ID="hdnItemId" runat="server" Value="-1" ClientIDMode="Static" />
                <asp:HiddenField ID="hdnItemName" runat="server" Value="" ClientIDMode="Static" />
            </td>
            <td class="Label2">
                <%= Resources.lang.Revision %>
                <em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtRev" runat="server" CssClass="TextBox"  isrequired="1"></asp:TextBox>
            </td>
        </tr>
       
        <tr>
        <td class="Label2">
                <%= Resources.lang.PickListName %> <em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtPickListName" runat="server"  isrequired="1" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label2">
                <%= Resources.lang.Status %> 
            </td>
            <td class="Field2">
                <asp:DropDownList ID="ddlStatus" ClientIDMode="Static" runat="server">
                </asp:DropDownList>
            </td>
         
        </tr>
        <tr>
            
            <td class="Label2">
                <%= Resources.lang.Remark %>
            </td>
            <td class="Field2" colspan="3">
                <asp:TextBox ID="txtRemark" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <%--<td class="Field1" colspan="2" style="text-align: center">
                <asp:Button ID="BtnUpload" runat="server" Text="<%$Resources:lang,Upload %>"
                    class="AdaptButton" Style="font-weight: bolder; font-size: small;" />
            </td>--%>
            <td class="Field1" colspan="4" style="text-align: center">
                <asp:Button ID="ButSave" runat="server" Text="<%$ Resources:lang,Save %>" OnClientClick="if(SubmitValidation()){return true;}else{return false;}" OnClick="ButSave_Click"
                    class="AdaptButton" />
            </td>
        </tr>
    </table>
    <div style="margin-top: -1px;">
        <asp:GridView ID="GridView1" runat="server" Width="100%" OnRowDataBound="GridView1_RowDataBound">
            <Columns>
                <asp:TemplateField HeaderText="序号" Visible="true"  ItemStyle-HorizontalAlign="Center"></asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
    <script type="text/javascript">
        var errStr = "";

        function selectItems(obj) {
            dialog({ title: "<%= Resources.Common.ChooseWindow %>", src: "<%= SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=1&Multiple=false&rnd=" + Math.random(), width: 680, height: 300 });
        }
        function getChooseValue(list) {
            $("#<%= this.txtModelName.ClientID %>").val(list[0][1]);
            $("#<%= this.hdnItemId.ClientID %>").val(list[0][0]);
            $("#<%= this.hdnItemName.ClientID %>").val(list[0][1]);
        }
     
        function uploadFile(filePath) {
            if (filePath.length > 0) {
                var str = '';
                var postback = $('#<%= linkUploadFile.ClientID %>').attr('href');
                var funcStartIndex = postback.indexOf('\'');
                var funcEndIndex = postback.indexOf('\',');
                if (funcStartIndex != -1 && funcEndIndex != -1) {
                    var str = postback.substring(funcStartIndex + 1, funcEndIndex);
                    __doPostBack(str, '');
                } else {
                    return false;
                }
            }
        }
    </script>
</asp:Content>
