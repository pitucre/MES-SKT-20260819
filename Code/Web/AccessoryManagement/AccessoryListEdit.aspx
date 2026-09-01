<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="True"
    CodeBehind="AccessoryListEdit.aspx.cs" Inherits="SKT.LeanMES.Web.AccessoryManagement.AccessoryListEdit" Title="Edit AccessoryList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %>
    </div>
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label1"><%= Resources.lang.AccessoryName %><em>*</em></td>
            <td class="Field1">
                <asp:TextBox ID="txtAccessoryName" runat="server" CssClass="TextBox" MaxLength="200" disabled="disabled" IsRequired='1'></asp:TextBox>
                <input type="button" class="ButtonBox" value="..." onclick="chooseAccessoryName()" />
                <asp:HiddenField ID="hAccessoryId" runat="server" Value="-1" />
            </td>
        </tr>
        <tr>
            <td class="Label1"><%= Resources.lang.AccessoryType %><em>*</em></td>
            <td class="Field1">
                <asp:TextBox ID="txtAccessoryType" runat="server" CssClass="TextBox" MaxLength="50" disabled="disabled" IsRequired='1'></asp:TextBox>
                <input type="button" class="ButtonBox" value="..." onclick="chooseAccessoryTypeName()" />
                <asp:HiddenField ID="hAccessoryTypeId" runat="server" Value="-1" />
            </td>
        </tr>
        <tr>
            <td class="Label1"><%= Resources.lang.WLTpye %></td>
            <td class="Field1">
                <asp:DropDownList runat="server" ID="txtWLTpye">
                    <asp:ListItem Value="1">有铅</asp:ListItem>
                    <asp:ListItem Value="2">无铅</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr style="display:none">
            <td class="Label1"><%= Resources.lang.IsFreeze %></td>
            <td class="Field1">
                <asp:DropDownList runat="server" ID="txtIsFreeze">
                    <asp:ListItem Value="">请选择</asp:ListItem>
                    <asp:ListItem Value="否">否</asp:ListItem>
                    <asp:ListItem Value="是">是</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="Label1"><%= Resources.lang.PartUnit %></td>
            <td class="Field1">
                <asp:Label runat="server" ID="txtUnitName"></asp:Label>
            </td>
        </tr>
    </table>

    <script type="text/javascript">
        var accessoryListId = '<%=Request.QueryString["ID"]%>';
        var flag = 0;
        function chooseAccessoryName() {
            flag = 0;
            chooseFlag = 1;
            pageCondition = "";
            dialog({ title: "", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Framework/ChoosePage.aspx?PageId=" + chooseFlag + "&PageCondition=" + pageCondition + "&Multiple=false&rnd=" + Math.random(), width: 650, height: 350 });
        }
        function chooseAccessoryTypeName() {
            flag = 1;
            chooseFlag = 503;
            pageCondition = "";
            dialog({ title: "", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Framework/ChoosePage.aspx?PageId=" + chooseFlag + "&PageCondition=" + pageCondition + "&Multiple=false&rnd=" + Math.random(), width: 650, height: 350 });
        }
        function getChooseValue(list) {
            if (flag == 0) {
                $("#<%=this.txtAccessoryName.ClientID%>").val(list[0][1]);
                $("#<%=this.txtUnitName.ClientID%>").html(list[0][4]);
                AccessoryCode = list[0][2];
                $("#<%=hAccessoryId.ClientID%>").val(list[0][2]);

            } else if (flag == 1) {
                $("#<%=this.txtAccessoryType.ClientID%>").val(list[0][2]);
                AccessoryType = list[0][0];
                $("#<%=hAccessoryTypeId.ClientID%>").val(list[0][0]);
                }
        }

        /*保存数据*/
        function Save() {
            var txtAccessoryCode = $("#<%=hAccessoryId.ClientID%>").val();
            var txtAccessoryName = $.trim($("#<%=this.txtAccessoryName.ClientID%>").val());
            var txtWLType = $.trim($("#<%=this.txtWLTpye.ClientID%>").val());
            var txtUnitName = $("#<%=this.txtUnitName.ClientID%>").html();
            var txtCreateBy = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';
            var txtIsFreeze = $.trim($("#<%=this.txtIsFreeze.ClientID%>").val());


            /*表单验证*/
            /*如需表单验证可以此处处理验证 开始*/


            var entity = {};

            entity.Id = accessoryListId
            entity.AccessoryCode = txtAccessoryCode;
            entity.AccessoryName = txtAccessoryName;
            entity.AccessoryType = $("#<%=hAccessoryTypeId.ClientID%>").val();
            entity.WLType = txtWLType;
            entity.UnitName = (txtUnitName == "&nbsp;" ? "" : txtUnitName);
            entity.CreateBy = txtCreateBy;
            entity.IsFreeze = txtIsFreeze;

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxAccessoryList.AccessoryListEdit(entity);
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
    </script>

</asp:Content>
