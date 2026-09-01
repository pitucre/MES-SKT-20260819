<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="True"
    CodeBehind="WarehouseCpInConfigEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Warehouse.WarehouseCpInConfigEdit"
    Title="Edit WarehouseCpInConfig" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %>
    </div>
    <table width="100%" class="EditeContentTable">
        <tr id="configname">
            <td class="Label2">
                <%= Resources.lang.ConfigName %>
            </td>
            <td class="Field2">
                <asp:DropDownList runat="server" ID="ddlConfigName" ClientIDMode="Static">
                 <%--   <asp:ListItem Value="1">是否启用PDA入库扫描</asp:ListItem>--%>
                    <%--<asp:ListItem Value="2">选择PDA入库扫描单据类型</asp:ListItem>--%>
                    <%--<asp:ListItem Value="3">是否启用FQC</asp:ListItem>--%>
                    <asp:ListItem Value="4">是否启用PDA备货扫描</asp:ListItem>
                    <%--<asp:ListItem Value="5">是否启用OQC</asp:ListItem>--%>
                    <asp:ListItem Value="6">默认库位设置</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr id="isconfig">
            <td class="Label2">
                <%= Resources.lang.ConfigDesc %>
            </td>
            <td class="Field2">
                <asp:DropDownList runat="server" ID="ddltxtConfigDesc" ClientIDMode="Static">
                    <asp:ListItem Value="0">是</asp:ListItem>
                    <asp:ListItem Value="1">否</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr id="pdatype" style="display: none">
            <td class="Label2">
                <%= Resources.lang.ConfigDesc %>
            </td>
            <td class="Field2">
                <asp:DropDownList runat="server" ID="DropDownList1" ClientIDMode="Static">
                    <asp:ListItem Value="1">无单入库</asp:ListItem>
                    <asp:ListItem Value="2">工单入库</asp:ListItem>
                    <asp:ListItem Value="3">FQC单入库</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr id="stationCon" style="display: none">
            <td class="Label2">默认库位
            </td>
            <td class="Field2">
                <asp:TextBox ID="stationConValue" runat="server" CssClass="TextBox" MaxLength="200"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.Remark %>
            </td>
            <td class="Field2" colspan="3">
                <asp:TextBox ID="txtRemark" runat="server" CssClass="TextBox" MaxLength="200"></asp:TextBox>
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        var warehouseCpInConfigId = '<%=Request.QueryString["ID"]%>';
        $(document).ready(function () {
            if ($("#ddlConfigName").val() == "2") {
                $("#pdatype").show();
                $("#isconfig").hide();
            } else if ($("#ddlConfigName").val() == "6") {
                $("#stationCon").show();
                $("#pdatype").hide();
                $("#isconfig").hide();
            } else {
                $("#pdatype").hide();
                $("#isconfig").show();
            }
            //PDA配置事件
            $("#ddlConfigName").bind("change", function () {
                if ($("#ddlConfigName").val() == "2") {
                    $("#pdatype").show();
                    $("#isconfig").hide();
                    $("#stationCon").hide();
                } else if ($("#ddlConfigName").val() == "6") {
                    $("#stationCon").show();
                    $("#pdatype").hide();
                    $("#isconfig").hide();
                } else {
                    $("#pdatype").hide();
                    $("#isconfig").show();
                    $("#stationCon").hide();
                }
            });
        });
        /*保存数据*/
        function Save() {
            var List = [];
            
            var txtConfigId = $("#ddlConfigName").val();
            var txtConfigName = $("#ddlConfigName").find(":selected").text();
            var txtConfigType = $("#ddltxtConfigDesc").val();
            var txtConfigDesc = $("#ddltxtConfigDesc").find(":selected").text();
            var txtRemark = $.trim($("#<%=this.txtRemark.ClientID%>").val());
            if (txtConfigId == 2) {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxWarehouseCpInConfig.IsPDAOpen();
                if (ajax.error != null) {
                    alert(ajax.error == null ? ajax.value.error : ajax.error);
                    return false;
                }
                if (ajax.value != null && ajax.value != "") {
                    var cc = $.parseJSON(ajax.value);
                    if (cc.error != null) {
                        alert(cc.error);
                        return false;
                    }
                }
               
                //PDA信息
                txtConfigType = $("#pdatype").find(":selected").val();
                txtConfigDesc = $("#pdatype").find(":selected").text();
                /*表单验证*/
                /*如需表单验证可以此处处理验证 开始*/
                var entity = {};
                entity.Id = warehouseCpInConfigId
                entity.ConfigId = txtConfigId;
                entity.ConfigName = txtConfigName;
                entity.ConfigType = txtConfigType;
                entity.ConfigDesc = txtConfigDesc;
                entity.Remark = txtRemark;
                //List.push(JSON.stringify(entity));
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxWarehouseCpInConfig.WarehouseCpInConfigEdit(entity);
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
            else {
                /*表单验证*/
                /*如需表单验证可以此处处理验证 开始*/
                //if ($("#stationCon:hide")) {
                //    txtConfigDesc = $("#stationConValue").val();
                //}
                if ($("#stationCon").attr("style") == "") {
                    txtConfigDesc = $("#<%=this.stationConValue.ClientID%>").val();
                }
                var entity = {};
                entity.Id = warehouseCpInConfigId
                entity.ConfigId = txtConfigId;
                entity.ConfigName = txtConfigName;
                entity.ConfigType = txtConfigType;
                entity.ConfigDesc = txtConfigDesc;
                entity.Remark = txtRemark;
                //List.push(JSON.stringify(entity));
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxWarehouseCpInConfig.WarehouseCpInConfigEdit(entity);
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
        }
    </script>
</asp:Content>
