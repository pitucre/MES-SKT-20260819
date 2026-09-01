<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="SupplierExameResultReExam.aspx.cs" Inherits="SKT.LeanMES.Web.Warehouse.SupplierExameResultReExam" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label3">
                考核类型
            </td>
            <td class="Field5">
                <asp:DropDownList runat="server" ID="ddlSupplierExameTempletType" Width="70px" ClientIDMode="Static">                    
                    <asp:ListItem Value="月度" Selected="True">月度</asp:ListItem>
                    <asp:ListItem Value="季度">季度</asp:ListItem>
                    <asp:ListItem Value="年度">年度</asp:ListItem>
                </asp:DropDownList>                     
            </td>
            <td class="Label3">
                考核时间
            </td>
            <td class="Field2">
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
            <td class="Label3">
                供应商
            </td>
            <td class="Field3">
                <input type="text" id="txtVenCode" class="TextBox" disabled="disabled" style="width:100px"/>
                <input type="button" class="ButtonBox" value="..." onclick="chooseVendorCode()" />
            </td>
            <td class="Field2">
                <input id="btnSearch" class="button" type="button" style="margin-right: 10px;" onclick="searchExamData()" value="重算"/>          
            </td>
        </tr>
    </table>
    <table id="tblExam" cellspacing="0" cellpadding="4" style="border-width: 0px; width: 100%; border-collapse: collapse; margin-top: 5px;"
        class="EditeContentTable">
        <tr class="ListTableHeader">
            <th scope="col" style="width: 15%;">考核时间</th>
            <th scope="col" style="width: 15%;">供应商编码</th>
            <th scope="col" style="width: 20%;">考核内容</th>
            <th scope="col" style="width: 20%;">考核方式</th>
            <th scope="col" style="width: 10%;">考核分数</th>
            <th scope="col" style="width: 10%;">权重</th>
            <th scope="col" style="width: 10%;">加权分</th>
        </tr>
        <tr id="trNewInfo" class="ListTableOddRow">
            <td colspan="7" style="text-align: center;">
                <%=Resources.Messages.HaveNothingData%>
            </td>
        </tr>
    </table>   
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

        function chooseVendorCode(obj) {
            dialog({
                title: "<%=Resources.Common.ChooseWindow %>"
                , src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=34&CallBackFunc=getChooseValue&Multiple=true&rnd="
                    + Math.random(), width: 600, height: 300
            });
        }

        function getChooseValue(list) {
            $("#txtVenCode").val(list[0][1]);
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

            var venCode = $("#txtVenCode").val();
            if (venCode == "") {
                alert("请选择供应商");
                return;
            }

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSupplierExame.SearchExamDataSupplier(examType, examData, venCode);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            var list = ajax.value;
            if (list.length > 0) {
                $("#trNewInfo").remove();
                $("#tblExam").html('<tr class="ListTableHeader"> <th scope="col" style="width: 15%;">考核时间</th> <th scope="col" style="width: 15%;">供应商编码</th><th scope="col" style="width: 20%;">考核内容</th>' +
                                        '<th scope="col" style="width: 20%;">考核方式</th> <th scope="col" style="width: 10%;">考核分数</th> <th scope="col" style="width: 10%;">权重</th>' +
                                        '<th scope="col" style="width: 10%;">加权分</th></tr>');
                var totalGrades = 0;
                for (i = 0; i < list.length; i++) {
                    AddNewDetail(list[i]);
                    totalGrades = totalGrades + list[i].WeightGrades;
                }

                //总计分
                entity = {};
                entity.ExameDate = "合计";
                entity.VendorCode = "";
                entity.SupplierExameName = "";
                entity.SupplierExameType = "自动计算";
                entity.SupplierExameContentResultID = "";
                entity.Grades = "";
                entity.AssessmentWeight = "";
                entity.WeightGrades = totalGrades;
                AddNewDetail(entity);
            }
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

            //考核方式
            cell = row.insertCell(3);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = entity.ExameDate == "合计" ? "" : entity.SupplierExameType;

            //考核分数
            cell = row.insertCell(4);
            cell.align = "center";
            cell.className = "Field";
            if ("手工计算" == entity.SupplierExameType) {
                cell.innerHTML = "<input type=\"text\" IsRequired='1' id='" + entity.SupplierExameContentResultID + "' style=\" width:90%;\"  class=\"TextBox\" value=\"" + entity.Grades
                    + "\" onkeyup=\"this.value=this.value.replace(/[^\\d.]/g,'')\" onafterpaste=\"this.value=this.value.replace(/[^\\d.]/g,'')\"  onchange=\"ChangeData(this)\"/>";
            }
            else {
                cell.innerHTML = entity.Grades;
            }

            //权重
            cell = row.insertCell(5);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = entity.AssessmentWeight;

            //加权分
            cell = row.insertCell(6);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = entity.WeightGrades;
        }


        function ChangeData(obj) {
            $(obj).attr("Update", "1");
            $(obj).parent().parent().css("color", "red");
            $(obj).parent().parent().find("td:eq(6)").html(parseFloat($(obj).parent().parent().find("td:eq(5)").html()) * parseInt($(obj).val()) / 100);

            var j = 1; var totalGrades = 0;
            for (j = 1; j < tab.rows.length - 1; j++) {//去掉标题行和总计行
                totalGrades = totalGrades + parseFloat($.trim($(tab.rows[j]).find("td:eq(6)").html()));
            }

            $(obj).parent().parent().parent().find("tr:last-child td:eq(6)").html(totalGrades);
        }

        function Save() {           
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
    </script>
</asp:Content>
