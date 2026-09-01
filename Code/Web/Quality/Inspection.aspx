<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    CodeBehind="Inspection.aspx.cs" Inherits="SKT.LeanMES.Web.Quality.Inspection" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <style type="text/css">
        .wrapper {
            padding-top: 10px;
            padding-left: 10px;
            padding-right: 10px;
        }

        .noBody {
            border: 0px solid #d3d3d3 !important;
        }

            .noBody tr td {
                border: 0px solid #d3d3d3 !important;
                padding-bottom: 5px;
            }

        .wrapper h1 {
            text-align: center;
            font-size: 30px;
            font-weight: bold;
            padding-bottom: 10px;
        }

        table tr th, table tr td, table tr td {
            text-align: center;
        }

        table a {
            font-size: 16px !important;
        }

        table label {
            font-size: 16px !important;
        }

        table input[type=text] {
            width: 90%;
        }

        .BtnBox {
            padding: 10px;
        }

        #iqcDetail, #iqcContent, #iqcSize, #iqcPerformance, #iqcTest {
            font-size: 20px;
            border: 0.5px solid #000;
            border-collapse: collapse;
        }

            #iqcDetail tr td, #iqcContent tr td, #iqcSize tr td, #iqcPerformance tr td, #iqcTest tr td {
                border: 0.5px solid #000;
            }

        /*.uploadify-button {
            width: 35px !important;
        }

        #fileUpload-button {
            width: 35px !important;
        }

        #fileUpload object {
            width: auto !important;
            display: inline !important;
        }

        #iqcTestUpload-button {
            width: 500px;
        }
        */

        #iqcTestUpload object {
            width: auto !important;
            display: inline !important;
        }
    </style>
    <table class="EditeContentTable" width="100%" style="display: none">
        <tr id="trInspectionOrderNo">
            <td class="Label1">
                <asp:Label ID="lbInspectionTypeName" runat="server" Text="检单号"></asp:Label><em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="InspectionOrderNo" runat="server" CssClass="TextBox"></asp:TextBox>
                <input id="button1" class="ButtonBox" type="button" onclick="selectInspectionOrderNo()"
                    value="..." title="选择检验单" />
                <asp:HiddenField ID="hfInspectionOrderId" runat="server" Value="-1" />
            </td>
        </tr>
        <tr id="trInspectionSerialNumber">
            <td class="Label1">物料条码<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtSerialNumber" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
    </table>

    <div class="wrapper">
        <h1></h1>
        <table id="iqcTable" class="ListTable" style="border-width: 0px; width: 100%; border-collapse: collapse;">
            <thead>
                <tr class="ListTableHeader">
                    <th>检验单号</th>
                    <th>采购订单</th>
                    <th>供应商编号</th>
                    <th>物料编码</th>
                    <th>物料名称</th>
                    <th>物料规格</th>
                    <th>物料类别</th>
                    <th>供应商</th>
                    <th>来料数量</th>
                    <th style="width: 100px">来料最小包装总量</th>
                    <th>单位</th>
                    <th>检验员</th>
                </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
    </div>
    <div class="BtnBox">
        <table style="width: 100%">
            <tr>
                <td style="width: 250px; text-align: left">
                    <span style="font-size: 15px; padding-right: 5px;">最终检验结果</span><label style="color: green"><input type="checkbox" disabled="disabled" id='cbFormOK' /><span>合格</span></label><label style="color: red"><input type="checkbox" disabled="disabled" id='cbFormNG' /><span>不合格</span></label>
                </td>
                <td style="text-align: center;" id="trSaveOrderBtn">
                    <input id="InspectionStartBtn" type="button" value=" 检验开始 " onclick="InspectionStart()" style="margin-right: 10px;" />
                    <input id="SaveBtn" type="button" value=" 检验完成  " onclick="    if (SubmitValidation()) { SaveForm(); }" style="margin-right: 10px;" />
                    <input id="btnVerify" type="button" value=" 审核 " onclick="Verify()" />
                </td>
            </tr>
            <tr id="trMsg" style="display: none;">
                <td colspan="2">
                    <div id="tip-msg" style="text-align: center; font-size: 32px; font-weight: bold; color: #ff0000; margin-top: 10px;">已紧急放行</div>
                </td>
            </tr>
        </table>
    </div>

    <div style="margin-top: 15px; margin-bottom: 15px; display: none">
        <table class="EditeContentTable" width="100%">
            <tr>
                <td class="Label3">检验单号
                </td>
                <td class="Field3">
                    <span id="spanInspectionOrderNo"></span>
                </td>
                <td class="Label3">产品编码
                </td>
                <td class="Field3">
                    <span id="spanInspectionItemCode"></span>
                </td>
                <td class="Label3">供应商
                </td>
                <td class="Field3">
                    <span id="spanVendor"></span>
                </td>
            </tr>
            <tr>
                <td class="Label3">产品规格
                </td>
                <td class="Field3" colspan="5">
                    <span id="ItemSpec"></span>
                </td>
            </tr>
            <tr>
                <td class="Label3">检验单数量
                </td>
                <td class="Field3">
                    <span id="spanInspectionOrderQty"></span>
                </td>
                <td class="Label3">检验员
                </td>
                <td class="Field3">
                    <input type="text" id="txtCheck" style="width: 90%" />
                </td>
                <td class="Label3">版本
                </td>
                <td class="Field3">
                    <input type="text" id="txtPrintLv" value="RF-GI-QM-015-02-V2.0" style="width: 160px" />
                </td>
            </tr>
            <tr>
                <td class="Label3">应抽数量
                </td>
                <td class="Field3">
                    <span id="spanInspectionQty"></span>
                </td>
                <td class="Label3">最终检验结果
                </td>
                <td class="Field3">
                    <label style="color: Green; font-weight: bold;">
                        <input type="checkbox" disabled="disabled" onchange='FinalResult(this)' />合格</label>&nbsp;&nbsp;
                    <label style="color: Red; font-weight: bold;">
                        <input type="checkbox" disabled="disabled" onchange='FinalResult(this)' />不合格</label>
                </td>
                <td class="Label3">文件上传
                </td>
                <td class="Field3">
                    <input type="file" name="fileUpload" id="fileUpload" />
                </td>
            </tr>
            <tr>
                <%--                <td class="Label3">
                    实抽数量<em>*</em>
                </td>
                <td class="Field3">
                    <input type="text" id="txtActualQty" IsRequired="1" style="width: 50%" />
                </td>
                <td class="Label3">
                    不良数量<em>*</em>
                </td>
                <td class="Field3">
                    <input type="text" id="txtNCQty"  IsRequired="1"  style="width: 50%" />
                </td>--%>
                <%--                <td class="Label3">
                    最终检验结果
                </td>
                <td class="Field3">
                    <label style="color: Green; font-weight:bold;">
                        <input id='cbFormOK' type="checkbox" disabled="disabled"  onchange='FinalResult(this)' />合格</label>&nbsp;&nbsp;
                    <label style="color: Red;font-weight:bold;">
                        <input id='cbFormNG' type="checkbox"  disabled="disabled" onchange='FinalResult(this)' />不合格</label>
                </td>--%>
            </tr>
            <tr>
                <td class="Label3">采购单号
                </td>
                <td class="Field3">
                    <span id="txtPOCode"></span>
                </td>
                <td class="Label3">订单号
                </td>
                <td class="Field3">
                    <span id="txtSOCode"></span>
                </td>
                <td class="Label3 verify" style="display: none">审核备注
                </td>
                <td class="Field3 verify" style="display: none">
                    <textarea type="text" id="txtSign" class="TextArea" style="min-width: 350px"></textarea>
                </td>
            </tr>
            <tr>
            </tr>
        </table>
    </div>
    <div class="wrap_tb" id="wrap_tb">
        <ul class="tb">
            <li class="current" id="Div1">检验明细</li>
            <li>GRN信息</li>
            <li>相关文件</li>
            <li>送货报告</li>
        </ul>
        <div class="tb_c tb_content">
            <div id="divDtl">
            </div>
            <br />
            <table class="EditeContentTable" width="100%">
                <tr>
                    <td class="Label" style="width: 20%; text-align: center">备注：
                    </td>
                    <td class="Field" style="width: 80%; text-align: center">
                        <input id="txtRemark" type="text" style="width: 97%; height: 30px" name="name" value="" />
                    </td>
                </tr>
                <tr>
                    <td class="Label" style="width: 20%; text-align: center">仪器编号：
                    </td>
                    <td class="Field" style="width: 80%; text-align: center">
                        <input id="txtInstrument" type="text" style="width: 97%; height: 30px" name="name"
                            value="A卡尺，B卷尺，C钢尺，D膜厚仪，E投影仪，F通止规，G环规，H针规，I塞尺，J网络分析仪，K互调仪，L色差仪，M大理石平台，N其他。" />
                    </td>
                </tr>
            </table>
        </div>
        <div id="GRNInfo">
            <table class="ListTable" width="100%">
                <tr class="ListTableHeader">
                    <th>行号</th>
                    <th>采购订单</th>
                    <th>GRN</th>
                    <th>数量</th>
                    <th>物料编码</th>
                    <th>物料名称</th>
                    <th>物料规格</th>
                </tr>
            </table>
        </div>
        <div id="FileInfo">
            <table class="ListTable" width="100%">
                <tr class="ListTableHeader">
                    <th>序号</th>
                    <th>产品编码</th>
                    <th>供应商</th>
                    <th>文件名称</th>
                    <th>文件类型</th>
                    <th>文件类型</th>
                    <th>创建人</th>
                    <th>创建时间</th>
                    <th>下载</th>
                </tr>
            </table>
        </div>
        <div id="ReceiveFile">
            <table id="tblShippingReport" class="ListTable" width="100%" style="margin-top: -1px;">
                <thead>
                    <tr class="ListTableHeader">
                        <th style="text-align: center; width: 150px;">序号
                        </th>
                        <th style="text-align: center; width: 150px;">报告类型
                        </th>
                        <th style="text-align: center; width: 150px;">文件名称
                        </th>
                        <th style="width: 150px; text-align: center;">文件属性
                        </th>
                        <th style="text-align: center; width: 150px;">文件类型
                        </th>
                        <th style="width: 150px; text-align: center;">上传人
                        </th>
                        <th style="width: 150px; text-align: center;">上传时间
                        </th>
                        <th style="width: 150px; text-align: center;">操作
                        </th>
                    </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>
    </div>
    <input id="inputPOCode" type="hidden" />
    <input id="inputDeliverNo" type="hidden" />
    <input id="inputVenCode" type="hidden" />
    <script type="text/javascript" src="../Content/js/jquery-3.1.0.min.js"></script>
    <script type="text/javascript" src="../Content/plugin/uploadify/jquery.uploadify.min.js"></script>
    <script type="text/javascript">
        var tab = document.getElementById("tblExpand");
        var TypeId = '<%=Request["TypeId"] %>'; /*页面布局  1：审核 2：检验  10：综合*/
        var name = '<%=Request["name"] %>'; //Material_IQCFormView查看
        var InspectionTypeId = '<%=Request["InspectionTypeId"]  %>';  /*验检单类型 */
        var InspectionId = '<%=Request["IOrderId"]??"-1"  %>';    /*检验单ID*/
        var IOrderId = InspectionId;                              /*检验单ID*/
        var IQCStatus = '<%=Request["Status"]??"-1"  %>'; //IQC状态 false 为检验true 已检验
        var VerifyUser = '';
        var InspectionResult = -1; //测试结果
        var userName = "<%=userName %>";
        var ItemCode = "";
        var moCount = 0; //  模版项计数
        var ShowMessCount = 0;
        var OrderStatue = 0;
        //模版检验项列表
        var listItem = [];
        //模版LCR检验项列表
        var Lcrlist = [];

        //IQC检验模板List
        var IQCModelList = [];
        //IQC检验项GRN结果录入
        var IQCInputGRNList = [];

        var isInspectionStart = 0;//是否已经点击了开始检验按钮

        /*页面模板显示*/
        function PageModelSetting() {
            if (TypeId == 1) {
                $("#divInspectionObj").css("display", "none");
                $("#tblExpand").css("display", "none");
                $("#trInspectionSerialNumber").css("display", "none");
            }
            $("#txtCheck").val(userName);
        }


        $(function () {
            $(".wrapper h1").text(mesLang("来 料 检 验 报 告"));
            $("#txtNCQty,#txtActualQty").keyup(function () {
                getIntVal($(this));
            });
            PageModelSetting();


            $("#<%=this.txtSerialNumber.ClientID%>").keydown(function (e) {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    var SerialNumber = $(this).val();
                    LoadInspectionOrderMember($("#spanInspectionOrderNo").html(), SerialNumber);
                    $(this).val("");

                    /*通过触发点击事件获取各检验项目的实抽数量*/
                    $(".InspectionItemEDQty").click();
                }
            });

            $("#txtNCQty").keydown(function (e) {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    var spanInspectionQty = parseInt($("#spanInspectionQty").text());
                    var txtActualQty = parseInt($("#txtActualQty").val());
                    var txtReQty = parseInt($("#spanRe").text());
                    var txtNCQty = parseInt($(this).val());
                    var spanInspectionOrderQty = parseInt($("#spanInspectionOrderQty").text());

                    if (txtActualQty > spanInspectionOrderQty) {
                        alert("实抽数量不能大于检验单数量！");
                        $("#txtActualQty").focus();
                        return false;
                    }
                    else if (txtActualQty < spanInspectionQty) {
                        alert("实抽数量不能少于应抽数量！");
                        $("#txtActualQty").focus();
                        return false;
                    }
                    else if (txtNCQty > txtActualQty) {
                        alert("不良数量不能大于实抽数量！");
                        $("#txtNCQty").focus();
                        return false;
                    }
                    if (txtNCQty >= txtReQty) {
                        $("#cbFormNG").prop("checked", "true");
                        $("#cbFormOK").removeAttr("checked");
                    }
                    else {
                        $("#cbFormOK").prop("checked", "true");
                        $("#cbFormNG").removeAttr("checked");
                    }

                }
            });
            //获取根据检验单Id获取检验信息
            if (InspectionTypeId != -1) {
                getFormInfo();
                //GetIqcTable();
                ReceiveFileShow(); //显示
                GRNInfoShow();
                UpLoad();
                //检验开始时候，检验完成审核时
                if (isInspectionStart == 0 || VerifyUser != "" || InspectionResult >= 0) {
                    $("#divDtl").find("input:not(.result-entry)").attr("disabled", "disabled");
                    $("#SaveBtn").hide(); //隐藏“检验完成”按钮
                    $(".MinPackQty").attr("disabled", "disabled");//禁用最小包装数量
                    $(".ButtonBox").attr("disabled", "disabled"); //禁用选择单位
                    $("input[name='downloadFile']").attr("disabled", "disabled"); //禁用下载按钮
                    //$("span[name='DeleteItem']").attr("disabled", "disabled");//禁用删除项按钮
                    //$("th[name='delId']").attr("disabled", "disabled");//禁用添加项按钮
                }
            }
            //input 事件焦点设定
            //$('input:checkbox').click(function () {
            //    this.blur();
            //    this.focus();
            //});
            //可否编辑
            if (name === 'Material_IQCFormView') {
                $('input:not(.result-entry)').attr("disabled", "disabled");
                //$('input').attr("disabled", "disabled");
                //$("#trSaveOrderBtn").css("display", "none");
                $("#btnVerify").siblings().hide();
                if ($("#btnVerify").parent().find("input:visible").length == 0) {
                    $("#txtSign").prop("disabled", true);
                    $("#trSaveOrderBtn").hide();
                }
            }

            var username = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';
            $("#fileUpload").removeAttr("disabled").uploadfile({
                uploader: '<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Handler/UploadHander.ashx',
                fileSizeLimit: 10,
                buttonText: "点击上传文件",
                formData: function () {
                    return { 'Action': 'InspectionFile', 'InspectionNo': $.trim($("#spanInspectionOrderNo").html()), "userName": username }
                },
                onUploadSuccess: function (file, data, response) {
                    FileShow();
                },
                fail: function () {

                }
            });
        })

        function GetIqcTable() {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxInspection.GetIqcFormModel(IOrderId);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                if (InspectionId != -1) {
                    parent.Refresh();
                }
                return;
            }
            var data = JSON.parse(ajax.value);
            var entity = data.data;
            SetIqcTable(entity);


            //var labCheck = data[0].LabCheck == "否" ? "否" : "是";
            //$("#slLabCheck").val(labCheck);

            //if (CheckStep > 1) {
            //    $("#slLabCheck").attr("disabled", "disabled");
            //}
        }

        function SetIqcTable(data) {
            $("#iqcTable tbody").html("<tr></tr>");

            var tab = document.getElementById("iqcTable").getElementsByTagName("tbody")[0];

            for (var i = 0; i < data.length; i++) {
                var row, cell, rowNewIdx = tab.rows.length;
                row = tab.insertRow(rowNewIdx);

                cell = row.insertCell(0);
                cell.align = "center";
                cell.className = "Field";
                cell.innerHTML = data[i].InspectionNo;//检验单号

                cell = row.insertCell(1);
                cell.align = "center";
                cell.className = "Field";
                cell.innerHTML = data[i].POCode;//采购订单
                $("#inputPOCode").val(data[i].POCode)

                cell = row.insertCell(2);
                cell.align = "center";
                cell.className = "Field";
                cell.innerHTML = data[i].SuplierCode;//供应商编号

                cell = row.insertCell(3);
                cell.align = "center";
                cell.className = "Field";
                cell.innerHTML = data[i].ItemCode;//物料编码

                cell = row.insertCell(4);
                cell.align = "center";
                cell.className = "Field";
                cell.innerHTML = data[i].ItemName;//物料名称

                cell = row.insertCell(5);
                cell.align = "center";
                cell.className = "Field";
                cell.innerHTML = data[i].ItemSpec;//物料规格

                cell = row.insertCell(6);
                cell.align = "center";
                cell.className = "Field";
                cell.innerHTML = data[i].CategoryOne;//物料类别

                cell = row.insertCell(7);
                cell.align = "center";
                cell.className = "Field";
                cell.innerHTML = data[i].VendorSort;//供应商

                cell = row.insertCell(8);
                cell.align = "center";
                cell.className = "Field";
                cell.innerHTML = parseFloat(data[i].InspectionQty);//来料数量

                var tdMinPackQty = "<span class=\"MinPackQty\">" + parseFloat(data[i].MinPackQty) + "</span>";
                var tdUnits = data[i].Units;

                if (name != "Material_IQCFormView") {
                    tdMinPackQty = "<input type=\"text\" class=\"MinPackQty\" value=\"" + parseFloat(data[i].MinPackQty) + "\" />";
                    tdUnits = ' <input type="text" MaxLength="50" value="' + (typeof (data[i].Units) == "undefined" ? "" : data[i].Units) + '" style="width:40%;" class="txtUnit"/>' +
                        '<input type=\"button\" onclick=\"selectUnit(this);\" class=\"ButtonBox\" value=\"...\" />';
                }

                cell = row.insertCell(9);
                cell.align = "center";
                cell.className = "Field";
                cell.innerHTML = tdMinPackQty;//来料最小包装总量

                cell = row.insertCell(10);
                cell.align = "center";
                cell.className = "Field";
                cell.innerHTML = tdUnits;//单位

                cell = row.insertCell(11);
                cell.align = "center";
                cell.className = "Field";
                cell.innerHTML = data[i].InspectionUser;//检验员
            }
        }

        function ReceiveFileShow() {
            $("#tblShippingReport tbody").html("");
            var DeliverNo = $("#inputDeliverNo").val();
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPurOrder.GetReportFileInfo(DeliverNo);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return;
            }
            var data = ajax.value;
            for (var i = 0; i < data.length; i++) {
                var rowType = data[i].RowType == "ShippingReport" ? "出货报告" : "实验报告";
                var clickInfo = "FileShipSave(this)";
                if (data[i].RowType != "ShippingReport") {
                    clickInfo = "FileTestSave(this)";
                }
                var $tr = $("<tr class='ListTableOddRow'>"
                    + "<td>" + (i + 1) + "</td>"
                    + "<td>" + rowType + "</td>"
                    + "<td>" + data[i].FileType + "</td>"
                    + "<td>" + data[i].FileName + "</td>"
                    + "<td>" + data[i].FileVersion + "</td>"
                    + "<td>" + data[i].CreateBy + "</td>"
                    + "<td>" + data[i].CreateDateTime + "</td>"
                    + "<td><a href='#' onclick=" + clickInfo + "><span style='font-size:12px;'>下载</span></a></td>"
                    + "</tr>");
                $("#tblShippingReport tbody").append($tr);
                $tr.data("FileSaveName", data[i].FileSaveName);
            }
        }

        var rowObj1 = null;
        function selectUnit(obj) {
            rowObj1 = obj.parentElement.parentElement;
            var searchCondition = " DicProperty='Unit' ";
            dialog({
                title: "<%=Resources.Common.ChooseWindow %>"
            , src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=3&CallBackFunc=getChooseValuesselectUnit&PageCondition= " + searchCondition + "&Multiple=false&rnd=" + Math.random(), width: 650, height: 350
            });
        }

        function getChooseValuesselectUnit(list) {
            $(rowObj1).find(".txtUnit").val(list[0][1]);
        }

        /**
        **IQC检验开始
        **/
        function InspectionStart() {
            //验证是否已经接收
            var entity = {};
            entity.InspectionId = IOrderId;
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialIQC.ValidateIQCRecived(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            if (!confirm("是否确认现在开始检验？")) {
                return false;
            }
            if (isInspectionStart) {
                alert("IQC检验单已开始检验！");
                return false;
            }
            else {
                var spanInspectionQty = parseInt($("#spanInspectionQty").text());
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxInspection.IQCInspectionStart(IOrderId, spanInspectionQty);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return;
                }
                alert("检验开始操作成功！");
                isInspectionStart = 1;
                $("#divDtl").find("input").removeAttr("disabled");
                $("#divDtl tr[name='TempLateTr'] ").each(function () {
                    var tdText = $(this).find("td:eq(2)").text();
                    if (tdText == "指定值") {
                        $(this).find("input[type='radio'][id *= 'OK'],input[type='radio'][id *= 'NG']").attr("disabled", "disabled");
                    }
                });
                $("#InspectionStartBtn").hide();

                $("#SaveBtn").show(); //隐藏“检验完成”按钮
                $(".MinPackQty").removeAttr("disabled");//禁用最小包装数量
                $(".ButtonBox").removeAttr("disabled") //禁用选择单位
                $("input[name='downloadFile']").removeAttr("disabled") //禁用下载按钮
                //$("span[name='DeleteItem']").attr("disabled", "disabled");//禁用删除项按钮
                //$("th[name='delId']").attr("disabled", "disabled");//禁用添加项按钮

                return true;
            }
        }

        function selectInspectionOrderNo() {

            var condition = " Statue =0 ";
            dialog({
                title: "<%=Resources.Common.ChooseWindow %>",
                src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=69&CallBackFunc=getChooseValueWO&SearchCondition=" + condition + "&Multiple=false&rnd=" + Math.random(), width: 500, height: 200
            });
        }

        //获取检验单
        function getChooseValueWO(list) {
            $("#<%=this.hfInspectionOrderId.ClientID%>").val(list[0][0]);
            $("#<%=this.InspectionOrderNo.ClientID%>").val(list[0][1]);

            IOrderId = list[0][0];
            IOrderNo = list[0][1];
            //获取根据检验单Id获取检验信息
            getFormInfo();
        }

        //获取根据检验单Id获取检验信息
        function getFormInfo() {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxInspection.GetIqcFormModel(IOrderId);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                if (InspectionId != -1) {
                    parent.Refresh();
                }
                return;
            }
            if (ajax.value != null) {
                var en = $.parseJSON(ajax.value)
                ItemCode = en.data[0].ItemCode;
                ItemSpec = en.data[0].ItemSpec;
                OrderStatue = en.data[0].Status;
                $("#inputDeliverNo").val(en.data[0].DeliverNo);

                if ("IQC批量质检合格" == en.data[0].Remark) {
                    $("#trMsg").css("display", "");
                }
                else {
                    $("#trMsg").css("display", "none");
                }

                if (en.data[0].InspectionStartUser != "") {
                    isInspectionStart = 1;
                    $("#divDtl").find("input").removeAttr("disabled");
                    $("#InspectionStartBtn").hide();
                }

                if (OrderStatue > "1") {
                    //检验单交接确认后，不能修改
                    $('#cbFormOK').attr("disabled", "disabled");
                    $('#cbFormNG').attr("disabled", "disabled");
                    $("#txtActualQty,#txtNCQty").attr("disabled", "disabled").removeAttr("IsRequired");
                    $("#btnVerify").show();
                    $(".verify").show();
                } else {
                    $("#btnVerify").hide();
                    $(".verify").hide();
                }
                $("#inputVenCode").val(en.data[0].SuplierCode);
                $("#spanInspectionOrderNo").html(en.data[0].InspectionNo);
                $("#spanInspectionItemCode").html(ItemCode);
                $("#ItemSpec").html(ItemSpec);
                $("#spanInspectionOrderQty").html(en.data[0].InspectionQty);
                VerifyUser = en.data[0].VerifyBy;
                if (en.data[0].VerifyBy) {
                    $("#btnVerify").hide();
                }
                $("#txtSign").val(en.data[0].Auditing);
                $("#txtActualQty").val(en.data[0].ActualQty);
                $("#txtNCQty").val(en.data[0].NCQty);
                InspectionResult = en.data[0].InspectionResult;
                if (en.data[0].InspectionResult == 0) {
                    $("#cbFormNG").attr("checked", "checked");
                    $("#cbFormOK").removeAttr('checked');
                }
                else if (en.data[0].InspectionResult == 1) {
                    $("#cbFormNG").prop("checked", false);
                    $("#cbFormOK").prop("checked", true);
                }

                if (OrderStatue == 1) {
                    $("#txtCheck").val(userName);
                }
                else {
                    if (en.data[0].InspectionUser != null && en.data[0].InspectionUser != "") {
                        $("#txtCheck").val(en.data[0].InspectionUser);
                    }
                }
                if (en.data[0].PrintLv != null && en.data[0].PrintLv != "") {
                    $("#txtPrintLv").val(en.data[0].PrintLv);
                }
                if (en.data[0].Instrument != null && en.data[0].Instrument != "") {
                    $("#txtInstrument").val(en.data[0].Instrument);
                }
                if (en.data[0].Remark != null && en.data[0].Remark != "") {
                    $("#txtRemark").val(en.data[0].Remark);
                }
                if (en.data[0].POCode != null && en.data[0].POCode != "") {
                    $("#txtPOCode").html(en.data[0].POCode)
                }
                if (en.data[0].SOCode != null && en.data[0].SOCode != "") {
                    $("#txtSOCode").html(en.data[0].SOCode)
                }

                //获取文件信息
                FileShow();
                //加载检验模版项
                moCount = 0;
                LoadInspectionItem(en.data1);
                SetIqcTable(en.data);

                //已检验的IQC单据禁用radio
                if (IQCStatus == "true") {
                    $("input[type='radio'],input[type='text']").attr("disabled", "disabled");
                    //$("#trSaveOrderBtn").css("display", "none");
                    $("#btnVerify").siblings().hide();
                    if ($("#btnVerify").parent().find("input:visible").length == 0) {
                        $("#trSaveOrderBtn").hide();
                        $("#txtSign").prop("disabled", true);
                    }
                }
                //初始化IQC单据状态
                if ($("tr[name='TempLateTr'] input[type='radio']:checked").length > 0) {
                    $("#cbFormOK").prop("checked", true)
                    $("#cbFormNG").prop("checked", false);
                    for (var i = 0; i < $("tr[name='TempLateTr'] input[type='radio']:checked").length; i++) {
                        var $_radio = $($("tr[name='TempLateTr'] input[type='radio']:checked")[i]);
                        if ($_radio.attr("id").toString().indexOf("NG") != -1) {
                            $("#cbFormOK").prop("checked", false);
                            $("#cbFormNG").prop("checked", true);
                            return false;
                        }
                    }
                }
            }
        }

        function FinalResult(t) {
            var cb = $(t).attr('id') == "cbFormOK" ? "cbFormNG" : "cbFormOK";
            $("#" + cb).removeAttr('checked');
        }

        //加载检验模版项
        function LoadInspectionItem(data1) {
            $("#divDtl").append("");
            listItem = [], moCount = 0;
            for (var i = 0; i < data1.length; i++) {
                DetailItem(data1[i].InspectionId, data1[i].InspectionTemplateId, i);
            }
        }

        //模版检验项详细资料取得绑定
        function DetailItem(InspectionId, InspectionTemplateId) {

            var IsNG = 0;
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxInspection.GetIqcFormItem(InspectionId, InspectionTemplateId);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return;
            }
            var value = $.parseJSON(ajax.value);

            //模版头添加
            var head = value.data[0];
            if (head == undefined) {
                return;
            }
            $("#spanLotSizeLevel").text(head.LotName + "/AQL=" + head.RuleName);
            //$("#spanInspectionQty").text(parseInt(head.SamplingValue) > (parseInt($("#spanInspectionOrderQty").text()))?parseInt($("#spanInspectionOrderQty").text()):parseInt(head.SamplingValue));
            $("#spanAc").text(head.ACValue);
            $("#spanRe").text(head.REValue);
            $("#spanVendor").text("[" + head.VendorCode + "]" + head.VendorName);
            var html = "<table id='tblExpand' class='ListTable' style='border-width:0px;width:100%;border-collapse:collapse; margin-top:5px;'  >"
                          + "<tr class='ListTableHeader' id='" + head.InspectionTemplateId + "' style='text-align: center;'><th colspan='6' >" + head.InspectionTemplateName + "</th></tr>"
                + "<tr class='ListTableHeader' ><th>" + mesLang("抽样水平") + "</th><th>" + mesLang(head.LotName) + "/AQL=" + (head.RuleName) + "</th>"
                + "<th>" + mesLang("抽样数量") +"</th><th>" + head.SamplingValue + "</th>"
                                      + "<th>Ac/Re</th><th>" + "Ac=  " + head.ACValue + "/ Re=  " + head.REValue + "</th></tr>"
                          + "</table>";
            $("#divDtl").append(html);
            if ($("#spanInspectionQty").text() == "" || parseInt($("#spanInspectionQty").text()) < parseInt(head.SamplingValue)) {
                $("#spanInspectionQty").text(head.SamplingValue);
            }

            //加载检验项
            var Dtllist = value.data1;

            var InsItemNamestr = "", InspectionMethodValue = "", CheckFashion = "", DelRow = "";

            html = "<table id='tbDtl" + head.InspectionTemplateId + "' class='ListTable' style='border-width:0px;width:100%;border-collapse:collapse; margin-top:5px;'  >"
                + "<tr class='ListTableHeader' ><th >" + mesLang("序号") + "</th><th>" + mesLang("检验项目") + "</th><th>" + mesLang("录入方式") + "</th><th>" + mesLang("判定标准") + "</th><th>" + mesLang("单位") + "</th><th>" + mesLang("检验方法") + "</th><th >" + mesLang("检验结果") + "</th><th></th><th>" + mesLang("备注") + "</th>"
                + (name === 'Material_IQCFormView' ? "" : "<th name='delId' style='color: #0066CC; cursor: pointer; ' onclick='AddCheckItem(" + head.InspectionTemplateId + ")'>+" + mesLang("添加检验项") + "</th>") + "</tr>";
            for (var j = 0; j < Dtllist.length; j++) {
                var tempList = {};
                //tempList.InspectionId = InspectionId;
                tempList.InspectionNo = $("#spanInspectionOrderNo").html();
                tempList.InspectionTemplateId = InspectionTemplateId;
                tempList.InspectionTemplateMemberId = Dtllist[j].InspectionTemplateMemberId; //modify by wenshun  on 2021-03-03, 以前的Prod_InspectionIQCInputGRNInfo结果项中的InspectionTemplateMemberId是检验项ID，现在增加检验项ID，InspectionTemplateMemberId对应Prod_InspectionTemplateItem.InspectionTemplateMemberId
                tempList.Value = Dtllist[j].InspectionMethodValue;
                //tempList.IsSave = 1;
                //tempList.Result = 0;
                //tempList.Remark = "";
                tempList.CreateBy = userName;
                //tempList.CreateDateTime = "";
                //tempList.IQCInputGRNList = [];
                //IQCModelList.push(tempList);
                //保存检验项, 现在检验项在获取之前就已经保存了，为了简化调用后台的次数
                //var ajax = SKT.LeanMES.Web.AjaxServices.AjaxInspection.InsertIQCInputGRNInfo(tempList);
                //if (ajax.error != null) {
                //    alert(ajax.error.Message);
                //    return;
                //}

                //模板-检验项-Id, 检验项结果Id，结果，文件路径都在上次查询的结果中
                var IQCTemplateItemId = Dtllist[j].Pid;//检验项的结果ID：Prod_InspectionIQCInputGRNInfo.ID
                var Result = parseInt(Dtllist[j].Result);//0是没结果，1是NG，2是OK，3是NA
                var FileUrl = Dtllist[j].FilePath;
                var InspectionItemId = Dtllist[j].InspectionItemId;
                if (Result == 1) {
                    IsNG++;
                }
                Dtllist[j].CountRow = moCount;
                //复制
                var en = {}, eItem = JSON.stringify(Dtllist[j]);
                $.extend(en, Dtllist[j]);
                en.CheckResult = Dtllist[j].CheckResult === "" ? null : Dtllist[j].CheckResult;
                listItem.push(en);

                //检验项目
                InsItemNamestr = Dtllist[j].IsCustom === 1 ? ("<input type='text' IsRequired='1' style='width:80%' value='" +
                        Dtllist[j].InspectionItemName + "' onchange='ChangeInsItemName(" + moCount + ", $(this))'/><em>*</em>")
                    : Dtllist[j].InspectionItemName;
                //判断标准
                InspectionMethodValue = Dtllist[j].IsCustom === 1 ? ("<input type='text' style='width:80%' IsRequired='1' value='" +
                        Dtllist[j].InspectJuge + "' onchange='ChangeJuge(" + moCount + ", $(this))'/><em>*</em>") : Dtllist[j].InspectionMethodValue;
                //检验方法
                CheckFashion = Dtllist[j].IsCustom === 1 ? ("<input type='text' style='width:80%' IsRequired='1' value='" +
                        Dtllist[j].InspectionAccording + "' onchange='ChangeInsAccording(" + moCount + ", $(this))'/><em>*</em>") : Dtllist[j].CheckFashion;


                html += "<tr name='TempLateTr' class='ListTableOddRow' id='" + IQCTemplateItemId + "'><td name='tdIndex' style='text-align:center; width:4%'>" + (j + 1).toString() + "</td>"
                                    + "<td style='text-align:left; width:15%' name='" + IQCTemplateItemId + "'>" + InsItemNamestr + "</td>"
                                    + "<td style='text-align:left; width:10%'>" + (Dtllist[j].InspectionMethodId == 1 ? "固定值结果" : "指定值") + "</td>"
                                    + "<td style='text-align:left; width:10%' name='tdMethodValue' >" + InspectionMethodValue + "</td>"
                                    + "<td style='text-align:left; width:5%' name='tdUnitName'><span>" + Dtllist[j].UnitName + "</span><input name='txtOffsetUnit' type='hidden' value='" + Dtllist[j].OffsetUnitName + "' /></td>"
                                    + "<td style='text-align:left; width:15%'>" + CheckFashion + "</td>"

                var downloadShow = "";
                if (FileUrl == "#") {
                    downloadShow = "display:none";
                } else {
                    var n = FileUrl.lastIndexOf("/");
                    FileUrl = GetFilePath("InspectionFile", FileUrl.substring(n + 1, FileUrl.length));
                }
                var uploadHtml = '<table class="noBody"><tr><td><input type="file" name="ipfileUpload" id="fileUpload' + IQCTemplateItemId + '" /></td><td style="' + downloadShow + '"><a name="downloadFile" href="' + FileUrl + '" style=\"CURSOR: pointer; COLOR: #0000ff;' + downloadShow + '\" onclick="downloadFile(this)"><span style="font-size:12px;">下载</span></a></td> ';

                if (Dtllist[j].InspectionMethodId == 2) {
                    html += "<td style='text-align:left; width:15%'><label " + (Result === 2 ? "style='background-color:#ACBAD4'" : "") + "><input id='cbOK" + moCount + "' type='radio' name='OkNgRa" + moCount + "'  disabled='disabled' "
                        + (Result === 2 ? " checked='checked'" : "") + "  />OK</label>&nbsp;&nbsp;"

                    + "<label " + (Result === 1 ? "style='background-color:#ACBAD4'" : "") + "><input id='cbNG" + moCount + "' type='radio' name='OkNgRa" + moCount + "'  disabled='disabled' " + (Result === 1 ? "checked='checked'" : "")
                    + "  />NG</label>&nbsp;&nbsp;" +
                            "<label " + (Result === 3 ? "style='background-color:#ACBAD4'" : "") + "><input id='cbNA" + moCount + "' type='radio' name='OkNgRa" + moCount + "'"
                        + (Result === 3 ? " checked='checked'" : " ") + " ischeck='" + (Result == 3 ? "1" : "0") + "' />N/A</label></td>"
                        + "<td style='text-align:center; width:8%'><input type='button' class='result-entry' value='" + mesLang("结果录入") + "' onclick='InputGRNResult(this)' /></td>"  //即使查看也可以点击结果录入，只是不能修改结果
                    + "<td style='text-align:center; width:10%'><input type='text' name='inputRemark' value='" + Dtllist[j].Remark + "' onchange='UpdateRemark(this," + IQCTemplateItemId + ")' /></td>"
                    + (name == 'Material_IQCFormView' ? "" : "<td name='trHandle' style='text-align:center; width:12%'>" + uploadHtml + "<td><span style=\"CURSOR: pointer; COLOR: #0000ff;\" onclick=\"deleteItem('" + InspectionItemId + "','" + InspectionTemplateId + "', $(this), '" + InsItemNamestr + "')\"><%= Resources.Buttons.COM_Delete %></span></td></tr></table></td>")
                    + "<tr>";
                } else {
                    html += "<td style='text-align:left; width:15%'><label " + (Result === 2 ? "style='background-color:#ACBAD4'" : "") + "><input id='cbOK" + moCount + "' type='radio' name='OkNgRa" + moCount + "'"
                            + (Result === 2 ? " checked='checked'" : " ") + "  />OK</label>&nbsp;&nbsp;"

                        + "<label " + (Result === 1 ? "style='background-color:#ACBAD4'" : "") + "><input id='cbNG" + moCount + "' type='radio' name='OkNgRa" + moCount + "' " + (Result === 1 ? "checked='checked'" : "")
                            + "  />NG</label>&nbsp;&nbsp;" +
                            "<label " + (Result === 3 ? "style='background-color:#ACBAD4'" : "") + "><input id='cbNA" + moCount + "' type='radio' name='OkNgRa" + moCount + "'"
                            + (Result === 3 ? " checked='checked'" : " ") + "  ischeck='0' />N/A</label></td>"
                        + "<td style='text-align:center; width:8%'></td>"
                        + "<td style='text-align:center; width:10%'><input type='text' name='inputRemark'  value='" + Dtllist[j].Remark + "' onchange='UpdateRemark(this," + IQCTemplateItemId + ")'  /></td>"
                        + (name == 'Material_IQCFormView' ? "" : "<td name='trHandle' style='text-align:center; width:12%'>" + uploadHtml + "<td><span name='DeleteItem' style=\"CURSOR: pointer; COLOR: #0000ff;\" onclick=\"deleteItem('" + InspectionItemId + "','" + InspectionTemplateId + "', $(this), '" + InsItemNamestr + "')\"><%= Resources.Buttons.COM_Delete %></span></td></tr></table></td>")
                        + "<tr>";
                }
                //加载出来的项不需要删除按钮，新增的项加删除按钮
                //DelRow = name === 'Material_IQCFormView' ? "" :
                //("<td style='text-align:center; width:5%'>" +
                //    (Dtllist[j].IsCustom === 1 ? "<span style=\"CURSOR: pointer; COLOR: #0000ff;\" onclick=\"deleteItem(" + moCount + ", $(this))\"><%= Resources.Buttons.COM_Delete %></span>" : "") + "</td>");

                moCount++;
            }
            html += "</table>";
            $("#divDtl").append(html);

            if (IsNG >= head.REValue) {
                $("#cbFormOK").prop("checked", false)
                $("#cbFormNG").prop("checked", true);
            }
            //else {
            //    $("#cbFormOK").prop("checked", true);
            //}
            //if($("#divDtl tr[name='TempLateTr'] input[type='checkbox']:checked").length)
        }
        //GRN输入
        function InputGRNResult(data) {

            $(data);
            //var list = "";
            //for (var i = 0; i < IQCInputGRNList.length; i++) {
            //    if (IQCInputGRNList[i].InspectionTemplateMemberId == $(data).parent().parent().find("td:eq(1)").attr("name")
            //        && IQCModelList[i].InspectionTemplateId == $(data).parent().parent().parent().parent().prev().find("tr:eq(0)").attr('id')) {
            //        list = JSON.stringify(IQCInputGRNList[i]);
            //    }
            //}
            var isView = name == 'Material_IQCFormView' ? 1 : 0;
            if (isInspectionStart == 0 || VerifyUser != "" || InspectionResult >= 0 || name == 'Material_IQCFormView') {
                isView = 1;
            }
            var str = "InspectionItemName=" + escape($(data).parent().parent().find("td:eq(1)").html())
                    + "&InspectionItemId=" + escape($(data).parent().parent().find("td:eq(1)").attr("name"))
                            + "&InspectionMethodName=" + escape($(data).parent().parent().find("td:eq(2)").html())
                        + "&InspectionMethodValue=" + escape($(data).parent().parent().find("td:eq(3)").html())
            + "&UnitName=" + escape($(data).parent().parent().find("td:eq(4) span").html())
            + "&OffsetUnitName=" + escape($(data).parent().parent().find("td:eq(4) input").val())
            + "&CheckFashion=" + escape($(data).parent().parent().find("td:eq(5)").html())
            + "&Sum=" + escape($(data).parent().parent().parent().parent().prev().find("th:eq(4)").html())
                + "&AcRc=" + escape($(data).parent().parent().parent().parent().prev().find("th:eq(6)").html())
                + "&InspectionNo=" + escape($("#spanInspectionOrderNo").html())
                + "&InspectionId=" + escape(InspectionId)
             + "&IQCStatus=" + escape(IQCStatus)
                + "&InspectionTemplateId=" + escape($(data).parent().parent().parent().parent().prev().find("tr:eq(0)").attr('id'))
            var openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Quality/InspectionInputGRN1.aspx?name=InspectionInputGRN&isView=" + isView + "&" + str;
            dialog({ title: "<%=Resources.Pages.InspectionItem %>", src: openWinUrl, width: 900, height: 800 });
        }

        function SetMehodValue(data, templateItemId, templateId, unitName, offSetUnitName) {
            data = data.replace('&gt;', ">");
            data = data.replace('&lt;', "<");

            $("#tbDtl" + templateId + " #" + templateItemId).find("td[name='tdMethodValue']").text(data);
            $("#tbDtl" + templateId + " #" + templateItemId).find("td:eq(4) span").html(unitName);
            $("#tbDtl" + templateId + " #" + templateItemId).find("td:eq(4) input").val(offSetUnitName);
        }

        function SetUnitValue(data, templateItemId, templateId) {
            data = data.replace('&gt;', ">");
            data = data.replace('&lt;', "<");

            $("#tbDtl" + templateId + " #" + templateItemId).find("td[name='tdUnitName']").text(data);
        }

        //检验结果反馈
        function InputGRNResultBckFunction(result) {
            closeDialog();
            $("#tbDtl4").find("#31")
            $("#" + result.InspectionItemId).find("input[type='radio']:eq(2)").attr("disabled", "disabled");

            $("#" + result.InspectionItemId).find("label").css('background', '#fff');
            $("#" + result.InspectionItemId).find("input[name='inputRemark']").val(result.Remark);

            if (result.result == "OK") {
                //$("#tbDtl" + result.InspectionTemplateId).find("#" + result.InspectionItemId).find("input[type='radio']:eq(0)").attr("checked", true);
                $("#" + result.InspectionItemId).find("input[type='radio']:eq(0)").prop("checked", true);
                $("#" + result.InspectionItemId).find("label:eq(0)").css('background', '#ACBAD4');
                //if ($("#cbFormOK").attr('checked') == null && $("#cbFormNG").attr('checked') == null) {
                //    $("#cbFormOK").prop("checked", true);
                //}
                if ($("tr[name='TempLateTr'] input[type='radio']:checked").length > 0) {
                    $("#cbFormOK").prop("checked", true)
                    $("#cbFormNG").prop("checked", false);
                    for (var i = 0; i < $("tr[name='TempLateTr'] input[type='radio']:checked").length; i++) {
                        var $_radio = $($("tr[name='TempLateTr'] input[type='radio']:checked")[i]);
                        if ($_radio.attr("id").toString().indexOf("NG") != -1) {
                            $("#cbFormOK").prop("checked", false);
                            $("#cbFormNG").prop("checked", true);
                            return false;
                        }

                    }
                }
            } else {
                //$("#tbDtl" + result.InspectionTemplateId).find("#" + result.InspectionItemId).find("input[type='radio']:eq(1)").attr("checked", true);
                $("#" + result.InspectionItemId).find("input[type='radio']:eq(1)").prop("checked", true);
                $("#" + result.InspectionItemId).find("label:eq(1)").css('background', '#ACBAD4');
                $("#cbFormOK").prop("checked", false)
                $("#cbFormNG").prop("checked", true);

            }

            //模板检验结果判断
            //if (result == "NG") {
            //    $("#cbFormOK").attr("checked", false)
            //    $("#cbFormNG").attr("checked", true);
            //} else {
            //    if ($("#cbFormOK").attr('checked') == null && $("#cbFormNG").attr('checked') == null) {
            //        $("#cbFormOK").attr("checked", true);
            //    }
            //}

            //var Number = 0;
            //var Pd = $($("#" + result.InspectionItemId).parent().parent().find("tr"));
            //var trs = $($("#" + result.InspectionItemId).parent().parent().find("tr[name='TempLateTr']"));
            //var AcRc = $($("#" + result.InspectionItemId).parent().parent().prev()).find("tr:eq(1) th:eq(5)").html();
            //var judgeValue = $.trim(AcRc.split('/')[1].substr(4, 3));

            //for (var i = 0; i < trs.length; i++) {
            //    if ($(trs[i]).find("input[type='checkbox']:checked").parent().text() == "NG") {
            //        Number++;
            //    }
            //}
            /////有一个模板NG IQC单据NG
            //if (Number >= judgeValue) {
            //    $("#cbFormOK").attr("checked", false)
            //    $("#cbFormNG").attr("checked", true);
            //} else {
            //    if ($("#cbFormOK").attr('checked') == null && $("#cbFormNG").attr('checked') == null) {
            //        $("#cbFormOK").attr("checked", true);
            //    }
            //}
            //else {
            //    $("#cbFormOK").attr("checked", true);
            //}
            //IQCInputGRNList.push(result.list);
            //for (var i = 0; i < IQCModelList.length; i++) {
            //    if (IQCModelList[i].InspectionTemplateMemberId == result.InspectionItemId && IQCModelList[i].InspectionTemplateId == result.InspectionTemplateId) {
            //        IQCModelList[i].Result = Result;
            //        IQCModelList[i].IQCInputGRNList = result.list;
            //    }
            //}

        }


        //检验结果选择改变
        function ChangeResult(rowCount, t) {
            var cb = ($(t).attr('id').substr(0, 4) == "cbOK" ? "cbNG" : "cbOK") + rowCount;
            if ($(t).attr('checked') === "checked") {
                $("#" + cb).removeAttr('checked');
            } else {
                $("#" + cb).attr("checked", true);
            }

            $.grep(listItem, function (o, j) {
                if (o.CountRow === rowCount) {
                    o.CheckResult = $("#cbOK" + rowCount).attr('checked') ? 1 : ($("#cbNG" + rowCount).attr('checked') ? 0 : null);
                };
            });

        }

        //描述
        function ChangeDesc(rowCount, t) {
            $.grep(listItem, function (o, j) {
                if (o.CountRow === rowCount) {
                    o.Discretion = $(t).val();
                };
            });
        }

        //检验项名称
        function ChangeInsItemName(rowCount, t) {
            $.grep(listItem, function (o, j) {
                if (o.CountRow === rowCount) {
                    o.InspectionItemName = $(t).val();
                };
            });
        }

        //判定标准
        function ChangeJuge(rowCount, t) {
            $.grep(listItem, function (o, j) {
                if (o.CountRow === rowCount) {
                    o.InspectJuge = $(t).val();
                };
            });
        }
        //检验方法
        function ChangeInsAccording(rowCount, t) {
            $.grep(listItem, function (o, j) {
                if (o.CountRow === rowCount) {
                    o.InspectionAccording = $(t).val();
                };
            });
        }

        var TemplateId = 0;
        //添加额外检验项
        function AddCheckItem(InspectionTemplateId) {
            if (isInspectionStart == 0 || VerifyUser != "" || InspectionResult >= 0) {
                return;
            }

            TemplateId = InspectionTemplateId;

            var openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Quality/InspectionItemDialog.aspx?name=QC_InspectionItemDialog&controlId=controlId";
            dialog({ title: "<%=Resources.Pages.InspectionItem %>", src: openWinUrl, width: 255, height: 350 });
        }


        //添加额外检验项进行赋值
        function SetValue(list) {
            closeDialog();

            var InspectionTemplateId = ""; InspectionItemId = ""; html = "";
            InspectionTemplateId = TemplateId;
            var tab = $("#tbDtl" + InspectionTemplateId);
            var tblength = $("#tbDtl" + InspectionTemplateId + " tr").length;

            for (k = 0; k < list.length; k++) {
                if ($("#tbDtl" + InspectionTemplateId + " tr td[key='tb" + list[k].InspectionItemId + "'").length > 0) {
                    alert("选择的检验(" + list[k].InspectionItemName + ")已经存在,请重新选择");
                    return;
                }
            }

            for (i = 0; i < list.length; i++) {
                InspectionItemId = list[i].InspectionItemId;
                InspectionNo = $("#spanInspectionOrderNo").html();

                //保存检验项
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxInspection.InsertInspectionTemplateItem(InspectionNo, parseInt(InspectionTemplateId), parseInt(InspectionItemId), userName);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return;
                }
                var entity = ajax.value;
                //模板-检验项-Id
                var IQCTemplateItemId = entity.Pid;//检验项的结果ID：Prod_InspectionIQCInputGRNInfo.ID
                var Result = entity.Result;//0是没结果，1是NG，2是OK，3是NA                

                //var moCount = 1;
                //if (tblength > 1) {
                //    moCount = parseInt($.trim($("#tbDtl" + InspectionTemplateId).find("tr td[name='tdIndex']:last").html())) + 1;
                //}

                var uploadHtml = '<table class="noBody"><tr><td><input type="file" name="ipfileUpload" id="fileUpload' + IQCTemplateItemId + '" /></td><td style="display:none"><a name="downloadFile" href="#" style=\"CURSOR: pointer; COLOR: #0000ff;display:none\" onclick="downloadFile(this)"><span style="font-size:12px;">下载</span></a></td> ';
                html += "<tr name='TempLateTr' class='ListTableOddRow' id='" + IQCTemplateItemId + "'><td name='tdIndex' style='text-align:center; width:4%'>" + moCount.toString() + "</td>"
                                    + "<td style='text-align:left; width:15%' name='" + IQCTemplateItemId + "' key='tb" + InspectionItemId + "' >" + entity.InspectionItemName + "</td>"
                                    + "<td style='text-align:left; width:10%'>" + (entity.InspectionMethodId == 1 ? "固定值结果" : "指定值") + "</td>"
                                    + "<td style='text-align:left; width:10%' name='tdMethodValue' >" + entity.InspectionMethodValue + "</td>"
                                    + "<td style='text-align:left; width:5%' name='tdUnitName'><span>" + entity.UnitName + "</span><input name='txtOffsetUnit' type='hidden' value='" + entity.OffsetUnitName + "' />" + "</td>"
                                    + "<td style='text-align:left; width:15%'>" + entity.CheckFashion + "</td>"

                if (entity.InspectionMethodId == 2) {
                    html += "<td style='text-align:left; width:15%'><label " + (Result === 2 ? "style='background-color:#ACBAD4'" : "") + "><input id='cbOK" + moCount + "' type='radio' name='OkNgRa" + moCount + "'  disabled='disabled' "
                        + (Result === 2 ? " checked='checked'" : "") + "  />OK</label>&nbsp;&nbsp;"

                    + "<label " + (Result === 1 ? "style='background-color:#ACBAD4'" : "") + "><input id='cbNG" + moCount + "' type='radio' name='OkNgRa" + moCount + "'  disabled='disabled' " + (Result === 1 ? "checked='checked'" : "")
                    + "  />NG</label>&nbsp;&nbsp;" +
                            "<label " + (Result === 3 ? "style='background-color:#ACBAD4'" : "") + "><input id='cbNA" + moCount + "' type='radio' name='OkNgRa" + moCount + "'"
                            + (Result === 3 ? " checked='checked'" : " ") + " ischeck='0' />N/A</label></td>"
                        + "<td style='text-align:center; width:8%'><input type='button' class='result-entry' value='" + mesLang("结果录入") + "' onclick='InputGRNResult(this)' /></td>"
                   + "<td style='text-align:center; width:10%'><input type='text' name='inputRemark' value='" + entity.Remark + "' onchange='UpdateRemark(this," + IQCTemplateItemId + ")' /></td>"
                    + "<td name='trHandle' style='text-align:center; width:12%'>" + uploadHtml + "<td><span style=\"CURSOR: pointer; COLOR: #0000ff;\" onclick=\"deleteItem('" + InspectionItemId + "','" + InspectionTemplateId + "', $(this), '" + entity.InspectionItemName + "')\" ><%= Resources.Buttons.COM_Delete %></span></td></tr></table></td><tr>";
                } else {
                    html += "<td style='text-align:left; width:15%'><label " + (Result === 2 ? "style='background-color:#ACBAD4'" : "") + "><input id='cbOK" + moCount + "' type='radio' name='OkNgRa" + moCount + "'"
                            + (Result === 2 ? " checked='checked'" : " ") + "  />OK</label>&nbsp;&nbsp;"

                        + "<label " + (Result === 1 ? "style='background-color:#ACBAD4'" : "") + "><input id='cbNG" + moCount + "' type='radio' name='OkNgRa" + moCount + "' " + (Result === 1 ? "checked='checked'" : "")
                            + "  />NG</label>&nbsp;&nbsp;" +
                            "<label " + (Result === 3 ? "style='background-color:#ACBAD4'" : "") + "><input id='cbNA" + moCount + "' type='radio' name='OkNgRa" + moCount + "'"
                            + (Result === 3 ? " checked='checked'" : " ") + "  ischeck='0' />N/A</label></td>"
                        + "<td style='text-align:center; width:8%'></td>"
                          + "<td style='text-align:center; width:10%'><input type='text' name='inputRemark' value='" + entity.Remark + "' onchange='UpdateRemark(this," + IQCTemplateItemId + ")'  /></td>"
                        + "<td name='trHandle' style='text-align:center; width:12%'>" + uploadHtml + "<td><span name='DeleteItem' style=\"CURSOR: pointer; COLOR: #0000ff;\" onclick=\"deleteItem('" + InspectionItemId + "','" + InspectionTemplateId + "', $(this), '" + entity.InspectionItemName + "')\"><%= Resources.Buttons.COM_Delete %></span></td></tr></table></td><tr>";
                }
                moCount ++
            }
            tab.append(html);

            if ($("#cbFormOK").prop('checked') == true) {
                $("#cbFormOK").prop("checked", false);
            }
            //动态绑定事件
            //$(document).on("click", "input[type='radio']:not(:disabled)", function () {
            //    checkBoxClick(this);
            //});
            UpLoad();
            TemplateId = 0;
        }

        function UpLoad() {
            var username = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';
            $("input[name=ipfileUpload]").each(function () {
                var id = $(this).parent().parent().parent().parent().parent().parent().attr("id");
                var InspectionItemName = $.trim($(this).parent().parent().parent().parent().parent().parent().find("td:eq(1)").text());
                $(this).uploadfile({
                    uploader: '<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Handler/UploadHander.ashx',
                    fileSizeLimit: 10,
                    buttonText: "上传报告",
                    formData: function () {
                        return {
                            'Action': 'CheckItemFileUpload', "Id": id, "userName": username
                        };
                    },
                    //上传成功时执行
                    onUploadSuccess: function (file, data) {

                        var data = $.parseJSON(data);
                        if (data.code == 1) {
                            alert(data.msg);
                            return;
                        }
                        var InspectionIQCInputGRNInfoId = id;
                        var ajax = SKT.LeanMES.Web.AjaxServices.AjaxInspection.GetInspectionIQCInputGRNInfo(InspectionIQCInputGRNInfoId);
                        if (ajax.error != null) {
                            alert(ajax.error.Message);
                            return;
                        }
                        var IQCTemplateItemId = ajax.value.Pid;//检验项的结果ID：Prod_InspectionIQCInputGRNInfo.ID                        
                        var FileUrl = ajax.value.FilePath;
                        var InspectionItemId = ajax.value.InspectionItemId;
                        var InspectionTemplateId = ajax.value.InspectionTemplateId;
                        var n = FileUrl.lastIndexOf("/");
                        FileUrl = GetFilePath("InspectionFile", FileUrl.substring(n + 1, FileUrl.length));
                        var uploadHtml = '<table class="noBody"><tr><td><input type="file" name="ipfileUpload" id="fileUpload' + IQCTemplateItemId + '" style="width: 35px;" /></td>';
                        uploadHtml += '<td><a name="downloadFile" href="' + FileUrl + '" style=\"CURSOR: pointer; COLOR: #0000ff;\" onclick="downloadFile(this)"><span style="font-size:12px;">下载</span></a></td> ';
                        uploadHtml += '<td><span style=\"CURSOR: pointer; COLOR: #0000ff;\" onclick=\"deleteItem(\'' + InspectionItemId + '\',\'' + InspectionTemplateId + '\', $(this), \'' + InspectionItemName + '\')\"><%= Resources.Buttons.COM_Delete %></span></td></tr></table>';

                        $("#" + id).find("td[name='trHandle']").html(uploadHtml);
                        UpLoad();
                        FileShow();
                        alert("上传成功");
                    },
                    //上传错误信息
                    onUploadError: function (file, text) {
                        alert(text);
                    }
                });
            });
        }

        function downloadFile(obj) {

        }

        //删除检验项行
        function deleteItem(InspectionItemId, InspectionTemplateId, t, InspectionItemName) {
            if (isInspectionStart == 0 || VerifyUser != "" || InspectionResult >= 0) {
                return;
            }
            if (window.confirm("是否要删除检验项(" + InspectionItemName + ")")) {
                //保存检验项
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxInspection.DeleteInspectionTemplateItem(parseInt(InspectionTemplateId), parseInt(InspectionItemId));
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return;
                }

                $(t).parent().parent().parent().parent().parent().parent().remove();
            }
        }

        //动态绑定事件
        $(document).on("click", "input[type='radio']:not(:disabled)", function () {
            checkBoxClick(this);
        });

        function checkBoxClick(obj) {
            var $_input = $(obj);
            var $_tr = $_input.parent().parent().parent();
            var $_lbl = $_input.parent();
            var Status = 0;

            $_tr.find("input[type='text'],input[type='button']").removeAttr("disabled");

            $_tr.find("label").css('background', '#fff');
            $_lbl.css('background', '#ACBAD4');

            //点击的NG  IQC检验单判为NG
            if ($_input.attr("id").toString().indexOf("NG") != -1) {
                Status = 1;
                $_input.parent().parent().find("input[type='radio']").attr("ischeck", 0);
                $("#cbFormOK").prop("checked", false);
                $("#cbFormNG").prop("checked", true);

            } else if ($_input.attr("id").toString().indexOf("OK") != -1) {
                Status = 2;
                $_input.parent().parent().find("input[type='radio']").attr("ischeck", 0);
                //如果 是第一次点击OK 判为OK
                if ($("#cbFormOK").prop('checked') == false && $("#cbFormNG").prop('checked') == false) {
                    $("#cbFormOK").prop("checked", true);
                    $("#cbFormNG").prop("checked", false);
                } else if ($("#cbFormNG").prop('checked') == false) {//如果当前IQC检验单是OK ，判为OK;
                    $("#cbFormOK").prop("checked", true);
                    $("#cbFormNG").prop("checked", false);
                } else if ($("tr[name='TempLateTr'] input[type='radio']:checked").length <= 1) {
                    $("#cbFormOK").prop("checked", true);
                    $("#cbFormNG").prop("checked", false);
                }

                var flags = true;
                var radioLen = $("input[type='radio']:checked:not([ischeck='1'])").length;

                for (var i = 0; i < radioLen; i++) {
                    if ($($("input[type='radio']:checked:not([ischeck='1'])")[i]).attr("id").toString().indexOf("NG") != -1) {
                        flags = false;
                        break;
                    }
                }
                if (flags) {
                    $("#cbFormOK").prop("checked", true);
                    $("#cbFormNG").prop("checked", false);
                }
            }
            else if ($_input.attr("id").toString().indexOf("NA") != -1) {
               // Status = 3;
                var isChecked = $_input.attr("ischeck");
                //var isChecked = $_input.val() == "on" ? 1 : 0;

                //if (isChecked == "1") {
                //    $_input.prop("checked", false);
                //    $_tr.find("input[type='text'],input[type='button']").removeAttr("disabled");
                //    $_input.attr("ischeck", 0);
                //    Status = -1;//全部没有选择
                //}
                //else {
                //    $_tr.find("input[type='text'],input[type='button']").attr("disabled", "disabled");
                //    $_input.attr("ischeck", 1);
                //}

                //var radioLen = $("input[type='radio']:checked:not([ischeck='1'])").length;
                //var ngLen = $("input[type='radio'][id *= 'NG' ]:checked").length;
                //var okLen = $("input[type='radio'][id *= 'OK' ]:checked").length;

                //if (ngLen == 0 && okLen == 0) {
                //    $("#cbFormOK").prop("checked", false);
                //    $("#cbFormNG").prop("checked", false);
                //}
                //else if (ngLen == 0 && okLen > 0) {
                //    $("#cbFormOK").prop("checked", true);
                //    $("#cbFormNG").prop("checked", false);
                //}
                //else if (ngLen > 0) {
                //    $("#cbFormOK").prop("checked", false);
                //    $("#cbFormNG").prop("checked", true);
                //}
                if (isChecked == "1") {
                    $_input.prop("checked", false);
                    $_lbl.siblings("td").find("input[type='text'],input[type='button']").prop("disabled", false);
                    $_tr.find(".result-entry").prop("disabled", false);
                    $_input.attr("ischeck", 0);
                    Status = 0;
                    $_tr.find("label").css('background', '#fff');
                }
                else {
                    $_lbl.siblings("td").find("input[type='text'],input[type='button']").prop("disabled", true);
                    $_tr.find(".result-entry").prop("disabled", true);
                    $_input.attr("ischeck", 1);
                    Status = 3;
                }
                //if (isChecked == 1) {

                //    $_tr.find("input[type='text'],input[type='button']").attr("disabled", "disabled");
               //     $_input.attr("ischeck", 1);
               // }
               // else {
              //      $_input.prop("checked", false);
               //     $_tr.find("input[type='text'],input[type='button']").removeAttr("disabled");
               //     $_input.attr("ischeck", 0);
               //     Status = -1;//全部没有选择                   
              //  }

                var radioLen = $("input[type='radio']:checked:not([ischeck='1'])").length;
                var ngLen = $("input[type='radio'][id *= 'NG' ]:checked").length;
                var okLen = $("input[type='radio'][id *= 'OK' ]:checked").length;
                var naLen = $("input[type='radio'][id *= 'NA' ]:checked").length;

                if (ngLen == 0 && okLen == 0 && naLen == 0) {
                    $("#cbFormOK").prop("checked", false);
                    $("#cbFormNG").prop("checked", false);
                }
                else if (ngLen == 0 && okLen > 0) {
                    $("#cbFormOK").prop("checked", true);
                    $("#cbFormNG").prop("checked", false);
                }
                else if (ngLen > 0) {
                    $("#cbFormOK").prop("checked", false);
                    $("#cbFormNG").prop("checked", true);
                }
            }
            else {
                Status = -1;//全部没有选择
            }
            //更改细项状态
            var id = $($_input.parents()[2]).attr("id");

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxInspection.UpdateFixedInspectionItem(id, Status);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return;
            }
        }

        //保存检验信息
        function SaveForm() {
            
            //判断是否所有检验项都完成了检验
            //for (var i = 0; i < $("tr[name='TempLateTr'] input[type='radio']").length; i++) {
            //    var $_tr = $($("tr[name='TempLateTr'] input[type='radio']")[i]);
            //    if ($_tr.attr("checked") == null) {
            //        alert("请完成所有检验项的检验");
            //        return false;
            //    }
            //}
            //限制不可全部为免检
            var len = $("tr[name='TempLateTr']").length;
            var qty = 0;
            for (var i = 0; i < len; i++) {
                var $_tr = $($("tr[name='TempLateTr']")[i]);
                var radio1 = $($("tr[name='TempLateTr']")[i]).find("td:eq(6) input:eq(0):checked").val();
                var radio2 = $($("tr[name='TempLateTr']")[i]).find("td:eq(6) input:eq(1):checked").val();
                var radio3 = $($("tr[name='TempLateTr']")[i]).find("td:eq(6) input:eq(2):checked").val();
                if (radio1 == undefined && radio2 == undefined && radio3 != "on") {
                    alert("请完成所有检验项的检验");
                    return false;
                }
                if (radio3 == "on") {
                    qty += 1;
                }
            }
            if (qty == len) {
                alert("不允许所有检验项目全部免检，至少要检验一项！");
                return false;
            }
            var entity = {};
            if ($("#cbFormOK").prop('checked') == false && $("#cbFormNG").prop('checked') == false) {
                alert("请进行检验后在点击保存按钮");
                //alert("请输入实抽数量和不良数量后，回车后计算检验结果！");
                return false;
            }

            entity.InspectionId = InspectionId;
            entity.InspectionResult = $("#cbFormOK").prop('checked') ? 1 : ($("#cbFormNG").prop('checked') ? 0 : null);
            entity.InspectionUser = $.trim($("#txtCheck").val());
            entity.InspectionCode = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';
            entity.Auditing = "";//$.trim($("#txtSign").val());
            entity.PrintLv = $.trim($("#txtPrintLv").val());
            entity.Instrument = $.trim($("#txtInstrument").val());
            entity.Remark = $.trim($("#txtRemark").val());
            entity.ModifyBy = userName;
            //entity.CheckList = JSON.stringify(listItem);
            entity.ActualQty = 0//$("#txtActualQty").val();
            entity.NCQty = 0//$("#txtNCQty").val();
            //entity.IQCModelList = IQCModelList;
            //entity.IQCInputGRNList = IQCInputGRNList;
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxInspection.SaveIqcCheck(JSON.stringify(entity));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return;
            }
            alert("保存成功！");
            window.opener.Refresh();
            window.close();
        }

        //GRN不合格信息
        function GrnNg() {
            dialog({ title: "IQC记录GRN信息", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Quality/IQCFormBack.aspx?name=Material_IQCFormBack&ID=" + InspectionId + "&OrderStatue=" + OrderStatue + "&rnd=" + Math.random(), width: 750, height: 368 });
        }

        //
        function Refresh() {
            document.forms[0].submit();
        }
        //显示GRN信息
        function GRNInfoShow() {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxInspection.uspSearchIQCInputGRNInfo($("#spanInspectionOrderNo").html());
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return;
            }
            var data = ajax.value;
            var strhtml = "";
            for (var i = 0; i < data.length; i++) {
                if (i % 2 == 0) {
                    strhtml += "<tr class='ListTableOddRow'>";
                } else {
                    strhtml += "<tr class='ListTableEvenRow'>";
                }
                strhtml += "<td>" + (i + 1) + "</td>"
                        + "<td>" + data[i].POCode + "</td>"
                        + "<td>" + data[i].GRN + "</td>"
                        + "<td>" + data[i].BalanceQty + "</td>"
                        + "<td>" + data[i].ItemCode + "</td>"
                        + "<td>" + data[i].ItemName + "</td>"
                        + "<td>" + data[i].ItemSpec + "</td></tr>"
            }
            $("#GRNInfo tbody").append(strhtml);
        }
        function FileShow() {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialIQC.GetFileInfo($("#spanInspectionItemCode").html(), $.trim($("#spanInspectionOrderNo").html()), $.trim($("#inputVenCode").val()));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return;
            }
            var data = ajax.value;
            $("#FileInfo tbody").html("<tr class=\"ListTableHeader\">"
                + "<th>" + mesLang("序号") + "</th>"
                + "<th>" + mesLang("产品编码") + "</th>"
                + "<th>" + mesLang("供应商") + "</th>"
                + "<th>" + mesLang("文件名称") + "</th>"
                + "<th>" + mesLang("文件版本") + "</th>"
                + "<th>" + mesLang("文件类型") + "</th>"
                + "<th>" + mesLang("创建人") + "</th>"
                + "<th>" + mesLang("创建时间") + "</th>"
                + "<th>" + mesLang("下载") + "</th>"
            + "</tr>  ");
            for (var i = 0; i < data.length; i++) {
                var $tr = $("<tr class='ListTableOddRow'>"
                    + "<td>" + (i + 1) + "</td>"
                    + "<td>" + data[i].ItemCode + "</td>"
                    + "<td>" + data[i].SupplierName + "</td>"
                    + "<td>" + data[i].FileName + "</td>"
                    + "<td>" + data[i].FileVersion + "</td>"
                    + "<td>" + data[i].FileType + "</td>"
                    + "<td>" + data[i].CreateBy + "</td>"
                    + "<td>" + data[i].CreateDateTime + "</td>"
                    + "<td><a href='#' onclick=FileSave(this)><span style='font-size:12px;'>下载</span></a></td>"
                    + "</tr>");
                $("#FileInfo tbody").append($tr);
                $tr.data("FileSaveName", data[i].FileSaveName);
            }
        }


        function FileShipSave(el) {
            var fileName = $(el).parent().parent().data("FileSaveName");
            var path = GetFilePath("ShippingReport", fileName);
            window.open(path);
        }
        function FileTestSave(el) {
            var fileName = $(el).parent().parent().data("FileSaveName");
            var path = GetFilePath("TestReport", fileName);

            window.open(path);
        }

        function FileSave(el) {
            var fileName = $(el).parent().parent().data("FileSaveName");
            var path = GetFilePath("InspectionFile", fileName);

            window.open(path);
        }

       <%-- function FileSave(data) {
            var path = "";
            if (data.substr(0, 1) == "/") {
                path = data;
            }
            else {
                path = '<%=SKT.LeanMES.Web.WebHelper.InspectionFileRoot %>' + data;
            }
            
            window.open(path);
        }--%>
        function UploadDialog() {
            var openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Quality/InspectionFileManage.aspx?name=InspectionInputGRN";
            dialog({ title: "<%=Resources.Pages.InspectionItem %>", src: openWinUrl, width: 900, height: 800 });
        }
        /*
        *更新备注项
        */
        function UpdateRemark(obj, id) {
            var remark = $(obj).val();
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxInspection.UpdateInspectionItemRemark(id, remark);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return;
            }
        }

        //审核
        function Verify() {
            var entity = {};
            entity.InspectionId = IOrderId;
            entity.Auditing = $.trim($("#txtSign").val());
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialIQC.IQCVerify(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert("审核成功！");
            window.opener.Refresh();
            window.close();
        }

        function clearRadio(id) {
            $("#" + id).find('input[type="radio"]').prop('checked', false);

        }
    </script>
</asp:Content>
