<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" CodeBehind="DetectionItemList.aspx.cs" Inherits="SKT.LeanMES.Web.Detection.DetectionItemList" %>
<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" Runat="Server" >
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">检测项编码</td>
            <td class="Field2">
               <asp:TextBox ID="txtDetectionCode" runat="server" CssClass="TextBox"  ></asp:TextBox> 
            </td>
            <td class="Label2">检测项名称</td>
            <td class="Field2">
               <asp:TextBox ID="txtDetectionName" runat="server" CssClass="TextBox" ></asp:TextBox>               
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" Runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" OnRowDataBound="GridView1_RowDataBound">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="DetectionCode" HeaderText="检测项编码" />
            <asp:BoundField DataField="DetectionName" HeaderText="检测项名称" />
            <asp:BoundField DataField="DetectionDesc" HeaderText="检测项描述" />
            <asp:BoundField DataField="Versions" HeaderText="版本" />
            <asp:BoundField DataField="Station" HeaderText="工序" />
            <asp:BoundField DataField="SL" HeaderText="SL" />
            <asp:BoundField DataField="USL" HeaderText="USL" />
            <asp:BoundField DataField="LSL" HeaderText="LSL" />
            <asp:BoundField DataField="CL" HeaderText="CL" />
            <asp:BoundField DataField="UCL" HeaderText="UCL" />
            <asp:BoundField DataField="LCL" HeaderText="LCL" />
            <asp:BoundField DataField="CreateBy" HeaderText="创建人" />
            <asp:BoundField DataField="CreateTime" HeaderText="创建时间" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />  
            <asp:BoundField DataField="ModifyBy" HeaderText="修改人" />
            <asp:BoundField DataField="ModifyTime" HeaderText="修改时间" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />  
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" 
        StartRowIndexParameterName="startRow" MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" 
        TypeName="SKT.LeanMES.Detection.BLL.DetectionItem" SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value=""/>
    <input type="hidden" id="hdnIdString" name="hdnIdString"  value=""/>

    <script type="text/javascript">
        isMultiple = false;
        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");
        function Add() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Detection/DetectionItemEdit.aspx?name=DetectionItemAdd&ID=-1";
            dialog({ title: "<%=Resources.Pages.DetectionItemAdd %>", src: openWinUrl, width: 700, height: 420});
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Detection/DetectionItemEdit.aspx?name=DetectionItemEdit&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.DetectionItemEdit %>", src: openWinUrl, width: 700, height: 420 });
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
