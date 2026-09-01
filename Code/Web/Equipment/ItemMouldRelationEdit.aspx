<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="True"
    CodeBehind="ItemMouldRelationEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Equipment.ItemMouldRelationEdit" Title="Edit ItemMouldRelationEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %>
    </div>
    <table width="100%" class="EditeContentTable">
        <tr>
            
            <td class="Label1"><%= Resources.lang.ItemCode %><em>*</em></td>
            <td class="Field1" >
                <asp:TextBox ID="txtItemName" runat="server" CssClass="TextBox" IsRequired='1' Width="210" 
                    ReadOnly="true"></asp:TextBox><input type="button" id="btnItemName" class="ButtonBox" 
                        value="..." onclick="selectItemName()" />
                <asp:HiddenField ID="HiddenItemId" runat="server" Value="-1" />
            </td>
           
        </tr>
               <tr>
          
            <td class="Label1"><%= Resources.lang.MouldName %><em>*</em></td>
            <td class="Field1" >
                <asp:TextBox ID="txtMouldName" runat="server" CssClass="TextBox" IsRequired='1' Width="210"
                    ReadOnly="true"></asp:TextBox><input type="button" id="btnMouldName" class="ButtonBox"
                        value="..." onclick="selectMouldName()" />
                <asp:HiddenField ID="HiddenMouldBomId" runat="server" Value="-1" />
            </td>

           
        </tr>

        <tr>
          
            <td class="Label1"><%= Resources.lang.Remark %>：</td>
            <td class="Field2">
                        <asp:TextBox ID="txtRemark" runat="server" CssClass="TextBox"
                            ClientIDMode="Static"></asp:TextBox>
                    </td>
        </tr>


    </table>

    <asp:HiddenField runat="server" ID="hdeqCode"/>
    <script type="text/javascript">
        
        var equipmentItemRelationId = '<%=Request.QueryString["ID"]%>';
        var temp = -1;

        $(function() {
            if (equipmentItemRelationId > 0) {
                $("#btnItemName").attr("disabled", "True");
               
            }

        })
        function selectItemName() {
            
            temp = 1;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=1&Multiple=false&rnd=" + Math.random(), width: 720, height: 450 });
        }

           function selectMouldName() {
            temp = 2;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=713&Multiple=false&rnd=" + Math.random(), width: 720, height: 450 });
        }
       
        function getChooseValue(list) {
            if (temp == 1) {
                $("#<%=this.txtItemName.ClientID%>").val('('+list[0][1]+')'+list[0][2]);
                $("#<%=this.HiddenItemId.ClientID%>").val(list[0][0]);
            }else if (temp == 2) {
                $("#<%=this.txtMouldName.ClientID%>").val(list[0][1]);
                $("#<%=this.HiddenMouldBomId.ClientID%>").val(list[0][0]);
            }
        }

        /*保存数据*/
        function Save() {

            var hiddenItemId = $("#<%=this.HiddenItemId.ClientID%>").val();
            var hiddenMouldBomId = $("#<%=this.HiddenMouldBomId.ClientID%>").val();
            var remark = $("#<%=this.txtRemark.ClientID%>").val();
            var entity = {};
            entity.ItemMouldRelationId = equipmentItemRelationId;
            entity.ItemId = hiddenItemId;
            entity.MouldId = hiddenMouldBomId;
            entity.CreateBy = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';
            entity.Remark = remark;


            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxItemMouldRelation.ItemMouldRelationEdits(entity);

            if (ajax.error != null) {
                alert(ajax.error.Message);
                return;
            }

            alert('<%=Resources.Messages.SaveInSuccess%>');
            parent.window.Refresh();
          
        }
    </script>

</asp:Content>
