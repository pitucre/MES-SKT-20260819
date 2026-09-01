<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="OSPSNReleaseList.aspx.cs" Inherits="SKT.LeanMES.Web.Hold.OSPSNReleaseList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
        <script src="../Content/plugin/DataTables-1.10.12/js/jquery.js" type="text/javascript"></script>
    <link href="../Content/plugin/DataTables-1.10.12/css/jquery.dataTables.min.css" rel="stylesheet"
        type="text/css" />
    <script src="../Content/plugin/DataTables-1.10.12/js/jquery.dataTables.js" type="text/javascript"></script>
    <style>
        #tblOSP th {
            background-color: #ececec;
            padding: 3px;
            height: 22px;
            border: 1px solid #d3d3d3;
            border-collapse: collapse;
            font-family: Verdana, 微软雅黑,黑体,宋体;
            color: #183152;
        }

        #tblOSP tr td {
            border: 1px solid rgb(211, 211, 211);
        }

        thead td {
            border-bottom: 1px solid #ececec;
            border-collapse: collapse;
        }

        table.dataTable.no-footer {
            border-bottom: 1px solid #ececec;
            border-collapse: collapse;
        }
    </style>
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label3">工单
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtOrderNo" runat="server" CssClass="TextBox" ClientIDMode="Static" IsRequired='1'
                    Width="90%"></asp:TextBox>
            </td>
            <td class="Label3">产品条码
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtSN" runat="server" CssClass="TextBox" ClientIDMode="Static" IsRequired='1'
                    Width="90%"></asp:TextBox>
            </td>
            <td class="Label3">状态
            </td>
            <td class="Field3">
                <asp:DropDownList ID="ddlStatus" runat="server" ClientIDMode="Static">
                    <asp:ListItem Text="全部" Value=""></asp:ListItem>
                    <asp:ListItem Text="逾期" Value="逾期" Selected="True"></asp:ListItem>
                    <asp:ListItem Text="未逾期" Value="未逾期"></asp:ListItem>
                    <asp:ListItem Text="已解除" Value="已解除"></asp:ListItem>
                </asp:DropDownList>

                <input type="button" id="searchSubmit" value="查 询" onclick="getOSPSN(1)" class="SearchButton" title=" 查 询 ">
            </td>
        </tr>
        <tr id="trRelease" style="display: none;">
            <td class="Label3">解除原因
            </td>
            <td class="Field3" colspan="4">
                <asp:TextBox ID="txtReason" runat="server" CssClass="TextArea" TextMode="MultiLine" ClientIDMode="Static" IsRequired='1'
                    Width="99%"></asp:TextBox>
            </td>
            <td class="Field3">
                <input type="button" id="release" value=" 解 除 " onclick="releaseOSP()" title=" 解 除 "></td>
        </tr>
    </table>
    <%--<table id="tblExpand" cellspacing="0" cellpadding="4" style="border-width: 0px; width: 100%; border-collapse: collapse; margin-top: 5px;"
        class="EditeContentTable">
        <tr class="ListTableHeader">
            <th scope="col" style="width: 50px; text-align: center;">序号
            </th>
            <th scope="col" style="width: 60px; text-align: center;">工单
            </th>
            <th scope="col" style="width: 100px; text-align: center;">产品条码
            </th>
            <th scope="col" style="width: 80px; text-align: center;">OSP类型
            </th>
            <th scope="col" style="width: 80px; text-align: center;">OSPTime(分)
            </th>
            <th scope="col" style="width: 60px; text-align: center;">状态
            </th>
            <th scope="col" style="width: 90px; text-align: center;">开始站
            </th>
            <th scope="col" style="width: 100px; text-align: center;">开始时间
            </th>
            <th scope="col" style="width: 90px; text-align: center;">结束站
            </th>
            <th scope="col" style="width: 100px; text-align: center;">结束时间
            </th>
            <th scope="col" style="width: 60px; text-align: center;">时长(分)
            </th>
            <th scope="col" style="width: 60px; text-align: center;">解除人
            </th>
            <th scope="col" style="width: 100px; text-align: center;">解除时间
            </th>
            <th scope="col" style="width: 100px; text-align: center;">解除原因
            </th>
        </tr>
        <tbody id="tbodyOSP">
        </tbody>

    </table>--%>
    <div class="tb_content" style="margin-top: 5px;">
        <table id="tblOSP" class="row-border stripe" width="100%">
        </table>
    </div>


    <script type="text/javascript">
        var userName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
        var ospId = [];
        
        $().ready(function () {
            getOSPSN(0);
        });

        var getJQTableLanguage = function (isPaging) {
            return {
                "lengthMenu": "每页 _MENU_ 条记录",
                "zeroRecords": "暂无数据",
                "info": isPaging?"显示第 _PAGE_ 页,共 _PAGES_ 页":"",
                "infoEmpty": "",
                "search": "综合搜索:",
                "infoFiltered": "(从 _MAX_ 条记录中查询)",
                "paginate": {
                    "first": "首页",
                    "last": "尾页",
                    "next": "后一页",
                    "previous": "前一页"
                },
                "loadingRecords": "数据加载中..."
            };
        }

        function getOSPSN(flag) {
            var orderNo = $.trim($("#txtOrderNo").val());
            var sn = $.trim($("#txtSN").val());
            var status = $.trim($("#ddlStatus").val());

            if (flag==1 && orderNo == "" && sn=="" && (status != "逾期" && status != "已解除")) {
                alert("请输入查询条件！");
                $("#txtOrderNo").select();
                return false;
            }

            ospId = [];

            var entity = {};
            entity.OrderNo = orderNo;
            entity.SN = sn;
            entity.Status = status;

            var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspGetOSPSN", JSON.stringify(entity));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            var dataSet = []; //数据源

            var result = JSON.parse(ajax.value);

            var list = result.data;
            if (result != null &&list.length > 0) {                
                for (var i = 0; i < list.length; i++) {
                    var row = [];
                    ospId.push(list[i].OSPId);
                    row.push(i+1);
                    row.push(list[i].OrderNO);
                    row.push(list[i].SN);
                    row.push(list[i].OSPTypeName);
                    row.push(list[i].OSPTypeTime);
                    row.push(list[i].Status);
                    row.push(parseFloat(list[i].OTime) - parseFloat(list[i].OSPTypeTime));
                    row.push(list[i].StartStation);
                    row.push(list[i].StartDateTime);
                    row.push(list[i].CloseStation);
                    row.push(list[i].CloseDateTime);
                    row.push(list[i].OTime);

                    row.push(list[i].ReleaseUser);
                    row.push(list[i].ReleaseDateTime);
                    row.push(list[i].Reason);

                    dataSet.push(row);
                }
            }

            //load(result.data);

            if (flag == 1) {
                $('#tblOSP').DataTable().destroy();
                $('#tblOSP').empty();
            }
            
            var isPaging = true;

           

            $('#tblOSP').DataTable({
                data: dataSet,
                paging: isPaging,
                pageLength: 30,
                lengthChange: false,
                searching: false,
                scrollCollapse: true,
                deferRender: true,
                language: getJQTableLanguage(isPaging),   //多语言设定（默认英语）                
                columns: [
                    { title: mesLang("序号") },
                    { title: mesLang("工单") },
                    { title: mesLang("产品条码") },
                    { title: mesLang("工序段类型") },
                    { title: mesLang("工序段时间(分)") },
                    { title: mesLang("状态") },
                    { title: mesLang("超期时长(分)") },
                    { title: mesLang("开始站") },
                    { title: mesLang("开始时间") },
                    { title: mesLang("结束站") },
                    { title: mesLang("结束时间") },
                    { title: mesLang("时长(分)") },
                    { title: mesLang("解除人") },
                    { title: mesLang("解除时间") },
                    { title: mesLang("解除原因") }
                ]
            });


            if ($("#ddlStatus").val() != "逾期") {
                $("#trRelease").hide();
            }
            else {
                if (result.data.length > 0) {
                    $("#trRelease").show();
                }
                else {
                    $("#trRelease").hide();
                }
            }
        }
        /*
        function load(list) {
            var html = "";

            for (var i = 0; i < list.length; i++) {
                var entity = list[i];
                ospId.push(entity.OSPId);
                html += "<tr class='ListTableOddRow'>" +
                    "<td align='center' class='Field'>" + (i + 1) + "</td>" +
                    "<td align='center' class='Field'>" + entity.OrderNO + "<input type='hidden' name='OSPId' value='" + entity.OSPId + "' /></td>" +
                    "<td align='center' class='Field' style='word-break: break-word;'>" + entity.SN + "</td>" +
                    "<td align='center' class='Field'>" + entity.OSPTypeName + "</td>" +
                    "<td align='center' class='Field'>" + entity.OSPTypeTime + "</td>" +
                    "<td align='center' class='Field'>" + entity.Status + "</td>" +
                    "<td align='center' class='Field'>" + entity.StartStation + "</td>" +
                    "<td align='center' class='Field'>" + entity.StartDateTime + "</td>" +
                    "<td align='center' class='Field'>" + entity.CloseStation + "</td>" +
                    "<td align='center' class='Field'>" + entity.CloseDateTime + "</td>" +
                    "<td align='center' class='Field'>" + entity.OTime + "</td>" +
                    "<td align='center' class='Field'>" + entity.ReleaseUser + "</td>" +
                    "<td align='center' class='Field'>" + entity.ReleaseDateTime + "</td>" +
                    "<td align='center' class='Field'>" + entity.Reason + "</td>" +
                    "</tr>";
            }

            $("#tbodyOSP").html(html);
        }*/

        function releaseOSP() {
            if ($("#ddlStatus").val() != "逾期") {
                alert("请先查询出已逾期的产品条码！");
                return false;
            }
            var reason = $.trim($("#txtReason").val());

            if (reason == "") {
                alert("请输入解除原因！");
                $("#txtReason").select()
                return false;
            }

            getOSPSN(1);

            if (ospId.length == 0) {
                alert("请先查询出已逾期的产品条码！");
                return false;
            }

            setTimeout(function () {
                if (!confirm("确认解除当前列表中已逾期的产品条码？")) {
                    return false;
                }

                var entity = {};
                entity.OSPId = ospId.join(",");
                entity.Reason = reason;
                entity.UserName = userName;

                var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspReleaseOSPSN", JSON.stringify(entity));
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }

                $("#txtReason").val("");
                ospId = [];
                getOSPSN(1);
            }, 100);



        }
    </script>
</asp:Content>
