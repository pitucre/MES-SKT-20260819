<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NavigationItemEdit.aspx.cs" 
    Inherits="SKT.LeanMES.Web.Navigation.NavigationItemEdit" MasterPageFile="~/Masters/EditMaster.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
<%--        <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %></div>--%>
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label1">
                序号<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtSequence" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                导航组名<em>*</em>
            </td>
            <td class="Field1" colspan="3">
                <asp:DropDownList ID="ddlNavigationgpName" runat="server" IsRequired="1">
                </asp:DropDownList>             
            </td>
        </tr>
        <tr>
            <td class="Label1">
                导航项名<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtNavigationName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
         <tr>
            <td class="Label1">
                打开方式<em>*</em>
            </td>
            <td class="Field1">
                <asp:DropDownList ID="ddlTarget" runat="server">
                  <asp:ListItem Value="1" Text="<%$ Resources:lang,NewPage %>"></asp:ListItem>
                    <asp:ListItem Value="2" Text="<%$ Resources:lang,Tab %>"></asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                URL<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtUrl" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        var Id = '<%=Request.QueryString["ID"] %>';
        var NavigationId = "";
        
        $(function () {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxNavigation.GetitemSequence(Id);
            if(ajax.error !=null)
            {
                alert(ajax.error.Message)
                return false;
            }

            $("#<%=this.txtSequence.ClientID%>").val(ajax.value);

            $("#txtSequence").focus(function () { this.select() });

        
        })
        function Save() {
            var ddlNavigationgpName = $("#<%=this.ddlNavigationgpName.ClientID%>").find("option:selected").text();;           
            var txtSequence = $("#<%=this.txtSequence.ClientID%>").val();            
            var txtNavigationName = $("#<%=this.txtNavigationName.ClientID%>").val();
            var txtUrl = $("#<%=this.txtUrl.ClientID%>").val();
            var CreateBy = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';
            var ModifyBy = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';            
            NavigationId = $("#<%=this.ddlNavigationgpName.ClientID%>").val();
            var Target = $("#<%=this.ddlTarget.ClientID%>").val();      
            
            if(txtSequence =="" || ddlNavigationgpName =="" || txtNavigationName =="" || txtUrl =="")
            {
                alert("带*号不可为空！");
                return false;
            }

            var entity = {};
            entity.ID = Id;
            entity.Sequence = txtSequence;
            entity.NavigationId = NavigationId;
            entity.NavigationgpName = ddlNavigationgpName;
            entity.NavigationName = txtNavigationName;
            entity.Url = txtUrl;
            entity.Target = Target;

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxNavigation.NavigationItemEdit(entity);
            if(ajax.error !=null)
            {
                alert(ajax.error.Message);
                return false;
            }
            alert("<%=Resources.Messages.SaveInSuccess %>");
            window.parent.UpdateList(txtNavigationName);
        }

      <%--  function selectName() {
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot  %>/Framework/ChoosePage.aspx?PageId=700&Multiple=false&CallBackFunc=setName&rnd=" + Math.random(), width: 545, height: 300 });
        }--%>

        <%--function setName(list) {
            $("#<%=this.ddlNavigationgpName.ClientID%>").val(list[0][2]);
            $("#<%=this.hdnNavigationgpId.ClientID%>").val(list[0][0]);
        }--%>
    </script>
</asp:Content>