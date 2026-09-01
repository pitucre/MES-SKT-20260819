<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HoldAndUnHoldHistory.aspx.cs" Inherits="SKT.LeanMES.Web.Hold.HoldAndUnHoldHistory" MasterPageFile="~/Masters/ListMaster.master" %>
<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">

    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">
                <%//=Resources.lang.TurnoverTypeName%>对象类型
            </td>
            <td class="Field2">
                <asp:DropDownList ID="ddlObjectType" runat="server">
                    <asp:ListItem Value = "-1">所有</asp:ListItem>
                    <asp:ListItem Value = "1">工单</asp:ListItem>
                    <asp:ListItem Value = "2">产品</asp:ListItem>
                    <asp:ListItem Value = "3">物料</asp:ListItem>
                    <asp:ListItem Value = "4">在制品</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td class="Label2">
                <%//=Resources.lang.TurnoverTypeName%>对象编号
            </td>
            <td class="Field2">
                <input type="text" id="txtObjectCode" class="TextBox" runat="server"/><input type="button" class="ButtonBox" value="..." onclick="choosepage()"/>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="searchConditions" runat="server" ContentPlaceHolderID="GridviewContent" >
    <asp:GridView ID="GridView1" AutoGenerateColumns="false" runat="server" >
        <Columns>
            <asp:BoundField DataField="OperateType" HeaderText="操作类型" ItemStyle-Width="90px" />
            <asp:BoundField DataField="ObjectName" HeaderText="对象类型" ItemStyle-Width="100px" />
            <asp:BoundField DataField="ObjectCode" HeaderText="对象编号" ItemStyle-Width="200px" />
            <asp:BoundField DataField="OperatePerson" HeaderText="操作人" ItemStyle-Width="100px" />
            <asp:BoundField DataField="OperateDateTime" HeaderText="操作时间" ItemStyle-Width="150px" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
            <asp:BoundField DataField="Remark" HeaderText="备注" ItemStyle-Width="150px" />
            <asp:BoundField DataField="HoldOrUnHoldCause" HeaderText="原因说明" ItemStyle-Width="350px" />

        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Quality.BLL.Hold"
        SelectMethod="GetHistoryAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>

    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <script type="text/javascript">
        isMultiple = false;
        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");

        var flag = -1;
        function choosepage() {
            var ot = parseInt($("#<%=this.ddlObjectType.ClientID %>").val());
            var pageCondition = "";

            if (ot <= 0 || ot == 4) {
                alert("请选择具体的对象类型（如：工单、产品、物料）！");
                $("#<%=this.ddlObjectType.ClientID %>").focus()
                return false;
            }

            switch (ot) {
                case 1: flag = 44;
                    break;
                case 2: flag = 1;
                    break;
                case 3: flag = 1;
                    break;
            }

            dialog({ title: "", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Framework/ChoosePage.aspx?PageId=" + flag + "&PageCondition=" + pageCondition + "&Multiple=false&rnd=" + Math.random(), width: 600, height: 300 });
        }

        function getChooseValue(list) {
            if (flag == 1) {
                $("#<%=this.txtObjectCode.ClientID %>").val(list[0][2])
            }
            else
            if (flag == 44) {
                $("#<%=this.txtObjectCode.ClientID %>").val(list[0][1])
            }

        }
    </script>
</asp:Content>



