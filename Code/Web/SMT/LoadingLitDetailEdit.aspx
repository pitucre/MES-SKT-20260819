<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LoadingLitDetailEdit.aspx.cs"
    MasterPageFile="~/Masters/EditMaster.master" Inherits="SKT.LeanMES.Web.SMT.LoadingLitDetailEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
       <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %>
    </div>
    <table class="EditeContentTable" width="100%">
        <tr>
             <td class="Label2">区<em>*</em>
            </td>
            <td class="Field2"  >
                <asp:TextBox ID="txtArea" runat="server" CssClass="TextBox" IsRequired="1"></asp:TextBox>
            </td>
            <td class="Label2">插槽号<em>*</em>
            </td>
            <td class="Field2"  >
                <asp:TextBox ID="txtPosition" runat="server" CssClass="TextBox" IsRequired="1"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">产品编码<em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtItemName" runat="server" CssClass="TextBox" Enabled="false" IsRequired="1"></asp:TextBox><input type="button" id="Button1" onclick="selectItems(this);" class="ButtonBox" value="..." />
                <asp:HiddenField ID="hdnItemId" runat="server" Value="-1" ClientIDMode="Static" />
            </td>
            <td class="Label2">需求数量<em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtSmtNum" runat="server" CssClass="TextBox" ClientIDMode="Static" IsRequired="1"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">位置
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtLocationType" runat="server" CssClass="TextBox" ClientIDMode="Static" MaxLength="2000"></asp:TextBox>
            </td>
            <td class="Label2">飞达
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtFeederType" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">点位
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtPoint" runat="server" CssClass="TextBox" ClientIDMode="Static" MaxLength="2000"></asp:TextBox>
            </td>
            <td class="Label2">替换料
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtReplaceNum" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
            </td>
        </tr>
    </table>
    <asp:HiddenField ID="hdnLoadingListId" runat="server" Value="-1" />
    <script type="text/javascript">
        var LoadingListDetailId = '<%=Request.QueryString["ID"] %>';
        var LoadingListId =  '<%=Request.QueryString["LoadingListId"] %>';
       
        function Save() {
            var entity = {};
            entity.LoadingListDetailId = LoadingListDetailId;
            entity.ItemCode = $("#<%=txtItemName.ClientID %>").val();
            entity.Position = $("#<%=txtPosition.ClientID %>").val();
            entity.SmtNum = $("#<%=txtSmtNum.ClientID %>").val();
            entity.LocationType = $("#<%=txtLocationType.ClientID %>").val();
            entity.FeederType = $("#<%=txtFeederType.ClientID %>").val();
            entity.Point = $("#<%=txtPoint.ClientID %>").val();
            entity.ReplaceNum = $("#<%=txtReplaceNum.ClientID %>").val();
            entity.LoadingListId = LoadingListId;
            entity.Area = $("#<%=txtArea.ClientID %>").val();

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxServicesLoadingList.SaveLoadListDetail(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert("<%=Resources.Messages.SaveInSuccess %>");
            parent.window.UpdateList();
        }

        function selectItems(obj) {
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=1&Multiple=false&rnd=" + Math.random(), width: 680, height: 300 });
        }
        function getChooseValue(list) {
            $("#<%=this.txtItemName.ClientID %>").val(list[0][2]);
            $("#<%=this.hdnItemId.ClientID %>").val(list[0][0]);
        }
    </script>
</asp:Content>
