<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditHeadMaster.master" AutoEventWireup="true" CodeBehind="StockListEditStandard.aspx.cs" Inherits="SKT.LeanMES.Web.Plan.StockListEditStandard" %>

<%@ MasterType VirtualPath="~/Masters/EditHeadMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label3">排产号
            </td>
            <td class="Field3">
                <asp:Label ID="lblPlanOrderNo" runat="server" Text=""></asp:Label>
            </td>
            <td class="Label3">数量
            </td>
            <td class="Field3">
                <asp:Label ID="lblPlanQty" runat="server" Text=""></asp:Label>
            </td>
            <td class="Label3">工单号
            </td>
            <td class="Field3">
                <asp:Label ID="lblOrderNo" runat="server" Text=""></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label3">物料编码
            </td>
            <td class="Field3">
                <asp:Label ID="lblItemCode" runat="server" Text=""></asp:Label>
            </td>
            <td class="Label3">物料名称
            </td>
            <td class="Field3" colspan="3">
                <asp:Label ID="lblItemName" runat="server" Text=""></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label3">设备
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtEquipmentCode" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
            </td>
            <td class="Label3">区域
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtArea" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
            </td>
            <td class="Label3">料站
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtPositon" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
                <input class="SearchButton" id="btnQuery" type="button" value="查  询" onclick="Query()" />
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" DataSourceID="ObjectDataSource1">
        <Columns>
            <%-- To Do --%>
            <asp:TemplateField HeaderText="序号" InsertVisible="False">
                <ItemStyle HorizontalAlign="Center" />
                <HeaderStyle HorizontalAlign="Center" />
                <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%# this.GridView1.PageIndex * this.GridView1.PageSize + this.GridView1.Rows.Count + 1%>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="主料" InsertVisible="False">
                <ItemStyle HorizontalAlign="Center" />
                <HeaderStyle HorizontalAlign="Center" />
                <ItemTemplate>
                    <span name="PartNumber"><%#Eval("PartNumber") %></span>
                </ItemTemplate>
            </asp:TemplateField>
            <%-- <asp:BoundField DataField="PartNumber" HeaderText="主料" />--%>
            <asp:BoundField DataField="ReplaceMaterial" HeaderText="替代料" />
            <asp:BoundField DataField="ABCClass" HeaderText="ABC等级" />
            <asp:BoundField DataField="Area" HeaderText="区" />
            <asp:BoundField DataField="TableName" HeaderText="面别" />
            <asp:BoundField DataField="EquipmentCode" HeaderText="设备" />
            <asp:BoundField DataField="FeederType" HeaderText="飞达类型" />

            <asp:TemplateField HeaderText="料站" InsertVisible="False">
                <ItemStyle HorizontalAlign="Center" />
                <HeaderStyle HorizontalAlign="Center" />
                <ItemTemplate>
                    <span name="Positon"><%#Eval("Positon") %></span>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="Num" HeaderText="用量" />
            <asp:BoundField DataField="CLNumber" HeaderText="扣料基数" />
            <asp:TemplateField HeaderText="总数量">
                <HeaderStyle HorizontalAlign="Center" />
                <ItemTemplate>
                    <span title='总数量 = (排产工单数量*用量)/(拼板数[无拼板的数量为1]) + ABC等级的超发数量'><%# Eval("TotalNum")%> </span>
                </ItemTemplate>
            </asp:TemplateField>
            <%-- <asp:BoundField DataField="ShouldIssue" HeaderText="应发数量" SortExpression="ShouldIssue" />--%>
            <asp:BoundField DataField="AlreadyIssue" HeaderText="已发数量" />
            <asp:BoundField DataField="PreparedNum" HeaderText="已备数量" />

        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Plan.BLL.StockList"
        SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <script type="text/javascript">
        isMultiple = false;
        var linePlanNo = '<%=Request.QueryString["PlanOrderNo"]%>';
        $().ready(function () {
            $("#chkAll").hide();
        });

        function AddReplaceItem() {
            var id = getOneRecordId();
            if (id == "") return false;
            var trObj = $("input[type=checkbox][name=chkSelect]:checked").parent().parent();
            var mainItemCode = trObj.find("td span[name='PartNumber']").text();
            var position = trObj.find("td span[name='Positon']").text();
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Plan/StockListAddReplaceItemStandard.aspx?name=Plan_AddReplaceItem_Standard&ID=" + id + "&PlanOrderNo=" + linePlanNo + "&MainItemCode=" + mainItemCode + "&Position=" + position;
            dialog({ title: "<%=Resources.Pages.Plan_AddReplaceItem %>", src: openWinUrl, width: 800, height: 350 });
        }

        function AddPosition() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Plan/StockListAddPositionStandard.aspx?name=Plan_AddPosition_Standard&PlanOrderNo=" + linePlanNo + "&standardID=0";
            dialog({ title: "<%=Resources.Pages.Plan_AddPosition %>", src: openWinUrl, width: 800, height: 350 });
        }
        function edit() {            
            var standardID = getOneRecordId();
            if (!standardID) return;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Plan/StockListAddPositionStandard.aspx?name=Plan_AddPosition_Standard&PlanOrderNo=" + linePlanNo + "&standardID=" + standardID;
            dialog({ title: "<%=Resources.Pages.Plan_AddPosition %>", src: openWinUrl, width: 800, height: 350 });
        }

        function Refresh() {
            document.forms[0].submit();
        }
        function Query() {
            $(".overlay").show();
            document.forms[0].submit();
        }

        //删除料站
        function DeletePosition() {
            var id = getOneRecordId();
            if (id == "") return false;
            if (confirm('确定删除该料站信息,如果该料站已经有上料信息,会自动打散?')) {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxStockList.DeleteStockListPosition(id, linePlanNo);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }
                alert('数据删除成功!');
                Refresh();
            }
        }
    </script>
</asp:Content>
