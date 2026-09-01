<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SMTStatusList.aspx.cs"
    Inherits="SKT.LeanMES.Web.SMT.SMTStatusList" MasterPageFile="~/Masters/ListMaster.master" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label3">工单号码
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtOrderNo" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">产品编码
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtItemCode" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
             <td class="Label3">
                排程工单号码
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtFBILLNO" runat="server" CssClass="TextBox" ></asp:TextBox>
            </td>
        </tr>      
        <tr> 
            <td class="Label3">GRN号码
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtSerialNumber" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">
                物料编码
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtMatItemCode" runat="server" CssClass="TextBox" ></asp:TextBox>
            </td>
            <td class="Label3">
                制造商编码
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtVendorCode" runat="server" CssClass="TextBox" ></asp:TextBox>
            </td>
        </tr>
        <tr> 
            <td class="Label3">生产线
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtLineName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">
                机台名称
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtEquipmentName" runat="server" CssClass="TextBox" ></asp:TextBox>
            </td>
            <td class="Label3">
                上料时间
            </td>
            <td class="Field3">
                <asp:TextBox CssClass="DateTimeBox" ID="txtCreateTimeStart" style="width:76px;" runat="server"></asp:TextBox> - <asp:TextBox CssClass="DateTimeBox" ID="txtCreateTimeEnd"  style="width:76px;" runat="server"></asp:TextBox>
            </td>
        </tr>
    </table>
   
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" style="table-layout:fixed;word-wrap: break-word; word-break: break-all;">
        <Columns>
            <asp:BoundField DataField="OrderNO" HeaderText="工单号码"  HeaderStyle-Width="130px" />  
            <asp:BoundField DataField="ItemCode" HeaderText="产品编码" HeaderStyle-Width="130px" />
            <asp:BoundField DataField="ItemName" HeaderText="产品名称" HeaderStyle-Width="130px" />
            <asp:BoundField DataField="ItemSpec" HeaderText="产品规格" HeaderStyle-Width="130px" />
            <asp:BoundField DataField="Actual_Start_Date" HeaderText="工单开始时间"  HeaderStyle-Width="80px" />
            <asp:BoundField DataField="Actual_Completed_Date" HeaderText="工单完成时间" HeaderStyle-Width="80px"  />
            <asp:BoundField DataField="FBILLNO" HeaderText="排程工单号码" HeaderStyle-Width="130px" />
                 <asp:TemplateField HeaderText="排程工单数量"  HeaderStyle-Width="100px">
                <ItemTemplate>
                    <%#Eval("FQty","{0:G0}").ToString() %>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="FPlanCommitDate" HeaderText="排程工单计划开工时间" HeaderStyle-Width="140px" />
            <asp:BoundField DataField="FPlanFinishDate" HeaderText="排程工单计划完工时间"  HeaderStyle-Width="140px"  />
            <asp:BoundField DataField="SerialNumber" HeaderText="GRN号码" HeaderStyle-Width="130px" />
            <asp:BoundField DataField="MatItemCode" HeaderText="物料编码" HeaderStyle-Width="130px" />
            <asp:BoundField DataField="MatItemName" HeaderText="物料名称" HeaderStyle-Width="130px" />
            <asp:BoundField DataField="MatItemSpec" HeaderText="物料规格" HeaderStyle-Width="130px"  />
            <asp:BoundField DataField="VendorCode" HeaderText="制造商编码" HeaderStyle-Width="100px"  />
            <asp:BoundField DataField="VendorName" HeaderText="制造商名称" HeaderStyle-Width="150px" />
            <asp:BoundField DataField="DateCode" HeaderText="制造生产日期" HeaderStyle-Width="100px" />
            <asp:BoundField DataField="Batch" HeaderText="制造生产批次" HeaderStyle-Width="130px"  />
            <asp:BoundField DataField="MPN" HeaderText="MPN" HeaderStyle-Width="130px" /> 
            <asp:BoundField DataField="LineName" HeaderText="生产线" HeaderStyle-Width="100px" />
            <asp:BoundField DataField="EquipmentCode" HeaderText="机台编码" HeaderStyle-Width="130px" />
            <asp:BoundField DataField="EquipmentName" HeaderText="机台名称" HeaderStyle-Width="130px" />
            <asp:BoundField DataField="SequenceNo" HeaderText="机台顺序" HeaderStyle-Width="60px" />
            <asp:BoundField DataField="LoadingListName" HeaderText="上料清单名称" HeaderStyle-Width="130px" />
            <asp:BoundField DataField="TableName" HeaderText="面" HeaderStyle-Width="60px"  />
            <asp:BoundField DataField="Area" HeaderText="区" HeaderStyle-Width="60px"  />            
            <asp:BoundField DataField="Position" HeaderText="站位" HeaderStyle-Width="130px" />
            <asp:BoundField DataField="Point" HeaderText="位置" HeaderStyle-Width="130px" />
             <asp:TemplateField  HeaderText="是否主料" HeaderStyle-Width="60px" >
                <ItemTemplate>
                    <%#Eval("IsMain").ToString() == "True"?"是":"否" %>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="MainItemCode" HeaderText="主料物料编码" HeaderStyle-Width="130px" />
            <asp:BoundField DataField="MainItemName" HeaderText="主料物料名称" HeaderStyle-Width="130px" />
            <asp:BoundField DataField="SmtNum" HeaderText="用量" HeaderStyle-Width="60px" />             
            <asp:TemplateField  HeaderText="是否离线备料" HeaderStyle-Width="100px" >
                <ItemTemplate>
                    <%#Eval("IsBindFeeder").ToString() == "True"?"是":"否" %>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="FeederSN" HeaderText="feeder号码" HeaderStyle-Width="130px" />
            <asp:BoundField DataField="FeederType" HeaderText="feeder类型" HeaderStyle-Width="130px" />
            <asp:BoundField DataField="BindPerson" HeaderText="最近绑定人" HeaderStyle-Width="80px" />
            <asp:BoundField DataField="BindTime" HeaderText="最新绑定时间" HeaderStyle-Width="80px"   />
            <asp:BoundField DataField="UnBindPerson" HeaderText="最近解绑人" HeaderStyle-Width="80px" />
            <asp:BoundField DataField="UnBindTime" HeaderText="最近解绑时间" HeaderStyle-Width="80px"  /> 
            <asp:BoundField DataField="LoadingPerson" HeaderText="上料人" HeaderStyle-Width="80px" />
            <asp:BoundField DataField="LoadingTime" HeaderText="上料时间" HeaderStyle-Width="80px"  />
            <asp:TemplateField HeaderText="上料时的数量"  HeaderStyle-Width="100px">
                <ItemTemplate>
                    <%#Eval("LoadingQty","{0:G0}").ToString() %>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="UnLoadingPerson" HeaderText="下料人" HeaderStyle-Width="80px" />
            <asp:BoundField DataField="UnLoadingTime" HeaderText="下料时间" HeaderStyle-Width="80px"   />
            <asp:TemplateField HeaderText="下料时的数量"  HeaderStyle-Width="100px">
                <ItemTemplate>
                    <%#Eval("UnLoadingQty","{0:G0}").ToString() %>
                </ItemTemplate>
            </asp:TemplateField>
               <asp:TemplateField HeaderText="使用数量"  HeaderStyle-Width="100px">
                <ItemTemplate>
                    <%#Eval("UseQty","{0:G0}").ToString() %>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="LastOperate" HeaderText="当前操作" HeaderStyle-Width="100px" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.SMT.BLL.Loadinglist"
        SelectMethod="GetMaterialHistory" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <asp:HiddenField runat="server" ID="hfShowTbInfo" ClientIDMode="Static" Value="0" />
    <script type="text/javascript">
        var isMultiple = false;
        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");
        
        function saveExcel() {
            var hdnOperate = $("#hdnOperate");
            hdnOperate.val("ExportExcel");
            document.forms[0].submit();
            hdnOperate.val("");

        }

    </script>


</asp:Content>
