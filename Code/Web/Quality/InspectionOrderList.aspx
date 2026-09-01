<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true"
    CodeBehind="InspectionOrderList.aspx.cs" Inherits="SKT.LeanMES.Web.Quality.InspectionOrderList" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label3">
                <%= Resources.lang.InspectionOrderNo%>
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtInspectionOrderNo" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">
                <%= Resources.lang.InspectionType %>
            </td>
            <td class="Field3">
                <%--<asp:DropDownList ID="ddlInspectionType" runat="server" ClientIDMode="Static">
                </asp:DropDownList>
                <asp:HiddenField ID="hfInspectionType" runat="server" ClientIDMode="Static" Value="-1" />--%>
                <asp:DropDownList ID="ddlInspectionTypeSelect" runat="server">
                    <asp:ListItem Value="">请选择</asp:ListItem>
                    <asp:ListItem Value="IPQC">IPQC</asp:ListItem>
                    <asp:ListItem Value="首件检验">首件检验</asp:ListItem>
                    <asp:ListItem Value="工程检验">工程检验</asp:ListItem>
                    <asp:ListItem Value="末件检验">末件检验</asp:ListItem>
                </asp:DropDownList>
            </td>
            <%--<td class="Label3">
                <%= Resources.lang.GroupAffirmStatusName%>
            </td>
            <td class="Field3">
                 <asp:DropDownList ID="ddlGroupAffirmStatus" runat="server">
                    <asp:ListItem Value="-2" >请选择</asp:ListItem>
                    <asp:ListItem Value="-1" >待审核</asp:ListItem>
                    <asp:ListItem Value="0" >通过</asp:ListItem>
                    <asp:ListItem Value="1">不通过</asp:ListItem>
                </asp:DropDownList>
            </td>--%>
        </tr>
        <tr>
            <%--<td class="Label3">
                <%= Resources.lang.OrderNo%>
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtOrderNo" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>--%>
            <td class="Label3">
                <%= Resources.lang.ItemCode %>
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtItemCode" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">
                <%=Resources.lang.Line%>
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtLine" runat="server" CssClass="TextBox" Enabled="false"></asp:TextBox>
                <input type="button" id="btnLine" class="ButtonBox" value="..." title="选择产线" onclick="selectLineName();" />
                <asp:HiddenField ID="hdnLineId" runat="server" Value="-1" />
                <asp:HiddenField ID="hdnLineName" runat="server" Value="" />
            </td>
            <%-- <td class="Label3">
                <%= Resources.lang.ProjectAffirmStatusName%>
            </td>
            <td class="Field3">
                 <asp:DropDownList ID="ddlProjectAffirmStatus" runat="server">
                    <asp:ListItem Value="-2" >请选择</asp:ListItem>
                    <asp:ListItem Value="-1" >待审核</asp:ListItem>
                    <asp:ListItem Value="0" >通过</asp:ListItem>
                    <asp:ListItem Value="1">不通过</asp:ListItem>
                </asp:DropDownList>
            </td>--%>
        </tr>
        <tr>
            <td class="Label3">
                <%= Resources.lang.StartTime%>
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtStartTime" runat="server" CssClass="DateTimeBox"></asp:TextBox>
            </td>
            <td class="Label3">
                <%= Resources.lang.EndTime%>
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtEndTime" runat="server" CssClass="DateTimeBox"></asp:TextBox>
            </td>
            <%--  <td class="Label3">
                <%= Resources.lang.AuditStatus%>
            </td>
            <td class="Field1">
                 <asp:DropDownList ID="ddlAuditStatus" runat="server">
                    <asp:ListItem Value="-1" >请选择</asp:ListItem>
                    <asp:ListItem Value="0" >待审核</asp:ListItem>
                    <asp:ListItem Value="1" >已审核</asp:ListItem>
                    <asp:ListItem Value="2" >免审核</asp:ListItem>
                </asp:DropDownList>
            </td>--%>
        </tr>
        <tr>
            <td class="Label3">客户料号
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtCPN" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
        <%-- <tr>
             <td class="Label3">
                <%=Resources.lang.Line%>
            </td>
            <td class="Field3" colspan="5">
                <asp:TextBox ID="txtLine" runat="server" CssClass="TextBox" Enabled="false"></asp:TextBox>
                <input type="button" id="btnLine" class="ButtonBox" value="..." title="选择产线" onclick="selectLineName();" />
                <asp:HiddenField ID="hdnLineId" runat="server" Value="-1" />
                <asp:HiddenField ID="hdnLineName" runat="server" Value="" />
            </td>
        </tr>--%>
    </table>
    <%--    <div style="display: none;"><asp:Button ID="btnExport" runat="server" OnClick="btnExport_Click" Text="导出" /></div>--%>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
    <asp:GridView ID="GridView1" AutoGenerateColumns="false" runat="server" OnRowDataBound="GridView1_RowDataBound">
        <Columns>
            <asp:BoundField DataField="InspectionOrderNo" HeaderText="<%$Resources:lang,InspectionOrderNo %>" ItemStyle-Width="120px" />
            <asp:BoundField DataField="LineName" HeaderText="<%$Resources:lang,LineName %>" ItemStyle-Width="120px" />
            <%--<asp:BoundField DataField="InspectionTypeName" HeaderText="<%$Resources:lang,InspectionTypeName %>"
                ItemStyle-Width="120px" />--%>
            <%-- <asp:BoundField DataField="OrderNo" HeaderText="<%$Resources:lang,OrderNum %>" ItemStyle-Width="120px" />--%>
            <asp:BoundField DataField="ItemCode" HeaderText="<%$Resources:lang,ItemCode %>" ItemStyle-Width="120px" />
            <asp:BoundField DataField="ItemName" HeaderText="<%$Resources:lang,ItemName %>" ItemStyle-Width="120px" />
            <asp:BoundField DataField="CPN" HeaderText="客户料号" ItemStyle-Width="120px" />
            <asp:BoundField DataField="InspectionSelectType" HeaderText="类型" ItemStyle-Width="120px" />
            <asp:BoundField DataField="AuditStatusName" HeaderText="<%$Resources:lang,AuditStatus %>" ItemStyle-Width="120px" />
            <%--  <asp:BoundField DataField="AuditStatusName" HeaderText="<%$Resources:lang,AuditStatus %>"
                ItemStyle-Width="120px" />
            <asp:BoundField DataField="AuditResult" HeaderText="审核结果" ItemStyle-Width="120px" />
             <asp:BoundField DataField="GroupAffirmStatusName" HeaderText="<%$Resources:lang,GroupAffirmStatusName %>" ItemStyle-Width="120px" />
            <asp:BoundField DataField="ProjectAffirmStatusName" HeaderText="<%$Resources:lang,ProjectAffirmStatusName %>" ItemStyle-Width="120px" />--%>
            <asp:BoundField DataField="CreateBy" HeaderText="创建人" ItemStyle-Width="120px" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="<%$Resources:lang,CreateTime %>" ItemStyle-Width="120px" />
            <asp:BoundField DataField="SystemType">
                <HeaderStyle CssClass="hide" />
                <ItemStyle CssClass="hide" />
            </asp:BoundField>
            <asp:BoundField DataField="LineName">
                <HeaderStyle CssClass="hide" />
                <ItemStyle CssClass="hide" />
            </asp:BoundField>
            <asp:BoundField DataField="Station">
                <HeaderStyle CssClass="hide" />
                <ItemStyle CssClass="hide" />
            </asp:BoundField>
            <asp:BoundField DataField="ResourceId">
                <HeaderStyle CssClass="hide" />
                <ItemStyle CssClass="hide" />
            </asp:BoundField>
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Quality.BLL.InspectionOrder"
        SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
        <input type="hidden" id="hdnOperate" name="hdnOperate" value=""/>
    <input type="hidden" id="hdnIdString" name="hdnIdString" value=""/>

    <script type="text/javascript">
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");
        var EditType = ["工程检验", "首件检验", "末件检验"];
        $(function () {

            $(".DateTimeBox").change(function () {
                if ($(this).val() == null || $(this).val() === "") return false;
                $(this).val(intToDate($(this).val()));
            });
        });

        function Accept() {
            var Id = getOneRecordId();
            if (Id == "") {
                return;
            }
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Quality/InspectionOrderConfirmation.aspx?name=InspectionOrderAudit_Confirmation&Id=" + Id;
            dialog({ title: "<%=Resources.Pages.InspectionOrderAudit_Confirmation %>", src: openWinUrl, width: 400, height: 200 });

        }

        //查看
        function View() {
            var Id = getOneRecordId();
            if (Id == "") {
                return;
            }
            //xiang.yan 2024-4-28  列取值由索引改为列明
            // 2 改为 InspectionTypeName
            if (getOneRecordCellTextByFiled("InspectionTypeName") == "OQC") {
                openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Quality/OQCReport.aspx?IOrderId=" + Id;
                window.open(openWinUrl, "newWindow", "fullscreen=yes, top=0, left=0,menubar=0,scrollbars=1, resizable=1,status=1,titlebar=0,toolbar=0,location=1");
                return;
            }
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Quality/InspectionOrderConView.aspx?name=InspectionOrderAudit_View&Type=" + getOneRecordCellTextByFiled("SystemType") + "&Id=" + Id;
            dialog({ title: "<%=Resources.Pages.InspectionOrderAudit_View %>", src: openWinUrl, width: 1000, height: 980 });

        }

        function Edit() {
            var idStr = getOneRecordId();
            var types = getOneRecordCellTextByFiled("InspectionSelectType");
            var audit = getOneRecordCellTextByFiled("AuditStatusName");
            if (idStr === "") return false;
            if ($.inArray(types, EditType) == -1) {
                alert("该类型无法编辑!")
                return false;
            }
            if (audit == "已审核") {
                alert("该单据已审核无法编辑!")
                return false;
            }
            var LineName = getOneRecordCellTextByFiled("LineName");
            var Station = getOneRecordCellTextByFiled("Station");
            var ResourceId = getOneRecordCellTextByFiled("ResourceId");
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Client/IPQCInspectionProject.aspx?name=IPQCInspection_ProCollectionUIProject&prodline=" + LineName + "&stationid=9&station=" + Station + "&resourceid=" + ResourceId + "&editProjectId=" + idStr;
            window.open(openWinUrl);
        }

        //打印
        function Print() {
            var Id = getOneRecordId();
            if (Id == "") {
                return;
            }
            //openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Quality/InspectionOrderPrint.aspx?name=InspectionOrderAudit_Print&Id=" + Id;
            //dialog({ title: "<%=Resources.Pages.InspectionOrderAudit_Print %>", src: openWinUrl, width: 1000, height: 980 });
            window.open("<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Quality/PreviewPDF.aspx?PreviewType=InspectionOrder&ids=" + Id);
        }

        //组长确认
        function GroupAffirm() {
            var Id = getOneRecordId();
            if (Id == "") {
                return;
            }
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Quality/InspectionOrderGroupAffirm.aspx?name=InspectionOrderAudit_GroupAffirm&Id=" + Id;
            dialog({ title: "<%=Resources.Pages.InspectionOrderAudit_GroupAffirm %>", src: openWinUrl, width: 400, height: 200 });

        }

        //工程确认
        function ProjectAffirm() {
            var Id = getOneRecordId();
            if (Id == "") {
                return;
            }
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Quality/InspectionOrderProjectAffirm.aspx?name=InspectionOrderAudit_ProjectAffirm&Id=" + Id;
            dialog({ title: "<%=Resources.Pages.InspectionOrderAudit_ProjectAffirm %>", src: openWinUrl, width: 400, height: 200 });

        }

<%--        function Export() {
            $("#<%=this.btnExport.ClientID %>").click();
        }--%>

        function UpdateList() {
            document.forms[0].submit();
        }


        /*选择线别*/
        function selectLineName() {
            temp = 1;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=21&Multiple=false&rnd=" + Math.random(), width: 500, height: 300 });
        }


        function getChooseValue(list) {
            if (temp === 1) {
                $("#<%=this.txtLine.ClientID %>").val(list[0][1]);
                $("#<%=this.hdnLineId.ClientID %>").val(list[0][0]);
                $("#<%=this.hdnLineName.ClientID %>").val(list[0][1]);
            }
        }

        $(function () {
            $("#ddlInspectionType").change(function () {
                $("#hfInspectionType").val($(this).val());

            })
        })
        function Delete() {
            var idStr = getDeletingRecordIdString();
            if (idStr === "") return false;
            hdnOperate.val("delete");
            hdnIdString.val(idStr);
            document.forms[0].submit();
        }

    </script>
</asp:Content>
