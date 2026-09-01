<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/ListMaster.master"
    CodeBehind="CustomerProjectList.aspx.cs" Inherits="SKT.LeanMES.Web.Customer.CustomerProjectList" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">
                项目名称
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtProName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label2">
                客户简称
            </td>
            <td class="Field2" width="165px">
                <asp:TextBox ID="txtCustomer" runat="server" CssClass="TextBox" Enabled="false" Text=""></asp:TextBox><input
                    type="button" id="btnSelectCustomer" class="ButtonBox" value="..." title="选择客户"
                    onclick="selectCustomer();" />
                <asp:HiddenField ID="hdnCustomerId" runat="server" Value="-1" />
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false">
        <Columns>
            <asp:BoundField DataField="ProName" HeaderText="项目名称" HeaderStyle-Width="260px" SortExpression="ProName" />
            <asp:BoundField DataField="CustomerName" HeaderText="客户简称" HeaderStyle-Width="260px"
                SortExpression="CustomerName" />
            <asp:BoundField DataField="ProDesc" HeaderText="<%$Resources:lang,Description %>" />
            <asp:BoundField DataField="ModifyBy" HeaderText="修改人" SortExpression="ModifyBy" />
            <asp:BoundField DataField="ModifyDateTime" HeaderText="修改时间" SortExpression="ModifyDateTime" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}"/>
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Customer.BLL.Project"
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

        function Add() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Customer/CustomerProjectEdit.aspx?name=Customer_CustomerProjectAdd&ID=-1";
            dialog({ title: mesLang("添加客户项目"), src: openWinUrl, width: 600, height: 300 });
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Customer/CustomerProjectEdit.aspx?name=Customer_CustomerProjectEdit&ID=" + idStr;
            dialog({ title: mesLang("编辑客户项目"), src: openWinUrl, width: 600, height: 300 });
        }

        function View() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Customer/CustomerProjectView.aspx?name=Customer_CustomerProjectView&ID=" + idStr;
            dialog({ title: mesLang("查看客户项目"), src: openWinUrl, width: 600, height: 300 });
        }

        function Delete() {
            var idStr = getDeletingRecordIdString();
            if (idStr == "") return false;
            hdnOperate.val("delete");
            hdnIdString.val(idStr);
            document.forms[0].submit();
        }

        function UpdateList(namestr, customerId, customerName) {
            $("#<%=this.txtProName.ClientID %>").val(namestr);
            $("#<%=this.txtCustomer.ClientID %>").val(customerName);
            $("#<%=this.hdnCustomerId.ClientID %>").val(customerId);
            document.forms[0].submit();
        }

        function selectCustomer() {
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=10&Multiple=false&rnd=" + Math.random(), width: 600, height: 300 });
        }

        function getChooseValue(list) {
            $("#<%=this.txtCustomer.ClientID %>").val(list[0][1]);
            $("#<%=this.hdnCustomerId.ClientID %>").val(list[0][0]);
        }

        function Copy() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Customer/CustomerProjectEdit.aspx?name=Customer_CustomerProjectEdit&ID=" + idStr+"&Action=Copy";
            dialog({ title:mesLang("复制客户项目"), src: openWinUrl, width: 600, height: 300 });
        }
    </script>
</asp:Content>
