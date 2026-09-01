<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ChooseListMaster.master" AutoEventWireup="true" CodeBehind="StationMatInList.aspx.cs" Inherits="SKT.LeanMES.Web.Product.StationMatInList" %>
    <%@ MasterType VirtualPath="~/Masters/ChooseListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
    <%--查询模块--%>
   <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1">
                工序名称
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtStation" runat="server" CssClass="TextBox"  ClientIDMode="Static"></asp:TextBox><input
                    type="button" id="btnSelectItem" class="ButtonBox" value="..." title="<%=Resources.lang.ChooseItem %>"
                    onclick="selectItem(8);" />              
                <asp:HiddenField ID="hdnStationId" runat="server" Value="-1" ClientIDMode="Static" />
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
<asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" >
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="Station" HeaderText="工序名称" SortExpression="Station" />
            <asp:BoundField DataField="ItemCode" HeaderText="物料编码"
                HeaderStyle-Width="60px" SortExpression="ItemCode" />
            <asp:BoundField DataField="ItemName" HeaderText="物料描述"
                SortExpression="ItemName" />
            <asp:BoundField DataField="CategoryOne" HeaderText="物料大类"
                SortExpression="CategoryOne" />
            <asp:BoundField DataField="CategoryTwo" HeaderText="物料中类"
                SortExpression="CategoryTwo" />
            <asp:BoundField DataField="CategoryThree" HeaderText="物料小类"
                SortExpression="CategoryThree" /> 
        </Columns>
    </asp:GridView>
     <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Product.BLL.StationMateriel"
        SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
     

    <script type="text/javascript">
        isMultiple = true;
        var stationId = $("#<%=this.hdnStationId.ClientID %>").val();
        var categoryOne = '<%=Request.QueryString["cone"] %>';
        var categoryTwo = '<%=Request.QueryString["ctwo"] %>';
        var categoryThree = '<%=Request.QueryString["cthree"] %>';

        function selectItem(i) {
            chooseFlag = i;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=" + i.toString() + "&Multiple=false&rnd=" + Math.random(), width: 550, height: 280 });
        }

        function getChooseValue(list) {
            if (chooseFlag == 8) {
                $("#<%=this.txtStation.ClientID %>").val(list[0][1]);
                $("#<%=this.hdnStationId.ClientID %>").val(list[0][0]);
                stationId = list[0][0];
                window.parent.document.getElementById("frmMatChooseList").src = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + '/Product/StationMatPreList.aspx?ID=<%= Request.QueryString["ID"] %>&StationId=' + stationId + '&cone=' + categoryOne + '&ctwo=' + categoryTwo + '&cthree=' + categoryThree;
            }
        }
    </script>
    </asp:Content>