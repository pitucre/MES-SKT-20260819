<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" CodeBehind="InterfaceManagementList.aspx.cs" Inherits="SKT.LeanMES.Web.Wave.InterfaceManagementList" %>

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
        <tr>
            <td class="Label4">文件类型</td>
            <td class="Field4">
                <asp:DropDownList ID="ddlFileType" runat="server">
                    <asp:ListItem Value=''>--请选择--</asp:ListItem>
                    <asp:ListItem Value="Excel">Excel</asp:ListItem>
                    <asp:ListItem Value="CSV">CSV</asp:ListItem>
                    <asp:ListItem Value="XML">XML</asp:ListItem>
                    <asp:ListItem Value="TXT">TXT</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td class="Label4"></td>
            <td class="Field4">
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1">
        <Columns>
            <asp:BoundField DataField="DeviceType" HeaderText="设备类型" />
            <asp:BoundField DataField="Brand" HeaderText="品牌型号" />
            <asp:BoundField DataField="TargetFileDir" HeaderText="目标文件目录" />
            <asp:BoundField DataField="FileType" HeaderText="文件类型" />
            <asp:BoundField DataField="DefaultUserName" HeaderText="默认用户" />
            <asp:BoundField DataField="NCCode" HeaderText="不良代码" />
            <asp:BoundField DataField="LineName" HeaderText="线别名称" />
            <asp:BoundField DataField="IsCoupletName" HeaderText="是否联版" />
            <asp:BoundField DataField="ModifyBy" HeaderText="修改人" />
            <asp:BoundField DataField="ModifyDateTime" HeaderText="修改时间" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true"
        StartRowIndexParameterName="startRow" MaximumRowsParameterName="maxRows" SortParameterName="sortExpression"
        TypeName="SKT.LeanMES.Wave.BLL.DeviceInterface" SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <input type="hidden" id="hdnDeviceType" class="hid-val" name="hdnDeviceType" runat="server" value="" />
    <input type="hidden" id="hdnBrandType" class="hid-val" name="hdnBrandType" runat="server" value="" />

    <script type="text/javascript">
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");
        $(function () {
            $("#DeviceType").append("<option value=''>--请选择--</option>");
            $("#BrandType").append("<option value=''>--请选择--</option>");
            $("#BrandType").bind("change", function () {
                var BrandTypeValue = $("#BrandType").val() == "--请选择--" ? "" : $("#BrandType").val();
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


        function View() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Wave/InterfaceManagementView.aspx?&id=" + idStr;
            dialog({ title: mesLang("设备接口详情"), src: openWinUrl, width: 1000, height: 300 });
        }

        function Refresh() {
            document.forms[0].submit();
        }

        function Add() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Wave/InterfaceManagementEdit.aspx?name=InterfaceManagementEdit&id=-1";
            dialog({ title: mesLang("新增设备接口"), src: openWinUrl, width: 1000, height: 550 });
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr === "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Wave/InterfaceManagementEdit.aspx?name=InterfaceManagementEdit&id=" + idStr;
            dialog({ title: mesLang("编辑设备接口"), src: openWinUrl, width: 1000, height: 550 });
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

        function clearOthers() {
            $(".hid-val").val("");
        }        
    </script>
</asp:Content>
