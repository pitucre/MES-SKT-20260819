<%@ Page Title="" Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/EditMaster.master"
    CodeBehind="StaffAssessEdit.aspx.cs" Inherits="SKT.LeanMES.Web.TestManagement.StaffAssessEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <table>
        <tr><td class="Label2">员工名称</td>
            <td class="Field2">
                <asp:TextBox ID="txtName" runat="server" CssClass="TextBox" MaxLength="200"></asp:TextBox><em>*</em>
            </td>
            <td class="Label2">员工编号</td>
            <td class="Field2">
                <asp:TextBox ID="txtEmployeeNo" runat="server" CssClass="TextBox" MaxLength-="200"></asp:TextBox><em>*</em>
            </td>
        </tr>        
        <tr>           
            <td class="Label2">部门</td>
            <td class="Field2">
                <asp:TextBox ID="txtDepartName" runat="server" CssClass="TextBox" MaxLength="200"></asp:TextBox><input 
                    type="button" value="..." class="ButtonBox" title="选择部门"/><em>*</em>
            </td>
        </tr>
        <tr>
            <td class="Label2">考核季度</td>
            <td class="Field2">
                <asp:DropDownList ID="dllQtyAet" runat="server" ClientIDMode="Static">
                    <asp:ListItem Value="" Selected="True">=请选择=</asp:ListItem>
                    <asp:ListItem  Value="0">第一季度</asp:ListItem>
                    <asp:ListItem  Value="1">第二季度</asp:ListItem>
                    <asp:ListItem  Value="2">第三季度</asp:ListItem>
                    <asp:ListItem  Value="3">第四季度</asp:ListItem>
                </asp:DropDownList><em>*</em>
            </td>
            <td class="Label2">考核等级</td>
            <td class="Field2">
                <asp:DropDownList ID="dllAetGrade" ClientIDMode="Static" runat="server">
                    <asp:ListItem Value="" Selected="True">=请选择=</asp:ListItem>
                    <asp:ListItem Value="A">A</asp:ListItem>
                    <asp:ListItem Value="B">B</asp:ListItem>
                    <asp:ListItem Value="C">C</asp:ListItem>
                </asp:DropDownList><em>*</em>
            </td>
        </tr>
        <tr>
            <td class="Label2">性别</td>
            <td class="Field2">
                <asp:DropDownList ID="ddlSex" runat="server">
                    <asp:ListItem Text="男" Value="1"></asp:ListItem>
                    <asp:ListItem Text="女" Value="0"></asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>                                                    
            <td class="Label2">电话</td>
            <td class="Field2">
                <asp:TextBox ID="txtPhone" runat="server" CssClass="TextBox" MaxLength="200"></asp:TextBox>
            </td>
            <td class="Label2">邮箱</td>
            <td class="Field2">
                <asp:TextBox ID="txtEmail" runat="server" CssClass="TextBox" MaxLength="200"></asp:TextBox>
            </td>
        </tr>    
        <tr>
            <td class="Label2">备注</td>
            <td class="Field2">
                <asp:TextBox ID="txtRemark" runat="server" CssClass="TextBox" ></asp:TextBox>
            </td>
        </tr>     
    </table>
    <asp:HiddenField ID="filepaths" runat="server" Value="-1" ClientIDMode="Static" />
    <script type="text/javascript">
        var userId = '<%=Request.QueryString["ID"]%>';

        function Save() {
            var txtName = $("#<%=this.txtName.ClientID%>").val();
            var txtEmployeeNo = $("#<%=this.txtEmployeeNo.ClientID%>").val();
            var txtDepartName = $("#<%=this.txtDepartName.ClientID%>").val();
            var dllQtyAet = $("#<%=this.dllQtyAet.ClientID%>").val();
            var dllAetGrade = $("#<%=this.dllAetGrade.ClientID %>").val();
            var ddlSex = $("#<%=this.ddlSex.ClientID%>").val();
            var txtPhone = $("#<%=this.txtPhone.ClientID%>").val();
            var txtEmail = $("#<%=this.txtEmail.ClientID%>").val();
            var CreateBy = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>';
            var ModifyBy = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>';
            var txtRemark = $("#<%=this.txtRemark.ClientID%>").val();

            if(txtName=="" || txtEmployeeNo=="" || txtDepartName=="" || dllAetGrade=="" || dllQtyAet=="")
            {
                alert("带*号不能为空");
                return false;
            }

            var entity = {};
            entity.UserId = userId;
            entity.UserName = txtName;
            entity.EmployeeNo = txtEmployeeNo;
            entity.QtyAet = dllQtyAet;
            entity.AetGrade = dllAetGrade;
            entity.Sex = ddlSex;
            entity.Phone = txtPhone;
            entity.Email = txtEmail;
            entity.Remark = txtRemark;

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxStaffAssess.EditStaffAssess(entity);
            if(ajax.error != null){
                alert(ajax.error.Message);
                return false;
            }
            alert('<%=Resources.Messages.SaveInSuccess%>');
            parent.window.UpdateList(txtName);
        }
    </script>
</asp:Content>
