<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    CodeBehind="PieceWageEdit.aspx.cs" Inherits="SKT.LeanMES.Web.PieceWage.PieceWageEdit" Title="Edit PieceWage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div class="infoTips">
        <%= Resources.Messages.WithAsteriskIsRequired %>
    </div>
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label2">编号<em>*</em></td>
            <td class="Field2" colspan="3">
                <asp:TextBox ID="txtNO" runat="server" CssClass="TextBox" IsRequired='1'></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">工序<em>*</em></td>
            <td class="Field2" colspan="3">
                <asp:TextBox ID="txtStation" runat="server" CssClass="TextBox" Enabled="false" ClientIDMode="Static" Width="64%" IsRequired='1'></asp:TextBox><input type="button" id="Button1" class="ButtonBox" value="..." title="Select" onclick="openChoosePage(8);" />
                <asp:HiddenField ID="hdStationID" runat="server" Value="-1" ClientIDMode="Static" />
            </td>
        </tr>
        <tr>
            <td class="Label2">设备</td>
            <td class="Field2" colspan="3">
                <asp:TextBox ID="txtEquipmentCode" runat="server" CssClass="TextBox" Enabled="false" ClientIDMode="Static" Width="64%"></asp:TextBox><input type="button" id="Button2" class="ButtonBox" value="..." title="Select" onclick="openChoosePage(54);" />
                <asp:HiddenField ID="hdEquipmentID" runat="server" Value="-1" ClientIDMode="Static" />
            </td>
        </tr>
        <tr>
            <td class="Label2">产品<em>*</em></td>
            <td class="Field2" colspan="3">
                <asp:TextBox ID="txtItemCode" runat="server" CssClass="TextBox" IsRequired='1' Enabled="false" ClientIDMode="Static" Width="64%"></asp:TextBox><input type="button" id="btnSelectItem" class="ButtonBox" value="..." title="Select" onclick="openChoosePage(1);" />
                <asp:HiddenField ID="hdnItemId" runat="server" Value="-1" ClientIDMode="Static" />
            </td>
        </tr>
        <tr>
            <td class="Label2">价格/个<em>*</em></td>
            <td class="Field2" colspan="3">
                <asp:TextBox ID="txtPrice" runat="server" CssClass="TextBox" IsRequired='1' onkeyup="if(isNaN(value))execCommand('undo')" onafterpaste="if(isNaN(value))execCommand('undo')"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2"><%= Resources.lang.Remark %></td>
            <td class="Field2" colspan="3">
                <asp:TextBox ID="txtRemark" Width="500px" runat="server" CssClass="TextBox"  MaxLength="500"></asp:TextBox>
            </td>
        </tr>
    </table>

    <script type="text/javascript">
        var pieceWageId = '<%=Request.QueryString["ID"]%>';
        /*保存数据*/
        function Save() {
            var txtStationId = $("#<%=this.hdStationID.ClientID%>").val();
            var txtEquipmentId = $("#<%=this.hdEquipmentID.ClientID%>").val();
            var txtItemId = $("#<%=this.hdnItemId.ClientID%>").val();
            var txtPrice = $("#<%=this.txtPrice.ClientID%>").val();
            var txtRemark = $.trim($("#<%=this.txtRemark.ClientID%>").val()); 
            var NO = $.trim($("#<%=this.txtNO.ClientID%>").val());
            if (NO == "") {
                alert("编号不能为空！");
                return false;
            }

            if (txtPrice == "") {
                alert("价格不能为空！");
                return false;
            }

            if (txtItemId == -1) {
                alert("产品不能为空！");
                return false;
            }
            /*表单验证*/
            /*如需表单验证可以此处处理验证 开始*/

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPieceWage.Edit(pieceWageId, txtStationId, txtEquipmentId, txtItemId, txtPrice, txtRemark, NO);
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
            } else if (flag == 1) {
                $("#txtItemCode").val(list[0][1]);
                $("#hdnItemId").val(list[0][0]);
            } else if (flag == 54) {
                $("#txtEquipmentCode").val(list[0][1]);
                $("#hdEquipmentID").val(list[0][0]);
            }
            flag = -1;
        }
    </script>

</asp:Content>