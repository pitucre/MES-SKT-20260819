<%@ Page Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true"  CodeBehind="SchedulPlanConfig.aspx.cs" Inherits="SKT.LeanMES.Web.Plan.SchedulPlanConfig" %>

<%@ Import Namespace="Resources" %>
<%@ Import Namespace="SKT.LeanMES.Web" %>
<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
<%--<script src="../Content/js/jquery-1.7.2.js" type="text/javascript"></script>
 <script src="../Content/js/jquery.jedate.min.js" type="text/javascript"></script>
 <link href="../Content/jedate.css" rel="stylesheet" type="text/css" />--%>
    
<%--  <style type="text/css">
      .wicon {
    background-image: url("data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABwAAAASAgMAAAA1aVZ3AAAACVBMVEUAAAD///9nyrNdI4MmAAAAAXRSTlMAQObYZgAAAChJREFUCNdjWAUCCxjg9DQgtTKBAUN8aigQJGCho6KiYDSJ8ggaYR8Ao74zAKjm+cYAAAAASUVORK5CYII=");
    background-position: right center;
    background-repeat: no-repeat;
}
  </style>--%>
    <table class="EditeContentTable" width="100%">
        <tr>
              <td class="Label1" >
                 名称
            </td>
             <td class="Field1">
                 <asp:TextBox ID="txtName" runat="server" CssClass="TextBox"></asp:TextBox>
             </td>
        
            
        </tr>
      
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="Name" HeaderText="名称" />
            <asp:TemplateField HeaderText="是否启用" HeaderStyle-Width="90px">
                <ItemTemplate>
                      <%#Eval("IsEnable").ToString() == "0" ? "是" : "否"%>
                </ItemTemplate>
            </asp:TemplateField>
             <asp:BoundField DataField="Remark" HeaderText="备注"  />
            <asp:BoundField DataField="CreateBy" HeaderText="创建人"  HeaderStyle-Width="90px"/>
            <asp:BoundField DataField="CreateTime" HeaderText="创建时间"  HeaderStyle-Width="140px"/>
         
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Plan.BLL.SchedulPlanConfig"
        SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    
    <input type="hidden" id="hdnItemId" name="hdnItemId" value="" />
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <script type="text/javascript">
        isMultiple = false;
        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");
        function Add() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Plan/SchedulPlanConfigEdit.aspx?name=System_SchedulPlanConfigAdd&ID=-1";
            dialog({ title: "<%=Resources.lang.Add %>", src: openWinUrl, width: 550, height: 400 });
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Plan/SchedulPlanConfigEdit.aspx?name=System_SchedulPlanConfigEdit&ID=" + idStr;
            dialog({ title: "<%=Resources.lang.Edit %>", src: openWinUrl, width: 550, height: 400 });
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
    </script>
</asp:Content>
