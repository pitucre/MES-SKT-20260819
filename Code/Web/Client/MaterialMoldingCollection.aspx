<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ProductionCollection.Master"
    AutoEventWireup="true" CodeBehind="MaterialMoldingCollection.aspx.cs" Inherits="SKT.LeanMES.Web.Client.MaterialMoldingCollection" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="client-center">
        <table cellpadding="0" cellspacing="0" border="0" width="100%">
            <tr>
                <th style="width: 75%"></th>
                <th style="width: 25%"></th>
            </tr>
            <tr>
                <td style="vertical-align: top">
                    <div class="dds-panel">
                        <div class="leftmenu-new-header">
                            物料信息
                        </div>
                        <table cellpadding="0" cellspacing="0" border="0" width="100%" class="EditeContentTable">
                            <tr>
                                <td class="Label3">
                                    <em style="color: Red;">*</em>待加工物料GRN
                                </td>
                                <td class="Field3">
                                    <input type="text" id="txtSourceGRN" class="ui-textbox" style="width: 120px;" />
                                    <input type="button" value="载入" class="SearchButton" onclick="CheckMemberSourceGRN()" />
                                </td>
                                <td class="Label3">物料编码
                                </td>
                                <td class="Field3" id="SourceItemCode"></td>
                                <td class="Label3">物料规格
                                </td>
                                <td class="Field3" id="SourceItemName"></td>
                            </tr>
                            <tr>
                                <td class="Label3">库位
                                </td>
                                <td class="Field3">
                                    <input type="text" id="txtStorageLocation" class="ui-textbox" style="width: 120px;" /><asp:TextBox ID="txtWebPath" runat="server" Style="display: none"></asp:TextBox>
                                </td>
                                <td class="Label3">加工后物料编码
                                </td>
                                <td class="Field3" id="TargetItemCode"></td>
                                <td class="Label3">供应商
                                </td>
                                <td class="Field3" id="VendorName"></td>
                            </tr>
                            <tr>
                                <td class="Label3">重量
                                </td>
                                <td class="Field3">
                                    <input type="text" id="txtWeight" class="ui-textbox" style="width: 120px;" />
                                </td>
                                <td class="Label3">操作人
                                </td>
                                <td class="Field3" id="Username"></td>
                                <td class="Label3">
                                    <em style="color: Red;">*</em>打印数量
                                </td>
                                <td class="Field3">
                                    <input type="text" id="txtPrintNum" class="ui-textbox" style="width: 120px;" />
                                </td>
                            </tr>
                            <tr id="trBurnSoft">
                                <td class="Label3">
                                    <label id="lblShowSoft">烧录软件</label>
                                </td>
                                <td class="Field3" colspan="3">
                                    <input id="txtFilename" class="ui-textbox" value="" disabled="disabled" />
                                    <input id="txtSoftPath" value="" style="display: none" />
                                    <input type="hidden" id="hidIsProgrammer" value="0" />
                                    <input type="hidden" id="hidIsDownLoad" value="0" />
                                </td>
                                <td class="Label3">默认目录
                                </td>
                                <td class="Field3">
                                    <input id="txtDownloadDir" class="ui-textbox" value="" disabled="disabled" /><input id="btnDownLoad" class="SearchButton" style="margin-left: 10px" value="下载" type="button"
                                        onclick="DownloadSoft()" /><label id="lblIsDownLoad" style="margin-left: 10px"></label>
                                </td>
                            </tr>
                            <tr>
                                <td class="Label3">备注
                                </td>
                                <td class="Field3">
                                    <input type="text" id="txtRemark" class="ui-textbox" style="width: 120px;" />
                                </td>
                                <td class="Label3">打印机名称
                                </td>
                                <td class="Field3" colspan="3">
                                    <select id="selPrintersList" style="width: 140px;">
                                    </select>
                                    <input type="button" value="打印" class="SearchButton" onclick="Print()" />
                                    <input type="button" value="重置" class="SearchButton" onclick="Reset()" />

                                    <input type="hidden" id="hidMoldingId" name="hidMoldingId" value="0" />
                                    <input type="hidden" id="hidMoldingMemberId" name="hidMoldingMemberId" value="0" />
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
                <td style="vertical-align: top">
                    <div class="dds-panel">
                        <div class="leftmenu-new-header">
                            前加工信息
                        </div>
                        <table cellpadding="0" cellspacing="0" border="0" width="100%" class="EditeContentTable">
                            <tr>
                                <td class="Label1">班组
                                </td>
                                <td class="Field1">
                                    <asp:DropDownList ID="txtGroup" runat="server">
                                    </asp:DropDownList>
                                    <!--<input type="text" id="txtGroup" class="ui-textbox" style="width: 120px;" />-->
                                </td>
                            </tr>
                            <tr>
                                <td class="Label1">生产日期
                                </td>
                                <td class="Field1">
                                    <input type="text" id="txtProdDate" class="ui-textbox DateTimeBox" style="width: 110px;" />
                                    <img style="vertical-align: middle; cursor: pointer; margin-top: -2px; margin-left: -18px; margin-right: 5px"
                                        class="ui-datepicker-trigger" src="../Content/plugin/calendar/skin/images/calendar2.png"
                                        alt="选择日期" title="选择日期" />
                                </td>
                            </tr>
                            <tr>
                                <td class="Label1">设备编码
                                </td>
                                <td class="Field1">
                                    <input type="text" id="txtEquipmentNo" class="ui-textbox" style="width: 120px;" />
                                </td>
                            </tr>
                            <tr>
                                <td class="Label1">设备编码
                                </td>
                                <td class="Field1">
                                    <input type="text" id="txtFixtureNo" class="ui-textbox" style="width: 120px;" />
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
        </table>
        <div class="dds-panel">
            <div class="leftmenu-new-header">
                成型信息
            </div>
            <div style="height: 60px; overflow: auto; overflow: -Scroll overflow-y: hidden;">
                <table cellpadding="0" cellspacing="0" border="0" width="100%" class="ListTable"
                    id="tbMoldingDetail">
                    <thead>
                        <tr class="ListTableHeader">
                            <th style="width: 60px">加工类型
                            </th>
                            <th style="width: 120px">加工物料编码
                            </th>
                            <th style="width: 250px">物料规格
                            </th>
                            <th style="width: 50px">用量
                            </th>
                            <th style="width: 60px">工单数量
                            </th>
                            <th style="width: 60px">已入数量
                            </th>
                            <th style="width: 50px">剩余数量
                            </th>
                            <th style="width: 80px">位置
                            </th>
                            <th style="width: 100px">工位
                            </th>
                            <th style="width: 50px">规格/尺寸
                            </th>
                            <th style="width: 120px">加工后物料条码
                            </th>
                            <th>备注
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
        </div>
        <div class="dds-panel">
            <div class="leftmenu-new-header">
                物料信息
            </div>
            <div style="height: 100px; overflow: auto;">
                <table cellpadding="0" cellspacing="0" border="0" width="100%" class="ListTable"
                    id="tbMaterialInfo">
                    <thead>
                        <tr class="ListTableHeader">
                            <th style="width: 50px">序号
                            </th>
                            <th>Grn
                            </th>
                            <th style="width: 300px">物料编码
                            </th>
                            <th style="width: 100px">数量
                            </th>
                            <th style="width: 150px">DataCode
                            </th>
                            <th style="width: 100px">操作
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
        </div>
        <!--加工信息-->
        <div class="dds-panel">
            <div class="leftmenu-new-header">
                加工信息
            </div>
            <div style="height: 220px; overflow: auto;">
                <table cellpadding="0" cellspacing="0" border="0" width="100%" class="ListTable"
                    id="tbMoldingProcess">
                    <thead>
                        <tr class="ListTableHeader">
                            <th>流水号
                            </th>
                            <th>Grn
                            </th>
                            <th>生产日期
                            </th>
                            <th>班组
                            </th>
                            <th>工位
                            </th>
                            <th>批次
                            </th>
                            <th>原物料编码
                            </th>
                            <th>原数量
                            </th>
                            <th>加工人
                            </th>
                            <th>设备编号
                            </th>
                            <th>设备编号
                            </th>
                            <th>重量
                            </th>
                            <th>库位
                            </th>
                            <th>备注
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
        </div>
        <!--实时信息输出-->
        <div id="activeinfo" class="active-info">
            <textarea id="activeinfoarea" class="active-info-area" rows="" cols="" readonly="readonly">
            </textarea>
        </div>
    </div>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnFtpIP" name="hdnFtpIP" value="" runat="server" />
    <input type="hidden" id="hdnFtpUser" name="hdnFtpUser" value="" runat="server" />
    <input type="hidden" id="hdnFtpPwd" name="hdnFtpPwd" value="" runat="server" />
      <script type="text/javascript" src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/layui/layui.all.js"></script>
    <link href="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/layui/css/layui.css" rel="stylesheet" />
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/ws.js" type="text/javascript"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.utility.printer.js?v=3" type="text/javascript"></script>
    <script type="text/javascript">

        $(document).ready(function () {
            $("#trBurnSoft").hide();
            //选择工单
            SelectProOrder();

            $("#txtProdDate").val(currentTime.substring(0, 10));

            $("#Username").html(employeeCName);

            $("#txtSourceGRN").focus().keydown(function () {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    CheckMemberSourceGRN();
                }
            });

            bindPrinters('selPrintersList');

            setTimeout(
                function () {
                    //加载按钮
                    loadClientButton('MaterialMoldingCollection');
                },
                10
            );

        });

        //删除物料
        function delMaterial(grn) {
            var rowIndex = 0;
            var readyQty = 0;
            $("#tbMaterialInfo tbody tr").each(function () {
                if ($.trim($(this).children(0)[1].innerHTML) == grn) {
                    rowIndex = this.rowIndex;
                }
                else {
                    readyQty = readyQty + parseFloat($.trim($(this).children(0)[3].innerHTML));
                }
            });
            var tab = document.getElementById("tbMaterialInfo");
            tab.deleteRow(rowIndex); // obj.parentElement.parentElement.rowIndex);

            var trDetail = $("#tbMoldingDetail tbody tr").first();
            var useage = parseFloat($.trim(trDetail.children(0)[3].innerHTML));//用量
            $("#txtPrintNum").val(parseFloat((readyQty * 1) / useage));
        }

        var ProdOrderId = 0;
        var ProdOrderQty = 0;
        var moldingMemberId = 0;
        function CheckMemberSourceGRN() {
            labelStationId = $("#hdnCurrStationId").val();
            var sourceGRN = $.trim($("#txtSourceGRN").val());
            if (sourceGRN === "") {
                $("#txtSourceGRN").focus();
                alert("请输入GRN！");
                return false
            }

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMolding.CheckMemberSourceGRN(ProdOrderId, moldingMemberId, sourceGRN, labelStationId);
            if (ajax.error != null) {
                $("#txtSourceGRN").select();
                alert(ajax.error.Message);
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, sourceGRN, ajax.error.Message);
                return false;
            }

            if (ajax.value.RowCount > 1) {
                chooseFlag = 2;
                var searchCondition = " MoldingId = " + ajax.value.MoldingId + " and SourceItemCode='" + ajax.value.SourceItemCode + "'";
                dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=502&CallBackFunc=getProOrderValue&PageCondition= " + searchCondition + "&Multiple=false&rnd=" + Math.random(), width: 600, height: 300 });
                return false;
            }

            if ($("#SourceItemCode").html() == "") {//当物料等没有内容时，显示当前物料的内容,只有1行时，增加成型明细
                moldingMemberId = ajax.value.MoldingMemberId;
                $("#VendorName").html(ajax.value.SourceMaterialUnit.VendorName);
                $("#SourceItemCode").html(ajax.value.SourceItemCode);
                $("#SourceItemName").html(ajax.value.SourceItemName);
                $("#TargetItemCode").html(ajax.value.TargetItemCode);
                //$("#txtPrintNum").val(ajax.value.SourceMaterialUnit.BalanceQty);
                $("#hidMoldingId").val(ajax.value.MoldingId);
                $("#hidMoldingMemberId").val(ajax.value.MoldingMemberId);
                //$("#hidBalanceQty").val(ajax.value.SourceMaterialUnit.BalanceQty);
                labelItemId = ajax.value.TargetItemId;
                if (!moldingDetailAdd(moldingMemberId)) {
                    return false;
                }
            }
            if ($("#SourceItemCode").html() != ajax.value.SourceItemCode) {//物料编号不一致
                alert("待加工物料编号和之前扫描的GRN物料编号的不一样,请将已选择的物料打印,重置后，再进行扫描！");
                $("#txtSourceGRN").val("").focus();
                return false;
            }

            var trDetail = $("#tbMoldingDetail tbody tr").first();
            var remainingQty = parseFloat($.trim(trDetail.children(0)[6].innerHTML));//剩余数量
            var useage = parseFloat($.trim(trDetail.children(0)[3].innerHTML));//用量
            //数量大于剩余数量,//投产的时候可能会多投产一些，因此成型的时候要多数量做可能的次品，因此不用验证数量要小于工单数量--2017/8/30 wenshun.wang
            //if (parseFloat(ajax.value.SourceMaterialUnit.BalanceQty) / useage > remainingQty) {
            //    alert("扫描的Grn数量大于成型的剩余数量,请按成型的剩余数量将Grn分料或者换一个Grn进行扫描！");
            //    $("#txtSourceGRN").val("").focus();
            //    return false
            //}

            if ($("#tbMaterialInfo tbody tr").length > 0) {
                //物料已经扫描过
                var bExists = false;
                $("#tbMaterialInfo tbody tr").each(function () {
                    if ($.trim($(this).children(0)[1].innerHTML) == sourceGRN) {
                        bExists = true;
                        return;
                    }
                });
                if (bExists) {
                    alert("Grn已经扫描过,不能重复扫描！");
                    $("#txtSourceGRN").val("").focus();
                    return false;
                }


                var datacode = $.trim($("#tbMaterialInfo tbody tr").first().children(0)[4].innerHTML);
                //物料的DataCode不一致
                if ($.trim(ajax.value.DateCode) != datacode) {
                    alert("GRN的DataCode和前面扫描的Grn的DataCode不一致！");
                    $("#txtSourceGRN").val("").focus();
                    return false
                }

                //物料的Qty合计超过工单数量                
                var readyQty = 0;
                $("#tbMaterialInfo tbody tr").each(function () {
                    readyQty = readyQty + parseFloat($.trim($(this).children(0)[3].innerHTML));
                });
                //投产的时候可能会多投产一些，因此成型的时候要多数量做可能的次品，因此不用验证数量要小于工单数量--2017/8/30 wenshun.wang
                //if (remainingQty < (readyQty + parseFloat(ajax.value.SourceMaterialUnit.BalanceQty)) / useage) {
                //    alert("扫描的Grn数量和已扫描Grn数量之和大于成型的剩余数量,请按成型的剩余数量将Grn分料或者换一个Grn进行扫描！");
                //    $("#txtSourceGRN").val("").focus();
                //    return false
                //}

                $("#txtPrintNum").val((readyQty + parseInt(ajax.value.SourceMaterialUnit.BalanceQty) * 1 / useage));
            }
            else {
                $("#txtPrintNum").val(parseInt(ajax.value.SourceMaterialUnit.BalanceQty * 1 / useage));
            }

            //物料明细增加显示
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMolding.GetMaterialUnitBySN(sourceGRN);
            if (ajax.error != null) {
                $("#txtSourceGRN").select();
                alert(ajax.error.Message);
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, sourceGRN, ajax.error.Message);
                return false;
            }
            var mudata = ajax.value;
            $("#tbMaterialInfo tbody").append("<tr class='ListTableOddRow'><td>" + ($("#tbMaterialInfo tbody tr").length + 1) + "</td><td>" + sourceGRN + "</td><td>" + mudata.ItemCode + "</td><td>"
                + mudata.BalanceQty + "</td><td>" + mudata.DateCode + "</td><td><input type='button' name='material' value='删除' onclick='delMaterial(\"" + sourceGRN + "\");' /></td></tr>");

            $("#txtSourceGRN").select().focus();
        }

        //下载
        function DownloadSoft() {
            if ($("#txtDownloadDir").val() == "" || $("#txtSoftPath").val() == "" || moldingMemberId == 0 || moldingMemberId == -1) {
                alert("当前物料没有上传烧录软件!");
                return false;
            }
            var data = {
                FileName: $("#txtFilename").val(),
                DownLoadURL: $("#txtSoftPath").val(),
                DownLoadDir: $("#txtDownloadDir").val(),
                FtpIP: "<%= hdnFtpIP.Value %>",
                FtpUser: "<%= hdnFtpUser.Value %>",
                FtpPwd: "<%= hdnFtpPwd.Value %>",
            };
            if (!data.FtpIP || !data.FtpUser || !data.FtpPwd)
            {
                alert("FTP配置信息无效，请先维护FTP配置!");
                return;
            }
            $.initWebSocket({
                Ip: "127.0.0.1",
                Port: "53817",
                Method: "DownLoadBurnSoftware",
                Data: JSON.stringify(data),
                onMessage: function (ws, msg) {
                    var data = JSON.parse(msg.data);
                    if (!data.Success) {
                        alert(data.Error);
                        return;
                    }
                    //下载完成后处理
                    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMolding.AddDownLoadinfo(moldingMemberId);
                    if (ajax.error != null) {
                        alert(ajax.error.Message);
                        //写入日志
                        SaveUserUILog("一般", stationId, resourceId, "", ajax.error.Message);
                        return;
                    }
                    $("#lblIsDownLoad").text("已下载").css("color", "green");
                    $("#hidIsDownLoad").val(1);
                },
                onClose: function (ws, msg) {
                    if (ws && ws.readyState != 1) {
                        alert("连接尚未建立,请确认SKT-LEANMES服务是否开启");
                    }
                }
            });
        }

        //下载烧录程序
        function download() {
            try {
                var requestObj = new Object();
                requestObj.key = "BurnSoft";
                requestObj.iccode = document.getElementById("lblMaterialCode").innerText;
                requestObj.tempatePath = document.getElementById("softpath").innerText;
                var jsonStr = JSON.stringify(requestObj);
                socket.send(jsonStr);
            } catch (e) {
                alert(e);
                $("#lblMessage").html(e);
                return false;
            }
        }

        //打印
        function Print() {
            //设置信息            
            labelStationId = $("#hdnCurrStationId").val();

            var sourceGRN = "";
            $("#tbMaterialInfo tbody tr").each(function () {
                sourceGRN = sourceGRN + $.trim($(this).children(0)[1].innerHTML) + ",";
            });
            var weight = $.trim($("#txtWeight").val());
            var printNum = $.trim($("#txtPrintNum").val());

            if (sourceGRN === "") {
                $("#txtSourceGRN").focus();
                alert("'待加工物料GRN'不能为空！");
                return false;
            }

            if (weight != "") {
                var reg = /^\d+(\.\d+)?$/;
                if (!reg.test(weight)) {
                    $("#txtWeight").select();
                    alert("请输入正确的重量值！");
                    return false;
                }
            }

            if (printNum === "") {
                $("#txtPrintNum").focus();
                alert("打印数量不能为空！");
                return false;
            }

            if (printNum == "0") {
                $("#txtPrintNum").focus();
                alert("打印数量大于0！");
                return false;
            }

            if ($("#hidIsProgrammer").val() == "1") {//需要烧录
                if ($("#hidIsDownLoad").val() == "0") {//是否有下载烧录软件
                    alert("打印前请先下载烧录软件");
                    return false;
                }
            }

            //数量
            var trDetail = $("#tbMoldingDetail tbody tr").first();
            var remainingQty = parseFloat($.trim(trDetail.children(0)[6].innerHTML));//剩余数量
            var useage = parseFloat($.trim(trDetail.children(0)[3].innerHTML));//用量
            var readyQty = 0;
            $("#tbMaterialInfo tbody tr").each(function () {
                readyQty = readyQty + parseFloat($.trim($(this).children(0)[3].innerHTML));
            });
            if (printNum > (readyQty / useage)) {
                $("#txtPrintNum").focus();
                alert("打印数量不能大于扫描的所有物料转型后的数量！");
                return false;
            }

            reg = /^[1-9]\d*$/;
            if (!reg.test(printNum)) {
                $("#txtPrintNum").select();
                alert("请输入正确的打印数量！");
                return false;
            }

            //if (parseFloat($("#hidBalanceQty").val()) === 0) {
            //    alert("无可打印数量！");
            //    return false;
            //}

            if (parseFloat(printNum) > remainingQty) {
                $("#txtPrintNum").focus();
                alert("打印数量不能超过:" + remainingQty);
                return false;
            }
            var group = $("#<%=txtGroup.ClientID %>").val() == "0" ? "" : $("#<%=txtGroup.ClientID %>").find("option:selected").text();
            var t =
            {
                MoldingId: parseFloat($("#hidMoldingId").val()),
                MoldingMemberId: parseFloat($("#hidMoldingMemberId").val()),
                Group: group,
                EquipmentNo: $("#txtEquipmentNo").val(),
                FixtureNo: $("#txtFixtureNo").val(),
                ProdDate: new Date($("#txtProdDate").val()),
                Weight: parseFloat($("#txtWeight").val()),
                StorageLocation: $("#txtStorageLocation").val(),
                CreateBy: userId,
                Remark: $("#txtRemark").val(),
                SourceMoldingMember: new Object(),
                ProdOrderID: ProdOrderId
            };

            t.SourceMoldingMember.SourceMaterialUnit = new Object();
            t.SourceMoldingMember.SourceMaterialUnit.SerialNumber = sourceGRN;
            t.SourceMoldingMember.SourceMaterialUnit.BalanceQty = parseInt($("#txtPrintNum").val());

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMolding.AddProcess(t);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, "", ajax.error.Message);
                return false;
            }
            //获取标签信息
            SNInfo = ajax.value;

            //设置Label
            getDocumentInfo();
            //打印
            getGRNDocumentInfo();
            mesLabLabelPrintType(1);


            setMessageBox(ajax.value.SerialNumber + ' PASS', 'messageGreen');

            //删除内容重置
            $("#tbMaterialInfo tbody").html("");//清空已经打印的物料            
            $("#tbMoldingDetail tbody").html("");//清空选择成型规则
            Reset();//重置        
            GetMaterialProcess();
        }

        function Reset() {
            //如果有未打印的内容，提示是否要重置
            if ($("#tbMaterialInfo tbody tr").length > 0) {
                if (!window.confirm("还有Grn未进行打印，确定要进行重置吗？")) {
                    return false;
                }
            }
            moldingMemberId = 0;
            $("#txtGroup").val("");
            $("#txtProdDate").val(currentTime.substring(0, 10));
            $("#Username").html("");
            $("#txtEquipmentNo").val("");
            $("#txtFixtureNo").val("");
            $("#VendorName").html("");
            $("#txtSourceGRN").val("").focus();
            $("#SourceItemCode").html("");
            $("#SourceItemName").html("");
            $("#TargetItemCode").html("");
            $("#txtWeight").val("");
            $("#txtStorageLocation").val("");
            $("#txtRemark").val("");
            $("#txtPrintNum").val("0");
            $("#hidMoldingId").val("0");
            $("#hidMoldingMemberId").val("0");
            $("#hidIsProgrammer").val("0");
            $("#hidIsDownLoad").val("0");
            //$("#hidBalanceQty").val("0");
            $("#tbMaterialInfo tbody").html("");//清空已经打印的物料            
            $("#tbMoldingDetail tbody").html("");//清空选择成型规则
            //$("#tbMoldingProcess tbody").html("");//清空选择成型规则 
            $("#txtSoftPath").val("");
            $("#txtFilename").val("");
            $("#txtDownloadDir").val("");
        }

        //获取已经成型的物料
        function GetMaterialProcess() {
            $("#tbMoldingProcess tbody").html("");
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMolding.GetListProcess(ProdOrderId);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, "", ajax.error.Message);
                return false;
            }

            var formatDate = function (date) {
                var y = date.getFullYear();
                var m = date.getMonth() + 1;
                m = m < 10 ? '0' + m : m;
                var d = date.getDate();
                d = d < 10 ? ('0' + d) : d;
                return y + '-' + m + '-' + d;
            };
            $.each(ajax.value, function () {
                $("#tbMoldingProcess tbody").append("<tr class='ListTableOddRow'><td>" + this.ProcessNo + "</td><td>" + this.UseGRN + "</td><td>" + formatDate(this.ProdDate) + "</td><td>" + this.Group + "</td><td>" + this.SourceMoldingMember.StationName + "</td><td>" + this.SourceMoldingMember.SourceMaterialUnit.LotCode + "</td><td>" + this.SourceMoldingMember.SourceItemCode + "</td><td>" + this.SourceMoldingMember.SourceMaterialUnit.BalanceQty + "</td><td>" + this.CName + "</td><td>" + this.EquipmentNo + "</td><td>" + this.FixtureNo + "</td><td>" + this.Weight + "</td><td>" + this.StorageLocation + "</td><td>" + this.Remark + "</td></tr>");
            });
        }

        /**
        *选择工单
        */
        function SelectProOrder() {
            chooseFlag = 1;
           // var searchCondition = "1=1"; // "Status=1"; 
            var searchCondition = "";

            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=44&CallBackFunc=getProOrderValue&PageCondition=" + searchCondition + "&Multiple=false&rnd=" + Math.random(), width: 600, height: 300 });
        }

        /**
        *返回值
        */
        function getProOrderValue(list) {
            if (chooseFlag == 1) {
                ProdOrderId = list[0][0];
                ProdOrderQty = list[0][3];
                if (GetMaterialProcess() === false) {
                    return false;
                }

                //---选择工单后动作：1、路由获取；2、相关动态信息获取；3、根据当前工序及路由获取前后工序信息并回显
                $("#hdnCurrProOrderId").val(ProdOrderId);
                //1、获取路由
                var routeId = SKT.LeanMES.Web.AjaxServices.AjaxClientConfig.GetRouteIdByProOrderId(ProdOrderId);
                if (routeId.error != null) {
                    alert(routeId.error.Message);
                    //写入日志
                    SaveUserUILog("一般", stationId, resourceId, "", routeId.error.Message);
                    return false;
                }
                var routeId = routeId.value;

                if (routeId === "-1") {
                    //获取路由失败
                    alert("Error:" + "<%=Resources.Messages.CreateSN_Router_Invalid %>");
                    return false;
                } else {

                    //获取路由成功
                    $("#hdnCurrRouteId").val(routeId);
                    $("#txtSN").removeAttr("disabled");
                }
                //2、相关动态信息获取
                refreshProInfoByProOrderId(ProdOrderId);

                //3、根据当前工序及路由获取前后工序信息并回显
                stationRefresh();

                //end、重新绘制窗口
                setContentHeight();
                setLeftMenuHeight();
                setActiveInfoHeight();

            } else if (chooseFlag == 2) {
                moldingMemberId = list[0][0];

                //重新加载Grn
                CheckMemberSourceGRN();
            }
            chooseFlag = 0;
        }

        ///增加成型规则行
        function moldingDetailAdd(MoldingMemberId) {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMolding.GetMoldingMember(MoldingMemberId, ProdOrderId);
            if (ajax.error != null) {
                $("#txtSourceGRN").select();
                alert(ajax.error.Message);
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, "", ajax.error.Message);
                return false;
            }
            //tbMoldingDetail//成型数据增加1列                
            var data = ajax.value;

            if (data.IsProgrammer) {
                //需要烧录
                $("#txtSoftPath").val(data.SoftPath);
                $("#txtFilename").val(data.Filename);
                $("#trBurnSoft").show();
                $("#hidIsProgrammer").val(data.IsProgrammer ? "1" : "0");
                $("#txtDownloadDir").val(data.DownloadDir);
                $("#hidIsDownLoad").val(data.IsDownload);
                if (data.IsDownload == 1) {
                    $("#lblIsDownLoad").text("已下载").css("color", "green");
                }
                else {
                    $("#lblIsDownLoad").text("未下载").css("color", "red");
                }
            }
            else {
                $("#trBurnSoft").hide();
                $("#txtDownloadDir").val(data.DownloadDir);
                $("#hidIsDownLoad").val(data.IsDownload);
                $("#hidIsProgrammer").val("0");
                $("#hidIsDownLoad").val("0");
            }

            $("#tbMoldingDetail tbody").html("");
            var moldingmemberQty = "";


            $("#tbMoldingDetail tbody").append("<tr class='ListTableOddRow'><td>" + data.MachineTypeName + "</td><td>" + data.SourceItemCode + "</td><td>" + data.SourceItemSpec + "</td><td>" + data.Usage + "</td><td>"
                + ProdOrderQty + "</td><td>" + data.UseQty + "</td><td>" + (parseFloat(ProdOrderQty) - parseFloat(data.UseQty)) + "</td><td>" + data.Location + "</td><td>" + data.StationName + "</td><td>" + data.Specification
                + "</td><td>" + data.TargetItemCode + "</td><td>" + data.Remark + "</td></tr>");
            return true;
        }


        /********************************************标签打印 开始  （zhibin.Chen 2016-03-11 整理）************************************************/

        var ibs;                    //秒
        var labelDocumentId = -1    //Label文档Id
        var lableTypeQty = 1;       //连板数量
        var printName = "";         //打印机名称
        var labelItemId = '';    //ItemId
        var labelProdOrderId = '';
        var labelStationId = -1;    //工位Id
        var labelType = -3;          //标签类型  (1.GRN 2.包装)
        var labelSequence = 2;      //标签序号
        var labelPrintWayId = -1;   //打印方式 78=Lab  79=ZPL

        var lableArr = null;        //标签信息的SN序列号集合对象
        var SNInfo;                 //当前释放标签的信息集合对象
        var tempatePath = "";       //Lab模板文件路径     


        /*打印机插件未引用成功的消息内容*/
        NoPrinterPlugin = "<%=Resources.Messages.NoPrinterPlugin %>";
        var NoPrinterPluginLab = "Lab打印插件加载失败！请先安装打印插件！";
        var NoPrinterPluginZPL = "ZPL打印插件加载失败！请先安装打印插件！";
        //打印插件对象
        var labelPrintingPlugin;

        //获取物料条码文档模板基础信息
        function getGRNDocumentInfo() {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPrint.GetLabelDocumentInfo(labelItemId, labelStationId, labelType, labelSequence);
            if (ajax.error == null) {
                var entity = ajax.value;
                labelDocumentId = entity.LabelDocumentId; //Label文档Id
                lableTypeQty = entity.PlateQty;           //连板数量
                //获取打印机名称值
                printName = $("#selPrintersList").val();
                labelPrintWayId = entity.PrintWayId;      //打印方式 78=Lab  79=ZPL
                tempatePath = entity.TemplatePath.replace("\\", "\\\\");

            }
            else {
                alert(ajax.error.Message);
                $("#lblMessage").html(ajax.error.Message);
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, "", ajax.error.Message);
                return false;
            }
        }

        //获取文档模板基础信息
        function getDocumentInfo() {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPrint.GetLabelDocumentInfo(labelItemId, labelStationId, labelType, labelSequence);
            if (ajax.error == null) {
                var entity = ajax.value;
                labelDocumentId = entity.LabelDocumentId;
                lableTypeQty = entity.PlateQty;
                printName = entity.PrinterName;
                labelPrintWayId = entity.PrintWayId;
                tempatePath = entity.TemplatePath.replace("\\", "\\\\");
            }
            else {
                alert(ajax.error.Message);
                $("#lblMessage").html(ajax.error.Message);
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, "", ajax.error.Message);
                return false;
            }

            //初始化打印插件
            //InityPrintingPlugin();
        }


        //codesoft打印  Lab模板方式
        function mesLabLabelPrintType(PrintType) {
            //从已释放的标签信息集合中，获取SN序列号集合。
            lableArr = [];
            lableArr[0] = SNInfo.SerialNumber;

            var labelStr = "";
            var printdata = [];
            /*循环GRN*/
            for (var i = 0; i < lableArr.length;) {
                //连片数
                if (lableTypeQty == 1) {
                    labelStr = lableArr[i];
                }
                else {
                    //每次重置一下
                    labelStr = "";
                    for (var j = 0; j < lableTypeQty; j++) {
                        if (lableArr[i + j] == null || lableArr[i + j] == "undefined") {
                        }
                        else {
                            //根据联板数，拼接SN字符串。 
                            labelStr += lableArr[i + j] + ",";
                        }
                    }
                }
                i = i + lableTypeQty; //连片的递增
                //获取标签模板中的标签值 集合
                var ajaxLabContent = SKT.LeanMES.Web.AjaxServices.AjaxPrint.returnLabelInfoForLab(labelDocumentId, labelStr, -1, -1, -1, labelItemId, -1);
                if (ajaxLabContent.error == null) {
                    try {
                        var list = ajaxLabContent.value;
                        if (list.length > 0) {
                            var page = { LabelContent: [] };
                            for (var k = 0; k < list.length; k++) {
                                page.LabelContent.push({ name: list[k].LabelName, value: list[k].LabelValue });
                            }
                            printdata.push(page);
                        }
                    } catch (e) {
                        printdata = [];
                        alert(e);
                        $("#lblMessage").html(e);
                        return false;
                    }
                }
                else {
                    printdata = [];
                    alert(ajaxLabContent.error.Message);
                    $("#lblMessage").html(ajaxLabContent.error.Message);
                    return false;
                }
            }
            if (printdata.length == 0)
                return;
            try {
                sendPrintContent(JSON.stringify(printdata), printName, 1, labelDocumentId);
            } catch (e) {
                alert(e);
                $("#lblMessage").html(e);
                return false;
            }
            ibs = 3;
            setTimeout(function () {
                $("#lblMessage").html('条码打印完成!');
            }, 300);
        }


        function recordPrint(sn) {
            var printRecodeEntity = {};
            printRecodeEntity.RecordId = -1;
            printRecodeEntity.ActionType = 1;
            printRecodeEntity.PrintType = -3;
            printRecodeEntity.PrintKey = sn;
            printRecodeEntity.StationId = -1;
            printRecodeEntity.ResourceId = -1;
            var ajaxPrintRecodes = SKT.LeanMES.Web.AjaxServices.AjaxSerialNumber.RecodePrint(printRecodeEntity);
            if (ajaxPrintRecodes.error != null) {
                alert(ajaxPrintRecodes.error.Message);
                $("#lblMessage").html(ajaxPrintRecodes.error.Message);
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, "", ajaxPrintRecodes.error.Message);
                return false;
            }
        }
        /********************************************标签打印 结束   （zhibin.Chen 2016-03-11 整理）************************************************/
    </script>
</asp:Content>
