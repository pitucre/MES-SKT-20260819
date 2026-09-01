<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master"
    AutoEventWireup="true" CodeBehind="GenerateVirtualPo.aspx.cs" Inherits="SKT.LeanMES.Web.Material.GenerateVirtualPo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div>
        <div class="interval">
        </div>
        <div class="leftcontent">
            <fieldset style="height: 200px">
                <legend>查询条件</legend>
                <table width="100%" class="EditeContentTable">
                    <tr>
                        <td class="Label4">
                            供应商<em>*</em>
                        </td>
                        <td class="Field4">
                            <input type="hidden" value="-1" id="hdnVenID" />
                            <input type="hidden" value="" id="hdnVendorCode" />
                            <input type="text" value="" id="txtVendorName" disabled="disabled"  />
                            <input type="button" value="..." class="ButtonBox" onclick="chooseVendor(1)" />
                        </td>
                        <td class="Label4">
                            操作员
                        </td>
                        <td class="Field4">
                            <input class="TextBox" id="txtCreateBy" style="width:87%"/>
                        </td>
                        
                    </tr>
                    <tr>
                        <td class="Label4">
                            开始时间
                        </td>
                        <td class="Field4">
                            <input type="text" id="txtDateFrom" class="DateTimeBox" style="width:80%"/>
                        </td>
                        <td class="Label4">
                            结束时间
                        </td>
                        <td class="Field4">
                            <input type="text" id="txtDateTo" class="DateTimeBox" style="width:80%"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="Field4" colspan="4" style="text-align:center">
                            <input class="SearchButton" id="btnQuery" type="button" value="查  询" onclick="QueryGrn()" />
                            <input class="SearchButton" id="btnEmpty" type="button" value="清  空" onclick="Empty()" />
                        </td>
                    </tr>
                </table>
            </fieldset>
        </div>
        <div class="interval">
        </div>
        <div class="middlecontent">
            <fieldset style="height: 200px">
                <legend>输入项</legend>
                <table width="100%" class="EditeContentTable">
                    <tr>
                        <td class="Label4">
                            供应商<em>*</em>
                        </td>
                        <td class="Field4">
                            <input type="hidden" value="-1" id="hdnInputVenID" />
                            <input type="hidden" value="" id="hdnInputVendorCode" />
                            <asp:Label ID="lblInputVendorName" runat="server" Text=""></asp:Label>
                            <input type="text" value="" id="txtInputVendorName" disabled="disabled" isrequired="1"  style="display:none;"/>
                     <%--       <input type="button" value="..." class="ButtonBox" onclick="chooseVendor(2)" />--%>
                        </td>
                    </tr>
                    <tr>
                        <td class="Label4">
                            收货方式<em>*</em>
                        </td>
                        <td class="Field4">
                            <select style="width:79%" id="selReceiveType" isrequired="1">
	                            <option value="厂商直送">厂商直送-检验</option>
	                            <option value="工厂自取">工厂自取-免检</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td class="Label4">
                            订单号
                        </td>
                        <td class="Field4">
                            <input class="TextBox" id="txtSOCode" style="width:79%"   readonly="readonly"/>
                            <input type="button" onclick="selectSOCode();" class="ButtonBox" value="..." />

                        </td>
                    </tr>
                    <tr>
                        <td class="Label4">
                            客户
                        </td>
                        <td class="Field4">
                            <asp:Label ID="lblCus" runat="server" Text="" ></asp:Label>

                        </td>
                    </tr>
                    <tr>
                        <td class="Label4">
                            备注
                        </td>
                        <td class="Field4">
                            <input class="TextBox" id="txtRemark" style="width:79%"/>
                        </td>
                    </tr>
                </table>
            </fieldset>
        </div>
    </div>
    <div id="lblMessage" class="Tips" style="text-align: center">
    </div>
    <div style="height:5px"></div>
    <table class="ListTable" width="100%" id="tbGrnList">
        <tr class="ListTableHeader">
            <%--<th width="3%"><input onchange='cbAllClick(this)' type='checkbox'/></th>--%>
            <th width="3%">序号</th>
            <th width="140px">物料编码</th>
            <th width="170px">物料名称</th>
            <th>物料规格</th>
            <th width="15%">GRN</th>
            <th width="50px">数量</th>
            <th width="80px">条码生成日期</th>
            <th width="50px">打印人</th>
        </tr>
    </table>
    <style type="text/css">
        fieldset
        {
            border: #2491BF solid 1px;
        }
        legend
        {
            font-size: 13px;
            font-weight: bold;
            color: #296AA0;
            
            background-repeat: no-repeat;
            height: 24px;
            padding-top: 2px;
            padding-left: 5px;
        }
        .leftcontent
        {
            float: left;
            width: 60%;
            height: 126px;
            border: 0px solid #b9d8e0;
        }
        .rightcontent
        {
            float: left;
            width: 39%;
            height: 126px;
            border: 0px solid #b9d8e0;
        }
        .interval
        {
            float: left;
            width: 0.5%;
            height: 126px;
            border: 0px solid #b9d8e0;
        }
    </style>
    <script type="text/javascript" src="../Content/js/jquery-3.1.0.min.js"></script>
    <script type="text/javascript" src="../Content/plugin/jquery-easyui-1.4.2/layer/layer.js"></script>
    <script type="text/javascript">
        var entityList = null;
        var falg = 1;
        var VenID = '<%=Request.QueryString["VenID"]%>'; 
        var VendorName = '<%=Request.QueryString["VendorName"]%>'; 
        var VendorCode = '<%=Request.QueryString["VendorCode"]%>';
        var SerialNumberStr = "";

        $(function () {
            if (VendorCode != "") {
                $("#hdnVenID").val(VenID);
                $("#txtVendorName").val(VendorName);
                $("#hdnVendorCode").val(VendorCode);


                //保存的
                $("#hdnInputVenID").val(VenID);
                $("#txtInputVendorName").val(VendorName);
                $("#<%=this.lblInputVendorName.ClientID%>").text(VendorName)
                $("#hdnInputVendorCode").val(VendorCode);
            }
        });
      
        //查询可生成送货单的GRN
        function QueryGrn() {
            var VendorCode = $("#hdnVendorCode").val();//供应商编码
            var DateFrom = $("#txtDateFrom").val();//开始时间
            var DateTo = $("#txtDateTo").val();//结束时间
            var CreateBy = $("#txtCreateBy").val();//操作人

            if (VendorCode == "") {
                alert("请选择供应商！");
                return false;
            }
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.QueryVirtualPoGrn(VendorCode, DateFrom, DateTo, CreateBy);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var entity = ajax.value;
            SerialNumberStr = "";
            var logList = '';
            var _css = 'ListTableOddRow';
            $("#tbGrnList tr:gt(0)").remove();

            for (var i = 0; i < entity.length; i++) {
                if (i % 2 == 0) _css = 'ListTableEvenRow';
                else _css = 'ListTableOddRow';

                logList += '<tr class="' + _css + '">';
                //logList += '<td style="text-align:center"><input name="cbSerialNumber" value="' + entity[i].SerialNumber + '" type="checkbox"/></td>';
                logList += '<td>' + (i + 1).toString() + '</td>';
                logList += '<td>' + entity[i].ItemCode + '</td>';
                logList += '<td>' + entity[i].ItemName + '</td>';
                logList += '<td>' + entity[i].ItemSpec + '</td>';
                logList += '<td>' + entity[i].SerialNumber + '</td>';
                logList += '<td>' + entity[i].Quantity + '</td>';
                logList += '<td>' + entity[i].CreateDateTime.Format("yyyy-MM-dd") + '</td>';
                logList += '<td>' + entity[i].CreateBy + '</td>';
                logList += '</tr>';

                SerialNumberStr = SerialNumberStr + entity[i].SerialNumber + ",";
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

        //生成虚拟PO单
        function Save() {
            //var SerialNumberStr = "";//条码信息
            var VendorCode = $("#hdnInputVendorCode").val();//供应商编码
            var VenID = $("#hdnInputVenID").val();//供应商ID
            var ReceiveType = $("#selReceiveType").val(); //收料方式
            var Remark = $("#txtRemark").val(); //备注
            var SOCode = $("#txtSOCode").val(); //订单号  added by zhi.li 20180926
            
            //if (VendorCode == "") {
            //    alert("请选择客户！");
            //    return false;
            //}
            if (SerialNumberStr == "") {
                alert("没有需要生成虚拟采购订单的GRN！");
                return false;
            }
            //var cbSerialNumber = $("input[name='cbSerialNumber']:checked");
            //if (cbSerialNumber.length == 0) {
            //    alert("请先选择需要虚拟采购订单的GRN！");
            //    return false;
            //}
            //$('input[name="cbSerialNumber"]:checked').each(function () {
            //    SerialNumberStr = SerialNumberStr + $(this).val() + ",";
            //});
            
            //保存至数据库
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.SaveVirtualPo(VenID, VendorCode, ReceiveType, Remark, SerialNumberStr, SOCode);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert("生成虚拟采购订单成功！");
            QueryGrn();
            $("#lblMessage").html("虚拟采购订单生产成功："+ajax.value);
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
        function chooseVendor(sign) {
            falg = sign;
           dialog({
               title: "<%=Resources.Common.ChooseWindow %>",
               src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=34&CallBackFunc=setVendor&Multiple=false&rnd=" + Math.random(), width: 680, height: 350
            });
        }
        function setVendor(list) {
            if (falg == 1) {
                $("#hdnVenID").val(list[0][0]);
                $("#txtVendorName").val(list[0][2]);
                $("#hdnVendorCode").val(list[0][1]);
                $("#txtVendorName").attr("disabled", "disabled");


                //保存的
                $("#hdnInputVenID").val(list[0][0]);
                $("#txtInputVendorName").val(list[0][2]);
                $("#<%=this.lblInputVendorName.ClientID%>").text(list[0][2])
                $("#hdnInputVendorCode").val(list[0][1]);
                $("#txtInputVendorName").attr("disabled", "disabled");


            }
            if (falg == 2) {
                $("#hdnInputVenID").val(list[0][0]);
                $("#txtInputVendorName").val(list[0][2]);
                $("#hdnInputVendorCode").val(list[0][1]);
                $("#txtInputVendorName").attr("disabled", "disabled");
            }

        }
        //清空所有的数据
        function Empty() {
            $("#hdnVenID").val(-1);
            $("#txtVendorName").val("");
            $("#hdnVendorCode").val("");
            $("#txtDateFrom").val("");
            $("#txtDateTo").val("");
            $("#txtCreateBy").val("");
        }


        //选订单
        function selectSOCode() {
            dialog({
                title: "<%=Resources.Common.ChooseWindow %>"
                , src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=810&CallBackFunc=getChooseValuesselectSOCode&Multiple=false&rnd=" + Math.random(), width: 650, height: 350
            });
        }
        //返回客户
        function getChooseValuesselectSOCode(list) {
            $("#txtSOCode").val(list[0][1])
            $("#<%=this.lblCus.ClientID%>").text(list[0][2])
        }




    </script>
</asp:Content>
