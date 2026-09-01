<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" CodeBehind="LineEdgeQtyList.aspx.cs" Inherits="SKT.LeanMES.Web.MaterialDelivery.LineEdgeQtyList" %>
 <%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
 <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
    <tr>
            <td class="Label Tips" align="left" colspan="4">
               
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%= Resources.lang.EdgeName %>
            </td>
            <td class="Field1">
                <input type="text" value="" id="txtEdge" class="TextBox" style="width: 250px; height: 25px;" runat="server"/>
                <input type="button" id="btnEdge" class="ButtonBox" value="..." title="" style="height: 27px;"
                    onclick="SelectEdge();" />
            </td>
        </tr>
        <tr>
            <td class="Label1" >
                <%=Resources.lang.SerialNumber%>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtSerialNumber" runat="server" Width="250" Height="25"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
<asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="EdgeName" HeaderText="<%$ Resources:lang, EdgeName %>" />
            <asp:BoundField DataField="SerialNumber" HeaderText="<%$ Resources:lang, SerialNumber %>" />
            <asp:BoundField DataField="BalanceQty" HeaderText="<%$ Resources:lang, LineEdgeBalanceQty %>" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.MaterialDelivery.BLL.EdgeLine"
        SelectMethod="GetLineEdgeList" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <script type="text/javascript"> /*选择线边仓*/
        function SelectEdge() {
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=52&Multiple=false&rnd=" + Math.random(), width: 400, height: 300 });
        }

        function getChooseValue(list) {
            $("#<%=this.txtEdge.ClientID %>").val(list[0][1]);
        }
    </script>
</asp:Content> 