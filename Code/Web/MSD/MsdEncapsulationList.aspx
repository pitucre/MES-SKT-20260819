<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" CodeBehind="MsdEncapsulationList.aspx.cs" Inherits="SKT.LeanMES.Web.MSD.MsdEncapsulationList" %>
<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label3">
                物料条码
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtSerialNumber" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
            </td>  
            <td class="Label3">
                物料编码/名称
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtItem" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
            </td>  
            <td class="Label3">
                状态
            </td>
            <td class="Field3">
                 <asp:DropDownList ID="selEncapStatus" runat="server">
                    <asp:ListItem Text="全部" Value=""></asp:ListItem>
                    <asp:ListItem Text="已开封" Value="已开封"></asp:ListItem>
                    <asp:ListItem Text="已封装" Value="已封装"></asp:ListItem>
                     <asp:ListItem Text="恒温箱" Value="恒温箱"></asp:ListItem>
                    <asp:ListItem Text="烘烤箱" Value="烘烤箱"></asp:ListItem>
                </asp:DropDownList>
               
            </td>            
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" >
        <Columns>
          
            <asp:BoundField DataField="SerialNumber" HeaderText="物料条码"  SortExpression="SerialNumber" />
           
            <asp:BoundField DataField="ItemCode" HeaderText="物料编码" SortExpression="ItemCode" />
            <asp:BoundField DataField="ItemName" HeaderText="物料名称"  SortExpression="ItemSpec" />
         <%--<asp:BoundField DataField="ItemSpec" HeaderText="物料规格"  SortExpression="ItemSpec" />--%>
            <asp:BoundField DataField="StartExposeTime" HeaderText="开始暴露时间" HeaderStyle-Width="140px" SortExpression="StartExposeTime"  DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
           <asp:BoundField DataField="TotalExposeMinute" HeaderText="累计暴露时间(H)" HeaderStyle-Width="60px"  SortExpression="TotalExposeMinute" />
            <asp:BoundField DataField="FloorLife" HeaderText="允许暴露时长(H)"  HeaderStyle-Width="60px" SortExpression="FloorLife" />
            
            <asp:BoundField DataField="EncapStatus" HeaderText="状态" HeaderStyle-Width="40px" SortExpression="EncapStatus" />
             <asp:BoundField DataField="CreateUser" HeaderText="操作人"  SortExpression="CreateUser"  HeaderStyle-Width="60px" />
              <asp:BoundField DataField="ModifyDateTime" HeaderText="操作时间" HeaderStyle-Width="140px"  SortExpression="ModifyDateTime"  DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
           
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.MSD.BLL.MsdEncapsulation"
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
            dialog({ title: "<%=Resources.Pages.MSD_MsdBakeIn %>", src: openWinUrl, width: 800, height: 600, resizeable: false });
        }

        function Out() {
        
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/MSD/MsdBakeOut.aspx?name=Production_MslEdit&ID=-1" ;
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
