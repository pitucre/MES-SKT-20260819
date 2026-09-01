<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" 
CodeBehind="ShipmentList.aspx.cs" Inherits="SKT.LeanMES.Web.Shipment.ShipmentList" %>
<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1">
                <%=Resources.lang.ShippingOrderNumber%>
            </td>
            <td class="Field1" >
                <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
 <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" 
        onrowdatabound="GridView1_RowDataBound">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="OrderNO" HeaderText="<%$Resources:lang,ShippingOrderNumber %>"   />  
            <asp:BoundField DataField="ItemId" HeaderText="<%$Resources:lang,ItemName %>" ItemStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="Qty" HeaderText="<%$Resources:lang,Qty %>" ItemStyle-HorizontalAlign="Center"/>
            <asp:BoundField DataField="Qty" HeaderText="<%$Resources:lang,PartUnit%>"  ItemStyle-HorizontalAlign="Center"/>
            <asp:BoundField DataField="ShipDate" HeaderText="<%$Resources:lang,ShipDate%>"  ItemStyle-HorizontalAlign="Center"/>
            <asp:BoundField DataField="State" HeaderText="<%$Resources:lang,Status %>" ItemStyle-HorizontalAlign="Center"/>
            <asp:BoundField DataField="CreateDateTime" HeaderText="<%$Resources:lang,CreateDateTime %>" ItemStyle-HorizontalAlign="Center"/>
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" 
        StartRowIndexParameterName="startRow" MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" 
        TypeName="SKT.LeanMES.Shipment.BLL.Shipment" SelectMethod="GetAll" SelectCountMethod="GetCount">
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
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Shipment/ShipmentEdit.aspx?name=Production_ShipmentAdd&ID=-1";
            dialog({ title: "<%=Resources.Pages.Production_ShipmentAdd %>", src: openWinUrl, width: 650, height: 300 });
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxShipment.IsOperability(parseInt(idStr));
            if (true == ajax.value) {
                openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Shipment/ShipmentEdit.aspx?name=Production_ShipmentEdit&ID=" + idStr;
                dialog({ title: "<%=Resources.Pages.Production_ShipmentEdit %>", src: openWinUrl, width: 600, height: 300 });
            }
            else {
                alert("已审核和已发货的不允许修改！");
            }
        }

        function Delete() {
             var idStr = getOneRecordId();
            if (idStr == "") return false;
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxShipment.IsOperability(parseInt(idStr));
            if (true != ajax.value) {
                alert("<%=Resources.Messages.AuditOrShipmentNotDelete %>！");
                return;
            }
            idStr = getDeletingRecordIdString();
            if (idStr == "") return false;
            hdnOperate.val("delete");
            hdnIdString.val(idStr);
            document.forms[0].submit();
        }

        function Refresh() {
            document.forms[0].submit();
        }

        function Audi(flag) {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            var msg = "";
            if (flag == 1) {
                msg = "<%=Resources.Messages.AreYouSureAudit %>";
            }
            else if (flag == 2) {
                msg = "<%=Resources.Messages.AreYouSureAbandon %>";
            }
            if (confirm(msg)) {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxShipment.Audi(parseInt(idStr), parseInt(flag));
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }
                if (parseInt(ajax.value) ==-2 ) {
                    alert("已发货不允许修改！");
                    return;
                }
                else if (parseInt(flag) == 1) {
                    if (parseInt(ajax.value) > 0) {
                        alert("<%=Resources.Messages.AuditSuccess %>");
                    }
                    else if (parseInt(ajax.value) == 0) {
                        alert("<%=Resources.Messages.Audited %>！");
                    }
                    else {
                        alert("<%=Resources.Messages.NonOperational %>");
                    }
                }
                else if (parseInt(flag) == 2) {
                    if (parseInt(ajax.value) > 0) {
                        alert("<%=Resources.Messages.AbandonSuccess %>");
                    }
                    else if (parseInt(ajax.value) == 0) {
                        alert("<%=Resources.Messages.Abandoned %>");
                    }
                    else {
                        alert("<%=Resources.Messages.NonOperational %>");
                    }
                }
                Refresh();
            }
            
        }

        function View() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Shipment/ShipmentView.aspx?ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.Production_ShipmentView %>", src: openWinUrl, width: 600, height: 300 });
        }

    </script>
</asp:Content>
