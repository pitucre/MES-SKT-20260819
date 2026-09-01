<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" CodeBehind="ScrapApply.aspx.cs" Inherits="SKT.LeanMES.Web.Scrap.ScrapApply" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label3">报废单号</td>
            <td class="Field3">
                <asp:TextBox ID="txtScrapNo" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>

            <td class="Label3">创建时间
            </td>
            <td class="Field3">
                <input type="text" id="txtDateF" class="DateTimeBox" runat="server" readonly="readonly" />
                -
                <input type="text" id="txtDateT" class="DateTimeBox" runat="server" readonly="readonly" />
            </td>
            <td class="Label3">创建人</td>
            <td class="Field3">
                <asp:TextBox ID="txtCreateBy" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label3">报废部门</td>
            <td class="Field3">
                <asp:TextBox ID="txtDepartName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>

            <td class="Label3">报废状态</td>
            <td class="Field3">
                <asp:DropDownList ID="ddlState" runat="server">
                    <asp:ListItem Value="">全部</asp:ListItem>
                    <asp:ListItem Value="0">待报废</asp:ListItem>
                    <asp:ListItem Value="1">报废中</asp:ListItem>
                     <asp:ListItem Value="3">已提交（扫码完成）</asp:ListItem>
                    <asp:ListItem Value="2">报废完成</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td class="Label3">仓库</td>
            <td class="Field3">
                <asp:TextBox ID="txtOutWhName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
        <tr>

            <%--         <td class="Label3">调出仓</td>
            <td class="Field3">
                <asp:TextBox ID="txtOutWhName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">调入仓</td>
            <td class="Field3">
                <asp:TextBox ID="txtInWhName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3"></td>
            <td class="Field3"></td>--%>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" OnRowDataBound="GridView1_RowDataBound">
        <Columns>
            <asp:BoundField DataField="ScrapNo" HeaderText="报废单号" SortExpression="ScrapNo" />
            <asp:BoundField DataField="WhName" HeaderText="仓库" />
            <asp:BoundField DataField="StatueName" HeaderText="报废单状态" SortExpression="Statue" />
            <asp:BoundField DataField="DepartName" HeaderText="报废部门" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="创建时间" SortExpression="CreateDateTime" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
            <asp:BoundField DataField="CreateBy" HeaderText="创建人" />
            <asp:BoundField DataField="ModifyBy" HeaderText="修改人" />
            <asp:BoundField DataField="ModifyDateTime" HeaderText="修改时间" SortExpression="ModifyDateTime" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
            <asp:BoundField DataField="AuditingName" HeaderText="报废审核人" />
            <asp:BoundField DataField="AuditingStatue" HeaderText="报废申请审核" SortExpression="AuditingStatue" />
            <asp:BoundField DataField="Remark" HeaderText="补充说明" />
            <asp:BoundField DataField="EndUserName" HeaderText="结束报废操作人" />
            <asp:BoundField DataField="EndDate1" HeaderText="结束报废时间" SortExpression="EndDate" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Scrap.BLL.Scraps"
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
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");

        function AddScrapOrder() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Scrap/ScrapApplyEdit.aspx?name=ScrapApplyAdd&ID=-1";
            dialog({ title: mesLang("添加报废申请"), src: openWinUrl, width: 950, height: 400 });
        }



        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            //xiang.yan 2024-4-28  列取值由索引改为列明
            // 8>10 改为 AuditingStatue
            var resultState = getOneRecordCellTextByFiled("AuditingStatue");
            if (resultState == "已审核") {
                alert("该报废申请单状态为【" + resultState + "】,不能编辑!");
                return false;
            }
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Scrap/ScrapApplyEdit.aspx?name=ScrapApplyEdit&ID=" + idStr;
            dialog({ title: mesLang("编辑报废申请单"), src: openWinUrl, width: 950, height: 400 });

        }

        function Delete() {
            var c = $("input[name='chkSelect']:checked");
            if (c.length != 1) {
                alert("请选择一条数据进行删除！");
                return false;
            }
            if (c[0].parentElement.parentElement.cells[8].innerText == "已审核") {
                alert("该报费申请单状态为【已审核】,不能删除！");
                return false;
            }
            var idStr = getDeletingRecordIdString();
            if (idStr == "")
                return false;
            hdnOperate.val("delete");
            hdnIdString.val(idStr);
            Refresh();
        }

        function View() {
            var idStr = getOneRecordId();
            if (idStr == "") return;
            dialog({ title: mesLang("查看详细"), src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Scrap/ScrapApplyView.aspx?name=ScrapApplyView&ID=" + idStr + "&rnd=" + Math.random(), width: 950, height: 400 });
        }

        function Refresh() {
            document.forms[0].submit();
        }

        function Print() {
            var idStr = getOneRecordId();
            if (idStr == "") return;

            //xiang.yan 2024-4-28  列取值由索引改为列明， 该字段后面未使用注释
            //var result = getOneRecordCellText(2);

            window.open("<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Scrap/ScrapPrint.aspx?ID=" + idStr);
        }

        //导出
        function Import() {
            hdnOperate.val("exportExcel");
            Refresh();
            hdnOperate.val("");
        }

        //检验报告审核
        function AudiInspection() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            if (!window.confirm("是否确认审核？")) {
                return "";
            }
            var scrapId = idStr;
            var userId = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserId %>";
             var ajax = SKT.LeanMES.Web.AjaxServices.AjaxScrapApply.ScrapApplyAuditing(scrapId, userId);

             if (ajax.error != null) {
                 alert(ajax.error.Message);
                 return;
             }
             alert("审核成功");
             Refresh();
         }

         function FinishScrap() {
             var idStr = getRecordIdString();
             if (idStr == "") return false;
             if (!window.confirm("是否确认结束报废申请？")) {
                 return "";
             }
             var scrapId = idStr;
             var userId = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserId %>";
             var ajax = SKT.LeanMES.Web.AjaxServices.AjaxScrapApply.ScrapApplyEnd(scrapId, userId);
             if (ajax.error != null) {
                 alert(ajax.error.Message);
                 return;
             }
             alert("结束报废申请成功");
             Refresh();
         }
    </script>
</asp:Content>



