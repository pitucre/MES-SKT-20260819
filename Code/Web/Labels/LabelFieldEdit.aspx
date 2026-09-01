<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    Inherits="SKT.LeanMES.Web.Labels.LabelFieldEdit" CodeBehind="LabelFieldEdit.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div class="wrap_tb" style="min-width: 720px;">
        <ul class="tb">
            <li class="current">标签字段信息</li>
            <li>定义标签字段</li>
        </ul>
        <div class="tb_c">
            <div class="infoTips">
                <%=Resources.Messages.WithAsteriskIsRequired %>
            </div>
            <table class="EditeContentTable" width="100%">
                <tr>
                    <td class="Label1">
                        <%= Resources.lang.LabelFieldName %><em>*</em>
                    </td>
                    <td class="Field1">
                        <asp:TextBox ID="txtLabelFieldName" runat="server" CssClass="TextBox" Width="245px"
                            isrequired="1"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="Label1">
                        字体
                    </td>
                    <td class="Field1">
                        <asp:TextBox ID="txtFont" runat="server" CssClass="TextBox"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="Label1">
                        加粗
                    </td>
                    <td class="Field1">
                        <asp:CheckBox runat="server" ID="chkIsBold" />
                    </td>
                </tr>
                <tr>
                    <td class="Label1">
                        <%=Resources.lang.Description %>
                    </td>
                    <td class="Field1">
                        <asp:TextBox ID="txtDesc" runat="server" CssClass="TextArea" TextMode="MultiLine"
                            Width="350px" Height="60px"></asp:TextBox>
                    </td>
                </tr>
            </table>
        </div>
        <div>
            <div class="ListTableTitle" style="border-bottom: 1px solid #d3d3d3;">
                <img src="../Content/images/icon/menu.png" style="vertical-align: middle; padding-right: 5px;"
                    alt="" /><span>标签字段定义</span><em>*</em>
            </div>
            <div style="height: 280px; border-top: 0px solid #cccccc; border-left: 1px solid #cccccc;
                border-right: 1px solid #cccccc; border-bottom: 1px solid #cccccc; font-size: 11px;
                padding-top: 5px; padding-left: 5px; position: relative;">
                <div style="width: 575px; float: left; position: absolute; height: 275px; left: 3px;
                    top: 3px; overflow: auto;">
                    <table width="100%" cellpadding="1" cellspacing="1" border="0" id="fieldList">
                    </table>
                </div>
                <div style="width: 160px; float: left; background-color: #f7f7f7; height: 275px;
                    border: 1px solid #cccccc; position: absolute; right: 3px; top: 3px; font-size: 12px;">
                    <div style="background-color: #eeeeee; border-top: 0px; border-left: 0px; border-right: 0px;
                        height: 20px; font-weight: bold; padding: 8px 0px 0px 5px; border-bottom: 1px solid #cccccc;">
                        <img src="../Content/images/icon/menu.png" style="vertical-align: middle; padding-right: 5px;"
                            alt="" /><span>功能菜单</span></div>
                    <div style="overflow: auto; height: 240px;">
                        <div class="fieldFun" onclick="addfield(1)">
                            <img src="../Content/images/icon/dbfield.png" style="vertical-align: middle; padding-right: 10px;"
                                alt="" /><span>数据库字段</span></div>
                        <div class="fieldFun" onclick="addfield(2)">
                            <img src="../Content/images/icon/function.png" style="vertical-align: middle; padding-right: 10px;"
                                alt="" /><%=Resources.lang.Function %></div>
                        <div class="fieldFun" onclick="addfield(3)">
                            <img src="../Content/images/icon/literal.png" style="vertical-align: middle; padding-right: 10px;"
                                alt="" /><%=Resources.lang.Constant %></div>
                        <div class="fieldFun" onclick="addfield(4)">
                            <img src="../Content/images/icon/storeissue.png" style="vertical-align: middle; padding-right: 10px;"
                                alt="" /><span>存储过程</span></div>
                    </div>
                </div>
            </div>
            <div id="fielddemo" style="overflow:hidden;">
            </div>
        </div>
    </div>
    <script type="text/javascript">
        initPageData();
        function moveUp(obj) {
            var tr = obj.parentNode.parentNode.parentNode;
            var tbody = tr.parentNode;
            var tb = tbody.parentNode;
            var rowIdx = 0;
            for (var i = 0; i < tb.rows.length; i++) {
                if (tb.rows[i] == tr) {
                    rowIdx = i;
                    break;
                }
            }
            if (rowIdx == 0) return;
            var preTr = tb.rows[rowIdx - 1];
            var nextNextObj = tr.nextSibling;
            tbody.removeChild(preTr);
            if (nextNextObj) {
                tbody.insertBefore(preTr, nextNextObj);
            }
            else {
                tbody.appendChild(preTr);
            }
            setDemo();
        }
        function moveDown(obj) {
            var tr = obj.parentNode.parentNode.parentNode;
            var tbody = tr.parentNode;
            var tb = tbody.parentNode;
            var rowIdx = 0;
            for (var i = 0; i < tb.rows.length; i++) {
                if (tb.rows[i] == tr) {
                    rowIdx = i;
                    break;
                }
            }
            if (rowIdx == tb.rows.length - 1) return;
            var nextTr = tb.rows[rowIdx + 1];
            var nextNextObj = nextTr.nextSibling;
            tbody.removeChild(tr);
            if (nextNextObj) {
                tbody.insertBefore(tr, nextNextObj);
            }
            else {
                tbody.appendChild(tr);
            }
            setDemo();
        }

        function addfield(t) {
            if (t == 1) {
                dialog({ title: "<%=Resources.Pages.Labels_LabelAddDBField %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Labels/LabelAddDBField.aspx?name=Labels_LabelAddDBField&ID=-1", width: 600, height: 300 });
            }
            else if (t == 2) {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxLabels.GetCustomFun();
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }
                var dt = ajax.value;
                var dt_fn = "";
                if (dt != null) {
                    for (var i = 0; i < dt.Rows.length; i++) {
                        dt_fn += "<option value='" + dt.Rows[i]["name"] + "()'>" + dt.Rows[i]["name"] + "()</option>";
                    }
                }
                var fn = "<div class='clear5'></div><table class='EditeContentTable' width='100%'><tr><td class='Label1'><%=Resources.lang.Function %></td><td class='Field1'>"
                fn += "<select id='fnc'>";
                fn += "<optgroup label='系统内置函数'>"
                fn += "<option value='Year()'>四位年(yyyy)</option>";
                fn += "<option value='Year2()'>两位年(yy)</option>";
                fn += "<option value='Month()'>两位月(MM)</option>";
                fn += "<option value='Day()'>两位天(dd)</option>";
                fn += "<option value='Week()'>周(Week)</option>";
                fn += "<option value='Hour()'>小时(Hour)</option>";
                fn += "<option value='Minute()'>分钟(Minute)</option>";
                fn += "<option value='Second()'>秒(Second)</option>";
                fn += "</optgroup>";
                fn += "<optgroup label='自定义函数'>";
                fn += dt_fn;
                fn += "</optgroup>";
                fn += "</select></td></tr></table>";
                var buttons = { text: "<%=Resources.Buttons.COM_Ok %>", onclick: "setFunction" };
                dialog({ title: "<%=Resources.lang.Function %>", content: fn, width: 550, height: 100, buttons: buttons });

            }
            else if (t == 3) {
                var fn = "<div class='clear5'></div><table class='EditeContentTable' width='100%'><tr><td class='Label1'><%=Resources.lang.Constant %></td><td class='Field1'>"
                fn += "<input type='text' id='txtliteral' value='' class='TextBox'/>";
                fn += "</td></tr></table>";
                var buttons = { text: "<%=Resources.Buttons.COM_Ok %>", onclick: "setLiteral" };
                dialog({ title: "<%=Resources.lang.Constant %>", content: fn, width: 350, height: 100, buttons: buttons });
            }
            else if (t == 4) {
                var fn = "<div class='clear5'></div><table class='EditeContentTable' width='100%'><tr><td class='Label1'>存储过程名称</td><td class='Field1'>"
                fn += "<input type='text' id='txtproc' value='' class='TextBox'/>";
                fn += "</td></tr></table>";
                var buttons = { text: "<%=Resources.Buttons.COM_Ok %>", onclick: "setProc" };
                dialog({ title: "添加存储过程", content: fn, width: 350, height: 100, buttons: buttons });
            }
        }

        function mouseOver(obj) {
            $(obj).children().children().eq(1).show();
        }

        function mouseOut(obj) {
            $(obj).children().children().eq(1).hide();
        }

        function deleteField(obj) {
            var row = obj.parentNode.parentNode.parentNode;
            $(row).remove();
            setDemo();
        }

        function addFieldValue(s, t) {
            var h = fieldDefString(s, t);

            $("#fieldList").append(h);
            setDemo();
            closeDialog();
        }

        function setFunction() {
            var p = $("#fnc").find("option:selected").val();
            addFieldValue("fn." + p, 2);
        }

        function setLiteral() {
            var p = $("#txtliteral").val();
            addFieldValue("\"" + p + "\"", 3);
        }

        function setProc() {
            var p = $("#txtproc").val();
            addFieldValue(p, 4);
        }

        function setDemo() {
            var s = "";
            $("#fieldList tr").each(function () {
                s += $(this).children().children().eq(0).html();
            });
            $("#fielddemo").html(s);
        }
        
        function Save() {
            var id = '<%=Request.QueryString["ID"] %>';
            var txtLabelFieldName = $.trim($("#<%=this.txtLabelFieldName.ClientID %>").val());
            var txtDesc = $("#<%=this.txtDesc.ClientID %>").val();
            var txtFont = $("#<%=this.txtFont.ClientID %>").val();
            var isbold = $("#<%=this.chkIsBold.ClientID %>").prop("checked");
            var rowcount = $("#fieldList tr").length;
            var errStr = "";
            if (txtLabelFieldName == "") {
                errStr += "<%=Resources.Messages.LabelFieldIsBlank %>\n";
            }
            if (rowcount <= 0 && id <= 0) {
                errStr += "<%=Resources.Messages.LabelFieldDefNeeded %>\n";
            }
            if (errStr != "") {
                alert(errStr);
                return false;
            }

            var s = "";
            var s1 = "";
            $("#fieldList tr").each(function (i, e) {
                s += $(this).children().children().eq(0).html() + "," + $(this).children().children().eq(2).children().val() + "," + i.toString() + "!!";
                s1 += $(this).children().children().eq(0).html();
            });

            var entity = {};
            var action = '<%=Request.QueryString["Action"] %>';
            if (action == "Copy") {
                entity.FieldDfID = -2;
            }
            else {
                entity.FieldDfID = id;
            }
            entity.FieldDfName = txtLabelFieldName;
            entity.FieldDfDesc = txtDesc;
            entity.Definition = s1;
            entity.Font = txtFont;
            entity.IsBold = isbold;
            var username = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>';
            entity.CreateBy = username;
            entity.ModifyBy = username;

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxLabels.EditLabelDef(entity, s);
            if (ajax.error == null) {
                alert("<%=Resources.Messages.SaveInSuccess %>");
                window.parent.UpdateList(txtLabelFieldName);
            } else {
                alert(ajax.error.Message);
                return false;
            }
        }

        function initPageData() {
            var id = '<%=Request.QueryString["ID"] %>';
            var action = '<%=Request.QueryString["Action"] %>';
            if (id == -1) return false;
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxLabels.GetInfo(id);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var entity = ajax.value;
            if (entity != null ) {
                if (action == "Copy") {
                    $("#<%=this.txtLabelFieldName.ClientID %>").val('<%=Resources.Buttons.COM_Copy %> - ' + entity.Rows[0]["FieldDfName"]);
                }
                else {
                    $("#<%=this.txtLabelFieldName.ClientID %>").val(entity.Rows[0]["FieldDfName"]);
                }
                $("#<%=this.txtDesc.ClientID %>").val(entity.Rows[0]["FieldDfDesc"]);
                $("#<%=this.txtFont.ClientID %>").val(entity.Rows[0]["Font"]);
                $("#<%=this.chkIsBold.ClientID %>").prop("checked", entity.Rows[0]["IsBold"]);
                var s = "";
                for (var i = 0; i < entity.Rows.length; i++) {
                    s += fieldDefString(entity.Rows[i]["DfContent"], entity.Rows[i]["DfType"]);
                }
                $("#fieldList").html(s);
                setDemo();
            }
        }

        function fieldDefString(s, t) {
            var h = "";
            h += '<tr class="OddTableRow" onmouseover="mouseOver(this);" onmouseout="mouseOut(this);"><td>';
            h += '<span>' + s + '</span>';
            h += '<span class="abc">';
            h += '<span onclick="moveUp(this)"><img src="../Content/images/icon/arrow_up.png" title="<%=Resources.Common.MoveUp %>"/></span>';
            h += '<span onclick="moveDown(this)"><img src="../Content/images/icon/arrow_down.png" title="<%=Resources.Common.MoveDown %>"/></span>';
            h += '<span onclick="deleteField(this)" style="margin-left:2px;"><img src="../Content/images/icon/delete.png" title="<%=Resources.Common.Delete %>"/></span>';
            h += '</span>';
            h += '<span><input type="hidden" name="fieldType" value="' + t + '"></span>';
            h += '</td></tr>';
            return h;
        }
    </script>
</asp:Content>
