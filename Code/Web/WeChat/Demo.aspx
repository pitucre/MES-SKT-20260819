<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" ValidateRequest="false" CodeBehind="Demo.aspx.cs" Inherits="SKT.LeanMES.Web.WeChat.Demo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <script src="../Content/js/jquery-3.1.0.min.js"></script>
    <link href="../Content/plugin/bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen" />
    <link href="../Content/productioncollection.css" rel="Stylesheet" type="text/css" />
       <script type="text/javascript" src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/layui/layui.all.js"></script>
    <link href="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/layui/css/layui.css" rel="stylesheet" />
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/ws.js" type="text/javascript"></script>
    <script src="../Content/js/skt.client.productioncollection.js" type="text/javascript"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
    <link type="text/css" href="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/uploadify/uploadify.css"
        rel="Stylesheet" />
    <script type="text/javascript" src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/uploadify/jquery.uploadify.min.js"></script>
    <script src="../Content/plugin/bootstrap/js/bootstrap-treeview.min.js"></script>
    <link href="../Content/plugin/bootstrap/js/bootstrap-treeview.min.css" rel="stylesheet" />
    <style type="text/css">
        input[type="text"], input[type="text"]:hover {
            height: 34px;
            line-height: 34px;
            padding: 0px 12px;
        }
    </style>
    <div class="client-center" style="margin: 5px 15px 0px 15px;">
        <ul id="tab" class="nav nav-tabs" style="font-weight: bold;">

            <li class="active">
                <a href="#manageDepartment" data-toggle="tab">部门管理
                </a>
            </li>
            <li><a href="#manageUser" data-toggle="tab">用户管理</a></li>
            <li><a href="#message" data-toggle="tab" id="hrefOther">消息发送</a></li>
        </ul>
        <div id="tabContent" class="tab-content" style="margin-top: 0px;">
            <asp:ScriptManager ID="ScriptManager"
                runat="server" />
            <%--部门管理--%>
            <div class="tab-pane fade in active" id="manageDepartment">
                <div class="panel panel-default">
                    <div class="panel-body">
                        <div class="form-group">
                            <label for="ddlddlStationPhase" class="col-sm-2 col-lg-2 control-label">操作类型<em>*</em></label>
                            <div class="col-sm-10 col-lg-10">
                                <select runat="server" id="ddlDepartment" clientidmode="Static" class="form-control" isrequired='1'>
                                    <option value="create">创建部门</option>
                                    <option value="update">更新部门</option>
                                    <option value="delete">删除部门</option>
                                </select>
                            </div>
                        </div>
                        <div id="departCreate">
                            <div class="form-group">
                                <label class="col-sm-2 col-lg-2 control-label">部门名称<em>*</em></label>
                                <div class="col-sm-10 col-lg-10">
                                    <input type="text" class="form-control" id="txtDepartmentName" runat="server" placeholder="请输入部门名称" isrequired='1' />
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 col-lg-2 control-label">上级部门<em>*</em></label>
                                <div class="col-sm-10 col-lg-10">
                                    <div id="createTreeview" class=""></div>
                                    <input type="hidden" id="hdnDepartmentId" runat="server" value="0" clientidmode="Static" />
                                </div>
                            </div>
                        </div>
                        <div id="departUpdate" style="display: none;">
                            <div class="form-group">
                                <label class="col-sm-2 col-lg-2 control-label">需修改部门<em>*</em></label>
                                <div class="col-sm-10 col-lg-10">
                                    <div id="editTreeview" class=""></div>
                                    <input type="hidden" id="hdnEditDepartmentId" runat="server" value="0" clientidmode="Static" />
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 col-lg-2 control-label">新部门名称<em>*</em></label>
                                <div class="col-sm-10 col-lg-10">
                                    <input type="text" class="form-control" id="txtNewDepartmentName" clientidmode="Static" runat="server" placeholder="请输入部门名称" isrequired='1' />
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="ddlddlStationPhase" class="col-sm-2 col-lg-2 control-label">新上级部门<em>*</em></label>
                                <div class="col-sm-10 col-lg-10">
                                    <div id="parentTreeview" class=""></div>
                                    <input type="hidden" id="hdnParentDepartmentId" runat="server" value="0" clientidmode="Static" />
                                </div>
                            </div>
                        </div>
                        <div id="departDelete" style="display: none;">
                            <div class="form-group">
                                <label class="col-sm-2 col-lg-2 control-label">需删除部门<em>*</em></label>
                                <div class="col-sm-10 col-lg-10">
                                    <div id="deleteTreeview" class=""></div>
                                    <input type="hidden" id="hdnDeleteDepartmentId" runat="server" value="0" clientidmode="Static" />
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="" class="col-sm-2 col-lg-2 control-label"></label>
                            <div class="col-sm-10 col-lg-10" style="text-align: left;">

                                <asp:UpdatePanel ID="UpdatePanel2"
                                    UpdateMode="Conditional"
                                    runat="server">
                                    <ContentTemplate>
                                        <fieldset>
                                            <asp:Button ID="btn" class="btn btn-primary btn-lg" runat="server" Text="保 存" OnClick="DepartmentManage" />&nbsp;&nbsp;
                                        <asp:Label ID="lblDepartmentMsg" Style="font-size: 14px; color: green; margin-left: 10px;" runat="server" Text=""></asp:Label>
                                            <asp:Label ID="lblDepartmentErrorMsg" runat="server" Text="" Style="font-size: 14px; color: red; margin-left: 10px;"></asp:Label>
                                            <input type="hidden" id="hdnDepartmentList" value="" runat="server" clientidmode="Static" />
                                        </fieldset>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <%--用户管理--%>
            <div class="tab-pane fade" id="manageUser">
                <div class="panel panel-default">
                    <div class="panel-body">
                        <div class="form-group">
                            <label for="ddlddlStationPhase" class="col-sm-2 col-lg-2 control-label">操作类型<em>*</em></label>
                            <div class="col-sm-10 col-lg-10">
                                <select runat="server" id="ddlUser" clientidmode="Static" class="form-control" isrequired='1'>
                                    <option value="list">获取部门用户</option>
                                    <option value="create">创建用户</option>
                                    <option value="update">更新用户</option>
                                    <option value="delete">删除用户</option>
                                    
                                </select>
                            </div>
                        </div>
                        <div id="userOther" style="display: none;">
                            <div class="form-group" id="createUserId">
                                <label class="col-sm-2 col-lg-2 control-label">账号<em>*</em></label>
                                <div class="col-sm-10 col-lg-10">
                                    <input type="text" class="form-control" id="txtUserId" runat="server" placeholder="请输入账号" isrequired='1' />
                                </div>
                            </div>
                            <div class="form-group" >
                                <label class="col-sm-2 col-lg-2 control-label">姓名<em>*</em></label>
                                <div class="col-sm-10 col-lg-10">
                                    <input type="text" class="form-control" id="txtUserName" runat="server" placeholder="请输入姓名" isrequired='1' />
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 col-lg-2 control-label">所在部门<em>*</em></label>
                                <div class="col-sm-10 col-lg-10">
                                    <div id="departTreeview" class=""></div>
                                    <input type="hidden" id="hdndepartTreeview" runat="server" value="0" clientidmode="Static" />
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 col-lg-2 control-label">英文名</label>
                                <div class="col-sm-10 col-lg-10">
                                    <input type="text" class="form-control" id="txtEnglishName" runat="server" placeholder="请输入英文名" isrequired='1' />
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 col-lg-2 control-label">邮箱</label>
                                <div class="col-sm-10 col-lg-10">
                                    <input type="text" class="form-control" id="txtemail" runat="server" placeholder="请输入邮箱" />
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 col-lg-2 control-label">手机号</label>
                                <div class="col-sm-10 col-lg-10">
                                    <input type="text" class="form-control" id="txtmobile" runat="server" placeholder="请输入手机号" />
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 col-lg-2 control-label">职位</label>
                                <div class="col-sm-10 col-lg-10">
                                    <input type="text" class="form-control" id="txtposition" runat="server" placeholder="请输入职位" />
                                </div>
                            </div>
                        </div>
                        <div id="userList" >
                            <div class="form-group">
                                <label class="col-sm-2 col-lg-2 control-label">所在部门<em>*</em></label>
                                <div class="col-sm-10 col-lg-10">
                                    <div id="listTreeview" class=""></div>
                                    <input type="hidden" id="hdnUserListDepartId" runat="server" value="0" clientidmode="Static" />
                                </div>
                            </div>

                            <table id="listTb" class="table  table-bordered" style="margin-top: 25px;">
                                <caption>部门用户信息</caption>
                                <thead>
                                    <tr>
                                        <th style="width: 70px;">序号</th>
                                        <th style="width: 150px;">账号</th>
                                        <th>姓名</th>
                                        <th>英文名</th>
                                        <th style="width: 100px;">手机号</th>
                                        <th style="width: 100px;">邮箱</th>
                                        <th style="width: 80px;">职位</th>
                                    </tr>
                                </thead>
                                <tbody id="listTbody">
                                </tbody>
                            </table>
                        </div>
                        <div class="form-group">
                            <label for="" class="col-sm-2 col-lg-2 control-label"></label>
                            <div class="col-sm-10 col-lg-10" style="text-align: left;">

                                <asp:UpdatePanel ID="UpdatePanel3"
                                    UpdateMode="Conditional"
                                    runat="server">
                                    <ContentTemplate>
                                        <fieldset>
                                            <asp:Button ID="btnUser" ClientIDMode="Static" class="btn btn-primary btn-lg" runat="server" Text="查 询" OnClick="UserManage" />&nbsp;&nbsp;
                                         <asp:Label ID="lblUserMsg" Style="font-size: 14px; color: green; margin-left: 10px;" runat="server" Text=""></asp:Label>
                                            <asp:Label ID="lblUserErrorMsg" runat="server" Text="" Style="font-size: 14px; color: red; margin-left: 10px;"></asp:Label>
                                            <input type="hidden" id="hdnUserList" runat="server" value="" clientidmode="Static" />
                                        </fieldset>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <%--消息发送--%>
            <div class="tab-pane fade" id="message">
                <div class="panel panel-default">
                    <div class="panel-body">
                        <div class="form-group">
                            <label for="ddlddlStationPhase" class="col-sm-2 col-lg-2 control-label">消息类型<em>*</em></label>
                            <div class="col-sm-10 col-lg-10">
                                <select runat="server" id="ddlMessageType" clientidmode="Static" class="form-control" isrequired='1'>
                                    <option value="text">文字消息</option>
                                    <option value="image">图片消息</option>
                                    <option value="file">文件消息</option>
                                    <option value="textcard">文本卡片消息</option>
                                    <option value="news">图文消息</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 col-lg-2 control-label">接收消息部门<em>*</em></label>
                            <div class="col-sm-10 col-lg-10">
                                <div id="getMsgTreeview" class=""></div>
                                <input type="hidden" id="hdnMsgDepartmentId" runat="server" value="0" clientidmode="Static" />
                            </div>
                        </div>
                        <%--文字消息--%>
                        <div class="form-group" id="msgText">
                            <label for="ddlddlStationPhase" class="col-sm-2 col-lg-2 control-label">文本信息<em>*</em></label>
                            <div class="col-sm-10 col-lg-10">
                                <textarea cols="1" class="form-control" rows="3" runat="server" id="txtTextMsg" isrequired='1' placeholder="请输入文本信息"></textarea>
                            </div>
                        </div>
                        <%--图片/文件消息--%>
                        <div class="form-group" id="msgFile" style="display: none;">
                            <label for="ddlddlStationPhase" class="col-sm-2 col-lg-2 control-label">文件信息<em>*</em></label>
                            <div class="col-sm-10 col-lg-10">
                                <div style="padding-top: 10px;">
                                    <input type="file" name="fileUpload" id="fileUpload" style="width: 73px;" />
                                    <input type="hidden" id="hidFilePath" clientidmode="Static" runat="server" value="" />
                                </div>
                                <div id="fileQueue"></div>
                            </div>
                        </div>
                        <%--文本卡片消息--%>
                        <div id="msgTextCard" style="display: none;">
                            <div class="form-group">
                                <label class="col-sm-2 col-lg-2 control-label">消息标题<em>*</em></label>
                                <div class="col-sm-10 col-lg-10">
                                    <input type="text" class="form-control" id="txtTextCardTitle" runat="server" placeholder="请输入消息标题" value="停线通知" isrequired='1' />
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 col-lg-2 control-label">消息描述<em>*</em></label>
                                <div class="col-sm-10 col-lg-10">
                                    <textarea cols="1" class="form-control" rows="3" runat="server" id="txtTextCardDesc" placeholder="请输入消息描述" isrequired='1'><div class="gray">2018年6月26日</div> <div class="normal">生产一线停线</div><div class="highlight">请***同事前往处理！</div></textarea>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 col-lg-2 control-label">点击消息链接URL<em>*</em></label>
                                <div class="col-sm-10 col-lg-10">
                                    <input type="text" class="form-control" id="txtTextCardURL" runat="server" value="http://www.baidu.com" placeholder="请输入点击消息链接URL" isrequired='1' />
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 col-lg-2 control-label">按钮文字</label>
                                <div class="col-sm-10 col-lg-10">
                                    <input type="text" class="form-control" id="txtTextCardBtn" runat="server" placeholder="请输入按钮文字" isrequired='1' />
                                </div>
                            </div>
                        </div>
                        <%--图文消息--%>
                        <div id="msgNews" style="display: none;">
                            <div class="form-group">
                                <label class="col-sm-2 col-lg-2 control-label">消息标题<em>*</em></label>
                                <div class="col-sm-10 col-lg-10">
                                    <input type="text" class="form-control" id="txtNewsTitle" runat="server" placeholder="请输入消息标题" value="测试通知" isrequired='1' />
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 col-lg-2 control-label">消息描述<em>*</em></label>
                                <div class="col-sm-10 col-lg-10">
                                    <textarea cols="1" class="form-control" rows="3" runat="server" id="txtNewsDesc" placeholder="请输入消息描述" isrequired='1'><div class="gray">2018年6月26日</div> <div class="normal">生产一线停线</div><div class="highlight">请***同事前往处理！</div></textarea>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 col-lg-2 control-label">点击消息链接URL<em>*</em></label>
                                <div class="col-sm-10 col-lg-10">
                                    <input type="text" class="form-control" id="txtNewsURL" runat="server" value="http://www.baidu.com" placeholder="请输入点击消息链接URL" isrequired='1' />
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 col-lg-2 control-label">图片链接URL<em>*</em></label>
                                <div class="col-sm-10 col-lg-10">
                                    <input type="text" class="form-control" id="txtNewsPicURL" runat="server" value="http://res.mail.qq.com/node/ww/wwopenmng/images/independent/doc/test_pic_msg1.png" placeholder="请输入点击消息链接URL" isrequired='1' />
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 col-lg-2 control-label">按钮文字</label>
                                <div class="col-sm-10 col-lg-10">
                                    <input type="text" class="form-control" id="txtNewsBtn" runat="server" placeholder="请输入按钮文字" isrequired='1' />
                                </div>
                            </div>

                        </div>

                        <div class="form-group">
                            <label for="" class="col-sm-2 col-lg-2 control-label"></label>
                            <div class="col-sm-10 col-lg-10" style="text-align: left;">
                                <asp:UpdatePanel ID="UpdatePanel1"
                                    UpdateMode="Conditional"
                                    runat="server">
                                    <ContentTemplate>

                                        <fieldset>
                                            <asp:Button ID="Button15" class="btn btn-primary btn-lg" runat="server" Text="发 送" OnClick="SendMsg" />&nbsp;&nbsp;
                                        <asp:Label ID="lblErorrMsg" Style="font-size: 14px; color: green; margin-left: 10px;" runat="server" Text=""></asp:Label>
                                            <asp:Label ID="lblMsg" runat="server" Text="" Font-Size="Large"></asp:Label>
                                        </fieldset>
                                    </ContentTemplate>
                                </asp:UpdatePanel>


                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        var list = jQuery.parseJSON('<%= deparmentList%>');
        var subList = [];

        var prm = Sys.WebForms.PageRequestManager.getInstance();
        prm.add_endRequest(function () {
            //在这下面写你的js或jquery代码
            $(function () {
                //加载部门信息   
                if ($("#manageUser").css("display") == "block" && $("#ddlUser").val() == "list") {                     
                    if ($("#hdnUserList").val() == "") {
                        return false;
                    }
                    bindUserList();
                }
                else {
                    if ($("#hdnDepartmentList").val() == "") {
                        return false;
                    }
                    list = jQuery.parseJSON($("#hdnDepartmentList").val());
                    subList = [];
                    getDepartments();
                    bindTreeview();
                }
            });
        });

        $().ready(function () {
            //加载部门信息
            getDepartments();
            bindTreeview();
        });

        function bindUserList() {
            var list = JSON.parse($("#hdnUserList").val());
            var tbObj = $("#listTbody");

            var trHtml = "";
            var entity;

            if (list == "" || list.length == 0) {
                trHtml += "<tr><td colspan='6' align='center'> 未找到用户<td></tr>";
                tbObj.html(trHtml);
                return false;
            }

            for (var i = 0; i < list.length; i++) {
                entity = list[i];
                trHtml += "<tr><td align='center' >" + (i + 1) + "</td><td>" + entity.userid + "</td><td>" + entity.name + "</td><td>" + entity.english_name + "</td><td>" + entity.mobile + "</td><td>" + entity.email + "</td><td>" + entity.position + "</td>";
            }
            tbObj.html(trHtml);
        }

        function bindTreeview() {
            $("#createTreeview").on('nodeSelected', function (event, node) {
                $("#hdnDepartmentId").val(node.id);
            });
            $("#editTreeview").on('nodeSelected', function (event, node) {
                $("#hdnEditDepartmentId").val(node.id);
                $("#txtNewDepartmentName").val(node.text);
            });
            $("#parentTreeview").on('nodeSelected', function (event, node) {
                $("#hdnParentDepartmentId").val(node.id);
            });
            $("#deleteTreeview").on('nodeSelected', function (event, node) {
                $("#hdnDeleteDepartmentId").val(node.id);
            });
            $("#getMsgTreeview").on('nodeSelected', function (event, node) {
                $("#hdnMsgDepartmentId").val(node.id);
            });
            $("#departTreeview").on('nodeSelected', function (event, node) {
                $("#hdndepartTreeview").val(node.id);
            });
            $("#listTreeview").on('nodeSelected', function (event, node) {
                $("#hdnUserListDepartId").val(node.id);
            });
        }

        function getDepartments() {
            //如果有部门信息
            var topDepartment;
            for (var i = 0; i < list.length; i++) {
                if (list[i].id == 1) {
                    topDepartment = list[i];
                    break;
                }
            }

            subList.push({ "id": topDepartment.id, "text": topDepartment.name, "nodes": [] });

            getChild(topDepartment.id);

            $('#createTreeview,#editTreeview,#parentTreeview,#deleteTreeview,#getMsgTreeview,#departTreeview,#listTreeview').treeview({
                data: subList,
                levels: 3 //默认展开级别
            });
        }

        //绑定微信部门信息
        function getChild(pid) {
            var templist = [];
            var newObj = {};

            for (var k = 0; k < list.length; k++) {
                newObj = list[k];

                if (newObj.parentid == pid) {
                    var childEntity = { "id": newObj.id, "text": newObj.name };

                    $.each(list, function (i, obj) {
                        if (obj.parentid == newObj.id) {
                            childEntity = { "id": newObj.id, "text": newObj.name, "nodes": [] };
                        }
                    });

                    getParent(subList, pid, childEntity);

                    templist.push(newObj);
                }
            }

            for (var i = 0 ; i < templist.length; i++) {
                getChild(templist[i].id);
            }
        }

        function getParent(sourceObj, pid, entity) {
            $.each(sourceObj, function (i, obj) {
                if (obj.id == pid) {
                    sourceObj[i].nodes.push(entity);
                    return;
                }
                if (typeof (obj.nodes) == "object") {
                    getParent(obj.nodes, pid, entity);
                }
            });
        }

        $("#ddlMessageType").change(function () {
            $("div[id^='msg']").hide();
            switch (this.value) {
                case "text":
                    $("#msgText").show();
                    break;
                case "image":
                    $("#msgFile").show();
                    break;
                case "file":
                    $("#msgFile").show();
                    break;
                case "textcard":
                    $("#msgTextCard").show();
                    break;
                case "news":
                    $("#msgNews").show();
                    break;
                default:
                    break;
            }
        });

        $("#ddlDepartment").change(function () {
            $("div[id^='depart']").hide();
            switch (this.value) {
                case "create":
                    $("#departCreate").show();
                    break;
                case "update":
                    $("#departUpdate").show();
                    break;
                case "delete":
                    $("#departDelete").show();
                    break;
                default:
                    break;
            }
        });

        $("#ddlUser").change(function () {
            $("div[id^='user']").hide();
            switch (this.value) {
                case "delete":
                    $("#userOther").children().hide();
                    $("#createUserId").show();
                    $("#userOther").show();
                    break;
                case "list":                   
                    $("#userList").show();
                    $("#btnUser").val("查 询");
                    break;
                default:
                    $("#userOther").children().show();
                    $("#userOther").show();
                    $("#btnUser").val("保 存");
                    break;
            }
        });

        $('#fileUpload').uploadify({
            //后台处理的页面
            uploader: '<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Handler/UploadHander.ashx?Action=UpalodMedia',
            //指定swf文件
            swf: '<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/uploadify/uploadify.swf',
            //取消按钮图片
            //            cancelImage: '<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/uploadify/uploadify-cancel.png',
            //指定上传队列
            queueID: 'fileQueue',
            //选择文件后自动上传
            auto: true,
            //设置为true将允许多文件上传
            multi: true,
            //上传文件的类型  默认为所有文件'All Files';'*.*'
            //在浏览窗口底部的文件类型下拉菜单中显示的文本
            fileTypeDesc: '支持的格式：IMG|PDF|xls',
            //允许上传的文件后缀
            fileTypeExts: '*.jpg;*.jpge;*.gif;*.png;*.pdf;*.mp4;*.xls;*.xlsx;',
            //文件大小（KB）限制
            fileSizeLimit: '1572864',
            //同时上传文件数量限制
            queueSizeLimit: 1,
            //按钮显示的文字
            buttonText: "上传文件",
            //发送给后台的其他参数通过formData指定
            //formData: { 'FtpType': 1 },
            //请求后台方式
            method: 'POST',
            successTimeout: 720,
            //选择文件时执行             
            onUploadStart: function (file) {

            },
            //上传成功时执行
            onUploadSuccess: function (file, data, response) {
                if (response) {
                    if (data) {
                        if (data == "0") {
                            $("#fileUpload").uploadify("cancel", "*");
                            return;
                        }
                        else if (data.indexOf("Exception") > -1) {
                            alert(data);
                            $("#fileUpload").uploadify("cancel", "*");
                            return;
                        }
                        $("#hidFilePath").val(data);

                    } else {
                        alert("文件上传失败！");
                    }
                }
            }
        });
    </script>
</asp:Content>
