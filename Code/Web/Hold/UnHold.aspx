<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UnHold.aspx.cs" Inherits="SKT.LeanMES.Web.Hold.UnHold" MasterPageFile="~/Masters/ViewMaster.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="server">
    <style>
        .wrap_tb > div {
            clear: both;
            display: none;
            height: auto;
            padding-top: 5px;
        }

        #tblOrder th {
            background-color: #ececec;
            padding: 3px;
            height: 22px;
            border: 1px solid #d3d3d3;
            border-collapse: collapse;
            font-family: Verdana, 微软雅黑,黑体,宋体;
            color: #183152;
        }

        #tblOrder tr td {
            border: 1px solid rgb(211, 211, 211);
        }

        #tblItem th {
            background-color: #ececec;
            padding: 3px;
            height: 22px;
            border: 1px solid #d3d3d3;
            border-collapse: collapse;
            font-family: Verdana, 微软雅黑,黑体,宋体;
            color: #183152;
        }

        #tblItem tr td {
            border: 1px solid rgb(211, 211, 211);
        }

        #tblMaterial th {
            background-color: #ececec;
            padding: 3px;
            height: 22px;
            border: 1px solid #d3d3d3;
            border-collapse: collapse;
            font-family: Verdana, 微软雅黑,黑体,宋体;
            color: #183152;
        }

        #tblMaterial tr td {
            border: 1px solid rgb(211, 211, 211);
        }

        #tblUnit th {
            background-color: #ececec;
            padding: 3px;
            height: 22px;
            border: 1px solid #d3d3d3;
            border-collapse: collapse;
            font-family: Verdana, 微软雅黑,黑体,宋体;
            color: #183152;
        }

        #tblUnit tr td {
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
    <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %>
    </div>
    <div style="height: 60px;">
        <table class="EditeContentTable" width="100%">
            <tr>
                <td class="Label1"><em>*</em>原因说明：</td>
                <td class="Field1">
                    <input type="text" id="txtCauseDescription" class="TextArea" />
                </td>
            </tr>
        </table>
    </div>
    <%--选项卡 开始--%>
    <div class="wrap_tb" id="infoTabs">
        <ul class="tb">
            <li class="current" onclick="selHoldObjec(this,1)">工单UnHold</li>
            <li onclick="selHoldObjec(this,2)">产品UnHold</li>
            <li onclick="selHoldObjec(this,3)">物料UnHold</li>
            <li onclick="selHoldObjec(this,4)">在制品UnHold</li>
        </ul>

        <%--选项卡内容 工单UnHold--%>
        <div id="infoTabContent-1" class="tb_c" name="infoTabContent">
            <table id="tblOrder" class="row-border stripe" width="100%">
            </table>
        </div>

        <%--选项卡内容 产品UnHold--%>
        <div id="infoTabContent-2" name="infoTabContent">
            <table id="tblItem" class="row-border stripe" width="100%">
            </table>
        </div>

        <%--选项卡内容 物料UnHold--%>
        <div id="infoTabContent-3" name="infoTabContent">
            <table id="tblMaterial" class="row-border stripe" width="100%">
            </table>
        </div>

        <%--选项卡内容 在制品UnHold--%>
        <div id="infoTabContent-4" name="infoTabContent">
            <table id="tblUnit" class="row-border stripe" width="100%">
            </table>
        </div>

    </div>

    <script src="../Content/plugin/DataTables-1.10.12/js/jquery.js" type="text/javascript"></script>
    <link href="../Content/plugin/DataTables-1.10.12/css/jquery.dataTables.min.css" rel="stylesheet"
        type="text/css" />
    <script src="../Content/plugin/DataTables-1.10.12/js/jquery.dataTables.js" type="text/javascript"></script>

    <script type="text/javascript">
        var objectFlag = 1; //默认工单

        var OrderFlag = 0;
        var ItemFlag = 0;
        var MaterialFlag = 0;
        var UnitFlag = 0;

        $(function () {
            showOrderDtl(0);
        });

        //保存UnHold信息
        function UnHold() {
            var objectNO = "";
            var txtCauseDescription = $("#txtCauseDescription").val();
            if (isNull(txtCauseDescription)) {
                alert("请填写UnHold原因！")
                return false;
            }
            if (objectFlag == 1) {
                var valckOrde = "";//工单信息
                var ckOrder = $("input[name='cbOrder']:checked");
                if (ckOrder.length == 0) {
                    alert("请先选择需要UnHold的工单！");
                    return false;
                }
                $('input[name="cbOrder"]:checked').each(function () {
                    valckOrde = valckOrde + $(this).val() + ",";
                });
                objectNO = valckOrde;
            }
            if (objectFlag == 2) {
                var valckItem = "";//产品信息
                var ckItem = $("input[name='cbItem']:checked");
                if (ckItem.length == 0) {
                    alert("请先选择需要UnHold的产品！");
                    return false;
                }
                $('input[name="cbItem"]:checked').each(function () {
                    valckItem = valckItem + $(this).val() + ",";
                });
                objectNO = valckItem;
            }
            if (objectFlag == 3) {
                var valckMaterial = "";//物料信息
                var ckMaterial = $("input[name='cbMaterial']:checked");
                if (ckMaterial.length == 0) {
                    alert("请先选择需要UnHold的物料！");
                    return false;
                }
                $('input[name="cbMaterial"]:checked').each(function () {
                    valckMaterial = valckMaterial + $(this).val() + ",";
                });
                objectNO = valckMaterial;
            }
            if (objectFlag == 4) {
                var valckUnit = "";//物料信息
                var ckUnit = $("input[name='cbUnit']:checked");
                if (ckUnit.length == 0) {
                    alert("请先选择需要UnHold的在制品！");
                    return false;
                }
                $('input[name="cbUnit"]:checked').each(function () {
                    valckUnit = valckUnit + $(this).val() + ",";
                });
                objectNO = valckUnit;
            }

            //保存至数据库
            var ajaxUnHold = SKT.LeanMES.Web.AjaxServices.AjaxQuality.SaveObjectUnHold(objectNO, objectFlag, txtCauseDescription);
            if (ajaxUnHold.error != null) {
                alert(ajaxUnHold.error.Message);
                return false;
            }
            if (objectFlag == 1) {
                showOrderDtl(1);
            }
            else if (objectFlag == 2) {
                showItemDtl(1);
            } else if (objectFlag == 3) {
                showMaterialDtl(1);
            } else if (objectFlag == 4) {
                showUnitDtl(1);
            }
            alert("保存成功！");


        }
        var getJQTableLanguage = function () {
            return {
                "lengthMenu": "每页 _MENU_ 条记录",
                "zeroRecords": "暂无数据",
                "info": "显示第 _PAGE_ 页,共 _PAGES_ 页",
                "infoEmpty": "",
                "search": "综合查询:",
                "infoFiltered": "(从 _MAX_ 条记录中查询)",
                "paginate": {
                    "first": "首页",
                    "last": "尾页",
                    "next": "后一页",
                    "previous": "前一页"
                }
            };
        }

        function selHoldObjec(obj, tag) {
            objectFlag = tag;
            selectTab(obj, tag);
            $("div[name='infoTabContent']").removeClass("tb_c");
            $("#infoTabContent-" + tag).addClass("tb_c");

            if (tag == 1 && OrderFlag == 0) {
                showOrderDtl(0);
                OrderFlag = 0;
            }
            if (tag == 2 && ItemFlag == 0) {
                showItemDtl(0);
                ItemFlag = 0;
            }
            if (tag == 3 && MaterialFlag == 0) {
                showMaterialDtl(0);
                MaterialFlag = 0;
            }
            if (tag == 4 && UnitFlag == 0) {
                showUnitDtl(0);
                UnitFlag = 0;
            }

            //$("#infoTabContent-" + tag).attr('style', 'display: block;');

        }

        //#region *******************工单（1）************************begin

        //加载数据
        function showOrderDtl(doclean) {
            var dataSet = []; //数据源
            if (doclean) { //清空，绑定表格
                $('#tblOrder').DataTable().destroy();
            }
            var OrderNo = "工单" //$("#txtMaterialCode").val();
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxQuality.GetQueryQHold(OrderNo);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var entity = ajax.value;
            entityList = entity;
            if (entity != null && entity.length > 0) {
                for (var i = 0; i < entity.length; i++) {
                    var row = [];
                    row.push(entity[i].SerialNumber);
                    row.push(entity[i].SerialNumber);
                    row.push(entity[i].Cause);
                    row.push(entity[i].OperatePerson);
                    row.push(formatDate(entity[i].OperateDateTime));
                    dataSet.push(row);
                }
            }
            $('#tblOrder').empty();
            $('#tblOrder').DataTable({
                data: dataSet,
                paging: true,
                searching: true,
                scrollCollapse: true,
                deferRender: true,
                destroy:true,
                bSort: false,//是否启动各个字段的排序功能
                language: getJQTableLanguage(),   //多语言设定（默认英语）
                columns: [
                        {
                            title: "<input onchange='cbAllClick(this)' type='checkbox'/>", "render": function (data, type, full, meta) {
                                return '<input name="cbOrder" onchange="cbOrderClick(this)" value="' + data + '" type="checkbox"/>';
                            }, width: 30
                    },
                    { title: mesLang("工单号") },
                    { title: mesLang("QHold原因") },
                    { title: mesLang("操作人") },
                    { title: mesLang("操作时间") }
                ],
                "createdRow": function (row, data, dataIndex) {
                    $(row).children('td').eq(0).attr('style', 'text-align: center;');
                },
            });
            $('#tblOrder tbody').on('click', 'tr', function () {
                $(this).toggleClass('selected');
                $(this).find("input[name='cbOrder']").prop("checked", $(this).hasClass("selected"));
            });
        }
        //行checkbox事件
        function cbOrderClick(obj) {
            //$(obj).toggleClass('selected');
            //if ($(this).is(':checked')) {
            //    $(this).prop("checked", true);
            //} else {

            //    $(this).prop("checked", false);
            //}
        }
        //全选事件
        function cbAllClick(obj) {
            if ($(obj).is(':checked')) {
                $("[name = cbOrder]:checkbox").prop("checked", true);
                $('#tblOrder tbody tr').addClass('selected');
            } else {
                $("[name = cbOrder]:checkbox").prop("checked", false);
                $('#tblOrder tbody tr').removeClass('selected');
            }
        }
        //endregion ******************工单*************************end

        //#region *******************产品（2）************************begin

        //加载数据
        function showItemDtl(doclean) {
            var dataSet = []; //数据源
            if (doclean) { //清空，绑定表格
                $('#tblItem').DataTable().destroy();
            }
            var ItemNo = "产品" //$("#txtMaterialCode").val();
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxQuality.GetQueryQHold(ItemNo);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var entity = ajax.value;
            entityList = entity;
            if (entity != null && entity.length > 0) {
                for (var i = 0; i < entity.length; i++) {
                    var row = [];
                    row.push(entity[i].SerialNumber);
                    row.push(entity[i].SerialNumber);
                    row.push(entity[i].Cause);
                    row.push(entity[i].OperatePerson);
                    row.push(formatDate(entity[i].OperateDateTime));
                    dataSet.push(row);
                }
            }
            $('#tblItem').empty();
            $('#tblItem').DataTable({
                data: dataSet,
                paging: true,
                searching: true,
                scrollCollapse: true,
                deferRender: true,
                destroy: true,
                bSort: false,//是否启动各个字段的排序功能
                language: getJQTableLanguage(),   //多语言设定（默认英语）
                columns: [
                        {
                            title: "<input onchange='cbAllClickItem(this)' type='checkbox'/>", "render": function (data, type, full, meta) {
                                return '<input name="cbItem" onchange="cbItemClick(this)" value="' + data + '" type="checkbox"/>';
                            }, width: 30
                        },
                    { title: mesLang("产品编码") },
                    { title: mesLang("QHold原因") },
                    { title: mesLang("操作人") },
                    { title: mesLang("操作时间") }
                ],
                "createdRow": function (row, data, dataIndex) {
                    $(row).children('td').eq(0).attr('style', 'text-align: center;');
                },
            });
            $('#tblItem tbody').on('click', 'tr', function () {
                $(this).toggleClass('selected');
                $(this).find("input[name='cbItem']").prop("checked", $(this).hasClass("selected"));
            });
        }
        //行checkbox事件
        function cbItemClick(obj) {
            //$(obj).toggleClass('selected');
            //if ($(this).is(':checked')) {
            //    $(this).prop("checked", true);
            //} else {

            //    $(this).prop("checked", false);
            //}
        }
        //全选事件
        function cbAllClickItem(obj) {
            if ($(obj).is(':checked')) {
                $("[name = cbItem]:checkbox").prop("checked", true);
                $('#tblItem tbody tr').addClass('selected');
            } else {
                $("[name = cbItem]:checkbox").prop("checked", false);
                $('#tblItem tbody tr').removeClass('selected');
            }
        }
        //endregion ******************产品*************************end

        //#region *******************物料（3）************************begin

        //加载数据
        function showMaterialDtl(doclean) {
            var dataSet = []; //数据源
            if (doclean) { //清空，绑定表格
                $('#tblMaterial').DataTable().destroy();
            }
            var MaterialNo = "物料" //
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxQuality.GetQueryQHold(MaterialNo);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var entity = ajax.value;
            entityList = entity;
            if (entity != null && entity.length > 0) {
                for (var i = 0; i < entity.length; i++) {
                    var row = [];
                    row.push(entity[i].SerialNumber);
                    row.push(entity[i].SerialNumber);
                    row.push(entity[i].Cause);
                    row.push(entity[i].OperatePerson);
                    row.push(formatDate(entity[i].OperateDateTime));
                    dataSet.push(row);
                }
            }
            $('#tblMaterial').empty();
            $('#tblMaterial').DataTable({
                data: dataSet,
                paging: true,
                searching: true,
                scrollCollapse: true,
                deferRender: true,
                destroy: true,
                bSort: false,//是否启动各个字段的排序功能
                language: getJQTableLanguage(),   //多语言设定（默认英语）
                columns: [
                        {
                            title: "<input onchange='cbAllClickMaterial(this)' type='checkbox'/>", "render": function (data, type, full, meta) {
                                return '<input name="cbMaterial" onchange="cbMaterialClick(this)" value="' + data + '" type="checkbox"/>';
                            }, 'width': '50'
                        },
                    { title: mesLang("物料条码") },
                    { title: mesLang("QHold原因") },
                    { title: mesLang("操作人") },
                    { title: mesLang("操作时间") }
                ],
                "createdRow": function (row, data, dataIndex) {
                    $(row).children('td').eq(0).attr('style', 'text-align: center;');
                },
            });
            $('#tblMaterial tbody').on('click', 'tr', function () {
                $(this).toggleClass('selected');
                $(this).find("input[name='cbMaterial']").prop("checked", $(this).hasClass("selected"));
            });
        }
        //行checkbox事件
        function cbMaterialClick(obj) {
            //$(obj).toggleClass('selected');
            //if ($(this).is(':checked')) {
            //    $(this).prop("checked", true);
            //} else {

            //    $(this).prop("checked", false);
            //}
        }
        //全选事件
        function cbAllClickMaterial(obj) {
            if ($(obj).is(':checked')) {
                $("[name = cbMaterial]:checkbox").prop("checked", true);
                $('#tblMaterial tbody tr').addClass('selected');
            } else {
                $("[name = cbMaterial]:checkbox").prop("checked", false);
                $('#tblMaterial tbody tr').removeClass('selected');
            }
        }
        //endregion ******************物料*************************end

        //#region *******************在制品（4）************************begin

        //加载数据
        function showUnitDtl(doclean) {
            var dataSet = []; //数据源
            if (doclean) { //清空，绑定表格
                $('#tblUnit').DataTable().destroy();
            }
            var MaterialNo = "在制品" //$("#txtMaterialCode").val();
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxQuality.GetQueryQHold(MaterialNo);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var entity = ajax.value;
            entityList = entity;
            if (entity != null && entity.length > 0) {
                for (var i = 0; i < entity.length; i++) {
                    var row = [];
                    row.push(entity[i].SerialNumber);
                    row.push(entity[i].SerialNumber);
                    row.push(entity[i].Cause);
                    row.push(entity[i].OperatePerson);
                    row.push(formatDate(entity[i].OperateDateTime));
                    dataSet.push(row);
                }
            }
            $('#tblUnit').empty();
            $('#tblUnit').DataTable({
                data: dataSet,
                paging: true,
                searching: true,
                scrollCollapse: true,
                deferRender: true,
                destroy: true,
                bSort: false,//是否启动各个字段的排序功能
                language: getJQTableLanguage(),   //多语言设定（默认英语）
                columns: [
                        {
                            title: "<input onchange='cbAllClickUnit(this)' type='checkbox'/>", "render": function (data, type, full, meta) {
                                return '<input name="cbUnit" onchange="cbUnitClick(this)" value="' + data + '" type="checkbox"/>';
                            }, 'width': '50'
                        },
                    { title: mesLang("产品条码") },
                    { title: mesLang("QHold原因") },
                    { title: mesLang("操作人") },
                    { title: mesLang("操作时间") }
                ],
                "createdRow": function (row, data, dataIndex) {
                    $(row).children('td').eq(0).attr('style', 'text-align: center;');
                },
            });
            $('#tblUnit tbody').on('click', 'tr', function () {
                $(this).toggleClass('selected');
                $(this).find("input[name='cbUnit']").prop("checked", $(this).hasClass("selected"));
            });
        }
        //行checkbox事件
        function cbUnitClick(obj) {
            //$(obj).toggleClass('selected');
            //if ($(this).is(':checked')) {
            //    $(this).prop("checked", true);
            //} else {

            //    $(this).prop("checked", false);
            //}
        }
        //全选事件
        function cbAllClickUnit(obj) {
            if ($(obj).is(':checked')) {
                $("[name = cbUnit]:checkbox").prop("checked", true);
                $('#tblUnit tbody tr').addClass('selected');
            } else {
                $("[name = cbUnit]:checkbox").prop("checked", false);
                $('#tblUnit tbody tr').removeClass('selected');
            }
        }
        //endregion ******************物料*************************end

        //日期格式化
        function formatDate(date, format) {
            if (!date) return "";
            if (!format) format = "yyyy-MM-dd HH:mm:ss";
            if (typeof (date) === "string") date = new Date(date);

            var o = {
                "M+": date.getMonth() + 1, //month
                "d+": date.getDate(), //day
                "H+": date.getHours(), //hour
                "m+": date.getMinutes(), //minute
                "s+": date.getSeconds(), //second
                "q+": Math.floor((date.getMonth() + 3) / 3), //quarter
                "S": date.getMilliseconds() //millisecond
            }

            if (/(y+)/.test(format)) {
                format = format.replace(RegExp.$1, (date.getFullYear() + "").substr(4 - RegExp.$1.length));
            }

            for (var k in o) {
                if (new RegExp("(" + k + ")").test(format)) {
                    format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? o[k] : ("00" + o[k]).substr(("" + o[k]).length));
                }
            }
            return format;
        }
    </script>

</asp:Content>
