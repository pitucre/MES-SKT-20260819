<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="MaterialUnitEditSuply.aspx.cs" Inherits="SKT.LeanMES.Web.SuplyMaterial.MaterialUnitEditSuply" %>

<%@ MasterType VirtualPath="~/Masters/EditMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">
                 物料条码
            </td>
            <td class="Field2">
                <asp:Label ID="txtSerialNumber" runat="server" Text="Label"></asp:Label>
            </td>
             <td class="Label2">
                批次号
            </td>
            <td class="Field2">
               <asp:Label ID="txtLotCode" runat="server" Text="Label"></asp:Label>
            </td>         
        </tr>
         <tr>
            <td class="Label2">
                生产日期
            </td>
            <td class="Field2">
               <asp:Label ID="txtDateCode" runat="server" Text="Label"></asp:Label>
            </td>
            <td class="Label2"> 
               供应商料号
            </td>
            <td class="Field2" colspan="3">
                <asp:Label ID="txtMPN" runat="server" Text="Label"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                产品名称
            </td>
            <td class="Field2">
             <asp:Label ID="txtItemName" runat="server" Text="Label"></asp:Label>
            </td>
            <td class="Label2"> 
               产品描述
            </td>
            <td class="Field2" colspan="3">
              <asp:Label ID="txtItemDesc" runat="server" Text="Label"></asp:Label>
            </td>
        </tr>        
        <tr>
            <td class="Label2">
                 总量
            </td>
            <td class="Field2">
               <asp:Label ID="txtBalanceQty" runat="server" Text="Label"></asp:Label>
            </td>
           <td class="Label2">
                 剩余数量
            </td>
            <td class="Field2">
               <asp:Label ID="txtCurrentQty" runat="server" Text="Label"></asp:Label>
            </td>
        </tr>
         <tr>
             <td class="Label2">
                状态
            </td>
            <td class="Field2">
               <asp:Label ID="txtStatus" runat="server" Text="Label"></asp:Label>
            </td>
            <td class="Label2">
                创建人
            </td>
            <td class="Field2">
              <asp:Label ID="txtCreate" runat="server" Text="Label"></asp:Label>
            </td>
        </tr>
         <tr>
         <td class="Label2">
                 生成物料条码时间
            </td>
            <td class="Field2">
               <asp:Label ID="txtCreateTime" runat="server" Text="Label"></asp:Label>
            </td>
            <td class="Label2">
                 入库时间
            </td>
            <td class="Field2" >
               <asp:Label ID="txtStorageTime" runat="server" Text="Label"></asp:Label>
            </td>
        </tr>
    </table>
    <div class="clear5">
    </div>
    <link href="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/calendar/skin/datepicker.css" rel="stylesheet" type="text/css" />
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/calendar/js/jquery.ui.core.js"
        type="text/javascript"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/calendar/js/jquery.ui.datepicker.js"
        type="text/javascript" charset="GBK"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/calendar/js/jquery.ui.datepicker.zn.js"
        type="text/javascript"></script> 
    <script type="text/javascript">
        var uNITID = '<%= Request.QueryString["ID"] %>';

        function Save() {
            var errStr = "";
            var textLotCode = $("#txtLotCode").val();
            var txtProdDate = $("#txtProdDate").val();

            /*生产日期必须输入 add by watson 2015-03-31*/
            if (txtProdDate == "") {
                errStr += "<%=Resources.Messages.WithAsteriskIsRequiredAlert %>\n";
            }
            if (errStr != "") {
                alert(errStr);
                return false;
            }

            if (uNITID == null || uNITID == -1) {
                alert("<%=Resources.Messages.InvalidateParameter %>");
                return false;
            }

            var entity = {};
            entity.ID = uNITID;
            entity.LotCode = textLotCode;
            entity.DateCode = txtProdDate;

            var ajaxsave = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.EditMaterailUnitGRN(entity);
            if (ajaxsave.error != null) {
                alert(ajaxsave.error.Message);
                return false;
            }
            alert('<%=Resources.Messages.SaveSuccess %>');
            parent.window.UpdateList($("#txtSerialNumber").val());
        }

    </script>
</asp:Content>
