<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master"
    AutoEventWireup="true" CodeBehind="DeliverPrint.aspx.cs" Inherits="SKT.LeanMES.Web.Material.DeliverPrint" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">

    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label4">
                供应商代码
            </td>
            <td class="Field4">
                <input type="hidden" value="-1" id="hdnVenID" />
                <input type="text" value="" id="txtVendorCode" isrequired="1" />
                <input type="button" value="..." class="ButtonBox" onclick="chooseVendor(34)" />
            </td>
            <td class="Label4">
                供应商名称
            </td>
            <td class="Field4">
                <label id="lblVendorName"></label>
            </td>
            <td class="Label4">
                开始时间
            </td>
            <td class="Field4">
                <input type="text" id="txtDateFrom" class="DateTimeBox" />
            </td>
            <td class="Label4">
                结束时间
            </td>
            <td class="Field4">
                <input type="text" id="txtDateTo" class="DateTimeBox" />
            </td>
        </tr>
        <tr>
            <td class="Label4">
                物料编码
            </td>
            <td class="Field4">
                <input type="hidden" value="-1" id="hdnItemId" />
                <input type="hidden" value="-1" id="hdnRowId" />
                <input type="text" id="txtItemCode" class="TextBox" disabled="disabled" value="" /><input
                    type="button" id="btnSelectItem" class="ButtonBox" value="..." onclick="selectItem()" />
            </td>
            <td class="Label4">
                包装箱号
            </td>
            <td class="Field4">
                <input class="TextBox" id="txtCarton" />
            </td>
            <td class="Label4">
                GRN
            </td>
            <td class="Field4">
                <input class="TextBox" id="txtGRN" />
            </td>
            <td class="Label4">
                操作员
            </td>
            <td class="Field4">
                <input class="TextBox" id="txtCreateBy" />
            </td>
        </tr>
    </table>
    <div style="height:5px"></div>
    <div style="text-align:center">
        <input class="SearchButton" id="btnQuery" type="button" value="查  询" onclick="QueryGrn()" />
                <input class="SearchButton" id="btnEmpty" type="button" value="清  空" onclick="Empty()" />
    </div>
    <div style="height:5px"></div>
    <%--<div id=""test" style="overflow:scroll;height:400px">--%>
    <table class="ListTable" width="100%" id="tbGrnList">
        <tr class="ListTableHeader">
            <th width="3%"><input onchange='cbAllClick(this)' type='checkbox'/></th>
            <th width="3%">序号</th>
            <th>物料编码</th>
            <th>物料名称</th>
            <th>物料规格</th>
            <th>包装箱号</th>
            <th width="15%">GRN</th>
            <th>数量</th>
            <th>物料条码生成时间</th>
            <th>打印人</th>
        </tr>
    </table>
