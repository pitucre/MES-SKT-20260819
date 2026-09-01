<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="ItemBomComponentEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Product.ItemBomComponentEdit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %></div>
    <table class="EditeContentTable" width="100%">
        <tr style=" display:none;">
            <td class="Label1">
                阶次<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtItemLevel" runat="server" CssClass="TextBox"  MaxLength='30' Text="" ClientIDMode="Static"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                物料名称<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtItemName" runat="server" CssClass="TextBox" Enabled="false" IsRequired='1' ClientIDMode="Static"></asp:TextBox><input
                    type="button" id="btnSelectItem" class="ButtonBox" value="..." title="<%=Resources.lang.ChooseItem %>"
                    onclick="selectItem(1);" />
                <asp:HiddenField ID="hdnItemCode" runat="server" Value="" />
                <asp:HiddenField ID="hdnItemId" runat="server" Value="-1" />
            </td>
        </tr>
 
        <tr>
            <td class="Label1">
               单位用量<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtQty" runat="server" CssClass="TextBox" IsRequired='1' IsNumber='1' MinValue='0' ClientIDMode="Static" ></asp:TextBox>&nbsp;
                <asp:Label ID="lblUnit" runat="server"  ClientIDMode="Static"></asp:Label> 
            </td>
        </tr>
        <tr>
            <td class="Label1">
                使用位置
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtUsePosition" runat="server" CssClass="TextBox" MaxLength='200' ClientIDMode="Static" ></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label1">
              是否虚拟件
            </td>
            <td class="Field1">
                <asp:DropDownList ID="ddlIsFictitious" runat="server" ClientIDMode="Static"> 
                    <asp:ListItem Value="0"  >否</asp:ListItem>
                    <asp:ListItem Value="1" >是</asp:ListItem>                   
                </asp:DropDownList>
            </td>
        </tr>
         
    </table>
    <script type="text/javascript">        
        var bomChildId = '<%=Request.QueryString["ID"] %>';
        var bomId = '<%=Request.QueryString["BOMID"] %>';               
        var chooseFlag = 0;
        var userName = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>';

        function selectItem(i) {
            chooseFlag = i;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=" + i.toString() + "&Multiple=false&rnd=" + Math.random(), width: 550, height: 280 });
        }

        function getChooseValue(list) {            
            if (chooseFlag == 1) {
                $("#<%=this.hdnItemCode.ClientID %>").val(list[0][2]);
                $("#<%=this.txtItemName.ClientID %>").val(list[0][1]);
                $("#<%=this.hdnItemId.ClientID %>").val(list[0][0]);
                $("#lblUnit").html(list[0][4]);
               
            }          
        }

        function Save() {
            var txtItemLevel = $("#<%=this.txtItemLevel.ClientID %>").val();
            var hdnItemId = $("#<%=this.hdnItemId.ClientID %>").val();
            var hdnItemCode = $("#<%=this.hdnItemCode.ClientID %>").val();
            var txtItemName = $("#<%=this.txtItemName.ClientID %>").val();           
            var txtQty = $("#<%=this.txtQty.ClientID %>").val();
            var txtUsePosition = $("#<%=this.txtUsePosition.ClientID %>").val();
            var ddlIsFictitious = $("#<%=this.ddlIsFictitious.ClientID %>").val();
            var lblUntis =$("#lblUnit").html();
            var entity = {};

            if (parseFloat(txtQty) > 10000000) {
                alert("当前产品用量输入值过大！");
                return false;
            }
            entity.ItemBomChildId = bomChildId;
            entity.ItemBomId = bomId;
            entity.ItemLevel = txtItemLevel;
            entity.ItemId = hdnItemId;
            entity.ItemCode = hdnItemCode;
            entity.ItemName = txtItemName;
            entity.Qty = parseFloat(txtQty);
            entity.Units = lblUntis;
            entity.UsePosition = txtUsePosition;
            entity.IsFictitious = (ddlIsFictitious == 0) ? false : true;
            entity.CreateBy = userName;
            entity.ModifyBy = userName;
            entity.FeatureCode = "";

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxProduct.ItemBomChildEdit(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert("<%=Resources.Messages.SaveInSuccess %>");
            parent.window.update(bomId);
        }     
    </script>
</asp:Content>