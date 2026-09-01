<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="EquipmentMaintenance.aspx.cs" Inherits="SKT.LeanMES.Web.Equipment.EquipmentMaintenance" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <script src="../Content/plugin/tabs/jPlugin-tabs.js"></script>
    <link href="../Content/plugin/tabs/tabs.css" rel="stylesheet" />
    <link href="../Content/plugin/bootstrap/css/bootstrap.css" rel="stylesheet" />
    <style type="text/css">
        table .hide { display:none; }
    </style>
    <style type="text/css">
 #dialogUpdateAudit{display:none;}
</style> 
    <style type="text/css">
        .btn-view { font-size: 12px; }
        .td-upload a.btn { padding: 3px 20px; }
        .ListTableHeader th { background: none no-repeat #f5f5f5 }
        .uploadify-button { text-align: center; }
        #div-upload { overflow: hidden; }
        .file-input { width: 180px; position: absolute; left: -100px; top: 0; z-index: 1; -moz-opacity: 0; -ms-opacity: 0; -webkit-opacity: 0; opacity: 0; filter: alpha(opacity=0); cursor: pointer; }
    </style>
    <div style="margin-top: 15px; margin-bottom: 15px;">
        <div id="dialogUpdateAudit" title="设备报修">
        
    </div>
        <table class="EditeContentTable" width="100%">
            <tr>
                <td class="Label3">检验单号
                </td>
                <td class="Field3">
                    <asp:Label ID="lblInspectionNo" runat="server" ClientIDMode="Static"></asp:Label>
                </td>
                <td class="Label3">设备编码
                </td>
                <td class="Field3">
                    <asp:TextBox ID="txtEquipmentCode" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox><input type="button" class="ButtonBox" onclick="openChoosePage(54)" value="..." />
                </td>
                <td class="Label3">设备名称
                </td>
                <td class="Field3">
                    <asp:Label ID="EquipmentName" runat="server" ClientIDMode="Static"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="Label3">设备类型
                </td>
                <td class="Field3">
                    <asp:Label ID="lblEquipmentTypeName" runat="server" ClientIDMode="Static"></asp:Label>
                </td>
                <td class="Label3">周期类型
                </td>
                <td class="Field3">
                    <asp:DropDownList ID="Cycle" runat="server" ClientIDMode="Static">
                        <asp:ListItem Value="1">--小时--</asp:ListItem>
                        <asp:ListItem Value="2">--天--</asp:ListItem>
                        <asp:ListItem Value="3">--周--</asp:ListItem>
                        <asp:ListItem Value="4">--月--</asp:ListItem>
                        <asp:ListItem Value="5">--年--</asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td class="Label3">班次
                </td>
                <td class="Field3">
                    <asp:DropDownList ID="ddlWorkShift" runat="server" AutoPostBack="false" ClientIDMode="Static">
                        <asp:ListItem Value="1">白班</asp:ListItem>
                        <asp:ListItem Value="2">夜班</asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td class="Label3">检验人工号
                </td>
                <td class="Field3">
                    <asp:Label ID="lblInspectionUserNo" runat="server" ClientIDMode="Static"></asp:Label>
                </td>
                <td class="Label3">检验人姓名
                </td>
                <td class="Field3">
                    <asp:Label ID="lblInspectionUserName" runat="server" ClientIDMode="Static"></asp:Label>
                </td>
                <td class="Label3">检验时间
                </td>
                <td class="Field3">
                    <asp:Label ID="lblInspectionTime" runat="server" ClientIDMode="Static"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="Label3">检验结果
                </td>
                <td class="Field3">
                    <label style="color: Green; font-weight: bold;">
                        <input id='cbProductFormOK' type="checkbox" disabled="disabled" onchange='FinalResult(this)' /><span>合格</span></label>&nbsp;&nbsp;
                    <label style="color: Red; font-weight: bold;">
                        <input id='cbProductFormNG' type="checkbox" disabled="disabled" onchange='FinalResult(this)' /><span>不合格</span></label>
                </td>
                <%--<td class="Label3">文件编号
                </td>
                <td class="Field3">
                    <span id="FormCode"></span>
                </td>
                <td class="Label3">工序
                </td>
                <td class="Field3">
                    <asp:Label ID="lblStation" runat="server" ClientIDMode="Static"></asp:Label>
                </td>--%>
            </tr>
            <tr id="trSaveOrderBtn">
                <td class="Field3" colspan="6" style="text-align: center;">
                    <input type="button" value=" 无需检验 " class="btn btn-primary btn-sm maintenance-no" onclick=" if (SubmitValidation()) { SaveForm(0); }" style="margin-right: 10px; display: none;" />
                    <input type="button" value=" 检验完成 " class="btn btn-primary btn-sm maintenance-complete" onclick=" if (SubmitValidation()) { SaveForm(1); }" style="margin-right: 10px; display: none;" />
                     <input type="button" value=" 批量点检 " class="btn btn-primary btn-sm one-click-inspection" onclick=" if (SubmitValidation()) { BatchInspection(); }" style="margin-right: 10px; display: none;" />
                </td>
            </tr>
        </table>
    </div>
    <div class="wrap_tb" id="wrap_tb">
        <ul class="tb">
            <li class="current" id="Div1">检验明细</li>
        </ul>
        <div class="tb_c tb_content">
            <div id="divDtl">
                <table class="ListTable inspection-template" width="100%">
                    <thead>
                        <tr class="ListTableHeader">
                            <th rowspan="2">序号</th>
                            <th rowspan="2">检验项目</th>
                            <th rowspan="2" style="width: 20%;">检验方法</th>
                            <th rowspan="2">检验标准</th>
                            <th colspan="3" style="text-align: center; display: none;">输出</th>
                            <%--<th rowspan="2">检验数据</th>--%>
                            <%--<th rowspan="2">最大值</th>
                            <th rowspan="2">最小值</th>
                            <th rowspan="2">平均值</th>--%>
                            <th rowspan="2" style="width: 80px; max-width: 80px; overflow: hidden;">检验图片</th>
                            <th rowspan="2" style="width: 80px; max-width: 80px; overflow: hidden;">检验文件</th>
                            <th rowspan="2" style="width: 150px; max-width: 150px; overflow: hidden;">判定结果</th>
                            <th rowspan="2">不合格描述</th>
                            <th rowspan="2">记录时间</th>
                            <th rowspan="2">备注信息</th>
                            <th rowspan="2">参考图片</th>
                        </tr>
                        <tr class="ListTableHeader" style="display: none;">
                            <th>数据</th>
                            <th>图片</th>
                            <th>文件</th>
                        </tr>
                    </thead>
                    <tbody></tbody>
                </table>
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
    </div>
    
    <div style="display: none;">
        <%--<asp:FileUpload ID="fileBomUrl" ClientIDMode="Static" runat="server" onchange="uploadFile(this.value)" accept="image/*" />
        <asp:Button ID="btnUpload" runat="server" OnClick="Upload_Click" ClientIDMode="Static" Style="display: none;" />--%>
        <asp:HiddenField ID="hidInspectionId" runat="server" ClientIDMode="Static" />
        <asp:HiddenField ID="hidInspectionOrderOATemplateDetailId" runat="server" ClientIDMode="Static" />
        <asp:HiddenField ID="hidFileType" runat="server" ClientIDMode="Static" />
    </div>

    <%--
    --新版安卓不支持flash
    <div id="div-upload" style="position: relative; display: none;">
        <input type="file" name="fileUpload" id="fileUpload" />
    </div>--%>

    <%--文件上传--%>
    <div id="div-upload" style="position: relative; display: none;">
        <a class="btn btn-link"><span class="">上传</span></a>
        <input type="file" name="file" onchange="uploadFileFormData(this.value)" class="file-input" />
    </div>
    
    <script type="text/javascript" src="../Content/plugin/uploadify/jquery.uploadify.js"></script>

    <script type="text/javascript">
        var upurl = '<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Handler/UploadHander.ashx';
        $(function () {
            $("#form1").attr({ "method": "post", "onsubmit": "return upload(this)", "enctype": "multipart/form-data" });
        })

        function uploadFileFormData(filePath) {
            if (filePath.length > 0) {
                upload($("#form1")[0]);
                return false;
            }
        }

        function xhrupload(fd, url) {
            var xhr = new XMLHttpRequest();
            xhr.open("post", url, true);
            xhr.onreadystatechange = function () {
                if (xhr.readyState == 4) {
                    //清空上传文本框中的文件
                    $("#div-upload input[type=\"file\"]")[0].value = "";

                    if (200 == xhr.status) {
                        var entity = JSON.parse(xhr.responseText);
                        if (entity.code == 1) {
                            alert("上传失败！" + entity.msg);
                            return;
                        } else {
                            //上传成功后，可以查看、删除文件
                            var hl = "<a class=\"btn-view btn btn-link\"><span class=\"\">查看</span></a><a class=\"delete-upload btn btn-link\"><span class=\"\">删除</span></a>"
                            $("#div-upload").siblings("div").find("a.file-upload").nextAll().remove();
                            $("#div-upload").siblings("div").find("a.file-upload").after(hl);                            
                            $("#div-upload").closest("td").attr({ "fileNameServer": entity.data.FileName, "title": entity.data.FileName });
                            alert("上传成功");
                            return;
                        }
                    }
                    else {
                        alert('发生错误\nstatus:' + xhr.status + '\n返回内容:' + xhr.responseText);
                    }
                }
            }
            xhr.send(fd);
        }


        //报修
        function InputGRNRepair(idStr) {
            var url = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/EquipmentInspectionRepair.aspx?name=EquipmentInspectionRepair&ID=" + idStr;
            dialog({ title: "设备报修", src: url, width: 600, height: 400 });
        }

        function upload(f) {
            if (window.FormData) {
                var fd = new FormData();
                fd.append("Action", "EquipmentInspectionFile");
                fd.append("Filedata", f.file.files[0]);
                fd.append("InspectionId", $.trim($("#hidInspectionId").val()));
                fd.append("InspectionOrderOATemplateDetailId", $.trim($("#hidInspectionOrderOATemplateDetailId").val()));
                fd.append("fileType", $.trim($("#hidFileType").val()));
                fd.append("userName", userName);
                xhrupload(fd, upurl);
                return false;//阻止表单提交
            }
            else {
                alert('不支持html5 ajax上传！');
            }
            return false;
        }
    </script>

    <script type="text/javascript">
        var tab = document.getElementById("tblExpand");
        var pageName = '<%=Request["name"] %>'; //EquipmentMaintenanceView查看
        //var inspectionTypeId = '<%=Request["InspectionTypeId"]  %>';  //类型：-1：查看 0：生产检验 1：品质检验
        var InspectionId = parseInt("<%=Request["InspectionOrderId"]??"-1"  %>");    /*检验单ID*/
        var InspectionType = "<%=Request["InspectionType"] %>";   //检验类型：7：设备检验 12：设备点检
        var userName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
        var userCName = "<%= SKT.LeanMES.Web.AccountController.GetCurrentUser().EmployeeCName %>";
        var modifyBy = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
        var inspectionStatus = -1; //检验单状态 -1：待检验  0：无需检验  1：已检验
        var isFirst = true;

        function uploadFile(filePath) {
            if (filePath.length > 0) {
                $("#btnUpload").click();
            }
        }

        $(function () {
            $("#hidInspectionId").val(InspectionId);

            //设备编码回车事件
            $("#txtEquipmentCode").keydown(function (e) {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    if (InspectionType == 7) {
                        var cycle = $("#Cycle").val();
                        if (cycle == -1) {
                            alert("请选择频次");
                            return false;
                        }
                    }
                    getFormInfo(2);
                    return false;
                }
            });

            //获取根据检验单Id获取检验信息
            if (InspectionId != -1) {
                getFormInfo(-1);
                $("#txtEquipmentCode").prop("disabled", true).next().hide();
            } else {
            }

            if ((InspectionId != -1 && InspectionType == 7) || InspectionType == 12) {
                $("#Cycle").prop("disabled", true);
            }

            //可否编辑
            if (pageName == 'EquipmentMaintenanceView' || pageName == "EquipmentSpotCheckView") {
                $("#trSaveOrderBtn").hide();
                $('input:not(.result-entry)').attr("disabled", "disabled");
                $('select').prop("disabled", true);
                $('.file-upload').hide();
            }

            //上传
            $(".td-upload").live("hover", function () {
                if (isFirst) {
                    isFirst = false;
                    var height = $(".td-upload div").first().height() + 12;
                    var width = $(".td-upload div").first().width();
                    //$(".uploadify-button").css({ "height": height, "width": width });
                    //$("#div-upload").css({ "height": height, "width": width });
                    //$("#fileUpload").css({ "height": height, "width": width });
                    $("#div-upload").css({ "width": width });
                }
                if ($(this).find("#div-upload").length > 0) {
                    return;
                }
                if ($(this).find(".file-upload").is(":hidden")) {
                    return;
                }
                var obj = $(this).parent();
                //$("#hidInspectionId").val(obj.attr("InspectionId"));
                $("#hidInspectionOrderOATemplateDetailId").val(obj.attr("InspectionOrderOATemplateDetailId"));
                $("#hidFileType").val($(this).attr("file-type"));
                //$("#hidInspectionTemplateId").val(obj.attr("InspectionTemplateId"));
                //$("#hidInspectionItemId").val(obj.attr("InspectionItemId"));

                //$(this).find("span.upload-txt").hide().closest("tr").siblings().find("span.upload-txt").show();
                $(this).find(".file-upload").hide().closest("tr").siblings().find(".file-upload").show();
                $(this).closest("td").siblings().find(".file-upload").show();
                $("#div-upload").show().prependTo($(this));
            });

            //查看
            $(".btn-view").live("click", function () {
                var serverFileName = $(this).closest("td").attr("FileNameServer");
                if (serverFileName) {
                    FileSave(serverFileName);
                }
            });

            //删除文件
            $(".delete-upload").live("click", function () {
                var serverFileName = $(this).closest("td").attr("FileNameServer");
                if (!serverFileName) {
                    return false;
                }
                if (!confirm("确认要删除吗？")) {
                    return false;
                }
                var entity = {};
                entity.InspectionOrderId = parseInt(InspectionId);
                entity.InspectionOrderOATemplateDetailId = parseInt($(this).closest("tr").attr("InspectionOrderOATemplateDetailId"));
                var fileType = $(this).closest("td").attr("file-type");//文件类型（0：检验图片 1：检验文件）
                //var ajax = SKT.LeanMES.Web.AjaxServices.AjaxInspection.UploadTemplateItemFile(entity, fileType, "", "");
                //if (ajax.error != null) {
                //    alert(ajax.error.Message);
                //    return false;
                //}
                alert("删除成功！");
                //移除查看、删除按钮
                $(this).siblings(".btn-view").remove();
                $(this).remove();
            });

        })

        function FinalResult(t) {
            var cb = $(t).attr('id') == "cbProductFormOK" ? "cbProductFormNG" : "cbProductFormOK";
            $("#" + cb).removeAttr('checked');
        }

        //GRN输入 inspectionOrderOATemplateDetailId 检验项Id
        function InputGRNResult(inspectionOrderOATemplateDetailId, inspectionItemType) {
            var isView = pageName == 'EquipmentMaintenanceView' ? 1 : 0;
            var sn = $.trim($("#txtSN").val());
            var openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/EquipmentInspectionInputGRN.aspx?name=InspectionInputGRN&isView=" + isView + "&inspectionOrderOATemplateDetailId=" + inspectionOrderOATemplateDetailId + "&inspectionStatus=" + escape(inspectionStatus) + "&InspectionId=" + InspectionId + "&InspectionType=" + InspectionType;
            dialog({ title: "<%=Resources.Pages.InspectionItem %>", src: openWinUrl, width: 900, height: 800 });
        }

        function BatchInspection() {
            //判断是否所有检验项都完成了检验
            $("tr.inspection-item td.td-result").each(function (i) {
                $(this).find('input[type=radio][name=OkNgNa' + i + '][value=1]').prop('checked', true).trigger('change');
            });
        }

        //检验结果反馈（结果录入界面保存或清除后，会调用此方法）
        function InputGRNResultBckFunction(entity) {
            closeDialog();

            //更新检验项检验结果
            var trItem = $(".inspection-template tr.inspection-item[InspectionOrderOATemplateDetailId=\"" + entity.InspectionOrderOATemplateDetailId + "\"]");
            if (entity.Result == -1) {
                //未检验
                trItem.find("input[type='radio']").prop("checked", false);
            } else {
                trItem.find("input[type='radio'][value=\"" + entity.Result + "\"]").prop("checked", true);
            }
            //trItem.find("td.InspectionData").text(entity.InspectionData == null ? "" : entity.InspectionData);
            //trItem.find("td.MaxValue").text(entity.MaxValue == null ? "" : entity.MaxValue);
            //trItem.find("td.MinValue").text(entity.MinValue == null ? "" : entity.MinValue);
            //trItem.find("td.AvgValue").text(entity.AvgValue == null ? "" : entity.AvgValue);

            //生产检验
            trItem.find(".InspectionItemRecordTime").text(getDateString(entity.InspectionItemRecordTime));


            //根据所有检验项检验结果，设置检验结果
            setInspectionResult();
        }

        //动态绑定事件
        $(document).on("change", "input[type='radio']:not(:disabled)", function () {
            //$("input[type='radio']:not(:disabled)").on("change", function () {
            var result = parseInt($(this).val());
            var $parentTd = $(this).closest("td");
            if (result == 2) {
                //N/A
                var isChecked = $(this).attr("ischeck");

                if (isChecked == "1") {
                    $(this).prop("checked", false);
                    $parentTd.siblings("td").find("input[type='text'],input[type='button']").prop("disabled", false);
                    $parentTd.find(".result-entry").prop("disabled", false);
                    $(this).attr("ischeck", 0);
                }
                else {
                    $parentTd.siblings("td").find("input[type='text'],input[type='button']").prop("disabled", true);
                    $parentTd.find(".result-entry").prop("disabled", true);
                    $(this).attr("ischeck", 1);
                }
                var check = $(this).prop("checked");
                if (!check) {
                    result = -1;
                }
            } else {
                //合格或者不合格
                $parentTd.find("input[type='radio']").attr("ischeck", 0);
                //if (inspectionStatus == -1 || inspectionStatus == 0) {
                if (inspectionStatus == 1) {
                    $parentTd.siblings("td").find("input[type='text'],input[type='button']").prop("disabled", false);
                }
            }

            //更改细项状态
            var id = $(this).closest("tr").attr("InspectionOrderOATemplateDetailId");

            //生产检验项
            var entity = {};
            entity.Result = result;
            entity.InspectionOrderOATemplateDetailId = parseInt(id);
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEquipmentInspectionItem.UpdateInspectionItemResult(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return;
            }
            //更新记录时间
            var entity = ajax.value;
            if (entity) {
                $(this).closest("td").siblings(".InspectionItemRecordTime").text(getDateString(entity.InspectionItemRecordTime));
            }

            //根据所有检验项检验结果，设置检验结果
            setInspectionResult();
        });

        //根据所有检验项检验结果，设置检验结果
        function setInspectionResult() {
            //生产检验
            var okLen = $("tr.inspection-item td input[type=\"radio\"][id*=\"OK\"]:checked").length;
            var ngLen = $("tr.inspection-item td input[type=\"radio\"][id*=\"NG\"]:checked").length;
            if (okLen == 0 && ngLen == 0) {
                $("#cbProductFormOK").prop("checked", false);
                $("#cbProductFormNG").prop("checked", false);
            } else if (ngLen > 0) {
                $("#cbProductFormOK").prop("checked", false);
                $("#cbProductFormNG").prop("checked", true);
            } else {
                $("#cbProductFormOK").prop("checked", true);
                $("#cbProductFormNG").prop("checked", false);
            }
        }

        //保存检验信息 type 0：设备停机，无需检验 1：检验完成
        function SaveForm(type) {
            if (type == 1) {
                if ($("#cbProductFormOK").prop('checked') == false && $("#cbProductFormNG").prop('checked') == false) {
                    alert("请进行检验后在点击保存按钮");
                    return false;
                }

                var isOk = true;
                //判断是否所有检验项都完成了检验
                $("tr.inspection-item td.td-result").each(function () {
                    if ($(this).find("input[type=\"radio\"]:checked").length <= 0) {
                        isOk = false;
                        alert("请先对[" + $.trim($(this).siblings(".InspectionItemName").text()) + "]进行检验");
                        return false;
                    }
                });
                if (!isOk) {
                    return;
                }
            } else {
                if ($("#cbProductFormOK").prop('checked') || $("#cbProductFormNG").prop('checked')) {
                    if (!confirm("您已进行了检验，确定无需检验吗？")) {
                        return false;
                    }
                }
            }

            var result = $("#cbProductFormOK").prop('checked') ? 1 : 0;
            var workShift = $("#ddlWorkShift").val();
            var entity = {};
            entity.InspectionId = InspectionId;
            entity.WorkShift = workShift;
            entity.InspectionResult = result;
            entity.Instrument = $.trim($("#txtInstrument").val());
            entity.Remark = $.trim($("#txtRemark").val());
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEquipmentInspectionItem.InspectionEquipmentComplete(entity, type);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return;
            }

            alert("保存成功！");
            window.opener.Refresh();
            window.close();
        }

        function FileShow(entity) {
            //var uploadTd = $("#div-upload").closest("td").siblings(".td-view").find(".btn-view");
            //uploadTd.text(entity.FileName).attr("FileNameServer", entity.ServerFileName);

            //var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialIQC.GetFileInfo($("#spanInspectionItemCode").html(), $.trim($("#lblInspectionNo").html()));
            //if (ajax.error != null) {
            //    alert(ajax.error.Message);
            //    return;
            //}
            //var data = ajax.value;
            //$("#FileInfo tbody").html("<tr class=\"ListTableHeader\">"
            //    + "<th>序号</th>"
            //    + "<th>产品编码</th>"
            //    + "<th>供应商</th>"
            //    + "<th>文件名称</th>"
            //    + "<th>文件类型</th>"
            //    + "<th>创建人</th>"
            //    + "<th>创建时间</th>"
            //    + "<th>下载</th>"
            //+ "</tr>  ");
            //for (var i = 0; i < data.length; i++) {
            //    $("#FileInfo tbody").append("<tr class='ListTableOddRow'>"
            //        + "<td>" + (i + 1) + "</td>"
            //        + "<td>" + data[i].ItemCode + "</td>"
            //        + "<td>" + data[i].SupplierName + "</td>"
            //        + "<td>" + data[i].FileName + "</td>"
            //        + "<td>" + data[i].FileType + "</td>"
            //        + "<td>" + data[i].CreateBy + "</td>"
            //        + "<td>" + data[i].CreateDateTime + "</td>"
            //        + "<td><a href='#' onclick=FileSave('" + data[i].FileSaveName + "')>下载</a></td>"
            //        + "</tr>")
            //}
        }

        function FileSave(data) {
            var fileUrl = "/ESOP/DownLoad.aspx?Action=EquipmentInspectionFile&fileName=" + data + ""; 
            //var path = '<%=SKT.LeanMES.Web.WebHelper.WebRoot %>' + "/UploadFiles/EquipmentInspection/" + data;
            window.open(fileUrl);
        }

        //更新备注
        function UpdateRemark(obj, id) {
            var remark = $.trim($(obj).val());
            var entity = {};
            entity.Remark = remark;
            entity.InspectionOrderOATemplateDetailId = parseInt(id);
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEquipmentInspectionItem.UpdateInspectionItemRemark(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return;
            }
        }

        //验证是否为0或正数
        function isPositiveNumberOrZero(val) {
            var reg = /^[0-9]+(.[0-9]{1,6})?$/;
            return reg.test(val);
        }

        //验证是否为大于0的数字（小数部分最多允许输入6位）
        function isGreaterThanZero(val) {
            var reg = /^[0-9]+(.[0-9]{1,6})?$/;
            if (reg.test(val) && parseFloat(val) != 0) {
                return true;
            }
            return false;
        }

    </script>

    <script>
        var flag = -1;

        //获取根据检验单Id获取检验信息   type：-1 已生成检验单，查看检验单 2:扫描或选择设备
        function getFormInfo(type) {
            //if (type == 2 && InspectionId != "-1") {
            //    alert("数据异常");
            //    return false;
            //}

            if (type == 2) {
                //如果未生成检验单，则生成检验单，否则带出检验单信息
                var entity =
                {
                    EquipmentCode: $.trim($("#txtEquipmentCode").val()),
                    InspectionType: 12,
                    Cycle: parseInt($("#Cycle").val()),
                    ModifyBy: modifyBy,
                }
                var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspEquipmentInspectionNo", JSON.stringify(entity));
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return;
                }
                InspectionId = JSON.parse(ajax.value).data[0].InspectionOrderId;
                $("#txtEquipmentCode").prop("disabled", true).next().hide();
                $("#hidInspectionId").val(InspectionId);
            }

            var entity = {};
            entity.InspectionId = parseInt(InspectionId);

            //获取检验单基本信息
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEquipmentInspectionItem.GetEquipmentMaintenanceInfo(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return;
            }
            var mainEntity = ajax.value;
            if (!mainEntity || !mainEntity.InspectionNo) {
                alert("未获取到检验单信息");
                return;
            }

            //获取检验单明细信息
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEquipmentInspectionItem.GetEquipmentInspectionTemplateDetail(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return;
            }
            var list = ajax.value;
            if (!list || list.length <= 0) {
                alert("未获取到检验项信息");
                return;
            }

            inspectionStatus = mainEntity.Status;   // 检验单状态（1：待检验 3：无需检验 2：已检验 ）
            if ((inspectionStatus == 1 || inspectionStatus == 3) && pageName != "EquipmentMaintenanceView") {
                //if ((inspectionStatus == -1) && pageName != "EquipmentMaintenanceView") {
                $(".maintenance-no,.maintenance-complete").show();
                $(".maintenance-no,.one-click-inspection").show();
            }

            $("#lblInspectionNo").text(mainEntity.InspectionNo);
            if (inspectionStatus == 1) {
                $("#lblInspectionUserNo").text(userName);
                $("#lblInspectionUserName").text(userCName);
            } else {
                $("#lblInspectionUserNo").text(mainEntity.InspectionUser);
                $("#lblInspectionUserName").text(mainEntity.InspectionUserCName);
                $("#lblInspectionTime").text(getDateString(mainEntity.InspectionTime));
            }
            $("#txtEquipmentCode").val(mainEntity.EquipmentCode);
            $("#EquipmentName").text(mainEntity.EquipmentName);
            $("#Cycle").val(mainEntity.CycleType);
            $("#ddlWorkShift").val(mainEntity.WorkShift);
            $("#lblEquipmentTypeName").text(mainEntity.EquipmentTypeName);
            //$("#lblStation").text(mainEntity.Station);
            //$("#FormCode").text(mainEntity.FormCode);

            //检验结果
            if (mainEntity.InspectionResult == 0) {
                $("#cbProductFormOK").removeAttr('checked');
                $("#cbProductFormNG").prop("checked", true);
            }
            else if (mainEntity.InspectionResult == 1) {
                $("#cbProductFormOK").prop("checked", true);
                $("#cbProductFormNG").prop("checked", false);
            }
            if (mainEntity.Instrument) {
                $("#txtInstrument").val(mainEntity.Instrument);
            }
            if (mainEntity.Remark) {
                $("#txtRemark").val(mainEntity.Remark);
            }

            //获取文件信息
            //FileShow();
            //加载检验模版项
            LoadInspectionItem(list);

            //已检验的IQC单据禁用radio
            //if (inspectionStatus > 1) {
            //    $("input[type='radio'],input[type='text']").attr("disabled", "disabled");
            //    $('.file-upload').hide();                
            //}

            ////初始化IQC单据状态
            //if ($("tr[name='TempLateTr'] input[type='radio']:checked").length > 0) {
            //    $("#cbProductFormOK").prop("checked", true)
            //    $("#cbProductFormNG").prop("checked", false);
            //    for (var i = 0; i < $("tr[name='TempLateTr'] input[type='radio']:checked").length; i++) {
            //        var $_radio = $($("tr[name='TempLateTr'] input[type='radio']:checked")[i]);
            //        if ($_radio.attr("id").toString().indexOf("NG") != -1) {
            //            $("#cbProductFormOK").prop("checked", false);
            //            $("#cbProductFormNG").prop("checked", true);
            //            return false;
            //        }
            //    }
            //}

            //已检验，禁用文本框
            //if (inspectionStatus != -1 && inspectionStatus != 0) {
            if (inspectionStatus != 1) {
                $("input[type='radio'],input[type='text']").attr("disabled", "disabled");
                $('.file-upload').hide();
            } else {
                //初始化IQC单据检验结果
                setInspectionResult();
            }

            //if (inspectionStatus == -1 || inspectionStatus == 0) {
            //    if (inspectionStatus == -1) {
            //        $("#cbProductFormOK").prop("checked", true);
            //    } else if (inspectionStatus == 0 && inspectionTypeId == 1) {
            //        $("#chkQualityOK").prop("checked", true);
            //    }

            //    for (var i = 0; i < $("tr[name='TempLateTr'] input[type='radio']:checked").length; i++) {
            //        var $_radio = $($("tr[name='TempLateTr'] input[type='radio']:checked")[i]);
            //        if ($_radio.attr("id").toString().indexOf("NG") != -1) {
            //            if (inspectionStatus == -1) {
            //                $("#cbProductFormOK").prop("checked", false);
            //                $("#cbProductFormNG").prop("checked", true);
            //            } else if (inspectionTypeId == 1) {
            //                $("#chkQualityOK").prop("checked", false);
            //                $("#chkQualityNG").prop("checked", true);
            //            }
            //            return false;
            //        }
            //    }
            //}
        }

        //加载检验模版项
        function LoadInspectionItem(list) {
            var hl = "";
            for (var i = 0; i < list.length; i++) {//InspectionId=\"" + InspectionId + "\"  InspectionTemplateId=\"" + tempList.InspectionTemplateId + "\" InspectionItemId=\"" + tempList.InspectionTemplateMemberId + "\"                
                var inspectionFileHtml = "<td></td>";   //检验文件Html
                var inspectionImageHtml = "<td></td>";   //检验图片Html


                if (list[i].OutPutFileFlag != 0) {
                    //if (pageName != "EquipmentMaintenanceView" && (inspectionStatus == -1 || inspectionStatus == 0)) {
                    if (pageName != "EquipmentMaintenanceView" && (inspectionStatus == 1)) {
                        //待检验状态
                        inspectionFileHtml = "<td class=\"InspectionFileName td-upload\" file-type=\"1\" FileNameServer=\"" + list[i].InspectionFileName + "\" title=\"" + list[i].InspectionFileName + "\"><div style=\"position: relative\"><a class=\"file-upload btn btn-link\"><span class=\"upload-txt\">上传</span></a>";
                        if (list[i].InspectionFileName != "") {
                            inspectionFileHtml += "<a class=\"btn-view btn btn-link\"><span class=\"\">查看</span></a><a class=\"delete-upload btn btn-link\"><span class=\"\">删除</span></a>"
                        }
                        inspectionFileHtml += "</div></td>";

                    } else if (list[i].InspectionFileName != "") {
                        //已检验
                        inspectionFileHtml = "<td class=\"td-view\" FileNameServer=\"" + list[i].InspectionFileName + "\" title=\"" + list[i].InspectionFileName + "\"><a class=\"btn btn-link btn-view\">查看</a></td>";
                    }
                }

                if (list[i].OutPutImageFlag != 0) {
                    //if (pageName != "EquipmentMaintenanceView" && (inspectionStatus == -1 || inspectionStatus == 0)) {
                    if (pageName != "EquipmentMaintenanceView" && (inspectionStatus == 1)) {
                        //待检验状态  
                        inspectionImageHtml = "<td class=\"InspectionImageName td-upload\" file-type=\"0\" FileNameServer=\"" + list[i].InspectionImageName + "\" title=\"" + list[i].InspectionImageName + "\"><div style=\"position: relative\"><a class=\"file-upload btn btn-link\"><span class=\"upload-txt\">上传</span></a>";
                        if (list[i].InspectionImageName != "") {
                            inspectionImageHtml += "<a class=\"btn-view btn btn-link\"><span class=\"\">查看</span></a><a class=\"delete-upload btn btn-link\"><span class=\"\">删除</span></a>"
                        }
                    } else if (list[i].InspectionImageName != "") {
                        //已检验
                        inspectionImageHtml = "<td class=\"td-view\" FileNameServer=\"" + list[i].InspectionImageName + "\" title=\"" + list[i].InspectionImageName + "\"><a class=\"btn btn-link btn-view\">查看</a></td>";
                    }
                }

                hl += "<tr class=\"ListTableOddRow inspection-item\" name='TempLateTr' InspectionOrderOATemplateDetailId=\"" + list[i].InspectionOrderOATemplateDetailId + "\" InspectionTypeName=\"" + list[i].InspectionTypeName + "\"><td>" + (i + 1) + "</td>" +    //序号
                    //"<td>" + list[i].InspectionTypeName + "</td>" + //检验类别
                    "<td class=\"InspectionItemName\">" + list[i].InspectionItemName + "</td>" + //检验项目
                    //"<td>" + list[i].InspectionCycle + "</td>" + //检验周期/频次
                    //"<td>" + list[i].AQLRuleName + "</td>" + //抽样比例/标准
                    "<td>" + list[i].InspectionMethod + "</td>" + //检验方法
                    "<td>" + list[i].StandardValue + "</td>" + //检验标准
                    "<td class=\"OutPutDataFlag\" style=\"display:none\" OutPutDataFlag=\"" + list[i].OutPutDataFlag + "\">" + (list[i].OutPutDataFlag == 1 ? "√" : "") + "</td>" + //数据
                    "<td class=\"OutPutImageFlag\" style=\"display:none\" OutPutImageFlag=\"" + list[i].OutPutImageFlag + "\">" + (list[i].OutPutImageFlag == 1 ? "√" : "") + "</td>" + //图片
                    "<td class=\"OutPutFileFlag\" style=\"display:none\" OutPutFileFlag=\"" + list[i].OutPutFileFlag + "\">" + (list[i].OutPutFileFlag == 1 ? "√" : "") + "</td>" + //文件
                    //"<td class=\"FixResultFlag\" FixResultFlag=\"" + list[i].FixResultFlag + "\">" + (list[i].FixResultFlag == 1 ? "固定结果" : "指定值") + "</td>" + //结果判定方式（1：固定结果 0：指定值）
                    //"<td><input type=\"text\" class=\"NumericBox50\" onchange='UpdateSamplingQty(this," + list[i].InspectionOrderOATemplateDetailId + ")' value=\"" + list[i].SamplingQty + "\"></input></td>" + //抽检数量
                    //"<td>" + list[i].TestBy + "</td>" + //测试人员
                    //"<td>" + list[i].TestEquipment + "</td>" + //测试设备
                    //"<td class=\"test-data InspectionData\">" + list[i].InspectionData + "</td>" + //检验数据
                    //"<td class=\"test-data MaxValue\">" + list[i].MaxValue + "</td>" + //最大值
                    //"<td class=\"test-data MinValue\">" + list[i].MinValue + "</td>" + //最小值
                    //"<td class=\"test-data AvgValue\">" + list[i].AvgValue + "</td>" + //平均值
                    //"<td class=\"InspectionImageName\">" + list[i].InspectionImageName + "</td>" + //检验图片
                    inspectionImageHtml + //检验图片
                    //+ "<td style='text-align:center; width:10%' class=\"td-upload\"><div style=\"position: relative\"><a class=\"file-upload btn btn-link\"><span class=\"upload-txt\">上传</span></a></div></td>"
                    //"<td class=\"InspectionFileName td-upload\">" + list[i].InspectionFileName + "</td>" + //检验文件
                    inspectionFileHtml + //检验文件
                    //"<td><input type=\"text\" class=\"InspectionItemQty NumericBox50\" value=\"" + list[i].InspectionItemQty + "\"></input></td>" + //检验项检验数量
                    //"<td><input type=\"text\" class=\"InspectionItemNGQty NumericBox50\" value=\"" + list[i].InspectionItemNGQty + "\"></input></td>" + //检验项不合格数量
                    "<td class=\"td-result\" FixResultFlag=\"" + list[i].FixResultFlag + "\">" +
                    "<label style=\"background-color;#ACBAD4\"><input value=\"1\" class=\"result\" type=\"radio\" " + (list[i].Result == 1 ? "checked=\"true\"" : "") + (list[i].FixResultFlag == 1 ? "" : "disabled=\"disabled\"") + " id=\"cbOK" + i + "\" name=\"OkNgNa" + i + "\">OK</label>&nbsp;&nbsp;" +
                    "<label style=\"background-color;#ACBAD4\"><input value=\"0\" class=\"result\" type=\"radio\" " + (list[i].Result == 0 ? "checked=\"true\"" : "") + (list[i].FixResultFlag == 1 ? "" : "disabled=\"disabled\"") + " id=\"cbNG" + i + "\" name=\"OkNgNa" + i + "\">NG</label>&nbsp;&nbsp;" +
                    "<label style=\"background-color;#ACBAD4\"><input value=\"2\" class=\"result\" ischeck=\"" + (list[i].Result == 2 ? "1" : "0") + "\" type=\"radio\" " + (list[i].Result == 2 ? "checked=\"true\"" : "") + "\" id=\"cbNA" + i + "\" name=\"OkNgNa" + i + "\">N/A</label>" +
                    (list[i].FixResultFlag == 1 ? "" : "<input type='button' class='btn btn-primary btn-xs result-entry' value='" + mesLang("结果录入") + "' " + (list[i].Result == 2 ? "disabled=\"disabled\"" : "") + "onclick='InputGRNResult(\"" + list[i].InspectionOrderOATemplateDetailId + "\")' />") +    //结果录入文本框
                    (list[i].Result != 0 ? "" : "&nbsp;&nbsp;<input type='button' class='btn btn-primary btn-xs result-entry' value='维修' onclick='InputGRNRepair(\"" + list[i].InspectionOrderOATemplateDetailId + "\")' />") +    //维修
                    "</td>" +   //list[i].Result 检验结果
                    "<td><input type=\"text\" class=\"InspectionItemNGQty\" value=\"" + list[i].Remark + "\" onchange='UpdateRemark(this," + list[i].InspectionOrderOATemplateDetailId + ")'></input></td>" + //不合格描述
                    "<td class=\"InspectionItemRecordTime\">" + getDateString(list[i].InspectionItemRecordTime) + "</td>" + //记录时间
                    "<td>" + list[i].Remark + "</td>" +
                    "<td>" + list[i].InspectionNGImageUrl + "</td>" +
                    "</tr > "; //不合格图片
            }

            $(".inspection-template tbody").html(hl);
        }

        function openChoosePage(flags) {
            var condition = "";
            if (flags == 54) {
                condition = " EquipmentTypeId NOT IN (-2,-3,-4)";
            }
           
            flag = flags;
            dialog({ title: "选择窗口", src: "../Framework/ChoosePage.aspx?PageId=" + flags + "&Multiple=false&PageCondition=" + condition + "&rnd=" + Math.random(), width: 650, height: 350 });
        }

        function getChooseValue(list) {
            if (flag == 54) {
                $("#txtEquipmentCode").val(list[0][1]);
                if (list[0][2]) {
                    getFormInfo(2);
                }
            }
        }

        function UpdateList() {
            document.forms[0].submit();
        }

        //获取时间字符串形式
        function getDateString(date) {
            if (!date) {
                return "";
            }
            var today = new Date(date);
            return today.Format();
        }

        //时间转字符串
        Date.prototype.Format = function (fmt) {
            if (undefined == fmt || null == fmt) {
                fmt = "yyyy-MM-dd HH:mm:ss";
            }
            var t = this;
            var tf = function (str, len) {
                if (str.length < len) {
                    for (var i = 0; i < len - str.length; i++) {
                        str = "0" + str;
                    }
                }
                return str
            };
            var opt = {
                "y+": t.getFullYear().toString(),        // 年
                "M+": (t.getMonth() + 1).toString(),     // 月
                "d+": t.getDate().toString(),            // 日
                "H+": t.getHours().toString(),           // 时
                "m+": t.getMinutes().toString(),         // 分
                "s+": t.getSeconds().toString()          // 秒
                // 有其他格式化字符需求可以继续添加，必须转化成字符串
            };
            var ret;
            for (var k in opt) {
                ret = new RegExp("(" + k + ")").exec(fmt);
                if (ret) {
                    fmt = fmt.replace(ret[1], ret[1].length == 1 ? opt[k] : tf(opt[k], ret[1].length));
                }
            }
            return fmt;
        }

    </script>

</asp:Content>
