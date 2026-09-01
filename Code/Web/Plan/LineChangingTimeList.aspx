<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true"
    CodeBehind="LineChangingTimeList.aspx.cs" Inherits="SKT.LeanMES.Web.Plan.LineChangingTimeList" %>

<%@ Import Namespace="Resources" %>
<%@ Import Namespace="SKT.LeanMES.Web" %>
<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
    <table class="EditeContentTable" width="100%">
        <tr>
          <td class="Label2" >
              线别
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtLineName" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
            </td>
             
            <td class="Label2" >
                  <%=Resources.lang.ResName %>
            </td>
            <td class="Field2">
                 <asp:TextBox ID="txtResName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>               
        </tr>
        <tr>
              <td class="Label2" >
                 产品A编码
            </td>
             <td class="Field2">
                 <asp:TextBox ID="txtItemOneCode" runat="server" CssClass="TextBox"></asp:TextBox>
             </td>

            <td class="Label2" >
                产品B编码
            </td>
             <td class="Field2">
                 <asp:TextBox ID="txtItemTwoCode" runat="server" CssClass="TextBox"></asp:TextBox>
             </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="LineName" HeaderText="线别" />
            <asp:BoundField DataField="ResName" HeaderText="资源名称" />
            <asp:BoundField DataField="ItemOneCode" HeaderText="产品A编码" />
            <asp:BoundField DataField="ItemTwoCode" HeaderText="产品B编码" />
            <asp:BoundField DataField="LineChangingTime" HeaderText="换线时间(h)" />
          
            <asp:BoundField DataField="CreateBy" HeaderText="创建人"  HeaderStyle-Width="90px"/>
            <asp:BoundField DataField="CreateTime" HeaderText="创建时间"  HeaderStyle-Width="140px"/>
            <asp:BoundField DataField="Remark" HeaderText="备注" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Plan.BLL.LineChangingTime"
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
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Plan/LineChangingTimeEdit.aspx?name=LineChangingTimeAdd&ID=-1";
            dialog({ title: "<%=Resources.Pages.LineChangingTimeAdd %>", src: openWinUrl, width: 750, height: 400 });
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Plan/LineChangingTimeEdit.aspx?name=LineChangingTimeEdit&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.LineChangingTimeEdit %>", src: openWinUrl, width: 750, height: 400 });
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
                width: 600,
                height: 300
            });
        }

        function getChooseValue(list) {   
                $("#txtItemName").val(list[0][2]);
                $("#hdnItemId").val(list[0][0]);            
        }
    </script>
</asp:Content>
