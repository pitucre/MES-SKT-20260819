<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    CodeBehind="PlanEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Plan.PlanEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <div class="infoTips">
        <%= Resources.Messages.PlanListByTime %>
    </div>
    <table width="100%" class="EditeContentTable">
        <tr>
            
            <td class="Label3">
                 <%=Resources.lang.OrderNum%>
            </td>
            <td class="Field3">
                <asp:Label ID="lbOrderNumber" runat="server" Text=""></asp:Label>
            </td>
            <td class="Label3">
                <%=Resources.lang.PlanQty%>
            </td>
            <td class="Field3">
                <asp:Label ID="lbFQty" runat="server" Text=""></asp:Label>
            </td>
            <td class="Label3">
                产品编码
            </td>
            <td class="Field3">
                <asp:Label ID="lblItemCode" runat="server" Text="" ClientIDMode="Static"></asp:Label>
                <asp:HiddenField ID="hdnItemId" Value="-1" ClientIDMode="Static" runat="server" />
            </td>
        </tr>
        <tr>
            <td class="Label3">
                <%=Resources.lang.MaterialName %>
            </td>
            <td class="Field3">
                <asp:Label ID="lbFName" runat="server" Text="" ClientIDMode="Static"></asp:Label>
            </td>
            <td class="Label3">
                拼板数量
            </td>
            <td class="Field3">
                <asp:Label ID="lblPlaneQty" runat="server" Text="" ForeColor="#FF3300"></asp:Label>
            </td>
            <td class="Label3">
                可排产数量
            </td>
            <td class="Field3">
                <asp:Label ID="lbFQtyPlan" runat="server" Text="" ForeColor="#FF3300"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label3">
                路由名称
            </td>
            <td class="Field3">
                <asp:Label ID="lblRouterName" runat="server" ClientIDMode="Static" Text=""></asp:Label>
            </td>
            <td class="Label3">
                <%=Resources.lang.PlanCommitDate%>
            </td>
            <td class="Field3">
                <asp:Label ID="lbFPlanCommitDate" runat="server" Text=""></asp:Label>
            </td>
            <td class="Label3">
                <%=Resources.lang.PlanFinishDate%>
            </td>
            <td class="Field3">
                <asp:Label ID="lbFPlanFinishDate" runat="server" Text=""></asp:Label>
            </td>
        </tr>
        <tr style="display: none">
            <td class="Label3">
                <%=Resources.lang.Biller %>
            </td>
            <td class="Field3">
                <asp:Label ID="lbFBiller" runat="server" Text=""></asp:Label>
            </td>
            <td class="Label3">
                <%=Resources.lang.Conveyer %>
            </td>
            <td class="Field3">
                <asp:Label ID="lbFConveyer" runat="server" Text=""></asp:Label>
            </td>
        </tr>
        <tr style="display: none">
            <td class="Label2">
                <%=Resources.lang.CommitDate%>
            </td>
            <td class="Field2">
                <asp:Label ID="lbFCommitDate" runat="server" Text="Label"></asp:Label>
            </td>
            <td class="Label2">
                <%=Resources.lang.ProcessingCompany%>
            </td>
            <td class="Field2">
                <asp:Label ID="lbFWorkShop" runat="server" Text="Label"></asp:Label>
            </td>
        </tr>
    </table>
   
    <table id="tblExpand" cellspacing="0" cellpadding="4" style="border-width: 0px; width: 100%;
        border-collapse: collapse; margin-top: 5px;" class="EditeContentTable">
        <tr class="ListTableHeader">
            <th scope="col" style="width: 15%;">
                <%=Resources.lang.ProductionLine%><em>*</em>
            </th>
            <th scope="col" style="width: 15%;">
                资源
            </th>
            <th scope="col" style="width: 20%;">
                线别设备类型
            </th>
            <th scope="col" style="width: 10%;">
                <%=Resources.lang.PlanQty %><em>*</em>
            </th>
            <th scope="col" style="width: 15%;">
                <%=Resources.lang.StartTime %><em>*</em>
            </th>
            <th scope="col" style="width: 5%;">
                面别<em>*</em>
            </th>
            <th scope="col" style="width: 5%;">
                标准产能
            </th>
            <th scope="col" id="thAddDetail" onclick="addDetail(null,'','-1','','');" style="color: #0066CC;
                cursor: pointer; width: 8%;">
                +
                <%=Resources.lang.AddLine %>
            </th>
        </tr>
        <tr id="trNewInfo" class="ListTableOddRow">
            <td colspan="6" style="text-align: center;">
                <%=Resources.Messages.HaveNothingData%>
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        _isHms = true; /*日期控件开启时分秒*/
        var planType = '<%=Request.QueryString["PlanType"]%>'; //排产类型：1、SMT工单排程 2、其他工单排程 3、批次排产
        var FInterID = '<%=Request.QueryString["ID"]%>';
        var FBILLNO = $('#' + '<%=this.lbOrderNumber.ClientID %>').html();

        //产量计划
        var fQty = $("#<%=this.lbFQty.ClientID%>").html();
        //求排期数量lb对象
        var fQtyPlanObj = $("#<%=this.lbFQtyPlan.ClientID%>");

        var tab = document.getElementById("tblExpand");
        var rowObj = null;
        var rowIndex = 0;

        $(function () {
           <%-- $("#<%=this.lbFQtyPlan.ClientID%>").html($("#<%=this.lbFQty.ClientID%>").html());--%>
            if ($.trim($("#lblRouterName").text()) == "") {
                alert("未找到当前工单的路由信息，请先维护路由信息！");
                $("#thAddDetail").removeAttr("onclick");
                return false;
            }
            if (planType == "") {
                planType = 1;
            }
            initFTable();
        })

        function initFTable() {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPlan.GetLinePlanByFInterIDS(FInterID);
            IsInti = true;
            var qty = 0;

            if (ajax.error == null) {
                var entityAry = ajax.value;
                if (entityAry.length > 0) {
                    for (var i = 0; i < entityAry.length; i++) {
                        if (entityAry[i].TableName == "TB") {
                            $("#<%=this.lbFQtyPlan.ClientID%>").text(parseInt($("#<%=this.lbFQty.ClientID%>").text()) - entityAry[i].FQty);
                        }
                        else if (entityAry[i].TableName == "T") {
                            qty += entityAry[i].FQty;
                        }
                        if (i == 0) {
                            planType = entityAry[0].LinePlanType;
                        }
                        addDetail(entityAry[i], "", -1, "", 0);
                    }

                    if (qty != 0) {
                        $("#<%=this.lbFQtyPlan.ClientID%>").text(parseInt($("#<%=this.lbFQty.ClientID%>").text()) - qty);

                    }
                }
                else {
                    //if (planType != 1) {
                    //    $('#tblExpand tr').find('td:eq(1),td:eq(4),td:eq(5), th:eq(1), th:eq(4), th:eq(5)').hide();
                    //}
                    if (planType == 2) {
                        $('#tblExpand tr').find('td:eq(1),td:eq(2),td:eq(5),td:eq(6), th:eq(1),th:eq(2), th:eq(5), th:eq(6)').hide();
                    }
                    if (planType == 3) {
                        $('#tblExpand tr').find('td:eq(2),td:eq(5),td:eq(6), th:eq(2),th:eq(5), th:eq(6)').hide();
                    }
                }

            } else {
                alert(ajax.error.Message);
            }
            IsInti = false;
            getBalancePlanQty();
        }

        var IsInti = false;
        function addDetail(entity, tableName, lineId, lineName, planQty) {

            if (entity == null) {
                entity = {};
                entity.LinePlanId = -1;
                entity.LineId = lineId;
                entity.LineName = lineName;
                entity.FPlanCommitDate = "";
                entity.FPlanFinishDate = "";
                entity.LineDescription = "";
                entity.FQty = planQty;
                entity.State = -3;
                entity.FStockQty = 0;
                entity.TableName = tableName;
                entity.LineMachineRelation = "";
                entity.ResourceId = -1;
                entity.ResName = lineName;
            }

            //格式化日期
            entity.FPlanCommitDate = entity.FPlanCommitDate != "" ? entity.FPlanCommitDate.pattern("yyyy-MM-dd HH:mm:ss") : "";
            entity.FPlanFinishDate = entity.FPlanFinishDate != "" ? entity.FPlanFinishDate.pattern("yyyy-MM-dd HH:mm:ss") : "";

            if (entity.LineId > -1) {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPlan.GetLineInfoLineID(entity.LineId);
                if (ajax.value != null && ajax.value != undefined) {
                    entity.LineName = ajax.value.LineName;
                    entity.LineMachineRelation = ajax.value.LineMachineRelation;
                }
            }

            var lineList = $("input[type=hidden][class=hdLineId][value=" + entity.LineId + "]"); //获取线别对象

            $("#trNewInfo").remove();
            var row, cell;
            rowNewIdx = tab.rows.length;
            row = tab.insertRow(rowNewIdx);
            row.className = "ListTableOddRow";

            var readonly = (entity.State != -3 ? "readonly=\"readonly\"" : "");
            var disabled = ((entity.State != -3) ? "disabled=\"disabled\"" : "");

            cell = row.insertCell(0);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = " <input type=\"hidden\" class=\"hdLineId\" value=\"" + entity.LineId + "\" />"
            + "<input type=\"text\" name=\"txtLineName\"  IsRequired='1' class=\"TextBox\" value=\"" + entity.LineName + "\" disabled=\"disabled\" style=\" width:100px;\" >"
            + "<input type=\"button\" id=\"btnSelectItems\" onclick=\"selectItems(this);\" class=\"ButtonBox\" value=\"...\" " + disabled + "  />"
            + " <input type=\"hidden\" class=\"hdLinePlanId\" value=\"" + entity.LinePlanId + "\" />";

            cell = row.insertCell(1);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = " <input type=\"hidden\" class=\"hdResourceId\" value=\"" + entity.ResourceId + "\" />"
                + "<input type=\"text\" name=\"txtResource\"  class=\"TextBox\" value=\"" + entity.ResName + "\" disabled=\"disabled\" style=\" width:100px;\" >"
                + "<input type=\"button\" id=\"btnselectResource\" onclick=\"selectResource(this);\" class=\"ButtonBox\" value=\"...\" " + disabled + "  />";

            cell = row.insertCell(2);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = "<input type=\"text\" name=\"txtEquipmentLine\" class=\"TextBox\" style=\" width:80%;\" disabled=\"disabled\" value=\"" + entity.LineMachineRelation + "\"  />"

            cell = row.insertCell(3);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = "<input type=\"text\"  IsNumber='1' onkeyup=\"getIntVal(this)\" IsRequired='1' MinValue='1' " + readonly + " style=\"width: 70px\" class=\"fQtyPlan\" value=\"" + entity.FQty
            + "\" onblur=\"onTextBlur(this)\"  />"

            cell = row.insertCell(4);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = "<input type=\"text\" IsRequired='1'  style=\" width:80%;\" readonly='readonly' " + disabled + "  class=\"startDate\" value=\"" + entity.FPlanCommitDate + "\" />";

            //面别
            var tableStr = getPlanTable(entity.TableName, disabled);

            cell = row.insertCell(5);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = tableStr;

            //标准产能
            debugger;
            var standardCapacity = getStandardCapacity(entity.TableName, entity.LineMachineRelation);
            cell = row.insertCell(6);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = "<span name='lblStandardCapacity'>" + standardCapacity + "</span>";

            cell = row.insertCell(7);
            cell.align = "center";
            cell.className = "Field";
            if (entity.State == -3) {
                cell.innerHTML = "<span style=\"CURSOR: pointer; COLOR: #0000ff;\" onclick=\"deleteItem(this)\"><%= Resources.Buttons.COM_Delete %></span>";
            }
            else {
                var planState = "";
                switch (entity.State) {
                    case -2:
                        planState = "待备料";
                        break;
                    case -1:
                        planState = "备料中";
                        break;
                    case 0:
                        planState = "备料完成/可上料";
                        break;
                    case 1:
                        planState = "上料验证";
                        break;
                    case 2:
                        planState = "投产中";
                        break;
                    case 3:
                        planState = "已暂停";
                        break;
                    case 4:
                        planState = "已完成";
                        break;
                    case 5:
                        planState = "卸料";
                        break;
                }
                cell.innerHTML = planState;
            }

            var tdObj = $($("#tblExpand").find("tr")[$("#tblExpand").find("tr").length - 1]).find("td");

            intiDatepicker($(tdObj[4]).find(".startDate"));
            if (planType == 2) {
                $('#tblExpand tr').find('td:eq(1),td:eq(2),td:eq(5),td:eq(6), th:eq(1),th:eq(2), th:eq(5), th:eq(6)').hide();
            }
            if (planType == 3) {
                $('#tblExpand tr').find('td:eq(2),td:eq(5),td:eq(6), th:eq(2),th:eq(5), th:eq(6)').hide();
            }
        }

        function Save() {
            if (checkBalancePlanQty()) {
                if ($.trim($("#lblRouterName").text()) == "") {
                    alert("未找到当前工单的路由信息，请先维护路由信息！");
                    return false;
                }
                var LineIdArr = GetArrValue($(".hdLineId"));
                var StartDateArr = GetArrValue($(".startDate"));
                var EndDateArr = GetArrValue($(".endDate"));
                var FQtyArr = GetArrValue($(".fQtyPlan"));
                var LinePlanIdArr = GetArrValue($(".hdLinePlanId"));
                var tableNameArr = GetArrValue($("select[name=sltTableName]"));
                var hdResourceIdArr = GetArrValue($(".hdResourceId"));

                var entity = {};
                entity.LinePlanIdArr = LinePlanIdArr;
                entity.FInterID = FInterID;
                entity.FBILLNO = FBILLNO;
                entity.LineIdArr = LineIdArr;
                entity.StartDateArr = StartDateArr;
                entity.EndDateArr = EndDateArr;
                entity.FQtyArr = FQtyArr;
                entity.CreateBy = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>'
                entity.ModifyBy = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>'
                entity.TableNameArr = tableNameArr;
                entity.LinePlanType = planType;
                entity.ResourceIdArr = hdResourceIdArr;
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPlan.CollectOrderPlanInfo(entity);

                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }
                alert('<%=Resources.Messages.SaveInSuccess%>');
                parent.window.Refresh();
            }
        }

        function selectResource(obj) {
            rowObj = obj.parentElement.parentElement;
            rowIndex = rowObj.rowIndex;
            dialog({
                title: "<%=Resources.Common.ChooseWindow %>"
                , src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=6&CallBackFunc=getChooseValueResource&Multiple=false&rnd="
                    + Math.random(), width: 600, height: 300
            });
        }

        function getChooseValueResource(list) {
            rowObj.cells[1].children[0].value = list[0][0];
            rowObj.cells[1].children[1].value = list[0][1];
        }

        function selectItems(obj) {
            rowObj = obj.parentElement.parentElement;
            rowIndex = rowObj.rowIndex;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>"
            , src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=21&CallBackFunc=getChooseValueLine&Multiple=false&rnd="
            + Math.random(), width: 600, height: 300
            });
        }

        function deleteItem(obj) {
            var trObj = $(obj).parent().parent(); //获取TR对象     
            trObj.remove();
            var lineList = $("input[type=hidden][class=hdLineId]");
            var tableAQty = 0;
            var tableBQty = 0;
            var tableABQty = 0;
            var tableName = "";
            var planQty = 0;

            lineList.parent().parent().each(function () {
                tableName = $(this).find("select[name=sltTableName]").val();
                planQty = parseInt($(this).find("input[type=text][class=fQtyPlan]").val());
                if (tableName == "T") {
                    tableAQty = tableAQty + planQty;
                }
                else if (tableName == "B") {
                    tableBQty = tableBQty + planQty;
                }
                else if (tableName == "TB") {
                    tableABQty = tableABQty + planQty;
                }
            });
            var balancePlanQty = 0;
            if (tableABQty > 0) {
                balancePlanQty = (parseInt(fQty) - tableABQty);
            }
            else {
                if (tableAQty > tableBQty) {
                    balancePlanQty = (parseInt(fQty) - tableAQty);
                }
                else {
                    balancePlanQty = (parseInt(fQty) - tableBQty);
                }
            }

            fQtyPlanObj.text(balancePlanQty < 0 ? 0 : balancePlanQty);
        }

        function getChooseValueLine(list) {
            if ($.trim(list[0][3]) == "" && planType == 1) {
                alert("请先维护好线别设备类型！");
                return false;
            }
            var lineIdObj = $(".hdLineId");
            var lineId = list[0][0];

            rowObj.cells[0].children[0].value = lineId;
            rowObj.cells[0].children[1].value = list[0][1];
            rowObj.cells[2].children[0].value = list[0][3];
            setTimeout(function () { $(rowObj).find("input[type=text][class=fQtyPlan]").val('').focus(); }, 100);

            return true;
        }

        //产线产量失去焦点事件
        function onTextBlur(obj) {
            if (!isNumber($(obj).val())) {
                $(obj).val('');
                return;
            }
            //获取当前线别分配的排产数量，如果分配的为A、B面别 则设置A/B面别排产数量一致
            var planQtyObj; //获取当前input对象

            var trObj = $(obj).parent().parent(); //获取TR对象
            var tbObj = $("#tblExpand"); //获取表格对象
            var lineId = trObj.find("input[type=hidden][class=hdLineId]").val(); //获取线别ID
            var lineList = $("input[type=hidden][class=hdLineId][value=" + lineId + "]"); //获取线别对象

            if (parseInt($(obj).val()) > parseInt(fQty)) {
                alert("排产数量不能超过计划生产数量！");
                setTimeout(function () {
                    $(obj).select();
                },100);
               
                return;
            }

            getBalancePlanQty();
        }

        /**
        * 保存时检测排产的数量是否正确
        **/
        function checkBalancePlanQty() {
            //获取当前面别信息
            var lineList = $("input[type=hidden][class=hdLineId]");
            var tableAQty = 0;
            var tableBQty = 0;
            var tableABQty = 0;

            var tableName = "";
            var planQty = 0;

            lineList.parent().parent().each(function () {
                tableName = $(this).find("select[name=sltTableName]").val();
                planQty = parseInt($(this).find("input[type=text][class=fQtyPlan]").val());
                if (tableName == "T") {
                    tableAQty = tableAQty + planQty;
                }
                else if (tableName == "B") {
                    tableBQty = tableBQty + planQty;
                }
                else if (tableName == "TB") {
                    tableABQty = tableABQty + planQty;
                }
            });

            if (tableAQty > parseInt(fQty) || tableBQty > parseInt(fQty) || tableABQty > parseInt(fQty)) {
                if (planType == 1) {
                    alert("TB面别的排产数量超过计划生产数量，请重新排产！");
                }
                else {
                    alert("排产数量超过计划生产数量，请重新排产！");
                }
                return false;
            }
            else if (tableAQty != tableBQty) {
                alert("T面别与B面别的排产数量不一致，请重新排产！");
                return false;
            }
            return true;
        }

        /**
        * 保获取剩余可排产数量
        **/
        function getBalancePlanQty() {
            var lineList = $("input[type=hidden][class=hdLineId]");
            var tableAQty = 0;
            var tableBQty = 0;
            var tableABQty = 0;

            var tableName = "";
            var planQty = 0;

            lineList.parent().parent().each(function () {
                tableName = $(this).find("select[name=sltTableName]").val();
                planQty = parseInt($(this).find("input[type=text][class=fQtyPlan]").val());
                if (tableName == "T") {
                    tableAQty = tableAQty + planQty;
                }
                else if (tableName == "B") {
                    tableBQty = tableBQty + planQty;
                }
                else if (tableName == "TB") {
                    tableABQty = tableABQty + planQty;
                }
            });
            var balancePlanQty = 0;
            if (tableABQty > 0) {
                balancePlanQty = (parseInt(fQty) - tableABQty);
            }
            else {
                if (tableAQty > tableBQty) {
                    balancePlanQty = (parseInt(fQty) - tableAQty);
                }
                else {
                    balancePlanQty = (parseInt(fQty) - tableBQty);
                }
            }
            if (balancePlanQty < 0) {
                if (planType == 1) {
                    alert("TB面别的排产数量超过计划生产数量，请重新排产！");
                }
                else {
                    alert("排产数量超过计划生产数量，请重新排产！");
                }
                return false;
            }
            else {
                //fQtyPlanObj.text(balancePlanQty);
            }
            return true;
        }

        //初始化日期
        function intiDatepicker(obj) {
            $(obj).datepicker({
                buttonImageOnly: true,
                showHms: true
            });
        }

        //获取对象数组里的val值，返回'1,2,3,4,5'
        function GetArrValue(o) {
            var str = "";
            for (var i = 0; i < o.length; i++) {
                if (i == 0) {
                    str = $(o[i]).val();
                }
                else {
                    str += "," + $(o[i]).val();
                }
            }
            return str;
        }

        /**
        *获取面别信息
        **/
        function getPlanTable(tableName, disable) {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPlan.GetTableName();

            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var selectStr;
            var list = ajax.value;
            var entity;
            var select = "";
            disable = (planType != 1 ? "disabled=\"disabled\"" : disable);
            tableName = (planType == 1 ? tableName : "TB");
            var isRequired = (planType == 1 ? "IsRequired=1" : "");
            if (list != null && list != undefined && list.length > 0) {
                selectStr = "<select name='sltTableName' onchange='setStandardCapacity(this)' " + disable + " " + isRequired + "><option value=''>--请选择--</option>";
                for (var i = 0; i < list.length; i++) {
                    entity = list[i];
                    if (entity.TableName == tableName) {
                        select = "selected='selected'";
                    }
                    else {
                        select = "";
                    }
                    selectStr += "<option value='" + entity.TableName + "' " + select + "  >" + entity.TableDesc + "</option>";
                }
                selectStr += "</select>";
            }
            return (selectStr);
        }

        function setStandardCapacity(obj) {
            var sltObj = $(obj); //面别选择框对象
            var tableName = sltObj.find(":checked").val(); //面别名称 
            var trObj = sltObj.parent().parent(); //TR对象
            var lineId = trObj.find("input[type=hidden][class=hdLineId]").val();
            var flag = true;
            //检验线别信息
            if (lineId == -1) {
                alert("请先选择产线！");
                sltObj.val('');
                return false;
            }

            var equipmentLine = trObj.find("input[name=txtEquipmentLine]").val(); //线别设备类型
            var lineName = trObj.find("input[type=text][name=txtLineName]").val(); //线别名称
            var planQty = trObj.find("input[type=text][class=fQtyPlan]").val(); //排产数量

            if (planQty == "") {
                alert('计划生产数量不能为空 ！');
                trObj.find("input[type=text][class=fQtyPlan]").focus();
                sltObj.val('');
                return false;
            }
            else if (planQty == 0) {
                alert('计划生产数量不能为0 ！');
                trObj.find("input[type=text][class=fQtyPlan]").focus();
                sltObj.val('');
                return false;
            }

            var standardCapacityObj = trObj.find("span[name=lblStandardCapacity]"); //标准产能对象
            var standardCapacity = getStandardCapacity(tableName, equipmentLine); //查询标准产能信息

            if (!(parseInt(standardCapacity) > 0) && tableName != "" && planType == 1) {
                alert("请先维护产线生产工单产品的标准产能！");
                sltObj.val('');
                return false;
            }

            var lineList = $("input[type=hidden][class=hdLineId][value=" + lineId + "]"); //获取线别对象

            //检验如果已存在A、B面别的排产信息 则不允许进行AB面排产
            if (tableName == "TB") {
                var tbObj = $("#tblExpand"); //获取表格对象
                tbObj.find("tr td select[name=sltTableName]").each(
                        function () {
                            if ($(this).val() != "TB" && $(this).val() != "") {
                                alert("当前排产已存在T/B分面排产，不可再进行TB面别排产！");
                                flag = false;
                                sltObj.val('');
                                return false;
                            }
                        }
                );
            }
            else {
                var tbObj = $("#tblExpand"); //获取表格对象
                tbObj.find("tr td select[name=sltTableName]").each(
                        function () {
                            if ($(this).val() == "TB") {
                                alert("当前排产已存在TB面别排产，不可再进行T/B分面排产！");
                                flag = false;
                                sltObj.val('');
                                return false;
                            }
                        }
                );
            }

            //查询可排产数量
            if (!getBalancePlanQty()) {
                sltObj.val('');
                flag = false;
                return false;
            }
            if (flag) {
                standardCapacityObj.text(standardCapacity); //设置标准产能
            }
        }

        function getStandardCapacity(tableName, equipmentLine) {
            var itemId = $("#hdnItemId").val();
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPlan.GetStandardCapacity(itemId, tableName, equipmentLine);

            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            return ajax.value;
        }
        //function getStandardCapacity(tableName, lineId) {
        //    if (tableName == "" || lineId == "") {
        //        return "";
        //    }
        //    var itemId = $("#hdnItemId").val();
        //    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPlan.GetResourceManageInfo(itemId, lineId, tableName);
        //    if (ajax.error != null) {
        //        alert(ajax.error.Message);
        //        return false;
        //    }
        //    if (ajax.value != null) {
        //        var unit = "";
        //        switch (ajax.value.CapacityUnit) {
        //            case "Minute":
        //                unit = "分";
        //                break;
        //            case "Hour":
        //                unit = "时";
        //                break;
        //            case "Day":
        //                unit = "天";
        //                break;
        //        }

        //        return ajax.value.Capacity + "/" + unit;
        //    } else {
        //        return "未维护";
        //    }

        //}

        

        Date.prototype.pattern = function (fmt) {
            var o = {
                "M+": this.getMonth() + 1, //月份         
                "d+": this.getDate(), //日         
                "h+": this.getHours() % 12 == 0 ? 12 : this.getHours() % 12, //小时         
                "H+": this.getHours(), //小时         
                "m+": this.getMinutes(), //分         
                "s+": this.getSeconds(), //秒         
                "q+": Math.floor((this.getMonth() + 3) / 3), //季度         
                "S": this.getMilliseconds() //毫秒         
            };
            var week = {
                "0": "/u65e5",
                "1": "/u4e00",
                "2": "/u4e8c",
                "3": "/u4e09",
                "4": "/u56db",
                "5": "/u4e94",
                "6": "/u516d"
            };
            if (/(y+)/.test(fmt)) {
                fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
            }
            if (/(E+)/.test(fmt)) {
                fmt = fmt.replace(RegExp.$1, ((RegExp.$1.length > 1) ? (RegExp.$1.length > 2 ? "/u661f/u671f" : "/u5468") : "") + week[this.getDay() + ""]);
            }
            for (var k in o) {
                if (new RegExp("(" + k + ")").test(fmt)) {
                    fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
                }
            }
            return fmt;
        }       
      
    </script>
</asp:Content>
