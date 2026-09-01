<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" CodeBehind="TransfersApply.aspx.cs" Inherits="SKT.LeanMES.Web.Transfers.TransfersApply" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label3">调拨单号</td>
            <td class="Field3">
                <asp:TextBox ID="txtTransfersNo" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">来源单号</td>
            <td class="Field3">
                <asp:TextBox ID="txtSourceNo" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">创建时间
            </td>
            <td class="Field3">
                <input type="text" id="txtDateF" class="DateTimeBox" runat="server" readonly="readonly" />
                -
                <input type="text" id="txtDateT" class="DateTimeBox" runat="server" readonly="readonly" />
            </td>
        </tr>
        <tr>
            <td class="Label3">调拨类型</td>
            <td class="Field3">
                <asp:DropDownList ID="ddlType" runat="server">
                    <asp:ListItem Value="">全部</asp:ListItem>
                    <asp:ListItem Value="1">委外调拨</asp:ListItem>
                    <asp:ListItem Value="0">无订单调拨</asp:ListItem>
                    <asp:ListItem Value="3">超期不良调拨</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td class="Label3">调拨状态</td>
            <td class="Field3">
                <asp:DropDownList ID="ddlState" runat="server">
                    <asp:ListItem Value="">全部</asp:ListItem>
                    <asp:ListItem Value="0">待调拨</asp:ListItem>
                    <asp:ListItem Value="1">调拨中</asp:ListItem>
                    <asp:ListItem Value="3">出库完成</asp:ListItem>
                    <asp:ListItem Value="2">调拨完成</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td class="Label3">创建人</td>
            <td class="Field3">
                <asp:TextBox ID="txtCreateBy" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label3">调拨部门</td>
            <td class="Field3">
                <asp:TextBox ID="txtDepartName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">调出仓</td>
            <td class="Field3">
                <asp:TextBox ID="txtOutWhName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">调入仓</td>
            <td class="Field3">
                <asp:TextBox ID="txtInWhName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" OnRowDataBound="GridView1_RowDataBound">
        <Columns>
            <asp:BoundField DataField="TransfersNo" HeaderText="调拨单号" SortExpression="TransfersNo" />
            <asp:BoundField DataField="TransfersTypeName" HeaderText="调拨类型" SortExpression="TransfersType" ItemStyle-CssClass="transfer-type" />
            <asp:BoundField DataField="OutWhName" HeaderText="调出仓" />
            <asp:BoundField DataField="InWhName" HeaderText="调入仓" />
            <asp:BoundField DataField="SourceNo" HeaderText="来源单号" SortExpression="SourceNo" />
            <asp:BoundField DataField="StatueName" HeaderText="调拨单状态" SortExpression="Statue" />
            <asp:BoundField DataField="DepartName" HeaderText="调拨部门" />
            <asp:BoundField DataField="EName" HeaderText="创建人" SortExpression="EName" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="创建时间" SortExpression="CreateDateTime" DataFormatString="{0:yyyy-MM-dd}" />
             <asp:BoundField DataField="ModifyBy" HeaderText="修改人" SortExpression="ModifyBy" />
            <asp:BoundField DataField="ModifyDateTime" HeaderText="修改时间" SortExpression="ModifyDateTime" DataFormatString="{0:yyyy-MM-dd}" />
            <asp:BoundField DataField="AuditingName" HeaderText="调拨审核人" />
            <asp:BoundField DataField="AuditingStatue" HeaderText="调拨申请审核" SortExpression="AuditingStatue" />
            <asp:BoundField DataField="Remark" HeaderText="补充说明" />
            <asp:BoundField DataField="EndUserName" HeaderText="结束调拨操作人" />
            <asp:BoundField DataField="EndDate" HeaderText="结束调拨时间" SortExpression="EndDate" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.AjaxCommon.DBService"
        SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:HiddenField ID="hdnOperate" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="hdnIdString" runat="server" ClientIDMode="Static" />

    <script type="text/javascript">
        isMultiple = false;
        var openWinUrl = "";
        var gridClientId = "<%=this.GridView1.ClientID%>";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");

        function AddHandTransfers() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Transfers/TransfersApplyEdit.aspx?name=TransfersApplyAdd&ID=-1";
            dialog({ title: mesLang("添加无订单调拨申请"), src: openWinUrl, width: 950, height: 400 });
        }

        function AddPoTransfers() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Transfers/TransfersApplyPoEdit.aspx?name=TransfersApplyAdd&ID=-1";
            dialog({ title: mesLang("添加委外调拨申请"), src: openWinUrl, width: 950, height: 400 });
        }

        function AddCQTransfers() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Transfers/TransfersApplyCqEdit.aspx?name=TransfersApplyAdd&ID=-1";
            dialog({ title: mesLang("添加超期不良调拨申请"), src: openWinUrl, width: 950, height: 400 });
        }
        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            var statueName = getOneRecordCellTextByFiled("StatueName");
            var resultState = getOneRecordCellTextByFiled("AuditingStatue");
       
            if (resultState == "已审核") {
                alert("该调拨申请单状态为【" + resultState + "】,不能编辑！");
                return false;
            }
            if (statueName != "待调拨") {
                alert("该调拨申请单状态为【" + statueName + "】,不能编辑！");
                return false;
            }
            var resultType = getOneRecordCellTextByFiled("TransfersTypeName");
            if (resultType == "委外调拨") {
                openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Transfers/TransfersApplyPoEdit.aspx?name=TransfersApplyEdit&ID=" + idStr;
                dialog({ title: mesLang("编辑委外调拨申请"), src: openWinUrl, width: 950, height: 400 });
            }
            else if (resultType == "无订单调拨")
            {
                openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Transfers/TransfersApplyEdit.aspx?name=TransfersApplyEdit&ID=" + idStr;
                dialog({ title: mesLang("编辑无订单调拨申请"), src: openWinUrl, width: 950, height: 400 });
            }
            else {
                openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Transfers/TransfersApplyCqEdit.aspx?name=TransfersApplyCqEdit&ID=" + idStr;
                dialog({ title: mesLang("编辑超期不良调拨申请"), src: openWinUrl, width: 950, height: 400 });
            }
    }

    function Delete() {
        var idStr = getDeletingRecordIdString();
        if (idStr == "") return false;
        var listAuditingStatue = getRecordCellTextsByFiled("AuditingStatue").split(",");
        if (listAuditingStatue.length > 0) {
            for (var i = 0; i < listAuditingStatue.length; i++) {
                if (listAuditingStatue[i] == "已审核") {
                    alert("存在【已审核】的调拨申请单,不能删除！");
                    return false;
                }
            }
        }
        var entity = {};
        entity.IdString = idStr;
        entity.UserName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
            var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("Prod_Transfers_Delete", JSON.stringify(entity));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert("删除成功");
            document.forms[0].submit();
        }

        function View() {
            var idStr = getOneRecordId();
            if (idStr == "") return;
            dialog({ title: mesLang("查看详细"), src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Transfers/TransferApplyView.aspx?name=TransferApplyView&ID=" + idStr + "&rnd=" + Math.random(), width: 950, height: 400 });
        }

        function Refresh() {
            document.forms[0].submit();
        }

        function Print() {
            var idStr = getOneRecordId();
            if (idStr == "") return;

            var result = getOneRecordCellTextByFiled("TransfersTypeName");
            var TransfersCate = 0;
            if (result == "委外调拨") {
                TransfersCate = 1;
            }
            window.open("<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Transfers/TransfersPrint.aspx?ID=" + idStr + "&TransfersCate=" + TransfersCate);
        }

        //导出
        function Import() {
            hdnOperate.val("exportExcel");
            document.forms[0].submit();
            hdnOperate.val("");
        }

        //检验报告审核
        function AudiInspection() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            //by liwen 20200715
            var arr = $("input[type='checkbox'][value='" + idStr + "']").parents("tr.ListTableSelectedRow").find("td");
            var resultState = getOneRecordCellTextByFiled("AuditingStatue");
            if (resultState == "已审核") {
                alert("调拨申请已经审核,不能再审核!");
                return false;
            }
            if (!window.confirm("是否确认审核？")) {
                return "";
            }

            var entity = {};
            entity.TransfersId = idStr;
            entity.UserId = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserId %>";;
            var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("upsTransfersApplyAudi", JSON.stringify(entity));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return;
            }
            alert("审核成功");
            document.forms[0].submit();
        }

        function FinishTransfers() {
            var idStr = getRecordIdString();
            if (idStr == "") return false;
            if (!window.confirm("是否确认结束调拨申请？")) {
                return "";
            }
            var entity = {};
            entity.TransfersId = idStr;
            entity.UserId = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserId %>";;
            var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("upsTransfersApplyEnd", JSON.stringify(entity));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return;
            }
            alert("结束调拨申请成功");
            document.forms[0].submit();
        }

        
    </script>
</asp:Content>



