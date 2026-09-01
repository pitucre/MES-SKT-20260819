<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true"
    CodeBehind="ErrorList.aspx.cs" Inherits="SKT.LeanMES.Web.SystemConfiguration.ErrorList" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <table class="EditeContentTable" width="100%">
        <tr>
            <%--<td class="Label1">
                错误发生日期
            </td>
            <td class="Field1">
                <select id="selYear">
                </select>
                <select id="selMonth">
                </select>
                <input type="button" class="SearchButton" value="查询" id="btnSearch" style="margin-left: 10px;" />
            </td>--%>
           <td class="Label2">
                开始时间
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtBegTime" runat="server" class="DateTimeBox" Width="150" isRequired="1"
                    ClientIDMode="Static"></asp:TextBox>
            </td>
            <td class="Label2">
                结束时间
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtEndTime" runat="server" class="DateTimeBox" Width="150" isRequired="1"
                    ClientIDMode="Static"></asp:TextBox>
            </td>
            
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
     <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="ID" HeaderText="日志编号" />
            <asp:BoundField DataField="UserName" HeaderText="操作人" />
            <asp:BoundField DataField="ErrorMsg" HeaderText="错误信息" />
            <asp:BoundField DataField="Remark" HeaderText="异常信息" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="发生时间" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}"/>
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.SystemLog.BLL.SystemErrorLog"
        SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <script type="text/javascript">
        _isHms = true;
       
    </script>
</asp:Content>
