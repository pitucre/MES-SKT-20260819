<%@ Page Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="True"
    CodeBehind="TemplateList.aspx.cs" Inherits="SKT.LeanMES.Web.Labels.TemplateList"
 %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label3">标签模板名称
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtTempName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">
            </td>
            <td class="Field3">
              
            </td>
            <td class="Label3">
            </td>
            <td class="Field3">
      
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1"
        OnRowDataBound="GridView1_RowDataBound">
        <Columns>
            <asp:BoundField DataField="TempName" HeaderText="模板名称"  HeaderStyle-Width="180px" SortExpression="TempName" />
            <asp:BoundField DataField="PanelWidth" HeaderText="宽度(MM)" HeaderStyle-Width="180px" SortExpression="PanelWidth" />
            <asp:BoundField DataField="PanelHeight" HeaderText="高度(MM)" HeaderStyle-Width="180px" SortExpression="PanelHeight" />
            <asp:BoundField DataField="CreateBy" HeaderText="<%$ Resources:lang, CreateBy %>" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="<%$ Resources:lang, CreateDateTime %>" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
            <asp:BoundField DataField="ModifyBy" HeaderText="<%$ Resources:lang, ModifyBy %>" />
            <asp:BoundField DataField="ModifyDateTime" HeaderText="<%$ Resources:lang, ModifyDateTime %>" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}"/>
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Labels.BLL.PrintTemplate"
        SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
     <script src="../Content/login/js/jquery.cookie.js"></script>
    <script type="text/javascript">
        isMultiple = false;
        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");
        function Add() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Labels/TemplateEdit.aspx?name=Labels_TemplateAdd&TempId=-1";
            dialog({ title: "<%= Resources.Pages.Labels_LabelDocumentAdd %>", src: openWinUrl, width: 700, height: 400 });
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Labels/TemplateEdit.aspx?name=Labels_TemplateEdit&TempId=" + idStr;
            dialog({ title: "<%= Resources.Pages.Labels_LabelDocumentEdit %>", src: openWinUrl, width: 700, height: 400 });
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
         function Copy() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Labels/TemplateEdit.aspx?name=Labels_TemplateEdit&TempId=" + idStr + "&Action=Copy&rnd=" + Math.random();
             dialog({ title: "复制模板", src: openWinUrl, width: 700, height: 400 });
        }
        function Design() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            var option = $.cookie("SocketParams");
            if (option) {
                option = JSON.parse(option);
                option.rate = 1;
                //bug:1687 把A标签模板放大缩小后系统把其他的所有模板也给放大缩小了
                $.cookie("SocketParams", JSON.stringify(option), { expires: 7 });
            }
            dialog({
                onClosing: function (node) {
                    if (!node.find("iframe")[0].contentWindow.designOptions.winclose)
                        return confirm("没有保存确定要关闭吗？");
                    return true;
                }, title: "模板设计", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Labels/Design.aspx?TempId=" + idStr, width: $("body").width() - 100, height: $("body").height() - 50
            });
        }
    </script>
</asp:Content>
