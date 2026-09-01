<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="SupplierExameResultEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Warehouse.SupplierExameResultEdit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label5">
                考核类型
            </td>
            <td class="Field5">
                <asp:DropDownList runat="server" ID="ddlSupplierExameTempletType" Width="70px" ClientIDMode="Static">                    
                    <asp:ListItem Value="月度" Selected="True">月度</asp:ListItem>
                    <asp:ListItem Value="季度">季度</asp:ListItem>
                    <asp:ListItem Value="年度">年度</asp:ListItem>
                </asp:DropDownList>                     
            </td>
            <td class="Label5">
                考核时间
            </td>
            <td class="Field3">
                <span name="year">年</span>
                <asp:DropDownList runat="server" ID="ddlYear" Width="70px" ClientIDMode="Static"></asp:DropDownList>
                <span name="quarter" style="display:none">季度</span>
                <asp:DropDownList  runat="server" ID="ddlQuarter" Width="70px" ClientIDMode="Static">
                    <asp:ListItem Text="1季度" Value="Q1" Selected="True"></asp:ListItem>
                    <asp:ListItem Text="2季度" Value="Q2"></asp:ListItem>
                    <asp:ListItem Text="3季度" Value="Q3"></asp:ListItem>
                    <asp:ListItem Text="4季度" Value="Q4"></asp:ListItem>
                </asp:DropDownList>
                <span name="month">月份</span>
                <asp:DropDownList  runat="server" ID="ddlMonth" Width="70px" ClientIDMode="Static">
                    <asp:ListItem Text="1月" Value="01" Selected="True"></asp:ListItem>
                    <asp:ListItem Text="2月" Value="02"></asp:ListItem>
                    <asp:ListItem Text="3月" Value="03"></asp:ListItem>
                    <asp:ListItem Text="4月" Value="04"></asp:ListItem>
                    <asp:ListItem Text="5月" Value="05"></asp:ListItem>
                    <asp:ListItem Text="6月" Value="06"></asp:ListItem>
                    <asp:ListItem Text="7月" Value="07"></asp:ListItem>
                    <asp:ListItem Text="8月" Value="08"></asp:ListItem>
                    <asp:ListItem Text="9月" Value="09"></asp:ListItem>
                    <asp:ListItem Text="10月" Value="10"></asp:ListItem>
                    <asp:ListItem Text="11月" Value="11"></asp:ListItem>
                    <asp:ListItem Text="12月" Value="12"></asp:ListItem>
                </asp:DropDownList>
            </td>
            <td class="Field2">
                <input id="btnSearch" class="button" type="button" style="margin-right: 10px;" onclick="searchExamData()" value="查询"/>
                <input id="btnAdd" class="button" type="button" style="margin-right: 10px;" onclick="generateExamData()" value="生成考核内容"/> 
                <input id="btnImport" class="button" type="button" style="margin-right: 10px;" onclick="ImportData()" value="导入结果"/> 
                <input id="btnDowmload" class="button" type="button" style="margin-right: 10px;" onclick="dowmloadTemp()" value="下载导入模板"/>   
                <input id="btnOutPutData" class="button" type="button" style="margin-right: 10px;" onclick="OutPutData()" value="导出数据"/>               
            </td>
            <td class="Field4" style="display:none"> 
                <input type="file" name="fileUpload" id="fileUpload" style="display:none" />
            </td>
        </tr>
    </table>
    <table id="tblExam" cellspacing="0" cellpadding="4" style="border-width: 0px; width: 100%; border-collapse: collapse; margin-top: 5px;"
        class="EditeContentTable">
        <tr class="ListTableHeader">
            <th scope="col" style="width: 15%;">考核时间</th>
            <th scope="col" style="width: 15%;">供应商编码</th>
            <th scope="col" style="width: 40%;">考核内容</th>
            <th scope="col" style="width: 10%;">考核分数</th>
            <th scope="col" style="width: 10%;">权重%</th>
            <th scope="col" style="width: 10%;">加权分</th>
        </tr>
        <tr id="trNewInfo" class="ListTableOddRow">
            <td colspan="7" style="text-align: center;">
                <%=Resources.Messages.HaveNothingData%>
            </td>
        </tr>
    </table>    
    <asp:HiddenField ID="hdnDataString" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="hdnOperate" runat="server" ClientIDMode="Static" />
    <script type="text/javascript" src="../Content/plugin/uploadify/jquery.uploadify.min.js"></script>
    <script type="text/javascript">
        var tab = document.getElementById("tblExam");
        $(document).ready(function () {
            $("span[name='quarter']").css("display", "none");
            $("span[name='month']").css("display", "");

            $("#ddlQuarter").hide();
            $("#ddlMonth").show();


            $("#ddlSupplierExameTempletType").change(function () {
                if ($("#ddlSupplierExameTempletType").val() == "月度") {
                    $("span[name='quarter']").css("display", "none");
                    $("span[name='month']").css("display", "");

                    $("#ddlQuarter").hide();
                    $("#ddlMonth").show();
                }
                else if ($("#ddlSupplierExameTempletType").val() == "季度") {
                    $("span[name='quarter']").css("display", "");
                    $("span[name='month']").css("display", "none");

                    $("#ddlQuarter").show();
                    $("#ddlMonth").hide();
                }
                else if ($("#ddlSupplierExameTempletType").val() == "年度") {
                    $("span[name='quarter']").css("display", "none");
                    $("span[name='month']").css("display", "none");

                    $("#ddlQuarter").hide();
                    $("#ddlMonth").hide();
                }
            });
        });

        function generateExamData() {
            var examType = $("#ddlSupplierExameTempletType").val();
            var examData = "";
            var year = $("#ddlYear").val();
            if (examType == "月度") {
                examData = year + $("#ddlMonth").val();
            }
            else if (examType == "季度") {
                examData = year + $("#ddlQuarter").val();
            }
            else if (examType == "年度") {
                examData = year;
            }

            if (!window.confirm("生成考核结果会将之前生成的结果删除,你确定要重新生成吗?")) {
                return false;
            }

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSupplierExame.GenerateExamData(examType, examData);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert("生成成功");
            var list = ajax.value;
            if (list.length > 0) {
                $("#trNewInfo").remove();
                $("#tblExam").html('<tr class="ListTableHeader"> <th scope="col" style="width: 15%;">考核时间</th> <th scope="col" style="width: 15%;">供应商编码</th>' +
                                        '<th scope="col" style="width: 40%;">考核内容</th> <th scope="col" style="width: 10%;">考核分数</th> <th scope="col" style="width: 10%;">权重%</th>' +
                                        '<th scope="col" style="width: 10%;">加权分</th></tr>');

                for (i = 0; i < list.length; i++) {
                    AddNewDetail(list[i]);
                }                
            }
        }

        function searchExamData() {
            var examType = $("#ddlSupplierExameTempletType").val();
            var examData = "";
            var year = $("#ddlYear").val();
            if (examType == "月度") {
                examData = year + $("#ddlMonth").val();
            }
            else if (examType == "季度") {
                examData = year + $("#ddlQuarter").val();
            }
            else if (examType == "年度") {
                examData = year;
            }

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSupplierExame.SearchExamData(examType, examData);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            
            var list = ajax.value;
            if (list.length > 0) {
                $("#trNewInfo").remove();
                $("#tblExam").html('<tr class="ListTableHeader"> <th scope="col" style="width: 15%;">考核时间</th> <th scope="col" style="width: 15%;">供应商编码</th>'+
                                        '<th scope="col" style="width: 40%;">考核内容</th> <th scope="col" style="width: 10%;">考核分数</th> <th scope="col" style="width: 10%;">权重</th>' +
                                        '<th scope="col" style="width: 10%;">加权分</th></tr>');

                for (i = 0; i < list.length; i++) {
                    AddNewDetail(list[i]);
                }
            }
        }
        function ImportData() {
            $("#fileUpload").click();
        }

        $("#fileUpload").uploadfile({
            uploader: '<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Handler/UploadHander.ashx',
            fileSizeLimit: 10,
            buttonText: "导入结果",
            fileTypeExts: '*.xls;*.xlsx;',
            formData: function () {
                return { 'Action': 'ImportResultData'}
            },
            onUploadStart: function (file) {
                if ($(tab).find("input").length <= 0) {
                    alert("没有需要修改的考核记录!");
                    return false;
                }
                return true;
            },
            onUploadSuccess: function (file, data, response) {
                var list = JSON.parse(data);
                //循环给供应商填写值
                for (i = 0; i < list.length; i++) {
                    var vendorcode = list[i].VendorCode;
                    var grades = list[i].Grades;
                    if (parseInt(grades) == NaN) {
                        continue;
                    }
                    var k = 1;
                    for (k = 1; k < tab.rows.length; k++) {
                        if($.trim($(tab.rows[k]).find("td:eq(1)").html()) == vendorcode){
                            $(tab.rows[k]).find("td input").val(grades);
                            $(tab.rows[k]).find("td input").attr("Update", "1");
                            $(tab.rows[k]).css("color", "red");
                            $(tab.rows[k]).find("td:eq(5)").html(parseFloat($.trim($(tab.rows[k]).find("td:eq(4)").html())) * parseInt(grades) / 100);
                            break;
                        }
                    }
                }
            }
        });

        function dowmloadTemp() {
            window.open('<%=SKT.LeanMES.Web.WebHelper.FileModelRoot+"供应商考核结果导入模板.xlsx" %>', 'excel');
        }

        function ChangeData(obj) {
            $(obj).attr("Update", "1");
            $(obj).parent().parent().css("color", "red");         
            $(obj).parent().parent().find("td:eq(5)").html(parseFloat($(obj).parent().parent().find("td:eq(4)").html()) * parseInt($(obj).val()) / 100);
        }

        function AddNewDetail(entity) {
            var row, cell;
            var rowNewIdx = tab.rows.length;
            row = tab.insertRow(rowNewIdx);
            row.className = "ListTableOddRow";

            //考核时间
            cell = row.insertCell(0);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = entity.ExameDate;

            //供应商编码
            cell = row.insertCell(1);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = entity.VendorCode;

            //考核内容
            cell = row.insertCell(2);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = entity.SupplierExameName;

            //考核分数
            cell = row.insertCell(3);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = "<input type=\"text\" IsRequired='1' id='" + entity.SupplierExameContentResultID + "' style=\" width:90%;\"  class=\"TextBox\" value=\"" + entity.Grades
                + "\" onkeyup=\"limitNumRange(this)\" onafterpaste=\"limitNumRange(this)\"  onchange=\"ChangeData(this)\"/>";

            //权重
            cell = row.insertCell(4);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = entity.AssessmentWeight + "%";

            //加权分
            cell = row.insertCell(5);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = entity.WeightGrades;
        }

        function Save() {
            var examType = $("#ddlSupplierExameTempletType").val();
            var examData = "";
            var year = $("#ddlYear").val();
            if (examType == "月度") {
                examData = year + $("#ddlMonth").val();
            }
            else if (examType == "季度") {
                examData = year + $("#ddlQuarter").val();
            }
            else if (examType == "年度") {
                examData = year;
            }
            var list = [];
            var k = 1;
            for (k = 1; k < tab.rows.length; k++) {
                if ($(tab.rows[k]).find("td input").attr("Update") == "1") {
                    var entity = {};
                    entity.SupplierExameContentResultID = parseInt($(tab.rows[k]).find("td input").attr("id"));
                    entity.Grades = parseFloat($(tab.rows[k]).find("td input").val());
                    list.push(entity);
                }
            }            
            if (list.length <= 0) {
                alert("没有修改的考核记录!");
                return false;
            }
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSupplierExame.SaveExamChangeData(list);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert("保存成功");
            parent.window.UpdateList();
        }
        var hdnOperate = $("#hdnOperate");
        var hdnDataString = $("#hdnDataString");
        function OutPutData() {
            var examType = $("#ddlSupplierExameTempletType").val();
            var examData = "";
            var year = $("#ddlYear").val();
            if (examType == "月度") {
                examData = year + $("#ddlMonth").val();
            }
            else if (examType == "季度") {
                examData = year + $("#ddlQuarter").val();
            }
            else if (examType == "年度") {
                examData = year;
            }

            if ($(tab).find("input").length <= 0) {
                alert("没有需要导出的考核记录!");
                return false;
            }

            hdnDataString.val(examType + "," + examData);
            hdnOperate.val("exportexcel");
            document.forms[0].submit();
            hdnOperate.val("");
        }

        //限制文本框的数字输入范围
        function limitNumRange(input, min, max) {
            //参数处理
            min = min | 0;
            max = max | 100;
            if (!input || !input.value) return;
            //移除非数字
            input.value = input.value.replace(/[^\d]/g, '')
            //限制范围
            if (!input.value) return;
            var num = parseInt(input.value);
            if (num < min) {
                num = min;
            }
            if (num > max) {
                num = max;
            }
            input.value = num;
        }
    </script>
</asp:Content>
