<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" CodeBehind="MoldComponentList.aspx.cs" Inherits="SKT.LeanMES.Web.Equipment.MoldComponentList" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label3">模具构件名称</td>
            <td class="Field3">
                <asp:TextBox ID="txtComponentName" runat="server"></asp:TextBox>
            </td>
            <td class="Label3">创建人</td>
            <td class="Field3">
                <asp:TextBox ID="txtCreateBy" runat="server"></asp:TextBox><input type="button" value="..." class="ButtonBox" onclick="selectUser(1)" />
                <asp:HiddenField ID="hdCreateBy" runat="server" />
            </td>
            <td class="Label3">创建时间</td>
            <td class="Field3">
                <asp:TextBox CssClass="DateTimeBox" ID="txtCreateTimeStart" Style="width: 86px;" runat="server"></asp:TextBox>
                -
                <asp:TextBox CssClass="DateTimeBox" ID="txtCreateTimeEnd" Style="width: 86px;" runat="server"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="searchConditions" runat="server" ContentPlaceHolderID="GridviewContent">
    <asp:GridView ID="GridView1" AutoGenerateColumns="false" runat="server" OnRowDataBound="GridView1_RowDataBound">
        <Columns>
            <asp:BoundField DataField="ComponentName" HeaderText="模具构件名称" ItemStyle-Width="200px" />
            <asp:BoundField DataField="SafeStock" HeaderText="安全库存" ItemStyle-Width="200px" />
            <asp:BoundField DataField="Remark" HeaderText="备注" />
            <asp:BoundField DataField="CreateBy" HeaderText="创建人" ItemStyle-Width="120px" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="<%$ Resources:lang,CreateDateTime %>" ItemStyle-Width="140px" />
            <asp:BoundField DataField="ModifyBy" HeaderText="<%$ Resources:lang, ModifyBy %>" />
            <asp:BoundField DataField="ModifyDateTime" HeaderText="<%$ Resources:lang, ModifyDateTime %>" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Equipment.BLL.MoldComponent"
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
        var chooseFlag = -1;

        //增加 
        function Add() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/MoldComponentEdit.aspx?name=MoldComponentAdd&Id=-1";
            dialog({ title: mesLang("新增模具构件"), src: openWinUrl, width: 650, height: 300, resizeable: false });
        }

        //编辑
        function Save() {
            var idStr = getOneRecordId();
            if (idStr == "") return;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/MoldComponentEdit.aspx?name=MoldComponentEdit&Id=" + idStr;
            dialog({ title: mesLang("编辑模具构件"), src: openWinUrl, width: 650, height: 300, resizeable: false });
        }

        //刷新 
        function refresh() {
            document.forms[0].submit();
        }

        //删除
        function Delete() {
            var idStr = getDeletingRecordIdString();
            if (idStr == "") return false;
            $(hdnOperate).val("Delete");
            $(hdnIdString).val(idStr);
            document.forms[0].submit();
        }

        //更新列表
        function UpdateList(bomName) {
            $("#<%=this.txtComponentName.ClientID %>").val(bomName);
            document.forms[0].submit();
        }

        /*选择用户*/
         function selectUser(type) {

             chooseFlag = type;
             dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=12&Multiple=false&rnd=" + Math.random(), width: 500, height: 300 });
         }

        function getChooseValue(list) {
            if (chooseFlag == 1) {
                $("#<%=this.hdCreateBy.ClientID %>").val(list[0][2]);
                $("#<%=this.txtCreateBy.ClientID %>").val(list[0][3]);

            }
        }
    </script>
</asp:Content>
