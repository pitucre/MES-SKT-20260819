<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/ProductionCollection.Master" CodeBehind="SpcTestDataEntering.aspx.cs" Inherits="SKT.LeanMES.Web.Client.SpcTestDataEntering" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="client-center">
        <!--SPC测试数据录入口-->
        <div style="marign: 0 auto; text-align: center; padding: 15px 0px 10px 0px; font-size: 14px; background-color:#F7F7F7;">
            <table class="EditeContentTable" id="tbDataCollect" width="100%">
                <tbody>
                    <tr>
                        <td class="Label2">
                            工单号:
                        </td>
                        <td class="Field2">
                            <input class="ui-textbox" id="txtOrderNo" type="text" style="width: 170px;" />
                            <input type="button" id="btnSelectOrder" class="ButtonBox" value="..." title="Select" 
                            onclick="openSelectOrder();" style="height: 27px;" />
                        </td>
                         <td class="Label2">
                            产品编码:
                        </td>
                        <td class="Field2">
                            <input class="ui-textbox" id="txtItemCode" type="text" style="width: 170px;" />
                            <input type="button" id="btnSelectCode" class="ButtonBox" value="..." title="Select" 
                            onclick="openChoosePage();" style="height: 27px;" />
                            <span style="color:Red">*</span>
                        </td>
                    </tr>
                    <tr>
                        <td class="Label2">
                            任务名称:
                        </td>
                        <td class="Field2">
                            <input class="ui-textbox" id="txtTaskName" type="text" style="width: 170px;" />
                            <input type="button" id="butTask" class="ButtonBox" value="..." title="Select" 
                            onclick="openSelectTackPage();" style="height: 27px;" />
                            <span style="color:Red">*</span>
                        </td>
                         <td class="Label2">
                            操作人员:
                        </td>
                        <td class="Field2">
                            <span id ="userName"></span>
                        </td>
                    </tr>
                    <tr>
                        <td class="Label2">
                            备注:
                        </td>
                        <td class="Field2" colspan="4">
                            <input class="ui-textbox" id="txtRemark" type="text" style="width: 190px;" />
                        </td>
                    </tr>
                    <tr style="text-align:center">
                        <td colspan="4" style=" height:27px;background-color:#f7f7f7;padding:3px 3px 3px 0px;border-top:1px solid #d3d3d3">
                             <input type="radio" id ="rdoTestValue" name="rdoType" value="1" checked/>测试值录入
                             &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                             <input type="radio" id ="rdoResult" name="rdoType" value="2" />结果录入
                        </td>
                    </tr>
                    <tr>
                         <td colspan="4" style=" height:27px;background-color:#f7f7f7;padding:3px 3px 3px 0px;border-top:1px solid #d3d3d3">
                             <span id ="spanNcCode" style=" display:none">
                                   当前组样本数 &nbsp;&nbsp;&nbsp;
                                   <input class="ui-textbox" id="txtGroupNum" type="text" autocomplete="off" style="width: 120px;" />
                             </span>
                              &nbsp&nbsp;&nbsp;
                             <span id ="spanResult" style=" display:none">结果(PASS/不良代码)</span>
                             <span id ="spanTestVale">测量值</span>
                             &nbsp&nbsp;&nbsp;
                             <input class="ui-textbox" id="txtValue" type="text" style="width: 120px;" />
                             &nbsp&nbsp;&nbsp;&nbsp&nbsp;&nbsp;
                             <span id ="spanGroupNum" style=" display:none">
                                 当前组已扫样本数 &nbsp;&nbsp;&nbsp;<span id ="ScanQty">0</span>
                             </span>
                         </td>
                    </tr>
                </tbody>
            </table>
            <div style="clear:both"></div>
            <div class="leftmenu-new-header">已录入的结果数量:&nbsp;<span id="resultNum">0</span></div>
            <table class="ListTable" id="spcTab" style="margin-bottom: 10px;">
                <tbody>
                <tr class="ListTableHeader" style="height: 30px;">
                    <th align="center">
                        序号
                    </th>
                    <th align="center">
                        测量值
                    </th>
                    <th align="center">
                        测量结果
                    </th>
                    <th align="center">
                        录入时间
                    </th>
                    <th align="center">
                        录入方式
                    </th>
                    <th align="center">
                       操作
                    </th>
                </tr>
                <tr class="ListTableOddRow T" id="listSpcRow">
                    <td style="text-align: center;" colspan="6">
                        暂无数据
                    </td>
                </tr>
                </tbody>
            </table>
        </div>
         <!--实时信息输出-->
        <div id="activeinfo" class="active-info">
            <div id="activeinfoarea" class="active-info-area" ></div>
        </div>
    </div>
    <script type="text/javascript">

        var userName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUserInfo().UserName%>";
        var USL = 0;
        var LSL = 0;
        var TestWay = -1; //录入方式
        var sampleGroup = "";    //用于删除时查询当前组已扫样本数
        var sampleGroupNum = 0;  //样品组数量   

        $(document).ready(function () {
            $("#userName").html(userName);
            //加载按钮
            setTimeout(
                function () {
                    loadClientButton('SpcTestDataEntering');
                },
                10
            );
            //测试结果录入的显示隐藏
            $('input[type=radio][name=rdoType]').change(function () {
                if (this.value == '1') {
                    $("#spanTestVale").show();
                    $("#spanResult").hide();
                    $("#spanNcCode").hide();
                    $("#spanGroupNum").hide();
                    $("#txtValue").val("").focus();
                }
                else if (this.value == '2') {
                    $("#spanTestVale").hide();
                    $("#spanResult").show();
                    $("#spanNcCode").show();
                    $("#spanGroupNum").show();
                    $("#txtGroupNum").val("").focus();
                }

            });

            //输入只回车事件
            $("#txtGroupNum").keydown(function (e) {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;

                if (curKey == 13) {
                    $("#txtValue").val("").focus();
                }
                if (curKey == 46) {
                    $("#txtGroupNum").val("").focus();
                }
            });

            //输入值回车事件
            $("#txtValue").keydown(function (e) {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;

                if (curKey == 13) {

                    var ItemCode = $("#txtItemCode").val();
                    if (ItemCode == "") {
                        alert("产品编码不能为空，请选择!");
                        return false;
                    }
                    var txtTaskName = $("#txtTaskName").val();
                    if (txtTaskName == "") {
                        alert("任务名称不能为空,请选择!");
                        return false;
                    }
                    var checkType = $("input[name='rdoType']:checked").val();
                    if (checkType == "2") {
                        //加载数据
                        SaveSpcTestShowData($.trim(this.value), checkType);
                        $("#txtValue").val("").focus();
                    }
                    else {
                        //加载数据
                        SaveSpcTestShowData($.trim(this.value), checkType);
                        $("#txtValue").val("").focus();
                    }
                }
                if (curKey == 46) {
                    $("#txtValue").val("").focus();
                }
            });
        });

        /*加载显示测试数据*/
        function SaveSpcTestShowData(value, type) {

            var OrderNo = $("#txtOrderNo").val();
            var ItemCode = $("#txtItemCode").val();
            var txtTaskName = $("#txtTaskName").val();
            var txtRemark = $("#txtRemark").val();

            var TestResult = "";  //测量结果
            var TestValue = "";   //测量值
            var Entering = "";    //录入方式

            //判断录入的方式，录入方式只能单一，不能混合录入
            if (TestWay != -1){
                if (type != TestWay) {
                    alert("录入的方式只能单一，不能混合录入!");
                    $("#txtValue").val("").focus();
                    return false;
                }
            }
            if (type == "1") {
                Entering = "测试值录入";
                TestValue = value;
                //根据规格上下限来判断录入结果的,在上下限范围内的为PASS
                var uslQty = parseFloat(USL);
                var lslQty = parseFloat(LSL);
                if (parseFloat(value) <= uslQty && parseFloat(value) >= lslQty) {
                    TestResult = "PASS";
                }
                else {
                    TestResult = "FAIL";
                }
            }
            else {
                Entering = "结果录入";
                //获取组样品数
                sampleGroupNum = $("#txtGroupNum").val().toString();
                if (value.toUpperCase() == "PASS") {
                    TestValue = "-1";
                    TestResult = "PASS";
                }
                else {
                    //通过验证输入的的不良代码，并返回不良代码ID
                    var NcCodeId = "";
                    var ajaxNc = SKT.LeanMES.Web.AjaxServices.AjaxSPC.GetNcCodeId(value);
                    if (ajaxNc.error != null) {
                        alert(ajaxNc.error.Message);
                        setTimeout(function () {
                            $("#txtValue").focus();
                            $("#txtValue").select();
                        }, 100);
                        return;
                    }
                    NcCodeId = ajaxNc.value;
                    TestValue = "-1";
                    TestResult = value;
                }
            }

            //保存SPC录入的数据,结果录入时(返回当前组已扫描数量，和当前组别)
            var ajaxSpc = SKT.LeanMES.Web.AjaxServices.AjaxSPC.SaveSpcTestData(
               OrderNo, ItemCode, txtTaskName, txtRemark, type, userName, TestValue, TestResult, sampleGroupNum);
            if (ajaxSpc.error != null) {
                alert(ajaxSpc.error.Message);
                return;
            }
            $('#txtGroupNum').attr("disabled", "disabled");
            var ajaxStr = ajaxSpc.value;
            var arr = new Array();
            arr = ajaxStr.split(',');
            //返回的当前组已扫描数量
            var sacnSampleNum = arr[0]; 
            sampleGroup = arr[1];
            $("#ScanQty").html(sacnSampleNum);
            //如果当前组已扫样本数 等于 当前组样本数 提示用是否调整当前样本
            if (type == "2") {
                if (sacnSampleNum == sampleGroupNum) {
                    $("#txtGroupNum").removeAttr("disabled");
                    setTimeout(function () {
                        $("#txtGroupNum").focus();
                        $("#txtGroupNum").select();
                    }, 100);
                    alert("当前组已扫样本数等于当前组样本数,是否更换当前组样本数！");
                } 
            }
            //显示SPC录入的数据信息
            ShowGetSpcTestDataList(ItemCode, txtTaskName);
            if (type == "1") {
                $('#rdoResult').attr("disabled", "disabled");
            }
            else {
                $('#rdoTestValue').attr("disabled", "disabled");
            }
            TestWay = type;
        }

        //显示SPC录入的数据信息
        var tab = document.getElementById("spcTab");
        function ShowGetSpcTestDataList(ItemCode, txtTaskName){
            var ajaxSpcList = SKT.LeanMES.Web.AjaxServices.AjaxSPC.GetSpcTestDataList(ItemCode, txtTaskName);
            if (ajaxSpcList.error != null) {
                alert(ajaxSpcList.error.Message);
                return false;
            }
            var row, cell;
            var list = ajaxSpcList.value;
            if (list == null || list == undefined) {
                return;
            }
            //先清空再加载
            if ($("#spcTab tr").length > 1) {
                $("#spcTab tr:not(:first)").remove();
            }
            var rowNum = list.length;
            /***动态创建表***/
            for (var i = 0; i < list.length; i++) {

                row = tab.insertRow(tab.rows.length);
                row.className = "ListTableOddRow";

                cell = row.insertCell(0);
                cell.align = "center";
                cell.innerHTML = i + 1;

                //第二行 测量值
                cell = row.insertCell(1);
                cell.align = "center";
                cell.innerHTML = list[i].TestValue;

                //第三行 测量结果
                cell = row.insertCell(2);
                cell.align = "center";
                cell.innerHTML = list[i].TestResult;


                //第四行 录入时间
                cell = row.insertCell(3);
                cell.align = "center";
                cell.innerHTML = list[i].TestDataTime.toLocaleString().replace("日", "").replace(/[年月]/g, "-");

                //第五行 录入方式
                cell = row.insertCell(4);
                cell.align = "center";
                cell.innerHTML = list[i].TestWay;

                //第六行 操作
                cell = row.insertCell(5);
                cell.align = "center";
                cell.innerHTML = "&nbsp;&nbsp;<a href='#' onclick='Delete(" + list[i].SpcId + ")'>删除</a>";
            }
            $("#resultNum").html(rowNum);
        }

        //删除
        function Delete(spcid) {

            //先删除数据库表
            var ajaxDel = SKT.LeanMES.Web.AjaxServices.AjaxSPC.DelSpcById(spcid);
            if (ajaxDel.error != null) {
                alert(ajaxDel.error.Message);
                return false;
            }
            //从新加载数据
            var ItemCode = $("#txtItemCode").val();
            var txtTaskName = $("#txtTaskName").val();
            ShowGetSpcTestDataList(ItemCode, txtTaskName);
            //结果录入时调用
            if (TestWay == "2") {
                //获取当前已扫描的样本数
                var ajaxNum = SKT.LeanMES.Web.AjaxServices.AjaxSPC.GetScanGroupNum(ItemCode, txtTaskName, sampleGroup);
                if (ajaxNum.error != null) {
                    alert(ajaxNum.error.Message);
                    return false;
                }
                $("#ScanQty").html(ajaxNum.value);
            }
        }

        //选择工单
        function openSelectOrder() {
           // var condition = "1=1"; 
            var condition = ""; 

            dialog({
                title: "<%= Resources.Common.ChooseWindow %>",
                src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=44&CallBackFunc=getProOrderValue&Multiple=false&SearchCondition=" + condition +"&rnd=" +Math.random(),
                width: 650,
                height: 350
            });
        }
        function getProOrderValue(list) {
            $("#txtOrderNo").val(list[0][1]);
            $("#txtItemCode").val(list[0][2]);
        }

        //选择产品
        function openChoosePage() {
            //var condition = "1=1";
            var condition = " ";

            dialog({
                title: "<%= Resources.Common.ChooseWindow %>",
                src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=1&CallBackFunc=getItemValue&Multiple=false&SearchCondition=" +
                condition + "&rnd=" + Math.random(),
                width: 650,
                height: 350
            });
        }
        function getItemValue(list) {
            $("#txtItemCode").val(list[0][2]);
            setTimeout(function () {
                $("#txtValue").focus();
                $("#txtValue").select();
            }, 100);
        }

        //选择任务
        function openSelectTackPage() {
           // var condition = "1=1";
            var condition = " ";
            dialog({
                title: "<%= Resources.Common.ChooseWindow %>",
                src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=807&CallBackFunc=getTaskValue&Multiple=false&SearchCondition=" +
                condition + "&rnd=" + Math.random(),
                width: 650,
                height: 350
            });
        }

        function getTaskValue(list) {
            $("#txtTaskName").val(list[0][2]);
            USL = list[0][4];
            LSL = list[0][5];
            setTimeout(function () {
                $("#txtValue").focus();
                $("#txtValue").select();
            }, 100);
        }
    </script>
     
</asp:Content>