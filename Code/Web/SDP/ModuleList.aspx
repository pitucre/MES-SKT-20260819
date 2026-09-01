<%@ Page Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" CodeBehind="ModuleList.aspx.cs" 
Inherits="SKT.LeanMES.Web.SDP.ModuleList" Title="Module List"
ValidateRequest="false" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1">
                模板名称
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtModelueName" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
            </td>           
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" 
        AutoGenerateColumns="false" OnRowDataBound="GridView1_RowDataBound">
        <Columns>            
            <asp:BoundField DataField="ModelName" HeaderText="<%$ Resources:lang, ModuleName %>" HeaderStyle-Width="180px" SortExpression="ModelName"/>   
            <asp:BoundField DataField="ModelTypeName" HeaderText="<%$ Resources:lang, Accessorie_SOLD_TYPE %>" HeaderStyle-Width="180px" SortExpression="ModelTypeName"/>   
            <asp:BoundField DataField="ModelClass" HeaderText="<%$ Resources:lang, FN %>" HeaderStyle-Width="180px" SortExpression="ModelClass"/>   
            <asp:BoundField DataField="CreateBy"  HeaderText="建立人" HeaderStyle-Width="180px" SortExpression="CreateBy"/> 
            <asp:BoundField DataField="CreateDateTime" HeaderText="<%$ Resources:lang, CreateDateTime %>" HeaderStyle-Width="180px" SortExpression="CreateDateTime" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}"/> 
            <asp:BoundField DataField="ModifyBy"  HeaderText="修改人" HeaderStyle-Width="180px" SortExpression="ModifyBy"/> 
            <asp:BoundField DataField="ModifyDateTime" HeaderText="<%$ Resources:lang, ModifyDateTime %>" HeaderStyle-Width="180px" SortExpression="ModifyDateTime" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}"/>              
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.SDP.BLL.UIModel"
        SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <script type="text/javascript">
        function Add(flag) {
            if (flag == 1) {
                 openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SDP/UIDesigner.aspx?ID=-1";
            }
            else if (flag == 2) {
                openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SDP/SDPUIDesigner.aspx?ID=-1";
            }
            else if (flag == 4) {
                openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SDP/PDAUIDesigner.aspx?ID=-1";
            }
            window.parent.openTab(this, "增加模板", openWinUrl, Date.parse(new Date()), '<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/theme/Metro/Images/Icon/edit.png');
            //dialog({ title: , src: openWinUrl, width: 1050, height: 550, resizeable: false });
            return false;
        }

        function Edit() {
            var type = 1;
            var idStr = getOneRecordId();
            if (idStr == "") return false;

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSDP.GetUIModel(idStr);
            
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            if (ajax.value.ModelType > 0) {
                type = ajax.value.ModelType;
            }
            if (type == 1) {//简单模式
                openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SDP/UIDesigner.aspx?ID=" + idStr;
            }
            else if (type == 2) {//高级模式
                openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SDP/SDPUIDesigner.aspx?ID=" + idStr;
            }
            else if (type == 4) {//PDA模式
                openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SDP/PDAUIDesigner.aspx?ID=" + idStr; 
            }
            window.parent.openTab(this, "修改模板", openWinUrl, Date.parse(new Date()), '<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/theme/Metro/Images/Icon/edit.png');
            //dialog({ title: "", src: openWinUrl, width: 1050, height: 550, resizeable: false });
            return false;
        }

        /*刷新页面*/
        function Refresh() {
            document.forms[0].submit();
        }

        function UpdateList(templName) {
            $("#<%=this.txtModelueName.ClientID%>").val(templName);
            document.forms[0].submit();
        }
    </script>
</asp:Content>
