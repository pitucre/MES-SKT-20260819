<%@ Page Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="True"
    CodeBehind="WarehouseAGVMarkList.aspx.cs" Inherits="SKT.LeanMES.Web.Warehouse.WarehouseAGVMarkList"
    Title="WarehouseAGVMarkList List Page" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label3">AGV区域名称
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtAGVAreaName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">AGV地标码
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtAGVLandMarkCode" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">创建人
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtCreateBy" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label3">修改人
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtModifyBy" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">状态
            </td>
            <td class="Field3">
                <asp:DropDownList ID="ddlStatus" runat="server">
                    <asp:ListItem Value="-2">请选择</asp:ListItem>
                    <asp:ListItem Value="0">空闲</asp:ListItem>
                    <asp:ListItem Value="1">占用</asp:ListItem>
                    <asp:ListItem Value="2">停用</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td class="Label3"></td>
            <td class="Field3"></td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" OnRowDataBound="GridView1_RowDataBound">
        <Columns>
            <asp:BoundField DataField="AGVAreaName" HeaderText="AGV区域名称" HeaderStyle-Width="120px" />
            <asp:BoundField DataField="AGVLandMarkCode" HeaderText="AGV地标码" HeaderStyle-Width="120px" />
            <asp:BoundField DataField="AGVLandMarkCodeSort" HeaderText="地标码顺序" HeaderStyle-Width="120px" SortExpression="AGVLandMarkCodeSort" />
            <asp:BoundField DataField="Remark" HeaderText="备注" HeaderStyle-Width="120px"/>
            <asp:BoundField DataField="StatueName" HeaderText="状态" HeaderStyle-Width="80px" />
            <asp:BoundField DataField="CreateBy" HeaderText="<%$ Resources:lang,CreateBy%>" SortExpression="CreateBy" HeaderStyle-Width="60px" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="<%$ Resources:lang,CreateDateTime%>" SortExpression="CreateDateTime" HeaderStyle-Width="140px" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
            <asp:BoundField DataField="ModifyBy" HeaderText="<%$ Resources:lang,ModifyBy%>" SortExpression="CreateBy" HeaderStyle-Width="60px" />
            <asp:BoundField DataField="ModifyDateTime" HeaderText="<%$ Resources:lang,ModifyDateTime%>" SortExpression="CreateDateTime" HeaderStyle-Width="140px" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Warehouse.BLL.WarehouseAGVMark"
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
           
        });


        function Add() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Warehouse/WarehouseAGVMarkEdit.aspx?name=Warehouse_WarehouseAGVMarkAdd&ID=-1";
            dialog({ title: "新增AVG地标码", src: openWinUrl, width: 700, height: 400 });
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") {
                return false;
            }
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Warehouse/WarehouseAGVMarkEdit.aspx?name=Warehouse_WarehouseAGVMarkEdit&ID=" + idStr;
            dialog({ title: "编辑新增AVG地标码", src: openWinUrl, width: 700, height: 400 });
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


        function Release() {
            var idStr = getRecordIdString();
            if (idStr == "") {
                return false;
            }
            hdnOperate.val("update");
            hdnIdString.val(idStr);
            document.forms[0].submit();
        }

        function UpdateList(namestr) {
            $("#<%=this.txtAGVLandMarkCode.ClientID %>").val(namestr);
            document.forms[0].submit();
        }
    </script>
</asp:Content>
