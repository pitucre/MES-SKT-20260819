<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="True"
    CodeBehind="StationTypeEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Station.StationTypeEdit"
    Title="Edit StationType" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div class="wrap_tb" style="min-height: 350px; min-width: 600px">
        <ul class="tb">
            <li class="current" title="<%= Resources.lang.BaseInfo%>">
                <%= Resources.lang.BaseInfo%>
            </li>
            <li title="分配工位">分配工位 </li>
        </ul>
        <!--基本信息-->
        <div class="tb_c">
            <div class="infoTips">
                <%=Resources.Messages.WithAsteriskIsRequired %></div>
            <table class="EditeContentTable" width="100%">
                <tr>
                    <td class="Label2">
                        工序类型<em>*</em>
                    </td>
                    <td class="Field2">
                        <asp:TextBox ID="txtOpeType" runat="server" CssClass="TextBox" ClientIDMode="Static"
                            IsRequired='1'></asp:TextBox>
                    </td>
                </tr>
                <tr style="display:none;">
                    <td class="Label2">
                        设置模板
                    </td>
                    <td class="Field2">
                        <asp:TextBox ID="txtOperationUITemp" runat="server" CssClass="TextBox" Enabled="false"
                            IsRequired='0' ClientIDMode="Static"></asp:TextBox><input type="button" id="btnSelectOperationUITemp"
                                class="ButtonBox" value="..." title="Select" onclick="selectTemplate();" />
                        <asp:HiddenField ID="hdnTemplateId" runat="server" Value="-1" ClientIDMode="Static" />
                    </td>
                </tr>
                <tr>
                    <td class="Label2">
                        描述
                    </td>
                    <td class="Field2">
                        <asp:TextBox ID="txtDescription" runat="server" CssClass="TextArea" ClientIDMode="Static"
                            TextMode="MultiLine"  Width="350px" Height="90px"></asp:TextBox>
                    </td>
                </tr>
            </table>
        </div>
        <!--分配工位-->
        <div>
            <table width="100%" cellpadding="0" cellspacing="0" border="0">
                <tr>
                    <td align="center" valign="top">
                        <div style="width: 253px;">
                            <div class="divHeader" style="text-align: left">
                                <img src="../Content/images/icon/list.png" style="vertical-align: middle;">
                                <%=Resources.lang.AssignableStation %>
                            </div>
                            <div id="avilableOpeTypeList" style="display: block; margin-top: -7px; margin-left: -3px;">
                                <asp:ListBox ID="lbAvilableOperation" runat="server" Height="300px" Width="253px"
                                    SelectionMode="Multiple" CssClass="Padd7" ClientIDMode="Static"></asp:ListBox>
                            </div>
                        </div>
                    </td>
                    <td align="center" valign="middle">
                        <div style="width: 90px; text-align: center">
                            <input type="button" class="rightButton" onclick="assignToListBox('lbAvilableOperation','lbAssignOperation');" />
                            <br />
                            <br />
                            <br />
                            <input type="button" class="leftButton" onclick="deleteFromListBox('lbAssignOperation','lbAvilableOperation');" />
                        </div>
                    </td>
                    <td align="center" valign="top">
                        <div style="width: 253px;">
                            <div class="divHeader" style="text-align: left">
                                <img src="../Content/images/icon/list.png" style="vertical-align: middle;">
                                <%=Resources.lang.AllocatedLocation %></div>
                            <div id="assignOpeTypeList" style="display: block;margin-top: -7px; margin-left: -3px;">
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
        var OpeTypeId = '<%=Request.QueryString["ID"] %>';

        function assignToListBox(fromListBoxId, toListBoxId) {
            var selectedCert = $("#" + fromListBoxId + " option:selected").length;
            if (selectedCert <= 0) {
                alert("<%=Resources.Messages.ResourceIsRequired %>");
                return false;
            }
            $("#" + fromListBoxId + " option").each(function () {
                if ($(this).attr("selected")) {
                    $("#" + toListBoxId + "").append("<option value=\"" + $(this).val() + "\">" + $(this).text() + "</option>");
                    $(this).remove();
                }
            });
        }

        function deleteFromListBox(fromListBoxId, toListBoxId) {
            var selectedCert = $("#" + fromListBoxId + " option:selected").length;
            if (selectedCert <= 0) {
                alert("<%=Resources.Messages.ResourceIsRequired %>");
                return false;
            }
            $("#" + fromListBoxId + " option").each(function () {
                if ($(this).attr("selected")) {
                    $("#" + toListBoxId + "").append("<option value=\"" + $(this).val() + "\">" + $(this).text() + "</option>");
                    $(this).remove();
                }
            });
        }

        function selectTemplate() {
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=19&Multiple=false&rnd=" + Math.random(), width: 550, height: 300 });
        }

        function getChooseValue(list) {
            $("#hdnTemplateId").val(list[0][0]);
            $("#txtOperationUITemp").val(list[0][1]);
        }

        function Save() {
            if (isNull($("#txtOpeType").val())) {
                alert("<%=Resources.Messages.WithAsteriskIsRequiredAlert %>");
                return;
            }

            /*基本信息*/
            var entity = {};
            var action = '<%=Request.QueryString["Action"] %>';
            var userName = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>';
            if (action == "Copy") {
                entity.StationTypeId = -1;
            }
           
            else {
                entity.StationTypeId = OpeTypeId;
            }
            entity.ModifyBy = "";
            entity.StationType = $.trim($("#txtOpeType").val());
            entity.StationDesc = $.trim($("#txtDescription").val());
            entity.TempId = $("#hdnTemplateId").val();
            entity.CreateBy = userName;
            if (entity.StationTypeId != -1) {
                entity.ModifyBy = userName;
            }
            
            entity.Remark = "";

            /*分配Operation*/
            var opeIdString = "";
            $("#lbAssignOperation option").each(function () {
                if ($(this).text() != "") {
                    opeIdString += $(this).val() + ",";
                }
            });

            /*Save Event*/
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxStation.EditStationType(entity, opeIdString);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            alert("<%=Resources.Messages.SaveInSuccess %>");
            window.parent.UpdateList(entity.StationType);
        }
    </script>
</asp:Content>
