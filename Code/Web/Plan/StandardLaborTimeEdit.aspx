<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    CodeBehind="StandardLaborTimeEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Plan.StandardLaborTimeEdit" %>

<%@ Import Namespace="Resources" %>
<%@ Import Namespace="SKT.LeanMES.Web" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <style type="text/css">
        .Label2 {
            width: 25%
        }
    </style>
    <div class="infoTips">
        <%= Resources.Messages.WithAsteriskIsRequired %>
    </div>
    <table width="100%" class="EditeContentTable">
        <tr style="display: none">
            <td class="Label2">标准工时类型<em>*</em>
            </td>
            <td class="Field2" colspan="3">
                <asp:RadioButton ID="radSMT" runat="server" ClientIDMode="Static" GroupName="radLaborTimeType" />
                <span>SMT</span>
                <asp:RadioButton ID="radNoSMT" runat="server" ClientIDMode="Static" GroupName="radLaborTimeType" Checked="true" />
                <span>非SMT</span>
            </td>
        </tr>
        <tr id="trLine">
            <td class="Label2">线别设备类型<em>*</em>
            </td>
            <td class="Field2" colspan="3">
                <asp:TextBox ID="txtEquipmentLineName" runat="server" ReadOnly="true" IsRequired="1" CssClass="TextBox" ClientIDMode="Static"
                    Width="90%">
                </asp:TextBox><input type="button" id="btnSelectItem" runat="server" class="ButtonBox"
                    value="..." title="Select" onclick="openChoosePage(501);" />
                <asp:HiddenField ID="hdnEquipmentLineId" runat="server" Value="-1" ClientIDMode="Static" />
            </td>
        </tr>
        <tr>
            <td class="Label2">产品编码<em>*</em>
            </td>
            <td class="Field2" colspan="3">
                <asp:TextBox ID="txtItemName" runat="server" ReadOnly="true" CssClass="TextBox" IsRequired="1" ClientIDMode="Static"
                    Width="90%">
                </asp:TextBox><input type="button" id="Button1" runat="server" class="ButtonBox"
                    value="..." title="Select" onclick="openChoosePage(1);" />
                <asp:HiddenField ID="hdnItemId" runat="server" Value="-1" ClientIDMode="Static" />
            </td>
        </tr>
        <tr id="trTableName">
            <td class="Label2">面别<em>*</em>
            </td>
            <td class="Field2">
                <asp:DropDownList ID="ddlTableName" runat="server" IsRequired="1">
                </asp:DropDownList>
            </td>
            <td class="Label2">拼板数
            </td>
            <td class="Field2">
                <asp:Label ID="lblPanelQty" ClientIDMode="Static" runat="server" Text=""></asp:Label>
            </td>

        </tr>
        <tr>
            <td class="Label2">标准工时(秒)<em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtStandardLaborTime" IsRequired="1" runat="server" ClientIDMode="Static" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label2">标准产能<em>*</em>
            </td>

            <td class="Field2">
                <asp:TextBox ID="txtStandardCapacity" IsRequired="1" ClientIDMode="Static" runat="server" Text="0" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
        <tr style="display:none">
            <td class="Label2">瓶颈工时(秒)
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtBottleneckHours" IsRequired="0" runat="server" ClientIDMode="Static" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label2"></td>

            <td class="Field2"></td>
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.Remark %>
            </td>
            <td class="Field2" colspan="3">
                <asp:TextBox ID="txtRemark" runat="server" TextMode="MultiLine" CssClass="TextArea"
                    MaxLength="300" Width="90%"></asp:TextBox>
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        var standardLaborTimeId = '<%=Request.QueryString["ID"]%>';
        var flag = 0;

        $().ready(function () {
            $("#txtStandardCapacity").keyup(function () {
                getIntVal(this);
            });
            $("#txtStandardLaborTime,#txtBottleneckHours").keyup(function () {
                getDecimalVal(this);
            });
            $("#radSMT").click(function () {
                $("#trLine,#trTableName").show();
                $("#txtEquipmentLineName,#ddlTableName").attr("IsRequired", "1");
            });

            $("#radNoSMT").click(function () {
                $("#trLine,#trTableName").hide();
                $("#txtEquipmentLineName,#ddlTableName").attr("IsRequired", "0");
            });

            if ($("#radNoSMT").prop("checked")) {
                $("#radNoSMT").click();
            }

        });

        /*保存数据*/
        function Save() {

            var txtEquipmentLineId = $("#<%=this.hdnEquipmentLineId.ClientID%>").val();
            var txtItemId = $("#<%=this.hdnItemId.ClientID%>").val();
            var txtTableName = $.trim($("#<%=this.ddlTableName.ClientID%>").val());
            var txtStandardLaborTime = $("#<%=this.txtStandardLaborTime.ClientID%>").val();
            var txtStandardCapacity = $("#<%=this.txtStandardCapacity.ClientID%>").val();
            var txtRemark = $.trim($("#<%=this.txtRemark.ClientID%>").val());
            var laborTimeType = 1;
            var txtBottleneckHours = $("#<%=this.txtBottleneckHours.ClientID%>").val();

            if ($("#radNoSMT").prop("checked")) {
                laborTimeType = 2;
                txtTableName = "";
            }

            /*表单验证*/
            /*如需表单验证可以此处处理验证 开始*/


            var entity = {};

            entity.StandardLaborTimeId = standardLaborTimeId;
            entity.LaborTimeType = laborTimeType;
            entity.EquipmentLineId = txtEquipmentLineId;
            entity.ItemId = txtItemId;
            entity.TableName = txtTableName;
            entity.StandardLaborTime = parseFloat(txtStandardLaborTime);
            entity.StandardCapacity = parseFloat(txtStandardCapacity);
            entity.Remark = txtRemark;
            entity.BottleneckHours = parseFloat(txtBottleneckHours);

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxStandardLaborTime.StandardLaborTimeEdit(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            alert('<%=Resources.Messages.SaveInSuccess%>')
            parent.window.Refresh();

        }

        function openChoosePage(flags) {
            var condition = "";
            flag = flags;
            dialog({
                title: "<%= Common.ChooseWindow %>",
                src: "<%= WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=" +
                    flags +
                    "&Multiple=false&SearchCondition=" +
                    condition +
                    "&rnd=" +
                    Math.random(),
                width: 680,
                height: 300
            });
        }

        function getChooseValue(list) {
            if (flag == 1) {
                $("#txtItemName").val(list[0][2]);
                $("#hdnItemId").val(list[0][0]);
                getPalneQty(list[0][0]);
            }
            else if (flag == 501) {
                $("#txtEquipmentLineName").val(list[0][1]);
                $("#hdnEquipmentLineId").val(list[0][0]);
            }
        }

        /**
        *获取拼版数量
        **/
        function getPalneQty(itemId) {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxProduct.GetItemByItem(itemId);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            if (ajax.value.ChildrenNumber != null) {
                $("#lblPanelQty").text(ajax.value.ChildrenNumber * ajax.value.ParentNumber);
            }
        }
    </script>
</asp:Content>
