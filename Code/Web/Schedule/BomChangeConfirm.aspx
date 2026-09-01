<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BomChangeConfirm.aspx.cs" Inherits="SKT.LeanMES.Web.Schedule.BomChangeConfirm" MasterPageFile="~/Masters/ListMaster.master"%>
<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label3">
                <%=Resources.lang.Status%>
            </td>
            <td class="Field3" colspan="3" >
                <asp:DropDownList ID="ddStatus" runat="server">
                    <asp:ListItem Value="-1" Text="所有"> </asp:ListItem> 
                    <asp:ListItem Value="1" Text="可释放"> </asp:ListItem>
                    <asp:ListItem Value="2" Text="Hold"> </asp:ListItem>
                    <asp:ListItem Value="3" Text="完成"> </asp:ListItem>
                    <asp:ListItem Value="4" Text="关闭"> </asp:ListItem>
                </asp:DropDownList>
            </td>
            <td class="Label3">
                <%=Resources.lang.OrderNumber%>
            </td>
            <td class="Field3" >
                <asp:TextBox ID="txtOrderNo" runat="server"></asp:TextBox>
            </td>
            <td class="Label3">
                <%=Resources.lang.OrderType%>
            </td>
            <td class="Field3" >
                <asp:DropDownList ID="ddlOrderType" runat="server">
                    <asp:ListItem Value="-1" Text="所有"> </asp:ListItem> 
                    <asp:ListItem Value="1" Text="正常"> </asp:ListItem>
                    <asp:ListItem Value="2" Text="RMA"> </asp:ListItem>
                    <asp:ListItem Value="3" Text="返工"> </asp:ListItem>

                    <asp:ListItem Value="4" Text="委外加工"> </asp:ListItem>
                    <asp:ListItem Value="5" Text="受托加工"> </asp:ListItem>
                    <asp:ListItem Value="6" Text="重复生产"> </asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
      
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
     
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" AutoGenerateColumns="false" OnRowDataBound="GridView1_OnRowDataBound" ClientIDMode="Static">
        <Columns>
            <asp:BoundField DataField="MoCode" HeaderText="<%$ Resources:lang,ShopOrder %>" />
            <asp:BoundField DataField="InvCode" HeaderText="<%$ Resources:lang,ItemCode %>" />
            <asp:BoundField DataField="InvName" HeaderText="<%$ Resources:lang,ItemsName %>" />
            <asp:BoundField DataField="BusType" HeaderText="<%$ Resources:lang,OrderType %>" />
            <asp:BoundField DataField="State" HeaderText="<%$ Resources:lang,Status %>" />

        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Schedule.BLL.ERP_MOBOM"
        SelectMethod="GetWaitChangeAll" SelectCountMethod="GetCount">
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
        var date = "";
        var user = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>"

        function UpdateList(namestr) {
            $("#txtOrderNO").val(namestr);
            document.forms[0].submit();
        }

        //确认更新
        function ConfirmUpdate() {
            var idStr = getOneRecordId();
            if (idStr == "") return;
            //xiang.yan 2024-4-28  列取值由索引改为列明,菜单已无此页面
            // 1 改为 MoCode
            var orderNO = getOneRecordCellTextByFiled("MoCode");
            var pubufts = "";

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSchedule.BomConfirmChange(orderNO, pubufts, user)
            if (ajax.error != null) {
                alert(ajax.error.Message)
                return false;
            }

            alert("更新成功！");
            document.forms[0].submit();
        }


        //更新内容对比  ---这个工单此次变更的明细列表
        function Compare() {
            var idStr = getOneRecordId();
            if (idStr == "") return;
            //xiang.yan 2024-4-28  列取值由索引改为列明,菜单已无此页面
            // 1 改为 MoCode
            var orderNO = getOneRecordCellTextByFiled("MoCode");
            var pubufts = "";
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Schedule/BomUpdateCompare.aspx?name=Schedule_BomUpdateCompare&orderNO=" + orderNO + "&pubufts=" + pubufts;
            dialog({ title: "<%= Resources.Pages.Schedule_BomUpdateCompare %>", src: openWinUrl, width: 9900, height: 500, resizeable: false });
        }
        
    </script>
</asp:Content>
