<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="True"
    CodeBehind="StationEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Station.StationEdit"
    Title="Edit Station" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div class="wrap_tb" style="min-height: 350px; min-width: 600px">
        <ul class="tb">
            <li class="current" title="<%= Resources.lang.BaseInfo%>">
                <%= Resources.lang.BaseInfo%>
            </li>
            <li title="工序技能证书">工序技能证书 </li>
            <li id="div-childstation" title="子工序" style=" display:none;">子工序 </li>
        </ul>
        <!--基本信息-->
        <div class="tb_c">
            <div class="infoTips">
                <%=Resources.Messages.WithAsteriskIsRequired %></div>
            <table class="EditeContentTable" width="100%">
                <tr>
                    <td class="Label2">
                        工序名称<em>*</em>
                    </td>
                    <td class="Field2" colspan="3">
                        <asp:TextBox ID="txtOperation" runat="server" CssClass="TextBox" ClientIDMode="Static"
                            IsRequired='1' Width="270px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="Label2">
                        编码
                    </td>
                    <td class="Field2" colspan="3">
                        <asp:TextBox ID="txtShortLetter" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="Label2">
                        工序类型<em>*</em>
                    </td>
                    <td class="Field2" colspan="3">
                        <asp:TextBox ID="txtOpeType" runat="server" CssClass="TextBox" Enabled="false" ClientIDMode="Static"
                            IsRequired='1' Text=""></asp:TextBox><input type="button" id="btnSelectOpeType" class="ButtonBox"
                                value="..." title="Select" onclick="selectOpeType();" />
                        <asp:HiddenField ID="hdnOpeTypeId" runat="server" Value="-1" ClientIDMode="Static" />
                    </td>
                </tr>
                <tr>
                    <td class="Label2">
                        状态
                    </td>
                    <td class="Field2">
                        <asp:DropDownList ID="ddlOpeStatus" runat="server" ClientIDMode="Static">
                        </asp:DropDownList>
                    </td>
                    <td class="Label2">
                        资源类型<em>*</em>
                    </td>
                    <td class="Field2">
                        <asp:TextBox ID="txtResType" runat="server" CssClass="TextBox" Enabled="false" ClientIDMode="Static"></asp:TextBox><input
                            type="button" id="btnSelectResType" class="ButtonBox" value="..." title="Select"
                            onclick="selectResType();" />
                        <asp:HiddenField ID="hdnResTypeId" runat="server" Value="-1" ClientIDMode="Static" />
                    </td>
                </tr>
                <tr>                    
                    <td class="Label2">
                        工序默认绑定资源
                    </td>
                    <td class="Field2">
                        <asp:TextBox ID="txtResDefault" runat="server" CssClass="TextBox" Enabled="false"
                            ClientIDMode="Static" Text=""></asp:TextBox><input type="button" id="btnSelectResDefault"
                                class="ButtonBox" value="..." title="Select" onclick="selectResDefault();" />
                        <asp:HiddenField ID="hdnResId" runat="server" Value="-1" ClientIDMode="Static" />
                    </td>
                </tr>
                <tr>                   
                    <td class="Label2">
                        是否采集工位
                    </td>
                    <td class="Field2">
                        <asp:CheckBox runat="server" ID="chkIsCollectStation" Checked="true" ClientIDMode="Static" />
                    </td>
                </tr>
                <%--<tr>
                    <td class="Label2">
                        UI模板<em>*</em>
                    </td>
                    <td class="Field2" colspan="3">
                        <asp:TextBox ID="txtNewTemp" runat="server" CssClass="TextBox" Enabled="false"
                            IsRequired='1' ClientIDMode="Static"></asp:TextBox><input type="button" id="btnSelectTemp"
                                class="ButtonBox" value="..." title="Select" onclick="selectNewTemplate();" />
                        <asp:HiddenField ID="hdnNewTemplate" runat="server" Value="-1" ClientIDMode="Static" />
                    </td>
                </tr>--%>
                <tr>
                    <td class="Label2">
                        版本<em>*</em>
                    </td>
                    <td class="Field2">
                        <asp:TextBox ID="txtVersion" runat="server" CssClass="TextBox" ClientIDMode="Static"
                            IsRequired='1' Width="60px"></asp:TextBox>
                    </td>
                    <td class="Label2">
                        是否当前版本
                    </td>
                    <td class="Field2">
                        <asp:CheckBox runat="server" ID="chkIsCurrent" Checked="true" ClientIDMode="Static"
                            Enabled="false" />
                    </td>
                </tr>
                <tr>
                    <td class="Label2">
                        描述
                    </td>
                    <td class="Field2" colspan="3">
                        <asp:TextBox ID="txtDescription" runat="server" CssClass="TextBox" ClientIDMode="Static" TextMode="MultiLine"
                            Width="350px" Height="90px"></asp:TextBox>
                    </td>
                </tr>
            </table>
        </div>
        <!--工序技能证书-->
        <div>
            <table width="100%" cellpadding="0" cellspacing="0" border="0">
                <tr>
                    <td align="center" valign="top">
                        <div style="width: 253px;">
                            <div class="divHeader" style="text-align: left">
                                <img src="../Content/images/icon/list.png" style="vertical-align: middle;">
                               <%=Resources.lang.OptionalSkillCertificates %> 
                            </div>
                            <div id="avilableCerList" style="display: block; margin-top: -7px; margin-left: -3px;">
                                <asp:ListBox ID="lbAvilableCerList" runat="server" Height="300px" Width="253px" SelectionMode="Multiple"
                                    CssClass="Padd7" ClientIDMode="Static"></asp:ListBox>
                            </div>
                        </div>
                    </td>
                    <td align="center" valign="middle">
                        <div style="width: 90px; text-align: center">
                            <input type="button" class="rightButton" onclick="assignToListBox('lbAvilableCerList','lbAssignCerList',1);" />
                            <br />
                            <br />
                            <br />
                            <input type="button" class="leftButton" onclick="deleteFromListBox('lbAssignCerList','lbAvilableCerList',1);" />
                        </div>
                    </td>
                    <td align="center" valign="top">
                            <div style="width: 253px;">
                            <div class="divHeader" style="text-align: left">
                                <img src="../Content/images/icon/list.png" style="vertical-align: middle;">
                               <%=Resources.lang.AssignedSkillsAndCertificates %> </div>
                            <div id="assignCerList" style="display: block; margin-top: -7px; margin-left: -3px;">
                                <asp:ListBox ID="lbAssignCerList" runat="server" Height="300px" Width="253px" SelectionMode="Multiple"
                                    ClientIDMode="Static" CssClass="Padd7"></asp:ListBox>
                            </div>
                        </div>
                    </td>
                </tr>
            </table>
        </div>
        <!--子工序-->
        <div >
            <table width="100%" cellpadding="0" cellspacing="0" border="0">
                <tr>
                    <td align="center" valign="top">
                        <div style="width: 253px;">
                            <div class="divHeader" style="text-align: left">
                                <img src="../Content/images/icon/list.png" style="vertical-align: middle;">
                                可分配工位
                            </div>
                            <div id="avilableOpeTypeList" style="display: block; margin-top: -7px; margin-left: -3px;">
                                <asp:ListBox ID="lbAvilableOperation" runat="server" Height="300px" Width="253px"
                                    SelectionMode="Multiple" CssClass="Padd7" ClientIDMode="Static"></asp:ListBox>
                            </div>
                        </div>
                    </td>
                    <td align="center" valign="middle">
                        <div style="width: 90px; text-align: center">
                            <input type="button" class="rightButton" onclick="assignToListBox('lbAvilableOperation','lbAssignOperation',2);" />
                            <br />
                            <br />
                            <br />
                            <input type="button" class="leftButton" onclick="deleteFromListBox('lbAssignOperation','lbAvilableOperation',2);" />
                        </div>
                    </td>
                    <td align="center" valign="top">
                        <div style="width: 253px;">
                            <div class="divHeader" style="text-align: left">
                                <img src="../Content/images/icon/list.png" style="vertical-align: middle;">
                                已分配工位</div>
                            <div id="assignOpeTypeList" style="display: block; margin-top: -7px; margin-left: -3px;">
                                <asp:ListBox ID="lbAssignOperation" runat="server" Height="300px" Width="253px" SelectionMode="Multiple"
                                    ClientIDMode="Static" CssClass="Padd7"></asp:ListBox>
                            </div>
                        </div>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <script type="text/javascript">
        var opeId = '<%=Request.QueryString["ID"] %>';

        /*ESOP模式修改 子工序 注释
        $(function () {
            $("#chkIsCollectStation").click(function (event) {
                if ($("#chkIsCollectStation").is(":checked")) {
                    $("#div-childstation").show();
                } else {
                    $("#div-childstation").hide();
                }

            });

            if ($("#chkIsCollectStation").is(":checked")) {
                $("#div-childstation").show();
            } else {
                $("#div-childstation").hide();
            }

        });
        */

        function assignToListBox(fromListBoxId, toListBoxId, listFlag) {
            var selectedCert = $("#" + fromListBoxId + " option:selected").length;
            if (selectedCert <= 0) {
                var msg = '<%=Resources.Messages.QualificationCertificatinIsRequired %>';
                if (listFlag == 2) {
                    msg = "请选择工序！";
                }
                alert(msg);
                return false;
            }
            $("#" + fromListBoxId + " option").each(function () {
                if ($(this).attr("selected")) {
                    $("#" + toListBoxId + "").append("<option value=\"" + $(this).val() + "\">" + $(this).text() + "</option>");
                    $(this).remove();
                }
            });
        }

        function deleteFromListBox(fromListBoxId, toListBoxId, listFlag) {
            var selectedCert = $("#" + fromListBoxId + " option:selected").length;
            if (selectedCert <= 0) {
                var msg = '<%=Resources.Messages.QualificationCertificatinIsRequired %>';
                if (listFlag == 2) {
                    msg = "请选择工序！";
                }
                alert(msg);
                return false;
            }
            $("#" + fromListBoxId + " option").each(function () {
                if ($(this).attr("selected")) {
                    $("#" + toListBoxId + "").append("<option value=\"" + $(this).val() + "\">" + $(this).text() + "</option>");
                    $(this).remove();
                }
            });
        }

        var flag = -1;
        function selectOpeType() {
            flag = 8;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=4&Multiple=false&rnd=" + Math.random(), width: 600, height: 300 });
        }

        function selectResType() {
            flag = 9;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=5&Multiple=false&rnd=" + Math.random(), width: 600, height: 300 });
        }

        function selectResDefault() {
            flag = 10;
           // var searchCondition = "1=1";
            var searchCondition = "";

            //            if ($("#txtResType").val() != "") {
            searchCondition = " ResourceId IN(SELECT ResourceId FROM Basal_ResourceTypeMember WHERE ResourceTypeId = " + $("#hdnResTypeId").val() + ")";
            //            }
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=6&PageCondition=" + escape(searchCondition) + "&Multiple=false&rnd=" + Math.random(), width: 600, height: 300 });
        }

        function getChooseValue(list) {
            if (flag == 8) {
                $("#hdnOpeTypeId").val(list[0][0]);
                $("#txtOpeType").val(list[0][1]);
            } else if (flag == 9) {
                $("#hdnResTypeId").val(list[0][0]);
                $("#txtResType").val(list[0][1] == "" ? "" : list[0][1]);

                //clear default resource
                $("#hdnResId").val("-1");
                $("#txtResDefault").val("");

            } else if (flag == 10) {
                $("#hdnResId").val(list[0][0]);
                $("#txtResDefault").val(list[0][1]);
            }
            else if (flag == 11) {
//                $("#hdnTemplateId").val(list[0][0]);
//                $("#txtOperationUITemp").val(list[0][1]);
            }
            flag = -1;
        }

        function Save() {
            if (isNull($("#txtOperation").val()) || isNull($("#txtVersion").val()) || isNull($("#txtOpeType").val())) {
                alert("<%=Resources.Messages.WithAsteriskIsRequiredAlert %>");
                return;
            }

            /*基本信息*/
            var entity = {};
            var action = '<%=Request.QueryString["Action"] %>';
            var userName = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>';
            var chkIsCollectStation = $("#chkIsCollectStation").is(":checked") == true ? 1 : 2;
            if (action == "Copy") {
                entity.StationId = -1;
            }
            else {
                entity.StationId = opeId;
            }
            entity.Station = $.trim($("#txtOperation").val());
            entity.StationDesc = $.trim($("#txtDescription").val());
            entity.StationTypeId = $("#hdnOpeTypeId").val();
            entity.StationStatus = $("#ddlOpeStatus").val();
            entity.StationResTypeId = $("#hdnResTypeId").val();
            entity.StationDefaultResId = $("#hdnResId").val();
            entity.StationRevision = $.trim($("#txtVersion").val());
            entity.StationIsCurrentRev = document.getElementById("chkIsCurrent").checked;
            entity.Remark = "";
            entity.TmplID = -1;
            entity.ShortLetter = $("#txtShortLetter").val();
            entity.CreateBy = userName;
            entity.ModifyBy = userName;
            entity.IsCollectStation = chkIsCollectStation;

            if (getByteLen(entity.Station) > 50) {
                alert("工序不能长度超过50个字节（汉字占两个字节，字母数字占一个字节）");
                return;
            }
            if (entity.StationResTypeId<0) {
                alert("请选择资源类型！");
                return;
            }
            //entity.ModuleId = $("#hdnNewTemplate").val();
            //alert("station:" + entity.Station + "; ShortLetter:" + entity.ShortLetter);
            /*授权证书*/
            var opeCertIDString = "";
            $("#lbAssignCerList option").each(function () {
                if ($(this).text() != "") {
                    opeCertIDString += $(this).val() + ",";
                }
            });

            /*子工序*/
            var sonStationId = "";
            $("#lbAssignOperation option").each(function () {
                if ($(this).text() != "") {
                    sonStationId += $(this).val() + ",";
                }
            });
           
            /*Save Event*/
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxStation.EditStation(entity, opeCertIDString, sonStationId);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            if (opeId == -1 || action == "Copy") {
                if (window.confirm("保存成功,是否需要再新增？")) {
                    document.forms[0].submit();
                }
                else {
                    window.parent.UpdateList(entity.Station);
                }
            }
            else {
                alert("<%=Resources.Messages.SaveInSuccess %>");
                window.parent.UpdateList(entity.Station);
            }
        }

        function selectTemplate() {
            flag = 11;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=19&Multiple=false&rnd=" + Math.random(), width: 600, height: 300 });
        }

//        function selectNewTemplate() {
//            flag = 12;
//            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=121&CallBackFunc=setTemplate&Multiple=false&rnd=" + Math.random(), width: 600, height: 300 });
//        }

//        function setTemplate(list) {
//            $("#hdnNewTemplate").val(list[0][1]);
//            $("#txtNewTemp").val(list[0][2]);
        //        }

        function getByteLen(val) {
            var len = 0;
            for (var i = 0; i < val.length; i++) {
                var a = val.charAt(i);
                if (a.match(/[^\x00-\xff]/ig) != null) {
                    len += 2;
                }
                else {
                    len += 1;
                }
            }
            return len;
        }
    </script>
</asp:Content>
