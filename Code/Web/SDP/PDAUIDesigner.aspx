<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="PDAUIDesigner.aspx.cs" Inherits="SKT.LeanMES.Web.SDP.PDAUIDesigner" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <div>
        <table width="100%" class="EditeContentTable">
            <tr>
                <td class="Label" align="left" id="spCodeMes" colspan="2">
                    <div class="" style="height: auto">
                        <%--<h1 style="font-size: 24px; text-align: center;">
                        UI设计器</h1>--%>
                        <div style="text-align: center">   
                            <label>
                                功能模块<em>*</em></label>
                             <asp:DropDownList ID="ddlModelClass" runat="server">
                                 <asp:ListItem Text="请选择" Value="-1" Selected="True"></asp:ListItem>
                                 <asp:ListItem Text="仓库管理" Value="仓库管理"></asp:ListItem>
                                 <asp:ListItem Text="生产管理" Value="生产管理"></asp:ListItem>
                                 <asp:ListItem Text="设备管理" Value="设备管理"></asp:ListItem>
                             </asp:DropDownList>
                            <label style="margin-left: 10px;">
                                模板名称：</label><em>*</em>
                            <asp:TextBox ID="txtModelName" runat="server" IsRequired='1'></asp:TextBox>&nbsp;                                                     
                            <input type="button" value=" 系统内置 " onclick="chooseUI()" title="点击按钮可选择系统定义UI模型，并可在此基础上进行修改。" style="margin-left: 5px; margin-right: 8px;" />
                            <input type="button" value=" 预 览 " onclick="preview()"  style="margin-right: 8px;" />
                            <input type="button" id="txtUdfSave" onclick="Save()" value=" 保 存 "/>
                            
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td class="Label" align="left" colspan="2" valign="middle">
                    <span style="float: left; font-weight: bold; padding-left: 10px;">设计UI模板&nbsp;&nbsp;</span>
                    <span style="float: right; color: #cccccc">&nbsp;编辑器版本 1.0.1</span>
                </td>
            </tr>
            <tr>
                <td class="Field" align="left" colspan="2" style="padding: 0px;">
                    <div id="loadingmsg" class="loadingmessage">
                        <%=Resources.Messages.LoadingData %>
                    </div>
                    <iframe id="ifCtrl" name="ifCtrl" frameborder="0" width="100%" height="195px" marginheight="0"
                        marginwidth="0" scrolling="auto" src=""></iframe>
                    <asp:HiddenField ID="hdnValue" runat="server" Value="" />
                </td>
            </tr>
        </table>        
    </div>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.utility.store.js" type="text/javascript"></script>
    <script type="text/javascript">
        var id = '<%=Request.QueryString["ID"] %>';

        var iframes = document.getElementById("ifCtrl");
        var sdpCookie = "SDPCookie";
        $(window).resize(function () {
            setCodeHeight();
        });

        $(document).ready(function () {
            $("#leanmescontent").css("overflow", "hidden");
            var values = $("#<%=this.hdnValue.ClientID %>").val();

            iframes.src = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/highlight/htmlmixededitor.aspx?rnd=" + Math.random();
            if (iframes.attachEvent) {
                iframes.attachEvent("onload", function () {
                    $("#loadingmsg").hide();
                    if (values != "") {
                        iframes.contentWindow.setData(values);
                    }
                    else {
                        iframes.contentWindow.setData("<div>你可以在此编辑您的HTML代码</div>\n<script type='text/javascript'>/*您可以在此写入您的js代码*/<\/script>");
                    }
                    setCodeHeight();
                });
            }
            else {
                iframes.onload = function () {
                    $("#loadingmsg").hide();
                    var values = $("#<%=this.hdnValue.ClientID %>").val();
                    if (values != "") {
                        iframes.contentWindow.setData(values);
                    }
                    else {
                        iframes.contentWindow.setData("<div>你可以在此编辑您的HTML代码</div><script type='text/javascript'>/*您可以在此写入您的js代码*/<\/script>");
                    }
                    setCodeHeight();
                };
            }
        });

        //设置代码编辑器的高度
        function setCodeHeight() {
            var iframes = document.getElementById("ifCtrl");
            var h = $(window).height() - 83;
            $(".CodeMirror-scroll", iframes.contentWindow.document.body).css("height", h);
            $(".CodeMirror-scroll", iframes.contentWindow.document.body).css("overflow", "auto");
            $("#ifCtrl").css("height", h);
        }

        //选择内置模板
        function chooseUI() {
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=123&CallBackFunc=loadUI&Multiple=false&rnd=" + Math.random(), width: 600, height: 300 });
        }        

        //加载模板内容
        function loadUI(list) {            
            <%--var url = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/" + list[0][3];

            $.ajax({
                url: url,
                type: 'POST',
                contentType: "text/html;charset=uft-8",
                timeout: 10000,
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert(errorThrown);
                },
                success: function (xml) {
                    xml = /<sdpui>[\w\W]*<\/sdpui>/g.exec(xml);
                    $("#<%=this.hdnValue.ClientID %>").val(encodeURI(xml));
                    iframes.contentWindow.setData(encodeURI(xml));
                }
            });--%>

            var modelTempId = list[0][1];
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSDP.GetModelTempInfo(parseInt(modelTempId));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var entity = ajax.value;
            $("#<%=this.hdnValue.ClientID %>").val(entity.Content);
            iframes.contentWindow.setData(entity.Content);
        }

        //预览设计的UI模板
        function preview() {
            var content = document.getElementById("ifCtrl").contentWindow.getData();

            //store.set(sdpCookie, content);
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSDP.SavePDAPreview(decodeURI(content));

            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }


            var openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/MobileApp/PDAFunctionPreview.aspx?ID=" + ajax.value + "&type=preview&name=" + $.trim($('#<%=txtModelName.ClientID %>').val()) + "&rnd=" + Math.random();

            window.open(openWinUrl, "PDA功能预览");
            //window.parent.openTab(this, 'UI模板预览', openWinUrl, Date.parse(new Date()), '<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/theme/Metro/Images/page.png');
        }

        //保存UI代码
        function Save() {
            var stationId = -1;

            var className = $("#<%=ddlModelClass.ClientID %>").val();
            if (className == "-1") {
                alert("请选择PDA功能模块！");
                return false;
            }

            var name = $.trim($('#<%=txtModelName.ClientID %>').val());
            var content = document.getElementById("ifCtrl").contentWindow.getData();
            //if (stationId == -1) {
            //    alert("请选择工序！");
            //    return false;
            //}
            if (name == "") {
                alert("请输入UI模板名称！");
                $('#<%=txtModelName.ClientID %>').focus();
                return false;
            }
            if (content == "") {
                alert("请输入代码！");
                return false;
            }
            store.set(sdpCookie, content);
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSDP.UDFSave(id, name, content, className, stationId);

            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            alert("<%=Resources.Messages.SaveInSuccess %>");
            window.parent.UpdateList(name);
         }

    </script>
</asp:Content>
