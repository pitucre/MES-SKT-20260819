<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DataDistributionSYBSelect.aspx.cs" MasterPageFile="~/Masters/ChooseListMaster.master" Inherits="SKT.LeanMES.Web.DataDistribution.DataDistributionSYBSelect" %>

<%@ MasterType VirtualPath="~/Masters/ChooseListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
<table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1">
                事业部名称
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtDepartName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
<asp:GridView ID="GridView1" AutoGenerateColumns="false" runat="server" DataSourceID="ObjectDataSource1">
        <Columns>
            <asp:BoundField DataField="DepartCode" HeaderText="事业部编号" />
            <asp:BoundField DataField="DepartName" HeaderText="事业部名称" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.DataDistribution.BLL.DataDistributionSYBConfig"
        SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    
    <div style=" height:38px; ">
        <div id="loading" style="display: none; z-index: 111;">
            <div style="background: #cccccc; position: absolute; z-index: 112; top: 0; left: 0px;
                filter: Alpha(opacity=60); -moz-opacity: 0.6; opacity: 0.6;" id="loading-bg">
            </div>
            <div style="position: absolute; top: 35%; left: 35%; z-index: 113; background: #f7f7f7;
                width: 360px; border: 1px solid #333333; height: 65px; line-height: 65px; text-align: center;"
                id="loading-content">
                正在下发数据，请不要关闭页面...
            </div>
        </div>
    </div>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="search" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <script type="text/javascript">
        var typename = '<%= Request.QueryString["name"] %>';
        var pra = '<%= Request.QueryString["pra"] %>';
        isMultiple = true;
        $(document).ready(function () {
            $("#loading").css("display", "none");
        });
        var userName = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>';
        var SerialNumberList = pra;
        if (typename == "MaterialDataDistributionOperate") {
            SerialNumberList = localStorage.getItem('SerialNumberList');
            localstorage.removeItem('SerialNumberList');
        }else if (typename == "SupplierDataDistributionOperate") {
            SerialNumberList = localStorage.getItem('SupplierNumberList');
            localstorage.removeItem('SupplierNumberList');
        } else if (typename == "CustomerDataDistributionOperate") {
            SerialNumberList = localStorage.getItem('CustomerNumberList');
            localstorage.removeItem('CustomerNumberList');
        } else if (typename == "ShopOrderDataDistributionOperate") {
            SerialNumberList = localStorage.getItem('ShopOrderNumberList');
            localstorage.removeItem('ShopOrderNumberList');
        }
        function DataDistributionOperate() {
            if (!SerialNumberList) {
                alert("下发的数据不存在,请与管理员确认!");
                return false;
            }
            //xiang.yan 2024-4-29 根据列号去值，改为根据列名取值,菜单已取消
            // 1 改为 DepartCode
            var DepartCodeList = getRecordCellTextsByFiled("DepartCode"); 
            if (!DepartCodeList) {
                return false;
            }
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxDataDistribution.DataDistributionOp(SerialNumberList, DepartCodeList, userName, typename);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            $("#loading").css("display", "none");
            alert("数据下发成功!");
            parent.parent.window.Refresh();
        }
    </script>
</asp:Content>
