<%@ Page Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="True"
    CodeBehind="EquipmentMouldRelationList.aspx.cs" Inherits="SKT.LeanMES.Web.Equipment.EquipmentMouldRelationList" Title="EquipmentMouldRelationList List Page" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>

            <td class="Label2"><%=Resources.lang.EquipmentCode%></td>
            <td class="Field2">
                <asp:TextBox ID="txtEquipmentCode" runat="server" CssClass="TextBox"></asp:TextBox>
                <input type="button" class="ButtonBox"
                    value="..." onclick="selectEquimentName()" />
            </td>
            <td class="Label2"><%=Resources.lang.MouldName%></td>
            <td class="Field2">
                <asp:TextBox ID="txtMouldCode" runat="server" CssClass="TextBox"></asp:TextBox>
                <input type="button" class="ButtonBox"
                    value="..." onclick="selectMouldName()" />
            </td>

        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="EquimentCode" HeaderText="<%$ Resources:lang, EquipmentCode %>" />
            <asp:BoundField DataField="EquimentName" HeaderText="<%$ Resources:lang, EquipmentName %>" />
            <asp:BoundField DataField="BomCode" HeaderText="模具编码" />
            <asp:BoundField DataField="BomName" HeaderText="<%$ Resources:lang, MouldName %>" />
            <asp:BoundField DataField="CreateBy2" HeaderText="<%$ Resources:lang, CreateBy %>" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="<%$ Resources:lang, CreateDateTime %>" />
            <asp:BoundField DataField="ModifyBy" HeaderText="<%$ Resources:lang, ModifyBy %>" />
            <asp:BoundField DataField="ModifyTime" HeaderText="<%$ Resources:lang, ModifyDateTime %>" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true"
        StartRowIndexParameterName="startRow" MaximumRowsParameterName="maxRows" SortParameterName="sortExpression"
        TypeName="SKT.LeanMES.Equipment.BLL.EquipmentMouldRelation" SelectMethod="GetAll" SelectCountMethod="GetCount">
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
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/EquipmentMouldRelationEdit.aspx?name=EquipmentItemRelationListAdd&ID=-1&EqCode=''";
            <%--openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/EquipmentItemRelationEdits.aspx?name=EquipmentItemRelationListAdd&ID=-1";--%>//类似BOM的添加模式
            dialog({ title: "<%=Resources.Pages.EquipmentMouldRelationAdd%>", src: openWinUrl, width: 850, height: 500 });
        }


        var chooseFlag = -1;
        function selectEquimentName() {
            var searchCondition = "  ParentTypeId =1";
            chooseFlag = 1;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=54&SearchCondition=" + searchCondition + "&Multiple=false&rnd=" + Math.random(), width: 600, height: 400 });
        }

        function selectMouldName() {
            chooseFlag = 2
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=705&Multiple=false&rnd=" + Math.random(), width: 700, height: 450 });
        }

        function getChooseValue(list) {
            if (chooseFlag == 1) {
                $("#<%=this.txtEquipmentCode.ClientID %>").val(list[0][1]);
            } else if (chooseFlag == 2) {
                $("#<%=this.txtMouldCode.ClientID %>").val(list[0][1]);
            }
        }
        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/EquipmentMouldRelationEdit.aspx?name=EquipmentItemRelationListEdit&ID=" + idStr;
            dialog({ title: mesLang("编辑设备模具BOM关联"), src: openWinUrl, width: 850, height: 500 });
        }

        function Delete() {
            var idStr = getDeletingRecordIdString();
            if (idStr == "") return false;
            hdnOperate.val("delete");
            hdnIdString.val(idStr);
            document.forms[0].submit();
        }

        function Refresh() {
            document.forms[0].submit();
        }
    </script>
</asp:Content>

