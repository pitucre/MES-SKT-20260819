<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/ListMaster.master"
    CodeBehind="MaterialApplyList.aspx.cs" Inherits="SKT.LeanMES.Web.Material.MaterialApplyList" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">领料单号
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtApplyNO" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label2">工单/投料单号
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtMOCode" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>

        </tr>
        <tr>
            <td class="Label2">仓库名称
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtWhName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label2">部门名称
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtDepName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">类型
            </td>
            <td class="Field2">
                <asp:DropDownList ID="ddlType" runat="server">
                    <asp:ListItem Value="">全部</asp:ListItem>
                    <asp:ListItem Value="0">其他领料</asp:ListItem>
                    <asp:ListItem Value="1">工单领料</asp:ListItem>
                    <asp:ListItem Value="2">委外领料</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td class="Label2">状态
            </td>
            <td class="Field2">
                <asp:DropDownList ID="ddlState" runat="server">
                    <asp:ListItem Value="">全部</asp:ListItem>
                    <asp:ListItem Value="0">待备料</asp:ListItem>
                    <asp:ListItem Value="4">备料中</asp:ListItem>
                    <asp:ListItem Value="1">已备料</asp:ListItem>
                    <asp:ListItem Value="2">已交接</asp:ListItem>
                    <asp:ListItem Value="3">已退料</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="Label2">使用日期
            </td>
            <td class="Field2">
                <input type="text" id="txtDateFrom" class="DateTimeBox" runat="server" readonly="readonly" />
                -
                <input type="text" id="txtDateTo" class="DateTimeBox" runat="server" readonly="readonly" />
            </td>
            <td class="Label2">发料类型
            </td>
            <td class="Field2">
                <asp:DropDownList ID="ddlApplyClass" runat="server">
                    <asp:ListItem Value="">全部</asp:ListItem>
                    <asp:ListItem Value="0">合并子单</asp:ListItem>
                    <asp:ListItem Value="1">合并母单</asp:ListItem>
                    <asp:ListItem Value="-1">独立发料</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>

    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" OnRowDataBound="GridView1_RowDataBound">
        <Columns>
            <asp:BoundField DataField="ApplyType" HeaderText="类型" />
            <asp:BoundField DataField="ApplyClass" HeaderText="发料类型" />
            <asp:BoundField DataField="ApplyNo" HeaderText="领料单号" />
            <asp:BoundField DataField="MOCode" HeaderText="工单号" />
            <asp:BoundField DataField="DepCode" HeaderText="生产部门编码" />
            <asp:BoundField DataField="DepName" HeaderText="生产部门名称" />
            <asp:BoundField DataField="WhCode" HeaderText="仓库编码" />
            <asp:BoundField DataField="WhName" HeaderText="仓库名称" />
            <asp:BoundField DataField="UseDateTime" HeaderText="使用日期" DataFormatString="{0:yyyy-MM-dd}" />
            <asp:BoundField DataField="CreateBy" HeaderText="申请人" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="申请日期" DataFormatString="{0:yyyy-MM-dd}" />
             <asp:BoundField DataField="ModifyBy" HeaderText="修改人" />
            <asp:BoundField DataField="ModifyDateTime" HeaderText="修改日期" DataFormatString="{0:yyyy-MM-dd}" />
            <asp:BoundField DataField="Remark" HeaderText="备注" />
            <asp:BoundField DataField="Statue" HeaderText="状态" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Material.BLL.Apply"
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
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Material/MaterialApplyEdit.aspx?name=MaterialApplyAdd&ID=-1";
            dialog({ title: mesLang("添加领料申请"), src: openWinUrl, width: (windowWidth - 200), height: (windowHeigth - 200) });
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            //xiang.yan 2024-4-28  列取值由索引改为列明
            // 1 改为 ApplyType
            var result = getOneRecordCellTextByFiled("ApplyType");
            //xiang.yan 2024-4-28  列取值由索引改为列明
            // 15 改为 Statue
            var resultState = getOneRecordCellTextByFiled("Statue");
            var applyClass = getOneRecordCellTextByFiled("ApplyClass");
            if (resultState != "待备料" && resultState != "备料中") {
                alert("该领料单状态为[" + resultState + "],不能编辑");
                return false;
            }
            if (applyClass == "合并子单" || applyClass == "合并母单") {
                alert("该领料单发料类型为[" + applyClass + "],不能编辑");
                return false;
            }

            var orderState = 0;
            if (resultState == "备料中") {
                orderState = 1;
            }
            if (result == "工单领料") {
                openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Material/MaterialApplyEdit.aspx?name=MaterialApplyEdit&ID=" + idStr + "&orderState=" + orderState;
                dialog({ title: mesLang("编辑领料申请"), src: openWinUrl, width: (windowWidth - 200), height: (windowHeigth - 200) });
            }
            if (result == "手工增加" || result == "其他领料") {
                openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Material/MaterialApplyHandEdit.aspx?name=MaterialApplyHandEdit&ID=" + idStr + "&orderState=" + orderState;
                dialog({ title: mesLang("编辑领料申请"), src: openWinUrl, width: (windowWidth - 200), height: (windowHeigth - 200) });
            }
        }
        //新增手工领料
        function AddHand() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Material/MaterialApplyHandEdit.aspx?name=MaterialApplyOtherAdd&ID=-1";
            dialog({ title: mesLang("添加领料申请"), src: openWinUrl, width: (windowWidth - 200), height: (windowHeigth - 200) });
        }
        //编辑手工领料
        function EditHand() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            //xiang.yan 2024-4-28  列取值由索引改为列明,功能已去除
            // 1 改为 ApplyType
            var result = getOneRecordCellTextByFiled("ApplyType");
            //xiang.yan 2024-4-28  列取值由索引改为列明,功能已去除
            // 15 改为 Statue
            var resultState = getOneRecordCellTextByFiled("Statue");
            if (resultState != "待备料" && resultState != "备料中") {
                alert("该发料单状态为" + resultState + "不能编辑");
                return false;
            }
            var orderState = 0;
            if (resultState == "备料中") {
                orderState = 1;
            }
            if (result == "手工增加" || result == "其他领料") {
                openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Material/MaterialApplyHandEdit.aspx?name=MaterialApplyEdit&ID=" + idStr + "&orderState=" + orderState;
                dialog({ title: mesLang("编辑领料申请"), src: openWinUrl, width: (windowWidth - 200), height: (windowHeigth - 200) });
            }
            if (result == "工单领料") {
                openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Material/MaterialApplyEdit.aspx?name=MaterialApplyEdit&ID=" + idStr + "&orderState=" + orderState;
                dialog({ title: mesLang("编辑领料申请"), src: openWinUrl, width: (windowWidth - 200), height: (windowHeigth - 200) });
            }
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
        
            if (idStr == "") return;
            dialog({ title: mesLang("查看详细"), src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Material/MaterialApplyView.aspx?name=MaterialApplyView&ID=" + idStr + "&rnd=" + Math.random(), width: 800, height: 400 });
        }

        function Refresh() {
            document.forms[0].submit();
        }

        //打印
        function ApplyPrint() {
            var idStr = getOneRecordId();
            if (idStr == "") {
                return false;
            }
            window.open("<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Material/MaterialApplyPrint.aspx?name=MaterialApplyPrint&ID=" + idStr);
        }

        //------------2017-7-4 委外领料单
        function AddOutside() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Material/MaterialApplyOutsideEdit.aspx?name=MaterialApplyOutsideAdd&ID=-1";
            dialog({ title: mesLang("添加委外领料申请"), src: openWinUrl, width: (windowWidth - 200), height: (windowHeigth - 200) });

        }

    </script>
</asp:Content>
