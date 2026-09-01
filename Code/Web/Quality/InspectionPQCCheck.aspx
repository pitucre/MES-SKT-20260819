<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    CodeBehind="InspectionPQCCheck.aspx.cs" Inherits="SKT.LeanMES.Web.Quality.InspectionPQCCheck" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
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
            <td class="Label1">
                物料条码<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtSerialNumber" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
    </table>
    <div style="margin-top: 15px; margin-bottom: 15px;">
        <table class="EditeContentTable" width="100%">
            <tr>
                <td class="Label3">
                    检验单号
                </td>
                <td class="Field3">
                    <span id="spanInspectionOrderNo"></span>
                </td>
                <td class="Label3">
                    产品编码
                </td>
                <td class="Field3">
                    <span id="spanInspectionItemCode"></span>
                </td>
                <td class="Label3">
                    检验单数量
                </td>
                <td class="Field3">
                    <span id="spanInspectionOrderQty"></span>
                </td>
            </tr>
            <tr>
                <td class="Label3">
                    生产组长
                </td>
                <td class="Field3">
                    <input type="text" id="txtProdGroup" style="width: 90%" />
                </td>
                <td class="Label3">
                    审核
                </td>
                <td class="Field3">
                    <input type="text" id="txtSign" style="width: 90%" />
                </td>
                <td class="Label3">
                    版本
                </td>
                <td class="Field3">
                    <input type="text" id="txtPrintLv" value="RF-GI-QM-086-01-V1.0" style="width: 160px" />
                </td>
            </tr>
            <tr>
                <td class="Label3">
                    品质QC
                </td>
                <td class="Field3">
                    <input type="text" id="txtQualityQc" value="" style="width: 90%" />
                </td>
                <td class="Label3">
                    最终检验结果
                </td>
                <td class="Field3">
                    &nbsp;&nbsp;<label style="color: Red">
                        <input id='cbFormOK' type="checkbox" onchange='FinalResult(this)' />合格</label>&nbsp;&nbsp;
                    <label style="color: Red">
                        <input id='cbFormNG' type="checkbox" onchange='FinalResult(this)' />不合格</label>
                </td>
            </tr>
            <tr>
                <td class="Label3">
                    检验时机
                </td>
                <td colspan="5">
                    &nbsp;&nbsp;<label>
                        <input id='checkOrder' type="checkbox"  />工单开线</label>&nbsp;&nbsp;
                    <label>
                        <input id='checkItem' type="checkbox"  />更换关键物料</label>&nbsp;&nbsp;
                    <label>
                        <input id='checkProd' type="checkbox"  />更换生产场地</label>&nbsp;&nbsp;
                    <label>
                        <input id='checkEqui' type="checkbox"  />更换仪器设备</label>&nbsp;&nbsp;
                    <label>
                        <input id='checkTech' type="checkbox"  />设计或工艺变更</label>&nbsp;&nbsp;
                    <label>
                        <input id='checkLine' type="checkbox"  />停线后复线</label>&nbsp;&nbsp;
                    <label>
                        <input id='checkOther' type="checkbox"  />其他<input type="text" id="txtOther" /></label>&nbsp;&nbsp;
                </td>
            </tr>
            <tr id="trSaveOrderBtn">
                <td class="Field3" colspan="6" style="text-align: center;">
                    <input id="SaveBtn" type="button" value=" 保存检验结果 " onclick="if (SubmitValidation()){SaveForm();}" />
                    <input id="btnGrnNg" type="button" value=" GRN信息 " onclick="GrnNg();" style="display: none;" />
                </td>
            </tr>
        </table>
    </div>
    <div id="divDtl">
    </div>
    <br />
    <table id="tabResult" class="EditeContentTable" width="100%" style="border-width: 0px;
        width: 100%; border-collapse: collapse;">
        <tr>
            <td class="Label" style="width: 10%; text-align: center">
                改善建议：
            </td>
            <td class="Field" colspan="5" style="width: 80%; text-align: center">
                <input id="txtRemark" type="text" style="width: 97%; height: 30px" name="name" value="" />
            </td>
        </tr>
        <tr>
            <td class="Label" rowspan="3" style="width: 10%; text-align: center">
                最终结果
            </td>
            <td class="Field" style="width: 20%; text-align: center">
                合格, 允许继续生产
            </td>
            <td class="Field" style="width: 10%; text-align: center">
                <label style="color: Red">
                    <input id='Checkbox1' type="checkbox" name="checkResult" onchange='FinishResult(this)' /></label>
            </td>
            <td class="Label" rowspan="3" style="width: 10%; text-align: center">
                会签评审
            </td>
            <td class="Field" style="width: 10%; text-align: center">
                生产会签
            </td>
            <td class="Field">
                <input type="text" id="txtProdSign" value="" style="width: 200px;" />
            </td>
        </tr>
        <tr>
            <td class="Field" style="width: 20%; text-align: center">
                不合格, 改善不良, 重新制作首件
            </td>
            <td class="Field" style="width: 10%; text-align: center">
                <label style="color: Red">
                    <input id='Checkbox2' type="checkbox" name="checkResult" onchange='FinishResult(this)' /></label>
            </td>
            <td class="Field" style="width: 10%; text-align: center">
                工艺会签
            </td>
            <td class="Field">
                <input type="text" id="txtTechSign" value="" style="width: 200px;" />
            </td>
        </tr>
        <tr>
            <td class="Field" style="width: 20%; text-align: center">
                不合格, 停止生产, 报相关部门整改
            </td>
            <td class="Field" style="width: 10%; text-align: center">
                <label style="color: Red">
                    <input id='Checkbox3' type="checkbox" name="checkResult" onchange='FinishResult(this)' /></label>
            </td>
            <td class="Field" style="width: 10%; text-align: center">
                品质批准
            </td>
            <td class="Field">
                <input type="text" id="txtQualitySign" value="" style="width: 200px;" />
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        var tab = document.getElementById("tblExpand");
        var TypeId = '<%=Request["TypeId"] %>'; /*页面布局  1：审核 2：检验  10：综合*/
        var name = '<%=Request["name"] %>'; //Material_PQCFormView查看
        var InspectionTypeId = '<%=Request["InspectionTypeId"]  %>';  /*验检单类型 */
        var ProductPQCId = '<%=Request["IOrderId"]??"-1"  %>';    /*检验单ID*/
        var IOrderId = ProductPQCId;                              /*检验单ID*/

        var userName = "<%=userName %>";
        var ItemCode = "";
        var moCount = 0; //  模版项计数
        var ShowMessCount = 0;

        //模版检验项列表
        var listItem = [];
        //模版LCR检验项列表
        var Lcrlist = [];

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
            //获取根据检验单Id获取检验信息
            if (InspectionTypeId != -1) {
                getFormInfo();
            }
            //input 事件焦点设定
            $('input:checkbox').click(function () {
                this.blur();
                this.focus();
            });
            //可否编辑
            if (name === 'Material_PQCFormView') {
                $('input').attr("disabled", "disabled");
                $("#trSaveOrderBtn").css("display", "none");
            }
        })

        function selectInspectionOrderNo() {

            var condition = " Statue =0 ";
            dialog({ title: "<%=Resources.Common.ChooseWindow %>",
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
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxInspectionOQC.GetPqcFormModel(IOrderId);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                if (ProductPQCId != -1) {
                    parent.Refresh();
                }
                return;
            }
            if (ajax.value != null) {
                var en = $.parseJSON(ajax.value);
                ItemCode = en.data[0].ItemCode;

                $("#spanInspectionOrderNo").html(en.data[0].ProductPQCNo);
                $("#spanInspectionItemCode").html(ItemCode);
                $("#spanInspectionOrderQty").html(en.data[0].InspectionQty);
                $("#txtSign").val(en.data[0].Auditing);
                if (en.data[0].InspectionResult === 0) {
                    $("#cbFormNG").attr("checked", "checked");
                    $("#cbFormOK").removeAttr('checked');
                }
                else if (en.data[0].InspectionResult === 1) {
                    $("#cbFormNG").removeAttr('checked');
                    $("#cbFormOK").attr("checked", "checked");
                }
                if (en.data[0].FinishResult === 1) {
                    $("#Checkbox1").attr("checked", "checked");
                }
                else if (en.data[0].FinishResult === 2) {
                    $("#Checkbox2").attr("checked", "checked");
                }
                else if (en.data[0].FinishResult === 3) {
                    $("#Checkbox3").attr("checked", "checked");
                }
                if (en.data[0].ProdGroup != null && en.data[0].ProdGroup != "") {
                    $("#txtProdGroup").val(en.data[0].ProdGroup);
                }
                if (en.data[0].QualityQc != null && en.data[0].QualityQc != "") {
                    $("#txtQualityQc").val(en.data[0].QualityQc);
                }
                if (en.data[0].ProdSign != null && en.data[0].ProdSign != "") {
                    $("#txtProdSign").val(en.data[0].ProdSign);
                }
                if (en.data[0].TechSign != null && en.data[0].TechSign != "") {
                    $("#txtTechSign").val(en.data[0].TechSign);
                }
                if (en.data[0].QualitySign != null && en.data[0].QualitySign != "") {
                    $("#txtQualitySign").val(en.data[0].QualitySign);
                }
                if (en.data[0].PrintLv != null && en.data[0].PrintLv != "") {
                    $("#txtPrintLv").val(en.data[0].PrintLv);
                }
                if (en.data[0].Remark != null && en.data[0].Remark != "") {
                    $("#txtRemark").val(en.data[0].Remark);
                }

                for (var i = 0; i < en.data.length; i++) {
                    if (en.data[i].ProdType == 1 && en.data[i].RemarkDtl == "1")
                        $("#checkOrder").attr("checked", true);
                    if (en.data[i].ProdType == 2 && en.data[i].RemarkDtl == "1")
                        $("#checkItem").attr("checked", true);
                    if (en.data[i].ProdType == 3 && en.data[i].RemarkDtl == "1")
                        $("#checkProd").attr("checked", true);
                    if (en.data[i].ProdType == 4 && en.data[i].RemarkDtl == "1")
                        $("#checkEqui").attr("checked", true);
                    if (en.data[i].ProdType == 5 && en.data[i].RemarkDtl == "1")
                        $("#checkTech").attr("checked", true);
                    if (en.data[i].ProdType == 6 && en.data[i].RemarkDtl == "1")
                        $("#checkLine").attr("checked", true);
                    if (en.data[i].ProdType == 7 && en.data[i].RemarkDtl != "") {
                        $("#checkOther").attr("checked", true);
                        $("#txtOther").val(en.data[6].RemarkDtl);
                    }
                }
                //加载检验模版项
                moCount = 0;
                LoadInspectionItem(en.data1);
                //加载LCR检验项
                DetailLcrItem(en.data[0].ProductPQCId);
            }
        }

        function FinalResult(t) {
            var cb = $(t).attr('id') == "cbFormOK" ? "cbFormNG" : "cbFormOK";
            $("#" + cb).removeAttr('checked');
        }
        function FinishResult(t) {
            $("#Checkbox1").removeAttr('checked');
            $("#Checkbox2").removeAttr('checked');
            $("#Checkbox3").removeAttr('checked');
            $(t).attr("checked", true);
        }
        //加载检验模版项
        function LoadInspectionItem(data1) {
            $("#divDtl").append("");
            listItem = [], moCount = 0;
            for (var i = 0; i < data1.length; i++) {
                DetailItem(data1[i].ProductPQCId, data1[i].InspectionTemplateId, i);
            }
        }

        //模版检验项详细资料取得绑定
        function DetailItem(ProductPQCId, InspectionTemplateId) {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxInspectionOQC.GetPqcFormItem(ProductPQCId, InspectionTemplateId);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return;
            }
            var value = $.parseJSON(ajax.value);
            //模版头添加
            var head = value.data[0];
            var html = "<table id='tblExpand' class='ListTable' style='border-width:0px;width:100%;border-collapse:collapse; margin-top:5px;'  >"
                          + "<tr class='ListTableHeader' ><th colspan='6' >" + head.InspectionTemplateName + "</th></tr>"
                          + "<tr class='ListTableHeader' ><th>抽样水平</th><th>" + head.LotName + "/AQL=" + head.RuleName + "</th>"
                          + "<th>抽样数量</th><th>" + head.SamplingValue + "</th>"
                          + "<th>Ac/Re</th><th>" + "Ac=  " + head.ACValue + "/ Re=  " + head.REValue + "</th></tr></table>";
            $("#divDtl").append(html);
            //加载检验项
            var Dtllist = value.data1;

            var InsItemNamestr = "", Jugestr = "", According = "", DelRow = "";

            html = "<table id='tbDtl" + head.InspectionTemplateId + "' class='ListTable' style='border-width:0px;width:100%;border-collapse:collapse; margin-top:5px;'  >"
                    + "<tr class='ListTableHeader' ><th>序号</th><th>检验项目</th><th>判定标准</th><th>检验方法</th><th>描述</th><th>检验结果</th>"
                    + (name === 'Material_PQCFormView' ? "" : "<th id='delId' style='color: #0066CC; cursor: pointer;' onclick='AddCheckItem(" + head.InspectionTemplateId + ")'>+添加检验项</th>") + "</tr>";
            for (var j = 0; j < Dtllist.length; j++) {
                Dtllist[j].CountRow = moCount;
                //复制
                var en = {}, eItem = JSON.stringify(Dtllist[j]);
                $.extend(en, Dtllist[j]);
                en.CheckResult = Dtllist[j].CheckResult === "" ? null : Dtllist[j].CheckResult;
                listItem.push(en);

                //检验项目
                InsItemNamestr = Dtllist[j].IsCustom === 1 ? ("<em>*</em><input type='text' IsRequired='1' style='width:90%' value='" +
                        Dtllist[j].InspectionItemName + "' onchange='ChangeInsItemName(" + moCount + ", $(this))'/>")
                    : Dtllist[j].InspectionItemName;
                //判断标准
                Jugestr = Dtllist[j].IsCustom === 1 ? ("<em>*</em><input type='text' style='width:90%' IsRequired='1' value='" +
                        Dtllist[j].InspectJuge + "' onchange='ChangeJuge(" + moCount + ", $(this))'/>") : Dtllist[j].InspectJuge;
                //检验方法
                According = Dtllist[j].IsCustom === 1 ? ("<em>*</em><input type='text' style='width:90%' IsRequired='1' value='" +
                        Dtllist[j].InspectionAccording + "' onchange='ChangeInsAccording(" + moCount + ", $(this))'/>") : Dtllist[j].InspectionAccording;

                DelRow = name === 'Material_PQCFormView' ? "" :
                    ("<td style='text-align:center; width:5%'>" +
                        (Dtllist[j].IsCustom === 1 ? "<span style=\"CURSOR: pointer; COLOR: #0000ff;\" onclick=\"deleteItem(" + moCount + ", $(this))\"><%= Resources.Buttons.COM_Delete %></span>" : "") + "</td>");

                html += "<tr class='ListTableOddRow'><td style='text-align:left; width:3%'>" + (j + 1).toString() + "</td>"
                        + "<td style='text-align:left; width:20%'>" + InsItemNamestr + "</td>"
                        + "<td style='text-align:left; width:23%'>" + Jugestr + "</td>"
                        + "<td style='text-align:left; width:10px'>" + According + "</td>"
                        + "<td style='text-align:left; width:30%'><input type='text' value= '" + Dtllist[j].Discretion + "' style='width:97%' onchange='ChangeDesc(" + moCount + ", $(this))'/></td>"
                        + "<td style='text-align:left; width:10%'><label><input id='cbOK" + moCount + "' type='checkbox' "
                            + (Dtllist[j].CheckResult === 1 ? " checked='checked'" : " ") + " onchange='ChangeResult(" + moCount + ", $(this))' />OK</label>&nbsp;&nbsp;"
                        + "<label><input id='cbNG" + moCount + "' type='checkbox' " + (Dtllist[j].CheckResult === 0 ? "checked='checked'" : "")
                            + " onchange='ChangeResult(" + moCount + ", $(this))' />NG</label></td>"
                        + DelRow
                        + "<tr>";

                moCount++;
            }
            html += "</table>";
            $("#divDtl").append(html);
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

        //添加额外检验项
        function AddCheckItem(index) {
            var newItem = {};
            //赋值行
            $.extend(newItem, listItem[0]);
            newItem.IQCModelCheckId = -1;
            newItem.InspectionTemplateId = index;
            newItem.InspectionItemName = "";
            newItem.InspectJuge = "";
            newItem.InspectionAccording = "";
            newItem.InspectionItemId = -1;
            newItem.CountRow = moCount;
            newItem.Discretion = "";
            newItem.CheckResult = null;
            listItem.push(newItem);

            var countRow = $("#tbDtl" + index).find(".ListTableOddRow").length + 1;

            var html = "<tr class='ListTableOddRow'><td style='text-align:center; width:5%'>" + countRow + "</td>"
                        + "<td style='text-align:center; width:15%'><em>*</em><input type='text' style='width:90%' IsRequired='1' onchange='ChangeInsItemName(" + moCount + ", $(this))'/></td>"
                        + "<td style='text-align:center; width:15%'><em>*</em><input type='text' style='width:90%' IsRequired='1' onchange='ChangeJuge(" + moCount + ", $(this))'/></td>"
                        + "<td style='text-align:center; width:15%'><em>*</em><input type='text' style='width:90%' IsRequired='1' onchange='ChangeInsAccording(" + moCount + ", $(this))'/></td>"
                        + "<td style='text-align:center; width:30%'><input type='text' style='width:90%' onchange='ChangeDesc(" + moCount + ", $(this))'/></td>"
                        + "<td style='text-align:center; width:15%'><label><input id='cbOK" + moCount + "' type='checkbox' "
                            + " onchange='ChangeResult(" + moCount + ", $(this))' />OK</label>&nbsp;&nbsp;"
                        + "<label><input id='cbNG" + moCount + "' type='checkbox' "
                            + " onchange='ChangeResult(" + moCount + ", $(this))' />NG</label></td>"
                        + "<td style='text-align:center; width:5%'><span style=\"CURSOR: pointer; COLOR: #0000ff;\" onclick=\"deleteItem(" + moCount + ", $(this))\"><%= Resources.Buttons.COM_Delete %></span></td><tr>";
            $("#tbDtl" + index).append(html);
            moCount++;
        }

        //删除检验项行
        function deleteItem(rowCount, t) {
            var index = -1;
            $.grep(listItem, function (o, j) {
                if (o.CountRow === rowCount) {
                    index = j;
                }
            });
            $(t).parent().parent().remove();
            listItem.splice(index, 1);
        }


        //模版检验项详细资料取得绑定
        function DetailLcrItem(ProductPQCId) {
            Lcrlist = [];
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxInspectionOQC.GetPqcFormLcrItem(ProductPQCId);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return;
            }
            var value = $.parseJSON(ajax.value);
            //模版头添加
            var head = value.data[0];
            var html = "<table id='tblExpand' class='ListTable' style='border-width:0px;width:100%;border-collapse:collapse; margin-top:5px;'  >"
                          + "<tr class='ListTableHeader' ><th colspan='6' >" + head.InspectionTemplateName + "</th></tr>"
                          + "<tr class='ListTableHeader' ><th>抽样水平</th><th>" + head.LotName + "/AQL=" + head.RuleName + "</th>"
                          + "<th>抽样数量</th><th>" + head.SamplingValue + "</th>"
                          + "<th>Ac/Re</th><th>" + "Ac=  " + head.ACValue + "/ Re=  " + head.REValue + "</th></tr></table>";
            $("#divDtl").append(html);
            //加载LCR检验项
            Lcrlist = value.data1;
            var itemCount = 0;

            html = "<table id='tbDtl" + head.InspectionTemplateId + "' class='ListTable' style='border-width:0px;width:100%;border-collapse:collapse; margin-top:5px;'  >";
            for (var j = 0; j < Lcrlist.length; j++) {
                html += "<tr class='ListTableOddRow'><td style='text-align:center; width:10%'>" + Lcrlist[j].IQCLcrItemName + "</td>";
                for (var a = 1; a <= 8; a++) {
                    //ID赋值
                    var Iid = j.toString() + a.toString();

                    if (Lcrlist[j].IQCLcrItemType === 2) {
                        itemCount++;
                        html += "<td style='text-align:center; width:9%'>(" + itemCount + ")</td>";
                    }
                    else if (Lcrlist[j].IQCLcrItemType === 1) {
                        html += "<td style='text-align:center; width:9%'><label><input id='cbLcrOK"
                            + j.toString() + a.toString() + "' type='checkbox' " + (Lcrlist[j]["Value" + a] === '1' ? " checked='checked'" : " ")
                            + " onchange='ChangeLCRResult(" + j + "," + a + ", $(this))' />OK<label>&nbsp;&nbsp;"
                            + "<label><input id='cbLcrNG" + j.toString() + a.toString() + "' type='checkbox' "
                            + (Lcrlist[j]["Value" + a] === '0' ? " checked='checked'" : " ")
                            + " onchange='ChangeLCRResult(" + j + "," + a + ", $(this))' />NG<label></td>";
                    }
                    else if (Lcrlist[j].IQCLcrItemType === 0) {
                        html += "<td style='text-align:center; width:9%'><input type='text' style='width:90%' value='" + Lcrlist[j]["Value" + a] + "' onchange='ChangeLcrValue(" + j + "," + a + ", $(this))'/></td>";
                    }
                }
                html += "<tr>";
            }
            html += "</table>";
            $("#divDtl").append(html);
        }

        //LCR检验项值保存
        function ChangeLcrValue(j, a, t) {
            Lcrlist[j]["Value" + a] = $(t).val();
        }

        //LCR检验结果选择改变
        function ChangeLCRResult(j, a, t) {
            var ida = j.toString() + a.toString();
            var cb = ($(t).attr('id').substr(0, 7) == "cbLcrOK" ? "cbLcrNG" : "cbLcrOK") + ida;
            $("#" + cb).removeAttr('checked');
            Lcrlist[j]["Value" + a] = $("#cbLcrOK" + ida).attr('checked') ? 1 : ($("#cbLcrNG" + ida).attr('checked') ? 0 : null);
        }

        //保存检验信息
        function SaveForm() {
            var entity = {};
            if ($("#cbFormOK").attr('checked') == null && $("#cbFormNG").attr('checked') == null) {
                alert("请选择检验结果");
                return false;
            }

            entity.ProductPQCId = ProductPQCId;
            entity.InspectionResult = $("#cbFormOK").attr('checked') ? 1 : ($("#cbFormNG").attr('checked') ? 0 : null);
            //最终结果
            if ($("#Checkbox1").is(':checked')) {
                entity.FinishResult = 1;
            }
            else if ($("#Checkbox2").is(':checked')) {
                entity.FinishResult = 2;
            }
            else if ($("#Checkbox3").is(':checked')) {
                entity.FinishResult = 3;
            }
            opportunity();
            
            entity.InspectionUser = ""; //检验人
            entity.ProdGroup = $.trim($("#txtProdGroup").val()); //生产组长
            entity.QualityQc = $.trim($("#txtQualityQc").val()); //品质QC
            entity.ProdSign = $.trim($("#txtProdSign").val()); //生产会签
            entity.TechSign = $.trim($("#txtTechSign").val()); //工艺会签
            entity.QualitySign = $.trim($("#txtQualitySign").val()); //品质批准
            entity.Auditing = $.trim($("#txtSign").val());
            entity.PrintLv = $.trim($("#txtPrintLv").val());
            entity.Remark = $.trim($("#txtRemark").val());
            entity.ModifyBy = userName;
            entity.CheckList = JSON.stringify(listItem);
            entity.LrcList = JSON.stringify(Lcrlist);
            //检验时机
            entity.OpporList = JSON.stringify(opportunityList);

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxInspectionOQC.SavePqcCheck(JSON.stringify(entity));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return;
            }
            alert("保存成功！");
            parent.Refresh();
        }
        //检验时机
        var opportunityList = [];
        function opportunity() {
            var model = {};
            model.ProdType = 1;
            model.Remark = "";
            if ($("#checkOrder").is(':checked')) {
                model.Remark = "1";
            }
            opportunityList.push(model);
            var model2 = {};
            model2.ProdType = 2;
            model2.Remark = "";
            if ($("#checkItem").is(':checked')) {
                model2.Remark = "1";
            }
            opportunityList.push(model2);
            var model3 = {};
            model3.ProdType = 3;
            model3.Remark = "";
            if ($("#checkProd").is(':checked')) {
                model3.Remark = "1";
            }
            opportunityList.push(model3);
            var model4 = {};
            model4.ProdType = 4;
            model4.Remark = "";
            if ($("#checkEqui").is(':checked')) {
                model4.Remark = "1";
            }
            opportunityList.push(model4);
            var model5 = {};
            model5.ProdType = 5;
            model5.Remark = "";
            if ($("#checkTech").is(':checked')) {
                model5.Remark = "1";
            }
            opportunityList.push(model5);
            var model6 = {};
            model6.ProdType = 6;
            model6.Remark = "";
            if ($("#checkLine").is(':checked')) {
                model6.Remark = "1";
            }
            opportunityList.push(model6);
            var model7 = {};
            model7.ProdType = 7;
            model7.Remark = "";
            if ($("#checkOther").is(':checked')) {
                model7.Remark = $.trim($("#txtOther").val());
            }
            opportunityList.push(model7);
        }
        //GRN不合格信息
        function GrnNg() {
            dialog({ title: "IQC记录GRN信息", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Quality/IQCFormBack.aspx?name=Material_IQCFormBack&ID=" + ProductPQCId + "&rnd=" + Math.random(), width: 750, height: 368 });
        }

        function Refresh() {
            document.forms[0].submit();
        }
    </script>
</asp:Content>
