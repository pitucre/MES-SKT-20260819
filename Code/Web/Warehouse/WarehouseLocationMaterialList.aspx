<%@ Page Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="True"
    CodeBehind="WarehouseLocationMaterialList.aspx.cs" Inherits="SKT.LeanMES.Web.Warehouse.WarehouseLocationMaterialList"
    Title="WarehouseLocationMaterial List Page" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">
                <%= Resources.lang.WarehouseGoodsCode%>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtCBarCode" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label2">
                <%= Resources.lang.ItemCode%>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtItemCode" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" OnRowDataBound="GridView1_RowDataBound">
        <Columns>
            <asp:BoundField DataField="ItemCode" HeaderText="<%$ Resources:lang,ItemCode%>" HeaderStyle-Width="120px" SortExpression="ItemCode" />
            <asp:BoundField DataField="CWhCode" HeaderText="<%$ Resources:lang,WarehouseCode%>" HeaderStyle-Width="120px" SortExpression="CWhCode" />
            <asp:BoundField DataField="CBarCode" HeaderText="<%$ Resources:lang,WarehouseGoodsCode%>" HeaderStyle-Width="120px" SortExpression="CBarCode" />
            <asp:BoundField DataField="CreateBy" HeaderText="<%$ Resources:lang,CreateBy%>" HeaderStyle-Width="60px" SortExpression="CreateBy" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="<%$ Resources:lang,CreateDateTime%>" HeaderStyle-Width="140px" SortExpression="CreateDateTime" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
            <asp:BoundField DataField="ModifyBy" HeaderText="<%$ Resources:lang,ModifyBy%>" HeaderStyle-Width="60px" SortExpression="ModifyBy"  />
            <asp:BoundField DataField="ModifyDateTime" HeaderText="<%$ Resources:lang,ModifyDateTime%>" HeaderStyle-Width="140px" SortExpression="ModifyDateTime" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
            <asp:BoundField DataField="Remark" HeaderText="<%$ Resources:lang,Remark%>" HeaderStyle-Width="200px" SortExpression="Remark"   />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Warehouse.BLL.WarehouseLocationMaterial"
        SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <script type="text/javascript">
        //预定义
        isMultiple = false;
        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");      
        var hdnIdString = $("#hdnIdString");    

        //加载
        $(document).ready(function () {
            //
            $("#<%=this.txtCBarCode.ClientID %>").focus();
            var searchCondition = '<%=Request.Form["searchCondition"] %>';
            if (searchCondition != null && searchCondition != "") {
                $("#searchCondition").val(searchCondition);
            }
            //校验查询栏
            $("#<%= txtCBarCode.ClientID %>").blur(function () {
                CheckSqlSpecialChar("#<%= txtCBarCode.ClientID %>");
            });
            $("#<%= txtItemCode.ClientID %>").blur(function () {
                CheckSqlSpecialChar("#<%= txtItemCode.ClientID %>");
            });
        });

        //新增
        function Add() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Warehouse/WarehouseLocationMaterialEdit.aspx?name=Warehouse_WarehouseLocationMaterialAdd&ID=-1";
            dialog({ title: "<%= Resources.lang.WarehouseLocationMaterialAdd%>", src: openWinUrl, width: 700, height: 400 });
        }
        //修改
        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") {
                return false;
            }
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Warehouse/WarehouseLocationMaterialEdit.aspx?name=Warehouse_WarehouseLocationMaterialEdit&ID=" + idStr;
            dialog({ title: "<%= Resources.lang.WarehouseLocationMaterialEdit%>", src: openWinUrl, width: 700, height: 400 });
        }
        //查询
        function View() {
            var idStr = getOneRecordId();
            if (idStr == "") {
                return false;
            }
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Warehouse/WarehouseLocationMaterialView.aspx?name=Warehouse_WarehouseLocationMaterialView&ID=" + idStr;
            dialog({ title: "<%= Resources.lang.WarehouseLocationMaterialView%>", src: openWinUrl, width: 700, height: 400 });
        }

        function Delete() {
            var idStr = getDeletingRecordIdString();
            if (idStr == "") {
                return false;
            }
            hdnOperate.val("delete");
            hdnIdString.val(idStr);
            document.forms[0].submit();
        }
        //
        function UpdateList(itemCode) {
            $("#<%=this.txtItemCode.ClientID %>").val(itemCode);
            document.forms[0].submit();
        }
    </script>
</asp:Content>
