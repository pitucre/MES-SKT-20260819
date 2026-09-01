<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    CodeBehind="JigEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Jig.JigEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
     <table width="100%" class="EditeContentTable">
        <tr>
            <td colspan="4" class="Label infoTips">
                <%=Resources.Messages.WithAsteriskIsRequired %>
            </td>
        </tr>
         <tr class="clear5">
         </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.JigName %><em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtJigName" runat="server" CssClass="TextBox" MaxLength="50" isRequired="1"></asp:TextBox>
            </td>
            <td class="Label2">
                <%= Resources.lang.JigCode%><em>*</em>
            </td>
            <td class="Field2">
            <asp:TextBox ID="txtJigCode" runat="server" CssClass="TextBox" MaxLength="50" isRequired="1"></asp:TextBox>
                
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.Category%><em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtJigType" isRequired="1" runat="server" CssClass="TextBox" Enabled="false"></asp:TextBox>
                <input type="button" id="btnType" class="ButtonBox" value="..." title="选择类型"
                    onclick="selectTypeName();" />
                <asp:HiddenField ID="hdfType" runat="server" Value="-1" />
            </td>
             <td class="Label2">
                <%= Resources.lang.JigNickName %><em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtJigNickName" runat="server" CssClass="TextBox" MaxLength="50" isRequired="1"></asp:TextBox>
            </td>
           
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.VendorName %> 
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtVendorName" runat="server" CssClass="TextBox" Enabled="false"></asp:TextBox>
                <input type="button" id="btnVendor" class="ButtonBox" value="..." title="选择供应商"
                    onclick="selectVendorName();" />
                <asp:HiddenField ID="hdnVendor" runat="server" Value="-1" />
            </td>
            <td class="Label2">
                <%= Resources.lang.PartLocation%>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtPosition" runat="server" CssClass="TextBox" MaxLength="50"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                当前位置
            </td>
            <td class="Field2">
                <asp:Label ID="lblCurPosition" runat="server"  ></asp:Label>
            </td>
            <td class="Label2">
                <%= Resources.lang.StandarLive %><em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtStandarLive" runat="server" CssClass="TextBox" isNumber="1" MaxLength="10" isRequired="1"></asp:TextBox>
            </td>

        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.UserCount%>
            </td>
            <td class="Field2">
                <asp:Label ID="lblUseCount" runat="server"></asp:Label>
            </td>
            <td class="Label2">
                <%= Resources.lang.ItemName %>
            </td>
            <td class="Field2">
            <asp:TextBox ID="txtItemName" runat="server" CssClass="TextBox" Enabled="false"></asp:TextBox>
                <input type="button" id="btnItemName" class="ButtonBox" value="..." title="选择产品"
                    onclick="selectItemName();" />
                <asp:HiddenField ID="hdnItemId" runat="server" Value="-1" />
            </td>
        </tr>
        <tr>
            <td class="Label2">保养预警</td>
            <td class="Field2" colspan="3">
                 <asp:TextBox ID="txtWarningTime" runat="server" CssClass="TextBox" isNumber="1"></asp:TextBox>
            </td>
        </tr>
         <tr>

            <td class="Label2">
                <%= Resources.lang.Remark%>
            </td>
            <td class="Field2" colspan="3">
                <asp:TextBox ID="txtRemark" runat="server" CssClass="TextArea" TextMode="MultiLine"
                    MaxLength="50" Width="99%" Height="50"></asp:TextBox>
            </td>
        </tr>


    </table>
     <script type="text/javascript">
        var jigId = <%= Request.QueryString["Id"] == null ? -1 : Convert.ToInt32(Request.QueryString["Id"].ToString())%>
        var temp = 0;
        /*保存数据*/
        function Save() {
            var txtJigName = $.trim($("#<%=this.txtJigName.ClientID%>").val());
            var txtJigNickName = $.trim($("#<%=this.txtJigNickName.ClientID%>").val());
            var txtJigCode = $.trim($("#<%=this.txtJigCode.ClientID%>").val());
            var txtJigType = $("#<%=this.hdfType.ClientID%>").val();
            var txtItemId = $("#<%=this.hdnItemId.ClientID%>").val();
            var txtVendorId = $("#<%=this.hdnVendor.ClientID%>").val();
            var txtPosition = $.trim($("#<%=this.txtPosition.ClientID%>").val());
            var txtStandarLive = $("#<%=this.txtStandarLive.ClientID%>").val();
            var txtStandarMaint = 0//$("#<%//=this.txtStandarMain.ClientID%>").val();
            //var txtUseCount = $("#<%//=this.txtUseCount.ClientID%>").val();
            var txtRemark = $.trim($("#<%=this.txtRemark.ClientID%>").val());
            var txtWarningTime = $("#<%=this.txtWarningTime.ClientID%>").val()

            /*表单验证*/
            /*如需表单验证可以此处处理验证 开始*/
            if (txtWarningTime * 1 >= txtStandarLive * 1) {
                alert("标准寿命不能小于预警寿命");
                return false;
            }
            var entity = {};

            entity.JigId = parseInt(jigId);
            entity.JigName = txtJigName;
            entity.JigNickName = txtJigNickName;
            entity.JigCode = txtJigCode;
            entity.JigType = parseInt(txtJigType);
            entity.ItemId = parseInt(txtItemId);
            entity.VendorId = parseInt(txtVendorId);
            entity.Position = txtPosition;
            entity.StandarLive =parseInt(txtStandarLive);
            entity.StandarMaint = 0//parseInt(txtStandarMaint);
            //entity.UseCount = parseInt(txtUseCount);
            entity.Remark = txtRemark;
            entity.WarningTime = parseInt(txtWarningTime);

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxJig.JigEdit(entity); 
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            alert('<%=Resources.Messages.SaveInSuccess%>')
            if ('<%=Request.QueryString["inMenu"] %>' == "true") {
                openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/User/UserEdit.aspx?name=Account_UserEdit&ID=" + parseInt(ajax.value);
                location.href = openWinUrl;
            }
            else {
                parent.window.Refresh();
            }
        }
        function selectItemName() {
            temp = 1;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=1&Multiple=true&rnd=" + Math.random(), width: 600, height: 400 });
        }
        function selectVendorName() {
            temp = 2;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=34&Multiple=false&rnd=" + Math.random(), width: 600, height: 400 });
        }
        function selectTypeName(){
            temp = 3;
             dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=56&Multiple=false&rnd=" + Math.random(), width: 600, height: 400 });
        }
        function getChooseValue(list) {
            if (temp == 1) {
                $("#<%=this.txtItemName.ClientID %>").val(list[0][1] + "|" + list[0][2]);
                $("#<%=this.hdnItemId.ClientID %>").val(list[0][0]);
            }
            else if (temp == 2) {
                $("#<%=this.txtVendorName.ClientID %>").val(list[0][1] + "|" + list[0][2]);
                $("#<%=this.hdnVendor.ClientID %>").val(list[0][0]);
            }
            else if(temp==3){
                $("#<%=this.txtJigType.ClientID %>").val(list[0][1] + "|" + list[0][2]);
                $("#<%=this.hdfType.ClientID %>").val(list[0][0]);
             }
        } 
     </script>
</asp:Content>
