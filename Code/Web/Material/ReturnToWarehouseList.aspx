<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ReturnToWarehouseList.aspx.cs" MasterPageFile="~/Masters/ListMaster.master"
    Inherits="SKT.LeanMES.Web.Material.ReturnToWarehouseList" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label3">生产退料单</td>
            <td class="Field3">
                <asp:TextBox ID="txtReturnToWarehouseNO" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">工单</td>
            <td class="Field3">
                <asp:TextBox ID="txtProdOrder" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">物料编码</td>
            <td class="Field3">
                <asp:TextBox ID="txtItemCode" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label3">供应商代码</td>
            <td class="Field3">
                <asp:TextBox ID="txtVenCode" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">ERP来源单</td>
            <td class="Field3">
                <asp:TextBox ID="txtErpSrc" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">仓库名字</td>
            <td class="Field3">
                <asp:TextBox ID="txtWh" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label3">退料人</td>
            <td class="Field3">
                <asp:TextBox ID="txtCreater" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">退料日期</td>
            <td class="Field3">
                <asp:TextBox ID="txtReturnDateFr" runat="server" ClientIDMode="Static" CssClass=" DateTimeBox"></asp:TextBox>
                --
                <asp:TextBox ID="txtReturnDateTo" runat="server" ClientIDMode="Static" CssClass="DateTimeBox"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="ReturnOrderNo" HeaderText="退料单" SortExpression="ReturnOrderNo" />
            <asp:BoundField DataField="ItemCode" HeaderText="物料编码" SortExpression="ItemCode" />
            <asp:BoundField DataField="ItemName" HeaderText="物料名称" SortExpression="ItemName" />
            <asp:BoundField DataField="ProdOrderNo" HeaderText="工单" SortExpression="ProdOrderNo" />
            <asp:BoundField DataField="DepartName" HeaderText="退料部门" SortExpression="DepartName" />
            
            <asp:TemplateField HeaderText="需退数量" SortExpression="ReturnQty"  HeaderStyle-Width="80px">
                <ItemTemplate>
                    <%#Eval("ReturnQty","{0:G0}").ToString() %>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="已退数量" SortExpression="ReceiveQty"  HeaderStyle-Width="80px">
                <ItemTemplate>
                    <%#Eval("ReceiveQty","{0:G0}").ToString() %>
                </ItemTemplate>
            </asp:TemplateField>
           
            <asp:BoundField DataField="StatusDesc" HeaderText="完成状态"  />
            <asp:BoundField DataField="StatusName" HeaderText="退料状态"  />
            <asp:BoundField DataField="CWhName" HeaderText="仓库" SortExpression="CWhName" />
<%--            <asp:BoundField DataField="VendorName" HeaderText="供应商" SortExpression="VendorName" />--%>
            <asp:BoundField DataField="SourceBillNo" HeaderText="ERP来源单" SortExpression="SourceBillNo" />
            <asp:BoundField DataField="CreateBy" HeaderText="创建人" SortExpression="CreateBy" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="创建时间" SortExpression="CreateDateTime" />
            <asp:BoundField DataField="UpdateBy" HeaderText="修改人" SortExpression="UpdateBy" />
            <asp:BoundField DataField="ModifyByTime2" HeaderText="修改时间" SortExpression="ModifyDateTime" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true"
        StartRowIndexParameterName="startRow" MaximumRowsParameterName="maxRows" SortParameterName="sortExpression"
        TypeName="SKT.LeanMES.Material.BLL.Material" SelectMethod="GetProdReturnOrderAll" SelectCountMethod="GetCount">
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
        $(function () {
            $("#txtReturnDateFr").attr("readonly", "readonly");
            $("#txtReturnDateTo").attr("readonly", "readonly");
            gridCellsChangeNo = true;
        })
        function Add() {
           <%-- openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Material/MaterialProdReturn.aspx?name=MaterialProdReturn&ID=-1";
            dialog({ title: "新增", src: openWinUrl, width: 650, height: 400 });--%>
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Material/MaterialProdReturn.aspx?name=MaterialProdReturn&ID=" + idStr;
            dialog({ title: mesLang("编辑"), src: openWinUrl, width: 600, height: 400 });
        }

        function View() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Material/ReturnToWarehouseDtl.aspx?ID=" + idStr;
            dialog({ title: mesLang("查看"), src: openWinUrl, width: 900, height: 500 });
        }

        function Cancel() {
            //xiang.yan 2024-4-28  列取值由索引改为列明
            // 8 改为 StatusDesc
            var resultState = getOneRecordCellTextByFiled("StatusDesc");
            if (resultState !== "未完成") {
                alert("只有未完成的退料单可以取消操作!");
                return false;
            }
            //var idStr = getDeletingRecordIdString();
            //xiang.yan 2024-4-28  列取值由索引改为列明
            // 1 改为 ReturnOrderNo
            var idStr = getOneRecordCellTextByFiled("ReturnOrderNo");
            if (idStr == "") return false;

            hdnOperate.val("Cancel");
            hdnIdString.val(idStr);
            document.forms[0].submit();
        }

        function Refresh() {
            document.forms[0].submit();
        }

        //无单生产退料入库
        function ReturnMaterial() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Material/ReturnNoOrderMaterial.aspx?name=AddReturnMaterial";
            dialog({ title: mesLang("无单生产退料入库"), src: openWinUrl, width: (windowWidth - 200), height: (windowHeigth - 100) });
        }

        //生产退料申请
        function ApplyMaterial() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Material/MaterialProdReturn.aspx?name=MaterialProdReturn";
            dialog({ title: mesLang("生产退料申请"), src: openWinUrl, width: (windowWidth - 200), height: (windowHeigth - 100) });
        }
    </script>
</asp:Content>
