<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" 
    CodeBehind="APIEdit.aspx.cs" Inherits="SKT.LeanMES.Web.SystemConfiguration.APIEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <table width="100%" class="EditeContentTable">
        <tr><td colspan="4" class="Label"><%=Resources.Messages.WithAsteriskIsRequired %></td></tr>
        <tr>
            <td class="Label2">业务名称</td>
            <td class="Field2">
                <asp:TextBox ID="txtBusinessName" runat="server" CssClass="TextBox"  MaxLength="200"></asp:TextBox><em>*</em>
            </td>
            <td class="Label2">SAP内表名</td>
            <td class="Field2">
                <asp:TextBox ID="txtSapTabName" runat="server" CssClass="TextBox" MaxLength="200"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">处理函数</td>
            <td class="Field2">
                <asp:TextBox ID="txtFuncName" runat="server" CssClass="TextBox"  MaxLength="200"></asp:TextBox><em>*</em>
            </td>
            <td class="Label2">目标库表名</td>
            <td class="Field2">
                <asp:TextBox ID="txtTargetTabName" runat="server" CssClass="TextBox"  MaxLength="200"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">传入参数</td>
            <td class="Field2" colspan="3">
                <asp:TextBox ID="txtSapParam" runat="server" CssClass="TextBox" style="width:95%;"  MaxLength="2000"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">参数描述</td>
            <td class="Field2" colspan="3">
                <asp:TextBox ID="txtSapParamDesc" runat="server" CssClass="TextBox" style="width:95%;"  MaxLength="2000"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">SAP读取列</td>
            <td class="Field2" colspan="3">
                <asp:TextBox ID="txtSapFields" runat="server" CssClass="TextBox" style="width:95%;"  MaxLength="2000"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">目标表对应列</td>
            <td class="Field2" colspan="3">
                <asp:TextBox ID="txtTargetTabFields" runat="server" CssClass="TextBox" style="width:95%;"  MaxLength="2000"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">备注</td>
            <td class="Field2" colspan="3">
                <asp:TextBox ID="txtRemark" runat="server" CssClass="TextBox" style="width:95%;"  MaxLength="200"></asp:TextBox>
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        var aPIId = '<%=Request.QueryString["ID"]%>';
        /*保存数据*/
        function Save() {
            var txtBusinessName = $.trim($("#<%=this.txtBusinessName.ClientID%>").val());
            var txtFuncName = $.trim($("#<%=this.txtFuncName.ClientID%>").val());
            var txtSapParam = $.trim($("#<%=this.txtSapParam.ClientID%>").val());
            var txtSapParamDesc = $.trim($("#<%=this.txtSapParamDesc.ClientID%>").val());
            var txtSapFields = $.trim($("#<%=this.txtSapFields.ClientID%>").val());
            var txtTargetTabName = $.trim($("#<%=this.txtTargetTabName.ClientID%>").val());
            var txtTargetTabFields = $.trim($("#<%=this.txtTargetTabFields.ClientID%>").val());
            var txtSapTabName = $.trim($("#<%=this.txtSapTabName.ClientID%>").val());
            var txtRemark = $.trim($("#<%=this.txtRemark.ClientID%>").val());


            /*表单验证*/
            /*如需表单验证可以此处处理验证 开始*/
            if (txtBusinessName == "" || txtFuncName == "") {
                alert("带*为必填项.");
                return;
            }

            var txtSapFieldArr = txtSapFields.replace(/，/g, ",").split(",");
            var txtTargetTabFieldArr = txtTargetTabFields.replace(/，/g, ",").split(",");
            if (txtSapFieldArr.length != txtTargetTabFieldArr.length) {
                alert("SAP读取列和目标表对应列的数量要相同.");
                return;
            }
            var entity = {};
            entity.ID = aPIId;
            entity.BusinessName = txtBusinessName;
            entity.FuncName = txtFuncName;
            entity.SapParam = txtSapParam;
            entity.SapParamDesc = txtSapParamDesc;
            entity.SapFields = txtSapFields.replace(/，/g, ",");
            entity.TargetTabName = txtTargetTabName;
            entity.TargetTabFields = txtTargetTabFields.replace(/，/g, ",");
            entity.SapTabName = txtSapTabName;
            entity.Remark = txtRemark;

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSysConfiguration.APIEdit(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            alert('<%=Resources.Messages.SaveInSuccess%>')
            parent.window.Refresh();
        }
    </script>
</asp:Content>
