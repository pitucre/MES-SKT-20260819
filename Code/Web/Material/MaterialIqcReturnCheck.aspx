<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/ViewMaster.master"
    CodeBehind="MaterialIqcReturnCheck.aspx.cs" Inherits="SKT.LeanMES.Web.Material.MaterialIqcReturnCheck" %>

<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="server">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1">扫描GRN
            </td>
            <td class="Field1">
                <input type="text" id="txtGRN" class="TextBox" />
            </td>

        </tr>
        <tr>
            <td class="Label1">待退GRN数量
            </td>
            <td class="Field1" id="tdTotal"></td>

        </tr>
        <tr>
            <td class="Label1">已扫描GRN数量
            </td>
            <td class="Field1" id="tdScan"></td>
        </tr>
    </table>
    <table id="tblExpand" cellspacing="0" cellpadding="4" style="border-width: 0px; width: 100%; border-collapse: collapse; margin-top: 5px;"
        class="EditeContentTable">
        <tr class="ListTableHeader">
            <th scope="col" align="center" style="width: 4%;">行号
            </th>
            <th scope="col" align="center" style="width: 12%;">GRN条码
            </th>
            <th scope="col" align="center" style="width: 12%;">物料编码
            </th>
            <th scope="col" align="center" style="width: 5%;">物料数量
            </th>
            <th scope="col" align="center" style="width: 5%;">合格数量
            </th>
            <th scope="col" align="center" style="width: 5%;">不合格数量
            </th>
            <th scope="col" align="center" style="width: 18%;">不良描述
            </th>
        </tr>
        <tr id="trNewInfo" class="ListTableOddRow">
            <td colspan="7" style="text-align: center;">暂无数据
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        var IQCBatchId = '<%=Request.QueryString["IQCBatchId"]%>'; //退货ID
        var iqcNo=  '<%=Request.QueryString["iqcNo"]%>'; //退货ID
        var returnMode = '<%=Request.QueryString["ReturnMode"]%>'; //退货模式
        var scanGrn = [];
        var arrGrn = [];
        $("form").submit(function (e) {
            if (e && e.preventDefault) {
                e.preventDefault();
            }
            else {
                window.event.returnValue = false;
            }
            return false;
        })


        $("#txtGRN").keydown(function () {
            var curKey = 0, e = e || window.event;
            curKey = e.keyCode || e.which || e.charCode;
            if (curKey == 13) {
                checkGrn($.trim($("#txtGRN").val()));
            }
        });

        $(function () {
            showMaterialRequestInfo();
            $("#txtGRN").focus();
        });
        //根据检验单号查询GRN信息
        function showMaterialRequestInfo() {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialIQC.GetIqcFormGrnReturn(IQCBatchId);

            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var List = $.parseJSON(ajax.value).data1;
            $("#tdTotal").html(List.length || 0);
            $("#tdScan").html(scanGrn.length || 0);

            for (var i = 0; i < List.length; i++) {
                addDetail(List[i], i);
                arrGrn.push(List[i].GRN);
            }
        }

        var tab = document.getElementById("tblExpand");
        //var i = 0;

        function addDetail(entity, i) {
            if (entity == null) {
                return;
            }
            i += 1;
            $("#trNewInfo").remove();
            var row, cell;
            rowNewIdx = tab.rows.length;
            row = tab.insertRow(rowNewIdx);
            row.className = "ListTableOddRow";
            //行号
            cell = row.insertCell(0);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = i.toString();

            cell = row.insertCell(1);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = entity.GRN;

            cell = row.insertCell(2);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = entity.ItemCode;

            cell = row.insertCell(3);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = parseFloat(entity.TotalQty);

            cell = row.insertCell(4);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = parseFloat(entity.OKQty);

            cell = row.insertCell(5);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = parseFloat(entity.NgQty);

            cell = row.insertCell(6);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = entity.Remark;
        }

        function checkGrn(grn) {
            for (var i in scanGrn) {   //已扫描的检查
                if (scanGrn[i] === grn) {
                    alert('请不要重复扫描');
                    $("#txtGRN").val("").focus();
                    return false;
                }
            }
            for (var i in arrGrn) {   //目标GRN检查
                if (arrGrn[i] == grn) {
                    scanGrn.push(grn);
                    $("#tdScan").html(scanGrn.length);
                    $("td").each(function () {
                        if ($(this).html() === grn) {
                            $(this).css("background", "green");
                            $("#txtGRN").val("").focus();
                        }
                    });
                }
            }

            if (scanGrn.length === arrGrn.length) {
                confirm();
            }
        }

        function confirm() {
            var entity = {};
            entity.ReturnFormId = parseInt(IQCBatchId);
            <%--entity.ConfirmBy = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
            entity.ReturnMode = parseInt(returnMode);--%>
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialIQC.ConfirmIqcReturn(entity, parseInt(returnMode));
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                }
                else {
                    alert("退货成功!");
                    if (returnMode === '1') window.parent.updatelist();
                    //if (returnMode === '0') window.parent.pdfReturnOrder();
                    if (returnMode === '0') {
                        var spPara = {}
                        spPara.InspectionNo = iqcNo;
                        spPara.UserName = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().EmployeeCName%>';
                        var spJson = JSON.stringify(entity);
                        window.open("<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Material/IqcReturnPrint.aspx?spJson=" + JSON.stringify(spPara)); 
                        window.parent.updatelist();
                    }
                }
            }
    </script>
</asp:Content>
