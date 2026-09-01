<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TemplatesEdit.aspx.cs"
    MasterPageFile="~/Masters/EditMaster.master" Inherits="SKT.LeanMES.Web.Activities.TemplatesEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div class="wrap_tb">
        <ul class="tb">
            <li id="tb1" class="current">模板属性</li>
            <li>模板代码</li>
        </ul>
        <div class="tb_c">
            <div class="infoTips">
                <%=Resources.Messages.WithAsteriskIsRequired %>
            </div>
            <table width="100%" class="EditeContentTable">
                <tr>
                    <td class="Label1">
                        模板名<em>*</em>
                    </td>
                    <td class="Field1">
                        <asp:TextBox ID="txtTmplName" IsRequired="1" MaxLength='50' runat="server" CssClass="TextBox"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="Label1">
                        描述
                    </td>
                    <td class="Field1">
                        <asp:TextBox ID="txtTmplDesc" runat="server" CssClass="TextArea" TextMode="MultiLine"></asp:TextBox>
                    </td>
                </tr>
            </table>
        </div>
        <div>
            <table width="100%" class="EditeContentTable">
                <tr>
                    <td class="Label" align="left">
                        <span style="float: left; padding-left: 10px; font-weight: bold;">模板内容</span> <span
                            style="float: right; color: #cccccc">编辑器版本 1.0.1</span>
                    </td>
                </tr>
                <tr>
                    <td align="left" valign="top">
                        <div id="loadingmsg" class="loadingmessage">
                            <img src="../Content/images/gif/loading.gif" style="vertical-align: middle; margin-right: 5px;" /><span
                                style="line-height: 28px;"><%=Resources.Messages.LoadingData %></span>
                        </div>
                        <iframe id="ifCtrl" name="ifCtrl" frameborder="0" width="100%" height="300px" marginheight="0"
                            marginwidth="0" scrolling="auto" src=""></iframe>
                        <asp:HiddenField ID="hdnValue" runat="server" Value="" />
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <script type="text/javascript">
        $(function () {
            var iframes = document.getElementById("ifCtrl");
            iframes.src = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/highlight/htmlmixededitor.html?rnd=" + Math.random();
            var values = $("#<%=this.hdnValue.ClientID %>").val();

            if (iframes.attachEvent) {
                iframes.attachEvent("onload", function () {
                    $("#loadingmsg").hide();
                    if (values != "") {
                        iframes.contentWindow.setData(values);
                    }
                    else {
                        iframes.contentWindow.setData("<div>你可以在此编辑您的HTML代码</div>\r\n<script type='text/javascript'>\r\n/*您可以在此写入您的js代码*/\r\n<\/script>");
                    }
                    setCodeHeight();
                });
            }
            else {
                iframes.onload = function () {
                    $("#loadingmsg").hide();
                    if (values != "") {
                        iframes.contentWindow.setData(values);
                    }
                    else {
                        iframes.contentWindow.setData("<div>你可以在此编辑您的HTML代码</div>\r\n<script type='text/javascript'>\r\n/*您可以在此写入您的js代码*/\r\n<\/script>");
                    }
                    setCodeHeight();
                };
            }

            $(window).keydown(function (e) {
                if (e.which == 83 && e.ctrlKey) {
                    Save();
                }
            });

            keepSessionAlive();

            $(window).resize(function () { setCodeHeight(); })
        });

        function Save() {
            var tmplId = '<%=Request.QueryString["ID"] %>';
            var txtTmplName = $("#<%=this.txtTmplName.ClientID %>").val();
            var tmplContent = document.getElementById("ifCtrl").contentWindow.getData();
            var txtTmplDesc = $("#<%=this.txtTmplDesc.ClientID %>").val();
            if (txtTmplName == "") {
                alert("<%= Resources.Messages.WithAsteriskIsRequiredAlert %>");
                $("#tb1").click();
                $("#<%=this.txtTmplName.ClientID %>").focus();
                return false;
            }
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxActivity.EditTemplate(tmplId, txtTmplName, tmplContent, txtTmplDesc);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert("数据保存成功。");
            window.parent.refreshTab("Activities_TemplatesList");
            window.parent.closeTab(window.parent.getCurrentTab()[0]);
        }

        function resizeContent() {
            var iframes = document.getElementById("ifCtrl");
            $(".EditeContentTable tr:eq(1),.EditeContentTable tr:eq(2)").toggle();
            if ($("#ifCtrl").css("height").replace("px", "") == "300") {
                $(".CodeMirror-scroll", iframes.contentWindow.document.body).css("height", "380px");
                $(".CodeMirror-scroll", iframes.contentWindow.document.body).css("overflow", "auto");
                $("#ifCtrl").css("height", "380px");
            }
            else {
                $(".CodeMirror-scroll", iframes.contentWindow.document.body).css("height", "300px");
                $("#ifCtrl").css({ "overflow": "auto", "height": "300px" });
            }
        }

        function setCodeHeight() {
            var iframes = document.getElementById("ifCtrl");
            var h = $(window).height() - 110;
            $(".CodeMirror-scroll", iframes.contentWindow.document.body).css("height", h);
            $(".CodeMirror-scroll", iframes.contentWindow.document.body).css("overflow", "auto");
            $("#ifCtrl").css("height", h);
        }

        function keepSessionAlive() {
            setInterval(function () {
                $.post("../Framework/Expired.aspx?rnd=" + Math.random() * 1000);
            }, 180000);
        }
    </script>
</asp:Content>
