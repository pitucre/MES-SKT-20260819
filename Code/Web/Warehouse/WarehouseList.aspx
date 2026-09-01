<%@ Page Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="True"
    CodeBehind="WarehouseList.aspx.cs" Inherits="SKT.LeanMES.Web.Warehouse.WarehouseList"
    Title="Warehouse List Page" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">
                <%= Resources.lang.WarehouseCode%>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtCodeName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label2">
                <%= Resources.lang.WarehouseName%>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtKeyWords" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" OnRowDataBound="GridView1_RowDataBound">
        <Columns>
            <asp:BoundField DataField="CWhCode" HeaderText="<%$ Resources:lang,WarehouseCode%>" HeaderStyle-Width="120px" SortExpression="CWhCode" />
            <asp:BoundField DataField="CWhName" HeaderText="<%$ Resources:lang,WarehouseName%>" HeaderStyle-Width="120px" SortExpression="CWhName" />
            <asp:BoundField DataField="CDepCode" HeaderText="<%$ Resources:lang,DepartmentName%>" HeaderStyle-Width="120px" SortExpression="CDepCode" />
            <asp:BoundField DataField="CcWhPhone" HeaderText="<%$ Resources:lang,Telephone%>" HeaderStyle-Width="120px" SortExpression="CcWhPhone" />
            <asp:BoundField DataField="CWhPerson" HeaderText="<%$ Resources:lang,Principal%>" HeaderStyle-Width="80px" SortExpression="CWhPerson" />
            <asp:BoundField DataField="IWHProperty" HeaderText="<%$ Resources:lang,WarehouseAttributes%>" HeaderStyle-Width="60px" SortExpression="IWHProperty"  />
            <asp:BoundField DataField="CWhAddress" HeaderText="<%$ Resources:lang,WarehouseAddress%>" SortExpression="CWhAddress" />
            <asp:BoundField DataField="CreateBy" HeaderText="<%$ Resources:lang,CreateBy%>" SortExpression="CreateBy"  HeaderStyle-Width="60px" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="<%$ Resources:lang,CreateDateTime%>" SortExpression="CreateDateTime" HeaderStyle-Width="140px"  DataFormatString="{0:yyyy-MM-dd HH:mm:ss}"  />
            <asp:BoundField DataField="ModifyBy" HeaderText="<%$ Resources:lang,ModifyBy%>" SortExpression="CreateBy"  HeaderStyle-Width="60px" />
            <asp:BoundField DataField="ModifyDateTime" HeaderText="<%$ Resources:lang,ModifyDateTime%>" SortExpression="CreateDateTime" HeaderStyle-Width="140px"  DataFormatString="{0:yyyy-MM-dd HH:mm:ss}"  />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Warehouse.BLL.Warehouse"
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

        $(document).ready(function () {
            $("#<%=this.txtKeyWords.ClientID %>").focus();
            var searchCondition = '<%=Request.Form["searchCondition"] %>';
            if (searchCondition != null && searchCondition != "") {
                $("#searchCondition").val(searchCondition);
            }
            $("#<%= txtCodeName.ClientID %>").blur(function () {
                CheckSqlSpecialChar("#<%= txtCodeName.ClientID %>");
            });
            $("#<%= txtKeyWords.ClientID %>").blur(function () {
                CheckSqlSpecialChar("#<%= txtKeyWords.ClientID %>");
            });
        });

        function CheckSqlSpecialChar(obj) {
            var re = "'|*|%|; |-|+|,|=|@";
            var charArr = re.split("|");
            for (i = 0; i < charArr.length; i++) {
                if ($(obj).val().indexOf(charArr[i]) >= 0) {
                    
                    $(obj).val("");
                    $(obj).focus();
                }
            }
        }

        function Add() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Warehouse/WarehouseEdit.aspx?name=Warehouse_WarehouseAdd&ID=-1";
            dialog({ title: "<%= Resources.lang.WarehouseListAdd%>", src: openWinUrl, width: 700, height: 400 });
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") {
                return false;
            }
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Warehouse/WarehouseEdit.aspx?name=Warehouse_WarehouseEdit&ID=" + idStr;
            dialog({ title: "<%= Resources.lang.WarehouseListEdit%>", src: openWinUrl, width: 700, height: 400 });
        }

        function View() {
            var idStr = getOneRecordId();
            if (idStr == "") {
                return false;
            }
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Warehouse/WarehouseView.aspx?name=Warehouse_WarehouseView&ID=" + idStr;
            dialog({ title: "<%= Resources.lang.WarehouseListView%>", src: openWinUrl, width: 700, height: 400 });
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

        function UpdateList(namestr) {
            $("#<%=this.txtKeyWords.ClientID %>").val(namestr);
            document.forms[0].submit();
        }
    </script>
</asp:Content>
