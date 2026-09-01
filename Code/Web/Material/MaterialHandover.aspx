<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" EnableEventValidation = "false"
    CodeBehind="MaterialHandover.aspx.cs" Inherits="SKT.LeanMES.Web.Material.MaterialHandover" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">
                领料单号
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtApplyNO" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label2">
                部门名称
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtDepName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                仓库名称
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtWhName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label2">
                使用日期
            </td>
            <td class="Field2">
                <input type="text" id="txtDateFrom" class="DateTimeBox" runat="server" readonly="readonly" />
                -
                <input type="text" id="txtDateTo" class="DateTimeBox" runat="server" readonly="readonly" />
            </td>
        </tr>
        <tr>
            <td class="Label2">
                类型
            </td>
            <td class="Field2">
                <asp:DropDownList ID="ddlType" runat="server">
                    <asp:ListItem Value="">全部</asp:ListItem>
                    <asp:ListItem Value="0">手工增加</asp:ListItem>
                    <asp:ListItem Value="1">工单领料</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td class="Label2">
                状态
            </td>
            <td class="Field2">
                <asp:DropDownList ID="ddlState" runat="server">
                    <asp:ListItem Value="">全部</asp:ListItem>
                    <asp:ListItem Value="0">待备料</asp:ListItem>
                    <asp:ListItem Value="4">备料中</asp:ListItem>
                    <asp:ListItem Value="1" Selected="True">已备料</asp:ListItem>
                    <asp:ListItem Value="2">已接收</asp:ListItem>
                    <asp:ListItem Value="3">已退料</asp:ListItem>
                    <asp:ListItem Value="-1">已删除</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" OnRowDataBound="GridView1_RowDataBound">
        <Columns>
            <asp:BoundField DataField="ApplyType" HeaderText="类型" />
            <asp:BoundField DataField="ApplyNo" HeaderText="领料单号" />
            <asp:BoundField DataField="PrepareMaterialNo" HeaderText="备料单号" />
            <asp:BoundField DataField="DepCode" HeaderText="生产部门编码" />
            <asp:BoundField DataField="DepName" HeaderText="生产部门名称" />
            <asp:BoundField DataField="WhCode" HeaderText="仓库编码" />
            <asp:BoundField DataField="WhName" HeaderText="仓库名称" />
            <asp:BoundField DataField="UseDateTime" HeaderText="使用日期" DataFormatString="{0:yyyy-MM-dd}" />
            <asp:BoundField DataField="CreateBy" HeaderText="备料人" />
            <asp:BoundField DataField="Remark" HeaderText="备注" />
            <asp:BoundField DataField="Statue" HeaderText="状态" />
            <asp:BoundField DataField="ModifyBy" HeaderText="接收人" />
            <asp:BoundField DataField="ModifyDateTime" HeaderText="接收时间" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Material.BLL.Apply"
        SelectMethod="GetAllDetails" SelectCountMethod="GetCount">
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

        function View() {
        	var idStr = getOneRecordId();
        	if (idStr == "") return false;

        	openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Material/MaterialdoApplyView.aspx?name=MaterialdoApplyView&ID=" + idStr + "&num=" + Math.random();
            dialog({ title: "备料单查看", src: openWinUrl, width: (windowWidth - 200), height: (windowHeigth - 200) });
        }

        //交接确认操作
        function Save() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            //xiang.yan 2024-4-28  列取值由索引改为列明,该字段后面已不再使用，注释掉
            // 9>11 改为 Statue
            //var resultState = getOneRecordCellTextByFiled("Statue");
            /*
            2017-2-9 BirongLiang   备料中/已备料，都能交接，可多次交接知道备料完成
            
            if (resultState != "已备料") {
                alert("该发料单状态为" + resultState + "不能进行交接确认");
                return false;
            }
            */


            if (confirm('确定该领料单交接确认?')) {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialApply.SaveApplyMaterialHandover(idStr);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }

                alert("交接确认成功!");
                document.forms[0].submit();
            }
        }

    </script>
</asp:Content>
