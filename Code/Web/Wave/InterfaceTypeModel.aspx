<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" CodeBehind="InterfaceTypeModel.aspx.cs" Inherits="SKT.LeanMES.Web.Wave.InterfaceTypeModel" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label4">设备类型</td>
            <td class="Field4">
                <select id="DeviceType" onchange="loadBrandType()">
                </select>
            </td>
            <td class="Label4">品牌型号</td>
            <td class="Field4">
                <select id="BrandType">
                </select>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" OnRowDataBound="GridView1_RowDataBound">
        <Columns>
            <asp:BoundField DataField="DeviceType" HeaderText="设备类型" />
            <asp:BoundField DataField="Brand" HeaderText="品牌型号" />
            <asp:BoundField DataField="CreateBy" HeaderText="创建人" />
            <asp:BoundField DataField="CreateTime" HeaderText="创建时间" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
            <asp:BoundField DataField="ModifyBy" HeaderText="<%$ Resources:lang, ModifyBy %>" />
            <asp:BoundField DataField="ModifyDateTime" HeaderText="<%$ Resources:lang, ModifyDateTime %>" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true"
        StartRowIndexParameterName="startRow" MaximumRowsParameterName="maxRows" SortParameterName="sortExpression"
        TypeName="SKT.LeanMES.Wave.BLL.DeviceInterfaceType" SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <input type="hidden" id="hdnDeviceType" class="hid-val" name="hdnDeviceType" runat="server" value="" />
    <input type="hidden" id="hdnBrandType" class="hid-val" name="hdnBrandType" runat="server" value="" />

    <script type="text/javascript">

        function clearOthers() {
            $(".hid-val").val("");
        }

        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");
         $(function () {
            $("#DeviceType").append("<option value=''>--请选择--</option>");
            $("#BrandType").append("<option value=''>--请选择--</option>");
            $("#BrandType").bind("change", function () {
               var BrandTypeValue= $("#BrandType").val() == "--请选择--" ? "" : $("#BrandType").val();
               $("#<%=this.hdnBrandType.ClientID %>").val(BrandTypeValue);
            });
            loadDeviceType();
            if ($("#<%=this.hdnDeviceType.ClientID %>").val() != "") {
                $("#DeviceType").val($("#<%=this.hdnDeviceType.ClientID %>").val())
                loadBrandType();
            }
            if ($("#<%=this.hdnBrandType.ClientID %>").val() != "") {
                $("#BrandType").val($("#<%=this.hdnBrandType.ClientID %>").val())
            }
        })
        function loadDeviceType() {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxInterfaceManagement.GetDeviceType();
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            if (ajax.value != "") {
                var data = ajax.value;               
                for (var i = 0; i < data.length; i++) {
                    $("#DeviceType").append('<option value=' + data[i].DeviceType + '>' + data[i].DeviceType + '</option>');
                }             
            }          
        }
        function loadBrandType() {          
            var deviceType = $("#DeviceType").find("option:selected").text() == "--请选择--" ? "" : $("#DeviceType").find("option:selected").text();
            $("#<%=this.hdnDeviceType.ClientID %>").val(deviceType);
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxInterfaceManagement.GetBrandType(deviceType);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            if (ajax.value != "") {
                var data = ajax.value;
                $("#BrandType option").remove();
                $("#BrandType").append("<option value=''>--请选择--</option>");
                for (var i = 0; i < data.length; i++) {
                    $("#BrandType").append('<option value=' + data[i].Brand + '>' + data[i].Brand + '</option>');
                }
            }
        }
        function Refresh() {
            document.forms[0].submit();
        }

        function Add() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Wave/InterfaceTypeModelEdit.aspx?name=InterfaceTypeModelAdd&ID=-1";
            dialog({ title: "<%= Resources.Pages.InterfaceTypeModelAdd %>", src: openWinUrl, width: 500, height: 300 });
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr === "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Wave/InterfaceTypeModelEdit.aspx?name=InterfaceTypeModelEdit&ID=" + idStr;
            dialog({ title: "<%= Resources.Pages.InterfaceTypeModelEdit %>", src: openWinUrl, width: 500, height: 300 });
            return idStr;
        }

        function Delete() {
            var idStr = getDeletingRecordIdString(); 
            if (idStr === "") return false;
            hdnOperate.val("delete");
            hdnIdString.val(idStr);
            document.forms[0].submit();
            return idStr;
        }
        
    </script>
</asp:Content>
