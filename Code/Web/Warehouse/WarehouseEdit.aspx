<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="True"
    CodeBehind="WarehouseEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Warehouse.WarehouseEdit" Title="Edit Warehouse" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
     <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %></div>
    <table width="100%" class="EditeContentTable">        
        <tr>
            <td class="Label2"><%= Resources.lang.WarehouseCode%><em>*</em></td>
            <td class="Field2">
                <asp:TextBox ID="txtWareHouseCode" runat="server" CssClass="TextBox"  MaxLength="10" IsRequired='1'></asp:TextBox>
            </td>
            <td class="Label2"><%= Resources.lang.WarehouseName%><em>*</em></td>
            <td class="Field2">
                <asp:TextBox ID="txtWhName" runat="server" CssClass="TextBox"  MaxLength="20" IsRequired='1'></asp:TextBox>
            </td>
        </tr>
         <tr>
            <td class="Label2"><%= Resources.lang.Principal%></td>
            <td class="Field2">
                <asp:TextBox ID="txtWhPerson" runat="server" CssClass="TextBox" Enabled="false" ReadOnly ="true"></asp:TextBox><input
                    type="button" id="btnSelectPerson" class="ButtonBox" value="..." onclick="selectSupervisor()" />
                <asp:HiddenField ID="hdnSelectPersonId" runat="server" Value="-1" />
            </td>
            <td class="Label2"><%= Resources.lang.DepartmentName%></td>
            <td class="Field2">
                  <asp:TextBox ID="txtDepCode" runat="server" CssClass="TextBox" Enabled="false" ReadOnly ="true"></asp:TextBox><input
                    type="button" id="btnSelectDepCode" class="ButtonBox" value="..." onclick="selectDepCode()" />
                <asp:HiddenField ID="hdnDepCode" runat="server" Value="-1" />
            </td>
        </tr>

        <tr>
            <td class="Label2"><%= Resources.lang.WarehouseTypeName%></td>
            <td class="Field2">
                  <asp:TextBox ID="txtWhType" runat="server" CssClass="TextBox" Enabled="false" ReadOnly ="true"></asp:TextBox><input
                    type="button" id="btnWhType" class="ButtonBox" value="..." onclick="selectWhType()" />
                   <asp:HiddenField ID="hdnWhType" runat="server" Value="-1" />
            </td>
            <td class="Label2"><%= Resources.lang.WarehouseAddress%></td>
            <td class="Field2">
                <asp:TextBox ID="txtAddress" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">
               <%= Resources.lang.Telephone%>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtPhone" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label2">
            </td>
            <td class="Field2">
            </td>
        </tr>
        <tr>
            <td class="Label2"><%= Resources.lang.WarehouseIsGoods%></td>
            <td class="Field2">
                <input id="cbStorage" type="checkbox" onclick="ChangeValue(this);" />
                <asp:HiddenField ID="hdnStorageValue" runat="server" />
            </td>
            <td class="Label2">
            </td>
            <td class="Field2">
            </td>
        </tr>
        <tr>
            <td class="Label2"> <%= Resources.lang.Description%></td>
            <td class="Field2" colspan="3">
                <asp:TextBox ID="txtDescription" runat="server" CssClass="TextArea" TextMode="MultiLine"
                    Height="55px" Width="99%"></asp:TextBox>
            </td>
        </tr>
    </table>

    <script type="text/javascript">
        var warehouseId = '<%=Request.QueryString["ID"]%>';
        var cbStorageValue = false;
        var hdnStorageValue = $("#<%=this.hdnStorageValue.ClientID %>").val();
        var temp = 0;

        $(document).ready(function () {
            /*如果是编辑状态，关闭字段提示*/
            if (parseInt(warehouseId) > 0) {
                $(".Tips").hide();
            }
            //勾选还是没勾选
            if (hdnStorageValue == 1) {
                $("#cbStorage").attr("checked", true);
                cbStorageValue = true;
            }
            else {
                $("#cbStorage").attr("checked", false);
                cbStorageValue = false;
            }
        });
        function ChangeValue(obj) {
            if (obj.checked == true) {
                cbStorageValue = true;
                hdnStorage = 1;
            }
            else {
                cbStorageValue = false;
                hdnStorage = 0;
            }
        }

        /*保存数据*/
        function Save() 
        {
            var txtWareHouseCode = $("#<%=this.txtWareHouseCode.ClientID %>").val();
            var txtWhName = $("#<%=this.txtWhName.ClientID %>").val();
            var txtPersion = $("#<%=this.hdnSelectPersonId.ClientID %>").val();
            var txtDept = $("#<%=this.hdnDepCode.ClientID %>").val();
            var txtAddress = $("#<%=this.txtAddress.ClientID %>").val();
            var txtPhone = $("#<%=this.txtPhone.ClientID %>").val();
            var whType = $("#<%=this.hdnWhType.ClientID %>").val();
            var ckbPos = cbStorageValue;
            var txtDescription = $("#<%=this.txtDescription.ClientID %>").val();
          
            var strError = "";
            if (checkStrLen(txtWareHouseCode, 10, false)) {
                strError += "<%= Resources.Messages.WarehouseCodeLength%>";
            }
            if (checkStrLen(txtWhName, 20), false) {
                strError += "<%= Resources.Messages.WarehouseNameLength%>";
            }
            if (checkStrLen(txtAddress, 30, false)) {
                strError += "<%= Resources.Messages.WarehouseAddressLength%>";
            }
            if (checkStrLen(txtPhone, 20, false)) {
                strError += "<%= Resources.Messages.TelephoneLength%>";
            }
            if (checkStrLen(txtDescription, 20, false)) {
                strError += "<%= Resources.Messages.DescriptionError%>";
            }
            if (!isNull(strError)) {
                alert(strError.toString());
                return false;
            }
            var entity = {};
            entity.WarehouseId = warehouseId
            entity.CWhCode = txtWareHouseCode;
            entity.CWhName = txtWhName
            entity.CWhPerson = txtPersion;
            entity.CDepCode = txtDept;
            entity.CWhAddress = txtAddress;
            entity.IWHProperty = whType;
            entity.BWhPos = ckbPos;
            entity.CWhMemo = txtDescription;
            entity.CcWhPhone = txtPhone;
            entity.CBarCode = "0";
            entity.BFreeze = false;
            entity.CycleCount = "0";
            entity.CFrequency = "0";
            entity.CreateBy = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>";
            entity.ModifyBy = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxWarehouse.WarehouseEdit(entity);
            if (ajax.error == null) {
                alert('<%=Resources.Messages.SaveInSuccess%>')
                parent.window.UpdateList(txtWhName);   
            }else {
                alert(ajax.error.Message);
                return false;
            }
        }
        function selectSupervisor() {
            temp = 1;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=12&Multiple=false&rnd=" + Math.random(), width: 650, height: 300 });
        }
        function selectDepCode() {
            temp = 2;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=13&Multiple=false&rnd=" + Math.random(), width: 650, height: 300 });
        }
        function selectWhType() {
            temp = 3;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=11&Multiple=false&rnd=" + Math.random(), width: 550, height: 300 });
        }
        function getChooseValue(list) {
            if (temp == 1) {
                $("#<%=this.txtWhPerson.ClientID %>").val(list[0][2] + "|" + list[0][3] + "(" + list[0][1] + ")");
                $("#<%=this.hdnSelectPersonId.ClientID %>").val(list[0][0]);
            }
            else if (temp == 2) {
                $("#<%=this.txtDepCode.ClientID %>").val(list[0][2] + "|" + list[0][1]);
                $("#<%=this.hdnDepCode.ClientID %>").val(list[0][0]);
            }
            else if (temp == 3) {
                $("#<%=this.txtWhType.ClientID %>").val(list[0][1] + "|" + list[0][0]);
                $("#<%=this.hdnWhType.ClientID %>").val(list[0][0]);
            }
            temp = 0;
        }
    </script>

</asp:Content>