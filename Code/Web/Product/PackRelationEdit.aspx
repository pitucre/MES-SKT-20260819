<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master"
    AutoEventWireup="true" CodeBehind="PackRelationEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Product.PackRelationEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <fieldset style="height: 108px">
        <legend><%=Resources.lang.MainInformation %></legend>
        <table width="100%" class="EditeContentTable">
            <tr>
                <td class="Label2">工单号<em>*</em>
                </td>
                <td class="Field2">
                    <asp:TextBox ID="txtOrderNo" runat="server" CssClass="TextBox" ClientIDMode="Static" ReadOnly="true" isrequired="1"></asp:TextBox>
                    <input type="button" id="bnOper" class="ButtonBox" onclick="openChoosePage()" value="..." />
                </td>
                <td class="Label2">订单号<em>*</em>
                </td>
                <td class="Field2">
                    <asp:TextBox ID="txtCustomerOrder" runat="server" CssClass="TextBox" disabled="disabled" ClientIDMode="Static" isrequired="1"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="Label2">号码类型<em>*</em>
                </td>
                <td class="Field2">
                    <asp:DropDownList ID="ddlNumberType" runat="server" ClientIDMode="Static" isrequired="1" Width="57%">
                        <asp:ListItem Value="客户号码">客户号码</asp:ListItem>
                        <asp:ListItem Value="大箱">大箱</asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td class="Label2">数量<em>*</em>
                </td>
                <td class="Field2">
                    <asp:TextBox ID="txtQty" runat="server" CssClass="TextBox" ClientIDMode="Static" disabled="disabled" isrequired="1" onkeyup="if(isNaN(value))execCommand('undo')"
                        onafterpaste="if(isNaN(value))execCommand('undo')"></asp:TextBox>
                </td>
            </tr>
        </table>
    </fieldset>
    <fieldset style="height: 250px" id="fdBar">
        <legend><%=Resources.lang.BarcodeInformation %></legend>
        <table width="100%" class="EditeContentTable">
            <tr id="trPrefix">
                <td class="Label2">条码前缀
                </td>
                <td class="Field2">
                    <asp:TextBox ID="txtPrefix" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
                </td>
                <td class="Label2">条码后缀
                </td>
                <td class="Field2">
                    <asp:TextBox ID="txtSuffix" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
                </td>

            </tr>
            <tr id="trLength">
                <td class="Label2">流水号长度
                </td>
                <td class="Field2">
                    <asp:TextBox ID="txtSerialLength" runat="server" CssClass="TextBox" ClientIDMode="Static" onkeyup="if(isNaN(value))execCommand('undo')"
                        onafterpaste="if(isNaN(value))execCommand('undo')"></asp:TextBox>
                </td>
                <td class="Label2" id="tdlIn">每箱号码数量</td>
                <td class="Field2" id="tdfIn">
                    <asp:TextBox ID="txtIncrease" runat="server" CssClass="TextBox" ClientIDMode="Static" onkeyup="if(isNaN(value))execCommand('undo')"
                        onafterpaste="if(isNaN(value))execCommand('undo')"></asp:TextBox>
                </td>
            </tr>
            <tr id="trSerialQty">
                <td class="Label2">条码个数
                </td>
                <td class="Field2">
                    <asp:TextBox ID="txtSerialQty" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
                </td>
                <td class="Label2">已维护条码总数
                </td>
                <td class="Field2">
                    <asp:Label ID="lblTotalQty" runat="server" ClientIDMode="Static"></asp:Label>
                </td>
            </tr>
            <tr id="trSerial">
                <td class="Label2">起始流水号
                </td>
                <td class="Field2">
                    <asp:TextBox ID="txtSerialBegin" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
                    <input class="SearchButton" id="btnItemCalculate" type="button" value="计算" onclick="Calculate()" />
                </td>
                <td class="Label2">结束流水号
                </td>
                <td class="Field2">
                    <asp:TextBox ID="txtSerialEnd" runat="server" disabled="disabled" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
                </td>
            </tr>
            <tr id="trMacNo">
                <td class="Label2">完整起始号码<em>*</em>
                </td>
                <td class="Field2">
                    <asp:TextBox ID="txtNumberBegin" runat="server" CssClass="TextBox" disabled="disabled" ClientIDMode="Static"></asp:TextBox>
                </td>
                <td class="Label2">完整结束号码<em>*</em>
                </td>
                <td class="Field2">
                    <asp:TextBox ID="txtNumberEnd" runat="server" CssClass="TextBox" disabled="disabled" ClientIDMode="Static"></asp:TextBox>
                    <input class="SearchButton" id="btnAdd" type="button" value="添加" onclick="AddBarToTable()" />
                    <input class="SearchButton" id="btnEmpty" type="button" value="清空" onclick="EmptyText()" />
                </td>
            </tr>
        </table>
    </fieldset>
    <div class="ListTableTitle">
        <div style="left: 10px; top: 0px; line-height: 18px;">
            待注册号码类型列表
        </div>
    </div>
    <%-- style="table-layout:fixed;word-wrap:break-word;word-break:break-all"--%>
    <table class="ListTable" width="100%" id="tblRecHistory">
        <thead>
            <tr class="ListTableHeader" style="text-align: center">
                <th>序号</th>
                <th>号码类型</th>
                <th>条码前缀</th>
                <th>条码后缀</th>
                <th>流水号长度</th>
                <th>起始流水号</th>
                <th>结束流水号</th>
                <th>完整起始号码</th>
                <th>完整结束号码</th>
                <th>每箱号码数量</th>
                <th><a href="#" onclick="AddBarToTable();">添加</a></th>
            </tr>
        </thead>
        <tbody>
            <tr id="trLast" class="ListTableOddRow">
                <td colspan="11" style="text-align: center;"><span>暂无数据</span>
                </td>
            </tr>
        </tbody>
    </table>
    <style type="text/css">
        fieldset { border: #2491BF solid 1px; }

        legend { font-size: 13px; font-weight: bold; color: #296AA0; background-repeat: no-repeat; height: 24px; padding-top: 2px; padding-left: 5px; }
    </style>
    <script type="text/javascript">
        var ScopeId = '<%=Request.QueryString["ID"]%>';
        var strOrderNo = '<%=Request.QueryString["OrderNo"]%>';
        var arrBarType = [];//

        $(function () {
            $('#ddlNumberType').change(function () {
                EmptyText();
                HideShow();
                GetCustomerOrderBarCode();
            })
            $("#txtSerialBegin").keydown(function (e) {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    Calculate();
                }
            });
            if (ScopeId > 0) {
                QueryBarType();
            }
            HideShow();

        });

        //计算按钮事件
        function Calculate() {
            if ($('#ddlNumberType').val() == "客户号码") {
                return GetItemNumberEnd();
            } else {
                return GetPackNumberEnd();
            }
        }


        //计算产品条码完整解析号码
        function GetItemNumberEnd() {
            var SerialLength = $("#txtSerialLength").val();
            var Qty = $("#txtQty").val();//工单数量
            var SerialQty = $.trim($("#txtSerialQty").val());//条码个数
            if (SerialLength == "" || SerialLength <= 0) {
                alert("条码长度不能为空并且需要大于0！");
                $("#txtSerialBegin").val('');
                $("#txtSerialLength").val('').focus();
                return false;
            }
            if (Qty == "" || Qty <= 0) {
                alert("数量不能为空并且需要大于0！");
                $("#txtSerialBegin").val('');
                $("#txtQty").val('').focus();
                return false;
            }
            if (SerialLength != $("#txtSerialBegin").val().length) {
                alert("起始流水号不符合流水号长度！");
                $("#txtSerialBegin").val('').focus();
                return false;
            }
            if (SerialQty == "") {
                alert("请输入条码个数！");
                $("#txtSerialQty").val('').focus();
                return false;
            }
            if (!isPositiveInteger(SerialQty)) {
                alert("条码个数必须为正整数！");
                $("#txtSerialQty").val('').focus();
                return false;
            }
            //if (parseInt(SerialQty) > parseInt(Qty)) {
            //    alert("条码个数不能超过工单数量！");
            //    $("#txtSerialQty").val('').focus();
            //    return false;
            //}
            var hasRegister = Qty - getRegisterQty();
            if (parseInt(SerialQty) > hasRegister) {
                alert("条码个数不能超过 " + hasRegister + "！");
                $("#txtSerialQty").val('').focus();
                return false;
            }

            var SerialBegin = $("#txtSerialBegin").val();//起始流水号
            var Prefix = $("#txtPrefix").val();//前缀
            var Suffix = $("#txtSuffix").val();//后缀
            //var Number = parseInt(SerialBegin) + parseInt(Qty) - 1;//根据起始流水号和数量计算结束流水号
            var Number = parseInt(SerialBegin) + parseInt(SerialQty) - 1;//根据起始流水号和数量计算结束流水号
            if (Number.toString().length > parseInt(SerialLength)) {
                alert("结束流水号" + Number + "位数不能超过流水号长度");
                return false;
            }
            var SerialEnd = addPreZero(Number, SerialLength);//结束流水号补0 
            $("#txtSerialEnd").val(SerialEnd);
            $("#txtNumberBegin").val(Prefix + SerialBegin + Suffix);
            $("#txtNumberEnd").val(Prefix + SerialEnd + Suffix);
            return true;
        }

        //计算大箱完整解析号码
        function GetPackNumberEnd() {
            var SerialLength = $("#txtSerialLength").val();
            var Qty = $("#txtQty").val();//工单数量
            var Increase = $("#txtIncrease").val();
            if (arrBarType.length % 2 == 0) {
                alert("请先添加客户条码");
                return false;
            }
            var SerialQty = arrBarType[arrBarType.length - 1].SerialQty;//客户条码个数          

            if (SerialLength == "" || SerialLength <= 0) {
                alert("条码长度不能为空并且需要大于0！");
                $("#txtSerialBegin").val('');
                $("#txtSerialLength").val('').focus();
                return false;
            }
            if (Qty == "" || Qty <= 0) {
                alert("数量不能为空并且需要大于0！");
                $("#txtSerialBegin").val('');
                $("#txtQty").val('').focus();
                return false;
            }
            if (SerialLength != $("#txtSerialBegin").val().length) {
                alert("起始流水号不符合流水号长度！");
                $("#txtSerialBegin").val('').focus();
                return false;
            }
            if (Increase == "" || Increase <= 0) {
                alert("每箱号码数量不能为空并且需要大于0！");
                $("#txtIncrease").val('').focus();
                return false;
            }
            if (!SerialQty) {
                alert("未获取到对应的客户条码个数！");
                return false;
            }
            //if (parseInt($("#txtQty").val() % $("#txtIncrease").val()) == 0) {
            //    Qty = parseInt($("#txtQty").val() / $("#txtIncrease").val());
            //} else {
            //    Qty = parseInt($("#txtQty").val() / $("#txtIncrease").val()) + 1;
            //}
            if (parseInt(SerialQty % $("#txtIncrease").val()) == 0) {
                Qty = parseInt(SerialQty / $("#txtIncrease").val());
            } else {
                Qty = parseInt(SerialQty / $("#txtIncrease").val()) + 1;
            }

            var SerialBegin = $("#txtSerialBegin").val();//起始流水号
            var Prefix = $("#txtPrefix").val();//前缀
            var Suffix = $("#txtSuffix").val();//后缀
            var Number = parseInt(SerialBegin) + parseInt(Qty) - 1;//根据起始流水号和数量计算结束流水号
            if (Number.toString().length > parseInt(SerialLength)) {
                alert("结束流水号" + Number + "位数不能超过流水号长度");
                return false;
            }
            var SerialEnd = addPreZero(Number, SerialLength);//结束流水号补0 
            $("#txtSerialEnd").val(SerialEnd);
            $("#txtNumberBegin").val(Prefix + SerialBegin + Suffix);
            $("#txtNumberEnd").val(Prefix + SerialEnd + Suffix);
            return true;
        }

        /*保存数据*/
        function Save() {
            //公共属性
            var OrderNo = $("#txtOrderNo").val();//工单号
            var CustomerOrder = $("#txtCustomerOrder").val();//订单号
            var Qty = $("#txtQty").val();//数量

            if (arrBarType.length <= 0) {
                alert("请先添加客户号码规则");
                return;
            }
            if (arrBarType.length % 2 == 1) {
                alert("请先添加大箱规则");
                return;
            }

            /*表单验证*/
            /*如需表单验证可以此处处理验证 开始*/

            var list = [];
            for (var i = 0; i < arrBarType.length; i++) {
                var entity = {};
                entity.NumberType = arrBarType[i].NumberType;
                entity.NumberClass = "";
                entity.Prefix = arrBarType[i].Prefix;
                entity.Suffix = arrBarType[i].Suffix;
                entity.SerialLength = arrBarType[i].SerialLength == "" ? 0 : arrBarType[i].SerialLength;
                entity.SerialBegin = arrBarType[i].SerialBegin;
                entity.SerialEnd = arrBarType[i].SerialEnd;
                entity.SpecialStr = "";
                entity.Increase = arrBarType[i].Increase == "" ? 0 : arrBarType[i].Increase;
                entity.NumberBegin = arrBarType[i].NumberBegin;
                entity.NumberEnd = arrBarType[i].NumberEnd;
                entity.IsMain = "";
                entity.Fixed = "";
                list.push(entity);
            }

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxProduct.PackRelationEdit(ScopeId, OrderNo, CustomerOrder, Qty, list);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            alert('保存成功！')
            parent.window.Refresh();
        }
        function openChoosePage(flags) {
            dialog({ title: "选择窗口", src: "../Framework/ChoosePage.aspx?PageId=44&Multiple=false&rnd=" + Math.random(), width: 600, height: 300 });
        }
        function getChooseValue(list) {
            $("#txtOrderNo").val(list[0][1]);
            $("#txtCustomerOrder").val(list[0][6]);
            $("#txtQty").val(list[0][3]);
            GetCustomerOrderBarCode();
        }
        //产品条码补0
        function addPreZero(num, i) {
            return ('00000000000000' + num).slice(-i);
        }

        //添加条码类型到列表
        function AddBarToTable() {
            var NumberType = $("#ddlNumberType").val();//号码类型
            var Prefix = $("#txtPrefix").val();//号码前缀
            var Suffix = $("#txtSuffix").val();//号码后缀
            var SerialLength = $("#txtSerialLength").val();//流水号长度
            var SerialBegin = $("#txtSerialBegin").val();//起始流水号
            var SerialEnd = $("#txtSerialEnd").val();//结束流水号
            var NumberBegin = $("#txtNumberBegin").val();//完整开始号码
            var NumberEnd = $("#txtNumberEnd").val();//完整结束号码
            var Increase = $("#txtIncrease").val();//每箱号码数量
            var SerialQty = $.trim($("#txtSerialQty").val());//条码个数

            if (NumberType == "大箱" && arrBarType.length % 2 == 0) {
                alert("请先添加客户条码");
                return false;
            }
            if (NumberType == "客户号码" && arrBarType.length % 2 == 1) {
                alert("请先添加大箱规则");
                return false;
            }
            //判断是否选择号码类型
            if (NumberType == "") {
                alert("请选择号码类型");
                return false;
            }
            //判断是否号码类型是否已经添加
            if (existsBarType(NumberType, Prefix, Suffix, SerialLength, SerialBegin, SerialEnd)) {
                alert("该号码类型规则已经添加");
                return false;
            }
            if (SerialLength == "") {
                alert("请输入流水号长度");
                $("#txtSerialLength").val('').focus();
                return false;
            }
            if (SerialBegin == "") {
                alert("请输入起始流水号");
                $("#txtSerialBegin").val('').focus();
                return false;
            }
            if (SerialEnd == "") {
                alert("请输入结束流水号");
                $("#txtSerialEnd").val('').focus();
                return false;
            }
            if (NumberBegin == "") {
                alert("请输入完整起始号码");
                return false;
            }
            if (NumberEnd == "") {
                alert("请输入完整结束号码");
                return false;
            }

            if (NumberType == "大箱") {
                SerialQty = 0;
                var BDX = "";
                for (var i = 0; i < arrBarType.length; i++) {
                    if (arrBarType[i].NumberType == "客户号码") {
                        BDX = arrBarType[i].NumberBegin;
                    }
                }
                if (BDX == "") {
                    alert("请先添加客户条码！");
                    return false;
                }
            }

            var isOk = Calculate();
            if (!isOk) {
                return false;
            }

            var obj = {};
            obj.NumberType = NumberType;
            obj.Prefix = Prefix;
            obj.Suffix = Suffix;
            obj.SerialLength = SerialLength;
            obj.SerialBegin = SerialBegin;
            obj.SerialEnd = SerialEnd;
            obj.NumberBegin = NumberBegin;
            obj.NumberEnd = NumberEnd;
            obj.Increase = Increase == "" ? 0 : Increase;
            obj.ScopeId = -1;
            obj.GroupNumber = getGroupNumber(NumberType);
            obj.SerialQty = parseInt(SerialQty);

            arrBarType.push(obj);
            Show();
        }

        function Show() {
            var data = "";
            $("#tblRecHistory tbody").html("");
            //将GRN数组拼接成HTML代码
            var html = bullderScanHtml();
            $("#tblRecHistory tbody").append(html);
            $("#lblTotalQty").text(getRegisterQty());
        }
        //将数组拼接成HTML代码
        function bullderScanHtml() {
            var html = "";
            var customerId = -1;    //客户号码对应的规则Id
            for (var i = 0; i < arrBarType.length; i++) {
                if (arrBarType[i].NumberType == "客户号码") {
                    customerId = arrBarType[i].ScopeId;
                } else {
                    customerId = arrBarType[i - 1].ScopeId;
                }
                html += "<tr onclick='trClick(this," + JSON.stringify(arrBarType[i]) + ")'><td class='Field1' style='width:5%;text-align: center;'>" + (i + 1) + "</td>"
                    + "<td class='Field1' style='width:10%;text-align: center;'>" + arrBarType[i].NumberType + "</td>"
                    + "<td class='Field1' style='width:10%;text-align: center;'>" + arrBarType[i].Prefix + "</td>"
                    + "<td class='Field1' style='width:10%;text-align: center;'>" + arrBarType[i].Suffix + "</td>"
                    + "<td class='Field1' style='width:10%;text-align: center;'>" + arrBarType[i].SerialLength + "</td>"
                    + "<td class='Field1' style='width:10%;text-align: center;'>" + arrBarType[i].SerialBegin + "</td>"
                    + "<td class='Field1' style='width:10%;text-align: center;'>" + arrBarType[i].SerialEnd + "</td>"
                    + "<td class='Field1' style='width:10%;text-align: center;'>" + arrBarType[i].NumberBegin + "</td>"
                    + "<td class='Field1' style='width:10%;text-align: center;'>" + arrBarType[i].NumberEnd + "</td>"
                    + "<td class='Field1' style='width:10%;text-align: center;'>" + arrBarType[i].Increase + "</td>"
                    + "<td class='Field1' style='width:5%;text-align: center;'><img title='删除' src='../Content/images/delete.gif' onclick=Delet('" + arrBarType[i].NumberType + "'," + customerId + "," + arrBarType[i].GroupNumber + "," + (i + 1) + ")></img></td></tr>";
            }
            return html;
        }

        //清空文本框
        function EmptyText() {
            $("#txtPrefix").val("");//号码前缀
            $("#txtSuffix").val("");//号码后缀
            $("#txtSerialLength").val("");//流水号长度
            $("#txtSerialBegin").val("");//起始流水号
            $("#txtSerialEnd").val("");//结束流水号
            $("#txtNumberBegin").val("");//完整开始号码
            $("#txtNumberEnd").val("");//完整结束号码
            $("#txtIncrease").val("");//每箱数量
            $("#txtSerialQty").val("");//条码个数
            $("#lblTotalQty").text(getRegisterQty());//已维护条码总数
            if ($('#ddlNumberType').val() == "大箱") {
                if (arrBarType.length > 2) {
                    $("#txtIncrease").val(arrBarType[1].Increase).prop("disabled", true);
                } else {
                    $("#txtIncrease").prop("disabled", false);
                }
            }
        }

        //判断号码类型是否已经添加
        function existsBarType(BarType, prefix, suffix, serialLength, serialBegin, serialEnd) {
            for (var i = 0; i < arrBarType.length; i++) {
                if (arrBarType[i].NumberType == BarType && arrBarType[i].Prefix == prefix && arrBarType[i].Suffix == suffix && arrBarType[i].SerialLength == serialLength) {
                    var beginRepeat = parseInt(serialBegin) >= parseInt(arrBarType[i].SerialBegin) && parseInt(serialBegin) <= parseInt(arrBarType[i].SerialEnd);
                    var endRepeat = parseInt(serialEnd) >= parseInt(arrBarType[i].SerialBegin) && parseInt(serialEnd) <= parseInt(arrBarType[i].SerialEnd);
                    if (beginRepeat || endRepeat) {
                        return true;
                    }
                }
            }
            return false;
        }

        //删除号码类型
        function Delet(barType, customerId, groupNumber, index) {
            if (customerId != -1) {
                //验证是否允许删除
                var entity = {};
                entity.ScopeId = customerId;
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxProduct.IsAllowDeletePackRelation(entity);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }
            }
            var siblingType = barType == "客户号码" ? "大箱" : "客户号码";//同组别条码规则
            var deleteIndex = barType == "客户号码" ? (index + 1) : (index - 1);
            if (index == arrBarType.length) {
                //如果移除的是最后一项，不需要提示
                sureDelete(-1, index);
            } else {
                //如果移除的不是最后一项，则需要提示是否删除同组别的序号规则
                if (confirm("删除此" + barType + "规则，将同时删除序号为" + deleteIndex + "的" + siblingType + "规则，确定要删除吗？")) {
                    sureDelete(groupNumber, -1);
                }
            }
        }

        //确认删除
        function sureDelete(groupNumber, index) {
            if (groupNumber != -1) {
                //按组别删除
                var idx = -1;
                for (var i = 0; i < arrBarType.length; i++) {
                    if (arrBarType[i].GroupNumber == groupNumber) {
                        idx = i;
                        break;
                    }
                }
                //按索引删除
                arrBarType.splice(idx, 2);
            } else {
                //按索引删除
                arrBarType.splice(index - 1, 1);
            }

            //重置列表
            var html = bullderScanHtml();
            $("#tblRecHistory tbody").html(html);
            $("#lblTotalQty").text(getRegisterQty());
        }


        //隐藏/显示TR
        function HideShow() {
            if ($("#ddlNumberType").val() == "客户号码") {
                $("#tdlIn").hide();
                $("#tdfIn").hide();
                $("#trSerialQty").show();
            }
            else {
                $("#tdlIn").show();
                $("#tdfIn").show();
                $("#trSerialQty").hide();
            }
        }

        //查询号码类型
        function QueryBarType() {

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxProduct.QueryPackRelation(strOrderNo);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var entity = ajax.value;
            var SerialQty = 0;
            for (var i = 0; i < entity.length; i++) {
                if (entity[i].NumberType == "客户号码") {
                    SerialQty = parseInt(entity[i].SerialEnd) - parseInt(entity[i].SerialBegin) + 1;
                } else {
                    SerialQty = 0;
                }
                var obj = {};
                obj.NumberType = entity[i].NumberType;
                obj.Prefix = entity[i].Prefix;
                obj.Suffix = entity[i].Suffix;
                obj.SerialLength = entity[i].SerialLength;
                obj.SerialBegin = entity[i].SerialBegin;
                obj.SerialEnd = entity[i].SerialEnd;
                obj.NumberBegin = entity[i].NumberBegin;
                obj.NumberEnd = entity[i].NumberEnd;
                obj.Increase = entity[i].Increase;
                obj.ScopeId = entity[i].ScopeId;
                obj.GroupNumber = entity[i].GroupNumber;
                obj.SerialQty = SerialQty;
                arrBarType.push(obj);
            }
            Show();
        }

        //行点击事件
        function trClick(obj, Model) {
            $("#tblRecHistory tbody").find("td").css('background', '#fff');
            $(obj).find("td").css('background', '#ACBAD4');

            $("#ddlNumberType").val(Model.NumberType);//号码类型
            $("#txtPrefix").val(Model.Prefix);//号码前缀
            $("#txtSuffix").val(Model.Suffix);//号码后缀
            $("#txtSerialLength").val(Model.SerialLength);//流水号长度
            $("#txtSerialBegin").val(Model.SerialBegin);//起始流水号
            $("#txtSerialEnd").val(Model.SerialEnd);//结束流水号
            $("#txtNumberBegin").val(Model.NumberBegin);//完整开始号码
            $("#txtNumberEnd").val(Model.NumberEnd);//完整结束号码
            $("#txtIncrease").val(Model.Increase);//每箱号码数量
            HideShow();
        }

        //根据订单号查询该订单是否已经生成过条码
        function GetCustomerOrderBarCode() {
            var OrderNo = $("#txtOrderNo").val();
            var CustomerOrder = $("#txtCustomerOrder").val();
            var NumberType = $("#ddlNumberType").val();

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxProduct.GetCustomerOrderBarCode(CustomerOrder, OrderNo, NumberType);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var entity = ajax.value;
            if (entity != null) {
                //$("#txtPrefix").val(entity.Prefix);//号码前缀
                //$("#txtSuffix").val(entity.Suffix);//号码后缀
                //$("#txtSerialLength").val(entity.SerialLength);//流水号长度


                //var Number = parseInt(entity.SerialEnd) + 1;//根据起始流水号和数量计算结束流水号
                //var SerialEnd = addPreZero(Number, entity.SerialLength);//结束流水号补0 

                //$("#txtSerialBegin").val(SerialEnd);//起始流水号
                //$("#txtIncrease").val(entity.Increase);//每箱号码数量
                //Calculate();

                //$("#txtPrefix").attr("disabled", true);
                //$("#txtSuffix").attr("disabled", true);
                //$("#txtSerialLength").attr("disabled", true);
                //$("#txtSerialBegin").attr("disabled", true);
                //$("#txtIncrease").attr("disabled", true);

            } else {
                $("#txtPrefix").attr("disabled", false);
                $("#txtSuffix").attr("disabled", false);
                $("#txtSerialLength").attr("disabled", false);
                $("#txtSerialBegin").attr("disabled", false);
                $("#txtIncrease").attr("disabled", false);
                EmptyText();
            }

        }


        //判断是否是正整数
        function isPositiveInteger(str) {
            var reg = /^[1-9]\d*$/;
            return reg.test(str);
        }

        //获取已维护客户号码总数
        function getRegisterQty() {
            var qty = 0;
            for (var i = 0; i < arrBarType.length; i++) {
                qty += arrBarType[i].SerialQty;
            }
            return qty;
        }

        //获取组别
        function getGroupNumber(type) {
            if (type == "客户号码") {
                if (arrBarType.length <= 0) {
                    return 1;
                } else {
                    return arrBarType[arrBarType.length - 1].GroupNumber + 1;
                }
            } else {
                return arrBarType[arrBarType.length - 1].GroupNumber;
            }
        }

    </script>
</asp:Content>
