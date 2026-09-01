<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EquipmentEarlyWarning.aspx.cs" Inherits="SKT.LeanMES.Web.Equipment.EquipmentEarlyWarning" MasterPageFile="~/Masters/ViewMaster.master" %>


<asp:Content ContentPlaceHolderID="viewcontent" runat="server">
    <style>
        .Label2 {
            width: 10%;
            height: 45px;
            font-size: 16px !important;
            text-align: right;
        }
    </style>
    <div class="clear5">
    </div>
    <div class="wrap_tb" id="wrap_tb">
        <ul class="tb">
            <li class="current" id="Div1">保养计划预警</li>
            <li>保养记录</li>
            <li>设备校验</li>
            <li>备件</li>
        </ul>
        <div class="tb_c tb_content">
            <div id="divDtl">
            </div>
            <br />
            <table class="EditeContentTable" width="100%">
                <tr style="color:red">
                    <td class="Label2" style="text-align: left">
                        超期未执行的计划
                    </td>
                    <td class="Field2">
                        <asp:Label CssClass="Value" runat="server" ID="Label4"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="Label2" style="text-align: left">
                        今日到期
                    </td>
                    <td class="Field2">
                        <asp:Label CssClass="Value" runat="server" ID="Label1"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="Label2" style="text-align: left">
                        明日到期
                    </td>
                    <td class="Field2">
                        <asp:Label CssClass="Value" runat="server" ID="Label2"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="Label2" style="text-align: left">
                        本月计划
                    </td>
                    <td class="Field2">
                        <asp:Label CssClass="Value" runat="server" ID="Label3"></asp:Label>
                    </td>
                </tr>
            </table>
        </div>
        <div id="ItemCodeInfo" runat="server">
            <table class="EditeContentTable" width="100%">
                <tr>
                    <td class="Label2" style="text-align: left">
                        本月执行
                    </td>
                    <td class="Field2">
                        <asp:Label CssClass="Value" runat="server" ID="Label5"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="Label2" style="text-align: left">
                        上月执行
                    </td>
                    <td class="Field2">
                        <asp:Label CssClass="Value" runat="server" ID="Label6"></asp:Label>
                    </td>
                </tr>
            </table>
        </div>
        <div id="FileInfo" runat="server">
            <table class="EditeContentTable" width="100%">
                <tr style="color:red">
                    <td class="Label2" style="text-align: left">
                        超期为检验设备
                    </td>
                    <td class="Field2">
                        <asp:Label CssClass="Value" runat="server" ID="Label7"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="Label2" style="text-align: left">
                        三日内需检验设备
                    </td>
                    <td class="Field2">
                        <asp:Label CssClass="Value" runat="server" ID="Label8"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="Label2" style="text-align: left">
                        本月到期
                    </td>
                    <td class="Field2">
                        <asp:Label CssClass="Value" runat="server" ID="Label9"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="Label2" style="text-align: left">
                        下月到期
                    </td>
                    <td class="Field2">
                        <asp:Label CssClass="Value" runat="server" ID="Label10"></asp:Label>
                    </td>
                </tr>
            </table>
        </div>
        <div id="PartInfo" runat="server">
            <table class="EditeContentTable" width="100%">
                <tr>
                    <td class="Label2" style="text-align: left">
                        库存不足
                    </td>
                    <td class="Field2">
                        <asp:Label CssClass="Value" runat="server" ID="Label11"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="Label2" style="text-align: left">
                        库存超出上限
                    </td>
                    <td class="Field2">
                        <asp:Label CssClass="Value" runat="server" ID="Label12"></asp:Label>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <asp:HiddenField ID="lbFileReady" runat="server" Value="-1" ClientIDMode="Static" />
    <asp:HiddenField ID="HiddenField1" runat="server" Value="-1" ClientIDMode="Static" />
    <script type="text/javascript" src="../Content/js/jquery-3.1.0.min.js"></script>
    <script type="text/javascript" charset="utf-8" src="../Content/plugin/jquery-easyui-1.4.2/layer/layer.js"></script>
    <script type="text/javascript">
        $(function () {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEquipment.EquipmentEarlyWarning();
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var data = $.parseJSON(ajax.value).data;
            $(".Field2").each(function (i, j) {
                $(this).html(data[i].Value + "     项");
            });
        });
    </script>
</asp:Content>
