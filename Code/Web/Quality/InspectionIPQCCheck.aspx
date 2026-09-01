<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    CodeBehind="InspectionIPQCCheck.aspx.cs" Inherits="SKT.LeanMES.Web.Quality.InspectionIPQCCheck" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
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
                    工单编号
                </td>
                <td class="Field3">
                    <span id="txtOrderNo"></span>
                </td>
                <td class="Label3">
                    工单数量
                </td>
                <td class="Field3">
                    <span id="txtOrderQty"></span>
                </td>
                <td class="Label3">
                    版本
                </td>
                <td class="Field3">
                    <input type="text" id="txtPrintLv" value="RF-GI-QM-081-01-V1.0" style="width: 160px" />
                </td>
            </tr>
            <tr>
                <td class="Label3">
                    生产确认
                </td>
                <td class="Field3">
                    <input type="text" id="txtProdUser" style="width: 90%" />
                </td>
                <td class="Label3">
                    检验员
                </td>
                <td class="Field3">
                    <input type="text" id="txtCheck" style="width: 90%" />
                </td>
                <td class="Label3">
                    审核
                </td>
                <td class="Field3">
                    <input type="text" id="txtSign" style="width: 90%" />
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
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label" style="width: 20%; text-align: center">
                备注：
            </td>
            <td class="Field" style="width: 80%; text-align: center">
                <input id="txtRemark" type="text" style="width: 97%; height: 30px" name="name" value="" />
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        var tab = document.getElementById("tblExpand");
        var TypeId = '<%=Request["TypeId"] %>'; /*页面布局  1：审核 2：检验  10：综合*/
        var name = '<%=Request["name"] %>'; //Material_IQCFormView查看
        var InspectionTypeId = '<%=Request["InspectionTypeId"]  %>';  /*验检单类型 */
        var ProductIPQCId = '<%=Request["IOrderId"]??"-1"  %>';    /*检验单ID*/
        var IOrderId = ProductIPQCId;                              /*检验单ID*/

        var userName = "<%=userName %>";
        var ItemCode = "";
        var moCount = 0; //  模版项计数
        var moTempCount = 0; //  模版项计数
        var ShowMessCount = 0;
        var ShiftType = "";
        //模版检验项列表
        var listItem = [];
        var listTempItem = [];

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
            if (name === 'Material_IQCFormView') {
                $('input').attr("disabled", "disabled");
                $("#trSaveOrderBtn").css("display", "none");
            }
        });
        
        //获取根据检验单Id获取检验信息
        function getFormInfo() {
            var entity = {};
            entity.ProductIPQCId = IOrderId;
            var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("upsGetIPQCTemplateModel", JSON.stringify(entity));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                if (ProductIPQCId != -1) {
                    parent.Refresh();
                }
                return;
            }
            if (ajax.value != null) {
                var en = $.parseJSON(ajax.value);
                ItemCode = en.data[0].ItemCode;

                $("#spanInspectionOrderNo").html(en.data[0].ProductIPQCNo);
                $("#spanInspectionItemCode").html(ItemCode);
                $("#spanInspectionOrderQty").html(en.data[0].InspectionQty);
                $("#txtOrderNo").html(en.data[0].OrderNO);
                $("#txtOrderQty").html(en.data[0].Qty_to_Build);
                $("#txtSign").val(en.data[0].Auditing);

                if (en.data[0].InspectionUser != null && en.data[0].InspectionUser != "") {
                    $("#txtCheck").val(en.data[0].InspectionUser);
                }
                if (en.data[0].PrintLv != null && en.data[0].PrintLv != "") {
                    $("#txtPrintLv").val(en.data[0].PrintLv);
                }
                if (en.data[0].Remark != null && en.data[0].Remark != "") {
                    $("#txtRemark").val(en.data[0].Remark);
                }
                if (en.data[0].ProdUser != null && en.data[0].ProdUser != "") {
                    $("#txtProdUser").val(en.data[0].ProdUser);
                }
                ShiftType = en.data[0].ShiftType; //班别
                //加载检验模版项
                moCount = 0;
                moTempCount = 0;
                LoadInspectionItem(en.data1);
                //加载LCR检验项
                //DetailLcrItem(en.data[0].ProductIPQCId);
            }
        }
        
        //加载检验模版项
        function LoadInspectionItem(data1) {
            $("#divDtl").append("");
            $("#divDtl").empty();
            listItem = [], moCount = 0, moTempCount = 0;
            for (var i = 0; i < data1.length; i++) {
                var tempName = data1[i].InspectionTemplateName;
                if (tempName.indexOf('常规生产') > -1) {
                    DetailItem(data1[i].ProductIPQCId, data1[i].InspectionTemplateId);
                }
                if (tempName.indexOf('生产过程') > -1) {
                    DetailTemplateItem(data1[i].ProductIPQCId, data1[i].InspectionTemplateId);
                }
            }
        }

        //模版检验项详细资料取得绑定
        function DetailItem(ProductIPQCId, InspectionTemplateId) {
            var entity = {};
            entity.InspectionId = ProductIPQCId;
            entity.TemplateId = InspectionTemplateId;
            
            var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("upsGetIPQCTemplateItem", JSON.stringify(entity));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return;
            }
            var value = $.parseJSON(ajax.value);

            //模版头添加
            var head = value.data[0];

            //加载检验项
            var Dtllist = value.data1;
            console.info(Dtllist);
            var InsItemNamestr = "", InsItemNamestrT = "", Jugestr = "", According = "", DelRow = "";

            html = "<table id='tbDtl" + head.InspectionTemplateId + "' class='ListTable' style='border-width:0px;width:100%;border-collapse:collapse; margin-top:5px;'  >"
                    + "<tr class='ListTableHeader' ><th colspan='7' >" + head.InspectionTemplateName + "</th></tr>"
                    + "<tr class='ListTableHeader' ><th>序号</th><th>检验项目</th><th>检验结果</th>"
                    + "<th>序号</th><th>检验项目</th><th>检验结果</th>"
                    + (name === 'Material_IQCFormView' ? "" : "<th id='delId' style='color: #0066CC; cursor: pointer;' onclick='AddCheckItem(" + head.InspectionTemplateId + ")'>+添加检验项</th>") + "</tr>";
            for (var j = 0; j < Dtllist.length; j = j + 2) {
                Dtllist[j].CountRow = moCount;
                //复制
                var en = {}, eItem = JSON.stringify(Dtllist[j]);
                $.extend(en, Dtllist[j]);
                en.CheckResult = Dtllist[j].CheckResult === "" ? null : Dtllist[j].CheckResult;
                listItem.push(en);

                //检验项目
                InsItemNamestr = Dtllist[j].IsCustom === 1 ? ("<input type='text' IsRequired='1' style='width:90%' value='" +
                        Dtllist[j].InspectionItemName + "' onchange='ChangeInsItemName(" + moCount + ", $(this))'/>")
                    : Dtllist[j].InspectionItemName;


                DelRow = name === 'Material_IQCFormView' ? "" :
                    ("<td style='text-align:center; width:5%'>" +
                        (Dtllist[j].IsCustom === 1 ? "<span style=\"CURSOR: pointer; COLOR: #0000ff;\" onclick=\"deleteItem(" + moCount + ", $(this))\"><%= Resources.Buttons.COM_Delete %></span>" : "") + "</td>");

                var k = j + 1;
                if (Dtllist[k] != null) {
                    Dtllist[k].CountRow = moCount + 1;
                    //复制
                    var enT = {}, eItemT = JSON.stringify(Dtllist[k]);
                    $.extend(enT, Dtllist[k]);
                    enT.CheckResult = Dtllist[k].CheckResult === "" ? null : Dtllist[k].CheckResult;
                    listItem.push(enT);

                    //检验项目
                    InsItemNamestrT = Dtllist[k].IsCustom === 1 ? ("<input type='text' IsRequired='1' style='width:90%' value='" +
                        Dtllist[k].InspectionItemName + "' onchange='ChangeInsItemName(" + parseInt(moCount + 1) + ", $(this))'/>")
                    : Dtllist[k].InspectionItemName;

                    DelRow = name === 'Material_IQCFormView' ? "" :
                    ("<td style='text-align:center; width:5%'>" +
                        (Dtllist[k].IsCustom === 1 ? "<span style=\"CURSOR: pointer; COLOR: #0000ff;\" onclick=\"deleteItem(" + moCount + ", $(this))\"><%= Resources.Buttons.COM_Delete %></span>" : "") + "</td>");

                    html += "<tr class='ListTableOddRow'><td style='text-align:left; width:3%'>" + (j + 1).toString() + "</td>"
                        + "<td style='text-align:left; width:20%'>" + InsItemNamestr + "</td>"
                        + "<td style='text-align:left; width:10%'><label><input id='cbOK" + moCount + "' type='checkbox' "
                            + (Dtllist[j].CheckResult === 1 ? " checked='checked'" : " ") + " onchange='ChangeResult(" + moCount + ", $(this))' />OK</label>&nbsp;&nbsp;"
                        + "<label><input id='cbNG" + moCount + "' type='checkbox' " + (Dtllist[j].CheckResult === 0 ? "checked='checked'" : "")
                            + " onchange='ChangeResult(" + moCount + ", $(this))' />NG</label></td>"

                        + "<td style='text-align:left; width:3%'>" + (k + 1).toString() + "</td>"
                        + "<td style='text-align:left; width:20%'>" + InsItemNamestrT + "</td>"
                        + "<td style='text-align:left; width:10%'><label><input id='cbOK" + parseInt(moCount + 1) + "' type='checkbox' "
                            + (Dtllist[k].CheckResult === 1 ? " checked='checked'" : " ") + " onchange='ChangeResult(" + parseInt(moCount + 1) + ", $(this))' />OK</label>&nbsp;&nbsp;"
                        + "<label><input id='cbNG" + parseInt(moCount + 1) + "' type='checkbox' " + (Dtllist[k].CheckResult === 0 ? "checked='checked'" : "")
                            + " onchange='ChangeResult(" + parseInt(moCount + 1) + ", $(this))' />NG</label></td>"

                        + DelRow
                        + "</tr>";
                }
                else {
                    html += "<tr class='ListTableOddRow'><td style='text-align:left; width:3%'>" + (j + 1).toString() + "</td>"
                        + "<td style='text-align:left; width:20%'>" + InsItemNamestr + "</td>"
                        + "<td style='text-align:left; width:10%'><label><input id='cbOK" + moCount + "' type='checkbox' "
                            + (Dtllist[j].CheckResult === 1 ? " checked='checked'" : " ") + " onchange='ChangeResult(" + moCount + ", $(this))' />OK</label>&nbsp;&nbsp;"
                        + "<label><input id='cbNG" + moCount + "' type='checkbox' " + (Dtllist[j].CheckResult === 0 ? "checked='checked'" : "")
                            + " onchange='ChangeResult(" + moCount + ", $(this))' />NG</label></td>"

                        + "<td style='text-align:left; width:3%'></td>"
                        + "<td style='text-align:left; width:20%'></td>"
                        + "<td style='text-align:left; width:10%'></td>"

                        + DelRow
                        + "</tr>";
                }
                moCount = moCount + 2;

            }
            html += "</table>";
            $("#divDtl").append(html);
        }
        //模版检验项详细资料取得绑定
        function DetailTemplateItem(ProductIPQCId, InspectionTemplateId) {
            var entity = {};
            entity.InspectionId = ProductIPQCId;
            entity.TemplateId = InspectionTemplateId;

            var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("upsGetIPQCTemplateItemSN", JSON.stringify(entity));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return;
            }
            var value = $.parseJSON(ajax.value);

            //模版头添加
            var head = value.data[0];

            //加载检验项
            var Dtllist = value.data1;

            var InsItemNamestr = "", InsItemNamestrT = "", Jugestr = "", According = "", DelRow = "";

            var htmlShiftType = "";
            if (ShiftType == "白班") {
                htmlShiftType = "<th>08:30-09:59</th><th>10:00-11:59</th><th>12:00-15:14</th><th>15:15-17:44</th><th>17:45-20:30</th>";
            }
            else if (ShiftType == "晚班") {
                htmlShiftType = "<th>20:30-21:59</th><th>22:00-23:59</th><th>00:00-03:14</th><th>03:15-05:44</th><th>05:45-08:29</th>";
            }
            else {
                return;
            }
            var Temphtml = "<table id='tbTemplateDtl" + head.InspectionTemplateId + "' class='ListTable' style='border-width:0px;width:100%;border-collapse:collapse; margin-top:5px;'  >"
                    + "<tr class='ListTableHeader' ><th colspan='11'>" + head.InspectionTemplateName + "</th></tr>"
                    + "<tr class='ListTableHeader' ><th colspan='2'>巡检关键工序</th><th>检验项目</th>"
                    + htmlShiftType
                    + "<th>不良汇总</th><th>产品序列号</th>"
                    + (name === 'Material_IQCFormView' ? "" : "<th id='delId' style='color: #0066CC; cursor: pointer;' onclick='AddCheckTempItem(" + head.InspectionTemplateId + ")'>+添加检验项</th>") + "</tr>";

            for (var j = 0; j < Dtllist.length; j++) {
                Dtllist[j].CountRow = moTempCount;
                //复制
                var en = {}, eItem = JSON.stringify(Dtllist[j]);
                $.extend(en, Dtllist[j]);
                en.CheckResult = Dtllist[j].CheckResult === "" ? null : Dtllist[j].CheckResult;
                listTempItem.push(en);

                InsItemNameTwo = Dtllist[j].InspectionTemplateId === -1 ? ("<input type='text' id='TempOne" + moTempCount + "' IsRequired='1' style='width:90%' value='" +
                        Dtllist[j].TwoName + "'/>")
                    : Dtllist[j].TwoName;

                InsItemNameOne = Dtllist[j].InspectionTemplateId === -1 ? ("<input type='text' id='TempTwo" + moTempCount + "' IsRequired='1' style='width:90%' value='" +
                        Dtllist[j].OneName + "'/>")
                    : Dtllist[j].OneName;

                //检验项目
                InsItemNamestr = Dtllist[j].InspectionTemplateId === -1 ? ("<input type='text' id='TempThree" + moTempCount + "' IsRequired='1' style='width:90%' value='" +
                        Dtllist[j].InspectionItemName + "'/>")
                    : Dtllist[j].InspectionItemName;


                DelRow = name === 'Material_PQCFormView' ? "" :
                    ("<td style='text-align:center; width:5%'>" +
                        (Dtllist[j].InspectionTemplateId === -1 ? "<span style=\"CURSOR: pointer; COLOR: #0000ff;\" onclick=\"deleteTempItem(" + Dtllist[j].OneId + ", $(this))\"><%= Resources.Buttons.COM_Delete %></span>" : "") + "</td>");

                if (Dtllist[j].InspectionItemId != null) {
                    Temphtml += "<tr class='ListTableOddRow'><td style='text-align:left; width:5%'>" + Dtllist[j].TwoName + "</td>"
                        + "<td style='text-align:left; width:15%'>" + Dtllist[j].OneName + "</td>"
                        + "<td style='text-align:left; width:22%'>" + Dtllist[j].InspectionItemName + "</td>"
                        + "<td style='text-align:left; width:10%'>" + Dtllist[j].Value1 + "</td>"
                        + "<td style='text-align:left; width:10%'>" + Dtllist[j].Value2 + "</td>"
                        + "<td style='text-align:left; width:10%'>" + Dtllist[j].Value3 + "</td>"
                        + "<td style='text-align:left; width:10%'>" + Dtllist[j].Value4 + "</td>"
                        + "<td style='text-align:left; width:10%'>" + Dtllist[j].Value5 + "</td>"
                        + "<td style='text-align:left; width:6%'>" + Dtllist[j].NgQty + "</td>"
                        + "<td style='text-align:center; width:5%'><span style=\"CURSOR: pointer; COLOR: #0000ff;\" onclick=\"AddSN(" + Dtllist[j].OneId + ", " + IOrderId + "," + Dtllist[j].InspectionTemplateId + ")\">添加</span></td>"
                        + DelRow
                        + "</tr>";
                }
            }

            Temphtml += "</table>";
            $("#divDtl").append(Temphtml);

            //合并单元格
            var setTable = document.getElementById("tbTemplateDtl" + head.InspectionTemplateId);
            var countRow = $("#tbTemplateDtl" + head.InspectionTemplateId).find(".ListTableOddRow").length;
            autoRowSpan(setTable, parseInt(2), parseInt(countRow + 2), 9);
            autoRowSpan(setTable, parseInt(2), parseInt(countRow + 2), 1);
            autoRowSpan(setTable, parseInt(2), parseInt(countRow + 2), 0);
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

        //检验项名称
        function ChangeInsItemName(rowCount, t) {
            $.grep(listItem, function (o, j) {
                if (o.CountRow === rowCount) {
                    o.InspectionItemName = $(t).val();
                };
            });
        }

        //添加额外检验项
        function AddCheckItem(index) {
            var moAddCount = parseInt(parseInt(moCount) + 1);
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

            var newItem = {};
            //赋值行
            $.extend(newItem, listItem[0]);
            newItem.IQCModelCheckId = -1;
            newItem.InspectionTemplateId = index;
            newItem.InspectionItemName = "";
            newItem.InspectJuge = "";
            newItem.InspectionAccording = "";
            newItem.InspectionItemId = -1;
            newItem.CountRow = moAddCount;
            newItem.Discretion = "";
            newItem.CheckResult = null;
            listItem.push(newItem);

            var tRow = $("#tbDtl" + index).find(".ListTableOddRow").length + 1;
            var countRow = parseInt(tRow) * 2 - 1;

            var html = "<tr class='ListTableOddRow'><td style='width:5%'>" + countRow + "</td>"
                        + "<td style='width:15%'><input type='text' style='width:90%' IsRequired='1' onchange='ChangeInsItemName(" + moCount + ", $(this))'/></td>"
                        + "<td style=' width:15%'><label><input id='cbOK" + moCount + "' type='checkbox' "
                            + " onchange='ChangeResult(" + moCount + ", $(this))' />OK</label>&nbsp;&nbsp;"
                        + "<label><input id='cbNG" + moCount + "' type='checkbox' "
                            + " onchange='ChangeResult(" + moCount + ", $(this))' />NG</label></td>"

                        + "<td style='width:5%'>" + parseInt(countRow + 1) + "</td>"
                        + "<td style='width:15%'><input type='text' style='width:90%' IsRequired='1' onchange='ChangeInsItemName(" + moAddCount + ", $(this))'/></td>"
                           + "<td style=' width:15%'><label><input id='cbOK" + moAddCount + "' type='checkbox' "
                            + " onchange='ChangeResult(" + moAddCount + ", $(this))' />OK</label>&nbsp;&nbsp;"
                        + "<label><input id='cbNG" + moAddCount + "' type='checkbox' "
                            + " onchange='ChangeResult(" + moAddCount + ", $(this))' />NG</label></td>"

                        + "<td style='text-align:center; width:5%'><span style=\"CURSOR: pointer; COLOR: #0000ff;\" onclick=\"deleteItem(" + moAddCount + ", $(this))\"><%= Resources.Buttons.COM_Delete %></span></td></tr>";

            $("#tbDtl" + index).append(html);
            moCount = parseInt(moCount + 2);
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

            rowCount = rowCount + 1;
            var index = -1;
            $.grep(listItem, function (o, j) {
                if (o.CountRow === rowCount) {
                    index = j;
                }
            });
            $(t).parent().parent().remove();
            listItem.splice(index, 1);
        }

        //添加额外检验项
        function AddCheckTempItem(index) {
            var newTempItem = {};
            //赋值行
            $.extend(newTempItem, listTempItem[0]);
            newTempItem.CountRow = moTempCount;
            newTempItem.InspectionItemId = -1;
            newTempItem.InspectionItemName = "";
            newTempItem.InspectionTemplateId = index;
            newTempItem.NgQty = 0;
            newTempItem.OneId = -1;
            newTempItem.OneName = "";
            newTempItem.OneParentId = -1;
            newTempItem.ParentId = -1;
            newTempItem.TwoId = -1;
            newTempItem.TwoName = "";
            newTempItem.TwoParentId = -1;
            newTempItem.Value1 = 0;
            newTempItem.Value2 = 0;
            newTempItem.Value3 = 0;
            newTempItem.Value4 = 0;
            newTempItem.Value5 = 0;
            listTempItem.push(newTempItem);

            var countRow = $("#tbTemplateDtl" + index).find(".ListTableOddRow").length + 1;

            var html = "<tr class='ListTableOddRow'><td style='width:5%'><input type='text' style='width:90%' IsRequired='1' id='TempOne"+moTempCount+"' /></td>"
                        + "<td><input type='text' style='width:90%' IsRequired='1' id='TempTwo" + moTempCount + "'/></td>"
                         + "<td><input type='text' style='width:90%' IsRequired='1' id='TempThree" + moTempCount + "'/></td>"
                          + "<td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td>"
                          + "<td></td>"
                        + "<td style='text-align:center; width:5%'><span style=\"CURSOR: pointer; COLOR: #0000ff;\" onclick=\"AddTempItem(" + moTempCount + ", $(this))\">保存</span><span style=\"CURSOR: pointer; COLOR: #0000ff; padding-left:12px;\" onclick=\"deleteTempItem(" + moTempCount + ", $(this))\"><%= Resources.Buttons.COM_Delete %></span></td></tr>";

            $("#tbTemplateDtl" + index).append(html);
            moTempCount++;
        }
        //删除检验项行
        function deleteTempItem(rowCount, t) {

            var entity = {};
            entity.ProdIPQCTempId = parseInt(rowCount);

            var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspDeleteProductIPQCTemp", JSON.stringify(entity));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return;
            }

            var index = -1;
            $.grep(listTempItem, function (o, j) {
                if (o.CountRow === rowCount) {
                    index = j;
                }
            });
            $(t).parent().parent().remove();
            listTempItem.splice(index, 1);
        }
        function AddTempItem(moTempCount, t) {
            var TempOne = $("#TempOne" + moTempCount).val();
            var TempTwo = $("#TempTwo" + moTempCount).val();
            if (TempOne == "" || TempTwo == "") {
                alert("巡检关键工序不能为空");
                return;
            }
            var TempThree = $("#TempThree" + moTempCount).val();
            if (TempThree == "") {
                alert("检验项目不能为空");
                return;
            }

            var entity = {};

            entity.ProductIPQCId = parseInt(ProductIPQCId);
            entity.InspectionItemOneName = TempOne;
            entity.InspectionItemTwoName = TempTwo;
            entity.InspectionItemName = TempThree;
            entity.CreateBy = userName;

            var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("upsSaveIPQCTemp", JSON.stringify(entity));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return;
            }
            alert("保存成功！");
            parent.Refresh();
        }
        //保存检验信息
        function SaveForm() {
            var entity = {};

            entity.ProductIPQCId = parseInt(ProductIPQCId);
            entity.ProdUser = $.trim($("#txtProdUser").val());
            entity.InspectionUser = $.trim($("#txtCheck").val());
            entity.Auditing = $.trim($("#txtSign").val());
            entity.PrintLv = $.trim($("#txtPrintLv").val());
            entity.Remark = $.trim($("#txtRemark").val());
            entity.ModifyBy = userName;
            entity.CheckList = JSON.stringify(listItem);
            
            var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("upsSaveIPQCResult", JSON.stringify(entity));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return;
            }
            alert("保存成功！");
            parent.Refresh();
        }

        function Refresh() {
            document.forms[0].submit();
        }
        //扫描SN
        function AddSN(TempId, InsId, InspectionTemplateId) {
            dialog({ title: "记录产品条码信息", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Quality/InspectionIPQCItem.aspx?name=InspectionIPQCItem&TempId=" + TempId + "&InsId=" + InsId + "&ShiftType=" + ShiftType + "&InspectionTemplateId=" + InspectionTemplateId + "&rnd=" + Math.random(), width: 850, height: 368 });
        }
        //合并单元格
        function autoRowSpan(tb, row, endRow, col) {
            var lastValue = "";
            var value = "";
            var pos = 1;
            for (var i = row; i < endRow; i++) {
                value = tb.rows[i].cells[col].innerHTML;
                if (lastValue == value) {
                    tb.rows[i].deleteCell(col);
                    tb.rows[i - pos].cells[col].rowSpan = tb.rows[i - pos].cells[col].rowSpan + 1;
                    pos++;
                } else {
                    lastValue = value;
                    pos = 1;
                }
            }
        }

    </script>
</asp:Content>
