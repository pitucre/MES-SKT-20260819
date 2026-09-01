<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" CodeBehind="MsdBakeList.aspx.cs" Inherits="SKT.LeanMES.Web.MSD.MsdBakeList" %>
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
        <tr>
            <td class="Label3">
                烤箱编码
            </td>
            <td class="Field4">
                <asp:TextBox ID="txtContainerCode" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
            </td>  
              <td class="Label3">
                状态
            </td>
            <td class="Field4">
                   <asp:DropDownList ID="ddlBakeStauts" runat="server">
                    <asp:ListItem Text="全部" Value="" Selected="True"></asp:ListItem>
                    <asp:ListItem Text="已完成" Value="已完成"></asp:ListItem>
                    <asp:ListItem Text="未完成" Value="未完成"></asp:ListItem>
                    <asp:ListItem Text="已超时" Value="已超时"></asp:ListItem>
                </asp:DropDownList>
            </td>            
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" >
        <Columns>
          
            <asp:BoundField DataField="SerialNumber" HeaderText="物料条码"  SortExpression="SerialNumber" />
            <asp:BoundField DataField="ItemCode" HeaderText="物料编码"  SortExpression="ItemCode" />
            <asp:BoundField DataField="ItemName" HeaderText="物料名称"  SortExpression="ItemName" />
             <asp:BoundField DataField="Msl" HeaderText="MSD等级"  SortExpression="Msl" />
            <asp:BoundField DataField="ContainerCode" HeaderText="烤箱编码" SortExpression="ContainerCode" />
 <%--           <asp:BoundField DataField="MinTemp" HeaderText="下限温度℃" SortExpression="MinTemp" />
            <asp:BoundField DataField="MaxTemp" HeaderText="上限温度℃" SortExpression="MaxTemp" />--%>
            <asp:BoundField DataField="Temperature" HeaderText="烘烤温度℃" SortExpression="Temperature" />
<%--            <asp:BoundField DataField="ScanTime" HeaderText="扫描时间" HeaderStyle-Width="140px" SortExpression="ScanTime" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />--%>
            <asp:BoundField DataField="StartBakeTime" HeaderText="开始烘烤时间" HeaderStyle-Width="140px" SortExpression="StartBakeTime" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
            <asp:BoundField DataField="PredictBakeTime" HeaderText="预计完成时间" HeaderStyle-Width="140px" SortExpression="PredictBakeTime" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
            <asp:BoundField DataField="BakeHours" HeaderText="烘烤时长(h)" HeaderStyle-Width="60px"  SortExpression="BakeHours" />
            <asp:BoundField DataField="ActualHours" HeaderText="实际烘烤时长(h)"  HeaderStyle-Width="60px" SortExpression="ActualHours" />
            <asp:BoundField DataField="BakeStauts" HeaderText="烘烤状态" HeaderStyle-Width="40px" SortExpression="BakeStauts" />
            <asp:BoundField DataField="Remark" HeaderText="备注"  SortExpression="Remark" />
            <asp:BoundField DataField="CreateUser" HeaderText="操作人"  SortExpression="CreateUser"  HeaderStyle-Width="60px" />
            <asp:BoundField DataField="ModifyDateTime" HeaderText="操作时间" HeaderStyle-Width="140px" SortExpression="ModifyDateTime" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />             
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.MSD.BLL.MsdBake"
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
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/MSD/MsdBakeEdit.aspx?name=MSD_MsdBakeIn&ID=-1";
            dialog({ title: "<%=Resources.Pages.MSD_MsdBakeIn %>", src: openWinUrl, width: 850, height: 600, resizeable: false });
        }

        function Out() {
        
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/MSD/MsdBakeOut.aspx?name=MSD_MsdBakeOut&ID=-1";
            dialog({ title: "<%=Resources.Pages.MSD_MsdBakeOut %>", src: openWinUrl, width: 800, height: 600, resizeable: false });
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
