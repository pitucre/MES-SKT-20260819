<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="OSPTypeEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Hold.OSPTypeEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %>
    </div>
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label1">工序段类型
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtOperateType" runat="server" CssClass="TextBox" MaxLength="50" ClientIDMode="Static"></asp:TextBox>
            </td>
        </tr>
       <tr>
            <td class="Label1">时间（分）
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtOSPTypeTime" runat="server" CssClass="TextBox" MaxLength="50" IsNumber="1" ClientIDMode="Static"></asp:TextBox>
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        var Id = '<%=Request.QueryString["ID"]%>';
        
        var userName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";

        function Save() {
            var txtOperateType = $("#txtOperateType").val();
            var txtOSPTypeTime= $("#txtOSPTypeTime").val();
            if(txtOperateType == ""){
                alert("请选择工序段类型！");
                $("#txtOperateType").select();
                return false;
            }
            if(txtOSPTypeTime == ""){
                alert("请选择工序段时间！");
                $("#txtOSPTypeTime").select();
                return false;
            }
            var entity = {};
            entity.OSPTypeId = Id;
            entity.OSPTypeName = txtOperateType;
            entity.OSPTypeTime = txtOSPTypeTime;
            entity.UserName = userName;

            var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("Prod_OSPType_Edit", JSON.stringify(entity));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert("保存成功！");

            window.parent.location.reload();
        }

        
    </script>
</asp:Content>
