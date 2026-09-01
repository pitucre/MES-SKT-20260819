<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="RouterBind.aspx.cs" Inherits="SKT.LeanMES.Web.Product.RouterBind" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" Runat="Server">
<table class="EditeContentTable" width="100%">
    <tr>
        <td class="Label1"><%= Resources.lang.ShopOrder %></td>
        <td class="Field1">
            <asp:Label ID="lblShopOrder" runat="server" ClientIDMode="Static"></asp:Label>
        </td>
    </tr>
    <tr>
        <td class="Label1"><%= Resources.lang.ItemsName %></td>
        <td class="Field1">
            <asp:Label ID="lblItemName" runat="server"></asp:Label>
        </td>
    </tr>
    <tr>
        <td class="Label1"><%= Resources.lang.RouterName %></td>
        <td class="Field1">
            <asp:TextBox ID="txtRouterName" runat="server" IsRequired = '1'  CssClass="TextBox" ClientIDMode="Static"></asp:TextBox><input type="button" class="ButtonBox" value="..." title="Select" onclick="openChoosePage(22);" /><em>*</em>
            <asp:HiddenField ID="hdnRouterId" runat="server" ClientIDMode="Static" />
        </td>
    </tr>
</table>

<script type="text/javascript">
    var flag = -1;
    var Id = <%=Request.QueryString["OrderID"] %>;
    var userName = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>';

    function getChooseValue(list) {
        if (flag == 22) {
            $("#txtRouterName").val(list[0][1]);
            $("#hdnRouterId").val(list[0][0]);
        }
        flag = -1;
    }
     
    function Save() {
            
        if($("#hdnRouterId").val() > 0)
        {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxShopOrder.RouterBind(Id, $("#hdnRouterId").val(), userName);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            alert("<%=Resources.Messages.SaveInSuccess %>");
            parent.window.UpdateList($("#lblShopOrder").text());
        }else
        {
            alert("请选择路由！");
            return false;
        }
    }

    function openChoosePage(flags){
        var condition = "";
        flag = flags;
        dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId="+flags+"&Multiple=false&SearchCondition="+condition+"&rnd=" + Math.random(), width: 600, height: 300 });
    }

</script>
</asp:Content>

