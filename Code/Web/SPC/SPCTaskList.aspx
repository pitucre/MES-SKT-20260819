<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true"
    CodeBehind="SPCTaskList.aspx.cs" Inherits="SKT.LeanMES.Web.SPC.SPCTaskList" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">
                项目名称
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtSPCProjectName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label2">
                任务名称
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtTaskName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" OnRowDataBound="GridView1_RowDataBound">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="ProjectName" HeaderText="项目名称" HeaderStyle-Width="120px" />
            <asp:BoundField DataField="TaskName" HeaderText="任务名称" HeaderStyle-Width="140px" />
            <asp:BoundField DataField="TaskDesc" HeaderText="任务描述" />
            <asp:BoundField DataField="GraphType" HeaderText="图表类型" HeaderStyle-Width="100px" />
            <asp:BoundField DataField="ItemCode" HeaderText="产品编码" HeaderStyle-Width="120px" />
            <asp:BoundField DataField="Units" HeaderText="单位" HeaderStyle-Width="60px" />
            <asp:BoundField DataField="LineName" HeaderText="线别" HeaderStyle-Width="80px" />
            <asp:BoundField DataField="Station" HeaderText="工序" HeaderStyle-Width="80px" />
            <asp:BoundField DataField="USL" HeaderText="规格上限" HeaderStyle-Width="80px" />
            <asp:BoundField DataField="LSL" HeaderText="规格下限" HeaderStyle-Width="80px" />

            <asp:BoundField DataField="CreateBy" HeaderText="创建人"  />
            <asp:BoundField DataField="CreateDateTime" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" HeaderText="创建时间"/>
            <asp:BoundField DataField="ModifyBy" HeaderText="修改人"  />
            <asp:BoundField DataField="ModifyDateTime" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" HeaderText="修改时间" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.SPC.BLL.SPCTask"
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
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SPC/SPCTaskEdit.aspx?name=SPC_TaskAdd&ID=-1";
            dialog({ title: "<%=Resources.Pages.SPC_TaskAdd %>", src: openWinUrl, width: 650, height: 400 });
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SPC/SPCTaskEdit.aspx?name=SPC_TaskEdit&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.SPC_TaskEdit %>", src: openWinUrl, width: 650, height: 400 });
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

        function ExecGraph() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;

            var graphType = "";
                        
            $("input[name=chkSelect]").each(
                function (i, item) {
                    if (item.value == idStr) {
                        graphType = $.trim($(item).parent().parent().find("td:eq(4)").html());
                    }
                }
            );
            if (graphType == "X-bar R") {
                openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SPC/XBar-RGraph.aspx?name=SPC_TaskExecGraph&ID=" + idStr;
            }
            else if (graphType == "np Chart") {
                openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SPC/NPChartGraph.aspx?name=SPC_TaskExecGraph&ID=" + idStr;
            }
            else if (graphType == "c Chart") {
                openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SPC/CChartGraph.aspx?name=SPC_TaskExecGraph&ID=" + idStr;
            }
            else if (graphType == "p Chart") {
                openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SPC/PChartGraph.aspx?name=SPC_TaskExecGraph&ID=" + idStr;
            }
            else if (graphType == "u Chart") {
                openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SPC/UChartGraph.aspx?name=SPC_TaskExecGraph&ID=" + idStr;
            }

            window.open(openWinUrl, idStr);
        }
    </script>
</asp:Content>
