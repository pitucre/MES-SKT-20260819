<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true"
    CodeBehind="StandardLaborTimeList.aspx.cs" Inherits="SKT.LeanMES.Web.Plan.StandardLaborTimeList" %>

<%@ Import Namespace="Resources" %>
<%@ Import Namespace="SKT.LeanMES.Web" %>
<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">
                标准工时类型
            </td>
            <td class="Field2">                 
                <asp:DropDownList ID="ddlLaborTimeType" runat="server">
                    <asp:ListItem Text="全部" Value="0" Selected="True" ></asp:ListItem>
                <asp:ListItem Text="SMT" Value="1"  ></asp:ListItem>
                <asp:ListItem Text="非SMT" Value="2"></asp:ListItem>              
                </asp:DropDownList>
            </td>
            <td class="Label2">
                产品编码
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtItemName" runat="server" CssClass="TextBox" ClientIDMode="Static"
                    Width="64%">
                </asp:TextBox><input type="button" id="btnSelectItem" runat="server" class="ButtonBox"
                    value="..." title="Select" onclick="openChoosePage(1);" />
                <asp:HiddenField ID="hdnItemId" runat="server" Value="-1" ClientIDMode="Static" />
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" style="table-layout:fixed;word-wrap:break-word;word-break:break-all">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="LaborTimeTypeName" HeaderText="标准工时类型" HeaderStyle-Width="90px"/>
            <asp:BoundField DataField="EquipmentLineName" HeaderText="线别设备类型" HeaderStyle-Width="210px"/>
            <asp:BoundField DataField="ItemCode" HeaderText="产品编码" HeaderStyle-Width="170px"/>
            <asp:BoundField DataField="ItemName" HeaderText="产品名称" HeaderStyle-Width="170px"/>
            <asp:BoundField DataField="TableDesc" HeaderText="面别" HeaderStyle-Width="70px"/>
            <asp:BoundField DataField="StandardLaborTime" HeaderText="标准工时（秒）"  HeaderStyle-Width="100px"/>
            <asp:BoundField DataField="BottleneckHours" HeaderText="瓶颈工时（秒）"  HeaderStyle-Width="100px"/>
            <asp:BoundField DataField="StandardCapacity" HeaderText="标准产能" HeaderStyle-Width="90px"/>
            <asp:BoundField DataField="PanelQty" HeaderText="拼板数" HeaderStyle-Width="80px"/>
            <asp:BoundField DataField="CreateBy" HeaderText="创建人"  HeaderStyle-Width="80px"/>
            <asp:BoundField DataField="CreateDateTime" HeaderText="创建时间"  HeaderStyle-Width="140px"/>
            <asp:BoundField DataField="ModifyBy" HeaderText="修改人" HeaderStyle-Width="90px" />
            
            <asp:BoundField DataField="ModifyDateTime" HeaderText="<%$ Resources:lang,ModifyDateTime %>" HeaderStyle-Width="140px"  DataFormatString="{0:yyyy-MM-dd HH:mm:ss}"/>
            <%--<asp:BoundField DataField="Remark" HeaderText="备注" />--%>
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Plan.BLL.StandardLaborTime"
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
        function Add() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Plan/StandardLaborTimeEdit.aspx?name=StandardLaborTimeAdd&ID=-1";
            dialog({ title: "<%=Resources.Pages.StandardLaborTimeAdd %>", src: openWinUrl, width: 750, height: 400 });
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Plan/StandardLaborTimeEdit.aspx?name=StandardLaborTimeEdit&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.StandardLaborTimeEdit %>", src: openWinUrl, width: 750, height: 400 });
        }

        function Delete() {
            var idStr = getDeletingRecordIdString();
            if (idStr == "") return false;
            hdnOperate.val("delete");
            hdnIdString.val(idStr);
            document.forms[0].submit();
        }

        function Refresh() {
            document.forms[0].submit();
        }

        function openChoosePage(flags) {
            var condition = "";
            dialog({
                title: "<%= Common.ChooseWindow %>",
                src: "<%= WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=" +
                flags +
                "&Multiple=false&SearchCondition=" +
                condition +
                "&rnd=" +
                Math.random(),
                width: 700,
                height: 300
            });
        }

        function getChooseValue(list) {   
                $("#txtItemName").val(list[0][2]);
                $("#hdnItemId").val(list[0][0]);            
        }
    </script>
</asp:Content>
