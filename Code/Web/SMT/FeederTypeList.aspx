<%@ Page Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true"
    Inherits="SKT.LeanMES.Web.SMT.FeederTypeList" Title="FeederType List Page" CodeBehind="FeederTypeList.aspx.cs" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1">
                <%=Resources.lang.FeederTypeName%>
            </td>
            <td class="Field1">
                <input type="text" id="txtFeederTypeName" class="TextBox" runat="server" />
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="searchConditions" runat="server" ContentPlaceHolderID="GridviewContent">
    <asp:GridView ID="GridView1" AutoGenerateColumns="false" runat="server" OnRowDataBound="GridView1_RowDataBound">
        <Columns>
            <asp:BoundField DataField="Name" HeaderText="<%$ Resources:lang,FeederTypeName %>"
                HeaderStyle-Width="120px" SortExpression="Name" />
            <asp:BoundField DataField="Size" HeaderText="<%$ Resources:lang,Size %>" HeaderStyle-Width="70px" />
            <asp:BoundField DataField="Pitch" HeaderText="<%$ Resources:lang,Pitch %>" HeaderStyle-Width="70px" />
            <asp:BoundField DataField="Attrition" HeaderText="<%$ Resources:lang,Attrition %>"
                HeaderStyle-Width="60px" />
            <%--<asp:BoundField DataField="CreateBy" HeaderText="<%$ Resources:lang, CreateBy %>" HeaderStyle-Width="120px"/>
            <asp:BoundField DataField="CreateDateTime" HeaderText="<%$ Resources:lang, CreateDateTime %>" HeaderStyle-Width="150px" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}"/>--%>

             <asp:BoundField DataField="ModifyBy" HeaderText="<%$ Resources:lang, ModifyBy %>" HeaderStyle-Width="120px"/>
            <asp:BoundField DataField="ModifyDateTime" HeaderText="<%$ Resources:lang, ModifyDateTime %>" HeaderStyle-Width="150px" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}"/>
            <asp:BoundField DataField="Description" HeaderText="<%$ Resources:lang,Description %>" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.SMT.BLL.FeederType"
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
        //增加 
        function Add() {
            dialog({ title: "<%= Resources.Pages.FeederTypeAdd %>", src: "FeederTypeEdit.aspx?name=FeederTypeAdd&ID=-1", width: 445, height: 350, resizeable: true });
        }
        //编辑
        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return;
            dialog({ title: "<%= Resources.Pages.FeederTypeEdit %>", src: "FeederTypeEdit.aspx?name=FeederTypeEdit&ID=" + idStr, width: 445, height: 350, resizeable: true });
        }
        //查看
        function View() {
            var idStr = getOneRecordId();
            if (idStr == "") return;
            dialog({ title: mesLang("查看飞达类型"), src: "FeederTypeView.aspx?name=FeederTypeView&ID=" + idStr, width: 445, height: 350, resizeable: true });
        }
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

        function UpdateList(ModelName) {
            $("#<%=this.txtFeederTypeName.ClientID %>").val(ModelName);
            document.forms[0].submit();
        }

        function Copy() {
            var idStr = getOneRecordId();
            if (idStr == "") return;
            dialog({ title: "复制飞达类型", src: "FeederTypeEdit.aspx?name=FeederTypeEdit&ID=" + idStr + "&Action=Copy", width: 445, height: 350, resizeable: true });
        }
    </script>
</asp:Content>
