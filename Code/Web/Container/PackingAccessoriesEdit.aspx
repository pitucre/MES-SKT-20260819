<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="PackingAccessoriesEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Container.PackingAccessoriesEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %>
    </div>
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label1">产品编码<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtMainItemCode" runat="server" CssClass="TextBox" Enabled="false"
                    IsRequired='1' ClientIDMode="Static"></asp:TextBox><input type="button" id="btnSelectItem"
                        class="ButtonBox" value="..." title="<%=Resources.lang.ChooseItem %>" onclick="ChoosePage(1);" />
                <asp:HiddenField ID="hdnMainItemId" runat="server" Value="-1" />
            </td>

        </tr>
        <tr>
            <td class="Label1">附件名称<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtAccessoriesName" runat="server" CssClass="TextBox" IsRequired='1'
                    ClientIDMode="Static"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label1">工序<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtStation" runat="server" CssClass="TextBox" Enabled="false" IsRequired='1'
                    ClientIDMode="Static"></asp:TextBox><input type="button" id="Button2" class="ButtonBox"
                        value="..." title="<%=Resources.lang.ChooseItem %>" onclick="ChoosePage(3);" />
                <asp:HiddenField ID="hdnStationId" runat="server" Value="-1" />
            </td>
        </tr>
        <tr>
            <td class="Label1">数量<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtAccessoriesQty" runat="server" CssClass="TextBox" MaxLength="5"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label1">扫描顺序<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtSequence" runat="server" CssClass="TextBox" MaxLength="5"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label1">检查类型<%--<em>*</em>--%>
            </td>
            <td class="Field1">
                <asp:DropDownList ID="ddlCheckType" runat="server">
                  <asp:ListItem Value="1" Text="<%$ Resources:lang,Other %>"> </asp:ListItem>
                    <asp:ListItem Value="2" Text="<%$ Resources:lang,SnInspection %>"> </asp:ListItem>  
                    <asp:ListItem Value="3" Text="<%$ Resources:lang,ComponentInspection %>"> </asp:ListItem>   
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="Label1">Group Type<em>*</em> <%-- 掩码组名--%>
            </td>
            <td class="Field1">
                <asp:DropDownList ID="txtMaskId" runat="server">
                </asp:DropDownList>

                <asp:DropDownList ID="ddlSnType" runat="server">
                    <asp:ListItem Value="0" Text="产品条码"> </asp:ListItem>
                    <asp:ListItem Value="10" Text="客户条码"> </asp:ListItem>
                    <asp:ListItem Value="11" Text="客户条码2"> </asp:ListItem>
                </asp:DropDownList>
                <asp:DropDownList ID="ddlPart" runat="server" >
                    <asp:ListItem Value="-100" Text="MAC"></asp:ListItem>
                    <asp:ListItem Value="-101" Text="WIFI_MAC"></asp:ListItem>
                    <asp:ListItem Value="-102" Text="BlueTooth_MAC"></asp:ListItem>
                    <asp:ListItem Value="-103" Text="DEVICE_ID"></asp:ListItem>            
                </asp:DropDownList>     
                <%-- <asp:TextBox ID="txtMask" runat="server" CssClass="TextBox" IsRequired='1'  Enabled="false"></asp:TextBox><input
                    type="button" id="btnMask" class="ButtonBox" value="..." title="" onclick="ChoosePage(4);" />
                <asp:HiddenField ID="hdnMaskId" runat="server" Value="-1" />--%>
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
        var packingAccessoriesConfigId = '<%=Request.QueryString["ID"]%>';
        var chooseFlag = 0;
        $(function () {
           <%-- if (packingAccessoriesConfigId > 0) {
                showDivContent($("#<%=this.ddlCheckType.ClientID%>").val());
            } else {--%>
                showDivContent($("#<%=this.ddlCheckType.ClientID%>").val());
            //}
         })
        $().ready(function () {
            $("#<%=this.txtAccessoriesQty.ClientID %>,#<%=this.txtSequence.ClientID %>")
                .bind("keyup", function () {
                    getIntVal(this)
                });
        });

        /*保存数据*/
        function Save() {
            var txtMaskId = "";
            var ddlCheckType = $("#<%=this.ddlCheckType.ClientID%>").val();
             if (ddlCheckType == 1 ) {
                 txtMaskId = $("#<%=this.txtMaskId.ClientID%>").val()
             } else if (ddlCheckType == 2) {
                txtMaskId = $("#<%=this.ddlSnType.ClientID%>").val();
             }
             else if (ddlCheckType == 3) {
                 txtMaskId = $("#<%=this.ddlPart.ClientID%>").val()
             }
            var action = '<%=Request.QueryString["Action"] %>';
            var txtItemId = $("#<%=this.hdnMainItemId.ClientID%>").val();
            var txtAccessoriesName = $.trim($("#<%=this.txtAccessoriesName.ClientID%>").val());
            var txtStationId = $("#<%=this.hdnStationId.ClientID%>").val();
            var txtAccessoriesQty = $("#<%=this.txtAccessoriesQty.ClientID%>").val();
            var ddlCheckType = ddlCheckType;
            var txtRemark = $.trim($("#<%=this.txtRemark.ClientID%>").val());
            var txtCreateBy = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';
            var txtModifyBy = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';
            var txtSequence = $("#<%=this.txtSequence.ClientID%>").val();
            /*表单验证*/
            /*如需表单验证可以此处处理验证 开始*/


            var entity = {};

            if (action == "Copy") {
                entity.PackingAccessoriesConfigId = -1;
            }
            else {
                entity.PackingAccessoriesConfigId = packingAccessoriesConfigId
            }

            entity.ItemId = txtItemId;
            entity.AccessoriesName = txtAccessoriesName;
            entity.StationId = txtStationId;
            entity.AccessoriesQty = txtAccessoriesQty;
            entity.MaskId = txtMaskId;
            entity.Remark = txtRemark;
            entity.CreateBy = txtCreateBy;
            entity.ModifyBy = txtModifyBy;
            entity.Sequence = txtSequence;
            entity.CheckType = ddlCheckType;
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPackingAccessories.PackingAccessoriesConfigEdit(entity);
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
            else if (chooseFlag == 3) {
                flag = "8";
            }
            /*  else if (chooseFlag == 4) {
                  flag = "24";
              }*/
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=" + flag + "&Multiple=false&rnd=" + Math.random(), width: 650, height: 350 });
        }

        function getChooseValue(list) {
            if (chooseFlag == 1) {
                $("#<%=this.txtMainItemCode.ClientID %>").val(list[0][1]);
                $("#<%=this.hdnMainItemId.ClientID %>").val(list[0][0]);
            }
            else if (chooseFlag == 3) {
                $("#<%=this.txtStation.ClientID %>").val(list[0][1]);
                $("#<%=this.hdnStationId.ClientID %>").val(list[0][0]);
            }
           <%-- else if (chooseFlag == 4) {
                $("#<%=this.txtMask.ClientID %>").val(list[0][1]);
                $("#<%=this.hdnMaskId.ClientID %>").val(list[0][0]);
            }--%>
        }
        $("#<%=this.ddlCheckType.ClientID%>").bind("change", function () {
            var selectCheckType = $("#<%=this.ddlCheckType.ClientID%>").val();
             showDivContent(selectCheckType);
         });
         function showDivContent(selectCheckType) {
             if (selectCheckType == 1 ) {
                 $("#<%=this.txtMaskId.ClientID%>").show();
                 $("#<%=this.ddlSnType.ClientID%>").hide();
                 $("#<%=this.ddlPart.ClientID%>").hide();
            }
            else if (selectCheckType == 2) {
                $("#<%=this.ddlSnType.ClientID%>").show();
                $("#<%=this.txtMaskId.ClientID%>").hide();
                $("#<%=this.ddlPart.ClientID%>").hide();
            }
            else if (selectCheckType == 3) {
                $("#<%=this.ddlSnType.ClientID%>").hide();
                $("#<%=this.txtMaskId.ClientID%>").hide();
                $("#<%=this.ddlPart.ClientID%>").show();
            }
    }
    </script>
</asp:Content>
