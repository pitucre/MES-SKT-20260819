<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    CodeBehind="ClientProInfoConfigEdit.aspx.cs" Inherits="SKT.LeanMES.Web.ClientConfig.ClientProInfoConfigEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div class="wrap_tb">
        <ul class="tb">
           <li class="current"><%=Resources.lang.EssentialInformation%></li>
            <li>UI<%=Resources.lang.Template %></li>
        </ul>
        <div class="tb_c">
            <table width="100%" class="EditeContentTable">
                <%-- <tr><td colspan="4" class="Label"><%=Resources.Messages.WithAsteriskIsRequired %></td></tr>--%>
                <tr>
                    <td class="Label2">
                        <%= Resources.lang.InfoName %>
                    </td>
                    <td class="Field2">
                        <asp:TextBox ID="txtInfoName" runat="server" CssClass="TextBox" MaxLength="20" ReadOnly="true"
                            Enabled="false"></asp:TextBox>
                    </td>
                    <td class="Label2">
                        <%= Resources.lang.DbName %>
                    </td>
                    <td class="Field2">
                        <asp:TextBox ID="txtDbName" runat="server" CssClass="TextBox" MaxLength="30" ReadOnly="true"
                            Enabled="false"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="Label2">
                        <%= Resources.lang.IsDisplay %>
                    </td>
                    <td class="Field2">
                        <asp:CheckBox ID="cbxIsDisplay" runat="server" />
                    </td>
                    <td class="Label2">
                        <%= Resources.lang.InfoType %>
                    </td>
                    <td class="Field2">
                        <asp:DropDownList ID="ddlInfoType" runat="server" CssClass="TextBox" ReadOnly="true"
                            Enabled="false">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td class="Label2">
                        <%= Resources.lang.DisplayStyle %>
                    </td>
                    <td class="Field2" colspan="3">
                        <asp:DropDownList ID="ddlDisplayStyle" runat="server" CssClass="TextBox">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td class="Label2">
                        <%=Resources.lang.Style %>

                    </td>
                    <td class="Field2" colspan="3">
                        <asp:TextBox ID="txtDisplayCSS" runat="server" CssClass="TextArea" TextMode="MultiLine"
                                Width="98%" Height="80px"></asp:TextBox><span class="Tips"><%=string.Format(Resources.Messages.Tips_MaxInputChars,200) %></span>
                    </td>
                </tr>
            </table>
        </div>
        <div>
            <table width="100%" cellpadding="0" cellspacing="0" border="0">
                <tr>
                    <td align="center" valign="top">
                        <div style="width: 248px;">
                            <div class="divHeader" style="text-align: left">
                                <img src="../Content/images/icon/list.png" style="vertical-align: middle;">
                                 <%=Resources.lang.OptionalUITemplate %><</div>
                            <div   style="display: block; margin-top: -7px; margin-left: -3px;">
                                <asp:ListBox ID="PreUIList" runat="server" Height="280px" Width="248px" SelectionMode="Multiple"
                                    CssClass="Padd7"></asp:ListBox>
                            </div>
                        </div>
                    </td>
                    <td align="center" valign="middle">
                        <div style="width: 90px; text-align: center">
                            <input type="button"  onclick="btnChooseUI(0);" class="rightButton"
                                title="<%=Resources.lang.SelectUITemplate %>" />
                            <br />
                            <br />
                            <br />
                            <input type="button"   onclick="btnChooseUI(1);" class="leftButton"
                                title="<%=Resources.lang.RemoveUITemplate %>" />
                        </div>
                    </td>
                    <td align="center" valign="top">
                        <div style="width: 248px;">
                            <div class="divHeader" style="text-align: left">
                                <img src="../Content/images/icon/list.png" style="vertical-align: middle;">
                               <%=Resources.lang.SelectedUITemplate %></div>
                            <div   style="display: block; margin-top: -7px; margin-left: -3px;">
                                <asp:ListBox ID="UIList" runat="server" Height="280px" Width="248px" SelectionMode="Multiple"
                                    CssClass="Padd7"></asp:ListBox>
                            </div>
                        </div>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <script type="text/javascript">
        var clientProInfoConfigId = '<%=Request.QueryString["ID"]%>';
        /*保存数据*/
        function Save() {
            var txtInfoName = $.trim($("#<%=this.txtInfoName.ClientID%>").val());
            var txtDbName = $.trim($("#<%=this.txtDbName.ClientID%>").val());
            var txtIsDisplay = false;
            if ($("#<%=this.cbxIsDisplay.ClientID%>").is(':checked')) {
                txtIsDisplay = true;
            }
            var txtInfoType = $("#<%=this.ddlInfoType.ClientID%>").val();
            var txtCreateBy = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';
            var txtModifyBy = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';
            var txtDisplayStyle = $("#<%=this.ddlDisplayStyle.ClientID%>").val();
            var txtDisplayCSS = $("#<%=this.txtDisplayCSS.ClientID%>").val();

            /*表单验证*/
            /*如需表单验证可以此处处理验证 开始*/

            var popedom = "";
            $("#<%=this.UIList.ClientID%> option").each(function () {
                popedom = popedom + $(this).val()+",";               
            });

            popedom = popedom.substring(0, popedom.length - 1);
            
            var entity = {};

            entity.ClientProInfoConfigId = clientProInfoConfigId
            entity.InfoName = txtInfoName;
            entity.DbName = txtDbName;
            entity.IsDisplay = txtIsDisplay;
            entity.InfoType = txtInfoType;
            entity.CreateBy = txtCreateBy;
            entity.ModifyBy = txtModifyBy;
            entity.DisplayStyle = txtDisplayStyle;
            entity.Popedom = popedom;
            entity.DisplayCSS = txtDisplayCSS;
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxClientConfig.ClientProInfoConfigEdit(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            alert('<%=Resources.Messages.SaveInSuccess%>')
            if ('<%=Request.QueryString["inMenu"] %>' == "true") {
                openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/User/UserEdit.aspx?name=Account_UserEdit&ID=" + parseInt(ajax.value);
                location.href = openWinUrl;
            }
            else {
                parent.window.Refresh();
            }
        }

        /*不工位分配到组*/
        function btnChooseUI(index) {
            if (index == 0) {
                var selectedCode = $("#<%=this.PreUIList.ClientID %> option:selected").length;
                if (selectedCode <= 0) {
                    alert("请选择UI模板");
                    return false;
                }
                $("#<%=this.PreUIList.ClientID %> option").each(function () {
                    if ($(this).attr("selected")) {
                        $("#<%=this.UIList.ClientID %>").append("<option value=\"" + $(this).val() + "\">" + $(this).text() + "</option>");
                        $(this).remove();
                    }
                });
            }
            else {
                /*从组里面删除工位*/
                var selectedCode = $("#<%=this.UIList.ClientID %> option:selected").length;
                if (selectedCode <= 0) {
                    alert("请选择UI模板");
                    return false;
                }
                $("#<%=this.UIList.ClientID %> option").each(function () {
                    if ($(this).attr("selected")) {
                        $("#<%=this.PreUIList.ClientID %>").append("<option value=\"" + $(this).val() + "\">" + $(this).text() + "</option>");
                        $(this).remove();
                    }
                });
            }
        }
    </script>
</asp:Content>
