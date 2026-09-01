<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ViewMaster.master" AutoEventWireup="true"
    CodeBehind="MaterialHisIssue.aspx.cs" Inherits="SKT.LeanMES.Web.Material.MaterialHisIssue" %>

<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="server">
    <table width="100%" class="EditeContentTable">
        <tr class="Label1">
            <td align="left">
                <span class="information16"></span>请选择要发料的领料单
            </td>
            <td align="right">
                <span class="informationlink"></span><a href="#" onclick="openSplitMaterial();">分料截料</a>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                领料单<em>*</em>
            </td>
            <td class="Field1">
                <input type="text" value="" id="txtReuestOrder" class="TextBox" style="width: 250px;
                    height: 25px; font-size: 16px; font-weight: bold; text-transform: uppercase;" />
                <input type="button" id="Button1" class="ButtonBox" value="..." style="height: 27px;
                    font-weight: bold; text-transform: uppercase;" onclick="selectPickingList()" />
            </td>
        </tr>
        <tr>
            <td class="Label1">
                工单
            </td>
            <td class="Field1">
                <label id="woNo">
                </label>
            </td>
        </tr>
    </table>
    <div class="clear5">
    </div>
    <div style="text-align: center;" class="Tips" id="msg">
    </div>
    <div style="width: 100%; float: left" id="leftApplication">
        <table class="ListTable" width="100%" id="tblRecHistory" style="margin-top: 5px;">
            <tr class="ListTableHeader">
                <th>
                    序号
                </th>
                <th>
                    物料名称
                </th>
                <th>
                    型号规格
                </th>
                <th>
                    申请数量
                </th>
                <th>
                    已发数量
                </th>
                <th>
                    发料到
                </th>
                <th>
                    供应商
                </th>
                <th>
                    最小包装数量
                </th>
                <th>
                    剩余数量
                </th>
                <th>
                    操作
                </th>
            </tr>
            <tr id="trNewInfo" class="ListTableOddRow">
                <td colspan="10" style="text-align: center;">
                    暂无数据
                </td>
            </tr>
        </table>
    </div>
    <div id="noprtplg" class="Tips">
    </div>
    <div id="printerHolder">
    </div>
    <asp:HiddenField runat="server" ID="hdnLabelContent" Value="" />
    <script type="text/javascript" src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.utility.printer.js"></script>
    <script type="text/javascript">
        var requestOrder = 0; //领料单号
        var itemStr = ""; //存储领料单对应的ItemId
        var grnStr = ""; //存储扫描的Grn
        var itemAllQty = 0; //领料单总数量
        var requtestQty = 0;   //已发数量
        var temp = 0;
        var row = 0; //行号

        $(document).ready(function () {
            pendPrintPluginDom($("#printerHolder"));
            checkPrintPlugin($("#noprtplg"));
        });

        //选择领料单
        function selectPickingList() {
            temp = 1;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=25&Multiple=false&rnd=" + Math.random(), width: 700, height: 380 });
        }
        //选择供应商
        function selectVendorList(rowNo) {
            temp = 2;
            row = rowNo;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=34&Multiple=false&rnd=" + Math.random(), width: 700, height: 380 });
        }
        function getChooseValue(list) {
            if (temp == 1) {
                requestOrder = list[0][1];
                $("#txtReuestOrder").val(list[0][2]);
                $("#woNo").text(list[0][1]);
                setPickingList(list[0][1]);
            }
            else if (temp = 2) {
                $("#hdfVendor" + row).val(list[0][1]);
                $("#txtVendor" + row).val(list[0][2]);
            }
        }
        function setPickingList(forNumber) {
            clearWaitGrnTable();
            if (forNumber != "") {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.sendMaterialInfo(forNumber, 1);
                if (ajax.error != null) {
                    $("#msg").html(ajax.error.Message);
                    $("#msg").css("color", "red");
                    return false;
                }
                else {
                    var list = ajax.value;
                    var r = "";
                    if (list == null || list.length == 0) {
                        r += "<tr class='ListTableEmptyDataRow'><td colspan='10' ><%=Resources.Messages.NoPickingLine %></td></tr>";
                        $(r).appendTo($("#tblRecHistory"));
                        return false;
                    }
                    if (requestOrder == 0) {
                        requestOrder = list[0].MaterialRequestId;
                    }
                    $("#txtDepart").html(list[0].DepartName);
                    $("#txtApplication").html(list[0].UserName);
                    for (var i = 0; i < list.length; i++) {
                        itemStr += list[i].ErpItemId + ','; //物料id
                        itemAllQty += list[i].StockQty;
                        r += "<tr class='ListTableOddRow'><td></td>";
                        r += "<td>" + list[i].ItemName + "</td>";
                        r += "<td style='width:15%'>" + list[i].ItemModel + "</td>";
                        r += "<td id='qty" + list[i].ErpItemId + "'>" + list[i].StockQty + "</td><td  id='td" + list[i].ErpItemId + "'>" + list[i].QtyMust + "</td>";
                        r += "<td align='center'><select id='selectSend" + list[i].ErpItemId + "' ><option value='2' selected='selected'>产线</option><option value='1'>线边仓</option></select></td>";
                        r += "<td align='center' ><div style='overflow:visible; min-width:230px;'><input type='text' value=''  id='txtVendor" + i + "' class='TextBox' style='width: 200px; height: 25px;' disabled='disabled'/>";
                        r += "<input type='button' id='Button1" + i + "' class='ButtonBox' value='...' style='height: 27px;font-weight: bold; text-transform: uppercase;' onclick='selectVendorList(" + i + ")' /><input id='hdfVendor" + i + "' type='hidden' /><div></td>";
                        r += "<td align='center'><em>*</em>&nbsp;<input id='minCount" + list[i].ErpItemId + "' maxlength='12'  style='width:80px;' type='text' onkeyup=\"if(isNaN(value))execCommand('undo')\" onafterpaste=\"if(isNaN(value))execCommand('undo')\"/></td>";
                        r += "<td align='center'><em>*</em>&nbsp;<input id='printCount" + list[i].ErpItemId + "' maxlength='12' style='width:80px;' onkeyup=\"if(isNaN(value))execCommand('undo')\" onafterpaste=\"if(isNaN(value))execCommand('undo')\"   type='text' value='" + GetDataValue(list[i].StockQty - list[i].QtyMust)  + "' /></td>";
                        r += "<td align='center'><input  type='button' class='SearchButton' value='发料' style='cursor:pointer;' onclick='ImportGRN(this);'/><input id='hdfItemValue' type='hidden' value='" + list[i].ErpItemId + "'/><input id='hdfItemCode' type='hidden' value='" + list[i].ItemCode + "'/></td>";
                        r += "</tr>";
                    }

                    if ($("#tblRecHistory tr").length == 1) {
                        $("#tblRecHistory tr:eq(0)").after(r);
                    }
                    else {
                        $("#tblRecHistory tr:eq(1)").before(r);
                    }
                    var j = 0;
                    $("#tblRecHistory tr").each(function () {
                        $(this).children("td:eq(0)").html(j.toString());
                        j++;
                    });
                }
            }
        }
        function GetDataValue(obj) {
            if (parseFloat(obj) < 0) {
                obj = '0.000';
            }
            else {
                obj = obj.toFixed(3);
            }
            return obj;
        }
        //行点击生成按钮事件
        //物料编号
        var _itemCode = "";
        //厂商编码
        var _vendorCode = "";
        //周数
        var theWeek = '<%=DateTime.Now.Year.ToString().Substring(2, 2) + SKT.LeanMES.Web.AppCode.Utility.DateTimeUtility.GetWeekOfYear(DateTime.Now).ToString() %>';
        //数量
        var _printCount = 0;
        function ImportGRN(obj) {
            //id
            var itemId = $(obj).next().val(); //id
            //item code
            var itemCode = $(obj).next().next().val();
            //行号
            var rowValue = $(obj).parent().parent().find('td:first').text();
            //要打印GRN的数量
            var printCount = $('#printCount' + itemId).val();
            //最小包装数量
            var minCount = $('#minCount' + itemId).val();
            //发料到
            var sendTo = $('#selectSend' + itemId).find("option:selected").val();
            //供应商
            var vendor = $('#hdfVendor' + (parseInt(rowValue) - 1)).val();
            //已发数量
            var sendYet = $('#td' + itemId).text();
            //请求数量
            var requestCount = $('#qty' + itemId).text();
            //每次生成的GRN*最小包装数+已发数量
            var myCount = parseFloat(printCount) * parseFloat(minCount) + parseFloat(sendYet);
            /* parseFloat(printCount + sendYet).toFixed(3);*/
            var ajax = "";
            if (vendor == "") {
                alert('请选择供应商!');
                return false;
            }
            if (isNull(minCount)) {
                alert('最小包装数量不能为空!');
                $('#minCount' + itemId).focus();
                return false;
            }
            if (isNull(printCount)) {
                alert('要打印GRN的数量不能为空!');
                $('#printCount' + itemId).focus();
                return false;
            }
            if (printCount == 0) {
                alert('发料剩余数量为0,不能发料!');
                return false;
            }
            if ((parseFloat(printCount) + parseFloat(sendYet)) >parseFloat(requestCount)) {
                alert("发料数量已经达到或超过请求数量,不能再发料!"); 
                return false;
            }
            if (confirm('确定该领料单发料?')) {
                //生成GRN

                ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.GenerateGRN(itemId, parseFloat(printCount), parseFloat(minCount), '', '', vendor, '', 0);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }
                var userName = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>';
                //保存发料信息
                //ajax.value[0]为GRN

                var ajaxSend = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.SaveSendMaterialHis(requestOrder.toString(), parseInt(sendTo), ajax.value[0], parseInt(myCount), parseInt(itemId), userName);
                if (ajaxSend.error != null) {
                    alert(ajaxSend.error.Message);
                    return false;
                }
                else {
                    $('#td' + itemId).text(parseFloat($('#td' + itemId).text()) + parseFloat($('#printCount' + itemId).val()));
                    $('#printCount' + itemId).val(parseFloat(requestCount) - parseFloat($('#td' + itemId).text()));
                    alert("发料成功!");
                }

                var arr = ajax.value;
                if (arr != null) {
                    _itemCode = itemCode;
                    _vendorCode = vendor;
                    _printCount = minCount;
                    printGRN(arr);
                }
            }
        }
        var itemId = -1; //获取选中的ItemId
        /* 清空指定table中数据 */
        function clearWaitGrnTable() {
            if ($("#tblRecHistory tr").length > 1) {
                $("#tblRecHistory tr:not(:first)").remove();
            }
            $("#iframeGrnList").attr("src", "");
            $("#showGrn").html("");
            $("#txtDepart").html("");
            $("#txtApplication").html("");
            itemStr = ""; //存储领料单对应的ItemId
            grnStr = ""; //存储扫描的Grn
            itemAllQty = 0; //领料单总数量
            requtestQty = 0;   //已发数量
        }
        var grnArr;
        var itemInfo;
        var vendorSort;
        var __txtQty = "";
        var __txtLeft = 0;
        var labelPrintingPlugin;
        function printGRN(arr) {
            __txtQty = _printCount;
            labelPrintingPlugin = document.getElementById("labelPrintingPlugin");

            if (arr == null) {
                return false;
            }
            arr[0] = arr[0].substring(0, arr[0].lastIndexOf(","));
            grnArr = arr[0].split(",");
            itemInfo = arr[1].split(",");
            vendorSort = arr[2].split(",");

            prtLabel();


        }
        var iCount = 0;
        function prtLabel() {

            if (grnArr.length) {
                var s = "... ...";
                iCount = (iCount > 6) ? 0 : (iCount + 1);
                $("#lblPt").html("正在排队打印，还有" + grnArr.length.toString() + "个条码等待打印" + s.substring(0, iCount));
                var __grn = grnArr.shift();

                //数量
                var __printCount = __grn.substring(__grn.indexOf("|") + 1, __grn.length);
                //GRN
                var grnstr = __grn.substring(0, __grn.indexOf("|"));
              
                var vendorLot = _itemCode.toString() + "+" + _vendorCode.toString() + "+" + theWeek.toString() + "+" + __printCount.toString().replace(".000","");

                var zplContent = $("#<%=this.hdnLabelContent.ClientID %>").val();
                zplContent = zplContent.replace(new RegExp("%VendorLot%", "gm"), vendorLot);
                zplContent = zplContent.replace(new RegExp("%ID%", "gm"), grnstr.toString());

                doPrintGrn(labelPrintingPlugin, zplContent);
                setTimeout(prtLabel, 300);
            }
             
        }
        function openSplitMaterial() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Material/MaterialSplit.aspx?name=Material_MaterialSplit";
            dialog({ title: "分料截料", src: openWinUrl, width: 750, height: 400 });
        }
    </script>
</asp:Content>
