<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    CodeBehind="ExtensionFieldsEdit.aspx.cs" Inherits="SKT.LeanMES.Web.ExtensionTables.ExtensionFieldsEdit"
    Title="Edit ExtensionFields" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
<div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %></div>
    <table width="100%" class="EditeContentTable">
        <asp:HiddenField ID="extensionFieldsId" runat="server" Value="0" />
        <tr>
            <td class="Label2">
                <%= Resources.lang.TableName %><em>*</em>
            </td>
            <td class="Field2">
                <asp:HiddenField ID="hidTableName" runat="server" /><asp:TextBox ID="txtTableName" runat="server" CssClass="TextBox" Enabled="false"  IsRequired="1"></asp:TextBox><input type="button" id="btnSelectSupervisor" class="ButtonBox" value="..." onclick="selectSupervisor()" />
            </td>
            <td class="Label2">
                <%= Resources.lang.ExtensionFieldName %><em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtExtensionFieldName" runat="server" CssClass="TextBox" IsRequired="1" MaxLength="50"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.ExtensionFieldDescription %><em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtExtensionFieldDescription" runat="server" CssClass="TextBox" IsRequired="1" MaxLength="50"></asp:TextBox>
            </td>
            <td class="Label2">
                <%= Resources.lang.ExtensionFieldType %><em>*</em>
            </td>
            <td class="Field2">
                <%--<asp:TextBox ID="txtExtensionFieldType" runat="server" CssClass="TextBox" IsRequired="1" MaxLength="50"></asp:TextBox>--%>
                <asp:DropDownList ID="ddlExtensionFieldType" runat="server">
                    <asp:ListItem>string</asp:ListItem>
                    <asp:ListItem>int</asp:ListItem>
                    <asp:ListItem>float</asp:ListItem>
                    <asp:ListItem>decimal</asp:ListItem>
                    <asp:ListItem>bool</asp:ListItem>
                    <asp:ListItem>datetime</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.ExtensionFieldIsAllowNull %>
            </td>
            <td class="Field2">
                <asp:CheckBox ID="chkExtensionFieldIsAllowNull" runat="server" CssClass="CheckBox"></asp:CheckBox>
            </td>
            <td class="Label2">
                <%= Resources.lang.Sequence %><em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtSequence" runat="server" IsRequired="1" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.Remark%>
            </td>
            <td colspan="3" class="Field2">
                <asp:TextBox ID="txtRemark" TextMode="MultiLine" Width="500" runat="server" CssClass="TextArea"></asp:TextBox>
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        //var extensionFieldsId = '<%=Request.QueryString["ID"]%>';
        var extensionFieldsId = $("#<%=this.extensionFieldsId.ClientID %>").val();
        /*保存数据*/
        function Save() {
            var txtTableName = $.trim($("#<%=this.txtTableName.ClientID%>").val());
            var txtExtensionFieldName = $("#<%=this.txtExtensionFieldName.ClientID%>").val();
            var txtExtensionFieldDescription = $.trim($("#<%=this.txtExtensionFieldDescription.ClientID%>").val());
            var ddlExtensionFieldType = $.trim($("#<%=this.ddlExtensionFieldType.ClientID%>").val());
            var chkExtensionFieldIsAllowNull = $("#<%=this.chkExtensionFieldIsAllowNull.ClientID%>").is(":checked");
            var txtSequence = $("#<%=this.txtSequence.ClientID%>").val();
            var txtModifyBy = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';
            var txtCreateBy = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';
            var txtRemark = $.trim($("#<%=this.txtRemark.ClientID%>").val());


            /*表单验证*/
            /*如需表单验证可以此处处理验证 开始*/


            var entity = {};
            entity.ExtensionFieldsId = extensionFieldsId;
            entity.TableName = txtTableName;
            entity.ExtensionFieldName = txtExtensionFieldName;
            entity.ExtensionFieldDescription = txtExtensionFieldDescription;
            entity.ExtensionFieldType = ddlExtensionFieldType;
            entity.ExtensionFieldIsAllowNull = chkExtensionFieldIsAllowNull;
            entity.Sequence = txtSequence;
            entity.ModifyBy = txtModifyBy;
            entity.CreateBy = txtCreateBy;
            entity.Remark = txtRemark;

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxExtensionFields.ExtensionFieldsEdit(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            alert('<%=Resources.Messages.SaveInSuccess%>')
            if ('<%=Request.QueryString["inMenu"] %>' == "true") {
                openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/ExtensionTables/ExtensionFieldsEdit.aspx?name=ExtensionFieldsEdit&ID=" + parseInt(ajax.value);
                location.href = openWinUrl;
            }
            else {
                parent.window.Refresh();
            }
        }


        function selectSupervisor() {
            var condition = " Name='ExtendTable' "
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=3&PageCondition=" + escape(condition) + "&Multiple=false&rnd=" + Math.random(), width: 700, height: 300 });
        }

        function getChooseValue(list) {
            $("#<%=this.txtTableName.ClientID %>").val(list[0][1]);
            $("#<%=this.hidTableName.ClientID %>").val(list[0][1]);
        }
    </script>
</asp:Content>
