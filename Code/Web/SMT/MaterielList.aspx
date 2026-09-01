<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true"
    Inherits="SKT.LeanMES.Web.SMT.MaterielList" CodeBehind="MaterielList.aspx.cs" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">
                <%=Resources.lang.ItemCode %>
            </td>
            <td class="Field2">
                <asp:TextBox ID="schModelNo" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label2">
                <%=Resources.lang.MaterialCode%>
            </td>
            <td class="Field2">
                <asp:TextBox ID="schPartNo" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false">
        <Columns>
            <asp:BoundField DataField="ModelNo" HeaderText="<%$ Resources:lang,ItemCode %>" SortExpression="ModelNo" />
            <asp:BoundField DataField="PartNo" HeaderText="<%$ Resources:lang,MaterialCode %>"
                SortExpression="PartNo" />
            <asp:BoundField DataField="Use_QTY" HeaderText="<%$ Resources:lang,Usage %>" SortExpression="Use_QTY" />
            <asp:BoundField DataField="Location" HeaderText="<%$ Resources:lang,Location %>"
                SortExpression="Location" />
            <asp:BoundField DataField="Station" HeaderText="<%$ Resources:lang,Station %>" SortExpression="Station" />
            <asp:BoundField DataField="Line" HeaderText="<%$ Resources:lang,Line %>" SortExpression="Line" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.SMT.BLL.PreAssemblySetting"
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
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SMT/MaterielEdit.aspx?name=MaterielAdd&ID=-1";
            dialog({ title: "<%=Resources.Pages.MaterielAdd %>", src: openWinUrl, width: 850, height: 480 });
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            //xiang.yan 2024-4-28  列取值由索引改为列明,菜单已无此页面
            // 1 改为 ModelNo
            var modelNo = getOneRecordCellTextByFiled("ModelNo");
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SMT/MaterielEdit.aspx?name=MaterielEdit&ID=" + escape(modelNo) + "";
            dialog({ title: "<%=Resources.Pages.MaterielEdit %>", src: openWinUrl, width: 850, height: 480 });
        }

        function Delete() {
            var idStr = getDeletingRecordIdString();
            if (idStr == "") return false;
            hdnOperate.val("delete");
            hdnIdString.val(idStr);
            document.forms[0].submit();
        }

        function UpdateList(namestr) {
            $("#<%=this.schModelNo.ClientID %>").val(namestr);
            document.forms[0].submit();
        }    
        
    </script>
</asp:Content>
