<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" CodeBehind="AnormalProcessConfigList.aspx.cs" Inherits="SKT.LeanMES.Web.Anormal.AnormalProcessConfigList" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label3">线别</td>
            <td class="Field3">
                <asp:TextBox runat="server" ID="LineName" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox><input type="button" class="ButtonBox" onclick="openChoosePage(21)" value="..." />
            </td>
            <td class="Label3">异常类型</td>
            <td class="Field3">
                <asp:TextBox ID="AnormalGroupName" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox><input type="button" class="ButtonBox" onclick="openChoosePage(831)" value="..." />
            </td>
             <td class="Label3">域</td>
            <td class="Field3">
                <asp:TextBox ID="AnormalContract" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
    <asp:GridView ID="GridView1" AutoGenerateColumns="false" runat="server" Style="word-wrap: break-word; word-break: break-all">
        <Columns>
            <asp:BoundField DataField="LineName" HeaderText="线别" SortExpression="LineName" />
            <asp:BoundField DataField="AnormalGroupName" HeaderText="异常类型" SortExpression="AnormalGroupId" />  
            <asp:BoundField DataField="AnormalContract" HeaderText="域" SortExpression="AnormalContract" />  
            <asp:BoundField DataField="ProcessByName" HeaderText="异常处理人" SortExpression="ProcessByName" />            
            <asp:BoundField DataField="CompleteByName" HeaderText="异常完结人" SortExpression="CompleteByName" />
            <asp:BoundField DataField="CreateBy" HeaderText="创建人" SortExpression="CreateBy" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="创建时间" SortExpression="CreateDateTime" />
            <asp:BoundField DataField="ModifyBy" HeaderText="修改人" SortExpression="ModifyBy" />
            <asp:BoundField DataField="ModifyDateTime" HeaderText="修改时间" SortExpression="ModifyDateTime" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.ProdAnormal.BLL.Anormal"
        SelectMethod="GetAnormalProcessConfigList" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <script language="javascript" type="text/javascript">
        var gridId = "<%=this.GridView1.ClientID%>";
        var flag = -1;
        isMultiple = true;

        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");

        function View() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            var src = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Anormal/AnormalProcessConfigView.aspx?name=AnormalProcessConfigView&AnormalProcessConfigId=" + idStr;
            dialog({ title: "查看", src: src, width: 850, height: 600 });
        }

        function Add() {
            var src = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Anormal/AnormalProcessConfigEdit.aspx?name=AnormalProcessConfigAdd&AnormalProcessConfigId=-1";
            dialog({ title: "新增", src: src, width: 850, height: 600 });
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            var src = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Anormal/AnormalProcessConfigEdit.aspx?name=AnormalProcessConfigEdit&AnormalProcessConfigId=" + idStr;
            dialog({ title: "编辑", src: src, width: 850, height: 600 });
        }

        //删除
        function Delete() {
            var idStr = getDeletingRecordIdString();
            if (idStr === "") return false;
            hdnOperate.val("delete");
            hdnIdString.val(idStr);
            document.forms[0].submit();
        }

        //导出到EXCEL
        function Export() {
            hdnOperate.val("exportexcel");
            document.forms[0].submit();
            hdnOperate.val("");
        }

        function Refresh() {
            hdnOperate.val("");
            document.forms[0].submit();
        }

        function openChoosePage(flags) {
            var condition = "";
            flag = flags;
            dialog({ title: "选择窗口", src: "../Framework/ChoosePage.aspx?PageId=" + flags + "&Multiple=false&SearchCondition=" + condition + "&rnd=" + Math.random(), width: 650, height: 350 });
        }

        function getChooseValue(list) {
            if (flag == 21) {	//选择线体
                $("#LineName").val(list[0][1]);
            }
            else if (flag == 831) {	//选择异常类型
                $("#AnormalGroupName").val(list[0][1]);
            }
            flag = -1;
        }

        //根据样式名获取文本
        function getTextByClass(cls) {
            return $.trim($("#<%=this.GridView1.ClientID%> tbody input[name=\"chkSelect\"]:checked").parent().siblings("." + cls).text());
        }

    </script>
</asp:Content>

