<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="True"
    CodeBehind="AccessoryEdit.aspx.cs" Inherits="SKT.LeanMES.Web.AccessoryManagement.AccessoryEdit" Title="Edit Accessory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %>
    </div>
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label2"><%= Resources.lang.Accessorie_BARCODE %><em>*</em></td>
            <td class="Field2">
                <asp:TextBox ID="txtSN" runat="server" CssClass="TextBox" MaxLength="50" IsRequired='1'></asp:TextBox>
            </td>
            <td class="Label2"><%= Resources.lang.AC_OBA_LotNo %></td>
            <td class="Field2">
                <asp:TextBox ID="txtLot" runat="server" CssClass="TextBox" MaxLength="50"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2"><%= Resources.lang.AccessoryCode %><em>*</em></td>
            <td class="Field2">
                <asp:TextBox ID="txtAccessoryName" runat="server" CssClass="TextBox" MaxLength="100" disabled="disabled" IsRequired='1'></asp:TextBox>
                <input type="button" class="ButtonBox" value="..." onclick="chooseAccessoryName()" id="btnAccessoryCode" />
                <asp:HiddenField ID="hAccessoryId" runat="server" Value="-1" />
            </td>
            <td class="Label2"><%= Resources.lang.AccessoryType %><em>*</em></td>
            <td class="Field2">
                <asp:Label runat="server" ID="textAccessoryType"></asp:Label>
                <asp:HiddenField ID="hAccessoryTypeId" runat="server" Value="-1" />
            </td>
        </tr>
        <tr>
            <td class="Label2"><%= Resources.lang.FSupplierName %><em>*</em></td>
            <td class="Field2">
                <asp:TextBox ID="txtSupplierCode" runat="server" CssClass="TextBox" MaxLength="50" disabled="disabled" IsRequired='1'></asp:TextBox>
                <input type="button" class="ButtonBox" value="..." onclick="chooseSupplier()" id="btnSupplierCode" />
                <asp:HiddenField ID="hSupplieCodeId" runat="server" Value="-1" />
            </td>
            <td class="Label2"><%= Resources.lang.LoseTime %><em>*</em></td>
            <td class="Field2">
                <asp:TextBox ID="txtLoseTime" runat="server" ReadOnly="true" IsRequired='1'></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2"><%= Resources.lang.ProdDateTime %><em>*</em></td>
            <td class="Field2">
                <asp:TextBox ID="txtProdDateTime" runat="server" ReadOnly="true" IsRequired='1'></asp:TextBox>
            </td>
            <td class="Label2"><%= Resources.lang.InStockQty %><em>*</em></td>
            <td class="Field2">
                <asp:TextBox ID="txtInStockQty" runat="server" CssClass="TextBox" IsNumber='1' IsRequired='1'></asp:TextBox>
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        var accessoryId = '<%=Request.QueryString["ID"]%>';
        $(function () {

            if (accessoryId != undefined && accessoryId != -1) {
                $("#btnAccessoryCode,#btnSupplierCode").hide();

            }

            //绑定日期选择框
            $("#<%=this.txtLoseTime.ClientID%>").datepicker({
                buttonImageOnly: true,
                showHms: true
            });

            //绑定生产日期选择框
            $("#<%=this.txtProdDateTime.ClientID%>").datepicker({
                buttonImageOnly: true,
                showHms: false
            });
        });
        //辅料
        function chooseAccessoryName() {
            flag = 0;
            chooseFlag = 504;
            pageCondition = "";
            dialog({ title: "", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Framework/ChoosePage.aspx?PageId=" + chooseFlag + "&PageCondition=" + pageCondition + "&Multiple=false&rnd=" + Math.random(), width: 650, height: 300 });
        }
        //供应商
        function chooseSupplier() {
            flag = 1;
            chooseFlag = 34;
            pageCondition = "";
            dialog({ title: "", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Framework/ChoosePage.aspx?PageId=" + chooseFlag + "&PageCondition=" + pageCondition + "&Multiple=false&rnd=" + Math.random(), width: 650, height: 300 });
        }
        function getChooseValue(list) {
            if (flag == 0) {
                $("#<%=this.txtAccessoryName.ClientID%>").val(list[0][2]);
                txtAccessoryCodoe = list[0][1];
                $("#<%=hAccessoryId.ClientID%>").val(list[0][1]);
                $("#<%=this.textAccessoryType.ClientID%>").html(list[0][3]);
                $("#<%=hAccessoryTypeId.ClientID%>").val(list[0][4]);
            } else if (flag == 1) {
                $("#<%=this.txtSupplierCode.ClientID%>").val(list[0][2]);
                SupplierCode = list[0][1];
                $("#<%=hSupplieCodeId.ClientID%>").val(list[0][1]);
                }
        }


        /*保存数据*/
        function Save() {
            var txtAccessoryName = $.trim($("#<%=this.txtAccessoryName.ClientID%>").val());
            var txtLot = $.trim($("#<%=this.txtLot.ClientID%>").val());
            var txtSerialNumber = $.trim($("#<%=this.txtSN.ClientID%>").val());
            var txtLoseTime = $("#<%=this.txtLoseTime.ClientID%>").val();
            
            var txtSupplierCode = $("#<%=hSupplieCodeId.ClientID%>").val();
            var txtProdDateTime = $("#<%=this.txtProdDateTime.ClientID%>").val();
            var txtInStockQty = $("#<%=this.txtInStockQty.ClientID%>").val();
            var txtCreateBy = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';

            var loseTime = new Date(Date.parse(txtLoseTime.replace(/-/g, "/")));
            if (loseTime <= new Date()) {
                alert("失效时间不能小于当前日期");
                return false;
            }
            /*表单验证*/
            /*如需表单验证可以此处处理验证 开始*/


            var entity = {};

            entity.AccessoryId = accessoryId
            entity.AccessoryCodoe = $("#<%=hAccessoryId.ClientID%>").val();
            entity.AccessoryName = txtAccessoryName;
            entity.Lot = txtLot;
            entity.SerialNumber = txtSerialNumber;
            entity.LoseTime = new Date(Date.parse(txtLoseTime.replace(/-/g, "/")));
            entity.SupplierCode = txtSupplierCode;
            entity.ProdDateTime = new Date(Date.parse(txtProdDateTime.replace(/-/g, "/")));
            entity.InStockQty = parseFloat(txtInStockQty);
            entity.CurrentQty = parseFloat(txtInStockQty);
            entity.CreateBy = txtCreateBy;
            entity.AccessoryType = $("#<%=hAccessoryTypeId.ClientID%>").val();
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxAccessory.AccessoryEdit(entity);
            //var ajax = SKT.LeanMES.Web.AjaxServices.AjaxAccessory.AccessoryEdit();
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
