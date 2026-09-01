<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ViewMaster.master" AutoEventWireup="true"
    CodeBehind="StationParamView.aspx.cs" Inherits="SKT.LeanMES.Web.Station.StationParamView" %>

<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="server">
    <div style="min-width: 560px;">
        <table width="100%" class="EditeContentTable">
            <tr>
                <td class="Label2">
                    <%= Resources.lang.StationName %>
                </td>
                <td class="Field2" style="min-width: 250px">
                    <asp:Label ID="lblStationName" runat="server" ClientIDMode="Static"></asp:Label>
                </td>
                <td class="Label2">
                    <%= Resources.lang.StationType %>
                </td>
                <td class="Field2">
                    <asp:Label ID="lblStationType" runat="server" ClientIDMode="Static"></asp:Label>
                </td>
            </tr>
        </table>
        <div class="clear5">
        </div>
        <div class="divHeader">
            工序工艺参数列表</div>
        <table id="tableParam" width="100%" class="ListTable">
            <tr class="ListTableHeader">
                <th style="width: 60px">
                    <%= Resources.lang.Sequence %>
                </th>
                <th style="width: 160px">
                    <%= Resources.lang.ParamName %>
                </th>
                <th>
                    <%= Resources.lang.ParamValue %>
                </th>
            </tr>
            <tr class="ListTableEmptyDataRow">
                <td colspan="3">
                   当前选择工序还没有任何工艺参数，请点击'添加参数'来为工序增加工艺参数
                </td>
            </tr>
        </table>
    </div>
    <script type="text/javascript">
        $(document).ready(function () {
            var stdId = '<%=Request.QueryString["ID"] %>';
            if (parseInt(stdId) != -1) {
                ShowParamList(stdId);
                var stationName = '<%=Request.QueryString["StationName"] %>';
                var stationTypeName = '<%=Request.QueryString["StationTypeName"] %>';
                $("#lblStationName").text(decodeURIComponent(stationName));
                $("#lblStationType").text(decodeURIComponent(stationTypeName));
            }
        });

        /* 清空指定table中数据 */
        function clearWaitGrnTable() {
            if ($("#tableParam tr").length > 1) {
                $("#tableParam tr:not(:first)").remove();
                $("#tableParam").append("<tr class='ListTableEmptyDataRow'><td colspan='4'>" + mesLang("当前选择工序还没有任何工艺参数，请点击'添加参数'来为工序增加工艺参数")+"</td></tr>");
            }
        }

        //显示已配置参数列表
        function ShowParamList(id) {
            if (id == -1) {
                return false;
            }
            var tableParam = document.getElementById("tableParam");

            var row, cel;
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxProduct.GetStationParamList(-1, id);

            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            } else if (ajax.value != null && ajax.value != undefined && ajax.value.length > 0) {
                $("#tableParam tr:gt(0)").remove();
                var entity = ajax.value;

                for (var i = 0; i < entity.length; i++) {
                    row = tableParam.insertRow(tableParam.rows.length);
                    row.className = "ListTableEvenRow";

                    cel = row.insertCell(0);
                    cel.style.cssText = "text-align:center";
                    cel.innerHTML = entity[i].ParamSeq;

                    cel = row.insertCell(1);
                    cel.innerHTML = entity[i].ParamName;

                    cel = row.insertCell(2);
                    cel.innerHTML = entity[i].ParamValue;

                }
            }
            else {
                clearWaitGrnTable();
            }
        }

        function Edit() {
            var idStr = '<%=Request.QueryString["ID"] %>';
            if (idStr == "") return false;
            var stationName = '<%=Request.QueryString["StationName"] %>';
            var stationTypeName = '<%=Request.QueryString["StationTypeName"] %>';
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Station/StationParamAdd.aspx?name=Station_StationParamEdit&ID=" + idStr + "&StationName=" + encodeURIComponent(stationName) + "&StationTypeName=" + encodeURIComponent(stationTypeName);
            location.href = openWinUrl;
        }
    </script>
</asp:Content>
