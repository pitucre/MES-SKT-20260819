<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="True"
    CodeBehind="LabelZPLEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Labels.LabelZPLEdit"
    Title="Edit LabelZPL" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %>
    </div>
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label2"> <%= Resources.lang.ZPLType %><em>*</em>
            </td>
            <td class="Field2" colspan="3">
                <asp:DropDownList ID="ddlZPLType" runat="server">
                    <asp:ListItem Text="ZPL指令" Value="0"></asp:ListItem>
                    <asp:ListItem Text="POSTEK指令" Value="1"></asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.ZPLName %><em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtZplName" runat="server" CssClass="TextBox" MaxLength="20" IsRequired="1"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.Description %>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtDescription" runat="server" CssClass="TextArea" TextMode="MultiLine"
                    MaxLength="50"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2" rowspan="4">
                <%= Resources.lang.ZPLValue %>
            </td>
            <td class="Field2" rowspan="4">
                <asp:TextBox ID="txtZPLValue" CssClass="TextArea" runat="server" Style="width: 400px; height: 200px;"
                    TextMode="MultiLine"></asp:TextBox>
                <div class="Tips" style="margin: 3px; line-height: 22px;">
                    <img src="../Content/images/icon/information.png" style="vertical-align: middle;" />
                    在指令模板中请使用如下格式来引用标签字段： %标签字段名%
                </div>
            </td>
        </tr>
    </table>

    <div class="clear5">
    </div>
    <center>
        <input type="button" value="<%= Resources.Buttons.PrintTestLabel %>" onclick="printDemo()" /></center>
    <script src="../Content/js/skt.utility.printer.js?v=10" type="text/javascript"></script>
    <script type="text/javascript">
        var labelZPLId = '<%=Request.QueryString["ID"]%>';
        var printerDemo = null;
        var zplStr = "";

        function printDemo() {
            zplStr = $("#<%=this.txtZPLValue.ClientID %>").val();
            var s = "";

            if (zplStr.indexOf("%") > -1) {
                var arr = reg(zplStr);
                for (var i = 0; i < arr.length; i++) {
                    s += "<tr><td class='Label1'>%" + arr[i] + "%</td><td class='Field1'><input type='text' name='zplParam' class='TextBox'/></td></tr>";
                }
                s = "<div style='overflow-y:auto; height:230px;'><table class='EditeContentTable' width='100%'>" + s + "</table></div>";

                var btn = { text: "Print Test", onclick: "doPrintDemo" };
                dialog({ title: "Print Test", content: s, width: 450, height: 230, buttons: btn });
            }
            else {
                doPrintDemo();
            }
        }
        function doPrintDemo() {
            if (zplStr.indexOf("%") > -1) {
                var zplParams = $("input[name='zplParam']");
                var arr = reg(zplStr);

                for (var i = 0; i < arr.length; i++) {
                    zplStr = zplStr.replace("%" + arr[i] + "%", $(zplParams[i]).val());
                }
            }

            try {
                if($("#<%=this.ddlZPLType.ClientID %>").val()=="0")
                    printLabel("", zplStr, "", "zpl");
                else
                    printLabel("", zplStr, "POSTEK G-3106", "postek");
            }
            catch (e) {
                alert(e);
            }
        }

        /*保存数据*/
        function Save() {
            var errStr = "";
            var txtZplName = $("#<%=this.txtZplName.ClientID%>").val();
            var txtDescription = $("#<%=this.txtDescription.ClientID%>").val();
            var txtValue = $("#<%=this.txtZPLValue.ClientID %>").val();
            var txtModifyBy = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';
            var txtCreateBy = txtModifyBy;
            if (txtZplName.length <= 0) {
                errStr += "<%= Resources.Messages.ZPLNameEmpty %>";
            }
            if (errStr != "") {
                alert(errStr);
                return false;
            }
            var ZplValues = txtValue;

            /*判断zpl模板中%号的个数是否为偶数个*/
            var re = /[%]/g;
            if (re.test(ZplValues)) {
                var n = ZplValues.match(re).length;
                if (n % 2 != 0) {
                    alert("在ZPL模板中是使用“%标签字段%”这样的格式来引用标签字段的，系统检测到当前模板中的%没有成对匹配，请检查！否则将无法在打印时调用此模板。");
                    return false;
                }
            }

            var entity = {};
            entity.ZplType = parseInt($("#<%=this.ddlZPLType.ClientID %>").val());
            entity.LabelZplId = labelZPLId
            entity.ZplName = txtZplName;
            entity.Description = txtDescription;
            entity.ModifyBy = txtModifyBy;
            entity.CreateBy = txtCreateBy;
            entity.Remark = "";

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxLabels.LabelZPLEdit(entity, ZplValues);
            if (ajax.error == null) {
                alert("<%=Resources.Messages.SaveInSuccess %>");
                window.parent.UpdateList(txtZplName);
            } else {
                alert(ajax.error.Message);
                return false;
            }
        }
    </script>
</asp:Content>
