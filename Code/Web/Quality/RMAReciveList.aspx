<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" CodeBehind="RMAReciveList.aspx.cs" Inherits="SKT.LeanMES.Web.Quality.RMAReciveList" %>
<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">
                RMA编号
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtRMANO" runat="server"></asp:TextBox>
            </td>
             <td class="Label2">
                产品编码
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtItemCode" runat="server"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" OnRowDataBound="GridView1_RowDataBound">
        <Columns>
            <asp:BoundField DataField="RmaNo" HeaderText="RMA编号" />
            <asp:BoundField DataField="Status" HeaderText="状态" />
            <asp:BoundField DataField="MachineTypeName" HeaderText="产品名称" />
            <asp:BoundField DataField="ItemCode" HeaderText="产品编码" />
            <asp:BoundField DataField="ItemSpec" HeaderText="产品规格" />
            <asp:BoundField DataField="CustomerName" HeaderText="客户" />
            <asp:BoundField DataField="Number" HeaderText="申请数量" />
            <asp:BoundField DataField="CancelTime" HeaderText="退回时间"  DataFormatString="{0:yyyy-MM-dd HH:mm:ss}"/>
            <asp:BoundField DataField="CreateBy" HeaderText="创建人" HeaderStyle-Width="120px" />  
            <asp:BoundField DataField="CreateTime" HeaderText="创建时间" HeaderStyle-Width="180px"  DataFormatString="{0:yyyy-MM-dd HH:mm:ss}"/>    
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Quality.BLL.Rma"
        SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <script type="text/javascript">
        isMultiple = false;
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");        

        function Manage() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Quality/RMAReciveManage.aspx?name=RMAReciveManage&ID=" + idStr;
            dialog({ title: mesLang("接收"), src: openWinUrl, width: 830, height: 500 });
        }

        function View() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;

            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Quality/RMAReciveView.aspx?name=RMAReciveView&ID=" + idStr;
            dialog({ title: mesLang("查看"), src: openWinUrl, width: 830, height: 500 });
        }

        function Refresh() {
            document.forms[0].submit();
        }
    </script>
</asp:Content>
