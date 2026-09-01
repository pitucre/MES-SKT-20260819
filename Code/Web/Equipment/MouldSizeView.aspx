<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="True"
    CodeBehind="MouldSizeView.aspx.cs" Inherits="SKT.LeanMES.Web.Equipment.MouldSizeView" Title="Edit EquipmentPosition" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <style>
        .Label {
            text-align: right;
        }
    </style>
    <div class="wrap_tb" style="min-height: 350px; min-width: 600px">
        <ul class="tb">
            <li class="current" title="">模具尺寸信息
            </li>
            <li title="">模具尺寸历史信息 </li>
        </ul>
        <div class="tb_c">
            <table width="100%" class="EditeContentTable">
                <tr>
                    <td class="Label">模具编码<em>*</em></td>
                    <td class="Field" colspan="1">
                        <asp:Label ID="txtMouldCode" runat="server" CssClass="TextBox" MaxLength="100"></asp:Label>

                        <asp:HiddenField ID="hdnMouldId" runat="server" ClientIDMode="Static" />
                    </td>
                    <td class="Label"><%=Resources.lang.MouldName%><em>*</em></td>
                    <td class="Field">
                        <asp:Label ID="lblBomName" runat="server" CssClass="TextBox" MaxLength="100"></asp:Label>
                        <asp:HiddenField ID="hdnMouldBomId" runat="server" ClientIDMode="Static" />
                    </td>
                </tr>
                <tr>
                    <td class="Label">构件名称<em>*</em></td>
                    <td class="Field">
                        <asp:Label ID="lblMouldTypeName" runat="server" CssClass="TextBox" MaxLength="100"></asp:Label>
                        <asp:HiddenField ID="hdnMouldTypeId" runat="server" ClientIDMode="Static" />
                    </td>
                    <td class="Label">单位</td>
                    <td class="Field">
                        <asp:Label ID="txtUnits" runat="server" CssClass="TextBox" MaxLength="10" Text="MM"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="Label" style="width: 220px">测试项目</td>
                    <td class="Field" style="width: 300px; text-align: center;"><b><span>测试项目1</span></b></td>
            <td class="Field" style="width: 300px; text-align: center;"><b><span>测试项目2</span></b> </td>
            <td class="Field" style="width: 300px; text-align: center;"><b><span>测试项目3</span></b> </td>
                </tr>
                <tr>
                    <td class="Label">标准值<em>*</em></td>
                    <td class="Field">
                        <asp:Label ID="lblExternalDiameterStander" runat="server"></asp:Label>
                    </td>
                    <td class="Field">
                        <asp:Label ID="lblInternalDiameterStander" runat="server"></asp:Label>
                    </td>
                    <td class="Field">
                        <asp:Label ID="lblTestItem3Stander" runat="server"></asp:Label>
                    </td>

                </tr>
                <tr>
                    <td class="Label">测量值一</td>
                    <td class="Field">
                        <asp:Label ID="txtExternalDiameter1" runat="server" CssClass="TextBox numbercheck" MaxLength="100" Text="0" IsNumber='1' onblur="ExternalDiameter(this)"></asp:Label>
                    </td>
                    <td class="Field">
                        <asp:Label ID="txtInternalDiameter1" runat="server" CssClass="TextBox numbercheck" Text="0" IsNumber='1' MaxLength="100" onblur="InternalDiameter(this)"></asp:Label></td>
                    <td class="Field">
                        <asp:Label ID="txtTestItem3_1" runat="server" CssClass="TextBox numbercheck" MaxLength="100" Text="0" IsNumber='1' onblur="TestItem3(this)"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="Label">测量值二</td>
                    <td class="Field">
                        <asp:Label ID="txtExternalDiameter2" runat="server" CssClass="TextBox numbercheck" MaxLength="100" Text="0" IsNumber='1' onblur="ExternalDiameter(this)"></asp:Label>
                    </td>
                    <td class="Field">
                        <asp:Label ID="txtInternalDiameter2" runat="server" CssClass="TextBox numbercheck" Text="0" IsNumber='1' MaxLength="100" onblur="InternalDiameter(this)"></asp:Label></td>
                    <td class="Field">
                        <asp:Label ID="txtTestItem3_2" runat="server" CssClass="TextBox numbercheck" MaxLength="100" Text="0" IsNumber='1' onblur="TestItem3(this)"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="Label">测量值三</td>
                    <td class="Field">
                        <asp:Label ID="txtExternalDiameter3" runat="server" CssClass="TextBox numbercheck" MaxLength="100" Text="0" IsNumber='1' onblur="ExternalDiameter(this)"></asp:Label>
                    </td>
                    <td class="Field">
                        <asp:Label ID="txtInternalDiameter3" runat="server" CssClass="TextBox numbercheck" Text="0" IsNumber='1' MaxLength="100" onblur="InternalDiameter(this)"></asp:Label></td>
                    <td class="Field">
                        <asp:Label ID="txtTestItem3_3" runat="server" CssClass="TextBox numbercheck" MaxLength="100" Text="0" IsNumber='1' onblur="TestItem3(this)"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="Label">平均值</td>
                    <td class="Field">
                        <asp:Label ID="lblExternalDiameterAvg" runat="server"></asp:Label>
                    </td>
                    <td class="Field">
                        <asp:Label ID="lblInternalDiameterAvg" runat="server"></asp:Label></td>
                    <td class="Field">
                        <asp:Label ID="lblTestItem3Avg" runat="server"></asp:Label></td>
                </tr>
                <tr>
                    <td class="Label">硬度<em>*</em></td>
                    <td class="Field">
                        <asp:Label ID="txtHardness" runat="server" CssClass="TextBox numbercheck" MaxLength="100" IsNumber='1' IsRequired="1"></asp:Label>
                    </td>
                    <td class="Label">判断</td>
                    <td class="Field">
                        <asp:Label ID="lblHege" runat="server" CssClass="TextBox" MaxLength="100" IsNumber='1'></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="Label">备注</td>
                    <td class="Field" colspan="3">
                        <asp:Label ID="lblRemark" ClientIDMode="Static" TextMode="MultiLine" runat="server" Height="60px" Width="80%"></asp:Label>
                    </td>
                </tr>

            </table>

        </div>
        <div style="overflow: auto; height: 560px;">
            <table class="ListTable" id="tbCompentList" style="border-width: 0px; width: 100%; border-collapse: collapse;"
                cellspacing="0" cellpadding="2">
                <tr class="ListTableHeader">
                    <th scope="col" colspan="2" style="text-align: center;">测试项目1
                    </th>
                    <th scope="col" colspan="2" style="text-align: center;">测试项目2
                    </th>
                    <th scope="col" colspan="2" style="text-align: center;">测试项目3
                    </th>
                    <th scope="col" rowspan="2" style="text-align: center;">硬度
                    </th>
                    <th scope="col" rowspan="2" style="text-align: center;">判断
                    </th>
                    <th scope="col" rowspan="2" style="text-align: center">备注
                    </th>
                    <th scope="col" rowspan="2" style="text-align: center; width: 60px">修改人
                    </th>
                    <th scope="col" rowspan="2" style="text-align: center; width: 140px;">修改时间
                    </th>
                </tr>
                <tr class="ListTableHeader">
                    <th scope="col">标准值
                    </th>
                   <%-- <th scope="col">测试值1
                    </th>
                    <th scope="col">测试值2
                    </th>
                    <th scope="col">测试值3
                    </th>--%>
                    <th scope="col" style="text-align: center;">平均值
                    </th>
                    <th scope="col">标准值
                    </th>
                    <%--<th scope="col">测试值1
                    </th>
                    <th scope="col">测试值2
                    </th>
                    <th scope="col">测试值3
                    </th>--%>
                    <th scope="col" style="text-align: center;">平均值
                    </th>
                    <th scope="col">标准值
                    </th>
                   <%-- <th scope="col">测试值1
                    </th>
                    <th scope="col">测试值2
                    </th>
                    <th scope="col">测试值3
                    </th>--%>
                    <th scope="col" style="text-align: center;">平均值
                    </th>
                </tr>
                <tbody id="historyTb">
                </tbody>
            </table>
        </div>
    </div>
    <input type="hidden" id="hdParentEquipmentCode" />
    <asp:HiddenField ID="hdnIsHege" runat="server" Value="0" ClientIDMode="Static" />
    <script type="text/javascript">
        var msmId = '<%=Request.QueryString["ID"]%>';
        $().ready(function () {
            switch ($("#<%=this.hdnIsHege.ClientID%>").val()) {
                case "1":
                    $("#<%=this.lblHege.ClientID%>").text("合格");
                    break;
                case "2":
                    $("#<%=this.lblHege.ClientID%>").text("不合格");
                    break;
                default:
                    $("#<%=this.lblHege.ClientID%>").text("");
                    break;
            }

            getMouldSizeHistory();
        });






        function getMouldSizeHistory() {

            var ajax = SKT.LeanMES.Web.Equipment.MouldSizeView.GetMouldSizeHistory(msmId);

            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            bulidTable(ajax.value);
        }

        function bulidTable(list) {
            if (list.lenght == 0) {
                return;
            }
            var obj = $("#historyTb");
            var html = "";

            for (var i = 0; i < list.length; i++) {
                var entity = {};
                entity = list[i];
                var d = new Date(entity.CreateTime);
                var datetime = d.getFullYear() + '-' + (d.getMonth() + 1) + '-' + d.getDate() + ' ' + d.getHours() + ':' + d.getMinutes() + ':' + d.getSeconds();

                html += "<tr class=\"ListTableOddRow\"><td width=\"150\">" + entity.ExternalDiameterMin + "~" + entity.ExternalDiameterMax + "</td><td>" + entity.ExternalDiameterAvg + "</td><td width=\"150\">" + entity.InternalDiameterMin + "~" + entity.InternalDiameterMax + "</td><td>" + entity.InternalDiameterAvg + "</td><td width=\"150\">" + entity.TestItem3Min + "~" + entity.TestItem3Max + "</td><td>" + entity.TestItem3Avg + "</td><td>" + entity.Hardness + "</td><td>" + (entity.Result == 1 ? "合格" : "不合格") + "</td><td>" + entity.Remark + "</td><td>" + entity.CreateBy + "</td><td>" + datetime + "</td></tr>"
            }
            obj.html(html);
        }

    </script>

</asp:Content>
