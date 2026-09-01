<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/ViewMaster.master" CodeBehind="TaskView.aspx.cs" Inherits="SKT.LeanMES.Web.SystemConfiguration.TaskView" %>

<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="Server">
    <table width="100%" class="ContentTable">
        <tr>
            <td class="Label2"><%=Resources.lang.TaskName%></td>
            <td class="Field2" colspan="3">
                <asp:Literal ID="ltrTaskName" runat="server"></asp:Literal>
            </td>
        </tr>
        <tr>
            <td class="Label2"><%=Resources.lang.ExecDll%></td>
            <td class="Field2" colspan="3">
                <asp:Literal ID="ltrExecDll" runat="server"></asp:Literal>
            </td>
        </tr>
        <tr>
            <td class="Label2"><%=Resources.lang.StartTime%></td>
            <td class="Field2">
                <asp:Literal ID="ltrStartTime" runat="server"></asp:Literal>
            </td>
            <td class="Label2"><%=Resources.lang.EndTime%></td>
            <td class="Field2">
                <asp:Literal ID="ltrEndTime" runat="server"></asp:Literal>
            </td>
        </tr>
        <tr>
            <td class="Label2"><%=Resources.lang.IntervalTime%></td>
            <td class="Field2" colspan="3">
                <asp:Literal ID="ltrIntervalTime" runat="server"></asp:Literal>Min
            </td>
        </tr>
        <tr>
            <td class="Label2"><%=Resources.lang.Trigger%><em>*</em></td>
            <td class="Field2" colspan="3">
                <asp:DropDownList ID="ddlTigger" runat="server" ClientIDMode="Static" Width="120px">
                    <asp:ListItem Value="1" Text="<%$ Resources:lang, EveryDay %>"></asp:ListItem>
                    <asp:ListItem Value="2" Text="<%$ Resources:lang, EveryWeek %>"></asp:ListItem>
                </asp:DropDownList>
                <span class="trigger day"></span>
                <span class="trigger week" style="display: none;">
                    <input type="checkbox" name="week" value="7" /><%=Resources.lang.Sunday%>
                    <input type="checkbox" name="week" value="1" /><%=Resources.lang.Monday%>
                    <input type="checkbox" name="week" value="2" /><%=Resources.lang.Tuesday%>
                    <input type="checkbox" name="week" value="3" /><%=Resources.lang.Wednesday%>
                    <input type="checkbox" name="week" value="4" /><%=Resources.lang.Thursday%>
                    <input type="checkbox" name="week" value="5" /><%=Resources.lang.Friday%>
                    <input type="checkbox" name="week" value="6" /><%=Resources.lang.Saturday%>
                </span>
            </td>
        </tr>
        <tr>
            <td class="Label2"><%=Resources.lang.TaskDesc%></td>
            <td class="Field2" colspan="3">
                <asp:Literal ID="ltrTaskDesc" runat="server"></asp:Literal>
            </td>
        </tr>
    </table>
    <table class="ListTable" width="100%">
        <tbody>
            <tr class="ListTableHeader">
                <th><%=Resources.lang.Sequence%></th>
                <th><%=Resources.lang.ExecTime%></th>
                <th><%=Resources.lang.ExecResult%></th>
                <th><%=Resources.lang.Message%></th>
            </tr>
            <tr class="ListTableOddRow">
                <td>1</td>
                <td>2020-04-06 00:01:00</td>
                <td>OK</td>
                <td></td>
            </tr>
            <tr class="ListTableOddRow">
                <td>2</td>
                <td>2020-04-07 00:01:00</td>
                <td>OK</td>
                <td></td>
            </tr>
        </tbody>
    </table>
    <asp:HiddenField ID="hidTiggerValue" runat="server" ClientIDMode="Static" />
    <script type="text/javascript">
        $(function () {
            showTigger();

            var tiggerValue = $("#hidTiggerValue").val();
            if (tiggerValue != "") {
                var arr = tiggerValue.split(",");
                $("input[name=\"week\"]").each(function (idx) {
                    //tiggerValue += idx == 0 ? "" : "," + $(this).val();
                    if (arr.indexOf($(this).val()) > -1) {
                        $(this).prop("checked", true);
                    }
                });
            }

            $("input[name=\"week\"]").attr("disabled", "disabled");

        });

        function showTigger() {
            var val = $("#ddlTigger").val();
            if (val == "1") {
                $(".trigger").hide();
                $(".day").show();
            } else if (val == "2") {
                $(".trigger").hide();
                $(".week").show();
            }
        }

    </script>
</asp:Content>

