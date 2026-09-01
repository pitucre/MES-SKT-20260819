<%@ Page Language="C#" MasterPageFile="~/Masters/ListMaster.master" 
    AutoEventWireup="true" CodeBehind="InterfaceManagementView.aspx.cs" Inherits="SKT.LeanMES.Web.Wave.InterfaceManagementView" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">

    <div style="height: 200px;">
        <asp:GridView ID="GridView1" AutoGenerateColumns="false" runat="server" DataSourceID="ObjectDataSource1"  OnRowDataBound="GridView1_RowDataBound">
            <Columns>
               <asp:BoundField DataField="Rows" HeaderStyle-Width="60px" HeaderText="行数"  SortExpression="Rows"/>
                <asp:BoundField DataField="Segment" HeaderStyle-Width="60px" HeaderText="段" SortExpression="Segment" />
                <asp:BoundField DataField="Contents" HeaderText="内容"  />
                <asp:BoundField DataField="CreateBy" HeaderText="建立人" />
                <asp:BoundField DataField="CreateTime" HeaderText="建立日期"  />
            </Columns>
        </asp:GridView>
        <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
            MaximumRowsParameterName="maxRows" SortParameterName="SortExpression"  TypeName="SKT.LeanMES.Wave.BLL.InterfaceManagement"
            SelectMethod="GetInterfaceManagementDef" SelectCountMethod="GetCount">
            <SelectParameters>
                <asp:Parameter Name="searchSettings" Type="Object" />
            </SelectParameters>
        </asp:ObjectDataSource>
    </div>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <script type="text/javascript">
        var InterfaceManagementId = <%= Request.QueryString["ID"] %>;
        var hdnOperate = $("#hdnOperate");
         var hdnIdString = $("#hdnIdString");
       
       $(function(){
         $("#searchField_content").remove();
        })

      function Add() {
          openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Wave/InterfaceManagementDefEdit.aspx?name=InterfaceManagementDefEdit&ID=-1&InterfaceManagementId=" + InterfaceManagementId;
          dialog({ title: mesLang("新增设备详情"), src: openWinUrl, width:400, height: 350 });
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr === "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Wave/InterfaceManagementDefEdit.aspx?name=InterfaceManagementDefEdit&ID=" + idStr + "&InterfaceManagementId=" + InterfaceManagementId;
            dialog({ title: mesLang("编辑设备详情"), src: openWinUrl, width: 400, height: 350 });
            return idStr;
        }

        function Delete() {
            var idStr = getOneRecordId();
            if (idStr === "") return false;
            hdnOperate.val("delete");
            hdnIdString.val(idStr);
            document.forms[0].submit();
            return idStr;
        }

        function Refresh() {
            document.forms[0].submit();
        }
        
    </script>
</asp:Content>