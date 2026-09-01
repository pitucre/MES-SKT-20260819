<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="StationOutputRateEdit.aspx.cs" Inherits="SKT.LeanMES.Web.PieceWage.StationOutputRateEdit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <table width="100%" class="EditeContentTable">
        <tr><td colspan="2" class="Label"><%=Resources.Messages.WithAsteriskIsRequired %></td></tr>
        <tr>
            <td class="Label2"><%=Resources.lang.Station%><em>*</em></td>
            <td class="Field2" colspan="3">
                <asp:TextBox ID="txtStation" runat="server" CssClass="TextBox" Enabled="false" ClientIDMode="Static" Width="64%" IsRequired='1'></asp:TextBox><input type="button" id="Button1" class="ButtonBox" value="..." title="Select" onclick="openChoosePage(8);" />
                <asp:HiddenField ID="hdStationID" runat="server" Value="-1" ClientIDMode="Static" />
            </td>
        </tr>
        <tr>
            <td class="Label2"><%=Resources.lang.ProductType%><em>*</em></td>
            <td class="Field2" colspan="3">
                <asp:TextBox ID="txtProductType" runat="server" CssClass="TextBox" IsRequired='1' Enabled="false" ClientIDMode="Static" Width="64%"></asp:TextBox><input type="button" id="btnSelectProductType" class="ButtonBox" value="..." title="Select" onclick="openChoosePage(39);" />
                <asp:HiddenField ID="hdnProductTypeId" runat="server" Value="-1" ClientIDMode="Static" />
            </td>
        </tr>
        <tr>
            <td class="Label2"><%=Resources.lang.StartRate%><em>*</em></td>
            <td class="Field2" colspan="3">
                <asp:TextBox ID="txtStartRate" runat="server" isNumber="1" CssClass="TextBox" IsRequired='1' onkeyup="if(isNaN(value))execCommand('undo')" onafterpaste="if(isNaN(value))execCommand('undo')"></asp:TextBox>
            </td>
        </tr>
            <tr>
            <td class="Label2"><%=Resources.lang.EndRate%><em>*</em></td>
            <td class="Field2" colspan="3">
                <asp:TextBox ID="txtEndRate" runat="server" isNumber="1" CssClass="TextBox" IsRequired='1' onkeyup="if(isNaN(value))execCommand('undo')" onafterpaste="if(isNaN(value))execCommand('undo')"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2"><%=Resources.lang.Coefficient%><em>*</em></td>
            <td class="Field2" colspan="3">
                <asp:TextBox ID="txtCoefficient" runat="server" isNumber="1" CssClass="TextBox" IsRequired='1' onkeyup="if(isNaN(value))execCommand('undo')" onafterpaste="if(isNaN(value))execCommand('undo')"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2"><%= Resources.lang.Remark %></td>
            <td class="Field2" colspan="3">
                <asp:TextBox ID="txtRemark" Width="400px" Height="100px" runat="server" CssClass="TextBox"  MaxLength="500"></asp:TextBox>
            </td>
        </tr>
    </table>

    <script type="text/javascript">
        var StationOutputRateId = '<%=Request.QueryString["ID"]%>';
        /*保存数据*/
        function Save() {
            var txtStationId = $("#<%=this.hdStationID.ClientID%>").val();
            var txtProductType = $("#<%=this.txtProductType.ClientID%>").val();
            var hdnProductTypeId = $("#<%=this.hdnProductTypeId.ClientID%>").val();
            var txtStartRate = $("#<%=this.txtStartRate.ClientID%>").val();
            var txtEndRate = $("#<%=this.txtEndRate.ClientID%>").val();
            var txtCoefficient = $.trim($("#<%=this.txtCoefficient.ClientID%>").val());
            var txtRemark = $.trim($("#<%=this.txtRemark.ClientID%>").val());
            var username='<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';
            /*表单验证*/
            /*如需表单验证可以此处处理验证 开始*/
            var entity = {};
            entity.StationOutputRateId=StationOutputRateId;
            entity.StationID=txtStationId;
            entity.StartRate = txtStartRate;
            entity.EndRate = txtEndRate;
            entity.Coefficient = txtCoefficient;
            entity.CreateBy=username;
            entity.Remark = txtRemark;
            entity.ProductType=txtProductType;
            entity.ProductTypeID = hdnProductTypeId;

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPieceWage.StationOutputRateEdit(JSON.stringify(entity));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            alert('<%=Resources.Messages.SaveInSuccess%>')
            if ('<%=Request.QueryString["inMenu"] %>' == "true") {
                openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/PieceWage/StationOutputRateEdit.aspx?name=StationOutputRateEdit&ID=" + parseInt(ajax.value);
                location.href = openWinUrl;
            }
            else {
                parent.window.Refresh();
            }
        }

        var flag = 0;
        //选择视窗
        function openChoosePage(flags) {
            var condition = "";
            flag = flags;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=" + flags + "&Multiple=false&PageCondition=" + condition + "&rnd=" + Math.random(), width: 600, height: 300 });
        }

        //获取选择值
        function getChooseValue(list) {
            if (flag == 8) {
                $("#txtStation").val(list[0][1]);
                $("#hdStationID").val(list[0][0]);
            } else if (flag == 39) {
                $("#txtProductType").val(list[0][1]);
                $("#hdnProductTypeId").val(list[0][0]);
            }
            flag = -1;
        }
    </script>

</asp:Content>
