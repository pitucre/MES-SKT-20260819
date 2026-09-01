<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    CodeBehind="EquipmentExceptionReportingEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Equipment.EquipmentExceptionReportingEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <div class="infoTips">
        <span>点击[添加异常方案]可新增异常方案</span>,<em>*</em><span>为必填项</span>
    </div>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label4">
                异常上报方案编号<em>*</em>
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtExceptionReportingCode" MaxLength="20" runat="server" CssClass="TextBox" IsRequired="1"></asp:TextBox>
            </td>
            <td class="Label4">
                异常上报方案名称<em>*</em>
            </td>
            <td class="Field4">
                <asp:TextBox ID="txtExceptionReportingName" MaxLength="20" runat="server" CssClass="TextBox" IsRequired="1"></asp:TextBox>
            </td>
            <td class="Label4">
                <%=Resources.lang.Status %>
            </td>
            <td class="Field4">
                <asp:HiddenField ID="txtHideInspectionTemplateId" runat="server" />
                <asp:HiddenField ID="txtHideCreateTime" runat="server" />
                <asp:HiddenField ID="txtHideCreater" runat="server" />
                <asp:DropDownList runat="server" ID="ddlStatus">
                    <asp:ListItem>启用</asp:ListItem>
                    <asp:ListItem>禁用</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="Label4">
                <%=Resources.lang.AC_OBA_Rev%>
            </td>
            <td class="Field4">
                <asp:TextBox ID="txtVersion" MaxLength="50" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label4">
                <%=Resources.lang.Description%>
            </td>
            <td class="Field4" >
                <asp:TextBox ID="txtDescription" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label4" >
                类型
            </td>
            <td class="Field4" >
                <asp:DropDownList ID="ddlExceptionType" runat="server" AutoPostBack="false" ClientIDMode="Static">
                    <asp:ListItem Value="">--请选择--</asp:ListItem>
                    <asp:ListItem Value="点检异常上报">点检异常上报</asp:ListItem>
                    <asp:ListItem Value="保养异常上报">保养异常上报</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
    </table>
    <table id="tblExpand" cellspacing="0" cellpadding="4" style="border-width: 0px; width: 100%; border-collapse: collapse; margin-top: 5px;"
        class="EditeContentTable">
        <tr class="ListTableHeader" style="text-align: center">
            <th scope="col" style="width: 5%;">序号
            </th>
            <th scope="col" style="width: 13%;">
                异常上报等级
            </th>
            <th scope="col" style="width: 8%;" id="trLrfs">
                超时时长
            </th>
            <th scope="col" style="width: 10%;" id="trDw">
                单位
            </th>
            <th scope="col" style="width: 33%;">
                预警接收人
            </th>
            <th scope="col" onclick="chooseInspectionItem(null);" style="color: #0066CC; cursor: pointer; width: 5%;">
                <span>+添加异常方案</span>
            </th>
        </tr>
        <tr id="trNewInfo" class="ListTableOddRow">
            <td colspan="9" style="text-align: center;">
                <%=Resources.Messages.HaveNothingData%>
            </td>
        </tr>
    </table>
    <input type="hidden" id="controlId" />
    <input type="hidden" id="hdInspectionTypeId" runat="server" />
    <input type="hidden" id="hdinspecType" value="-1" />
    <script type="text/javascript" src="../Content/js/jquery-3.1.0.min.js"></script>
    <script type="text/javascript" charset="utf-8" src="../Content/plugin/jquery-easyui-1.4.2/layer/layer.js"></script>
    <style type="text/css">
        .selectRow td {
            background-color: #C4C4C4;
        }

        .pointer {
            cursor: pointer;
        }
    </style>
    <script language="javascript" type="text/javascript">

        var tab = document.getElementById("tblExpand");
        var selectRowClass = "selectRow";
        var index = 1;
        var inspecType = -1;
        $(function () {
            inspecType = $("#<%=this.hdInspectionTypeId.ClientID%>").val();
            if (inspecType == "") {
                $("#hdinspecType").val(-1);
            } else {
                $("#hdinspecType").val(inspecType);
            }
            var listArr = GetInspectionTemplateMember();
            if (null != listArr) {
                index = 1;
                for (var i = 0; i < listArr.length; i++) {
                    addDetail(listArr[i], index);
                    index++;
                }
            }
        });

        function chooseInspectionItem() {
            var openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/EquipmentExceptionReportingDialog.aspx?name=Equipment_ExceptionReportingDialog&controlId=controlId";
            dialog({ title: "添加异常方案", src: openWinUrl, width: 800, height: 550 });
        }

        function SetValue(list) {
            closeDialog();
            var obj = $(".hdExceptionReportingGrade");
            var alreadyItem = "";
            var flag = true;
            for (var j = 0; j < obj.length; j++) {
                if ($(obj[j]).val() == list.ExceptionReportingGrade) {
                    alreadyItem += list.ExceptionReportingGrade + ",";
                    flag = false;
                    break;
                }
            }
            if (flag) {
                addDetail(list, index);
                index++;
            }

            if (alreadyItem != "") {
                alert("你选择的异常方案(" + alreadyItem + ")已经添加了.");
            }
        }

        function GetIndex() {
            var list = $(tab).find("tr");
            for (var i = 0; i < list.length; i++) {
                if ($(list[i]).attr("class").indexOf(selectRowClass) > -1) {
                    return i;
                }
            }
            return tab.rows.length;
        }

        function addDetail(entity, i) {
            var row, cell;
            rowNewIdx = GetIndex();
            row = tab.insertRow(rowNewIdx);
            row.className = "ListTableOddRow";

            $("#trNewInfo").remove();

            cell = row.insertCell(0);
            cell.align = "center";
            cell.className = "Field pointer";
            cell.innerHTML = i;

            cell = row.insertCell(1);
            cell.align = "center";
            cell.className = "Field pointer";
            cell.innerHTML = " <input type=\"hidden\"  name=\"ExceptionReportingGrade\" class=\"hdExceptionReportingGrade\" value=\"" + entity.ExceptionReportingGrade + "\" />" + entity.ExceptionReportingGrade;

            cell = row.insertCell(2);
            cell.align = "center";
            cell.className = "Field pointer";
            cell.innerHTML = "<input type=\"hidden\" name=\"TimeOutLength\" class=\"hdTimeOutLength\" value=\"" + entity.TimeOutLength + "\" />" + entity.TimeOutLength;


            cell = row.insertCell(3);
            cell.align = "center";
            cell.className = "Field pointer";
            cell.innerHTML = "<input type=\"hidden\" name=\"TimeOutUnit\" class=\"hdTimeOutUnit\" value=\"" + entity.TimeOutUnit + "\" />" + entity.TimeOutUnit;

            cell = row.insertCell(4);
            cell.align = "center";
            cell.className = "Field pointer";
            cell.innerHTML = "<input type=\"hidden\" name=\"ReportingUser\" class=\"hdReportingUser\" value=\"" + entity.ReportingUser + "\" /><input type=\"hidden\" name=\"ReportingUserEmail\" class=\"hdReportingUserEmail\" value=\"" + entity.ReportingUserEmail + "\" /><input type=\"hidden\" name=\"ReportingUserName\" class=\"hdReportingUserName\" value=\"" + entity.ReportingUserName + "\" />" + entity.ReportingUserName;

            cell = row.insertCell(5);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = "<span style=\"CURSOR: pointer; COLOR: #0000ff;\" onclick=\"deleteItem(this)\"><%= Resources.Buttons.COM_Delete %></span>";

        }


        function deleteItem(obj) {
            if (typeof (obj) == "number") {
                tab.deleteRow(rowIndex);
            }
            else {
                tab.deleteRow(obj.parentElement.parentElement.rowIndex);
            }
        }

        var rowObj = null;
        var rowIndex = 0;

        var ReqId = '<%=Request.QueryString["ID"] %>';
        $("select").css("width", "140px");

        /*保存数据*/
        function Save() {
            var entity = {};
            entity.ExceptionReportingId = $("#<%=this.txtHideInspectionTemplateId.ClientID %>").val();
            entity.ExceptionReportingCode = $("#<%=this.txtExceptionReportingCode.ClientID %>").val();
            entity.ExceptionReportingName = $("#<%=this.txtExceptionReportingName.ClientID %>").val();
            entity.CreateTime = new Date($("#<%=this.txtHideCreateTime.ClientID %>").val());
            entity.Status = $("#<%=this.ddlStatus.ClientID %>").val() === '启用' ? true : false;
            entity.Description = $("#<%=this.txtDescription.ClientID %>").val();
            entity.ExceptionReportingItemIdList = "";
            entity.Creater = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
            entity.Version = $("#<%=this.txtVersion.ClientID %>").val();
            entity.ExceptionType = $("#ddlExceptionType").val();
            if (entity.ExceptionReportingId === '') {
                entity.ExceptionReportingId = ReqId;
            }
            if (ReqId == -1) {
                entity.CreateTime = new Date();
            }
            var list = [];
            for (var i = 0; i < $("#tblExpand tr:gt(0)").length; i++) {
                var data = $("#tblExpand tr:gt(0)")[i];

                var en = {};
                //  $(o[i]).val();
                en.ExceptionReportingId = entity.ExceptionReportingId;
                en.ExceptionReportingGrade = $(data).find("td:eq(1) input[name='ExceptionReportingGrade']").val();
                en.TimeOutLength = $(data).find("td:eq(2) input[name='TimeOutLength']").val();
                en.TimeOutUnit = $(data).find("td:eq(3) input[name='TimeOutUnit']").val();
                en.ReportingUser = $(data).find("td:eq(4) input[name='ReportingUser']").val();
                en.ReportingUserName = $(data).find("td:eq(4) input[name='ReportingUserName']").val();
                en.ReportingUserEmail = $(data).find("td:eq(4) input[name='ReportingUserEmail']").val();
                list.push(en);
            }
            if (list.length == 0) {
                alert("请添加异常方案明细");
                return;
            }
            entity.TempItems = JSON.stringify(list);

            // var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEquipmentInspectionItem.EquipmentInspectionTemplateEdit(JSON.stringify(entity));
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEquipmentInspectionItem.EquipmentExceptionReportingEdit(JSON.stringify(entity));

            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert('<%=Resources.Messages.SaveInSuccess %>');
            parent.window.UpdateList($("#<%=this.ddlStatus.ClientID %>").val());
            return ajax;
        }



        function GetInspectionTemplateMember() {
            var InspectionTemplateId = $("#<%=this.txtHideInspectionTemplateId.ClientID %>").val();
            if (InspectionTemplateId == "" || parseInt(InspectionTemplateId) == -1) {
                return null;
            }
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEquipmentInspectionItem.GetEquipmentExceptionReportingMemberInfo(InspectionTemplateId);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return null;
            }
            return ajax.value;
        }


    </script>
</asp:Content>
