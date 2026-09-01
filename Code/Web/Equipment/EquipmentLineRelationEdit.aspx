<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="True"
    CodeBehind="EquipmentLineRelationEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Equipment.EquipmentLineRelationEdit" Title="Edit EquipmentLineRelation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %>
    </div>
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label2"><%= Resources.lang.EquipmentType %></td>
            <td class="Field2" colspan="3">
                <input type="text" runat="server" id="txtMachineType" class="TextBox" disabled="disabled" />
                <input type="button" id="Button1" class="ButtonBox" value="..." onclick="selectMAType()" />
            </td>
        </tr>
        <tr>
            <td class="Label2"><%= Resources.lang.EquipmentLineType %><em>*</em></td>
            <td class="Field2" colspan="3">
                <b><span id="txtMachineTypes" style="width: 420px" runat="server"></span></b>
            </td>
        </tr>
        <tr>
            <td class="Label2"><%= Resources.lang.EquipmentLineDisplayName %><em>*</em></td>
            <td class="Field2">
                <asp:TextBox ID="txtEquipmentLineDisplayName" runat="server" CssClass="TextBox" MaxLength="200" IsRequired='1'></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2"><%= Resources.lang.Remark %></td>
            <td class="Field2" colspan="3">
                <asp:TextBox ID="txtRemark" runat="server" CssClass="TextArea" TextMode="MultiLine" MaxLength="200"></asp:TextBox>
            </td>
        </tr>
    </table>
    <script type="text/javascript" src="../Content/js/jquery-3.1.0.min.js"></script>
    <script type="text/javascript">
        var EquipmentLineId = '<%=Request.QueryString["ID"]%>';
        var flag = 0;
        if (EquipmentLineId != -1) {

        }
        function selectMAType() {
            flag = 1;
            searchCondition = ' IsLoading=1 '
            //Modify By Alen Liu 2017-07-06 PageId=202 由于和8.5.0冲突，8.5.1 PageId 从500开始 PageId=500 
            dialog({
                title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=500&PageCondition="
                    + escape(searchCondition) + "&Multiple=false&rnd=" + Math.random(), width: 600, height: 300
            });
        }
        function getChooseValue(list) {
            $("#<%=txtMachineType.ClientID%>").val(list[0][1]);
            var machineTypes = $.trim($("#<%=txtMachineTypes.ClientID%>").html());
            if (machineTypes == "") {
                $("#<%=txtMachineTypes.ClientID%>").html(list[0][1]);
            }
            else {
                $("#<%=txtMachineTypes.ClientID%>").html(machineTypes + "," + list[0][1]);
            }
        }
        /*保存数据*/
        function Save() {
            var txtEquipmentLineType = $.trim($("#<%=txtMachineTypes.ClientID%>").html());
            var txtEquipmentLineDisplayName = $.trim($("#<%=this.txtEquipmentLineDisplayName.ClientID%>").val());
            var txtCreateBy = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';
            var txtRemark = $.trim($("#<%=this.txtRemark.ClientID%>").val());
            if (txtEquipmentLineType == '') {
                alert("线别设备类型不能为空");
                return false;
            }
            if (txtEquipmentLineDisplayName == '') {
                alert("线别设备类型名称不能为空");
                return false;
            }
            /*表单验证*/
            /*如需表单验证可以此处处理验证 开始*/

            var entity = {};

            entity.EquipmentLineId = EquipmentLineId
            entity.EquipmentLineType = txtEquipmentLineType;
            entity.EquipmentLineDisplayName = txtEquipmentLineDisplayName;
            entity.LineId = 0;
            entity.CreateBy = txtCreateBy;
            entity.UpdateBy = txtCreateBy;
            entity.Remark = txtRemark;

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEquipmentLineRelation.EquipmentLineRelationEdit(entity);
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
