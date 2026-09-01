<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true"
    Inherits="SKT.MES.Web.Material.FormChangeList" CodeBehind="FormChangeList.aspx.cs"
    ValidateRequest="false" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label3">单号
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtFormChangeNo" runat="server"></asp:TextBox>
            </td>
            <td class="Label3">仓库名称
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtWarehouseName" runat="server"></asp:TextBox>
            </td>
            <td class="Label3">项目
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtProject" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label3">组织
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtOrganization" runat="server"></asp:TextBox>
            </td>

            <td class="Label3">单据类型
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtDocumentType" runat="server"></asp:TextBox>
            </td>

            <td class="Label3">日期
            </td>
            <td class="Field3" colspan="5">
                <asp:TextBox ID="txtCreateDateTimeStart" runat="server" CssClass="DateTimeBox" ClientIDMode="Static"></asp:TextBox>
                ~
                <asp:TextBox ID="txtCreateDateTimeEnd" runat="server" CssClass="DateTimeBox" ClientIDMode="Static"></asp:TextBox>
            </td>

        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" AutoGenerateColumns="false"
        OnRowDataBound="GridView1_OnRowDataBound" ClientIDMode="Static" Style="table-layout: fixed; word-wrap: break-word; word-break: break-all">
        <Columns>

            <asp:BoundField DataField="FormChangeNo" HeaderText="形态转换单号" SortExpression="FromChangeByMESNo" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="120px" />
            <asp:BoundField DataField="DocumentType" HeaderText="单据类型" SortExpression="DocumentType" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="120px" />
            <asp:BoundField DataField="Organization" HeaderText="组织" SortExpression="Organization" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="120px" />
            <asp:BoundField DataField="Project" HeaderText="项目" SortExpression="Project" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="120px" />
            <asp:BoundField DataField="WarehouseCode" HeaderText="仓库编码" SortExpression="WarehouseCode" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="120px" />
            <asp:BoundField DataField="WarehouseName" HeaderText="仓库名称" SortExpression="WarehouseName" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="120px" />

            <asp:TemplateField HeaderText="日期" SortExpression="PackingDate" HeaderStyle-Width="120px">
                <ItemTemplate>
                    <%#Eval("FormChangeDate").ToString() == "9999/12/31 0:00:00" ? "" : Eval("FormChangeDate","{0:yyyy-MM-dd}").ToString()%>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:BoundField DataField="StatusName" HeaderText="状态" SortExpression="StatusName" HeaderStyle-Width="120px" />
            <asp:BoundField DataField="CreateBy" HeaderText="创建人" HeaderStyle-Width="120px" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="创建时间" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" HeaderStyle-Width="140px" />
            <asp:BoundField DataField="ModifyBy" HeaderText="修改人" HeaderStyle-Width="120px" />
            <asp:BoundField DataField="ModifyDateTime" HeaderText="修改时间" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" HeaderStyle-Width="140px" />

        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Order.BLL.ShopOrder"
        SelectMethod="GetAllFormChangeList" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <asp:HiddenField runat="server" ID="hfCheckBox" ClientIDMode="Static" />
    <script type="text/javascript">
        isMultiple = false;
        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");
        var date = "";
        var hfcheck = $("#hfCheckBox").val();
        setCheckBox(hfcheck, 'showChkBox');
        $(function () {
            gridCellsChangeNo = true;
            //var oname = $.trim(window.localStorage.getItem("OrganizationName"));
            //if (oname) {
            //    if (oname != "集团总部") {
            //        $('div.toolbar-btn[title="数据下发"]').hide();
            //        $('div.toolbar-btn[title="数据下发"]').next("div.btn-line").hide();
            //    }
            //} else {
            //    $('div.toolbar-btn[title="数据下发"]').hide();
            //    $('div.toolbar-btn[title="数据下发"]').next("div.btn-line").hide();
            //}
        });

        function openDialog(url) {
            dialog({ title: "打开文档列表", src: url, width: 730, height: 450, resizeable: false });
        }
        //编辑
<%--        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;

            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Product/ShopOrderEdit.aspx?name=ShopOrder_Edit&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.ShopOrder_Edit %>", src: openWinUrl, width: 980, height: 480 });
            //window.parent.openLeftMenu(this, "<%=Resources.Pages.ShopOrder_Edit %>", openWinUrl, idStr);

        }--%>

        //删除 只可单条删除
        //function Delete() {
        //    var idStr = getDeletingRecordIdString();
        //    if (idStr == "") return false;
        //    hdnOperate.val("delete");
        //    hdnIdString.val(idStr);
        //    document.forms[0].submit();
        //}
        //关闭装箱单
        //function Close() {
        //    var idStr = getRecordIdString();
        //    if (idStr == "") return false;
        //    hdnOperate.val("close");
        //    hdnIdString.val(idStr);
        //    document.forms[0].submit();
        //}
        function UpdateList(namestr) {
            $("#txtOrderNO").val(namestr);
            document.forms[0].submit();
        }

        function View() {

            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Material/FormChangeView.aspx?name=FormChangeView&ID=" + idStr;
            dialog({ title: "查看形态转换单明细", src: openWinUrl, width: 800, height: 500 });
        }

        //打印
        function Print() {

            var idStr = getOneRecordId();

            if (idStr == "") {
                return false;
            }
            window.open("<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Material/FormChangeListPrint.aspx?name=FormChangeListPrint&ID=" + idStr);
        }







        function Refresh() {
            document.forms[0].submit();
        }

    </script>
</asp:Content>
