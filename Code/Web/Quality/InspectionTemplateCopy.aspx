<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="InspectionTemplateCopy.aspx.cs" Inherits="SKT.LeanMES.Web.Quality.InspectionTemplateCopy" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <div class="infoTips">
        <span>点击[添加检验项目]可新增检验项目</span>, <em>*</em><span>为必填项</span>
    </div>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label3">
                <%=Resources.lang.InspectionTemplateName %><em>*</em>
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtInspectionTemplateName" MaxLength="20" runat="server" CssClass="TextBox"
                    IsRequired="1"></asp:TextBox>
            </td>
            <td class="Label3">
                <%=Resources.lang.InspectionTypeId%>
            </td>
            <td class="Field3">
                <asp:DropDownList ID="ddlInspectionType" runat="server">
                </asp:DropDownList>
            </td>
            <td class="Label3">
                <%=Resources.lang.Status %>
            </td>
            <td class="Field3">
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
            <td class="Label3">
                <%=Resources.lang.AC_OBA_Rev%>
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtVersion" MaxLength="50" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">
                <%=Resources.lang.Description%>
            </td>
            <td class="Field3" colspan="4">
                <asp:TextBox ID="txtDescription" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
    </table>
    <table id="tblExpand" cellspacing="0" cellpadding="4" style="border-width: 0px; width: 100%; border-collapse: collapse; margin-top: 5px;"
        class="EditeContentTable">
        <tr class="ListTableHeader" style="text-align: center">
            <th scope="col" style="width: 5%;">序号
            </th>
            <th scope="col" style="width: 13%;">
                <%=Resources.lang.InspectionItemName %>
            </th>
            <th scope="col" style="width: 20%;">工序
            </th>
            <%--         <th scope="col" style="width: 15%;">
                <%=Resources.lang.TestMethod %>
            <--%>
            <th scope="col" style="width: 13%;" id="trJcyj">
                <%=Resources.lang.TestBasis %>
            </th>
            <th scope="col" style="width: 8%;" id="trLrfs">录入方式
            </th>
            <th scope="col" style="width: 30%;" id="trPdbz">判断标准
            </th>
            <th scope="col" style="width: 10%;" id="trDw">单位
            </th>
            <th scope="col" style="width: 33%;">检验方法
            </th>
            <th scope="col" onclick="chooseInspectionItem(null);" style="color: #0066CC; cursor: pointer; width: 5%;">+
                <%=Resources.lang.AddInspection%>
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

            $("#<%=this.ddlInspectionType.ClientID %>").change(function () {
                var inspecType = this.value;
                // var entity = SKT.LeanMES.Web.Quality.InspectionTemplateEdit.GetInspectionTypeInf(inspecType).value;
                GetsysType(inspecType)
                // $("#hdinspecType").val(entity.SystemType);
                SetCoum();

            });
            var listArr = GetInspectionTemplateMember();
            if (null != listArr) {
                index = 1;
                for (var i = 0; i < listArr.length; i++) {
                    addDetail(listArr[i], index);
                    index++;
                }
            }
            SetCoum();




        });

        function GetsysType(inspecType) {

            var entity = SKT.LeanMES.Web.Quality.InspectionTemplateEdit.GetInspectionTypeInf(inspecType).value;

            $("#hdinspecType").val(entity.SystemType);
        }


        function SetCoum() {

            var val = $("#<%=this.ddlInspectionType.ClientID %>").val();
            GetsysType(val);

            var inspecType = $("#hdinspecType").val();
            // if (inspecType == 2 || inspecType == 6) { //检验类型为IPQC或者FAI首件时
            if (inspecType == 2) {
                for (var i = 0; i < tab.rows.length; i++) {
                    if (tab.rows[i].cells.length >= 6) {
                        tab.rows[i].cells[2].style.display = "";
                        tab.rows[i].cells[3].style.display = "none";
                        tab.rows[i].cells[4].style.display = "";
                        tab.rows[i].cells[5].style.display = "";
                        tab.rows[i].cells[6].style.display = "";
                    }
                }

                //$("#trLrfs").hide();
                //$("#trPdbz").hide();
                //$("#trDw").hide();
            } else {

                for (var i = 0; i < tab.rows.length; i++) {
                    if (tab.rows[i].cells.length >= 6) {
                        tab.rows[i].cells[2].style.display = "none";
                        tab.rows[i].cells[3].style.display = "none";
                        tab.rows[i].cells[4].style.display = "";
                        tab.rows[i].cells[5].style.display = "";
                        tab.rows[i].cells[6].style.display = "";
                    }
                }
                //$("#trLrfs").show();
                //$("#trPdbz").show();
                //$("#trDw").show();
            }
        }

        function chooseInspectionItem() {
            var openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Quality/InspectionItemDialog.aspx?name=QC_InspectionItemDialog&controlId=controlId";
            dialog({ title: "<%=Resources.Pages.InspectionItem %>", src: openWinUrl, width: 255, height: 350 });
        }

        function SetValue(list) {
            closeDialog();
            var obj = $(".hdInspectionItemId");
            var alreadyItem = "";
            for (var i = 0; i < list.length; i++) {
                var flag = true;
                for (var j = 0; j < obj.length; j++) {
                    if ($(obj[j]).val() == list[i].InspectionItemId) {
                        alreadyItem += list[i].InspectionItemName + ",";
                        flag = false;
                        break;
                    }
                }
                if (flag && !list[i].IsParent) {
                    list[i].MaxValue = 0;
                    list[i].MinValue = 0;
                    list[i].SpecialRequest = "无";
                    list[i].InspectionAccording = "根据工艺";
                    list[i].InspectJuge = "";
                    //if (list[i].OffsetUnitName == undefined) {
                    //    list[i].OffsetUnitName = "";
                    //}                  
                    list[i].OpenName = "";
                    list[i].OpenID = -1;
                    addDetail(list[i], index);
                    index++;
                }
            }

            if (alreadyItem != "") {
                alert("你选择的检验项(" + alreadyItem + ")已经添加了.");
            }
            SetCoum();
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
            cell.innerHTML = " <input type=\"hidden\" class=\"hdInspectionItemId\" value=\"" + entity.InspectionItemId + "\" />" + entity.InspectionItemName;


            $(cell).click(function () {
                var className = $(this.parentNode).attr("class");
                if (className.indexOf(selectRowClass) > -1) {
                    $(this.parentNode).removeClass(selectRowClass);
                }
                else {
                    $(tab).find("tr").removeClass(selectRowClass);
                    $(this.parentNode).addClass(selectRowClass);
                }
            })


            //cell = row.insertCell(2);
            //cell.align = "center";
            //cell.className = "Field pointer";
            //cell.innerHTML =entity.TestMethod;


            cell = row.insertCell(2);
            cell.align = "center";
            cell.className = "Field pointer";
            cell.innerHTML = "<input type=\"text\" name=\"txtOpenName\"  value='" + entity.OpenName + "' class=\"TextBox txtOpenName\"  disabled=\"disabled\" style=\" width:65%;\"  />"
                + "<input type=\"button\" onclick=\"selectOpenName(" + entity.InspectionItemId + ",this);\" class=\"ButtonBox\" value=\"...\" />"
                + "<input type=\"hidden\" name=\"hdOpenID\" class=\"hdOpenID\" value='" + entity.OpenID + "'  />";


            cell = row.insertCell(3);
            cell.align = "center";
            cell.className = "Field pointer";
            cell.innerHTML = '<input type="text" class="InspectionAccording" value="' + entity.InspectionAccording + '" MaxLength="50"  style="width:70px;height:25px;"/>'



            cell = row.insertCell(4);
            cell.align = "center";
            cell.className = "Field";
            cell.width = "80px";
            cell.id = entity.InspectionMethodId;



            if (typeof (entity.InspectionMethodId) == "undefined") {
                cell.innerHTML = "请维护检验项的录入方式";
                cell = row.insertCell(5);
                cell.align = "center";
                cell.className = "Field";
                cell.innerHTML = '';

            } else {
                cell.innerHTML = (entity.InspectionMethodId == 1 ? "固定结果" : "指定值");

                cell = row.insertCell(5);
                cell.align = "center";
                cell.className = "Field";
                cell.innerHTML = (entity.InspectionMethodId == 1 ? "OK/NG" : ' <input type="text" class="InspectionAccording" MaxLength="50" readonly="readonly" value="'
                    + (typeof (entity.InspectionMethodValue) == "undefined" ? "" : entity.InspectionMethodValue)
                    + '" style="width:40%;"/><input type="button" onclick="Set(this)" style="width:80px;margin-left:7px" value="' + mesLang('设置') + '"></input>');
            }



            cell = row.insertCell(6);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = ' <input type="text" MaxLength="50" value="' + (typeof (entity.UnitName) == "undefined" ? "" : entity.UnitName) + '" style="width:30%;" class="txtUnit"/>' +
                '<input type=\"button\" onclick=\"selectUnit(this);\" class=\"ButtonBox\" value=\"...\" /><input name="txtOffsetUnit" type="hidden" value="' + entity.OffsetUnitName + '" />';



            cell = row.insertCell(7);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = ' <input type="text" MaxLength="200" value="' + (typeof (entity.CheckFashion) == "undefined" ? "" : entity.CheckFashion) + '" style="width:80%;" class="txtInspectionmethods"/>' +
                '<input type=\"button\" onclick=\"selectInspectionmethods(this);\" class=\"ButtonBox\" value=\"...\" />';

            cell = row.insertCell(8);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = "<span style=\"CURSOR: pointer; COLOR: #0000ff;\" onclick=\"deleteItem(this)\"><%= Resources.Buttons.COM_Delete %></span>";

            BindIsPercentage("IsPercentage" + entity.InspectionItemId);
        }


        //获取单位
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

        //获取检验方法
        var rowObj2 = null;
        function selectInspectionmethods(obj) {
            rowObj2 = obj.parentElement.parentElement;
            var searchCondition = " DicProperty='Inspectionmethod' ";
            dialog({
                title: "<%=Resources.Common.ChooseWindow %>"
                , src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=822&CallBackFunc=getChooseValuesselectInspectionmethods&PageCondition= " + searchCondition + "&Multiple=false&rnd=" + Math.random(), width: 650, height: 350
            });
        }

        function getChooseValuesselectInspectionmethods(list) {
            $(rowObj2).find(".txtInspectionmethods").val(list[0][1]);
        }



        var GetValue = function (data, Id, StandardUnit, OffsetUnit) {
            closeDialog();
            data = data.replace('&gt;', ">");
            data = data.replace('&lt;', "<");
            debugger
            $("#tblExpand tr").eq(Id).find("td:eq(5) input[type='text']").val(data);
            $("#tblExpand tr").eq(Id).find("td:eq(6) input.txtUnit").val(StandardUnit);
            $("#tblExpand tr").eq(Id).find("td:eq(6) input[name='txtOffsetUnit']").val(OffsetUnit);
        }
        var Set = function (result) {
            var Id = $(result).parent().parent().find("td:eq(0)").html();
            var InspectionMethodValue = $(result).parent().find("input.InspectionAccording").val();
            var UnitName = $(result).parent().parent().find("td:eq(6) input.txtUnit").val();
            var OffsetUnitName = $(result).parent().parent().find("td:eq(6) input[name='txtOffsetUnit']").val();
            var openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Quality/InspectionTemplateEditValue.aspx?name=InspectionTemplateEditValue&value=" + InspectionMethodValue + "&Id=" + Id + "&UnitName=" + UnitName + "&OffsetUnitName=" + OffsetUnitName;
            dialog({ title: "<%=Resources.Pages.InspectionTemplateEditValue %>", src: openWinUrl, width: 500, height: 300 });

            //var data = "<table>";
            //for (var i = 0; i < length; i++) {

            //}
            //data += "<tr></tr>";
            //data += "<tr></tr>";
            //data += "<tr></tr>";
            //data += "</table>";
            //layer.open({
            //    type: 1,
            //    area: ['45%', '65%'],
            //    shadeClose: true, //点击遮罩关闭
            //    content: data
            //});
        }


        function BindIsPercentage(id) {
            $("#" + id).click(function () {
                id = $(this).attr("id");
                var value = parseInt($("#hd" + id).val());;
                if (value == 1) {
                    value = 0;
                }
                else {
                    value = 1
                }
                $("#hd" + id).val(value);
            });
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
            var IIObject = $(".hdInspectionItemId");
            var InspectionAccordingObj = $(".InspectionAccording");
            var SamplingRateObj = $(".SamplingRate");
            var TypeId = $("#<%=this.ddlInspectionType.ClientID %>").val();
            if (TypeId == -1 || TypeId=="-1")
            {
                alert("请选择检验类型");
                return;
            }
           
            var InspectionItemIdList = "";
            for (var i = 0; i < IIObject.length; i++) {
                InspectionItemIdList += (InspectionItemIdList == "" ? $(IIObject[i]).val() : "," + $(IIObject[i]).val());
            }
            var entity = {};
            entity.InspectionTemplateId = -1;
            entity.InspectionTemplateName = $("#<%=this.txtInspectionTemplateName.ClientID %>").val();
            entity.CreateTime = new Date($("#<%=this.txtHideCreateTime.ClientID %>").val());
            entity.Creater = $("#<%=this.txtHideCreater.ClientID %>").val();
            entity.Status = $("#<%=this.ddlStatus.ClientID %>").val() === '启用' ? true : false;
            entity.Description = $("#<%=this.txtDescription.ClientID %>").val();
            entity.InspectionItemIdList = InspectionItemIdList;
            entity.InspectionTypeId = $("#<%=this.ddlInspectionType.ClientID %>").val();
            entity.Creater = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
            entity.Version = $("#<%=this.txtVersion.ClientID %>").val();
            if (entity.InspectionTemplateId === '') {
                entity.InspectionTemplateId = ReqId;
            }
            if (ReqId == -1) {
                entity.CreateTime = new Date();
            }
            var list = [];
            for (var i = 0; i < $("#tblExpand tr:gt(0)").length; i++) {
                var data = $("#tblExpand tr:gt(0)")[i];

                var en = {};
                //  $(o[i]).val();
                en.InspectionTemplateId = entity.InspectionTemplateId;
                en.InspectionItemId = $($(".hdInspectionItemId")[i]).val();
                if (en.InspectionItemId == null || en.InspectionItemId == "undefined") {
                    alert("请添加检验项目");
                    return;
                }
                en.MaxValue = 0;
                en.MinValue = 0;
                en.SpecialRequest = "";
                en.InspectionAccording = $(data).find("td:eq(3) input").val();
                en.SamplingRate = 0;
                en.Remark = "";
                en.IsPercentage = -1;
                en.AQLRuleId = -1;
                en.InspectJuge = "";


                en.InspectionMethodId = $(data).find("td:eq(4)").attr("id");

                if (en.InspectionMethodId == 1) {
                    en.InspectionMethodValue = "OK/NG";
                } else {
                    en.InspectionMethodValue = $(data).find("td:eq(5) input:first").val();
                }
                //en.InspectionMethodValue = $($(".InspectionAccording")[i]).val();
                en.UnitName = $(data).find("td:eq(6) input.txtUnit").val();
                en.OffsetUnitName = $(data).find("td:eq(6) input[name='txtOffsetUnit']").val();
                en.CheckFashion = $(data).find("td:eq(7) input").val();
                en.OpenId = $(data).find("td:eq(2) [name='hdOpenID']").val();
                list.push(en);
            }
            if (list.length == 0) {
                alert("请添加检验项目");
                return;
            }
            entity.TempItems = JSON.stringify(list);

           // var ajax = SKT.LeanMES.Web.AjaxServices.AjaxQuality.InspectionTemplateEdit(JSON.stringify(entity));
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxQuality.InspectionTemplateEditJW(JSON.stringify(entity));

            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert('<%=Resources.Messages.SaveInSuccess %>');
            parent.window.UpdateList($("#<%=this.ddlStatus.ClientID %>").val());
            return ajax;
        }

        function selectInspectionTemplateValue() {
            dialog({
                title: "<%=Resources.Common.ChooseWindow %>",
                src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?" +
                    "PageId=74&CallBackFunc=getChooseValueInspectionTemplate&Multiple=true&rnd=" + Math.random(),
                width: 400,
                height: 250
            });
        }

        function GetInspectionTemplateMember() {
            var InspectionTemplateId = $("#<%=this.txtHideInspectionTemplateId.ClientID %>").val();
            if (InspectionTemplateId == "" || parseInt(InspectionTemplateId) == -1) {
                return null;
            }
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxQuality.GetInspectionTemplateMemberByTempId(InspectionTemplateId);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return null;
            }
            return ajax.value;
        }

        //获取工序
        var rowObj = null;
        var rowIndex = 0;
        var thisRow = -1;
        function selectOpenName(rowCount, obj) {
            rowObj = obj.parentElement.parentElement;
            rowIndex = rowObj.rowIndex;
            thisRow = rowCount;
            dialog({
                title: "<%=Resources.Common.ChooseWindow %>"
            , src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=8&CallBackFunc=getChooseValuesOpenName&Multiple=false&rnd=" + Math.random(), width: 650, height: 350
            });
        }
        function getChooseValuesOpenName(list) {
            $(rowObj).find(".hdOpenID").val(list[0][0]);
            $(rowObj).find(".txtOpenName").val(list[0][1]);
        }
    </script>
</asp:Content>
