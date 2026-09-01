<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ChooseListMaster.master" AutoEventWireup="true" CodeBehind="ResourcePreItem.aspx.cs" Inherits="SKT.LeanMES.Web.Plan.ResourcePreItem" %>
<%@ Import Namespace="Resources" %>
<%@ MasterType VirtualPath="~/Masters/ChooseListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
<table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">
                <%= Resources.lang.ResName %>
            </td>
            <td class="Field2">
              <asp:TextBox ID="txtResName" runat="server" CssClass="TextBox" Width="80%"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
    <asp:GridView ID="GridView1" AutoGenerateColumns="false" runat="server" DataSourceID="ObjectDataSource1">
        <Columns>
               <asp:BoundField DataField="ResName" HeaderText="<%$Resources:lang,ResName %>" HeaderStyle-Width="200px"
                SortExpression="ResName" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Resource.BLL.Resource"
        SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="search"/>
    <input type="hidden" id="hdnIdString" name="hdnIdString" value=""/>
    <script type="text/javascript">
        isMultiple = false;

        $(function () {
           
            $(".ListTableHeader").find("th")[0].width = 15;
        });
        function clk(obj) {
           
            if (isChkClk) {
                isChkClk = false;
                return;
            }
            if (isDblClick) {
                isDblClick = false;
                return;
            }
            var chk = obj.cells[0].children[0];

            if (isMultiple)
                chk.checked = !chk.checked;
            else
                chk.checked = !chk.checked;
            //var chk = $(obj).find("td:eq(0) input[type='checkbox']");
           
            //if (isMultiple)
            //    chk.attr("checked", !chk.is(':checked'));
            //else
            //    chk.attr("checked", !chk.is(':checked'));
            operateRow(obj);
            //alert($(obj).find("td:eq(0) input[type='checkbox']").is(':checked'));
            parent.window.UpdateList(obj);
        }

        function chkClk(obj){
            $(obj).parent().parent().click();
        }

       
    </script>
</asp:Content>

