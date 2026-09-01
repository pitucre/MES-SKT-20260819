<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" CodeBehind="InjectionAnormalList.aspx.cs" Inherits="SKT.LeanMES.Web.SDP.InjectionAnormalList" %>
<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>

<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
     <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" OnRowDataBound="GridView1_RowDataBound" DataKeyNames="AnormalObject">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="AbnormalDocumentNo" HeaderText="异常单号" SortExpression="LineName" />
            <asp:BoundField DataField="LineName" HeaderText="线别" SortExpression="LineName" />
            <asp:BoundField DataField="AnormalTypeName" HeaderText="异常类型" SortExpression="AnormalTypeName" />
            <asp:BoundField DataField="AnormalName" HeaderText="异常名称"/>
            <asp:BoundField DataField="Station" HeaderText="工位" SortExpression="Station" />
            <asp:BoundField DataField="CreateBy" HeaderText="异常录入人" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="异常录入时间" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
            <asp:BoundField DataField="DeptName" HeaderText="异常部门"/>
            <asp:BoundField DataField="Status" HeaderText="状态"  SortExpression="Status"/>
            <asp:BoundField DataField="Descriptions" HeaderText="异常描述" />
            <asp:BoundField DataField="IsLineStop" HeaderText="是否停线" SortExpression="IsLineStop"/>
            <asp:BoundField DataField="AbnormalTimeLength" HeaderText="时长" DataFormatString="{0:G0}" SortExpression="AbnormalTimeLength"/>
            <asp:BoundField DataField="AbnormalUnit" HeaderText="时长单位" />
            <asp:BoundField DataField="EffectPerson" HeaderText="影响人数" DataFormatString="{0:G0}"/>
            <asp:BoundField DataField="ModifyBy" HeaderText="修改人"/>
            <asp:BoundField DataField="ModifyDateTime" HeaderText="修改时间" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}"/>
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.ProdAnormal.BLL.Anormal"
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
        var chooseFlag = -1;
        _isHms = true;
        $("#searchField").hide();
        $("#updownSearchContainer1").parent().hide();
         
         
    </script>
</asp:Content>
