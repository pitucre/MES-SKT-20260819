<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/Masters.master" CodeBehind="SchedulOrderGantt.aspx.cs" Inherits="SKT.LeanMES.Web.Plan.SchedulOrderGantt" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript" src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/jquery-1.9.1.js"></script>
      <link href="../Content/plugin/tabs/tabs.css" rel="stylesheet" />
    <script src="../Content/plugin/tabs/jPlugin-tabs.js"></script>
    <link href="../Content/jsgantt/css/style.css" rel="stylesheet" />


    <style type="text/css">
        body {
            font-family: Helvetica, Arial, sans-serif;
            font-size: 13px;
            padding: 0 0 50px 0;
        }

        .contain {
            width: 100%;
            margin: 0 auto;
        }

        h1 {
            margin: 40px 0 20px 0;
        }

        h2 {
            font-size: 1.5em;
            padding-bottom: 3px;
            border-bottom: 1px solid #DDD;
            margin-top: 50px;
            margin-bottom: 25px;
        }

        table th:first-child {
            width: 150px;
        }
        body { font-size: 12px; } 
        #n { margin:10px auto; width:920px; border:1px solid #CCC;
            font-size:14px; line-height:30px; } 
        #n a { padding:0 4px; color:#333 } 
        .Bar ,.Bars { position: relative; width: 105px;
            /* 宽度 */ border: 1px solid #B1D632; padding: 1px; } 
        .Bar div,.Bars div { display: block; position: relative;
            background:#00F;/* 进度条背景颜色 */ color: #333333;
            height: 20px; /* 高度 */ line-height: 20px;
            /* 必须和高度一致，文本才能垂直居中 */ } 
        .Bars div{ background:#090} 
        .Bar div span,.Bars div span { position: absolute; width: 105px;
            /* 宽度 */ text-align: center; font-weight: bold; } 
        .cent{ margin:0 auto; width:300px; overflow:hidden} 
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <table class="EditeContentTable" style="width: 100%; margin: 2px;">
        <tr>
            <td id="Td1" class="Label3">工单
            </td>
            <td class="Field3">
                <input type="text" id="txtOrderNo" class="TextBox" /><input type="button" id="bnOper"
                    class="ButtonBox" onclick="openChoosePage(44)" value="..." />
            </td>
            <td>
                <div id="bnView" style="font-size: 16px; width: 80px; cursor: pointer; float: left; margin-left: 40%; text-decoration: underline;">
                    <img src="../Content/images/search.png" />查询
                </div>
            </td>


        </tr>


    </table>

    <div class="wrap_tb">
        <ul class="tb">
            <li class="current">图表展示</li>
            <%-- <li class="">图表展示</li>--%>
        </ul>
        <div id="divReport" class="tb_c">
            <div class="contain" id="contain">
                <div class="gantt"></div>
            </div>
        </div>
        <div id="divChart" class="">
            <div id="ChartContainer">
            </div>
        </div>
    </div>
    <script src="../Content/jsgantt/js/jquery-1.7.min.js" type="text/javascript"></script>
    <script src="../Content/jsgantt/js/jquery.fn.gantt.js" charset="gbk" type="text/javascript"></script>
    <script type="text/javascript">

        $(function () {
            $("#contain").height($(window).height() - 80 - $("#divReport").position().top);
            LoadGantt();
            $("#bnView").bind("click", function () {
                LoadGantt();
            });
        });

        function LoadGantt() {
            var txtOrderNo = $("#txtOrderNo").val();
            var ret = "";
            $.ajax({
                url: "../Handler/GANT_MSTServer.ashx",
                type: "get",
                data: {
                    action: "GetProjectOrder2",
                    orderNo: txtOrderNo,
                    orderId: -1
                },
                async: false,
                success: function (msg) {
                    if (msg.Statue == "ok") {
                        ret = JSON.parse(msg.Data);
                    }
                }
            });
            "use strict";
            $(".gantt").gantt({
                source: ret,
                navigate: "scroll",
                scale: "weeks",
                maxScale: "months",
                minScale: "hours",
                itemsPerPage: 20,
                onItemClick: function (data) {},
                onAddClick: function (dt, rowId) {},
                onRender: function () {
                    if (window.console && typeof console.log === "function") {
                        //console.log("chart rendered");
                    }
                }
            });
        }
        function openChoosePage(flags) {
            var condition = "";
            dialog({ title: "选择窗口", src: "../Framework/ChoosePage.aspx?PageId=" + flags + "&Multiple=false&SearchCondition=" + condition + "&rnd=" + Math.random(), width: 600, height: 300 });
        }
        function getChooseValue(list) {
            $("#txtOrderNo").val(list[0][1]);
        }
    </script>
</asp:Content>
