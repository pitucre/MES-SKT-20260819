<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ViewMaster.master" AutoEventWireup="true" CodeBehind="LoginLog.aspx.cs" Inherits="SKT.LeanMES.Web.SystemConfiguration.LoginLog" %>
<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="server">
    <style type="text/css">
        ul{padding:0; margin:0;float:left;line-height:22px;}
        ul li{float:left;padding:0; margin:0; margin-left:10px; height:22px; text-align:center; line-height:22px;}
        ul li:hover{cursor:pointer;  color:cornflowerblue}
        .current{ background:#ddd; border:1px solid #d3d3d3; font-weight:bold;}
    </style>
    <div  style="border:1px solid #d3d3d3; background:#F8F8F8; padding:10px; line-height:22px; height:22px;">
        <ul style="margin-left:0px;">
            <li style="font-weight:bold;"><%=Resources.lang.StartTime %>:</li>
            <li><input type="text" id="txtBegTime" class="DateTimeBox" style="width:150px" /></li>
            <li style="font-weight:bold;"><%=Resources.lang.EndTime %>:</li>
            <li><input type="text" id="txtEndTime" class="DateTimeBox" style="width:150px" /></li>
        </ul>
        <%--<ul class="list1">
            <li style="padding:0; margin:0; border:0; font-weight:bold;">按天查询：</li>
            <li style=" width:35px;" class="current" data-where="0">今天</li>
            <li style=" width:35px;" data-where="7">7天</li>
            <li style=" width:35px;" data-where="3">3天</li>
            <li style=" width:55px;" data-where="30">最近30天</li>
        </ul>--%>
          
        <ul style="margin-left:50px;">
            <li style="font-weight:bold;"><%=Resources.lang.UserNames %>:</li>
            <li><input type="text" id="username" class="TextBox"/><input type="button" onclick="search()" class="ButtonBox" style="width:40px; background:#aaaaaa; line-height:22px;" value="查询"/></li>
        </ul>
             
    </div>
    <div class="clear5"></div>
    <table class="ListTable" width="100%">
        <tr class="ListTableHeader">
            <th width="3%">序号</th>
            <th>用户名</th>
            <th>姓名</th>
            <th>员工编号</th>
            <th>部门</th>
            <th>客户端IP</th>
            <th>操作时间</th>
            <th>备注</th>
        </tr>
    </table>
    <script type="text/javascript">
        var str = 0;
        _isHms = true;
        $(function () {

            var myDate = new Date();//获取系统当前时间
            $("#txtBegTime").val(myDate.getFullYear() + "-" + ('00' + (parseInt(myDate.getMonth()) + 1)).slice(-2) + "-" + ('00' + myDate.getDate()).slice(-2) + " 00:00:00");
            $("#txtEndTime").val(myDate.getFullYear() + "-" + ('00' + (parseInt(myDate.getMonth()) + 1)).slice(-2) + "-" + ('00' + myDate.getDate()).slice(-2) + " 23:59:59");
            getLog($("#txtBegTime").val(),$("#txtEndTime").val(), $.trim($("#username").val()));

            $(".list1 li:gt(0)").click(function () {
                $(".current").removeClass("current");
                $(this).addClass("current");
                str = $(this).attr('data-where');
                getLog(str, $.trim($("#username").val()));
            });

            $("#username").change(function () {
                getLog($("#txtBegTime").val(), $("#txtEndTime").val(), $.trim($("#username").val()));
            });

            $(document).keypress(function () {
                var event = arguments.callee.caller.arguments[0] || window.event;
                if (event.keyCode == 13) {
                    search();
                    return false;
                }
            });
        });

        function search() {
            getLog($("#txtBegTime").val(), $("#txtEndTime").val(), $.trim($("#username").val()));
        }

        function getLog(BegTime, EndTime, strwhere1) {
            $.ajax({
                url: 'LoginLog.aspx?Action=getlog&BegTime=' + BegTime + '&EndTime=' + EndTime + '&strwhere1=' + escape(strwhere1) + '&rnd=' + Math.random(),
                type: 'get',
                success: function (data) {
                    var _data = eval('(' + data + ')');
                    var logList = '';
                    var _css = 'ListTableOddRow';
                    $("table tr:gt(0)").remove();
                    if (parseInt(_data.totals) == 0) {
                        $("table").append('<tr class="ListTableEmptyDataRow"><td colspan="8">没有数据</td></tr>');
                        return false;
                    }
                    for (var i = 0; i < parseInt(_data.totals) ; i++) {
                        if (i % 2 == 0) _css = 'ListTableEvenRow';
                        else _css = 'ListTableOddRow';
                        logList += '<tr class="' + _css + '">';
                        logList += '<td>' + (i + 1).toString() + '</td>';
                        logList += '<td>' + _data.data[i].username + '</td>';
                        logList += '<td>' + _data.data[i].cname + '(' + _data.data[i].ename + ')</td>';
                        logList += '<td>' + _data.data[i].employeeno + '</td>';
                        logList += '<td>' + _data.data[i].departname + '</td>';
                        logList += '<td>' + _data.data[i].loginclientip + '</td>';
                        logList += '<td>' + _data.data[i].logintime + '</td>';
                        logList += '<td>' + _data.data[i].remark + '</td>';
                        logList += '</tr>';
                    }
                    
                    $("table").append(logList);
                },
                datatype: 'text'
            });
        }
    </script>
</asp:Content>
