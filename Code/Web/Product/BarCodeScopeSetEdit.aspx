<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master"
    AutoEventWireup="true" CodeBehind="BarCodeScopeSetEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Product.BarCodeScopeSetEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <fieldset style="height: 98px">
        <legend><%=Resources.lang.MainInformation %></legend>
        <table width="100%" class="EditeContentTable">
            <tr>
                <td class="Label3">工单号<em>*</em>
                </td>
                <td class="Field3">
                    <asp:TextBox ID="txtOrderNo" runat="server" CssClass="TextBox" ClientIDMode="Static" isrequired="1"></asp:TextBox>
                    <input type="button" id="bnOper" class="ButtonBox" onclick="openChoosePage()" value="..." />
                </td>
                <td class="Label3">订单号<em>*</em>
                </td>
                <td class="Field3">
                    <asp:TextBox ID="txtCustomerOrder" runat="server" CssClass="TextBox" disabled="disabled" ClientIDMode="Static" isrequired="1"></asp:TextBox>
                </td>
                <td class="Label3">数量<em>*</em>
                </td>
                <td class="Field3">
                    <asp:TextBox ID="txtQty" runat="server" CssClass="TextBox" ClientIDMode="Static" disabled="disabled" isrequired="1"  onkeyup="if(isNaN(value))execCommand('undo')"
                        onafterpaste="if(isNaN(value))execCommand('undo')"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="Label3">号码类型<em>*</em>
                </td>
                <td class="Field3">
                    <asp:DropDownList ID="ddlNumberType" runat="server" ClientIDMode="Static" isrequired="1" Width="86%">
                        <asp:ListItem Value="产品条码">产品条码</asp:ListItem>
                        <asp:ListItem Value="MAC条码">MAC条码</asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td class="Label3">号码分类<em>*</em>
                </td>
                <td class="Field3">
                    <asp:DropDownList ID="ddlClass" runat="server" ClientIDMode="Static" isrequired="1" Width="76%">
                        <asp:ListItem Value="普通类型">普通类型</asp:ListItem>
                        <asp:ListItem Value="MAC类型">MAC类型</asp:ListItem>
                        <asp:ListItem Value="STB类型">STB类型</asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td class="Label3">主号码<em>*</em>
                </td>
                <td class="Field3">
                    <asp:DropDownList ID="ddlIsMain" runat="server" ClientIDMode="Static" isrequired="1" Width="76%">
                        <asp:ListItem Value="否">否</asp:ListItem>
                        <asp:ListItem Value="是">是</asp:ListItem>
                        <asp:ListItem Value="客户号码">客户号码</asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
        </table>
    </fieldset>
    <fieldset style="height: 178px" id="fdBar">
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
                <td class="Label2"></td>
                <td class="Field2"></td>
            </tr>
            <tr id="trSerial">
                <td class="Label2">起始流水号
                </td>
                <td class="Field2">
                    <asp:TextBox ID="txtSerialBegin" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
                    <input class="SearchButton" id="btnItemCalculate" type="button" value="计算" onclick="GetItemNumberEnd()" />
                </td>
                <td class="Label2">结束流水号
                </td>
                <td class="Field2">
                    <asp:TextBox ID="txtSerialEnd" runat="server" disabled="disabled" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
                </td>
            </tr>
            <tr id="trStr" style="display: none">
                <td class="Label2">特殊字符<em>*</em>
                </td>
                <td class="Field2">
                    <asp:TextBox ID="txtSpecialStr" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
                </td>
                <td class="Label2">递增量
                </td>
                <td class="Field2">
                    <asp:TextBox ID="txtIncrease" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
                </td>
            </tr>
            <tr id="trFixed">
                <td class="Label2">固定码
                </td>
                <td class="Field2">
                    <asp:TextBox ID="txtFixed" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
                    <input class="SearchButton" id="btnStbCalculate" type="button" value="计算" onclick="GetStbNumberEnd()" />
                </td>
                <td class="Label2"></td>
                <td class="Field2"></td>
            </tr>
            <tr id="trMacNo">
                <td class="Label2">完整起始号码<em>*</em>
                </td>
                <td class="Field2">
                    <asp:TextBox ID="txtNumberBegin" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
                    <input class="SearchButton" id="btnMacCalculate" type="button" value="计算" onclick="GetMacNumberEnd()" />
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
    <table class="ListTable" width="100%" id="tblRecHistory" >
        <thead>
            <tr class="ListTableHeader" style="text-align: center">
                <th>序号</th>
                <th>号码类型</th>
                <th>号码分类</th>
                <th>条码前缀</th>
                <th>条码后缀</th>
                <th>流水号长度</th>
                <th>起始流水号</th>
                <th>结束流水号</th>
                <th>完整起始号码</th>
                <th>完整结束号码</th>
                <th>特殊字符</th>
                <th>递增量</th>
                <th>固定码</th>
                <th>主条码</th>
                <th><a href="#" onclick="AddBarToTable();">添加</a></th>
            </tr>
        </thead>
        <tbody>
            <tr id="trLast" class="ListTableOddRow">
                <td colspan="15" style="text-align: center;">暂无数据
                </td>
            </tr>
        </tbody>
    </table>
    <style type="text/css">
        fieldset {
            border: #2491BF solid 1px;
        }

        legend {
            font-size: 13px;
            font-weight: bold;
            color: #296AA0;
            background-repeat: no-repeat;
            height: 24px;
            padding-top: 2px;
            padding-left: 5px;
        }
    </style>
    <script type="text/javascript">
        var ScopeId = '<%=Request.QueryString["ID"]%>';
        var strOrderNo = '<%=Request.QueryString["OrderNo"]%>';
        var arrBarType = [];//
        var PuIsMain = "否";
        var UpIsMain = "否"

        String.prototype.trim = function () {
            return this.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
        }
        $(function () {
            $('#ddlClass').change(function () {
                EmptyText();
                HideShow();

            })
            $("#txtSerialBegin").keydown(function (e) {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    GetItemNumberEnd();
                }
            });

            $("#txtNumberBegin").keydown(function (e) {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    GetMacNumberEnd();
                }
            });

            HideShow();
            if (ScopeId > 0) {
                QueryBarType();
            }
        });

        //计算MAC条码完整解释号码
        function GetMacNumberEnd() {
            var SpecialStr = $("#txtSpecialStr").val();
            var MacQty = $("#txtQty").val();
            var Increase = $("#txtIncrease").val();
            if (Increase == "" || Increase <= 0) {
                alert("递增量不能为空并且需要大于0！");
                $("#txtNumberBegin").val('');
                $("#txtIncrease").val('').focus();
                return false;
            }
            if (MacQty == "" || MacQty <= 0) {
                alert("数量不能为空并且需要大于0！");
                $("#txtNumberBegin").val('');
                $("#txtMacQty").val('').focus();
                return false;
            }
            var NumberBegin = $("#txtNumberBegin").val();//完整起始号码
            if (SpecialStr != "") {
                //判断MAC的分割符与特殊字符是否一致
                for (var i = 0; i < NumberBegin.length; i++) {
                    if (i != 0 && i % 3 == 2) {

                        if (NumberBegin.slice(i, i + 1) != SpecialStr) {
                            alert("特殊字符与MAC条码分割符不一致！");
                            $("#txtNumberBegin").val('');
                            return false;
                        }
                    }

                }
            }

            //根据特殊字符解析完整号码变成16进制条码
            var NumberNew = NumberBegin.split(SpecialStr).join(''); //NumberBegin.replace(/SpecialStr/g, '');
            //16进制转10进制
            var str10 = parseInt(NumberNew, 16) + (parseInt(Increase) * (parseInt(MacQty) - 1));//最后一个MAC地址等于起始地址加上数量乘以递增量
            //10进制转16进制
            var str16 = addPreZero(str10.toString(16),12);
            var NumberEn = "";
            for (var i = 0; i < str16.length; i++) {
                if (i != 0 && i % 2 == 0) {
                    NumberEn = NumberEn + SpecialStr;
                }

                NumberEn = NumberEn + str16.slice(i, i + 1);

            }
            $("#txtNumberEnd").val(NumberEn.toUpperCase());
        }

        //计算产品条码完整解释号码
        function GetItemNumberEnd() {
            var SerialLength = $("#txtSerialLength").val();
            var Qty = $("#txtQty").val();
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
            var SerialBegin = $("#txtSerialBegin").val();//起始流水号
            var Prefix = $("#txtPrefix").val().trim();//前缀
            var Suffix = $("#txtSuffix").val().trim();//后缀
            var Number = parseInt(SerialBegin) + parseInt(Qty) - 1;//根据起始流水号和数量计算结束流水号
            var SerialEnd = addPreZero(Number, SerialLength);//结束流水号补0 
            $("#txtSerialEnd").val(SerialEnd);
            $("#txtNumberBegin").val(Prefix + SerialBegin + Suffix);
            $("#txtNumberEnd").val(Prefix + SerialEnd + Suffix);
        }

        //计算STB类型完整解析号码
        function GetStbNumberEnd() {
            var Fixed = $("#txtFixed").val();//固定码不能为空
            var BMAC = "";
            var EMAC = "";
            var BDEVICE = "";
            var EDEVICE = "";
            var SpecialStr = "";

            for (var i = 0; i < arrBarType.length; i++) {
                if (arrBarType[i].NumberType == "MAC") {
                    BMAC = arrBarType[i].NumberBegin;
                    EMAC = arrBarType[i].NumberEnd;
                    SpecialStr = arrBarType[i].SpecialStr;
                }
                if (arrBarType[i].NumberType == "DEVICE_ID") {
                    BDEVICE = arrBarType[i].NumberBegin;
                    EDEVICE = arrBarType[i].NumberEnd;
                }
            }

            if (BMAC == "") {
                alert("请先添加MAC条码类型！");
                return false;
            }
            var BMACNew = BMAC.split(SpecialStr).join('');
            var EMACNew = EMAC.split(SpecialStr).join('');
            var strNumberBegin = Fixed + BMACNew;//Fixed + BDEVICE + BMACNew;
            var strNumberEnd = Fixed + EMACNew;
            $("#txtNumberBegin").val(strNumberBegin);
            $("#txtNumberEnd").val(strNumberEnd);
        }

        /*保存数据*/
        function Save() {

            var OrderNo = $("#txtOrderNo").val();//工单号
            //编辑状态下判断是否有主条码
            if (UpIsMain == "是" && ScopeId > 0) {

                //存在主条码则需要判断是否有主条码进入生产，有进入生产则不允许编辑
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxProduct.IsBarCodeExists(OrderNo);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }

            }

            //公共属性
            
            var CustomerOrder = $("#txtCustomerOrder").val();//订单号
            var Qty = $("#txtQty").val();//数量
            /*表单验证*/
            /*如需表单验证可以此处处理验证 开始*/

            var list = [];
            for (var i = 0; i < arrBarType.length; i++) {
                var entity = {};
                entity.NumberType = arrBarType[i].NumberType;
                entity.NumberClass = arrBarType[i].NumberClass;
                entity.Prefix = arrBarType[i].Prefix;
                entity.Suffix = arrBarType[i].Suffix;
                entity.SerialLength = arrBarType[i].SerialLength == "" ? 0 : arrBarType[i].SerialLength;
                entity.SerialBegin = arrBarType[i].SerialBegin;
                entity.SerialEnd = arrBarType[i].SerialEnd;
                entity.SpecialStr = arrBarType[i].SpecialStr;
                entity.Increase = arrBarType[i].Increase == "" ? 0 : arrBarType[i].Increase;
                entity.NumberBegin = arrBarType[i].NumberBegin;
                entity.NumberEnd = arrBarType[i].NumberEnd;
                entity.IsMain = arrBarType[i].IsMain;
                entity.Fixed = arrBarType[i].Fixed;
                list.push(entity);
            }

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxProduct.BarCodeScopeSetEdit(ScopeId, OrderNo, CustomerOrder, Qty,list);
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

        }
        //产品条码补0
        function addPreZero(num, i) {
            return ('00000000000000' + num).slice(-i);
        }

 

        //添加条码类型到列表
        function AddBarToTable() {

            var NumberType = $("#ddlNumberType").val();//号码类型
            var NumberClass = $("#ddlClass").val();//号码分类
            var IsMain = $("#ddlIsMain").val();//是否主号码
            var Prefix = $("#txtPrefix").val().trim();//号码前缀
            var Suffix = $("#txtSuffix").val().trim();//号码后缀
            var SerialLength = $("#txtSerialLength").val();//流水号长度
            var SerialBegin = $("#txtSerialBegin").val();//起始流水号
            var SerialEnd = $("#txtSerialEnd").val();//结束流水号
            var SpecialStr = $("#txtSpecialStr").val()//特殊字符;
            var Increase = $("#txtIncrease").val();//递增量
            var NumberBegin = $("#txtNumberBegin").val();//完整开始号码
            var NumberEnd = $("#txtNumberEnd").val();//完整结束号码
            var Fixed = $("#txtFixed").val();//固定码
            
            
            //判断是否选择号码类型
            if (NumberType == "") {
                alert("请选择号码类型");
                return false;
            }
            //判断是否号码类型是否已经添加
            if (existsBarType(NumberType)) {
                alert("该号码类型已经添加");
                //$("#txtGRN").val('').focus();
                return false;
            }
            //判断是否已经存在主条码
            if (PuIsMain == "是" && IsMain=="是") {
                alert("已经存在主条码");
                return false;
            }


            //判断号码分类是否添加
            if (NumberClass == "") {
                alert("请选择号码分类");
                return false;
            }
            if (NumberClass == "普通类型") {
                //if (Prefix == "") {
                //    alert("请输入号码前缀");
                //    $("#txtPrefix").val('').focus();
                //    return false;
                //}
                //if (Suffix == "") {
                //    alert("请输入号码后缀");
                //    $("#txtSuffix").val('').focus();
                //    return false;
                //}
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
                GetItemNumberEnd();

            }
            if (NumberClass == "MAC类型") {
                if (Increase == "") {
                    alert("请输入递增量");
                    $("#txtIncrease").val('').focus();
                    return false;
                }
                //if (SpecialStr == "") {
                //    alert("请输入特殊字符");
                //    $("#txtSpecialStr").val('').focus();
                //    return false;
                //}

                GetMacNumberEnd();
            }

            if (NumberClass == "STB类型") {
                GetStbNumberEnd();
            }

            if (IsMain == "客户号码") {
                var vIsMain = "否";
                for (var i = 0; i < arrBarType.length; i++) {
                    if (arrBarType[i].IsMain == "是") {
                        vIsMain = arrBarType[i].IsMain;
                        break;
                    }
                }
                if (vIsMain == "否") {
                    alert("请先添加主条码！");
                    return false;
                }
            }

            if (NumberBegin == "") {
                alert("请输入完整起始号码");
                return false;
            }
            if (NumberEnd == "") {
                alert("请输入完整结束号码");
                return false;
            }

            

            var obj = {};
            obj.NumberType = $("#ddlNumberType").val();
            obj.NumberClass = NumberClass;
            obj.Prefix = $("#txtPrefix").val().trim();
            obj.Suffix = $("#txtSuffix").val().trim();
            obj.SerialLength = $("#txtSerialLength").val();
            obj.SerialBegin = $("#txtSerialBegin").val();
            obj.SerialEnd = $("#txtSerialEnd").val();
            obj.SpecialStr = $("#txtSpecialStr").val();
            obj.Increase = $("#txtIncrease").val();
            obj.NumberBegin = $("#txtNumberBegin").val();
            obj.NumberEnd = $("#txtNumberEnd").val();
            obj.IsMain = IsMain;
            obj.Fixed = Fixed;
            arrBarType.push(obj);
            Show();
            if (IsMain=="是") {
                PuIsMain = IsMain;
            }
        }
        function Show() {
            var data = "";
            $("#tblRecHistory tbody").html("");

            //将GRN数组拼接成HTML代码
            var html = bullderScanHtml();
            $("#tblRecHistory tbody").append(html);
        }
        //将数组拼接成HTML代码
        function bullderScanHtml() {
            var html = "";
            for (var i = 0; i < arrBarType.length; i++) {
                html += "<tr onclick='trClick(this," + JSON.stringify(arrBarType[i]) + ")'><td class='Field1' style='width:5%;text-align: center;'>" + (i + 1) + "</td>"
                    + "<td class='Field1' style='width:10%;text-align: center;'>" + arrBarType[i].NumberType + "</td>"
                    + "<td class='Field1' style='width:10%;text-align: center;'>" + arrBarType[i].NumberClass + "</td>"
                    + "<td class='Field1' style='width:10%;text-align: center;'>" + arrBarType[i].Prefix + "</td>"
                    + "<td class='Field1' style='width:10%;text-align: center;'>" + arrBarType[i].Suffix + "</td>"
                    + "<td class='Field1' style='width:10%;text-align: center;'>" + arrBarType[i].SerialLength + "</td>"
                    + "<td class='Field1' style='width:10%;text-align: center;'>" + arrBarType[i].SerialBegin + "</td>"
                    + "<td class='Field1' style='width:10%;text-align: center;'>" + arrBarType[i].SerialEnd + "</td>"
                    + "<td class='Field1' style='width:10%;text-align: center;'>" + arrBarType[i].NumberBegin + "</td>"
                    + "<td class='Field1' style='width:10%;text-align: center;'>" + arrBarType[i].NumberEnd + "</td>"
                    + "<td class='Field1' style='width:10%;text-align: center;'>" + arrBarType[i].SpecialStr + "</td>"
                    + "<td class='Field1' style='width:10%;text-align: center;'>" + arrBarType[i].Increase + "</td>"
                    + "<td class='Field1' style='width:10%;text-align: center;'>" + arrBarType[i].Fixed + "</td>"
                    + "<td class='Field1' style='width:10%;text-align: center;'>" + arrBarType[i].IsMain + "</td>"
                    + "<td class='Field1' style='width:10%;text-align: center;'><img title='删除' src='../Content/images/delete.gif' onclick=Delet('" + arrBarType[i].NumberType + "')></img></td></tr>";
            }
            return html;
        }

        //清空文本框
        function EmptyText() {
            $("#txtPrefix").val("").trim;//号码前缀
            $("#txtSuffix").val("").trim;//号码后缀
            $("#txtSerialLength").val("");//流水号长度
            $("#txtSerialBegin").val("");//起始流水号
            $("#txtSerialEnd").val("");//结束流水号
            $("#txtSpecialStr").val("")//特殊字符;
            $("#txtIncrease").val("");//递增量
            $("#txtNumberBegin").val("");//完整开始号码
            $("#txtNumberEnd").val("");//完整结束号码
            $("#txtFixed").val("");//固定码
        }

        //判断号码类型是否已经添加
        function existsBarType(BarType) {
            for (var i = 0; i < arrBarType.length; i++) {
                if (arrBarType[i].NumberType == BarType) {
                    return true;
                }
            }
            return false;
        }

        //删除号码类型
        function Delet(BarType) {
            var idx = -1;
            for (var i = 0; i < arrBarType.length; i++) {
                if (arrBarType[i].NumberType == BarType) {
                    idx = i;
                    break;
                }
            }
            if (idx > -1) {
                arrBarType.splice(idx, 1);
            }
            //重置列表
            var html = bullderScanHtml();
            $("#tblRecHistory tbody").html(html);
        }

        //隐藏/显示TR
        function HideShow() {
            if ($("#ddlClass").val() == "MAC类型") {
                $("#trPrefix").hide();
                $("#trLength").hide();
                $("#trSerial").hide();
                $("#trStr").show();
                $("#trMacNo").show();
                $("#txtNumberBegin").attr("disabled", false);
                $("#btnMacCalculate").show();
                $("#fdBar").height(106);
                $("#trFixed").hide();
            }
            else if ($("#ddlClass").val() == "STB类型") {
                $("#trPrefix").hide();
                $("#trLength").hide();
                $("#trSerial").hide();
                $("#trStr").hide();
                $("#trMacNo").show();
                $("#fdBar").height(110);
                $("#btnMacCalculate").hide();
                $("#txtNumberBegin").attr("disabled", "disabled");
                $("#trFixed").show();
            }
            else {
                $("#trPrefix").show();
                $("#trLength").show();
                $("#trSerial").show();
                $("#trStr").hide();
                $("#trMacNo").show();
                $("#txtNumberBegin").attr("disabled", "disabled");
                $("#btnMacCalculate").hide();
                $("#fdBar").height(178);
                $("#trFixed").hide();
            }
        }

        //查询号码类型
        function QueryBarType() {

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxProduct.QueryBarType(strOrderNo);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var entity = ajax.value;
            for (var i = 0; i < entity.length; i++) {
                var obj = {};
                obj.NumberType = entity[i].NumberType;
                obj.NumberClass = entity[i].NumberClass;
                obj.Prefix = entity[i].Prefix;
                obj.Suffix = entity[i].Suffix;
                obj.SerialLength = entity[i].SerialLength;
                obj.SerialBegin = entity[i].SerialBegin;
                obj.SerialEnd = entity[i].SerialEnd;
                obj.SpecialStr = entity[i].SpecialStr;
                obj.Increase = entity[i].Increase;
                obj.NumberBegin = entity[i].NumberBegin;
                obj.NumberEnd = entity[i].NumberEnd;
                obj.IsMain = entity[i].IsMain;
                if (entity[i].IsMain == "是") {
                    UpIsMain="是";
                }
                obj.Fixed = entity[i].Fixed;
                arrBarType.push(obj);
            }
            Show();
        }

        //行点击事件
        function trClick(obj, Model) {
            $("#tblRecHistory tbody").find("td").css('background', '#fff');
            $(obj).find("td").css('background', '#ACBAD4');

            $("#ddlNumberType").val(Model.NumberType);//号码类型
            $("#txtPrefix").val(Model.Prefix).trim;//号码前缀
            $("#txtSuffix").val(Model.Suffix).trim;//号码后缀
            $("#txtSerialLength").val(Model.SerialLength);//流水号长度
            $("#txtSerialBegin").val(Model.SerialBegin);//起始流水号
            $("#txtSerialEnd").val(Model.SerialEnd);//结束流水号
            $("#txtNumberBegin").val(Model.NumberBegin);//完整开始号码
            $("#txtNumberEnd").val(Model.NumberEnd);//完整结束号码
            $("#txtIncrease").val(Model.Increase);//每箱号码数量
            $("#ddlClass").val(Model.NumberClass);//号码分类
            $("#ddlIsMain").val(Model.IsMain);//是否主号码
            $("#txtSpecialStr").val(Model.SpecialStr);//特殊字符;
            $("#txtFixed").val(Model.Fixed);//固定码
            HideShow();
        }
    </script>
</asp:Content>
