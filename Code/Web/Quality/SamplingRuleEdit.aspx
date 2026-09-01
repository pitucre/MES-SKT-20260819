<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="SamplingRuleEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Quality.SamplingRuleEdit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
<table class="EditeContentTable" width="100%">
        <tr>
            <td colspan="4" class="Label"><%=Resources.Messages.WithAsteriskIsRequired %></td>
        </tr>
        <tr>
            <td class="Label2">
                <%=Resources.lang.ItemsName %><em>*</em>
            </td>
            <td class="Field2">
                <asp:HiddenField  ID="hdnItemId" runat="server" Value="-1"/>
                <asp:TextBox ID="txtItemName" runat="server" CssClass="TextBox"></asp:TextBox><input type="button" id="btnSelectItem" class="ButtonBox" value="..." onclick="selectItem()"/>
            </td>
            <td class="Label2">
                <%=Resources.lang.AC_MSOBA_LotQty%><em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtLotSize" runat="server" CssClass="TextBox" onkeyup="this.value=this.value.replace(/\D/g,'')"
                    onafterpaste="this.value=this.value.replace(/\D/g,'')"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%=Resources.lang.AC_OBA_Percent %>
            </td>
            <td class="Field2">
<%--                <asp:TextBox ID="txtSamplePer" runat="server" CssClass="TextBox" onkeyup="if(isNaN(value))execCommand('undo')"
                    onafterpaste="if(isNaN(value))execCommand('undo')"  ></asp:TextBox>--%>
                    <asp:Label ID="lblSamplePer" runat="server"></asp:Label>
            </td>
            <td class="Label2">
                <%=Resources.lang.AC_OBA_SampleSize %><em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtSampleSize" runat="server" CssClass="TextBox" onkeyup="this.value=this.value.replace(/\D/g,'')"
                    onafterpaste="this.value=this.value.replace(/\D/g,'')" onblur="Onkey();" ></asp:TextBox>
            </td>
        </tr>
        </table>

        <script language="javascript" type="text/javascript">
            var itemAuditId = '<%=Request.QueryString["ID"] %>';


            function Onkey() {
                var strError = "";
                var txtSampleSize = $("#<%=this.txtSampleSize.ClientID %>").val();
                var txtLotSize = $("#<%=this.txtLotSize.ClientID %>").val();
                if (txtLotSize == "") {
                    strError += "请输入Lot Size\n";
                }

                if (txtSampleSize == "") {
                    strError += "请输入Sample Size\n";
                }
                if (!isNull(strError)) {
                    alert(strError.toString());
                    return false;
                }
                var count = txtSampleSize / txtLotSize * 100;
                var percentage = count.toFixed(2);
                $("#<%=this.lblSamplePer.ClientID %>").html("" + percentage + "%");

            }
            /*保存数据*/
            function Save() {
                var hdnItemId = $("#<%=this.hdnItemId.ClientID %>").val();
                var txtLotSize = $("#<%=this.txtLotSize.ClientID %>").val();
                var txtSamplePer = $("#<%=this.lblSamplePer.ClientID %>").text();
                var txtSampleSize = $("#<%=this.txtSampleSize.ClientID %>").val();

                var strError = "";

                /******add by weixia on 2014.12.26**********/
                var count = txtSampleSize / txtLotSize;
                var percentage = count.toFixed(2);
                /*******end******/
                if (hdnItemId == "-1") {
                    strError += "请选择产品\n";
                }

                if (txtLotSize == "") {
                    strError += "请输入Lot Size\n";
                }

                if (txtSampleSize == "") {
                    strError += "请输入Sample Size\n";
                }


                if (!isNull(strError)) {
                    alert(strError.toString());
                    return false;
                }

                var entity = {};
                entity.AuditRuleId = parseInt(itemAuditId);
                entity.ItemId = parseInt(hdnItemId);
                entity.LotSize = parseInt(txtLotSize);
                entity.SamplePercent = parseFloat(percentage);
                entity.SampleSize = parseInt(txtSampleSize);
                entity.CreateBy = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserId %>";
                entity.ModifyBy = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserId %>";

                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSamplingRule.EditOBAItemAudit(entity);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }

                alert('<%=Resources.Messages.SaveInSuccess %>');
                parent.window.UpdateList($("#<%=this.txtItemName.ClientID %>").val());
            }

            function selectItem() {
                dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=1&Multiple=false&rnd=" + Math.random(), width: 500, height: 300 });
            }

            function getChooseValue(list) {
                $("#<%=this.txtItemName.ClientID %>").val(list[0][1]);
                $("#<%=this.hdnItemId.ClientID %>").val(list[0][0]);
                $("#<%=this.txtItemName.ClientID %>").focus();
            }
    </script>
</asp:Content>
