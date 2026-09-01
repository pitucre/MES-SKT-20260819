<%@ Page Language="C#" MasterPageFile="~/Masters/ViewMaster.master"
    AutoEventWireup="true" CodeBehind="OnlineUser.aspx.cs" Inherits="SKT.LeanMES.Web.SystemConfiguration.OnlineUser" %>
<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="server">
 
    <div  style="border:1px solid #d3d3d3; background:#F8F8F8; padding:10px; line-height:22px; height:22px;">
        【提示】<span class="Tips">系统当前所在线人数为<%=Application["UserQty"].ToString() %>人，当前已在线<span id="onlineuserqty"></span>人。</span>
    </div>
    <div class="clear5"></div>
    <table class="ListTable" width="100%">
        <tr class="ListTableHeader">
            <th width="3%">序号</th>
            <th>用户名</th>
            <th>姓名</th>
            <th>工号</th>
            <th>最近一次访问时间</th>
        </tr>
    </table>
    <script type="text/javascript">
        $(function () {
            getOnlineUser();
        });

        function getOnlineUser() {
            $.ajax({
                url: 'OnlineUser.aspx?Action=getonlineuser&rnd=' + Math.random(),
                type: 'get',
                success: function (data) {
                    var _data = JSON.parse(data);
                    var logList = '';
                    var _css = 'ListTableOddRow';
                    if (_data) {
                        for (var i = 0; i < _data.length ; i++) {
                            if (i % 2 == 0) _css = 'ListTableEvenRow';
                            else _css = 'ListTableOddRow';
                            logList += '<tr class="' + _css + '">';
                            logList += '<td>' + (i + 1).toString() + '</td>';
                            logList += '<td>' + _data[i].UserName + '</td>';
                            logList += '<td>' + _data[i].EmployeeCName + '(' + _data[i].EmployeeEName + ')</td>';
                            logList += '<td>' + _data[i].EmployeeNo + '</td>';
                            logList += '<td>' + commonFormatDate(_data[i].LastVisitTime) + '</td>';
                            logList += '</tr>';
                        }
                        $("table").append(logList);
                        $("#onlineuserqty").html(_data.length);
                    }
                },
                datatype: 'text'
            });
        }
    </script>
</asp:Content>
