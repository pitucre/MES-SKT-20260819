<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RecPersonEdit.aspx.cs" Inherits="SKT.LeanMES.Web.EmailConfig.RecPersonEdit" MasterPageFile="~/Masters/EditMaster.master"%>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <div >
    <div class="infoTips"><%=Resources.Messages.WithAsteriskIsRequired %></div>
        <table style="width:100%" class="EditeContentTable">
            <tr>
                <td class="Label1">
                    收件人<em>*</em>
                </td>
                <td class="Field1">
                    <asp:TextBox ID="txtUserName" runat="server" ClientIDMode="Static" CssClass="TextBox" Width="160px" IsRequired='1'></asp:TextBox>
                 </td>
            </tr>
            <tr>
                <td class="Label1">
                    邮箱地址<em>*</em>
                </td>
                <td class="Field1">
                    <asp:TextBox ID="txtMailAddress" runat="server" ClientIDMode="Static" CssClass="TextBox" Width="160px" IsRequired='1'></asp:TextBox>
                 </td>
            </tr>
            <tr>
                <td class="Label1">
                    接收邮件类别 
                </td>
                <td class="Field1" >
                    <div id="divRecEmailType" style="height:160px; overflow:auto"></div>
                </td>
            </tr>
        </table>
    </div>
    <script type="text/javascript" language="javascript">
        var Id = '<%= Request.QueryString["Id"]%>';

        $(document).ready(function () {
            getRecEmailType();
        })

        function Save() {
            var txtUserName = $("#txtUserName").val();
            var txtMailAddress = $("#txtMailAddress").val();
            var strRecEmailTypeName = "";

            $(".chkRecEmailType:checked").each(function () {
                strRecEmailTypeName+= $(this).next().val() + ",";
            })

            if(!checkEmail(txtMailAddress)){return false;}

            var entity = {};
            entity.RecId = Id;
            entity.PersonName = txtUserName;
            entity.MailAddress = txtMailAddress;
            entity.RecEmailType = strRecEmailTypeName;
            entity.CreateBy = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
            entity.ModifyBy = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
            entity.Remark = "";

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEmailConfig.EmailRecPersonEdit(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            else {
                alert("保存成功！");
                parent.window.UpdateList(txtUserName)
            }
        }


        function getRecEmailType() {
            var html = '';
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEmailConfig.GetRecEmailType(Id);
            if (ajax.error != null) {
                html = ajax.error.Message;
            }
            else {
                var list = ajax.value;
                var isCheck = "";

                if (list.length > 0) {
                    html += '<ul>';

                    for (var i = 0; i < list.length; i++ ) {

                        isCheck = list[i].NotBind == "1" ? '' : 'checked ="checked"';

                        html += '<li><input type="checkbox" class="chkRecEmailType" '+ isCheck +'/>' + list[i].Description + '<input type="hidden" value=' + list[i].Name + ' style="display:none"/></li>';
                    }

                    html += '</ul>';
                }
                
                html
            }

            $("#divRecEmailType").html(html);
        }
    </script>
</asp:Content>