<%--   </div>--%>
    <script type="text/javascript" src="../Content/js/jquery-3.1.0.min.js"></script>
    <script type="text/javascript" src="../Content/plugin/jquery-easyui-1.4.2/layer/layer.js"></script>
    <script type="text/javascript">
        var entityList = null;
        var falg = 34;

        var VendorName = '<%=Request.QueryString["VendorName"]%>'; 
        var VendorCode = '<%=Request.QueryString["VendorCode"]%>';

        $(function () {
            if (VendorCode != "") {
                $("#lblVendorName").text(VendorName);
                $("#txtVendorCode").val(VendorCode);
            }
        });
      
        //查询可生成送货单的GRN
        function QueryGrn() {
            var VendorCode = $("#txtVendorCode").val();//供应商编码
            var DateFrom = $("#txtDateFrom").val();//开始时间
            var DateTo = $("#txtDateTo").val();//结束时间
            var ItemId = $("#hdnItemId").val();//物料ID
            var Carton = $("#txtCarton").val();//包装箱号
            var GRN = $("#txtGRN").val();//GRN
            var CreateBy = $("#txtCreateBy").val();//操作人

            if (VendorCode == "") {
                alert("请选择供应商！");
                return false;
            }
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.QueryDeliverGrn(VendorCode, DateFrom, DateTo, ItemId, Carton, GRN, CreateBy);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var entity = ajax.value;

            var logList = '';
            var _css = 'ListTableOddRow';
            $("#tbGrnList tr:gt(0)").remove();

            for (var i = 0; i < entity.length; i++) {
                if (i % 2 == 0) _css = 'ListTableEvenRow';
                else _css = 'ListTableOddRow';

                
                logList += '<tr class="' + _css + '">';
                logList += '<td style="text-align:center"><input name="cbSerialNumber" value="' + entity[i].SerialNumber + '" type="checkbox"/></td>';
                logList += '<td>' + (i + 1).toString() + '</td>';
                logList += '<td>' + entity[i].ItemCode + '</td>';
                logList += '<td>' + entity[i].ItemName + '</td>';
                logList += '<td>' + entity[i].ItemSpec + '</td>';
                logList += '<td>' + entity[i].CBarCode + '</td>';
                logList += '<td>' + entity[i].SerialNumber + '</td>';
                logList += '<td>' + entity[i].Quantity + '</td>';
                logList += '<td>' + entity[i].CreateDateTime.Format("yyyy-MM-dd hh:mm:ss") + '</td>';
                logList += '<td>' + entity[i].CreateBy + '</td>';
                //logList += '<td><img title="删除" src="../Content/images/delete.gif" onclick=Delet(this,"' + entity[i].SignId + '")></img></td>';
                logList += '</tr>';

            }
            $("#tbGrnList").append(logList);
           
        }

        //全选事件
        function cbAllClick(obj) {
            if ($(obj).is(':checked')) {
                $("[name = cbSerialNumber]:checkbox").prop("checked", true);
            } else {
                $("[name = cbSerialNumber]:checkbox").prop("checked", false);
            }
        }

        //生成送货单并打印
        function Save() {
            var SerialNumberStr = "";//条码信息
            var cbSerialNumber = $("input[name='cbSerialNumber']:checked");
            if (cbSerialNumber.length == 0) {
                alert("请先选择需要生成送货单的GRN！");
                return false;
            }
            $('input[name="cbSerialNumber"]:checked').each(function () {
                SerialNumberStr = SerialNumberStr + $(this).val() + ",";
            });
            var VendorCode = $("#txtVendorCode").val();//供应商编码
            //保存至数据库
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.SaveAndPrintDeliver(VendorCode, SerialNumberStr);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            QueryGrn();
            alert("生成送货单成功");
            QueryGrn();
            window.open("<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Material/MaterialDeliFormPrint.aspx?name=Material_DeliveryFormPrint&ID=" + ajax.value);
        }

        //选择产品
        function selectItem() {
            falg = 1;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=1&Multiple=false&rnd=" + Math.random(), width: 660, height: 300 });
        }
        function getChooseValue(list) {
            if (falg == 1) {
                $("#txtItemCode").val(list[0][1]);
                $("#hdnItemId").val(list[0][0]);
                $("#txtItemCode").attr("disabled", "disabled");
            }
            if (falg == 34) {
                $("#hdnVenID").val(list[0][0]);
                $("#txtVendorCode").val(list[0][1]);
                $("#lblVendorName").text(list[0][2]);
                
                
            }
           
        }
        Date.prototype.Format = function (fmt) {
            var o = {
                "M+": this.getMonth() + 1,
                "d+": this.getDate(),
                "h+": this.getHours(),
                "m+": this.getMinutes(),
                "s+": this.getSeconds(),
                "q+": Math.floor((this.getMonth() + 3) / 3),
                "S": this.getMilliseconds()
            };
            if (/(y+)/.test(fmt))
                fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
            for (var k in o)
                if (new RegExp("(" + k + ")").test(fmt))
                    fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
            return fmt;
        }

        //选中供应商
       function chooseVendor() {
           dialog({
               title: "<%=Resources.Common.ChooseWindow %>",
                src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=34&Multiple=false&rnd=" + Math.random(), width: 650, height: 350
            });
       }
        //清空所有的数据
        function Empty() {
            $("#hdnVenID").val(-1);
            $("#txtVendorCode").val("");
            $("#lblVendorName").text("");
            $("#txtDateFrom").val("");
            $("#txtDateTo").val("");
            $("#hdnItemId").val(-1);
            $("#hdnRowId").val(-1);
            $("#txtItemCode").val("");
            $("#txtCarton").val("");
            $("#txtGRN").val("");
            $("#txtCreateBy").val("");
        }
    </script>
</asp:Content>