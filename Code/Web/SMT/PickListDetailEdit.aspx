<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PickListDetailEdit.aspx.cs"
    MasterPageFile="~/Masters/EditMaster.master" Inherits="SKT.LeanMES.Web.SMT.PickListDetailEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div class="infoTips">
                <%=Resources.Messages.WithAsteriskIsRequired %></div>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">
                产品编码<em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtItemCode" runat="server" CssClass="TextBox" Enabled="false" ClientIDMode="Static" IsRequired='1'></asp:TextBox>
                <input type="button" id="btnSelectItem" class="ButtonBox" value="..." title="选择产品"
                    onclick="selectItem();"  />
                <asp:HiddenField ID="hdnItemId" runat="server" Value="-1" ClientIDMode="Static" />
            </td>
            <td class="Label2">
                需求数量<em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtPickListQty" runat="server" CssClass="TextBox" IsRequired='1' IsNumber='1' ClientIDMode="Static"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                扣料组编码
            </td>
            <td class="Field2">
                <asp:DropDownList ID="ddlGroupCode" runat="server" ClientIDMode="Static">
                    <asp:ListItem Text="扣料组1" Value="1"></asp:ListItem>
                    <asp:ListItem Text="扣料组2" Value="2"></asp:ListItem>
                    <asp:ListItem Text="扣料组3" Value="3"></asp:ListItem>
                    <asp:ListItem Text="扣料组4" Value="4"></asp:ListItem>
                    <asp:ListItem Text="扣料组5" Value="5"></asp:ListItem>
                    <asp:ListItem Text="扣料组6" Value="6"></asp:ListItem>
                    <asp:ListItem Text="扣料组7" Value="7"></asp:ListItem>
                    <asp:ListItem Text="扣料组8" Value="8"></asp:ListItem>
                    <asp:ListItem Text="扣料组9" Value="9"></asp:ListItem>
                    <asp:ListItem Text="扣料组10" Value="10"></asp:ListItem>
                 </asp:DropDownList>               
            </td>
            <td class="Label2">
                扣料组描述
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtGroupDesc" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                备注
            </td>
            <td class="Field2" colspan="3">
                <asp:TextBox ID="txtRemark" runat="server" CssClass="TextArea" Width="86%" ClientIDMode="Static"
                    TextMode="MultiLine"></asp:TextBox>
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        var pickListDetailId = '<%=Request.QueryString["ID"] %>';
        var pickListId = '<%=Request.QueryString["PickListID"] %>'; 
        var chooseFlag = -1;

        $(function () {
            if (pickListDetailId  != "-1") {
                $("#btnSelectItem").attr("disabled", "disabled");
            }
        })

        function Save() {
            var qty = $("#txtPickListQty").val();
            var itemId = $("#hdnItemId").val();
            var groupCode = $("#ddlGroupCode").val();
            var groupDesc = $("#txtGroupDesc").val();
            var remark = $("#txtRemark").val();
            var entity = {};
            entity.DetailID = pickListDetailId;
            entity.ItemID = itemId;
            entity.Qty = parseFloat(qty);
            entity.GroupCode = groupCode;
            entity.GroupDesc = groupDesc;
            entity.Remark = remark;
            entity.ListID = pickListId;
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPickList.pickListDetailEdit(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert("<%=Resources.Messages.SaveInSuccess %>");
            parent.window.UpdateList();
        }

        function selectItem() {
            chooseFlag = 1;
            var searchCondition = "";
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=1&SearchCondition=" + searchCondition + "&Multiple=false&rnd=" + Math.random(), width: 680, height: 300 });
        }

        function getChooseValue(list) {
            if (chooseFlag == 1) {
                $("#<%=this.txtItemCode.ClientID %>").val(list[0][1]);
                $("#<%=this.hdnItemId.ClientID %>").val(list[0][0]);
            }
        }
    </script>
</asp:Content>
