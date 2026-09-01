<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="True"
    CodeBehind="WarehouseLocationEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Warehouse.WarehouseLocationEdit"
    Title="Edit WarehouseLocation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %></div>
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label2">
                <%= Resources.lang.WarehouseInfo%><em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtWhInfo" runat="server" CssClass="TextBox" MaxLength="20" Enabled="false"
                    IsRequired='1' ClientIDMode="Static"> 
                </asp:TextBox><input type="button" id="btnselectWhInfo" class="ButtonBox" value="..."
                    title="Select" onclick="selectWhInfo();" />
                <asp:HiddenField ID="hdnWhID" runat="server" Value="-1" ClientIDMode="Static" />
                <asp:HiddenField ID="hdnWhCode" runat="server" Value="" ClientIDMode="Static" />
            </td>
            <td class="Label2">
                <%= Resources.lang.WarehouseTypeName%><em>*</em>
            </td>
            <td class="Field2">
                <asp:DropDownList ID="ddlWarehouseProperty" IsRequired='1' runat="server">
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.WarehouseStorageCode%><em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtScode" runat="server" IsRequired='1' CssClass="TextBox" MaxLength="20">
                </asp:TextBox>
            </td>
            <td class="Label2">
                <%= Resources.lang.WarehouseStorageName%><em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtSname" runat="server" IsRequired='1' CssClass="TextBox" MaxLength="50"> 
                </asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.WarehouseGoodsCode%><em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtPcode" runat="server" IsRequired='1' CssClass="TextBox" MaxLength="20"> 
                </asp:TextBox>
            </td>
            <td class="Label2">
                <%= Resources.lang.WarehouseGoodsName%><em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtPname" runat="server" IsRequired='1' CssClass="TextBox" MaxLength="50">
                </asp:TextBox>
            </td>
        </tr>
        <tr style="display:none">
            <td class="Label2">
                <%= Resources.lang.WarehouseIssueOrder%>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtMOrder" runat="server" Text="0" CssClass="TextBox" IsNumber='1'
                    MaxLength="18"></asp:TextBox>
            </td>
            <td class="Label2">
                <%= Resources.lang.WarehouseDeliveryOrder%>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtPOrder" runat="server" Text="0" CssClass="TextBox" IsNumber='1'
                    MaxLength="18"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.StorageInOrder%>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtInOrder" runat="server" Text="0" CssClass="TextBox" IsNumber='1'
                    MaxLength="18"></asp:TextBox>
            </td>
            <td class="Label2">
                <%= Resources.lang.AGVLandmarkCode%>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtAGVLandmarkCode" runat="server" Text="0" CssClass="TextBox"
                    MaxLength="18"></asp:TextBox>
            </td>
        </tr>
        <tr style="display:none">
            <td class="Label2">
                <%= Resources.lang.WarehouseCodeLevel%>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtGrade" runat="server" Text="0" CssClass="TextBox" IsNumber='1'
                    MaxLength="18"></asp:TextBox>
            </td>
            <td class="Label2">
                <%= Resources.lang.WarehouseLastLevel%>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtPosEnd" runat="server" Text="0" CssClass="TextBox" IsNumber='1'
                    MaxLength="18"></asp:TextBox>
            </td>
        </tr>
        <tr style="display:none">
            <td class="Label2">
                <%= Resources.lang.MaximumVolume%>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtMaxCubage" runat="server" Text="0" CssClass="TextBox" IsNumber='1'
                    MaxLength="18"></asp:TextBox>
            </td>
            <td class="Label2">
                <%= Resources.lang.MaximumWeight%>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtMaxWeight" runat="server" Text="0" CssClass="TextBox" IsNumber='1'
                    MaxLength="18"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                存放产品唯一
            </td>
            <td class="Field2">
                <asp:DropDownList ID="ddlProductIsOnly" runat="server">
                </asp:DropDownList>
            </td>
            <td class="Label2">
                货位类型
            </td>
            <td class="Field2">
                <select id="sltLoctionType" runat="server">
                    <option selected="selected" value="基础货架">基础货架</option>
                    <option value="电子料架">电子料架</option>
                    <option value="AGV">AGV</option>
                </select>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                
            </td>
            <td class="Field2">
               <asp:TextBox ID="txtShiftCode" runat="server"  CssClass="TextBox" 
                    MaxLength="50" Visible="false" ></asp:TextBox>
            </td>
            <td class="Label2"> 
                台车存放货位              
            </td>
            <td class="Field2"> 
                <select id="sltUni_pak" runat="server">
                    <option selected="selected" value="1">是</option>
                    <option value="0">否</option>
                </select>               
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.Description%>
            </td>
            <td class="Field2" colspan="3">
                <asp:TextBox ID="txtRemark" runat="server" CssClass="TextArea" TextMode="MultiLine"
                    MaxLength="100" Height="55px" Width="80%">
                </asp:TextBox>
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        var warehouseLocationId = '<%=Request.QueryString["ID"]%>';
        var flag = -1;

        $(function () {
            /*如果是编辑状态，关闭字段提示*/
            if (parseInt(warehouseLocationId) > 0) {
                $(".Tips").hide();
            }

            $("#btnSubmit").click(function () {
                Save();
            });
        });

        function selectWhInfo() {
            flag = 1
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=14&Multiple=false&rnd=" + Math.random(), width: 600, height: 360 });
        }

        function getChooseValue(list) {
            switch (flag) {
                case 1:
                    if (list[0][0] != "-1") {
                        $("#txtWhInfo").val(list[0][1] + "|" + list[0][2]);
                    }
                    else {
                        $("#txtWhInfo").val("");
                    }
                    $("#hdnWhID").val(list[0][0]);
                    $("#hdnWhCode").val(list[0][1]);
                    break;
                case 2:
                    break;
                default:
                    flag = -1;
                    break;
            }

            flag = -1;
        }

        /*保存数据*/
        function Save() {
            var txtScode = $("#<%=this.txtScode.ClientID%>").val().trim();
            var txtSname = $("#<%=this.txtSname.ClientID%>").val().trim();

            var txtPcode = $("#<%=this.txtPcode.ClientID%>").val().trim();
            var txtPname = $("#<%=this.txtPname.ClientID%>").val().trim();

            var ddlProperty = $("#<%=this.ddlWarehouseProperty.ClientID %>").val();
            var ddlProductIsOnly = $("#<%=this.ddlProductIsOnly.ClientID %>").val();

            var txtMOrder = $("#<%=this.txtMOrder.ClientID%>").val().trim();
            var txtPOrder = $("#<%=this.txtPOrder.ClientID%>").val().trim();

            var txtInOrder = $("#<%=this.txtInOrder.ClientID%>").val().trim();
            var txtAGVLandmarkCode = $("#<%=this.txtAGVLandmarkCode.ClientID%>").val().trim();

            var txtGrade = $("#<%=this.txtGrade.ClientID%>").val().trim();
            var txtPosEnd = $("#<%=this.txtPosEnd.ClientID%>").val().trim();

            var txtMaxCubage = $("#<%=this.txtMaxCubage.ClientID%>").val().trim();
            var txtMaxWeight = $("#<%=this.txtMaxWeight.ClientID%>").val().trim();

            var txtRemark = $("#<%=this.txtRemark.ClientID%>").val().trim();

            txtCreateBy = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';
            txtModifyBy = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';

            var txtLocationType = $("#<%=this.sltLoctionType.ClientID %>").val();
            var txtShiftCode ="";

            var strError = "";
            if (checkStrLen(txtGrade, 4, false)) {
                strError += "<%= Resources.Messages.PrintNumberLength%>";
            }
            if (checkStrLen(txtPosEnd, 4), false) {
                strError += "<%= Resources.Messages.PrintNumberLength%>";
            }
            if (!isNull(strError)) {
                alert(strError.toString());
                return false;
            }

            var sltUni_pak = $("#<%=this.sltUni_pak.ClientID %>").val();

            var entity = {};

            entity.WarehouseLocationId = warehouseLocationId
            entity.CStoreCode = txtScode;
            entity.CStoreName = txtSname;
            entity.CPosCode = txtPcode;
            entity.CPosName = txtPname;
            entity.CProperty = ddlProperty;
            entity.WMSWarehouseId = $("#hdnWhID").val();
            entity.CWhCode = $("#hdnWhCode").val();
            entity.MOrder = txtMOrder;
            entity.POrder = txtPOrder;
            entity.InOrder = txtInOrder;
            entity.AGVLandmarkCode = txtAGVLandmarkCode;
            entity.IPosGrade = parseInt(txtGrade);
            entity.BPosEnd = parseInt(txtPosEnd);
            entity.CBarCode = txtScode;
            entity.IMaxCubage = parseFloat(txtMaxCubage);
            entity.IMaxWeight = parseFloat(txtMaxWeight);
            entity.CreateBy = txtCreateBy;
            entity.ModifyBy = txtModifyBy;
            entity.Remark = txtRemark;
            entity.ProductIsOnly = ddlProductIsOnly;
            entity.LocationType = txtLocationType;
            entity.ShiftCode = txtShiftCode;
            entity.IsUniPakPos = sltUni_pak;

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxWarehouse.WarehouseLocationEdit(entity);
            if (ajax.error == null) {
                alert('<%=Resources.Messages.SaveInSuccess%>')
                parent.window.UpdateList();
            } else {
                alert(ajax.error.Message);
                return false;
            }
        }
    </script>
</asp:Content>
