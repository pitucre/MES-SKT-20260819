<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/EditMaster.master"
    CodeBehind="ResourceEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Resource.ResourceEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div style="min-width: 600px; min-height: 300px;">

        <div class="wrap_tb">
            <ul class="tb">
                <li class="current" title="<%= Resources.lang.BaseInfo%>">
                    <%= Resources.lang.BaseInfo%>
                </li>
                <li title="<%= Resources.lang.Tab_License%>">
                    <%= Resources.lang.Tab_License%>
                </li>
            </ul>
            <!--资源基本信息-->
            <div class="tb_c">
                <div class="infoTips">
                    <%=Resources.Messages.WithAsteriskIsRequired %>
                </div>
                <table class="EditeContentTable" width="100%">
                    <tr>
                        <td class="Label2">
                            <%=Resources.lang.ResName%><em>*</em>
                        </td>
                        <td class="Field2" colspan="3">
                            <asp:TextBox ID="txtResName" runat="server" CssClass="TextBox" ClientIDMode="Static"
                                IsRequired='1'></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="Label2"><%=Resources.lang.ResouceType%>
                        </td>
                        <td class="Field2" colspan="3">
                            <asp:TextBox ID="txtResType" runat="server" CssClass="TextBox" Enabled="false" ClientIDMode="Static"></asp:TextBox><input
                                type="button" id="btnChooseResType" class="ButtonBox" value="..." title="选择资源类型"
                                onclick="chooseResType();" />
                            <asp:HiddenField ID="hdnResTypeId" runat="server" Value="-1" ClientIDMode="Static" />
                        </td>
                    </tr>
                    <tr>
                        <td class="Label2">
                            <%=Resources.lang.Line%><em>*</em>
                        </td>
                        <td class="Field2">
                            <asp:TextBox ID="txtLineName" runat="server" CssClass="TextBox" Enabled="false" ClientIDMode="Static" IsRequired='1'></asp:TextBox><input
                                type="button" id="btnSelectDefaultOpt" class="ButtonBox" value="..." title="选择线别"
                                onclick="selectLine();" />
                            <asp:HiddenField ID="hdnLineId" runat="server" Value="-1" ClientIDMode="Static" />
                        </td>
                        <td class="Label2">
                            <%=Resources.lang.Status%>
                        </td>
                        <td class="Field2">
                            <asp:DropDownList ID="ddlResourceStatus" runat="server" ClientIDMode="Static">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td class="Label2"><%=Resources.lang.Layout %>
                        </td>
                        <td class="Field2">
                            <asp:DropDownList ID="ddlLayout" runat="server" CssClass="TextBox" IsRequired='1'>
                            </asp:DropDownList>
                        </td>
                        <td class="Label2">
                            设备编码
                        </td>
                        <td class="Field2">
                            <asp:TextBox ID="txtEquipmentName" runat="server" CssClass="TextBox" Enabled="false" ClientIDMode="Static" ></asp:TextBox><input
                                type="button" id="btnSelectEquipment" class="ButtonBox" value="..." title="选择设备"
                                onclick="selectEquipment();" />
                            <asp:HiddenField ID="hdEquipmentCode" runat="server" Value="-1" ClientIDMode="Static" />
                        </td>
                    </tr>
                    <tr>
                        <td class="Label2"><%=Resources.lang.ResourceAvailabilityTime %>
                        </td>
                        <td class="Field2" colspan="3">
                            <asp:TextBox ID="txtValidStartTime" runat="server" CssClass="DateTimeBox" ClientIDMode="Static"></asp:TextBox>
                            ~
                            <asp:TextBox ID="txtValidEndTime" runat="server" CssClass="DateTimeBox" ClientIDMode="Static"></asp:TextBox>
                            <span class="Tips"><%=Resources.Messages.Tips_ResourcesAllowed_TimeRange %></span>
                        </td>
                    </tr>
                    <tr>
                        <td class="Label2">
                            <%=Resources.lang.Description%>
                        </td>
                        <td class="Field2" colspan="3">
                            <asp:TextBox ID="txtDescription" runat="server" CssClass="TextArea" TextMode="MultiLine"
                                ClientIDMode="Static" Width="450px" Height="90px"></asp:TextBox>
                        </td>
                    </tr>
                </table>
            </div>
            <!--授权证书-->
            <div>
                <table width="100%" cellpadding="0" cellspacing="0" border="0">
                    <tr>
                        <td align="center" valign="top">
                            <div style="width: 253px;">
                                <div class="divHeader" style="text-align: left">
                                    <img src="../Content/images/icon/list.png" style="vertical-align: middle;">
                                    <%=Resources.lang.AvailableLicense%>
                                </div>
                                <div id="avilableCerList" style="display: block; margin-top: -7px; margin-left: -3px;">
                                    <asp:ListBox ID="lbAvilableCerList" runat="server" Height="300px" Width="253px" SelectionMode="Multiple"
                                        CssClass="Padd7" ClientIDMode="Static" Rows="4"></asp:ListBox>
                                </div>
                            </div>
                        </td>
                        <td align="center" valign="middle">
                            <div style="width: 90px; text-align: center">
                                <input type="button" class="rightButton" title="分配选中的授权证书给当前资源" onclick="assignToListBox('lbAvilableCerList', 'lbAssignCerList');" />
                                <br />
                                <br />
                                <br />
                                <input type="button" class="leftButton" title="删除当前资源选中的授权证书" onclick="deleteFromListBox('lbAssignCerList', 'lbAvilableCerList');" />
                            </div>
                        </td>
                        <td align="center" valign="top">
                            <div style="width: 253px;">
                                <div class="divHeader" style="text-align: left">
                                    <img src="../Content/images/icon/list.png" style="vertical-align: middle;">
                                    <%=Resources.lang.RequiredLicense%>
                                </div>
                                <div id="assignCerList" style="display: block; margin-top: -7px; margin-left: -3px;">
                                    <asp:ListBox ID="lbAssignCerList" runat="server" Height="300px" Width="253px" SelectionMode="Multiple"
                                        ClientIDMode="Static" CssClass="Padd7"></asp:ListBox>
                                </div>
                            </div>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
    <link href="../Content/plugin/tabs/tabs.css" rel="stylesheet" type="text/css" />
    <script src="../Content/plugin/tabs/jPlugin-tabs.js" type="text/javascript"></script>
    <script type="text/javascript">
        var resId = '<%=Request.QueryString["ID"] %>';
        var tab = document.getElementById("tblExpand");
        var flag = -1;
        var rowIndex = -1;
        var rowObj = null;

        /*分配授权证书和资源类型*/
        function assignToListBox(fromListBoxId, toListBoxId) {
            var selectedCert = $("#" + fromListBoxId + " option:selected").length;
            var requiredCert = $("#" + toListBoxId + " option").length;
            if (selectedCert <= 0) {
                alert("<%=Resources.Messages.QualificationCertificatinIsRequired %>");
                return false;
            }

            if (fromListBoxId == "lbAvilableResTypeList") {
                if (selectedCert > 1) {
                    alert("<%=Resources.Messages.NotAllowSelectMoreThanOne %>");
                    return false;
                }
            }

            if (fromListBoxId == "lbAvilableResTypeList") {
                if (requiredCert >= 2) {
                    alert("<%=Resources.Messages.AlreadyHasResourceType %>");
                    return false;
                }
            }

            $("#" + fromListBoxId + " option").each(function () {
                if ($(this).attr("selected")) {
                    $("#" + toListBoxId + "").append("<option value=\"" + $(this).val() + "\">" + $(this).text() + "</option>");
                    $(this).remove();
                }
            });
        }

        /*页面上移除选择的资源证书*/
        function deleteFromListBox(fromListBoxId, toListBoxId) {
            var selectedCert = $("#" + fromListBoxId + " option:selected").length;
            if (selectedCert <= 0) {
                alert("<%=Resources.Messages.QualificationCertificatinIsRequired %>");
                return false;
            }
            $("#" + fromListBoxId + " option").each(function () {
                if ($(this).attr("selected")) {
                    if ($(this).val() == "-1") {
                        alert("<%=Resources.Messages.DefautValueNotAllowDelete %>");
                        return;
                    }
                    $("#" + toListBoxId + "").append("<option value=\"" + $(this).val() + "\">" + $(this).text() + "</option>");
                    $(this).remove();
                }
            });
        }

        /*选择线别*/
        function selectLine() {
            flag = 7;
            var searchCondition = "<%=GetConditions() %>";
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=21&Multiple=false" + searchCondition + "&rnd=" + Math.random(), width: 650, height: 350 });
        }

        /*选择设备*/
        function selectEquipment() {
            flag = 9;
           // var searchCondition = " 1=1 ";
            var searchCondition = "";

            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=54&Multiple=false" + searchCondition + "&rnd=" + Math.random(), width: 650, height: 350 });
        }

        /*设置从选择窗口选取的值*/
        function getChooseValue(list) {
            if (flag == 5) {
                rowObj.cells[0].children[2].value = list[0][0];
                rowObj.cells[0].children[0].value = list[0][1];
                rowObj.cells[1].children[0].value = list[0][2];
            } else if (flag == 7) {
                $("#hdnLineId").val(list[0][0]);
                $("#txtLineName").val(list[0][1]);
            }
            else if (flag == 9) {
                $("#hdEquipmentCode").val(list[0][1]);
                $("#txtEquipmentName").val(list[0][2]);
            }
            flag = -1;
        }

        /*保存*/
        function Save() {
            if (isNull($("#txtResName").val())) {
                alert("<%=Resources.Messages.WithAsteriskIsRequiredAlert %>");
                $("#txtResName").focus();
                return false;
            }
            var startDate = $("#<%=this.txtValidStartTime.ClientID %>").val();
            var endDate = $("#<%=this.txtValidEndTime.ClientID %>").val();
            var starTime = new Date(startDate.replace(/-/g, "\/"));
            var endTime = new Date(endDate.replace(/-/g, "\/"));
            if (starTime > endTime) {
                alert("<%=Resources.lang.StartDateIsGreaterThanEndDate %>");
                $("#<%=this.txtValidStartTime.ClientID %>").focus();
                return false;
            }

            /*时间为空时转换*/
            var strStart = startDate;
            if (strStart.length == 0) {
                strStart = "";
            }
            var strEnd = endDate;
            if (strEnd.length == 0) {
                strEnd = "";
            }

            var userName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
            var action = '<%=Request.QueryString["Action"] %>';

            /*基本信息*/
            var entity = {};
            if (action == "Copy") {
                entity.ResourceId = -1;
            }
            else {
                entity.ResourceId = resId;
            }
            entity.ResName = $("#txtResName").val();
            entity.ResDescription = $("#txtDescription").val();
            entity.ResStatus = $("#ddlResourceStatus").val();
            entity.LineId = $("#hdnLineId").val();
            entity.CreateBy = userName;
            entity.ModifyBy = userName;            
            entity.Remark = "";
            entity.EquipmentCode = $("#hdEquipmentCode").val();
            /*授权证书*/
            var resCertIDString = "";
            $("#lbAssignCerList option").each(function () {
                if ($(this).text() != "") {
                    resCertIDString += $(this).val() + ",";
                }
            });

            /*资源类型*/
            var resResTypeString = $("#<%=this.hdnResTypeId.ClientID %>").val() + ",";
            var Face = $("#<%=this.ddlLayout.ClientID%>").val();
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxServiceResource.EditResource(entity, resCertIDString, resResTypeString, "", "", strStart, strEnd, Face);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert("<%=Resources.Messages.SaveInSuccess %>");
            window.parent.UpdateList(entity.ResName);
        }

        /*选择资源类型*/
        function chooseResType() {
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=5&Multiple=false&CallBackFunc=setResourceType&rnd=" + Math.random(), width: 650, height: 350 });
        }

        /*设置资源类型*/
        function setResourceType(list) {
            $("#<%=this.txtResType.ClientID %>").val(list[0][1]);
            $("#<%=this.hdnResTypeId.ClientID %>").val(list[0][0]);
        }
    </script>
</asp:Content>
