<%@ Page Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="True"
    Codebehind="ESOPFileList.aspx.cs" Inherits="SKT.LeanMES.Web.Product.ESOPFileList" Title="ESOPFile List Page" %>
<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" Runat="Server" >
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2"><%=Resources.lang.ItemsName %></td>
            <td class="Field2">
               <asp:TextBox ID="txtItem" runat="server" CssClass="TextBox" IsRequired='1'></asp:TextBox>
               <input type="button" id="btnSelectItem" class="ButtonBox" value="..." title="<%=Resources.lang.ChooseItem %>"
                  onclick="selectItem(1);" />
                <asp:HiddenField ID="hdnItemId" runat="server" Value="-1" />
            </td>
            <td class="Label2"><%=Resources.lang.AC_Operation%></td>
            <td class="Field2">
               <asp:TextBox ID="txtAssOperationName" runat="server" CssClass="TextBox" ></asp:TextBox>
               <input type="button" id="Button1" class="ButtonBox" value="..." title="<%=Resources.lang.ChooseOperation %>" onclick="selectItem(8);" />
               <asp:HiddenField ID="hdnAssOperationID" runat="server" Value="-1" />
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" Runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1">
        <Columns>
            <%-- To Do --%>
            <asp:HyperLinkField  DataTextField="ESOPFileName" DataNavigateUrlFields="ESOPFileName"  DataNavigateUrlFormatString="DownLoad.aspx?fileName={0}" 
   HeaderText="<%$Resources:lang, File%>"/>
            <asp:BoundField DataField="ItemName" HeaderText="<%$Resources:lang, ItemsName%>" />
            <asp:BoundField DataField="Station" HeaderText="<%$Resources:lang, AC_Operation%>"/>
            <asp:BoundField DataField="IsCurrent_CN" HeaderText="<%$Resources:lang, IsCurrentRev%>" />
            <asp:BoundField DataField="IsVideo_CN" HeaderText="<%$Resources:lang, IsVideo%>" />
            <asp:BoundField DataField="CreateDate" HeaderText="<%$Resources:lang, UploadTime%>" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" 
        StartRowIndexParameterName="startRow" MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" 
        TypeName="SKT.LeanMES.ESOP.BLL.ESOPFile" SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value=""/>
    <input type="hidden" id="hdnIdString" name="hdnIdString"  value=""/>

    <script type="text/javascript">
        isMultiple = false;
        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");
        function Add() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/ESOP/ESOPFileEdit.aspx?name=Production_ESOPFileAdd&ID=-1";
            dialog({ title: "<%=Resources.Pages.Production_ESOPFileAdd%>", src: openWinUrl, width: 650, height: 400 });
        }

        function Delete() {
            var idStr = getDeletingRecordIdString();
            if (idStr == "") return false;
            hdnOperate.val("delete");
            hdnIdString.val(idStr);
            document.forms[0].submit();
        }

        function UpdateList(namestr) {
            $("#txtBomName").val(namestr);
            document.forms[0].submit();
        }

        var chooseFlag = 0;

        function selectItem(i) {
            chooseFlag = i;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=" + i.toString() + "&Multiple=false&rnd=" + Math.random(), width: 550, height: 280 });
        }

        function getChooseValue(list) {
            if (chooseFlag == 2) {
            }
            else if (chooseFlag == 1) {
                $("#<%=this.txtItem.ClientID %>").val(list[0][1] + "(" + list[0][2] + ")");
                $("#<%=this.hdnItemId.ClientID %>").val(list[0][0]);
            }
            else if (chooseFlag == 8) {
                $("#<%=this.txtAssOperationName.ClientID %>").val(list[0][1] + "(" + list[0][2] + ")");
                $("#<%=this.hdnAssOperationID.ClientID %>").val(list[0][0]);
            }
        }

        function UpdateList(namestr, station) {
            $("#<%=this.txtItem.ClientID %>").val(namestr);
            $("#<%=this.txtAssOperationName.ClientID %>").val(station);

            document.forms[0].submit();
        }

        </script>
</asp:Content>

