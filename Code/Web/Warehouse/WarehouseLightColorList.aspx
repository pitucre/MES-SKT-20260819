<%@ Page Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="True"
    CodeBehind="WarehouseLightColorList.aspx.cs" Inherits="SKT.LeanMES.Web.Warehouse.WarehouseLightColorList" Title="WarehouseLightColor" %>
<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" Runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1"><%= Resources.lang.WarehouseLocationLightColorfunction%></td>
            <td class="Field1">
                <asp:TextBox ID="txtKeyWords" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
      
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" Runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" OnRowDataBound="GridView1_RowDataBound">
        <Columns>
            <asp:BoundField DataField="FunctionName" HeaderText="<%$ Resources:lang,WarehouseLocationLightColorfunction%>" />
            <asp:BoundField DataField="ColorDescription" HeaderText="<%$ Resources:lang,WarehouseLocationLightColor%>" />
            <asp:BoundField DataField="InUseProdOrderNo" HeaderText="占用单号" />
             <asp:BoundField DataField="CreateBy" HeaderText="<%$ Resources:lang,CreateBy%>"
                SortExpression="CreateBy" HeaderStyle-Width="60px" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="<%$ Resources:lang,CreateDateTime%>"
                SortExpression="CreateDateTime" HeaderStyle-Width="140px" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
            <asp:BoundField DataField="ModifyBy" HeaderText="<%$ Resources:lang,ModifyBy%>"
                SortExpression="ModifyBy" HeaderStyle-Width="60px" />
            <asp:BoundField DataField="ModifyDateTime" HeaderText="<%$ Resources:lang,ModifyDateTime%>"
                SortExpression="ModifyDateTime" HeaderStyle-Width="140px" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" 
        StartRowIndexParameterName="startRow" MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" 
        TypeName="SKT.LeanMES.Warehouse.BLL.WarehouseLightColor" SelectMethod="GetAll" SelectCountMethod="GetCount">
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
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Warehouse/WarehouseLightColorEdit.aspx?name=Warehouse_WarehouseLightColorEdit&ID=-1";
            dialog({ title: "<%= Resources.lang.WarehouseLocationLightColorAdd%>", src: openWinUrl, width: 450, height: 260 });
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Warehouse/WarehouseLightColorEdit.aspx?name=Warehouse_WarehouseLightColorEdit&ID=" + idStr;
            dialog({ title: "<%= Resources.lang.WarehouseLocationLightColorEdit%>", src: openWinUrl, width: 450, height: 260 });
        }

        function Delete() {
            var idStr = getDeletingRecordIdString();
            if (idStr == "") return false;
            hdnOperate.val("delete");
            hdnIdString.val(idStr);
            document.forms[0].submit();
        }

        function Release() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            var prodOrderNo = getOneRecordCellTextByFiled("InUseProdOrderNo");
            if ($.trim(prodOrderNo)) {
                if (confirm("确认要解除占用吗？")) {
                    hdnOperate.val("release");
                    hdnIdString.val(idStr);
                    document.forms[0].submit();
                }
            }
            else {
                alert("解除占用失败，当前未被占用");
            }
        }

        function UpdateList(obj) {
            $("#<%=this.txtKeyWords.ClientID %>").val(obj);
            document.forms[0].submit();
        }   
        </script>
</asp:Content>

