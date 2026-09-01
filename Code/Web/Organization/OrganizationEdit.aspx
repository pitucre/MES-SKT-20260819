<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="True"
    CodeBehind="OrganizationEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Organization.OrganizationEdit"
    Title="Edit Organization" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %></div>
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label2">
                上级部门
            </td>
            <td class="Field2" colspan="3">
                <asp:HiddenField ID="hdnParentId" runat="server" Value="-1" />
                <asp:TextBox ID="txtParentDepartName" runat="server" CssClass="TextBox" Enabled="false"></asp:TextBox><input
                    type="button" value="..." class="ButtonBox" title="选择上级部门" onclick="chooseParentDepart()" />
            </td>
        </tr>
        <tr>
            <td class="Label2">
                部门名称<em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtDepartName" runat="server" CssClass="TextBox" IsRequired="1"  MaxLength="20"></asp:TextBox>
            </td>
            <td class="Label2">
                部门编号<em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtDepartNo" runat="server" CssClass="TextBox" MaxLength="50" IsRequired="1"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                部门主管
            </td>
            <td class="Field2" colspan="3">
                <asp:HiddenField ID="hdnSupervisorId" runat="server" Value="-1" />
                <asp:TextBox ID="txtSupervisor" runat="server" CssClass="TextBox" MaxLength="20"
                    Enabled="false"></asp:TextBox><input type="button" value="..." class="ButtonBox"
                        title="选择主管" onclick="chooseSupervisor()" />
            </td>
        </tr>
        <tr>
            <td class="Label2">
                描述
            </td>
            <td class="Field2" colspan="3">
                <asp:TextBox ID="txtDescription" runat="server" CssClass="TextArea" TextMode="MultiLine"
                    MaxLength="50"></asp:TextBox>
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        var organizationId = '<%=Request.QueryString["ID"]%>';
        /*保存数据*/
        function Save() {
            var txtParentId = $("#<%=this.hdnParentId.ClientID%>").val();
            var txtDepartNo = $.trim($("#<%=this.txtDepartNo.ClientID%>").val());
            var txtDepartName = $.trim($("#<%=this.txtDepartName.ClientID%>").val());
            var hdnSupervisorId = $.trim($("#<%=this.hdnSupervisorId.ClientID%>").val());
            var txtDescription = $.trim($("#<%=this.txtDescription.ClientID%>").val());
            var txtCreateBy = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';
            var txtModifyBy = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';
            var txtRemark = "";


            /*表单验证*/
            /*如需表单验证可以此处处理验证 开始*/
            if (isNull(txtDepartName)) {
                alert("部门名称不能为空！");
                $("#<%=this.txtDepartName.ClientID%>").focus();
                return false;
            }

            if (organizationId > -1 && parseInt(organizationId) == parseInt(txtParentId)) {
                alert("部门的父级部门不能是自己！");
                return false;
            }

            var entity = {};

            entity.OrganizationId = organizationId
            entity.ParentId = txtParentId;
            entity.DepartNo = txtDepartNo;
            entity.DepartName = txtDepartName;
            entity.SupervisorId = hdnSupervisorId;
            entity.Description = txtDescription;
            entity.CreateBy = txtCreateBy;
            entity.ModifyBy = txtModifyBy;
            entity.Remark = txtRemark;

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxOrganization.OrganizationEdit(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            alert('<%=Resources.Messages.SaveInSuccess%>')
            if ('<%=Request.QueryString["inMenu"] %>' == "true") {
                openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Organization/OrganizationEdit.aspx?name=Account_OrganizationEdit&ID=" + parseInt(ajax.value) + "&inMenu=true";
                location.href = openWinUrl;
            }
            else {
                parent.window.Refresh(ajax.value);
            }
        }

        function chooseParentDepart() {
            dialog({ title: "选择上级部门", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot  %>/Organization/OrganizationTree.aspx?rnd=" + Math.random(), width: 350, height: 300 });
        }

        function chooseSupervisor() {
            var departId = '<%=Request.QueryString["ID"] %>';
             
            dialog({ title: "选择部门主管", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot  %>/Framework/ChoosePage.aspx?PageId=12&Multiple=false&CallBackFunc=setSupervisor&rnd=" + Math.random(), width: 550, height: 300 });
        }

        function getChooseValue(parentId, parentDepartName, parentDepartNo) {
            $("#<%=this.hdnParentId.ClientID %>").val(parentId);
            if (parentDepartNo == "") {
                $("#<%=this.txtParentDepartName.ClientID %>").val(parentDepartName);
            }
            else {
                if ($.trim(parentDepartNo) != "") {
                    $("#<%=this.txtParentDepartName.ClientID %>").val(parentDepartName + "(" + parentDepartNo + ")");
                }
                else {
                    $("#<%=this.txtParentDepartName.ClientID %>").val(parentDepartName);
                }
            }
            closeDialog();
        }

        function setSupervisor(list) {
            $("#<%=this.hdnSupervisorId.ClientID %>").val(list[0][0]);
            if (list[0][1] == "") {
                $("#<%=this.txtSupervisor.ClientID %>").val(list[0][2]);
            }
            else {
                if ($.trim(list[0][1]) != "") {
                    $("#<%=this.txtSupervisor.ClientID %>").val(list[0][2] + "(" + list[0][1] + ")");
                }
                else {
                    $("#<%=this.txtSupervisor.ClientID %>").val(list[0][2]);
                }
            }
        }
    </script>
</asp:Content>
