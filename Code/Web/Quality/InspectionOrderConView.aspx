<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/ViewMaster.master" CodeBehind="InspectionOrderConView.aspx.cs" Inherits="SKT.LeanMES.Web.Quality.InspectionOrderConView" %>

<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="Server">
    <style type="text/css">
        .tdred {
            background-color: lightpink;
        }
    </style>
    <div style="display: none">
        <table width="100%" style="height: auto;">
            <tr>
                <td style="background: url('../Content/images/IPQC.png') no-repeat center center; height: 42px;"></td>
            </tr>
        </table>
    </div>
    <div class="wrap_tb" style="min-height: 350px; min-width: 600px">
        <ul class="tb">
            <li class="current" title="<%= Resources.lang.BaseInfo%>">检验单信息
            </li>
            <li title="检查序号信息">检查序号信息 </li>
            <li class="view-qcfile" title="相关文件">相关文件</li>
        </ul>
        <div class="tb_c">
            <div class="Field" style="text-align: center; padding-top: 10px; font-size: large"><span id="spanTypeName" runat="server"></span></div>
            <table width="100%" class="EditeContentTable">
                <%-- <tr>
                    <td class="Label2" style=" background-color: #fff;">工单</td>
                    <td class="Field2">
                        <asp:Label ID="lblOrderNo" runat="server"></asp:Label>
                    </td>
                    <td class="Label2" style=" background-color: #fff;">订单数量</td>
                    <td class="Field2">
                        <asp:Label ID="lblOrderQty" runat="server"></asp:Label>
                    </td>
                </tr>--%>
                <tr>
                    <td class="Label3" style="background-color: #fff;">产品名称</td>
                    <td class="Field4">
                        <asp:Label ID="lblItemName" runat="server"></asp:Label>
                    </td>
                    <td class="Label3" style="background-color: #fff;">产线</td>
                    <td class="Field4">
                        <asp:Label ID="lblLineName" runat="server"></asp:Label>
                    </td>
                    <td class="Label3" style="background-color: #fff;">检验单号</td>
                    <td class="Field4">
                        <asp:Label ID="lblInspectionNo" runat="server"></asp:Label>
                    </td>
                    <td class="Label3" style="background-color: #fff;">单据名称</td>
                    <td class="Field4">
                        <asp:Label ID="Label1" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="Label3" style="background-color: #fff;">检检人</td>
                    <td class="Field4">
                        <asp:Label ID="lblSendMan" runat="server"></asp:Label>
                    </td>
                    <td class="Label3" style="background-color: #fff;">提交时间</td>
                    <td class="Field4">
                        <asp:Label ID="lblCreatetime" runat="server"></asp:Label>
                    </td>
                    <td class="Label3" style="background-color: #fff;">送检日期</td>
                    <td class="Field4">
                        <asp:Label ID="lblSJDate" runat="server"></asp:Label>
                    </td>
                    <td class="Label3" style="background-color: #fff;">检检日期</td>
                    <td class="Field4">
                        <asp:Label ID="lblJYDate" runat="server"></asp:Label>
                    </td>
                    <%-- <td class="Label2" style=" background-color: #fff;">班别</td>
                    <td class="Field2">
                        <asp:Label ID="lblClass" runat="server"></asp:Label>
                    </td>--%>
                </tr>
                <tr class="IsShow">
                    <td class="Label3" style="background-color: #fff;">模具名称</td>
                    <td class="Field4">
                        <asp:Label ID="lblMoudle" runat="server"></asp:Label>
                    </td>
                    <td class="Label3" style="background-color: #fff;">烘料温度设定</td>
                    <td class="Field4">
                        <asp:Label ID="lblDryingMaterialTemperature" runat="server"></asp:Label>
                    </td>
                    <td class="Label3" style="background-color: #fff;">热流道温度设定</td>
                    <td class="Field4" colspan="3">
                        <asp:Label ID="lblHotRunnerTemperature" runat="server"></asp:Label>
                    </td>
                    <%--<td class="Label2" style=" background-color: #fff;">样本数量</td>
                    <td class="Field2">
                        <asp:Label ID="lblSampleQty" runat="server"></asp:Label>
                    </td>--%>
                </tr>
                <tr class="IsShow">
                    <td class="Label3" style="background-color: #fff;">料管温度</td>
                    <td class="Field4" colspan="7">1：<asp:Label ID="lblBarrelTemperature1" runat="server"></asp:Label>&nbsp;&nbsp;&nbsp;
                        2：<asp:Label ID="lblBarrelTemperature2" runat="server"></asp:Label>&nbsp;&nbsp;&nbsp;
                        3：<asp:Label ID="lblBarrelTemperature3" runat="server"></asp:Label>&nbsp;&nbsp;&nbsp;
                        4：<asp:Label ID="lblBarrelTemperature4" runat="server"></asp:Label>&nbsp;&nbsp;&nbsp;
                        5：<asp:Label ID="lblBarrelTemperature5" runat="server"></asp:Label>&nbsp;&nbsp;&nbsp;
                    </td>
                </tr>
                <tr class="IsShow">
                    <td class="Label3" style="background-color: #fff;">模具温度(依实测)-动模</td>
                    <td class="Field4">
                        <asp:Label ID="lblMoldTemperatureDynamic" runat="server"></asp:Label>
                    </td>
                    <td class="Label3" style="background-color: #fff;">模具温度(依实测)-静模</td>
                    <td class="Field4">
                        <asp:Label ID="lblMoldTemperatureStatic" runat="server"></asp:Label>
                    </td>
                    <td class="Label3" style="background-color: #fff;">原料编号</td>
                    <td class="Field4">
                        <asp:Label ID="lblMaterialItemCode" runat="server"></asp:Label>
                    </td>
                    <td class="Label3" style="background-color: #fff;">原料名称</td>
                    <td class="Field4">
                        <asp:Label ID="lblMaterialItemName" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr class="IsShow">
                    <td class="Label3" style="background-color: #fff;">原料规格</td>
                    <td class="Field4">
                        <asp:Label ID="lblMaterialItemSpc" runat="server"></asp:Label>
                    </td>
                    <td class="Label3" style="background-color: #fff;">原料批次</td>
                    <td class="Field4">
                        <asp:Label ID="lblMaterialItemLot" runat="server"></asp:Label>
                    </td>
                    <td class="Label3" align="right">备注
                    </td>
                    <td class="Field4">
                        <asp:Label ID="lblRemark" runat="server"></asp:Label>
                    </td>
                    <td class="Label2" style="background-color: #fff;">检验结果</td>
                    <td class="Field2">
                        <asp:Label ID="lblResult" runat="server"></asp:Label>
                    </td>
                    <td class="Label2" style="background-color: #fff;"></td>
                    <td class="Field2"></td>
                </tr>
            </table>
            <div class="clear5">
            </div>
            <table class="ListTable" width="100%" id="tbInspectionTab" style="background-color: #fff;">
                <tr class="ListTableHeader">
                    <th style="text-align: center">NO
                    </th>
                    <th style="text-align: center">检验项名称
                    </th>
                    <th style="text-align: center">检验方法
                    </th>
                    <th style="text-align: center">检验依据
                    </th>
                    <%-- <th>
                        特殊要求
                    </th>--%>
                    <th style="text-align: center">检验结果
                    </th>
                    <th style="text-align: center">不良代码
                    </th>
                    <th style="text-align: center">备注
                    </th>
                </tr>
            </table>
            <div style="clear: both; height: 0px;">
            </div>
            <table width="100%" class="EditeContentTable" style="display: none">
                <%--<tr><td class="Label2" style="text-align: center;background-color: #fff;" colspan="4">解决方案</td></tr>
               <tr><td class="Field2" style="text-align: center;"  colspan="4"><asp:Label ID="lblProjectAffirmRemark" runat="server">（在工程确认时候填写解决方案栏位）</asp:Label></td></tr>--%>
                <tr>
                    <td class="Field2" style="width: 250px;">检检人:
                        <asp:Label ID="lblIPQC" runat="server"></asp:Label>
                    </td>
                    <td class="Field2" style="width: 250px;">组长确认:
                        <asp:Label ID="lblGroupAffirm" runat="server"></asp:Label>&nbsp;<asp:Label ID="lblGroupAffirmBy" runat="server"></asp:Label>&nbsp;
                    </td>
                    <td class="Field2" style="width: 250px;">工程确认:
                        <asp:Label ID="lblProjectAffirm" runat="server"></asp:Label>&nbsp;<asp:Label ID="lblProjectAffirmBy" runat="server"></asp:Label>&nbsp;
                    </td>
                    <td class="Field2" style="width: 250px;">审核:
                        <asp:Label ID="lblAuditResult" runat="server"></asp:Label>&nbsp;<asp:Label ID="lblAuditBy" runat="server"></asp:Label>&nbsp;
                    </td>
                </tr>
                <td class="Field2" style="width: 250px;"></td>
                <td class="Field2" style="width: 250px;">审核备注：<asp:Label ID="txtGroupRmark" runat="server"></asp:Label>
                </td>
                <td class="Field2" style="width: 250px;">解决方案：<asp:Label ID="txtProjectRmark" runat="server"></asp:Label>
                </td>
                <td class="Field2" style="width: 250px;">审核备注：<asp:Label ID="txtAuditRmark" runat="server"></asp:Label>
                </td>
                <tr>
                </tr>
            </table>
        </div>
        <div>
            <table class="ListTable" id="tabTurnOverList" width="100%">
                <tr class="ListTableHeader" style="height: 30px;">
                    <th scope="col" style="width: 70px">序号
                    </th>
                    <th scope="col">产品序列号
                    </th>
                    <th scope="col" style="width: 60px">检验结果
                    </th>
                    <th scope="col">不良现象
                    </th>
                    <th scope="col" style="width: 150px;">扫描时间
                    </th>
                </tr>
                <tbody id="checkSNTb">
                    <tr class="ListTableOddRow">
                        <td colspan="8" style="text-align: center;"><span>暂无数据</span>
                        </td>
                    </tr>
                </tbody>

            </table>
        </div>
        <div>
            <div id="FileInfo">
                <table class="ListTable" width="100%">
                    <thead>
                        <tr class="ListTableHeader">
                            <th>序号</th>
                            <th>产品编码</th>
                            <th>文件名称</th>
                            <th>文件类型</th>
                            <th>文件类型</th>
                            <th>创建人</th>
                            <th>创建时间</th>
                            <th>下载</th>
                        </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
        </div>
        <asp:HiddenField ID="IOrder" runat="server" />
        <asp:HiddenField ID="IQCType" runat="server" />
    </div>

    <script language="javascript" type="text/javascript">

        var tab = document.getElementById("tbInspectionTab");
        var Id = '<%= Request.QueryString["Id"] %>';
        var InspecType = '<%= Request.QueryString["Type"] %>';
        var ShowArray = ['2', '6'];
        $(function () {
            GetInspectionTabInfo();
            getInspectionSN();
            if (InspecType == "2") {
                $(".IsShow").hide();
            }
        });

        $(document).ready(function () {
            var _iqctype = $("#<%=this.IQCType.ClientID %>").val();
            if (_iqctype == 2) {
                $("#FileInfo").show();
                $(".view-qcfile").show();
                //获取文件信息
                FileShow();
            } else {
                $("#FileInfo").hide();
                $(".view-qcfile").hide();
            }

            if ($.inArray(InspecType, ShowArray) > -1) {
                $("#FileInfo").show();
                $(".view-qcfile").show();
                FileShow();
            }

        });
        function GetInspectionTabInfo() {
            if ($.inArray(InspecType, ShowArray) == "-1") {
                //这里获取GetAll方法里面的数据
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxInspection.GetInspectionMemberInfoById(Id);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return;
                }
                var entityAry = ajax.value;
                $(tab).find(".ListTableOddRow").empty().remove();
                var rowId = 0;
                for (var i = 0; i < entityAry.length; i++) {
                    rowId = rowId + 1;
                    addDetail(entityAry[i], rowId);
                }
            } else {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxInspection.GetInspectionMemberDetailById(Id);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return;
                }
                debugger
                var entityAry = ajax.value;
                $("#tbInspectionTab")[0].innerHTML = "";
                var InspecItem = Object.groupBy(entityAry, (x) => x.InspectionItemName);
                var Row = Object.groupBy(entityAry, (x) => x.RowIndex);

                //第一二行固定
                for (var i = 0; i < 2; i++) {
                    addDetailNew(InspecItem);
                }

                for (var i = 0; i < Object.keys(Row).length; i++) {
                    var entitys = Row[Object.keys(Row)[i]];
                    addDetailNew(entitys);
                }
            }
        }


        function addDetailNew(entity) {
            var row, cell;
            rowNewIdx = tab.rows.length;
            row = tab.insertRow(rowNewIdx);
            row.className = rowNewIdx < 2 ? "ListTableHeader" : "ListTableOddRow";
            if (rowNewIdx == 0) {
                cell = row.insertCell(0);
                cell.align = "center";
                cell.className = "Field";
                cell.innerHTML = "检验项";

                for (var i = 0; i < Object.keys(entity).length; i++) {
                    cell = row.insertCell(i + 1);
                    cell.align = "center";
                    cell.className = "Field";
                    cell.innerHTML = Object.keys(entity)[i];
                }
                cell = row.insertCell(i + 1);
                cell.align = "center";
                cell.className = "Field";
                cell.innerHTML = "";
            } else if (rowNewIdx == 1) {
                cell = row.insertCell(0);
                cell.align = "center";
                cell.className = "Field";
                cell.innerHTML = "检验方法";
                debugger

                for (var i = 0; i < Object.keys(entity).length; i++) {
                    cell = row.insertCell(i + 1);
                    cell.align = "center";
                    cell.className = "Field";
                    cell.innerHTML = entity[Object.keys(entity)[i]][0]["CheckFashion"];
                }
                cell = row.insertCell(i + 1);
                cell.align = "center";
                cell.className = "Field";
                cell.innerHTML = "检验日期";
            } else {
                cell = row.insertCell(0);
                cell.align = "center";
                cell.className = "Field";
                cell.innerHTML = rowNewIdx - 1;
                for (var j = 0; j < entity.length; j++) {
                    cell = row.insertCell(j + 1);
                    cell.align = "center";
                    //cell.className = entity[j]["InspectionMethodId"] == "2" && entity[j]["InspectionResult"] == "不合格" ? "Field tdred" : "Field";
                    cell.className = entity[j]["InspectionResult"] == "不合格" ? "Field tdred" : "Field";
                    cell.innerHTML = entity[j]["InspectionValue"];
                }
                cell = row.insertCell(j + 1);
                cell.align = "center";
                cell.className = "Field";
                cell.innerHTML = entity[j - 1]["InspectionDateTime"] == "" ? "" : formatDateSecond(entity[j - 1]["InspectionDateTime"]);
            }
        }

        /*为检验列表添加检验行*/
        function addDetail(entity, rowId) {
            var row, cell;
            rowNewIdx = tab.rows.length;
            row = tab.insertRow(rowNewIdx);
            row.className = "ListTableOddRow";
            //序号
            cell = row.insertCell(0);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = rowId;
            //检查项目
            cell = row.insertCell(1);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = entity.InspectionItemName;
            //测试方法
            cell = row.insertCell(2);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = entity.TestMethod;
            //检验依据
            cell = row.insertCell(3);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = entity.InspectionAccording;
            //特殊要求
            //cell = row.insertCell(4);
            //cell.align = "center";
            //cell.className = "Field";
            //cell.innerHTML = entity.SpecialRequest;
            //检验结果
            cell = row.insertCell(4);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = entity.InspectionResult;

            //不良代码
            cell = row.insertCell(5);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = entity.NCCode;

            //备注
            cell = row.insertCell(6);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = entity.Remark;
        }

        function getInspectionSN() {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxQC.GetFAISNInfo(Id);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return;
            }
            if (ajax.value != null) {
                addTrContent(ajax.value);
            }
        }

        function addTrContent(list) {
            var tbObj = $("#checkSNTb");
            var trHtml = "";
            var entity;

            for (var i = 0; i < list.length; i++) {
                entity = list[i];

                trHtml += "<tr class='ListTableOddRow'><td>" + (i + 1) + "</td><td>" + entity.SN + "</td><td>" + entity.Result + "</td><td>" + entity.NCCode + "</td><td>" + entity.ScanTime + "</td>";
            }
            tbObj.html(trHtml);
        }


        function FileShow() {
            var IOrder = $("#<%=this.IOrder.ClientID %>").val();
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialIQC.GetFileInfo("", $.trim(IOrder), "");
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return;
            }
            var data = ajax.value;
            for (var i = 0; i < data.length; i++) {
                var $tr = $("<tr class='ListTableOddRow'>"
                    + "<td>" + (i + 1) + "</td>"
                    + "<td>" + data[i].ItemCode + "</td>"
                    + "<td>" + data[i].FileName + "</td>"
                    + "<td>" + data[i].FileVersion + "</td>"
                    + "<td>" + data[i].FileType + "</td>"
                    + "<td>" + data[i].CreateBy + "</td>"
                    + "<td>" + data[i].CreateDateTime + "</td>"
                    + "<td><a href='#' onclick=FileSave(this)><span style='font-size:12px;'>" + mesLang("下载") + "</span></a></td>"
                    + "</tr>");
                $("#FileInfo tbody").append($tr);
                $tr.data("FileSaveName", data[i].FileSaveName);
            }
        }

        function FileSave(el) {
            var fileName = $(el).parent().parent().data("FileSaveName");
            var path = GetFilePath("InspectionIPQCFile", fileName);

            window.open(path);
        }

        function formatDateSecond(date) {
            var year = date.getFullYear();
            var month = ('0' + (date.getMonth() + 1)).slice(-2);
            var day = ('0' + date.getDate()).slice(-2);
            var hours = ('0' + date.getHours()).slice(-2);
            var minutes = ('0' + date.getMinutes()).slice(-2);
            var seconds = ('0' + date.getSeconds()).slice(-2);
            return year + '-' + month + '-' + day + ' ' + hours + ':' + minutes + ':' + seconds;
        }

    </script>
</asp:Content>
