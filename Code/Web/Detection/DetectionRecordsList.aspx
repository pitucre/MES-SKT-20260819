<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" CodeBehind="DetectionRecordsList.aspx.cs" Inherits="SKT.LeanMES.Web.Detection.DetectionRecordsList" %>
<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" Runat="Server" >
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label4">检测项编码</td>
            <td class="Field4">
               <asp:TextBox ID="txtDetectionCode" runat="server" CssClass="TextBox"  ></asp:TextBox> 
            </td>
            <td class="Label4">工单</td>
            <td class="Field4">
               <asp:TextBox ID="txtOrderNo" runat="server" CssClass="TextBox" ></asp:TextBox>               
            </td>
            <td class="Label4">序号</td>
            <td class="Field4">
               <asp:TextBox ID="txtSN" runat="server" CssClass="TextBox" ></asp:TextBox>               
            </td>
            <td class="Label4">设备编码</td>
            <td class="Field4">
               <asp:TextBox ID="txtEquipment" runat="server" CssClass="TextBox"  ></asp:TextBox> 
            </td>
        </tr>
        <tr>            
            <td class="Label4">工序</td>
            <td class="Field4">
               <asp:TextBox ID="txtStation" runat="server" CssClass="TextBox" ></asp:TextBox>               
            </td>
            <td class="Label4">资源</td>
            <td class="Field4">
               <asp:TextBox ID="txtResName" runat="server" CssClass="TextBox" ></asp:TextBox>               
            </td>
            <td class="Label4">检验时间从</td>
            <td class="Field4">
               <asp:TextBox CssClass="DateTimeBox" ID="txtCheckBeginTime" runat="server"></asp:TextBox>               
            </td>
            <td class="Label4">到</td>
            <td class="Field4">
               <asp:TextBox ID="txtCheckEndTime" runat="server" CssClass="DateTimeBox" ></asp:TextBox>               
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" Runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="DetectionCode" HeaderText="检测项编码" />
            <asp:BoundField DataField="DetectionName" HeaderText="检测项名称" />          
            <asp:BoundField DataField="OrderNO" HeaderText="工单号" />
            <asp:BoundField DataField="Station" HeaderText="工序" />
            <asp:BoundField DataField="EquipmentCode" HeaderText="设备编码" />
            <asp:BoundField DataField="LineName" HeaderText="线别" />
            <asp:BoundField DataField="ResName" HeaderText="资源" />
            <asp:BoundField DataField="SN" HeaderText="序列号" />
            <asp:BoundField DataField="Result" HeaderText="检测结果" />
            <asp:BoundField DataField="Files" HeaderText="文件路径" />
            <asp:BoundField DataField="CreateBy" HeaderText="检测人" />
            <asp:BoundField DataField="CreateTime" HeaderText="检测时间" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />  
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" 
        StartRowIndexParameterName="startRow" MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" 
        TypeName="SKT.LeanMES.Detection.BLL.DetectionRecords" SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
 
</asp:Content>
