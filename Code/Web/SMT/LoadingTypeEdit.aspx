<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LoadingTypeEdit.aspx.cs"
    MasterPageFile="~/Masters/EditMaster.master" Inherits="SKT.LeanMES.Web.SMT.LoadingType" %>


<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <style>
        .HideInfo {
            display: none;
        }
    </style>

    <table width="100%" class="EditeContentTable">
        <tr>
            <td colspan="4" class="infoTips"><%=Resources.Messages.WithAsteriskIsRequired %><span>不使用的内容请填"0"</span></td>
        </tr>
        <tr>
            <td class="Label2">上料清单类型</td>
            <td class="Field2">
                <asp:TextBox ID="txtTypeName" runat="server" CssClass="TextBox" MaxLength="100"></asp:TextBox><em>*</em>
            </td>
            <td class="Label2">数据起始行</td>
            <td class="Field2">
                <asp:TextBox ID="txtBeginRow" runat="server" IsNumber='1' CssClass="TextBox"></asp:TextBox><em>*</em>
            </td>
        </tr>
        <tr>
            <td class="Label2">区（列）</td>
            <td class="Field2">
                <asp:TextBox ID="txtArea" runat="server" IsNumber='1' CssClass="TextBox" Text="0" ></asp:TextBox><em>*</em>
            </td>
            <td class="Label2">料站/插槽（列）</td>
            <td class="Field2">
                <asp:TextBox ID="txtPositon" runat="server" IsNumber='1' CssClass="TextBox"></asp:TextBox><em>*</em>
            </td>
        </tr>
        <tr>
            <td class="Label2">子插槽（列）</td>
            <td class="Field2">
                <asp:TextBox ID="txtPositionP2" runat="server" IsNumber='1' CssClass="TextBox" Text="0" ClientIDMode="Static"></asp:TextBox>
            </td>
            <td class="Label2">物料编码（列）</td>
            <td class="Field2">
                <asp:TextBox ID="txtPartNum" runat="server" IsNumber='1' CssClass="TextBox"></asp:TextBox><em>*</em>
            </td>

        </tr>
        <%--隐藏列--%>
        <tr class="HideInfo">
            <td class="Label2 HideInfo">面别（列）</td>
            <td class="Field2 HideInfo">
                <asp:TextBox ID="txtSurface" runat="server" Text="0" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label2 HideInfo">原件位置（列）</td>
            <td class="Field2 HideInfo">
                <asp:TextBox ID="txtLocation" runat="server" Text="0" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">点位（列）</td>
            <td class="Field2">
                <asp:TextBox ID="txtPoint" runat="server" IsNumber='1' CssClass="TextBox"></asp:TextBox><em>*</em>
            </td>
            <td class="Label2">飞达类型（列）</td>
            <td class="Field2">
                <asp:TextBox ID="txtFeederType" runat="server" CssClass="TextBox"></asp:TextBox><em>*</em>
            </td>
        </tr>
        <tr>
            <td class="Label2">用量（列）</td>
            <td class="Field2">
                <asp:TextBox ID="txtNum" runat="server" IsNumber='1' CssClass="TextBox"></asp:TextBox><em>*</em>
            </td>
            <td class="Label2">替代料（列）</td>
            <td class="Field2">
                <asp:TextBox ID="txtReplaceNum" runat="server" CssClass="TextBox" Text="0"></asp:TextBox>
            </td>

        </tr>
        <tr>
            <td class="Label2">元件说明</td>
            <td class="Field2">
                <asp:TextBox ID="txtElementDescription" runat="server" CssClass="TextBox" Text="0"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">备注</td>
            <td class="Field2" colspan="3">
                <asp:TextBox ID="txtRemark" runat="server" CssClass="TextArea" MaxLength="200" TextMode="MultiLine">

                </asp:TextBox>
            </td>
        </tr>
    </table>

    <script type="text/javascript">
        var loadingTypeId = '<%=Request.QueryString["ID"]%>';
        var user = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
        /*保存数据*/
        function Save() {
            var txtTypeName = $.trim($("#<%=this.txtTypeName.ClientID%>").val());
            var txtBeginRow = $("#<%=this.txtBeginRow.ClientID%>").val();
            var txtPositon = $("#<%=this.txtPositon.ClientID%>").val();
            var txtPartNum = $("#<%=this.txtPartNum.ClientID%>").val();
            var txtSurface = $("#<%=this.txtSurface.ClientID%>").val();
            var txtNum = $("#<%=this.txtNum.ClientID%>").val();
            var txtPoint = $("#<%=this.txtPoint.ClientID%>").val();
            var txtLocation = $("#<%=this.txtLocation.ClientID%>").val();
            var txtFeederType = $("#<%=this.txtFeederType.ClientID%>").val();
            var txtReplaceNum = $("#<%=this.txtReplaceNum.ClientID%>").val();
            var txtRemark = $.trim($("#<%=this.txtRemark.ClientID%>").val());
            var txtPositionP2 = $.trim($("#txtPositionP2").val());
            var txtArea = $.trim($("#<%=this.txtArea.ClientID%>").val());
            var txtElementDescription = $.trim($("#<%=this.txtElementDescription.ClientID%>").val());

            /*表单验证*/
            /*如需表单验证可以此处处理验证 开始*/

            var entity = {};
            entity.LoadingTypeId = loadingTypeId * 1;
            entity.TypeName = txtTypeName;
            entity.BeginRow = txtBeginRow * 1;
            entity.ColPosition = txtPositon * 1;
            entity.ColPartNum = txtPartNum * 1;
            entity.ColTable = txtSurface * 1;
            entity.ColNum = txtNum * 1;
            entity.ColPoint = txtPoint * 1;
            entity.ColLocationType = txtLocation * 1;
            entity.ColFeederType = txtFeederType * 1;
            entity.ColReplaceNum = txtReplaceNum * 1
            entity.Remark = txtRemark;
            entity.CreateBy = user;
            entity.ColPosition_2 = txtPositionP2 * 1;
            entity.ColArea = txtArea * 1;
            entity.ElementDescription = txtElementDescription * 1;

            if (loadingTypeId === '-1') {
                entity.CreateBy = user;
            }
            entity.ModifyBy = user;

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxServicesLoadingList.EditLoadingType(entity);
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
    </script>
</asp:Content>
