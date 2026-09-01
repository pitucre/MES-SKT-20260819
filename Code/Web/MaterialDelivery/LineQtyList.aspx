<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" CodeBehind="LineQtyList.aspx.cs" Inherits="SKT.LeanMES.Web.MaterialDelivery.LineQtyList" %>
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
                <%= Resources.lang.LineName %>
            </td>
            <td class="Field1">
                <input type="text" value="" id="txtLine" class="TextBox" style="width: 250px; height: 25px;" runat="server" />
                <input type="button" id="btnLine" class="ButtonBox" value="..." title="" style="height: 27px;"
                    onclick="SelectLine();" />
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
            <asp:BoundField DataField="LineName" HeaderText="<%$ Resources:lang, LineName %>" />
            <asp:BoundField DataField="SerialNumber" HeaderText="<%$ Resources:lang, SerialNumber %>" />
            <asp:BoundField DataField="BalanceQty" HeaderText="<%$ Resources:lang, LineBalanceQty %>" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Resource.BLL.Line"
        SelectMethod="GetLineList" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <script type="text/javascript">        /*选择线边仓*/
        function SelectLine() {
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=21&Multiple=false&rnd=" + Math.random(), width: 400, height: 300 });
        }

        function getChooseValue(list) {
            $("#<%=this.txtLine.ClientID %>").val(list[0][1]);
        }
    </script>
</asp:Content>
 