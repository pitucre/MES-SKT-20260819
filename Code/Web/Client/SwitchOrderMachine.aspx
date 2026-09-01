<%@ Page Language="C#" Title="" MasterPageFile="~/Masters/ChooseListMaster.master"
    AutoEventWireup="true" CodeBehind="SwitchOrderMachine.aspx.cs" Inherits="SKT.LeanMES.Web.Client.SwitchOrderMachine" %>

<%@ MasterType VirtualPath="~/Masters/ChooseListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
    <table class="EditeContentTable" width="100%">
        <tr style="display: none;">
            <td class="Label1">设备编码
            </td>
            <td class="Field1">
                <asp:TextBox runat="server" ID="txtEquipment" CssClass="TextBox"></asp:TextBox>
                <input type="button" value="..." class="ButtonBox" onclick="selectEqType()" />
                <asp:HiddenField runat="server" ID="txtLineName" Value=""></asp:HiddenField>
            </td>
        </tr>
        <tr>
            <td class="Label1">工单号
            </td>
            <td class="Field1">
                <asp:TextBox runat="server" ID="txtLinePlanNo" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
    </table>
    <script src="../Content/js/jquery-3.1.0.min.js"></script>
    <script language="javascript" type="text/javascript">
        isMultiple = false;
        var orderId = -1
        var LineId = -1
        var orderNo = "";
        var LineName = "";
        var LinePlan = "";
        $('#<%=this.txtEquipment.ClientID %>').keydown(function (e) {
            if (e.keyCode == 13) {
                LineId = -1

                var entity = {};
                entity.EquipmentCode = $("#<%=this.txtEquipment.ClientID %>").val();
                if (!entity.EquipmentCode) {
                    return false;
                }
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSDP.ExecUDFProc("uspGetEquipmentLineName", JSON.stringify(entity));
                if (ajax.error != null) {
                    alert(ajax.error.Message)
                    return;
                } else {
                    if (ajax.value.length > 0) {
                        var data = JSON.parse(ajax.value);
                        $("#<%=this.txtLineName.ClientID %>").val(data[0].LineName);
                    }
                }
            }
        });

        function getChooseValue(list) {
            $("#<%=this.txtLineName.ClientID %>").val(list[0][4]);
            $("#<%=this.txtEquipment.ClientID %>").val(list[0][1]);
        }

        function selectEqType() {
            $("#<%=this.txtLineName.ClientID %>").val("");
            var condition = " LineID<>-1 ";
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=54&PageCondition= " + condition + "&Multiple=false&rnd=" + Math.random(), width: 450, height: 300 });
        }
        function clearSearch() {
            $("#<%=this.txtLinePlanNo.ClientID %>").val("");
            $("#searchSubmit").click();
            return true;
        }
        $(function () {
            //移除引入的js:
            var jssrc = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/jquery.min.js";
            $("script[src='" + jssrc + "']").remove()

        });

        // 保存数据到cookie
        function setCookie(name, value, days) {

            var d = new Date("2038-01-01"); // 设置为2038年的某个日期
            var expires = " ; expires=" + d.toUTCString();
            document.cookie = name + "=" + (value || "") + expires + "; path=/";
        }

        //双击行调用方法
        function dblClk(obj) {
            var LinePlanCode = $(obj.cells[1]).text();
            var orderId = $(obj.cells[0]).find("[name=chkSelect]")[0].value;
            setCookie('gd', LinePlanCode, 30); // 将用户名保存到cookie，有效期30天
            var location = encodeURI("Client/MachinedInjectionMolding.aspx");

            parent.window.location.href = '../' + location + "?OrderId=" + orderId + "&OrderNo=" + LinePlanCode + "&rnd=" + Math.random();
        }



    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
    <asp:GridView ID="GridView1" AutoGenerateColumns="false" runat="server" DataSourceID="ObjectDataSource1">
        <Columns>
            <asp:BoundField DataField="OrderNO" HeaderText="工单号" />
            <asp:BoundField DataField="ItemCode" HeaderText="产品编码" />
            <asp:BoundField DataField="ItemName" HeaderText="产品名称" />
            <asp:BoundField DataField="ItemSpec" HeaderText="产品规格" />
            <asp:BoundField DataField="Version" HeaderText="产品版本" />
            <asp:BoundField DataField="CPN" HeaderText="客户料号" />
            <asp:BoundField DataField="Planned_Start_Time" HeaderText="工单计划开始时间" />
            <asp:BoundField DataField="Qty_to_Build" HeaderText="工单计划生产数量" />
            <asp:BoundField DataField="Qty_Done" HeaderText="工单完成数量" />
            <asp:BoundField DataField="WaitQty" HeaderText="工单剩余数量" />
              <asp:BoundField DataField="BomVersion" HeaderText="客户BOM版本号" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Order.BLL.ShopOrder"
        SelectMethod="GetInjectMoudlLinePlanAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="search" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <script type="text/javascript">
        isMultiple = false;
    </script>
</asp:Content>
