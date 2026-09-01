<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" CodeBehind="MaterialBurnList.aspx.cs" Inherits="SKT.LeanMES.Web.Product.MaterialBurnList" %>
<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1">软件名称</td>
            <td class="Field1">
                <asp:TextBox ID="txtSoftName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" OnRowDataBound="GridView1_RowDataBound">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="SoftName" HeaderText="软件名称" />
            <asp:BoundField DataField="TestMachine" HeaderText="测试仪器" />
            <asp:BoundField DataField="Customer" HeaderText="适用客户" />
            <asp:BoundField DataField="SoftCreator" HeaderText="软件作者" />
            <asp:BoundField DataField="Filename" HeaderText="文件名" />
           <%-- <asp:BoundField DataField="VerifyCode" HeaderText="检验码" />--%>
            <asp:BoundField DataField="ReceiveDate" HeaderText="接收日期" />
            <asp:BoundField DataField="UpdateContent" HeaderText="更新内容" />
            <asp:BoundField DataField="SoftPath" HeaderText="软件地址" />
            <asp:BoundField DataField="VerifyCode" HeaderText="校验码" />
            <asp:BoundField DataField="DownloadDir" HeaderText="下载目录(客户端)" />
            <asp:BoundField DataField="Remark" HeaderText="描述" />
            <asp:BoundField DataField="CreateByName" HeaderText="创建人" />
            <asp:BoundField DataField="CreateTime" HeaderText="创建时间" />
            <asp:BoundField DataField="ModifyByName" HeaderText="修改人" />
            <asp:BoundField DataField="ModifyTime" HeaderText="修改时间" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" 
        StartRowIndexParameterName="startRow" MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" 
        TypeName="SKT.LeanMES.Molding.BLL.MaterialBurn" SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value=""/>
    <input type="hidden" id="hdnIdString" name="hdnIdString"  value=""/>

    <script type="text/javascript">
        isMultiple = false;
        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");

        function View() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Product/MaterialBurnView.aspx?name=MaterialBurnView&ID=" + idStr;
            dialog({ title: mesLang("查看烧录软件"), src: openWinUrl, width: 600, height: 420 });
        }

        function Add() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Product/MaterialBurnEdit.aspx?name=MaterialBurnListAdd&ID=-1";
            dialog({ title: mesLang("新增烧录软件"), src: openWinUrl, width: 600, height: 420});
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Product/MaterialBurnEdit.aspx?name=MaterialBurnListEdit&ID=" + idStr;
            dialog({ title: mesLang("修改烧录软件"), src: openWinUrl, width: 600, height: 420 });
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

        function Join() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            //xiang.yan 2024-4-28  列取值由索引改为列明
            // 1 改为 SoftName
            var SoftName = getOneRecordCellTextByFiled("SoftName");
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Product/MaterialBurnJoinProd.aspx?name=MaterialBurnJoinProd&ID=" + idStr + "&SF=" + encodeURIComponent(SoftName);
            dialog({ title: mesLang("产品"), src: openWinUrl, width: 750, height: 450 });
        }
    </script>
</asp:Content>
