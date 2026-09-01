<%@ Page Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" CodeBehind="AnormalConfigList.aspx.cs" Inherits="SKT.LeanMES.Web.Anormal.AnormalConfigList" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">
                异常类型
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtAnormalTypeName" runat="server" CssClass="TextBox"></asp:TextBox>
                <input type="button" runat="server" class="ButtonBox" value="..." title="异常类型" onclick="selectAnormalType();" />
            </td>
            <td class="Label2">
                异常接收途径
            </td>
            <td class="Field2">
                <asp:DropDownList ID="ddlSendWay" runat="server">
                    <asp:ListItem Value="-1" Text="==请选择=="></asp:ListItem>
                    <asp:ListItem Value="1" Text="邮件发送"></asp:ListItem>
                    <asp:ListItem Value="2" Text="微信发送"></asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
     <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" OnRowDataBound="GridView1_RowDataBound" DataKeyNames="AnormalConfigID">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="AnormalTypeName" HeaderText="异常类型" SortExpression="AnormalTypeName" />
            <asp:BoundField DataField="ReceiverName" HeaderText="异常接收人" />
            <asp:BoundField DataField="SendWay" HeaderText="异常接收途径" />
            <asp:BoundField DataField="CreateBy" HeaderText="创建人"/>
            <asp:BoundField DataField="CreateDateTime" HeaderText="创建时间" DataFormatString="{0:yyyy-MM-dd}"/>
            <asp:BoundField DataField="ModifyBy" HeaderText="修改人"/>
            <asp:BoundField DataField="ModifyDateTime" HeaderText="修改时间" DataFormatString="{0:yyyy-MM-dd}"/>
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.ProdAnormal.BLL.AnormalConfig"
        SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value=""/>
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <script type="text/javascript">
        isMultiple = false;
        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");

        //新增 
        function Add()
        {
            dialog({ title: mesLang("新增异常推送"), src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Anormal/AnormalConfigEdit.aspx?name=AnormalConfig_Add&ID=-1", width: 850, height: 450, resizeable: false });
        }

        //编辑、
        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return;
            dialog({ title: mesLang("修改异常推送"), src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Anormal/AnormalConfigEdit.aspx?name=AnormalConfig_Edit&ID=" + idStr, width: 850, height: 450, resizeable: false });
        }

    
        //刷新 
        function refresh() {
            document.forms[0].submit();
        }

        function Delete() {
            var idStr = getDeletingRecordIdString();
            if (idStr == "") return false;
            hdnOperate.val("Delete");
            hdnIdString.val(idStr);
            refresh();
        }
        function UpdateList(anormalTypeName) {
            $("#<%=this.txtAnormalTypeName.ClientID %>").val(anormalTypeName);
            document.forms[0].submit();
        }

        //选择异常类型
        function selectAnormalType() {
            var pageCondition = '';
            dialog({ title: mesLang("选择异常类型"), src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot%>/Framework/ChoosePage.aspx?PageId=831&Multiple=false&CallBackFunc=setAnormalType&PageCondition=" + pageCondition + "&rnd=" + Math.random(), width: 680, height: 350 });
        }
        function setAnormalType(list) {
            $('#<%=this.txtAnormalTypeName.ClientID%>').val(list[0][1]);
        }
    </script>
</asp:Content>
