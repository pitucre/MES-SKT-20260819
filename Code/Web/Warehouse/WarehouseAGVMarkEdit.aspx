<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="True"
    CodeBehind="WarehouseAGVMarkEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Warehouse.WarehouseAGVMarkEdit" Title="Edit WarehouseAGVMarkEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %>
    </div>
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label2">AGV区域名称<em>*</em>
            </td>
            <td class="Field2" colspan="3">
                <asp:DropDownList ID="ddlAGVAreaName" runat="server" ClientIDMode="Static" IsRequired="1">
                </asp:DropDownList>
            </td>
        </tr>
        <tr class="LaneSort" style="display: none;">
            <td class="Label1">巷道顺序<em>*</em></td>
            <td class="Field1">
                <asp:TextBox ID="txtLaneSort" runat="server" CssClass="TextBox" MaxLength="50"  IsNumber='1'></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label1">AGV地标码<em>*</em></td>
            <td class="Field1">
                <asp:TextBox ID="txtAGVLandMarkCode" runat="server" CssClass="TextBox" MaxLength="50" IsRequired='1'></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label1">地标码顺序<em>*</em></td>
            <td class="Field1">
                <asp:TextBox ID="txtAGVLandMarkCodeSort" runat="server" CssClass="TextBox" MaxLength="50" IsNumber='1' IsRequired='1'></asp:TextBox>
            </td>
        </tr>
        <tr style="display: none">
            <td class="Label1">是否AGV发货位</td>
            <td class="Field1">
                <input id="cbAGVDeliveryLocation" type="checkbox" onclick="ChangeValue(this);" />
                <asp:HiddenField ID="hdnAGVDeliveryLocation" runat="server" />
            </td>
        </tr>
        <tr style="display: none">
            <td class="Label1">是否AGV发料位</td>
            <td class="Field1">
                <input id="cbAGVMaterialLocation" type="checkbox" onclick="ChangeValue1(this);" />
                <asp:HiddenField ID="hdnAGVMaterialLocation" runat="server" />
            </td>
        </tr>
        <tr>
            <td class="Label1">AGV状态</td>
            <td class="Field1">
                <asp:DropDownList ID="ddlStatus" runat="server">
                    <%--  <asp:ListItem Value="-1">--请选择--</asp:ListItem>--%>
                    <asp:ListItem Value="0">空闲</asp:ListItem>
                    <asp:ListItem Value="1">占用</asp:ListItem>
                    <asp:ListItem Value="2">停用</asp:ListItem>

                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="Label1">备注</td>
            <td class="Field1">
                <asp:TextBox ID="txtRemark" runat="server" CssClass="TextArea" TextMode="MultiLine" Height="55px" Width="99%"></asp:TextBox>
            </td>
        </tr>
    </table>

    <script type="text/javascript">
        var Id = '<%=Request.QueryString["ID"]%>';
        var cbAGVDeliveryLocationValue = false;
        var cbAGVMaterialLocationValue = false;
        var hdnAGVDeliveryLocation = $("#<%=this.hdnAGVDeliveryLocation.ClientID %>").val();
        var hdnAGVMaterialLocation = $("#<%=this.hdnAGVMaterialLocation.ClientID %>").val();
        var temp = 0;

        $(document).ready(function () {
            /*如果是编辑状态，关闭字段提示*/
            if (parseInt(Id) > 0) {
                if ($.trim($("#<%=this.ddlAGVAreaName.ClientID %>").val()) != "巷道") {
                    $(".LaneSort").hide();
                    $("#<%=this.txtLaneSort.ClientID %>").removeAttr("IsRequired")

                } else {
                    $(".LaneSort").show();
                    $("#<%=this.txtLaneSort.ClientID %>").attr("IsRequired", 1)
                }
                $(".Tips").hide();
            }
            //勾选还是没勾选
            if (hdnAGVDeliveryLocation === "True") {
                $("#cbAGVDeliveryLocation").attr("checked", true);
                cbAGVDeliveryLocationValue = true;
            }
            else {
                $("#cbAGVDeliveryLocation").attr("checked", false);
                cbAGVDeliveryLocationValue = false;
            }

            if (hdnAGVMaterialLocation === "True") {
                $("#cbAGVMaterialLocation").attr("checked", true);
                cbAGVMaterialLocationValue = true;
            }
            else {
                $("#cbAGVMaterialLocation").attr("checked", false);
                cbAGVMaterialLocationValue = false;
            }
            $("#<%=this.ddlAGVAreaName.ClientID %>").bind("change", function () {
                if (this.value == "巷道") {
                    $(".LaneSort").show();
                    $("#<%=this.txtLaneSort.ClientID %>").attr("IsRequired", 1)
                } else {
                    $(".LaneSort").hide();
                    $("#<%=this.txtLaneSort.ClientID %>").removeAttr("IsRequired")
                }
            });


        });
        function ChangeValue(obj) {
            if (obj.checked == true) {
                cbAGVDeliveryLocationValue = true;
                hdnAGVDeliveryLocation = 1;
            }
            else {
                cbAGVDeliveryLocationValue = false;
                hdnAGVDeliveryLocation = 0;
            }
        }

        function ChangeValue1(obj) {
            if (obj.checked == true) {
                cbAGVMaterialLocationValue = true;
                hdnAGVMaterialLocation = 1;
            }
            else {
                cbAGVMaterialLocationValue = false;
                hdnAGVMaterialLocation = 0;
            }
        }

        /*保存数据*/
        function Save() {
            var txtAGVLandMarkCode = $.trim($("#<%=this.txtAGVLandMarkCode.ClientID %>").val());
            var txtAGVAreaName = $.trim($("#<%=this.ddlAGVAreaName.ClientID %>").val());
            var txtAGVLandMarkCodeSort = $.trim($("#<%=this.txtAGVLandMarkCodeSort.ClientID %>").val());
            var txtAGVDeliveryLocation = cbAGVDeliveryLocationValue;
            var txtAGVMaterialLocation = cbAGVMaterialLocationValue;
            var txtRemark = $.trim($("#<%=this.txtRemark.ClientID %>").val());
            var txtLaneSort = $.trim($("#<%=this.txtLaneSort.ClientID %>").val());
            var ddlStatus = $.trim($("#<%=this.ddlStatus.ClientID %>").val());
            var strError = "";

            if (checkStrLen(txtAGVLandMarkCode, 50, false)) {
                strError += "<%= Resources.Messages.WarehouseCodeLength%>";
            }
            if (checkStrLen(txtAGVAreaName, 50), false) {
                strError += "<%= Resources.Messages.WarehouseNameLength%>";
            }
            if (checkStrLen(txtAGVLandMarkCodeSort, 50, false)) {
                strError += "<%= Resources.Messages.WarehouseAddressLength%>";
            }

           

            if (!isNull(strError)) {
                alert(strError.toString());
                return false;
            }
            var entity = {};

            entity.ID = Id;
            entity.AGVLandMarkCode = txtAGVLandMarkCode;
            entity.AGVAreaName = txtAGVAreaName;
            entity.AGVLandMarkCodeSort = txtAGVLandMarkCodeSort;
            entity.AGVDeliveryLocation = txtAGVDeliveryLocation;
            entity.AGVMaterialLocation = txtAGVMaterialLocation;
            entity.Remark = txtRemark;
            entity.LaneSort = txtLaneSort == "" ? 0 : txtLaneSort;
            entity.Statues = ddlStatus;

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxWarehouse.AgvEdit(entity);
            if (ajax.error == null) {
                alert('<%=Resources.Messages.SaveInSuccess%>')
                parent.window.UpdateList(txtAGVLandMarkCode);
            } else {
                alert(ajax.error.Message);
                return false;
            }
        }
    </script>

</asp:Content>
