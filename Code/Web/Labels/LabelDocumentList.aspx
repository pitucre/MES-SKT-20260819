<%@ Page Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="True"
    CodeBehind="LabelDocumentList.aspx.cs" Inherits="SKT.LeanMES.Web.Labels.LabelDocumentList"
    Title="LabelDocument List Page" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label3">标签名称
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtDocumentName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">打印模板名称
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtTemplateName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">打印方式
            </td>
            <td class="Field3">
                <asp:DropDownList ID="ddlPrintMode" runat="server">
                </asp:DropDownList>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1"
        OnRowDataBound="GridView1_RowDataBound">
        <Columns>
            <asp:BoundField DataField="DocumentName" HeaderText="标签名称" HeaderStyle-Width="180px"
                SortExpression="DocumentName">
                <HeaderStyle Width="180px"></HeaderStyle>
            </asp:BoundField>
            <%--<asp:BoundField DataField="PlateQty" HeaderText="联板数量" HeaderStyle-Width="75px" SortExpression="PlateQty" />--%>
            <asp:BoundField DataField="TemplateName" HeaderText="模板名称" HeaderStyle-Width="120px" SortExpression="TemplateName">
                <HeaderStyle Width="120px"></HeaderStyle>
            </asp:BoundField>
            <asp:BoundField DataField="TemplatePath" HeaderText="模板文件" HeaderStyle-Width="120px" SortExpression="TemplatePath">
                <HeaderStyle Width="120px"></HeaderStyle>
            </asp:BoundField>
            <asp:BoundField DataField="CreateBy" HeaderText="<%$ Resources:lang, CreateBy %>" HeaderStyle-Width="120px" SortExpression="CreateBy">
                <HeaderStyle Width="120px"></HeaderStyle>
            </asp:BoundField>
            <asp:BoundField DataField="CreateDateTime" HeaderText="<%$ Resources:lang, CreateDateTime %>" HeaderStyle-Width="150px" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" SortExpression="CreateDateTime">
                <HeaderStyle Width="150px"></HeaderStyle>
            </asp:BoundField>
            <asp:BoundField DataField="ModifyBy" HeaderText="<%$ Resources:lang, ModifyBy %>" HeaderStyle-Width="120px" SortExpression="ModifyBy">
                <HeaderStyle Width="120px"></HeaderStyle>
            </asp:BoundField>
            <asp:BoundField DataField="ModifyDateTime" HeaderText="<%$ Resources:lang, ModifyDateTime %>" HeaderStyle-Width="150px" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" SortExpression="ModifyDateTime">
                <HeaderStyle Width="150px"></HeaderStyle>
            </asp:BoundField>
            <asp:BoundField DataField="Description" HeaderText="<%$ Resources:lang, Description %>" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Labels.BLL.LabelDocument"
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
        function Add() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Labels/LabelDocumentEdit.aspx?name=Labels_LabelDocumentAdd&ID=-1";
            dialog({ title: "<%= Resources.Pages.Labels_LabelDocumentAdd %>", src: openWinUrl, width: 900, height: 400 });
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Labels/LabelDocumentEdit.aspx?name=Labels_LabelDocumentEdit&ID=" + idStr;
            dialog({ title: "<%= Resources.Pages.Labels_LabelDocumentEdit %>", src: openWinUrl, width: 900, height: 400 });
        }

        function Delete() {
            var idStr = getDeletingRecordIdString();
            if (idStr == "") return false;
            hdnOperate.val("delete");
            hdnIdString.val(idStr);
            document.forms[0].submit();
        }

        function View() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Labels/LabelDocumentView.aspx?name=Labels_LabelDocumentView&ID=" + idStr;
            dialog({ title: "<%= Resources.Pages.Labels_LabelDocumentView %>", src: openWinUrl, width: 900, height: 400 });
        }

        function UpdateList(obj) {
            document.forms[0].submit();
        }

        function Copy() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Labels/LabelDocumentEdit.aspx?name=Labels_LabelDocumentCopy&ID=" + idStr + "&Action=Copy&rnd=" + Math.random();
            dialog({ title: "复制标签", src: openWinUrl, width: 900, height: 400 });
        }
        function Design() {
            var idStr = getOneRecordId();
            var name = "";
            $("#<%=GridView1.ClientID%> tr").each(function () {
                if (name == "" && $(this).find("input[name='chkSelect']:checked").length == 1) {
                    name = $(this).find("td:eq(2)").text();
                }
            });
            if (name != "Lable模板") {
                alert("Lable模板才能设计");
                return;
            }
            if (idStr == "") return false;
            //window.open( "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Labels/Design.aspx?name=Labels_LabelDocumentDesign&LabelId=" + idStr);
            dialog({
                onClosing: function (node) {
                    if (!node.find("iframe")[0].contentWindow.designOptions.winclose)
                        return confirm("没有保存确定要关闭吗？");
                    return true;
                }, title: "模板设计", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Labels/Design.aspx?name=Labels_LabelDocumentDesign&LabelId=" + idStr, width: $("body").width() - 100, height: $("body").height() - 50
            });
        }
    </script>
</asp:Content>
