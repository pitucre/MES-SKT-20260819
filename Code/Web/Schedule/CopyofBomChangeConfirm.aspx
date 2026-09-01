<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CopyofBomChangeConfirm.aspx.cs" Inherits="SKT.LeanMES.Web.Schedule.CopyofBomChangeConfirm" MasterPageFile="~/Masters/ListMaster.master"%>
<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
<%--            <td class="Label3">
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
            </td>--%>
            <td class="Label2">
                <%=Resources.lang.OrderNumber%>
            </td>
            <td class="Field2" >
                <asp:TextBox ID="txtOrderNo" runat="server"></asp:TextBox>
            </td>
            <td class="Label2">
                <%=Resources.lang.OrderType%>
            </td>
            <td class="Field2" >
                <asp:DropDownList ID="ddlOrderType" runat="server">
                    <asp:ListItem Value="-1" Text="所有"> </asp:ListItem> 
                    <asp:ListItem Value="1" Text="正常"> </asp:ListItem>
                    <asp:ListItem Value="5" Text="返工"> </asp:ListItem>
                    <asp:ListItem Value="7" Text="委外"> </asp:ListItem>
                    <asp:ListItem Value="8" Text="委外返工"> </asp:ListItem>
                    <asp:ListItem Value="11" Text="折件式"> </asp:ListItem>
                    <asp:ListItem Value="13" Text="预测"> </asp:ListItem>
                    <asp:ListItem Value="15" Text="试产"> </asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
      
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
     
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" AutoGenerateColumns="false" OnRowDataBound="GridView1_OnRowDataBound" ClientIDMode="Static">
        <Columns>
            <%-- <asp:BoundField DataField="OrderNO"  HeaderText="<%$ Resources:lang, OrderNumber %>"  />
             <asp:BoundField DataField="FName" HeaderText="<%$ Resources:lang, MaterialName %>"  /> 
             <asp:BoundField DataField="fbiller" HeaderText="<%$ Resources:lang, Biller %>"  /> 
             <asp:BoundField DataField="FQty" HeaderText="<%$ Resources:lang, PlanQty %>"  /> 
             <asp:BoundField DataField="Status" HeaderText="<%$ Resources:lang, Status %>"  /> 
             <asp:BoundField DataField="Qty_to_UScheduling" HeaderText="<%$ Resources:lang, SchedulingQty %>"  /> 
             <asp:BoundField DataField="FDATE" HeaderText="<%$ Resources:lang, OrderDate %>"  /> 
             <asp:BoundField DataField="FPlanCommitDate" HeaderText="<%$ Resources:lang, PlanCommitDate %>"  />--%>
            <%--<asp:BoundField DataField="Site" HeaderText="<%$ Resources:lang,Site %>" />--%>
            <asp:BoundField DataField="MoCode" HeaderText="<%$ Resources:lang,ShopOrder %>" />
            <asp:BoundField DataField="Rowno" HeaderText="项次" />
            <asp:BoundField DataField="BusType" HeaderText="<%$ Resources:lang,OrderType %>" />
            <asp:BoundField DataField="MDeptName" HeaderText="<%$ Resources:lang,DepartmentName %>" />
            <asp:BoundField DataField="InvCode" HeaderText="物料编码" />
            <asp:BoundField DataField="WhCode" HeaderText="仓库编码" />
            <asp:BoundField DataField="VouchCode" HeaderText="货位编码" />
            <asp:BoundField DataField="ComUnitCode" HeaderText="<%$ Resources:lang,PartUnit %>" />
            <asp:BoundField DataField="Qty" HeaderText="<%$ Resources:lang,Qty %>" />
            <asp:BoundField DataField="RequisitionIssQty" HeaderText="申请已领数量" />
            <asp:BoundField DataField="IssQty" HeaderText="已领数量" />
            <asp:BoundField DataField="CompScrap" HeaderText="损耗率" />
            <asp:BoundField DataField="Batch" HeaderText="批号" />
            <asp:BoundField DataField="RSortSeq" HeaderText="工段号" />
            <asp:BoundField DataField="SortSeq" HeaderText="工序号" />
            <asp:BoundField DataField="WorkSeq" HeaderText="工作序号" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Schedule.BLL.ERP_MOBOM_Change"
        SelectMethod="GetAll" SelectCountMethod="GetCount">
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

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSchedule.BomConfirmChange(idStr, user)
            if (ajax.error != null) {
                alert(ajax.error.Message)
                return false;
            }

            alert("更新成功！");
            document.forms[0].submit();
        }


        //更新内容对比
        function Compare() {
            var idStr = getOneRecordId();
            if (idStr == "") return;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Schedule/BomUpdateCompare.aspx?name=Schedule_BomUpdateCompare&Id=" + idStr;
            dialog({ title: "<%= Resources.Pages.Schedule_BomUpdateCompare %>", src: openWinUrl, width: 900, height: 500, resizeable: false });
        }
        
    </script>
</asp:Content>
