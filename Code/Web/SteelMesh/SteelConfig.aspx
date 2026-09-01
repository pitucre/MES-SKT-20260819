<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" CodeBehind="SteelConfig.aspx.cs" 
    Inherits="SKT.LeanMES.Web.SteelMesh.SteelConfig" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1">
                配置项
            </td>
            <td class="Field1">
                <asp:DropDownList runat="server" ID="ddlConfigType">
                    <asp:ListItem Value="">请选择</asp:ListItem>
                    <asp:ListItem Value="IsSteelNetInStock">钢网出入库</asp:ListItem>
                    <asp:ListItem Value="IsDrawKnifeInStock">刮刀出入库</asp:ListItem>
                    <asp:ListItem Value="IsSteelNetNeedClear">钢网清洗</asp:ListItem>
                    <asp:ListItem Value="IsDrawKnifeNeedClear">刮刀清洗</asp:ListItem>
                   <%-- <asp:ListItem Value="IsNeedCheckSteelNet">投入站检查钢网</asp:ListItem>
                    <asp:ListItem Value="IsNeedCheckDrawKnife">投入站检查刮刀</asp:ListItem>--%>
                    <asp:ListItem Value="IsDrawKnifeJoinProd">刮刀匹配机种</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" OnRowDataBound="GridView1_RowDataBound">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="SteelConfig" HeaderText="配置项" />
            <asp:BoundField DataField="Result" HeaderText="配置结果" />
            <asp:BoundField DataField="IsGlobal" HeaderText="系统内置" />
            <asp:BoundField DataField="ModifyBy" HeaderText="修改人" HeaderStyle-Width="60px" />
            <asp:BoundField DataField="ModifyDate" HeaderText="修改时间" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" HeaderStyle-Width="140px" />
            <asp:BoundField DataField="Remark" HeaderText="备注" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.SteelMesh.BLL.SteelMesh"
        SelectMethod="GetSteelConfig" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <script type="text/javascript">
        var temp = 0;
        isMultiple = false;
        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SteelMesh/SteelConfigEdit.aspx?name=SteelConfigEdit&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.SteelConfigEdit %>", src: openWinUrl, width: 600, height: 330 });
        }

        function View() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SteelMesh/SteelConfigView.aspx?name=SteelConfigView&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.SteelConfigView %>", src: openWinUrl, width: 600, height: 330 });
        }

        function Refresh() {
            document.forms[0].submit();
        }
    </script>
</asp:Content>
