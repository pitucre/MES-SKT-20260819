<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" CodeBehind="PrepareMaterialList.aspx.cs" Inherits="SKT.LeanMES.Web.Material.PrepareMaterialList" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">
                备料单号
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtPrepareForm" runat="server"></asp:TextBox>
            </td>
            <td class="Label2">
                备料人
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtCreateBy" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                备料部门
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtDeptName" runat="server"></asp:TextBox>
            </td>
            <td class="Label2">
                备料仓库
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtWhName" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                生产订单号
            </td>
            <td class="Field2" colspan='3'>
                <asp:TextBox ID="txtProductOrdeNo" runat="server"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="searchConditions" runat="server" ContentPlaceHolderID="GridviewContent">
    <asp:GridView ID="GridView1" AutoGenerateColumns="false" runat="server">
        <Columns>
            <asp:BoundField DataField="PMCode" HeaderText="备料单号" />
            <asp:BoundField DataField="MOCode" HeaderText="生产订单号" />
            <asp:BoundField DataField="DepName" HeaderText="备料部门" />
            <asp:BoundField DataField="WhName" HeaderText="备料仓库" />
            <asp:BoundField DataField="CreateBy" HeaderText="备料人" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="创建时间" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Material.BLL.PrepareMatForm"
        SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
   <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <input type="hidden" id="hdnPrepareListId" name="hdnPrepareListId" value="-1" />
    <input type="hidden" id="hdnSourceCode" name="hdnSourceCode" value="" />
    <script type="text/javascript">
        $(document).ready(function () {
            $("#ckbMultipleSelected").parent().hide();
        })
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");
        function Add() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Material/PrepareMaterialEdit.aspx?name=Material_PrepareMatFormAdd&ID=-1";
            dialog({ title: "新增备料单", src: openWinUrl, width: 800, height: 400 })
        }
        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Material/PrepareMaterialEdit.aspx?name=Material_PrepareMatFormEdit&ID=" + idStr;
            dialog({ title: "编辑备料单", src: openWinUrl, width: 800, height: 400 })
        }
        //查看
        function View() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Material/PrepareMaterialView.aspx?ID=" + idStr;
            dialog({ title: "查看备料单", src: openWinUrl, width: 800, height: 400 })
        }
        //新增其他领料方式
        function OtherAdd() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Material/PrepareMaterialOther.aspx?name=Material_PrepareMatFormOtherAdd&ID=-1";
            dialog({ title: "新增其他领料方式", src: openWinUrl, width: 1000, height: 400 })
        }
        //编辑其他领料方式
        function OtherEdit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Material/PrepareMaterialOther.aspx?name=Material_PrepareMatFormOtherEdit&ID=" + idStr;
            dialog({ title: "编辑其他领料方式", src: openWinUrl, width: 1000, height: 400 })
        }
        function UpdateList(namestr) {
            $("#hdnPrepareListId").val(namestr);
            document.forms[0].submit();
            $("#hdnPrepareListId").val("-1");
        }
        function Delete() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            if (confirm('确定要删除吗？')) {
                //xiang.yan 2024-4-28  列取值由索引改为列明,菜单已无此页面
                // 1 改为 PMCode
                var sourceName = getOneRecordCellTextByFiled("PMCode");
                if (sourceName == "深圳") {
                    sourceName = "001";
                }
                else {
                    sourceName = "003";
                }
                $("#hdnSourceCode").val(sourceName);
                hdnOperate.val("delete");
                hdnIdString.val(idStr);
                document.forms[0].submit();
            }
        }
    </script>
</asp:Content>
