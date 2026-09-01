<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true"
    Inherits="SKT.MES.Web.BasalData.DataTypeList" ViewStateMode="Disabled" CodeBehind="DataTypeList.aspx.cs" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">
                <%=Resources.lang.DTCategory%>
            </td>
            <td class="Field2">
                <asp:DropDownList ID="ddlCat" runat="server">
                    <asp:ListItem></asp:ListItem>
                    <asp:ListItem>Assembly</asp:ListItem>
                    <asp:ListItem>NC</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td class="Label2">
                <%=Resources.lang.DTName %>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" AutoGenerateColumns="false" runat="server" OnRowDataBound="GridView1_RowDataBound">
        <Columns>
            <asp:BoundField DataField="Category" HeaderText="<%$ Resources:lang,DTCategory %>"
                HeaderStyle-Width="120px" SortExpression="Category" />
            <asp:BoundField DataField="DataTypeName" HeaderText="<%$ Resources:lang,DTName %>"
                HeaderStyle-Width="150px" SortExpression="DataTypeName" />
            <asp:BoundField DataField="ValidationActivity" HeaderText="<%$ Resources:lang,ValidationActivity %>"
                HeaderStyle-Width="150px" />
            <asp:BoundField DataField="CreateBy" HeaderText="<%$ Resources:lang, CreateBy %>" HeaderStyle-Width="120"/>
            <asp:BoundField DataField="CreateDateTime" HeaderText="<%$ Resources:lang, CreateDateTime %>" HeaderStyle-Width="150" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}"/>
            <asp:BoundField DataField="ModifyBy" HeaderText="<%$ Resources:lang, ModifyBy %>" HeaderStyle-Width="120"/>
            <asp:BoundField DataField="ModifyDateTime" HeaderText="<%$ Resources:lang, ModifyDateTime %>" HeaderStyle-Width="150" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}"/>
            <asp:BoundField DataField="Description" HeaderText="<%$ Resources:lang,Description %>" />            
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.DataType.BLL.DataType"
        SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <script language="javascript" type="text/javascript">
        isMultiple = false;
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");
        //增加 
        function Add() {
            dialog({ title: "<%= Resources.Pages.DataTypeAdd %>", src: "DataTypeEdit.aspx?name=DataTypeAdd&ID=-1", width: 730, height: 420, resizeable: true });
        }

        //编辑
        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return;
            dialog({ title: "<%= Resources.Pages.DataTypeEdit %>", src: "DataTypeEdit.aspx?name=DataTypeEdit&ID=" + idStr, width: 730, height: 420, resizeable: true });
        }

        //删除
        function Delete() {
            var idStr = getDeletingRecordIdString();
            if (idStr == "") return false;
            hdnOperate.val("delete");
            hdnIdString.val(idStr);
            document.forms[0].submit();
        }
        function UpdateList(namestr) {
            $("#<%=this.txtName.ClientID %>").val(namestr);
            document.forms[0].submit();
        }

        function Copy() {
            var idStr = getOneRecordId();
            if (idStr == "") return;
            dialog({ title: "<%= Resources.Pages.DataTypeEdit %>", src: "DataTypeEdit.aspx?name=DataTypeEdit&ID=" + idStr + "&Action=Copy&rnd=" + Math.random(), width: 730, height: 420, resizeable: true });
        }
    </script>
</asp:Content>
