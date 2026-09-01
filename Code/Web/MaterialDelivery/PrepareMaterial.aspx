<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PrepareMaterial.aspx.cs" Inherits="SKT.LeanMES.Web.MaterialDelivery.PrepareMaterial" MasterPageFile="~/Masters/ListMaster.master"%>
<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>

<asp:Content ContentPlaceHolderID="SearchContent" runat="server">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">
                <%//=Resources.lang.TurnoverTypeName%>工单号码
            </td>
            <td class="Field2">
                <input type="text" id="txtProdOrderNO" class="TextBox" runat="server"/>
            </td>
            <td class="Label2">
                <%//=Resources.lang.TurnoverTypeName%>产品编码
            </td>
            <td class="Field2">
                <input type="text" id="txtProductCode" class="TextBox" runat="server"/>
<%--                <input type="button" class="ButtonBox" value="..." onclick="choosepage(2)"/>--%>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%//=Resources.lang.TurnoverTypeName%>工艺段
            </td>
            <td class="Field2">
                <input type="text" id="txtSectionCode" class="TextBox" runat="server"/>
            </td>
            <td class="Label2">
                <%//=Resources.lang.TurnoverTypeName%>需求日期
            </td>
            <td class="Field2">
                <input type="text" id="txtRequestDate" class="DateTimeBox" runat="server"/>
            </td>
        </tr>
    </table>
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="GridviewContent" runat="server">
    <asp:GridView ID="GridView1" AutoGenerateColumns="false" runat="server" >
        <Columns>
            <asp:BoundField DataField="PrepareNO" HeaderText="<%$ Resources:lang,PrepareNO %>" ItemStyle-Width="150px" />
<%--            <asp:BoundField DataField="ProdOrderNO" HeaderText="<%$ Resources:lang,ShopOrder %>" ItemStyle-Width="150px" />--%>
            <asp:BoundField DataField="SectionNO" HeaderText="<%$ Resources:lang,SectionNO %>" ItemStyle-Width="150px" />
            <asp:BoundField DataField="ProductCode" HeaderText="<%$ Resources:lang,ProductCode %>" ItemStyle-Width="150px" />
            <asp:BoundField DataField="RequestQty" HeaderText="<%$ Resources:lang,AC_Quantity %>" ItemStyle-Width="90px" />
            <asp:BoundField DataField="RequestDate" HeaderText="<%$ Resources:lang,RequestDate %>" ItemStyle-Width="160px" />
            <%--<asp:BoundField DataField="Status" HeaderText="<%$ Resources:lang,Status %>" ItemStyle-Width="90px" />--%>
            <asp:BoundField DataField="CreateBy" HeaderText="<%$ Resources:lang,CreateBy %>" ItemStyle-Width="100px" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="<%$ Resources:lang,CreateDateTime %>" ItemStyle-Width="160px" />
            <asp:BoundField DataField="GetPerson" HeaderText="<%$ Resources:lang,GetPerson %>" ItemStyle-Width="100px" />
            <asp:BoundField DataField="GetDateTime" HeaderText="<%$ Resources:lang,GetDateTime %>" ItemStyle-Width="160px" />
<%--            <asp:BoundField DataField="ModifyBy" HeaderText="<%$ Resources:lang,ModifyBy %>" ItemStyle-Width="100px" />
            <asp:BoundField DataField="ModifyDateTime" HeaderText="<%$ Resources:lang,ModifyDateTime %>" ItemStyle-Width="150px" />--%>
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.MaterialDelivery.BLL.MaterialPrepare"
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

        var user = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";

        //查看当前备料明细
        function ViewDetail() {
            var idStr = getOneRecordId();
            if (idStr == "") return;

            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/MaterialDelivery/PrepareMaterialDetail.aspx?name=MaterialDelivery_PrepareMaterialDetail&Id=" + idStr;
            dialog({ title: "<%= Resources.Pages.MaterialDelivery_PrepareMaterialDetail %>", src: openWinUrl, width: 800, height: 500, resizeable: false });
        }



        //查看变更明细
        function ViewChangeDetail() {
            var idStr = getOneRecordId();
            if (idStr == "") return;

            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/MaterialDelivery/PrepareMaterialDetail.aspx?name=MaterialDelivery_PrepareMaterialDetail&Id=" + idStr + "&c=1";
            dialog({ title: "<%= Resources.Pages.MaterialDelivery_PrepareMaterialDetail %>", src: openWinUrl, width: 1000, height: 500, resizeable: false });
        }

    </script>
</asp:Content>
