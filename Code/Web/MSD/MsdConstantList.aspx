<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" CodeBehind="MsdConstantList.aspx.cs" Inherits="SKT.LeanMES.Web.MSD.MsdConstantList" %>
<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label3">
                物料条码
            </td>
            <td class="Field4">
                <asp:TextBox ID="txtSerialNumber" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
            </td> 
             <td class="Label3">
                物料编码/名称
            </td>
            <td class="Field4">
                <asp:TextBox ID="txtItem" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
            </td>             
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" OnRowDataBound="GridView1_RowDataBound" >
        <Columns>
          
            <asp:BoundField DataField="SerialNumber" HeaderText="物料条码"  SortExpression="SerialNumber" />
              <asp:BoundField DataField="ItemCode" HeaderText="物料编码"  SortExpression="ItemCode" />
             <asp:BoundField DataField="ItemName" HeaderText="物料名称"  SortExpression="ItemSpec" />
            <asp:BoundField DataField="ContainerCode" HeaderText="恒温箱编码" SortExpression="ContainerCode" />
            <asp:BoundField DataField="ContainerName" HeaderText="恒温箱名称" SortExpression="ContainerName" />
            <asp:BoundField DataField="TotalThermostat" HeaderText="累计放入时长(H)" HeaderStyle-Width="140px" SortExpression="TotalThermostat" />
            <asp:BoundField DataField="Tstatus" HeaderText="状态"  SortExpression="Tstatus" />
             <asp:BoundField DataField="CreateUser" HeaderText="操作人"  SortExpression="CreateUser" />
            <asp:BoundField DataField="AddTime" HeaderText="操作时间" HeaderStyle-Width="140px" SortExpression="AddTime"  DataFormatString="{0:yyyy-MM-dd HH:mm:ss}"/>
            <asp:BoundField DataField="ModifyBy" HeaderText="修改人"  SortExpression="ModifyBy" />
            <asp:BoundField DataField="ModifyDateTime" HeaderText="修改时间" HeaderStyle-Width="140px" SortExpression="ModifyDateTime"  DataFormatString="{0:yyyy-MM-dd HH:mm:ss}"/>
                     
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.MSD.BLL.MsdThermostat"
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
        function In() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/MSD/MsdConstantEdit.aspx?name=MSD_MsdConstantIn&ID=-1";
            dialog({ title: "<%=Resources.Pages.MSD_MsdConstantIn %>", src: openWinUrl, width: 850, height: 600, resizeable: false });
        }

        function Out() {
        
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/MSD/MsdConstantOut.aspx?name=MSD_MsdConstantOut&ID=-1";
            dialog({ title: "<%=Resources.Pages.MSD_MsdConstantOut %>", src: openWinUrl, width: 800, height: 600, resizeable: false });
        }

        function Delete() {
            var idStr = getDeletingRecordIdString();
            if (idStr == "") return false;
            hdnOperate.val("delete");
            hdnIdString.val(idStr);
            document.forms[0].submit();
        }
 
        function UpdateList() {           
            document.forms[0].submit();
        }    
    </script>
</asp:Content>
