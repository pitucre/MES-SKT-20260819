<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    ValidateRequest="false" CodeBehind="CollectAssyMatInfo.aspx.cs" Inherits="SKT.LeanMES.Web.Client.CollectAssyMatInfo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %></div>
    <table class="EditeContentTable" width="100%" id="tbAssyData">
        <tr>
            <td class="Label1">
                部件条码
            </td>
            <td class="Field1">
                <span id="lblAssySn"></span>
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        var sn = getQueryString("SN");
        var mainSN = getQueryString("MainSN");
        var isReplace = getQueryString("IsReplace");
        var isValid = true;
        var errmsg = "";
        var n;

        $().ready(function () {
            $("#lblAssySn").text(sn);
            loadAssyDataInfo();
        });

        /**
        *   加载数据采集信息1
        **/
        function loadAssyDataInfo() {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxAssemble.GetAssyDataDetailInfo(sn, mainSN);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, sn, ajax.error.Message);
                return false;
            }
            loadAssyDataTable(ajax);
        }

        /**
        *   加载数据采集信息2
        **/
        function loadAssyDataTable(list) {
            var row, cell;
            var tabField = document.getElementById("tbAssyData");
            var entityAry = list.value;
            if (entityAry != null && entityAry.length > 0) {
                for (var i = 0; i < entityAry.length; i++) {
                    addDataField(tabField, entityAry[i]);
                }
                if (entityAry.length > 0) {
                    $("#tbAssyData").find("input[type=text]").eq(0).focus();
                }
                row = tabField.insertRow(tabField.rows.length);
                cell = row.insertCell(0);
                cell.className = "Label1";
                cell.innerHTML = '';
                cell = row.insertCell(1);
                cell.className = "Field1";
                cell.innerHTML = '<input type="button" value=" 确 定 " onclick="save();" />';

                $("input[name='dateAssyFields']").datepicker({
                    showHms: false
                });
                $("input[name='intAssyFields']").keyup(function () {
                    getDecimalVal(this);
                });

                $("input[name='AssyFields']").change(function (obj) {
                    var regular = ($(this).attr("RegularExpression"));
                    if (regular != undefined && regular != "") {
                        var regularArr = regular.split(';');
                        var reg;
                        if (regularArr != undefined && regularArr.length > 0 && $.trim($(this).val()) != "") {
                            for (var i = 0; i < regularArr.length; i++) {
                                reg = new RegExp(regularArr[i]);
                                if (!reg.test($(this).val())) {
                                    errmsg = "[" + $(this).val() + "]不符合系统定义的字符格式！";
                                    alert(errmsg);
                                    n = $(this).attr("AssyFieldId");
                                    isValid = false;
                                    setTimeout(function () {
                                        $("input[AssyFieldId='" + n + "']").val("").focus();
                                    }, 100);
                                    return;
                                }
                                else {
                                    isValid = true;
                                }
                            }
                        }
                    }
                });
            } else {
                $(tabField).html('<tr class="ListTableOddRow"><td style="text-align:center;">没有需要采集的数据！</td></tr>');
            }
        }

        /**
        *   加载数据采集信息3
        **/
        function addDataField(tabDatas, entityData) {
            var row, cell;
            var dataTag = "";
            row = tabDatas.insertRow(tabDatas.rows.length);
            row.className = "ListTableOddRow";

            dataTag = entityData.Required == false ? entityData.DataTag : entityData.DataTag + "<em>*</em>";

            cell = row.insertCell(0);
            cell.className = "Label1";
            cell.innerHTML = '<input type="hidden" name="hidDataFieldId" value="' + entityData.DataFieldId + '" />' + dataTag;

            var selectType = entityData.DataType;
            var isRequried = entityData.Required == false ? "" : "IsRequired='1'";
            var regularExpression = (entityData.RegularExpression);
            var innerHtml = '<input type="text" ' + isRequried + ' id="txtSN" name="AssyFields" AssyFieldId=' + entityData.DataFieldId + ' AssyField="AssyFields" value="' + entityData.FieldValue + '" RegularExpression="' + regularExpression + '" />';

            if (selectType == "Date") {
                innerHtml = '<input type="text" readonly="readonly" id=' + entityData.DataTag + ' ' + isRequried + '  name="dateAssyFields" AssyFieldId=' + entityData.DataFieldId + ' AssyField="AssyFields" value="' + entityData.FieldValue + '"  RegularExpression="' + regularExpression + '" />';
            }
            else if (selectType == "Number") {
                innerHtml = '<input type="text" id=' + entityData.DataTag + ' ' + isRequried + ' name="intAssyFields" AssyFieldId=' + entityData.DataFieldId + ' AssyField="AssyFields" value="' + entityData.FieldValue + '"  RegularExpression="' + regularExpression + '" />';
            }
            else if (selectType == "CheckBox") {
                var check = '';
                if (entityData.FieldValue == "true") {
                    check = 'checked="true"';
                }
                innerHtml = '<input type="checkbox" ' + check + '  id=' + entityData.DataTag + ' ' + isRequried + ' name="chkAssyFields" AssyFieldId=' + entityData.DataFieldId + '  AssyField="AssyFields" />';
            }
            cell = row.insertCell(1);
            cell.className = "Field1";
            cell.innerHTML = innerHtml;

        }

        /**
        *   保存数据采集信息
        **/
        function save() {
            if (SubmitValidation()) {
                if (!isValid) {
                    return false;
                }
                $("input[name='AssyFields']").each(function (obj) {
                    var regular = ($(this).attr("RegularExpression"));
                    if (regular != undefined && regular != "") {
                        var regularArr = regular.split(';');
                        var reg;
                        if (regularArr != undefined && regularArr.length > 0) {
                            for (var i = 0; i < regularArr.length; i++) {
                                reg = new RegExp(regularArr[i]);
                                if (!reg.test($(this).val())) {
                                    errmsg = "[" + $(this).val() + "]不符合系统定义的字符格式！";
                                    alert(errmsg);
                                    isValid = false;
                                    n = $(this).attr("AssyFieldId");
                                    setTimeout(function () {
                                        $("input[AssyFieldId='" + n + "']").val("").focus();
                                    }, 100);
                                    return false;
                                }
                                else {
                                    isValid = true;
                                }
                            }
                        }
                    }
                });

                if (!isValid) {
                    return false;
                }
                var assyFieldIds = $("input[name=hidDataFieldId]");
                var assyFieldValues = $("input[AssyField='AssyFields']");
                var xml = '<Assy>';
                var fieldVal = "";
                for (var i = 0; i < assyFieldValues.length; i++) {
                    fieldVal = assyFieldValues[i].value;
                    if (assyFieldValues[i].type == "checkbox") {
                        fieldVal = assyFieldValues[i].checked;
                    }

                    xml += '<AssyFiled DataFieldId="';
                    xml += assyFieldIds[i].value + '"';
                    xml += ' FieldValue="';
                    xml += fieldVal + '"';
                    xml += '></AssyFiled>';
                }
                xml += '</Assy>';

                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxAssemble.AssyDataDetailEdit(sn, xml);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    //写入日志
                    SaveUserUILog("一般", stationId, resourceId, sn, ajax.error.Message);
                    return false;
                }

                if (isReplace == "1") {
                    window.parent.closeDetail();
                }
                else {
                    window.parent.showAreaMessge(sn + "：数据采集成功！", "messageGreen");
                    window.parent.closeDetail();
                }

            }

        }
                        
    </script>
</asp:Content>
