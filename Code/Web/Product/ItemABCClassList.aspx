<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" CodeBehind="ItemABCClassList.aspx.cs" Inherits="SKT.LeanMES.Web.Product.ItemABCClassList" %>
<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" Runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1">物料ABC等级</td>
            <td class="Field1">
                <asp:TextBox ID="txtItemABC" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" Runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1">
        <Columns>
            <%-- To Do --%>           
            <asp:BoundField DataField="ABCClass" HeaderText="物料ABC等级" ItemStyle-Width="200px" />         
            <asp:BoundField DataField="ABCSuperDesc" HeaderText="类型" ItemStyle-Width="150px" />
            <asp:BoundField DataField="ABCVal" HeaderText="数量" ItemStyle-Width="100px" />
            <asp:BoundField DataField="ABCPercentVal" HeaderText="百分比(%)" ItemStyle-Width="100px" />                  
            <asp:BoundField DataField="Remark" HeaderText="备注" />            
            <asp:BoundField DataField="ModifyBy" HeaderText="<%$ Resources:lang,ModifyBy %>"
                SortExpression="ModifyBy" />
              <asp:BoundField DataField="ModifyDateTime" HeaderText="<%$ Resources:lang,ModifyDateTime %>"
                SortExpression="ModifyDateTime" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}"/> 
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" 
        StartRowIndexParameterName="startRow" MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" 
        TypeName="SKT.LeanMES.Product.BLL.ItemABCClass" SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value=""/>
    <input type="hidden" id="hdnIdString" name="hdnIdString"  value=""/>

    <script type="text/javascript">
        isMultiple = false;
        var openWinUrl = "";
      
        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Product/ItemABCClassEdit.aspx?name=Product_ItemABCClassEdit&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.Product_ItemABCClassEdit %>", src: openWinUrl, width: 600, height: 400 });
        }
               
        function Refresh() {
            document.forms[0].submit();
        }
    </script>
</asp:Content>
