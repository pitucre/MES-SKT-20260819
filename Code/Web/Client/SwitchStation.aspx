<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    CodeBehind="SwitchStation.aspx.cs" Inherits="SKT.LeanMES.Web.Client.SwitchStation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1">
                <b>
                    <%=Resources.lang.Station %></b>
            </td>
            <td class="Field1">
                <select id="ddlOperations" name="ddlOperations" style="z-index: 0;">
                    <option value="-1">选择工位</option>
                </select>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <b>
                    <%=Resources.lang.Resource %></b>
            </td>
            <td class="Field1">
                <select id="ddlResources" name="ddlResources" class="select">
                    <option value="-1">
                        <%=Resources.lang.Choose %><%=Resources.lang.Resource %></option>
                </select>
            </td>
        </tr>
    </table>
    <script src="../Content/js/jquery-3.1.0.min.js"></script>
    <link href="../Content/js/select/combo.select.css" rel="stylesheet" />
    <script src="../Content/js/select/jquery.combo.select.js"></script>
    <script language="javascript" type="text/javascript">
        function Save() {
            /*需要选择工位*/
            if ($("#ddlOperations").val() == "-1") {
                $("#ddlOperations").focus();
                return false;
            }
            /*需要选择资源*/
            if ($("#ddlResources").val() == "-1") {
                $("#ddlResources").focus();
                return false;
            }
            var optionId = $("#ddlOperations").val();
            var resId = $("#ddlResources").val();
            var location;
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxClientController.SwitchStation(optionId, resId);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, "", ajax.error.Message);
                return false;
            }
            if ($.trim(ajax.value) == "") {
                alert("请先配置好站位模板！");
                return false;
            }
            location = encodeURI(ajax.value);

            /*缓存用户登录工序资源信息*/
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxClientController.SetUserLoginCache(optionId, resId);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, "", ajax.error.Message);
                return false;
            }

            parent.window.location.href = '../' + location + "&rnd=" + Math.random();
        }

        $(function () {
            //移除引入的js:
            var jssrc = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/jquery.min.js";
            $("script[src='" + jssrc + "']").remove()
        });

            $(document).ready(function () {
                bindOperation('<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>');
              
                /*操作站位改变时绑定相应的资源*/
                $("#ddlOperations").change(function () {
                    operationId = $("#ddlOperations").val();
                    //BirongLiang 选中默认资源  2016-12-26
                    var defResId = getDefaultResource(operationId);

                    bindResourcesByOprId(operationId, '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>', defResId);

                });
                $("#ddlOperations").comboSelect();
            });

        /*根据用户绑定工位*/
        function bindOperation(username) {
            $("#ddlOperations").html("<option value='-1'>没有合适的工位</option>");
            $("#ddlResources").html("<option value='-1'>没有合适的资源</option>");

            /*根据用户获取所有的工位类型*/
            var ajax1 = SKT.LeanMES.Web.AjaxServices.AjaxLogin.GetOperationTypeByUserRole(username, -1, false);
            if (ajax1.error != null) {
                //                msg.text(ajax1.error.Message);
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, "", ajax1.error.Message);

                return false;
            }
            var list1 = ajax1.value; /*所有的有权限的站位*/
            var list2 = list1;
            if (list1.length == 0) {
                $("#ddlOperations").html("<option value='-1'>" + noOperation + "</option>");
                return false;
            }
            var oprType = "<option value='-1'>选择工位</option>";
            var stationTypeIdStr = ";" + list1[0].StationTypeId + ";";
            var arr1 = new Array();
            var arr2 = new Array();
            arr1[0] = list1[0].StationTypeId;;
            arr1[1] = list1[0].OpeType;
            arr2.push(arr1);

            for (var i = 0, j = list1.length; i < j; i++) {
                if ($.trim(stationTypeIdStr) != "") {
                    if (stationTypeIdStr.indexOf(";" + list1[i].StationTypeId + ";") == -1) {
                        arr1 = new Array();
                        arr1[0] = list1[i].StationTypeId;;
                        arr1[1] = list1[i].OpeType;
                        arr2.push(arr1);
                        stationTypeIdStr += list1[i].StationTypeId + ";";
                    }
                }
            }

            for (var i = 0, j = arr2.length; i < j; i++) {
                oprType += "<optgroup label='" + arr2[i][1] + "'>";
                for (var k = 0, m = list2.length; k < m; k++) {
                    if (list2[k].StationTypeId == arr2[i][0]) {
                        if ($.trim(list2[k].Station) != "") {
                            oprType += "<option value='" + list2[k].StationId + "'>" + list2[k].Station + "</option>";
                        }
                    }
                }
            }

            $("#ddlOperations").html(oprType);
        }

        /*根据工位ID绑定资源*/
        function bindResourcesByOprId(oprId, username, defResId) {
            var r = "";
            var noResources = "没有合适的资源";
            $("#ddlResources").html("<option value='-1'>没有合适的资源</option>");

            if (oprId == -1) {
                r = "<option value='-1'>" + noResources + "</option>";
            }
            else {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxLogin.GetResourcesByOprId(oprId, username);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    //写入日志
                    SaveUserUILog("一般", stationId, resourceId, "", ajax.error.Message);
                    return false;
                }
                var list = ajax.value;

                if (list.length == 0) {
                    r = "<option value='-1'>" + noResources + "</option>";
                }
                else {
                    r = "<option value='-1'>选择资源</option>";
                }

                for (var i = 0; i < list.length; i++) {
                    if (list[i].ResourceId === defResId) {
                        r += "<option selected='selected' value='" + list[i].ResourceId + "'>" + list[i].ResName + "</option>";
                    } else {
                        r += "<option value='" + list[i].ResourceId + "'>" + list[i].ResName + "</option>";
                    }
                }
            }
            $("#ddlResources").html(r);
        }

        //根据stationID获取默认资源 
        function getDefaultResource(opeId) {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxLogin.GetDefResByOprId(opeId * 1);
            if (ajax.error != null) {
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, "", ajax.error.Message);
                return '-1';
            }
            return ajax.value;
        }

    </script>
</asp:Content>
