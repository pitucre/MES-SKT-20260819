<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    CodeBehind="OfflineSerialNumberEdit.aspx.cs" Inherits="SKT.LeanMES.Web.SerialNumber.OfflineSerialNumberEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
<div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %></div>
    <table width="100%" class="EditeContentTable">    
        <tr>
            <td class="Label1">
                产品编码<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtMainItemCode" runat="server" CssClass="TextBox" Enabled="false"
                    IsRequired='1' ClientIDMode="Static"></asp:TextBox><input type="button" id="btnSelectItem"
                        class="ButtonBox" value="..." title="<%=Resources.lang.ChooseItem %>" onclick="ChoosePage(1);" />
                <asp:HiddenField ID="hdnMainItemId" runat="server" Value="-1" />
            </td>
           
        </tr>
         <tr>
          <td class="Label1">
                部件编码
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtPartItemCode" runat="server" CssClass="TextBox" Enabled="false"
                    ClientIDMode="Static"></asp:TextBox><input type="button" id="Button1"
                        class="ButtonBox" value="..." title="<%=Resources.lang.ChooseItem %>" onclick="ChoosePage(2);" />
                <asp:HiddenField ID="hdnPartItemId" runat="server" Value="-1" />
            </td>
         </tr>
        <tr>
            <td class="Label1">
                工序<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtStation" runat="server" CssClass="TextBox" Enabled="false" IsRequired='1'
                    ClientIDMode="Static"></asp:TextBox><input type="button" id="Button2" class="ButtonBox"
                        value="..." title="<%=Resources.lang.ChooseItem %>" onclick="ChoosePage(3);" />
                <asp:HiddenField ID="hdnStationId" runat="server" Value="-1" />
            </td>          
        </tr>
         <tr>
           <td class="Label1">
                数量<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtAssemblyQty" runat="server"  CssClass="TextBox" MaxLength="5" IsRequired='1' ></asp:TextBox>
            </td>
         </tr>
        <tr>
            <td class="Label1">
                部件类型<em>*</em>
            </td>
            <td class="Field1">
                <asp:DropDownList ID="ddlPartType" ClientIDMode="Static" runat="server" IsRequired='1' >
                    <asp:ListItem Text="--请选择--" Value=""></asp:ListItem>                   
                    <asp:ListItem Text="MAC" Value="MAC"></asp:ListItem>
                    <asp:ListItem Text="WIFI_MAC" Value="WIFI_MAC"></asp:ListItem>
                    <asp:ListItem Text="BlueTooth_MAC" Value="BlueTooth_MAC"></asp:ListItem>
                    <asp:ListItem Text="DEVICE_ID" Value="DEVICE_ID"></asp:ListItem>
                    <asp:ListItem Text="SN" Value="SN"></asp:ListItem>
                    <asp:ListItem Text="DEFAULT" Value="DEFAULT"></asp:ListItem>
                </asp:DropDownList>
            </td>
           
        </tr>
        <tr id="trMaskGroup" style="display:none">
            <td class="Label1">
                掩码组名<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtMask" runat="server" CssClass="TextBox" Enabled="false"></asp:TextBox><input
                    type="button" id="btnMask" class="ButtonBox" value="..." title="" onclick="ChoosePage(4);" />
                <asp:HiddenField ID="hdnMaskId" runat="server" Value="-1" ClientIDMode="Static" />
            </td>
        </tr>
        <tr>
         <td class="Label1">
                <%= Resources.lang.Remark %>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtRemark" runat="server" TextMode="MultiLine" CssClass="TextArea" MaxLength="100"></asp:TextBox>
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        var offlineSNConfigId = '<%=Request.QueryString["ID"]%>';
        var chooseFlag = 0;
        var action = '<%=Request.QueryString["Action"] %>';

        $().ready(function () {
            $("#<%=this.txtAssemblyQty.ClientID %>")
                .bind("keyup", function () {
                    getIntVal(this)
                });

           
            if ($("#ddlPartType").val() == "DEFAULT") {
               
                $("#trMaskGroup").show();
                $("#txtMask").attr("IsRequired", "1");
            }

            $("#ddlPartType").change(function () {
                if (this.value == "DEFAULT") {
                    $("#trMaskGroup").show();
                    $("#txtMask").attr("IsRequired", "1");
                }
                else {
                    $("#trMaskGroup").hide();
                    $("#txtMask").val("").removeAttr("IsRequired");
                    $("#hdnMaskId").val(-1);
                }
            });
         });

        /*保存数据*/
        function Save() {
            var txtMainItemId = $("#<%=this.hdnMainItemId.ClientID%>").val();
            var txtPartItemId = $("#<%=this.hdnPartItemId.ClientID%>").val();
            var txtStationId = $("#<%=this.hdnStationId.ClientID%>").val();
            var txtAssemblyQty = $("#<%=this.txtAssemblyQty.ClientID%>").val();
            var txtMaskId = $("#hdnMaskId").val();
            var txtRemark = $.trim($("#<%=this.txtRemark.ClientID%>").val());
            var txtCreateBy = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';
            var txtModifyBy = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';
            var ddlPartType = $("#ddlPartType").val();

            if (ddlPartType == "SN" && txtPartItemId == -1) {
                alert("当前部件类型为SN，请选择部件编码！");
                return false;
            }
            /*表单验证*/
            /*如需表单验证可以此处处理验证 开始*/

            var entity = {};

            if (action == "Copy") {
                entity.OfflineSNConfigId = -1;
            }
            else {
                entity.OfflineSNConfigId = offlineSNConfigId;
            }
    
            entity.MainItemId = txtMainItemId;
            entity.PartItemId = txtPartItemId;
            entity.StationId = txtStationId;
            entity.AssemblyQty = txtAssemblyQty;
            entity.MaskId = txtMaskId;
            entity.Remark = txtRemark;
            entity.CreateBy = txtCreateBy;
            entity.ModifyBy = txtModifyBy;
            entity.PartType = ddlPartType;

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxOfflineSNConfig.OfflineSNConfigEdit(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            alert('<%=Resources.Messages.SaveInSuccess%>')
            parent.window.Refresh();
            
        }

        function ChoosePage(flag) {
            chooseFlag = flag;
            if (chooseFlag == 1) {
                flag = "1";
            }
            else if (chooseFlag == 2) {
                flag = "1";
            }
            else if (chooseFlag == 3) {
                flag = "8";
            }
            else if (chooseFlag == 4) {
                flag = "24";
            }
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=" + flag + "&Multiple=false&rnd=" + Math.random(), width: 650, height: 450 });
        }

        function getChooseValue(list) {
            if (chooseFlag == 1) {
                $("#<%=this.txtMainItemCode.ClientID %>").val(list[0][1]);
                $("#<%=this.hdnMainItemId.ClientID %>").val(list[0][0]);
            }
            else if (chooseFlag == 2) {
                $("#<%=this.txtPartItemCode.ClientID %>").val(list[0][1]);
                $("#<%=this.hdnPartItemId.ClientID %>").val(list[0][0]);
            }
            else if (chooseFlag == 3) {
                $("#<%=this.txtStation.ClientID %>").val(list[0][1]);
                $("#<%=this.hdnStationId.ClientID %>").val(list[0][0]);
            }
            else if (chooseFlag == 4) {
                $("#<%=this.txtMask.ClientID %>").val(list[0][1]);
                $("#<%=this.hdnMaskId.ClientID %>").val(list[0][0]);
            }
        }
    </script>
</asp:Content>
