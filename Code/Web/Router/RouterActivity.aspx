<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="RouterActivity.aspx.cs" Inherits="SKT.LeanMES.Web.Router.RouterActivity" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <table id="tabRouteInfo" width="100%" class="EditeContentTable">
        <tr>
            <td class="Label2">
                <%=Resources.lang.RouterName %>
            </td>
            <td class="Field2">
                <span id="routerName"></span>
            </td>
            <td class="Label2">
                <%=Resources.lang.Station%>
            </td>
            <td class="Field2">
                <span id="opereationName"></span>
            </td>
        </tr>
    </table>
    <div class="clear5">
    </div>
    <div>
        <div class="divHeader hide">
            <img src="../Content/images/icon/edit_dblink.png" class="imgText" />&nbsp;SMT设置
        </div>
        <table id="tabSMTRouteSetting" width="100%" class="EditeContentTable hide">
            <tr>
                <td class="Label2">SMT开拉检查</td>
                <td class="Field2">
                    <asp:DropDownList ID="ddlOpenLine" runat="server">
                        <asp:ListItem Text="不需要" Value="0"></asp:ListItem>
                        <asp:ListItem Text="需要" Value="1"></asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td class="Label2">SMT扣料</td>
                <td class="Field2">
                    <asp:DropDownList ID="ddlSMTDeduct" runat="server" ClientIDMode="Static">
                        <asp:ListItem Text="不需要" Value="0"></asp:ListItem>
                        <asp:ListItem Text="需要" Value="1"></asp:ListItem>
                    </asp:DropDownList>
                    <asp:DropDownList ID="ddlSMTDeductFace" runat="server" ClientIDMode="Static">
                        <asp:ListItem Text="TB面" Value="0"></asp:ListItem>
                        <asp:ListItem Text="T面" Value="1"></asp:ListItem>
                        <asp:ListItem Text="B面" Value="2"></asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td class="Label2">钢网检查</td>
                <td class="Field2">
                    <asp:DropDownList ID="ddlCheckSteel" runat="server">
                        <asp:ListItem Text="不需要" Value="0"></asp:ListItem>
                        <asp:ListItem Text="需要" Value="1"></asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td class="Label2">刮刀检查</td>
                <td class="Field2">
                    <asp:DropDownList ID="ddlCheckKnife" runat="server">
                        <asp:ListItem Text="不需要" Value="0"></asp:ListItem>
                        <asp:ListItem Text="需要" Value="1"></asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td class="Label2">正面投入站</td>
                <td class="Field2">
                    <asp:DropDownList ID="ddlSMTAInputStation" runat="server">
                        <asp:ListItem Text="否" Value="0"></asp:ListItem>
                        <asp:ListItem Text="是" Value="1"></asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td class="Label2">正面产出站</td>
                <td class="Field2">
                    <asp:DropDownList ID="ddlSMTAOutputStation" runat="server">
                        <asp:ListItem Text="否" Value="0"></asp:ListItem>
                        <asp:ListItem Text="是" Value="1"></asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td class="Label2">背面投入站</td>
                <td class="Field2">
                    <asp:DropDownList ID="ddlSMTBInputStation" runat="server">
                        <asp:ListItem Text="否" Value="0"></asp:ListItem>
                        <asp:ListItem Text="是" Value="1"></asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td class="Label2">背面产出站</td>
                <td class="Field2">
                    <asp:DropDownList ID="ddlSMTBOutputStation" runat="server">
                        <asp:ListItem Text="否" Value="0"></asp:ListItem>
                        <asp:ListItem Text="是" Value="1"></asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
        </table>
        <div class="clear5">
        </div>
        <div class="divHeader">
            <img src="../Content/images/icon/edit_dblink.png" class="imgText" />&nbsp;其他设置
        </div>
        <table id="tabRouteSetting" width="100%" class="EditeContentTable">
            <tr>
                <td class="Label2">开工检查</td>
                <td class="Field2">
                    <asp:DropDownList ID="ddlPickOpenLine" runat="server">
                        <asp:ListItem Text="不需要" Value="0"></asp:ListItem>
                        <asp:ListItem Text="需要" Value="1"></asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td class="Label2">是否需要扣料</td>
                <td class="Field2" colspan="3">
                    <asp:DropDownList ID="ddlPickDeduct" runat="server" ClientIDMode="Static">
                        <asp:ListItem Text="不需要" Value="0"></asp:ListItem>
                        <asp:ListItem Text="需要" Value="1"></asp:ListItem>
                    </asp:DropDownList>
                    <asp:DropDownList ID="ddlGroupCode" runat="server" ClientIDMode="Static">
                        <asp:ListItem Text="扣料组1" Value="1"></asp:ListItem>
                        <asp:ListItem Text="扣料组2" Value="2"></asp:ListItem>
                        <asp:ListItem Text="扣料组3" Value="3"></asp:ListItem>
                        <asp:ListItem Text="扣料组4" Value="4"></asp:ListItem>
                        <asp:ListItem Text="扣料组5" Value="5"></asp:ListItem>
                        <asp:ListItem Text="扣料组6" Value="6"></asp:ListItem>
                        <asp:ListItem Text="扣料组7" Value="7"></asp:ListItem>
                        <asp:ListItem Text="扣料组8" Value="8"></asp:ListItem>
                        <asp:ListItem Text="扣料组9" Value="9"></asp:ListItem>
                        <asp:ListItem Text="扣料组10" Value="10"></asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr >
                <td class="Label2">单面/其他投入站</td>
                <td class="Field2">
                    <asp:DropDownList ID="ddlInputStation" runat="server">
                        <asp:ListItem Text="否" Value="0"></asp:ListItem>
                        <asp:ListItem Text="是" Value="1"></asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td class="Label2">单面/其他产出站</td>
                <td class="Field2">
                    <asp:DropDownList ID="ddlOutputStation" runat="server">
                        <asp:ListItem Text="否" Value="0"></asp:ListItem>
                        <asp:ListItem Text="是" Value="1"></asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr class="hide">
                <td class="Label2">解除拼板</td>
                <td class="Field2">
                    <asp:DropDownList ID="ddlSplitPanel" runat="server">
                        <asp:ListItem Text="不需要" Value="0"></asp:ListItem>
                        <asp:ListItem Text="需要" Value="1"></asp:ListItem>
                    </asp:DropDownList>
                </td>

            </tr>
            <tr class="hide">
                <td class="Label2">OSP-双面焊接检查</td>
                <td class="Field2">
                    <asp:DropDownList ID="ddlOSPWeldCheck" runat="server">
                        <asp:ListItem Text="否" Value="0"></asp:ListItem>
                        <asp:ListItem Text="是" Value="1"></asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td class="Label2">OSP-开封至波峰焊检查</td>
                <td class="Field2">
                    <asp:DropDownList ID="ddlOSPWaveSolderingCheck" runat="server">
                        <asp:ListItem Text="否" Value="0"></asp:ListItem>
                        <asp:ListItem Text="是" Value="1"></asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr class="hide">
                <td class="Label2">启用样机测试</td>
                <td class="Field2">
                    <asp:DropDownList ID="ddlSampleExame" runat="server">
                        <asp:ListItem Text="否" Value="0"></asp:ListItem>
                        <asp:ListItem Text="是" Value="1"></asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td class="Label2" style="display: none">生成送检单</td>
                <td class="Field2" style="display: none">
                    <asp:DropDownList ID="ddlPQC" runat="server">
                        <%--   <asp:ListItem Text="否" Value="0"></asp:ListItem>--%>
                        <asp:ListItem Text="是" Value="1"></asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td class="Label2"></td>
                <td class="Field2"></td>
            </tr>
            <tr>
                <td class="Label2">上模校验</td>
                <td class="Field2">
                    <asp:DropDownList ID="ddlUpModel" runat="server">
                        <asp:ListItem Text="否" Value="0"></asp:ListItem>
                        <asp:ListItem Text="是" Value="1"></asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td class="Label2">是否打印</td>
                <td class="Field2">
                    <asp:DropDownList ID="ddlIfPrint" runat="server">
                        <asp:ListItem Text="否" Value="0"></asp:ListItem>
                        <asp:ListItem Text="是" Value="1"></asp:ListItem>
                    </asp:DropDownList>

                </td>
            </tr>

        </table>
        <div class="clear1" style="display: none">
        </div>
        <div style="position: relative; display: none">
            <div id="ActivityList" style="width: 165px; position: absolute; left: 0px; top: 2px; height: 300px; background: #eeeeee; border: 1px solid #ccc; padding: 5px; overflow: auto;">
            </div>
            <div id="ActivityParamList" style="width: 460px; position: absolute; left: 175px; top: 2px; height: 300px; border-right: 1px solid #ccc; border-top: 1px solid #ccc; border-bottom: 1px solid #ccc; border-left: 0; padding: 5px; overflow: auto;">
            </div>
        </div>
    </div>
    <script type="text/javascript" language="javascript">
        var routerId, operationId;
        $(document).ready(function () {
            routerId = '<%=Request.QueryString["RouterID"] %>';
            operationId = '<%=Request.QueryString["OperationID"] %>';
            var routerName = decodeURI('<%=Request.QueryString["RouterName"] %>');
            var operationName = decodeURI('<%=Request.QueryString["OperationName"] %>');
            $("#routerName").html(routerName);
            $("#opereationName").html(operationName);
            setRouteSetting(routerId, operationId);
            //loadRouterActivity(operationId, routerId);//8.5不再使用工序带Activity的方式,所以全部注释掉

            if ($("#ddlPickDeduct").val() == "0") {
                $("#ddlGroupCode").hide();
            }

            $("#ddlPickDeduct").change(function () {
                if (this.value == "1") {
                    $("#ddlGroupCode").show();
                }
                else {
                    $("#ddlGroupCode").hide();
                }
            });

            //SMT扣料面别
            if ($("#ddlSMTDeduct").val() == "0") {
                $("#ddlSMTDeductFace").hide();
            }
            $("#ddlSMTDeduct").change(function () {
                if (this.value == "1") {
                    $("#ddlSMTDeductFace").show();
                }
                else {
                    $("#ddlSMTDeductFace").hide();
                }
            });
        });

        function setRouteSetting(routerId, operationId) {
            ajax1 = SKT.LeanMES.Web.AjaxServices.AjaxRouter.GetRouteOperationSetting(routerId, operationId);
            if (ajax1.error != null) {
                alert(ajax1.error.Message);
                return false;
            }
            var setting = ajax1.value;
            if (setting != undefined && setting != null && setting != "") {
                var tab = document.getElementById("tabRouteSetting");

                //if (setting.ShowOpenLine == "Y") {
                //    addRowAndSetSetting(tab, "检查开拉", "ddlOpenLine", setting.DefualtOpenLine);
                //}

                //if (setting.ShowPrintCS == "Y") {
                //    addRowAndSetSetting(tab, "打印客户条码", "ddlPrintCS", setting.DefualtPrintCS);
                //}

                if (setting.ShowPrintPack == "Y") {
                    addRowAndSetSetting(tab, "打印包装号", "ddlPrintPack", setting.DefualtPrintPack);
                }

                if (setting.ShowPrintPallet == "Y") {
                    addRowAndSetSetting(tab, "打印栈板号", "ddlPrintPallet", setting.DefualtPrintPallet);
                }

                if (setting.ShowUseElecScale == "Y") {
                    addRowAndSetSetting(tab, "启用电子称", "ddlUseElecScale", setting.DefualtUseElecScale);
                }

                //if (setting.ShowRepairReceive == "Y") {
                //    addRowAndSetSetting(tab, "启用不良接收", "ddlRepairReceive", setting.DefualtRepairReceive);
                //}
            }
        }

        function addRowAndSetSetting(tab, tdLabelHtml, selectId, tdFieldValue) {
            var index = tab.rows.length;
            var tr = tab.insertRow(index);
            var td1 = tr.insertCell(0);
            td1.className = "Label2";
            td1.innerHTML = tdLabelHtml;

            var td2 = tr.insertCell(1);
            td2.className = "Field2";
            td2.colSpan = "3";
            td2.innerHTML = "<select id=\"" + selectId + "\" name=\"ddlOpenLine\"><option value=\"1\">需要</option><option value=\"0\">不需要</option></select> ";

            $("#" + selectId).val(tdFieldValue);
        }
        //8.5不再使用工序带Activity的方式,所以全部注释掉
        <%--function loadRouterActivity(operationId, routerId) {
            var ajax2, actOptions, act_name = "", act_param = "", act_value = "";

            var ajax1 = SKT.LeanMES.Web.AjaxServices.AjaxRouter.LoadRouterActivity(operationId, routerId);
            if (ajax1.error != null) {
                alert(ajax1.error.Message);
                return false;
            }
            var activityList = ajax1.value;

            for (var i = 0; i < activityList.length; i++) {
                act_name += "<div class='actList' onclick='selectAct(" + activityList[i].AC_ID + ")' onmouseover='mouseover(this)' onmouseout='mouseout(this)' title='" + activityList[i].AC_Name + "'><div class='actText'>" + activityList[i].AC_Name + "</div><div class='routeractfloatbar'><span onclick='sortRouterActivity(" + activityList[i].AC_ID + ",1)' title='move up'><img src='../Content/images/sort_ascending.png' border='0'/></span><span onclick='sortRouterActivity(" + activityList[i].AC_ID + ",2)' title='move down'><img src='../Content/images/sort_descending.png' border='0'/></span><span onclick='deleteRouterActivity(" + activityList[i].AC_ID + ")' title='remove'><img src='../Content/images/delete.gif' border='0'/></span></div></div><div class='clear5'></div> ";

                act_param += "<div class='actParam' id='" + activityList[i].AC_ID + "' onclick='mouseclick(this)'><div class='divHeader'><div>" + activityList[i].AC_Name + "</div><div class=\"bar_expand\" onclick=\"hideOrShowSearch(this," + activityList[i].AC_ID + ")\"  title=\"<%=Resources.lang.ExpandOrCollapse %>\"></div></div><table id='tbl" + activityList[i].AC_ID.toString() + "' class='EditeContentTable' width='100%'>";

                ajax2 = SKT.LeanMES.Web.AjaxServices.AjaxRouter.GetRutActOptionsByActId(activityList[i].AC_ID, operationId, routerId);
                if (ajax2.error != null) {
                    alert(ajax2.error.Message);
                    return false;
                }
                actOptions = ajax2.value;
                if (actOptions.length == 0) {
                    act_param += "<tr><td class='Label' align='center' colspan='2'><%=Resources.Messages.NoParameterForTheActivity %></td></tr>";
                }
                else {
                    for (var j = 0; j < actOptions.length; j++) {
                        act_param += "<tr><td class='Label2'>" + actOptions[j].AC_Param_Name + "</td><td class='Field2'><input type='hidden' value='" + actOptions[j].ROAOID + "' name='RouterActId'/><input type='text' name='RouterActValue' value='" + actOptions[j].AC_Param_Value + "' class='TextBox' style='width:300px;' title='" + actOptions[j].AC_Param_Remark + "'/></td></tr>";
                    }
                }
                act_param += "</table></div>";
            }

            $("#ActivityList").html(act_name);
            $("#ActivityParamList").html(act_param);
        }--%>

        function mouseover(obj) {
            $(obj).addClass("actList-hover");
            $(obj).children().eq(1).show();
        }

        function mouseout(obj) {
            $(obj).removeClass("actList-hover");
            $(obj).children().eq(1).hide();
        }

        function selectAct(acId) {
            $(this).addClass("actList-hover");
            $(".actParam-selected").removeClass("actParam-selected");
            $("#ActivityParamList div[id='" + acId + "']").addClass("actParam-selected");
        }

        function mouseclick(obj) {
            $(".actParam-selected").removeClass("actParam-selected");
            $(obj).addClass("actParam-selected");
        }
        //8.5不再使用工序带Activity的方式,所以全部注释掉
        <%--function Add() {
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=23&Multiple=false&rnd=" + Math.random(), width: 500, height: 300 });
        }

        function getChooseValue(list) {
            var ac_id = list[0][0];
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxRouter.AddRouterActivity(ac_id, routerId, operationId);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            loadRouterActivity(operationId, routerId);
        }

        function deleteRouterActivity(actId) {
            if (confirm("<%=Resources.Messages.ConfirmToDelActivity %>")) {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxRouter.DeleteRouterActivity(actId, operationId, routerId);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }
                loadRouterActivity(operationId, routerId);
            }
        }

        function sortRouterActivity(actId, up) {
            if (confirm("<%=Resources.Messages.ConfirmToUpdateActSeq %>")) {
                /*up:1 up,2 down*/
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxRouter.SortRouterActivity(actId, operationId, routerId, up);
                if (ajax.error != null) {
                    alert(ajax.error.Message)
                    return false;
                }
                loadRouterActivity(operationId, routerId);
            }
        }--%>

        function Save() {
            var ddlSMTDeduct = $("#<%=ddlSMTDeduct.ClientID %>").val();
            var steelCheck = $("#<%= ddlCheckSteel.ClientID %>").val();
            var knifeCheck = $("#<%= ddlCheckKnife.ClientID %>").val();
            var splitpanel = $("#<%= ddlSplitPanel.ClientID %>").val();
            var routerId = '<%=Request.QueryString["RouterID"] %>';
            var operationId = '<%=Request.QueryString["OperationID"] %>';
            //zhiman.yuan 2017-9-1 增加投入产出站配置
            var inputStation = $("#<%=ddlInputStation.ClientID %>").val();
            var outputStation = $("#<%=ddlOutputStation.ClientID %>").val();
            var smtAInputStation = $("#<%=ddlSMTAInputStation.ClientID %>").val();
            var smtAOutputStation = $("#<%=ddlSMTAOutputStation.ClientID %>").val();
            var smtBInputStation = $("#<%=ddlSMTBInputStation.ClientID %>").val();
            var smtBOutputStation = $("#<%=ddlSMTBOutputStation.ClientID %>").val();
            var OpenLine = $("#<%= ddlOpenLine.ClientID %>").val();
            var PickOpenLine = $("#<%= ddlPickOpenLine.ClientID %>").val();
            //huangliang 2017-11-13 增加是否打印
            var IfPrint = $("#<%= ddlIfPrint.ClientID %>").val();
            //zhiman.yuan 2018-2-7 增加扣料组编码
            var groupCode = $("#<%= ddlGroupCode.ClientID %>").val();
            /*上模校验*/
            var UpModel = $("#<%= ddlUpModel.ClientID %>").val();
            if (!checkInOutPutStation(inputStation, outputStation, smtAInputStation, smtAOutputStation, smtBInputStation, smtBOutputStation)) {
                return false;
            }
            //yz.xiong 2021-4-28 增加OSP
            var OSPWeldCheck = $("#<%= ddlOSPWeldCheck.ClientID %>").val(); //OSP-双面焊接检查
            var OSPWaveSolderingCheck = $("#<%= ddlOSPWaveSolderingCheck.ClientID %>").val(); //OSP-开封至波峰焊检查
            //by liwen 20210508
            var ddlSampleExame = $("#<%=ddlSampleExame.ClientID %>").val();
            var entity = new Object();
            entity.OpeID = operationId;
            entity.R_ID = routerId;
            entity.DefualtDeduct = ddlSMTDeduct;
            entity.DefualtSteelCheck = steelCheck;
            entity.DefualtKnifeCheck = knifeCheck;
            entity.DefualtSplitPane = splitpanel;
            entity.DefualtInputStation = inputStation;
            entity.DefualtOutputStation = outputStation;
            entity.DefualtSMTAInputStation = smtAInputStation;
            entity.DefualtSMTAOutputStation = smtAOutputStation;
            entity.DefualtSMTBInputStation = smtBInputStation;
            entity.DefualtSMTBOutputStation = smtBOutputStation;
            entity.DefualtOpenLine = OpenLine;
            entity.DefualtPickOpenLine = PickOpenLine;
            entity.DefualtPrintCS = $("#ddlPrintCS").val();
            entity.DefualtPrintPack = $("#ddlPrintPack").val();
            entity.DefualtPrintPallet = $("#ddlPrintPallet").val();
            entity.DefualtUseElecScale = $("#ddlUseElecScale").val();
            entity.DefualtRepairReceive = $("#ddlRepairReceive").val();
            entity.DefualtPickDeduct = $("#<%= ddlPickDeduct.ClientID %>").val();
            entity.IfPrint = IfPrint;
            entity.GroupCode = groupCode;
            entity.OSPWeldCheck = OSPWeldCheck;
            entity.OSPWaveSolderingCheck = OSPWaveSolderingCheck;
            entity.SampleExame = ddlSampleExame;
            entity.PQCInspect = $("#<%=ddlPQC.ClientID %>").val();
            entity.UpModel = UpModel;

            var smtDeductFace = $("#<%=this.ddlSMTDeductFace.ClientID %>").val();
            if (ddlSMTDeduct == "0") {
                smtDeductFace = "";
            }


            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxRouter.SetSMTDeduct(routerId, operationId, entity, smtDeductFace);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            //8.5不再使用工序带Activity的方式,所以全部注释掉
            //var _obj_routerActId = $("input[name='RouterActId']");
            //var _obj_routerActValue = $("input[name='RouterActValue']");
            //var routerActIdStr = "";
            //var routerActValueStr = "";

            //for (var i = 0; i < _obj_routerActId.length; i++) {
            //    routerActIdStr += $(_obj_routerActId[i]).val() + ",";
            //    routerActValueStr += $(_obj_routerActValue[i]).val() + ",";
            //}
            //var ajax = SKT.LeanMES.Web.AjaxServices.AjaxRouter.SaveRouterActivityValue(routerActIdStr, routerActValueStr);
            //if (ajax.error != null) {
            //    alert(ajax.error.Message);
            //    return false;
            //}
            alert("<%=Resources.Messages.SaveInSuccess %>");
        }

        function hideOrShowSearch(obj, i) {
            $("#tbl" + i.toString()).stop(false, true).toggle();
            $(obj).toggleClass("bar_expand_hide");
        }

        function checkInOutPutStation(inputStation, outputStation, smtAInputStation, smtAOutputStation, smtBInputStation, smtBOutputStation) {
            if (
                (inputStation == 1 && (smtAInputStation == 1 || smtBInputStation == 1)) ||
                (smtAInputStation == 1 && (inputStation == 1 || smtBInputStation == 1)) ||
                (smtBInputStation == 1 && (inputStation == 1 || smtAInputStation == 1))
            ) {
                alert("不可同时选择多个投入站！");
                return false;
            }
            else if (
                (outputStation == 1 && (smtAOutputStation == 1 || smtBOutputStation == 1)) ||
                (smtAOutputStation == 1 && (outputStation == 1 || smtBOutputStation == 1)) ||
                (smtBOutputStation == 1 && (outputStation == 1 || smtAOutputStation == 1))
            ) {
                alert("不可同时选择多个产出站！");
                return false;
            }
            else if (
                inputStation == 1 && ((smtAOutputStation == 1 || smtBOutputStation == 1))
            ) {
                alert("已设置当前工序为[投入站]，请勿设置为非[产出站]类型！");
                return false;
            }
            else if (
                smtAInputStation == 1 && ((outputStation == 1 || smtBOutputStation == 1))
            ) {
                alert("已设置当前工序为[正面投入站]，请勿设置为非[正面产出站]类型！");
                return false;
            }
            else if (
                smtBInputStation == 1 && ((smtAOutputStation == 1 || outputStation == 1))
            ) {
                alert("已设置当前工序为[背面投入站]，请勿设置为非[背面产出站]类型！");
                return false;
            }
            return true;
        }
    </script>
</asp:Content>

