<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    CodeBehind="SysConfig.aspx.cs" Inherits="SKT.LeanMES.Web.SystemConfiguration.SysConfig" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.utility.validation.js"></script>
    <div id="onprocess" style="text-align: center;">
    </div>
    <div class="wrap_tb">
        <ul class="tb">
            <li style="display: none;"><%=Resources.lang.GlobalParameters %></li>
            <li class="current"><%= Resources.lang.DatabaseLinkConfiguration %></li>
            <li style="display: none;"><%=Resources.lang.SessionConfiguration %></li>
            <li><%= Resources.lang.LogoConfiguration %></li>
        </ul>
        <div style="display: none;">
            <div class="infoTips">
                <%= Resources.Messages.WithAsteriskIsRequired %>
            </div>
            <table class="EditeContentTable" width="100%">
                <tr>
                    <td class="Label1">    <%=Resources.lang.SystemSwitch %>
                    </td>
                    <td class="Field1">
                        <div style="width: 60px; height: 21px; border: 1px solid #c3c3c3; padding: 2px; position: relative; background: #e3e3e3; cursor: pointer;"
                            onclick="switchBtn(this)">
                            <div style="width: 32px; height: 25px; border: 0px; padding: 0px; margin: 0px; background: green; top: 0px; left: 0px; position: absolute; line-height: 25px; text-align: center; color: White; cursor: default;">
                                <%=Resources.lang.Normal %>
                            </div>
                        </div>
                        <asp:HiddenField runat="server" ID="hdnSystemSwitch" Value="1" />
                    </td>
                </tr>
                <tr id="txtCloseReasonWrap">
                    <td class="Label1"> <%=Resources.lang.ReasonsForClosing %> <em>*</em>
                    </td>
                    <td class="Field1">
                        <asp:TextBox runat="server" ID="txtCloseReason" TextMode="MultiLine" CssClass="TextArea"
                            Text="<%$ Resources:lang,TheSystemIsUpgrading %>..."></asp:TextBox>
                    </td>
                </tr>
            </table>
        </div>
        <div class="tb_c">
            <div class="infoTips">
                <%= Resources.Messages.WithAsteriskIsRequired %>
            </div>
            <table class="EditeContentTable" width="100%">
                <tr>
                    <td class="Label1"> <%= Resources.lang.DatabaseEncryption %>
                    </td>
                    <td class="Field1">
                        <asp:DropDownList runat="server" ID="ddlIsEncrypt">
                          <asp:ListItem Text="<%$ Resources:lang,Encryption %>" Value="true"></asp:ListItem>
                            <asp:ListItem Text="<%$ Resources:lang,Plaintext %>" Value="false"></asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
            </table>
            <div class="clear5">
            </div>
            <div class="divHeader">
                <img src="../Content/images/icon/edit_dblink.png" class="imgText" />&nbsp;<%=Resources.lang.MESDatabaseLink %>
            </div>
            <table class="EditeContentTable" width="100%">
                <tr>
                    <td class="Label1">服务器<em>*</em>
                    </td>
                    <td class="Field1">
                        <asp:TextBox runat="server" ID="txtMESDBServer" Text="" CssClass="TextBox MESDB" Width="250px"></asp:TextBox><span
                            class="Tips"><%=Resources.lang.IfThereIsAPort %></span>
                    </td>
                </tr>
                <tr>
                    <td class="Label1">用户名<em>*</em>
                    </td>
                    <td class="Field1">
                        <asp:TextBox runat="server" ID="txtMESDBUserName" Text="" CssClass="TextBox MESDB"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="Label1">密码<em>*</em>
                    </td>
                    <td class="Field1">
                        <asp:TextBox runat="server" ID="txtMESDBPwd" Text="" TextMode="Password" CssClass="TextBox MESDB"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="Label1">数据库名<em>*</em>
                    </td>
                    <td class="Field1">
                        <asp:TextBox runat="server" ID="txtMESDBName" Text="" CssClass="TextBox MESDB"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="Label1">最大链接池<em>*</em>
                    </td>
                    <td class="Field1">
                        <asp:TextBox runat="server" ID="txtMESDBPool" Text="500" CssClass="NumericBox50"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="Label1">超时间隔<em>*</em>
                    </td>
                    <td class="Field1">
                        <asp:TextBox runat="server" ID="txtMESInterval" Text="" CssClass="NumericBox50"></asp:TextBox><input type="button" id="btnMESTestConn" value="测试连接" onclick="CheckMesConn()" style="cursor: pointer;" />
                    </td>
                </tr>
            </table>
            <div class="clear5">
            </div>
            <div class="divHeader">
                <img src="../Content/images/icon/edit_dblink.png" class="imgText" />&nbsp;<%=Resources.lang.ReportDatabaseLinks %><
            </div>
            <table class="EditeContentTable" width="100%">
                <tr>
                    <td class="Label1">服务器<em>*</em>
                    </td>
                    <td class="Field1">
                        <asp:TextBox runat="server" ID="txtRptDBServer" Text="" CssClass="TextBox" Width="250px"></asp:TextBox><span
                            class="Tips"><%=Resources.lang.IfThereIsAPort %></span>
                    </td>
                </tr>
                <tr>
                    <td class="Label1">用户名<em>*</em>
                    </td>
                    <td class="Field1">
                        <asp:TextBox runat="server" ID="txtRptDBUserName" Text="" CssClass="TextBox MESDB"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="Label1">密码<em>*</em>
                    </td>
                    <td class="Field1">
                        <asp:TextBox runat="server" ID="txtRptDBPwd" Text="" TextMode="Password" CssClass="TextBox MESDB"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="Label1">数据库名<em>*</em>
                    </td>
                    <td class="Field1">
                        <asp:TextBox runat="server" ID="txtRptDBName" Text="" CssClass="TextBox MESDB"></asp:TextBox><input type="button" id="btnReportTestConn" value="测试连接" onclick="CheckReportConn()" style="cursor: pointer;" />
                    </td>
                </tr>
                <tr>
                    <td class="Label1">最大链接池<em>*</em>
                    </td>
                    <td class="Field1">
                        <asp:TextBox runat="server" ID="txtRptDBPool" Text="500" CssClass="NumericBox50"></asp:TextBox>
                    </td>
                </tr>
            </table>
            <!-- add by wenshun, 导数据需要中间库的信息-->
            <div class="clear5">
            </div>
            <div class="divHeader">
                <img src="../Content/images/icon/edit_dblink.png" class="imgText" />&nbsp;<%=Resources.lang.ERPIntermediateLibraryLink %>
            </div>
            <table class="EditeContentTable" width="100%">
                <tr>
                    <td class="Label1">服务器
                    </td>
                    <td class="Field1">
                        <asp:TextBox runat="server" ID="txtMidDBServer" Text="" CssClass="TextBox" Width="250px"></asp:TextBox><span
                            class="Tips"><%=Resources.lang.IfThereIsAPort %></span>
                    </td>
                </tr>
                <tr>
                    <td class="Label1">用户名
                    </td>
                    <td class="Field1">
                        <asp:TextBox runat="server" ID="txtMidDBUid" Text="" CssClass="TextBox"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="Label1">密码
                    </td>
                    <td class="Field1">
                        <asp:TextBox runat="server" ID="txtMidDBPwd" Text="" TextMode="Password" CssClass="TextBox"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="Label1">数据库名
                    </td>
                    <td class="Field1">
                        <asp:TextBox runat="server" ID="txtMidDBName" Text="" CssClass="TextBox"></asp:TextBox><input type="button" id="btnERPTestConn" value="测试连接" onclick="CheckERPConn()" style="cursor: pointer;" />
                    </td>
                </tr>
                <tr>
                    <td class="Label1">最大链接池
                    </td>
                    <td class="Field1">
                        <asp:TextBox runat="server" ID="txtMidDBPool" Text="500" CssClass="NumericBox50"></asp:TextBox>
                    </td>
                </tr>
            </table>
            <!-- add by wenshun, SAP配置-->
            <div class="clear5">
            </div>
            <div class="divHeader">
                <img src="../Content/images/icon/edit_dblink.png" class="imgText" />&nbsp;<%=Resources.lang.SAPConnectionConfiguration %>
            </div>
            <table class="EditeContentTable" width="100%">
                <tr>
                    <td class="Label1">服务器<em>*</em>
                    </td>
                    <td class="Field1">
                        <asp:TextBox runat="server" ID="txtSAPDBServer" Text="" CssClass="TextBox" Width="250px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="Label1">端口号<em>*</em>
                    </td>
                    <td class="Field1">
                        <asp:TextBox runat="server" ID="txtSAPPost" Text="" CssClass="TextBox"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="Label1">用户名<em>*</em>
                    </td>
                    <td class="Field1">
                        <asp:TextBox runat="server" ID="txtSAPUser" Text="" CssClass="TextBox"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="Label1">密码<em>*</em>
                    </td>
                    <td class="Field1">
                        <asp:TextBox runat="server" ID="txtSAPPwd" Text="" TextMode="Password" CssClass="TextBox"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="Label1">系统编号<em>*</em>
                    </td>
                    <td class="Field1">
                        <asp:TextBox runat="server" ID="txtSAPSysNo" Text="" CssClass="TextBox"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="Label1">登入语言<em>*</em>
                    </td>
                    <td class="Field1">
                        <asp:TextBox runat="server" ID="txtSAPLanguage" Text="" CssClass="TextBox"></asp:TextBox><input type="button" id="btnSAPTestConn" value="测试连接" onclick="CheckSAPConn()" style="cursor: pointer;" />
                    </td>
                </tr>
            </table>
        </div>
        <div style="display: none;">
            <div class="infoTips">
                <%= Resources.Messages.WithAsteriskIsRequired %>
            </div>
            <table class="EditeContentTable" width="100%">
                <tr>
                    <td class="Label1">Session超时时间<em>*</em>
                    </td>
                    <td class="Field1">
                        <asp:TextBox runat="server" ID="txtSessionTimeout" CssClass="NumericBox50" Text="30"></asp:TextBox><span
                            class="Tips">只能是正整数，单位：分钟</span>
                    </td>
                </tr>
            </table>
        </div>
        <div>
            <div class="infoTips">
                在此上传的logo将会在系统框架右上角显示，logo尺寸：宽*高 = 200px*45px
            </div>
            <table class="EditeContentTable" width="100%">
                <tr>
                    <td class="Label1">选择Logo文件：</td>
                    <td class="Field1">
                        <input type="file" id="Filedata" name="Filedata" />
                        <asp:Localize ID="llLogo" runat="server"></asp:Localize>
                        <a href="#" id="btnDeleteLogo">删除自定义LOGO</a>
                    </td>
                </tr>
            </table>
            <div style="text-align: center; padding: 10px;">
                <input type="button" value="上传Logo" class="button" id="btnUploadLogo" />

            </div>
            <div id="viewLogo" style="text-align: center; padding: 10px;">
                <img />
            </div>
        </div>
    </div>
    <div style="height: 38px;">
        <div id="loading" style="display: none; z-index: 111;">
            <div style="background: #cccccc; position: absolute; z-index: 112; top: 0; left: 0px; filter: Alpha(opacity=60); -moz-opacity: 0.6; opacity: 0.6;"
                id="loading-bg">
            </div>
            <div style="position: absolute; top: 35%; left: 35%; z-index: 113; background: #f7f7f7; width: 360px; border: 1px solid #333333; height: 65px; line-height: 65px; text-align: center;"
                id="loading-content">
                正在执行方法,请耐心等待...
            </div>
        </div>
    </div>
    <link href="../Content/plugin/tabs/tabs.css" rel="stylesheet" type="text/css" />
    <script src="../Content/plugin/tabs/jPlugin-tabs.js" type="text/javascript"></script>
    <script language="javascript" type="text/javascript">
        var isChanged = false;
        $(document).ready(function () {
            showCloseReason(false);
            $("#<%=this.txtSessionTimeout.ClientID %>").keyup(function () {
                $(this).val($(this).val().replace(/[^\d]/g, ''));
            });
            $("#<%=this.txtMESDBPwd.ClientID %>").click(function () {
                $(this).val("").attr("Encrypt", "1");
            });
            $("#<%=this.txtRptDBPwd.ClientID %>").click(function () {
                $(this).val("").attr("Encrypt", "1");
            });
            $("#<%=this.txtMidDBPwd.ClientID %>").click(function () {
                $(this).val("").attr("Encrypt", "1");
            });
            $("#<%=this.txtSAPPwd.ClientID %>").click(function () {
                $(this).val("").attr("Encrypt", "1");
            });
        });

        function showCloseReason(t) {
            if (t) {
                $("#txtCloseReason").show();
                $("#<%=this.hdnSystemSwitch.ClientID %>").val("0");
            }
            else {
                $("#txtCloseReason").hide();
                $("#<%=this.hdnSystemSwitch.ClientID %>").val("1");
            }

            $(".MESDB").change(function () {
                isChanged = true;
            });
        }

        function switchBtn(obj) {
            if ($(obj).children("div").css("right") == "auto") {
                $(obj).children("div").css("right", "0px");
                $(obj).children("div").css("left", "auto");
                $(obj).children("div").html("关闭");
                $(obj).children("div").css("background", "yellow");
                $(obj).children("div").css("color", "#000000");
                showCloseReason(true);
            }
            else {
                $(obj).children("div").css("left", "0px");
                $(obj).children("div").css("right", "auto");
                $(obj).children("div").html("正常");
                $(obj).children("div").css("background", "green");
                $(obj).children("div").css("color", "#ffffff");
                showCloseReason(false);
            }
        }

        function Save() {


            $("#onprocess").addClass("Tips");
            $("#onprocess").html("数据正在保存，请稍后...");
            setTimeout(function () {
                var connEncrypt = $("#<%=this.ddlIsEncrypt.ClientID %>").val();
                var txtMESDBServer = $("#<%=this.txtMESDBServer.ClientID %>").val();
                var txtMESDBUserName = $("#<%=this.txtMESDBUserName.ClientID %>").val();
                var txtMESDBPwd = $("#<%=this.txtMESDBPwd.ClientID %>").val();
                if ($("#<%=this.txtMESDBPwd.ClientID %>").attr("Encrypt") == "1") {
                    txtMESDBPwd = JsDesEncrypt(txtMESDBPwd);
                }
                var txtMESDBName = $("#<%=this.txtMESDBName.ClientID %>").val();
                var txtMESDBPool = $("#<%=this.txtMESDBPool.ClientID %>").val();

                var txtRptDBServer = $("#<%=this.txtRptDBServer.ClientID %>").val();
                var txtRptDBUserName = $("#<%=this.txtRptDBUserName.ClientID %>").val();
                var txtRptDBPwd = $("#<%=this.txtRptDBPwd.ClientID %>").val();
                if ($("#<%=this.txtRptDBPwd.ClientID %>").attr("Encrypt") == "1") {
                    txtRptDBPwd = JsDesEncrypt(txtRptDBPwd);
                }
                var txtRptDBName = $("#<%=this.txtRptDBName.ClientID %>").val();
                var txtRptDBPool = $("#<%=this.txtRptDBPool.ClientID %>").val();


                var txtMidDBServer = $("#<%=this.txtMidDBServer.ClientID %>").val();
                var txtMidDBUid = $("#<%=this.txtMidDBUid.ClientID %>").val();
                var txtMidDBPwd = $("#<%=this.txtMidDBPwd.ClientID %>").val();
                if ($("#<%=this.txtMidDBPwd.ClientID %>").attr("Encrypt") == "1") {
                    txtMidDBPwd = JsDesEncrypt(txtMidDBPwd);
                }
                var txtMidDBName = $("#<%=this.txtMidDBName.ClientID %>").val();
                var txtMidDBPool = $("#<%=this.txtMidDBPool.ClientID %>").val();

                var txtSAPDBServer = $("#<%=this.txtSAPDBServer.ClientID %>").val();
                var txtSAPPost = $("#<%=this.txtSAPPost.ClientID %>").val();
                var txtSAPUser = $("#<%=this.txtSAPUser.ClientID %>").val();
                var txtSAPPwd = $("#<%=this.txtSAPPwd.ClientID %>").val();
                if ($("#<%=this.txtSAPPwd.ClientID %>").attr("Encrypt") == "1") {
                    txtSAPPwd = JsDesEncrypt(txtSAPPwd);
                }
                var txtSAPSysNo = $("#<%=this.txtSAPSysNo.ClientID %>").val();
                var txtSAPLanguage = $("#<%=this.txtSAPLanguage.ClientID %>").val();
                var txtMESInterval = $("#<%=this.txtMESInterval.ClientID %>").val();

                if (isNull(txtMESDBServer)) {
                    alert("MES数据库服务器不能为空！");
                    styleErrorControl($("#<%=this.txtMESDBServer.ClientID %>"));
                    return false;
                }

                if (isNull(txtMESDBUserName)) {
                    alert("MES数据库用户名不能为空！");
                    styleErrorControl($("#<%=this.txtMESDBUserName.ClientID %>"));
                    return false;
                }

                if (isNull(txtMESDBPwd)) {
                    alert("MES数据库密码不能为空！");
                    styleErrorControl($("#<%=this.txtMESDBPwd.ClientID %>"));
                    return false;
                }

                if (isNull(txtMESDBName)) {
                    alert("MES数据库名字不能为空！");
                    styleErrorControl($("#<%=this.txtMESDBName.ClientID %>"));
                    return false;
                }

                if (isNull(txtMESDBPool)) {
                    alert("MES数据库最大链接池不能为空并且为数值！");
                    styleErrorControl($("#<%=this.txtMESDBPool.ClientID %>"));
                    return false;
                }
                if (isNull(txtMESInterval)) {
                    alert("MES超时间隔不能为空！");
                    styleErrorControl($("#<%=this.txtMESInterval.ClientID %>"));
                    return false;
                }

                if (isNull(txtRptDBServer)) {
                    alert("报表数据库服务器不能为空！");
                    styleErrorControl($("#<%=this.txtRptDBServer.ClientID %>"));
                    return false;
                }

                if (isNull(txtRptDBUserName)) {
                    alert("报表数据库用户名不能为空！");
                    styleErrorControl($("#<%=this.txtRptDBUserName.ClientID %>"));
                    return false;
                }

                if (isNull(txtRptDBPwd)) {
                    alert("报表数据库密码不能为空！");
                    styleErrorControl($("#<%=this.txtRptDBPwd.ClientID %>"));
                    return false;
                }

                if (isNull(txtRptDBName)) {
                    alert("报表数据库名字不能为空！");
                    styleErrorControl($("#<%=this.txtRptDBName.ClientID %>"));
                    return false;
                }


                if (isNull(txtRptDBPool)) {
                    alert("报表数据库最大链接池不能为空并且为数值！");
                    styleErrorControl($("#<%=this.txtRptDBPool.ClientID %>"));
                    return false;
                }

               <%-- if (isNull(txtMidDBServer)) {
                    alert("中间库服务器不能为空！");
                    styleErrorControl($("#<%=this.txtMidDBServer.ClientID %>"));
                    return false;
                }

                if (isNull(txtMidDBUid)) {
                    alert("中间库用户名不能为空！");
                    styleErrorControl($("#<%=this.txtMidDBUid.ClientID %>"));
                    return false;
                }

                if (isNull(txtMidDBPwd)) {
                    alert("中间库密码不能为空！");
                    styleErrorControl($("#<%=this.txtMidDBPwd.ClientID %>"));
                    return false;
                }

                if (isNull(txtMidDBName)) {
                    alert("中间库名字不能为空！");
                    styleErrorControl($("#<%=this.txtMidDBName.ClientID %>"));
                    return false;
                }
                         
                if (isNull(txtMidDBPool)) {
                    alert("中间库最大链接池不能为空并且为数值！");
                    styleErrorControl($("#<%=this.txtMidDBPool.ClientID %>"));
                    return false;
                }--%>
                if (isNull(txtSAPDBServer)) {
                    alert("SAP服务器不能为空！");
                    styleErrorControl($("#<%=this.txtSAPDBServer.ClientID %>"));
                    return false;
                }

                if (isNull(txtSAPPost)) {
                    alert("SAP端口号不能为空！");
                    styleErrorControl($("#<%=this.txtSAPPost.ClientID %>"));
                    return false;
                }

                if (isNull(txtSAPUser)) {
                    alert("SAP用户名不能为空！");
                    styleErrorControl($("#<%=this.txtSAPUser.ClientID %>"));
                    return false;
                }

                if (isNull(txtSAPPwd)) {
                    alert("SAP用户密码不能为空！");
                    styleErrorControl($("#<%=this.txtSAPPwd.ClientID %>"));
                    return false;
                }

                if (isNull(txtSAPSysNo)) {
                    alert("SAP的系统编号不能为空！");
                    styleErrorControl($("#<%=this.txtSAPSysNo.ClientID %>"));
                    return false;
                }

                if (isNull(txtSAPLanguage)) {
                    alert("SAP的登入语言不能为空！");
                    styleErrorControl($("#<%=this.txtSAPLanguage.ClientID %>"));
                    return false;
                }
                var dic1 = {
                    server: txtMESDBServer,
                    uid: txtMESDBUserName,
                    pwd: txtMESDBPwd,
                    database: txtMESDBName,
                    pool: txtMESDBPool,
                    interval: txtMESInterval
                };
                //"server=" + txtMESDBServer + ";uid=" + txtMESDBUserName + ";pwd=" + txtMESDBPwd + ";database=" + txtMESDBName + ";";
                var dic2 = {
                    server: txtRptDBServer,
                    uid: txtRptDBUserName,
                    pwd: txtRptDBPwd,
                    database: txtRptDBName,
                    pool: txtRptDBPool,
                    interval: txtMESInterval
                };
                //"server=" + txtRptDBServer + ";uid=" + txtRptDBUserName + ";pwd=" + txtRptDBPwd + ";database=" + txtRptDBName + ";";
                var dic3 = {
                    server: txtMidDBServer,
                    uid: txtMidDBUid,
                    pwd: txtMidDBPwd,
                    database: txtMidDBName,
                    pool: txtMidDBPool,
                    interval: txtMESInterval
                };
                // "server=" + txtMidDBServer + ";uid=" + txtMidDBUid + ";pwd=" + txtMidDBPwd + ";database=" + txtMidDBName + ";";
                var dic4 = {
                    server: txtSAPDBServer,
                    uid: txtSAPUser,
                    pwd: txtSAPPwd,
                    post: txtSAPPost,
                    systemno: txtSAPSysNo,
                    lang: txtSAPLanguage,
                    interval: txtMESInterval
                };
                //"server=" + txtSAPDBServer + ";post=" + txtSAPPost + ";uid=" + txtSAPUser + ";pwd=" + txtSAPPwd + ";systemno=" + txtSAPSysNo + ";lang=" + txtSAPLanguage + ";interval=" + txtMESInterval + ";";
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSysConfiguration.UpdateWebConfigDBLink(connEncrypt, dic1, dic2, dic3, dic4);
                if (handleAjaxError(ajax.error)) {
                    if (isChanged) {
                        alert("数据保存成功，数据库信息有变更需要重新登录!");
                        top.location.href = "../Logout.aspx";
                    }
                    else {
                        alert("数据保存成功!");
                        $("#onprocess").removeClass("Tips");
                        $("#onprocess").html("");
                    }
                }
            }, 100);
        }

        function CheckMesConn() {
            $("#loading").css({ display: "block", height: $(window).height(), width: $(window).width() });
            $("#loading-bg").width($(window).width());
            $("#loading-bg").height($(window).height());

            setTimeout(function () {
                var connEncrypt = $("#<%=this.ddlIsEncrypt.ClientID %>").val();
                var txtMESDBServer = $("#<%=this.txtMESDBServer.ClientID %>").val();
                var txtMESDBUserName = $("#<%=this.txtMESDBUserName.ClientID %>").val();
                var txtMESDBPwd = $("#<%=this.txtMESDBPwd.ClientID %>").val();
                if ($("#<%=this.txtMESDBPwd.ClientID %>").attr("Encrypt") == "1") {
                    txtMESDBPwd = JsDesEncrypt(txtMESDBPwd);
                }
                var txtMESDBName = $("#<%=this.txtMESDBName.ClientID %>").val();
                var txtMESDBPool = $("#<%=this.txtMESDBPool.ClientID %>").val();
                var txtMESInterval = $("#<%=this.txtMESInterval.ClientID %>").val();


                if (isNull(txtMESDBServer)) {
                    alert("MES数据库服务器不能为空！");
                    styleErrorControl($("#<%=this.txtMESDBServer.ClientID %>"));
                    return false;
                }

                if (isNull(txtMESDBUserName)) {
                    alert("MES数据库用户名不能为空！");
                    styleErrorControl($("#<%=this.txtMESDBUserName.ClientID %>"));
                    return false;
                }

                if (isNull(txtMESDBPwd)) {
                    alert("MES数据库密码不能为空！");
                    styleErrorControl($("#<%=this.txtMESDBPwd.ClientID %>"));
                    return false;
                }

                if (isNull(txtMESDBName)) {
                    alert("MES数据库名字不能为空！");
                    styleErrorControl($("#<%=this.txtMESDBName.ClientID %>"));
                    return false;
                }
                if (isNull(txtMESDBName)) {
                    alert("MES数据库名字不能为空！");
                    styleErrorControl($("#<%=this.txtMESDBName.ClientID %>"));
                    return false;
                }

                if (isNull(txtMESDBPool)) {
                    alert("MES数据库最大链接池不能为空并且为数值！");
                    styleErrorControl($("#<%=this.txtMESDBPool.ClientID %>"));
                    return false;
                }
                if (isNull(txtMESInterval)) {
                    alert("MES超时间隔不能为空！");
                    styleErrorControl($("#<%=this.txtMESInterval.ClientID %>"));
                    return false;
                }

                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSysConfiguration.CheckMesConn(txtMESDBServer, txtMESDBUserName, txtMESDBPwd, txtMESDBName, txtMESInterval, txtMESDBPool);
                if (ajax.value == "") {
                    alert("MES数据库连接成功.");
                    $("#loading").css("display", "none");
                    $("#onprocess").removeClass("Tips");
                    $("#onprocess").html("");

                } else {
                    alert("MES数据库连接失败：" + ajax.value);
                    $("#loading").css("display", "none");
                    $("#onprocess").removeClass("Tips");
                    $("#onprocess").html("");

                }
            }, 10);
        }

        function CheckReportConn() {
            $("#loading").css({ display: "block", height: $(window).height(), width: $(window).width() });
            $("#loading-bg").width($(window).width());
            $("#loading-bg").height($(window).height());

            setTimeout(function () {
                var txtRptDBServer = $("#<%=this.txtRptDBServer.ClientID %>").val();
                var txtRptDBUserName = $("#<%=this.txtRptDBUserName.ClientID %>").val();
                var txtRptDBPwd = $("#<%=this.txtRptDBPwd.ClientID %>").val();
                if ($("#<%=this.txtRptDBPwd.ClientID %>").attr("Encrypt") == "1") {
                    txtRptDBPwd = JsDesEncrypt(txtRptDBPwd);
                }
                var txtRptDBName = $("#<%=this.txtRptDBName.ClientID %>").val();
                var txtRptDBPool = $("#<%=this.txtRptDBPool.ClientID %>").val();

                if (isNull(txtRptDBServer)) {
                    alert("报表数据库服务器不能为空！");
                    styleErrorControl($("#<%=this.txtRptDBServer.ClientID %>"));
                    return false;
                }

                if (isNull(txtRptDBUserName)) {
                    alert("报表数据库用户名不能为空！");
                    styleErrorControl($("#<%=this.txtRptDBUserName.ClientID %>"));
                    return false;
                }

                if (isNull(txtRptDBPwd)) {
                    alert("报表数据库密码不能为空！");
                    styleErrorControl($("#<%=this.txtRptDBPwd.ClientID %>"));
                    return false;
                }

                if (isNull(txtRptDBName)) {
                    alert("报表数据库名字不能为空！");
                    styleErrorControl($("#<%=this.txtRptDBName.ClientID %>"));
                    return false;
                }

                if (isNull(txtRptDBPool)) {
                    alert("报表数据库最大链接池不能为空并且为数值！");
                    styleErrorControl($("#<%=this.txtRptDBPool.ClientID %>"));
                    return false;
                }

                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSysConfiguration.CheckMesConn(txtRptDBServer, txtRptDBUserName, txtRptDBPwd, txtRptDBName, "600", txtRptDBPool);
                if (ajax.value == "") {
                    alert("报表数据库连接成功.");
                    $("#loading").css("display", "none");
                    $("#onprocess").removeClass("Tips");
                    $("#onprocess").html("");
                    return true;
                } else {
                    alert("报表数据库连接失败：" + ajax.value);
                    $("#loading").css("display", "none");
                    $("#onprocess").removeClass("Tips");
                    $("#onprocess").html("");
                    return false;
                }
            }, 10);
        }

        function CheckERPConn() {

            //setTimeout(function () {
            var txtMidDBServer = $("#<%=this.txtMidDBServer.ClientID %>").val();
            var txtMidDBUid = $("#<%=this.txtMidDBUid.ClientID %>").val();
            var txtMidDBPwd = $("#<%=this.txtMidDBPwd.ClientID %>").val();
            if ($("#<%=this.txtMidDBPwd.ClientID %>").attr("Encrypt") == "1") {
                txtMidDBPwd = JsDesEncrypt(txtMidDBPwd);
            }
            var txtMidDBName = $("#<%=this.txtMidDBName.ClientID %>").val();
            var txtMidDBPool = $("#<%=this.txtMidDBPool.ClientID %>").val();

            if (isNull(txtMidDBServer)) {
                alert("中间库服务器不能为空！");
                styleErrorControl($("#<%=this.txtMidDBServer.ClientID %>"));
                return false;
            }

            if (isNull(txtMidDBUid)) {
                alert("中间库用户名不能为空！");
                styleErrorControl($("#<%=this.txtMidDBUid.ClientID %>"));
                    return false;
                }

                if (isNull(txtMidDBPwd)) {
                    alert("中间库密码不能为空！");
                    styleErrorControl($("#<%=this.txtMidDBPwd.ClientID %>"));
                    return false;
                }

                if (isNull(txtMidDBName)) {
                    alert("中间库名字不能为空！");
                    styleErrorControl($("#<%=this.txtMidDBName.ClientID %>"));
                    return false;
                }


                if (isNull(txtMidDBPool)) {
                    alert("中间数据库最大链接池不能为空并且为数值！");
                    styleErrorControl($("#<%=this.txtMidDBPool.ClientID %>"));
                    return false;
                }

                $("#loading").css({ display: "block", height: $(window).height(), width: $(window).width() });
                $("#loading-bg").width($(window).width());
                $("#loading-bg").height($(window).height());

                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSysConfiguration.CheckMesConn(txtMidDBServer, txtMidDBUid, txtMidDBPwd, txtMidDBName, "600", txtMidDBPool);
                if (ajax.value == "") {
                    alert("ERP中间库连接成功.");
                    $("#loading").css("display", "none");
                    $("#onprocess").removeClass("Tips");
                    $("#onprocess").html("");
                    return true;
                } else {
                    alert("ERP中间库连接失败：" + ajax.value);
                    $("#loading").css("display", "none");
                    $("#onprocess").removeClass("Tips");
                    $("#onprocess").html("");
                    return false;
                }
            //}, 10);
            }

            function CheckSAPConn() {
                $("#loading").css({ display: "block", height: $(window).height(), width: $(window).width() });
                $("#loading-bg").width($(window).width());
                $("#loading-bg").height($(window).height());

                setTimeout(function () {
                    var txtSAPDBServer = $("#<%=this.txtSAPDBServer.ClientID %>").val();
                    var txtSAPPost = $("#<%=this.txtSAPPost.ClientID %>").val();
                    var txtSAPUser = $("#<%=this.txtSAPUser.ClientID %>").val();
                    var txtSAPPwd = $("#<%=this.txtSAPPwd.ClientID %>").val();
                    if ($("#<%=this.txtSAPPwd.ClientID %>").attr("Encrypt") == "1") {
                        txtSAPPwd = JsDesEncrypt(txtSAPPwd);
                    }
                    var txtSAPSysNo = $("#<%=this.txtSAPSysNo.ClientID %>").val();
                    var txtSAPLanguage = $("#<%=this.txtSAPLanguage.ClientID %>").val();

                    if (isNull(txtSAPDBServer)) {
                        alert("SAP服务器不能为空！");
                        styleErrorControl($("#<%=this.txtSAPDBServer.ClientID %>"));
                    return false;
                }

                    if (isNull(txtSAPPost)) {
                        alert("SAP端口号不能为空！");
                        styleErrorControl($("#<%=this.txtSAPPost.ClientID %>"));
                    return false;
                }

                    if (isNull(txtSAPUser)) {
                        alert("SAP用户名不能为空！");
                        styleErrorControl($("#<%=this.txtSAPUser.ClientID %>"));
                    return false;
                }

                    if (isNull(txtSAPPwd)) {
                        alert("SAP用户密码不能为空！");
                        styleErrorControl($("#<%=this.txtMidDBPwd.ClientID %>"));
                    return false;
                }

                    if (isNull(txtSAPSysNo)) {
                        alert("SAP的系统编号不能为空！");
                        styleErrorControl($("#<%=this.txtSAPSysNo.ClientID %>"));
                    return false;
                }

                    if (isNull(txtSAPLanguage)) {
                        alert("SAP的登入语言不能为空！");
                        styleErrorControl($("#<%=this.txtSAPLanguage.ClientID %>"));
                    return false;
                }

                    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSysConfiguration.CheckSapConn(txtSAPDBServer, txtSAPPost, txtSAPUser, txtSAPPwd, txtSAPSysNo, txtSAPLanguage);
                    if (ajax.value == "") {
                        alert("SAP数据库连接成功.");
                        $("#loading").css("display", "none");
                        $("#onprocess").removeClass("Tips");
                        $("#onprocess").html("");
                        return true;
                    } else {
                        alert("SAP数据库连接失败：" + ajax.value);
                        $("#loading").css("display", "none");
                        $("#onprocess").removeClass("Tips");
                        $("#onprocess").html("");
                        return false;
                    }
                }, 10);
        }

        $(function () {

            $("#btnUploadLogo").click(function () {
                debugger;
                if ($("#Filedata").val() == "") {
                    alert("请选择上传文件！");
                    return false;
                }
                var form = new FormData($("#form1")[0]);
                try {
                    $.ajax({
                        type: "POST",  //提交方式  
                        url: "../Handler/UploadHander.ashx?Action=UploadCustomerLogo&rnd=" + Math.random(),//路径  
                        data: form,//数据
                        contentType: false, //禁止设置请求类型
                        processData: false, //禁止jquery对DAta数据的处理,默认会处理
                        success: function (data) {//返回数据根据结果进行相应的处理  
                            var path = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/ESOP/DownLoad.aspx?Action=UploadCustomerLogo&fileName=" + data;
                            $("#viewLogo").children("img").attr("src", path);

                            alert("Logo上传成功。");
                            top.location.href = top.location.href;
                        },
                        error: function (xhr, status, error) {
                            alert(error);
                        }
                    });
                    }
                catch (ex) {
                    alert(ex);
                }
            });

            $("#btnDeleteLogo").click(function () {
                if (confirm("是否确定要删除自定义LOGO？删除后将不再显示自定义LOGO！")) {
                    document.forms[0].submit();
                }
                else {
                    return false;
                }
            });
        });
    </script>
</asp:Content>
