<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master"
    AutoEventWireup="true" CodeBehind="FixedBarcodeEdit.aspx.cs" Inherits="SKT.LeanMES.Web.ProductionDataConfig.FixedBarcodeEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label1">配置类型<em>*</em>
            </td>
            <td class="Field1">
                <asp:DropDownList runat="server" ID="ddlConfigType" ClientIDMode="Static">
                    <asp:ListItem Value="-1">请选择</asp:ListItem>
                    <asp:ListItem Value="903">SMT是否启动Feeder扫描</asp:ListItem>
                    <asp:ListItem Value="904">SMT物料预警时间（单位：分钟）</asp:ListItem>
                    <asp:ListItem Value="905">报废是否算产出</asp:ListItem>
                    <asp:ListItem Value="906">产品最大不良维修次数</asp:ListItem>
                    <asp:ListItem Value="900">NG字符串</asp:ListItem>
                    <asp:ListItem Value="901">OK字符串</asp:ListItem>
                    <asp:ListItem Value="902">用户名</asp:ListItem>
                    <asp:ListItem Value="907">排产需要检查齐套</asp:ListItem>
                    <asp:ListItem Value="908">GRN转移检查制造日期</asp:ListItem>
                    <asp:ListItem Value="909">GRN转移检查批次号</asp:ListItem>
                    <asp:ListItem Value="910">排产确认是否校验领料单</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr id="showMaterialPrint">
            <td class="Label1">配置数据
            </td>
            <td class="Field1" id="comm">
                <asp:TextBox runat="server" ID="txtConfigResult" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Field1" id="showDropDownList" style="display: none">
                <asp:DropDownList runat="server" ID="txtConfigResults">
                    <asp:ListItem Value="是">是</asp:ListItem>
                    <asp:ListItem Value="否">否</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="Label1">备注
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtRemark" runat="server" CssClass="TextArea" TextMode="MultiLine"></asp:TextBox>
            </td>
        </tr>


    </table>
    <script type="text/javascript">
        var materialSysConfigId = '<%=Request.QueryString["ID"]%>';
        var name = '<%=Request.QueryString["value"]%>';
        $(function () {
            if (name == 'SMT是否启动Feeder扫描'
                || name == '报废是否算产出'
                || name == "排产需要检查齐套"
                || name == "GRN转移检查制造日期"
                || name == "GRN转移检查批次号"
                || name == "排产确认是否校验领料单") {
                Show();
            }
            $("#<%=this.ddlConfigType.ClientID%>").change(function () {
                Show();
            });
        });
        var Show = function () {
            var dropDownList = $("#<%=this.ddlConfigType.ClientID%>").val();
            if (dropDownList == 903
                || dropDownList == 905
                || dropDownList == 907
                || dropDownList == 908
                || dropDownList == 909
                || dropDownList == 910) {
                $("#comm").css("display", "none");
                $("#showDropDownList").removeAttr("style");
                //$("#showMaterialPrint td:eq(1)").html('');
                //var hl = '<select id="txtConfigResult"><option value="是">是</option><option value="否">否</option></select>';
                //$("#showMaterialPrint td:eq(1)").html(hl);
            } else {
                $("#comm").removeAttr("style");
                $("#showDropDownList").css("display", "none");
            }
        }


        /*保存数据*/
        function Save() {
            var txtID = $("#ddlConfigType").val() * 1;
            var txtConfigType = $("#ddlConfigType").find(":selected").text();
            var txtRemark = $.trim($("#<%=this.txtRemark.ClientID%>").val());
            var txtIsGlobal = 1;
            var txtConfigResult;
            if ($("#showDropDownList:hidden").length > 0) {
                txtConfigResult = $("#<%=this.txtConfigResult.ClientID%>").val();
            } else {
                txtConfigResult = $("#<%=this.txtConfigResults.ClientID%>").val();
            }

            if (txtConfigType == -1) {
                alert("请选择配置类型!");
                return false;
            }
            var txtConfigDesc = "固定条码枪";
            /*表单验证*/
            /*如需表单验证可以此处处理验证 开始*/
            var userName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";

            var entity = {};

            entity.ID = materialSysConfigId;
            entity.ConfigTypeId = txtID;
            entity.ConfigType = txtConfigType;
            entity.ConfigResult = txtConfigResult;
            entity.ConfigDesc = txtConfigDesc;
            entity.IsGlobal = Boolean(txtIsGlobal);
            entity.Remark = txtRemark;
            entity.UserName = userName;
            entity.Moudle = 1;

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialConfig.MaterialSysConfigEdit(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            alert('<%=Resources.Messages.SaveInSuccess%>');
            parent.window.UpdateList(txtID);
        }
    </script>
</asp:Content>
