<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" CodeBehind="MsdOperationList.aspx.cs" Inherits="SKT.LeanMES.Web.MSD.MsdOperationList" %>
<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
             <td class="Label2">
                <%= Resources.lang.StartTime%>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtStartTime" runat="server"  CssClass="DateTimeBox"></asp:TextBox>
            </td>
             <td class="Label2">
                <%= Resources.lang.EndTime%>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtEndTime"  runat="server"  CssClass="DateTimeBox"></asp:TextBox>
            </td>
        </tr>
        <tr>
             <td class="Label2">
                物料编码/名称
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtItem" runat="server"  ></asp:TextBox>
            </td>
            <td class="Label2">
                物料条码
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtSerialNumber" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
            </td>            
        </tr>
         <tr>
             <td class="Label2">
              操作动作 
            </td>
            <td class="Field2" colspan="3">
                <asp:DropDownList ID="selOperateDes" runat="server">
                    <asp:ListItem Text="全部" Value=""></asp:ListItem>
                    <asp:ListItem Text="开封物料" Value="开封物料"></asp:ListItem>
                    <asp:ListItem Text="封装物料" Value="封装物料"></asp:ListItem>
                     <asp:ListItem Text="放入恒温箱" Value="放入恒温箱"></asp:ListItem>
                    <asp:ListItem Text="拿出恒温箱" Value="拿出恒温箱"></asp:ListItem>
                    <asp:ListItem Text="入炉烘烤" Value="入炉烘烤"></asp:ListItem>
                    <asp:ListItem Text="物料出炉" Value="物料出炉"></asp:ListItem>
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
            <asp:BoundField DataField="OperateDes" HeaderText="操作动作" HeaderStyle-Width="140px" SortExpression="OperateDes" />
           <asp:BoundField DataField="ContainerCode" HeaderText="容器编码"   SortExpression="ContainerCode" />
            <asp:BoundField DataField="Remark" HeaderText="备注"/>
            <asp:BoundField DataField="OperateUser" HeaderText="操作人"   SortExpression="OperateUser" HeaderStyle-Width="60px" />
             <asp:BoundField DataField="OperateTime" HeaderText="操作时间" HeaderStyle-Width="140px"  SortExpression="OperateTime"  DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
            
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.MSD.BLL.MsdOperation"
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
