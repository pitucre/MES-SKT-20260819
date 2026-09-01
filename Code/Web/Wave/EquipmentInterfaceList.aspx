<%@ Page Language="C#" MasterPageFile="~/Masters/ListMaster.master"
    AutoEventWireup="true" CodeBehind="EquipmentInterfaceList.aspx.cs" Inherits="SKT.LeanMES.Web.Wave.EquipmentInterfaceList" %>
<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
      <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label4">设备类型：</td>
            <td class="Field4">
                <select id="DeviceType" onchange="loadBrandType()">
                </select>
            </td>
            <td class="Label4">品牌型号：</td>
            <td class="Field4">
                 <select id="BrandType">
                </select>
            </td>
          
        </tr>
         <tr>
             <td class="Label4">分割符号：</td>
            <td class="Field4">
                <select id="ddlSplict">

                </select>
            </td>
             <td class="Label4">文件类型</td>
            <td class="Field4">
                <select id="ddlFileType">

                </select>
            </td>
         </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
     <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" >
        <Columns>
         <%--    <asp:BoundField DataField="ID" HeaderText="序号"  />--%>
            <asp:BoundField DataField="DeviceType" HeaderText="设备类型" />
            <asp:BoundField DataField="BrandType" HeaderText="品牌型号" />
            <asp:BoundField DataField="Split" HeaderText="分割符号" />
            <asp:BoundField DataField="FileType" HeaderText="文件类型" />
            <asp:BoundField DataField="OKStr" HeaderText="OK对应字符" />
            <asp:BoundField DataField="NGStr" HeaderText="NG对应字符" />
            <asp:BoundField DataField="CreateBy" HeaderText="创建人" />
            <asp:BoundField DataField="CreateTime" HeaderText="创建时间" />         
             <asp:BoundField DataField="ModifyBy" HeaderText="<%$ Resources:lang, ModifyBy %>" />
            <asp:BoundField DataField="ModifyTime" HeaderText="<%$ Resources:lang, ModifyDateTime %>" />  
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" 
        StartRowIndexParameterName="startRow" MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" 
        TypeName="SKT.LeanMES.Wave.BLL.InterfaceManagement" SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value=""/>
    <input type="hidden" id="hdnIdString" name="hdnIdString"  value=""/>
    <input type="hidden" id="hdnDeviceType" class="hid-val" name="hdnDeviceType" runat="server"  value=""/>
    <input type="hidden" id="hdnBrandType" class="hid-val" name="hdnBrandType" runat="server"  value=""/>
    <input type="hidden" id="hdnFileType" class="hid-val" name="hdnFileType" runat="server"  value=""/>
    <input type="hidden" id="hdnSplict" class="hid-val" name="hdnSplict" runat="server"  value=""/>

    <script type="text/javascript">
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");
        $(function () {
            $("#DeviceType").append("<option value=''>--请选择--</option>");
            $("#BrandType").append("<option value=''>--请选择--</option>");
            $("#ddlFileType").append("<option value=''>--请选择--</option>");
            $("#ddlSplict").append("<option value=''>--请选择--</option>");

            $("#BrandType").bind("change", function () {
               var BrandTypeValue= $("#BrandType").val() == "--请选择--" ? "" : $("#BrandType").val();
               $("#<%=this.hdnBrandType.ClientID %>").val(BrandTypeValue);
            });

            $("#ddlSplict").bind("change", function () {
                var Splict = $("#ddlSplict").val() == "--请选择--" ? "" : $("#ddlSplict").val();
                $("#<%=this.hdnSplict.ClientID %>").val(Splict);
             });

            $("#ddlFileType").bind("change", function () {
                var FileType = $("#ddlFileType").val() == "--请选择--" ? "" : $("#ddlFileType").val();
                $("#<%=this.hdnFileType.ClientID %>").val(FileType);
            });

            loadDeviceType();
            if ($("#<%=this.hdnDeviceType.ClientID %>").val() != "") {
                $("#DeviceType").val($("#<%=this.hdnDeviceType.ClientID %>").val())
                loadBrandType();
            }
            if ($("#<%=this.hdnBrandType.ClientID %>").val() != "") {
                $("#BrandType").val($("#<%=this.hdnBrandType.ClientID %>").val())
            }
            loadFileType();
            loadDecollator();

            if ($("#<%=this.hdnSplict.ClientID %>").val() != "") {
                $("#ddlSplict").val($("#<%=this.hdnSplict.ClientID %>").val())
            }

            if ($("#<%=this.hdnFileType.ClientID %>").val() != "") {
                $("#ddlFileType").val($("#<%=this.hdnFileType.ClientID %>").val())
            }
        })
        function loadDeviceType() {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxInterfaceManagement.GetEquipmentType();
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            if (ajax.value != "") {
                var data = ajax.value;               
                for (var i = 0; i < data.length; i++) {
                   $("#DeviceType").append('<option value=' + data[i].Name + '>' + data[i].Name + '</option>');
                }             
            }          
        }

        function loadBrandType() {          
            var deviceType = $("#DeviceType").find("option:selected").text() == "--请选择--" ? "" : $("#DeviceType").find("option:selected").text();
            $("#<%=this.hdnDeviceType.ClientID %>").val(deviceType);
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxInterfaceManagement.GetEquipmentBrandType(deviceType);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            if (ajax.value != "") {
                var data = ajax.value;
                $("#BrandType option").remove();
                $("#BrandType").append("<option value=''>--请选择--</option>");
                for (var i = 0; i < data.length; i++) {
                    $("#BrandType").append('<option value=' + data[i].Name + '>' + data[i].Name + '</option>');
                }           
            }
        }

        function loadFileType() {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxInterfaceManagement.GetFileType();
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            if (ajax.value != "") {
                var data = ajax.value;
                for (var i = 0; i < data.length; i++) {
                    $("#ddlFileType").append('<option value=' + data[i].Name + '>' + data[i].Name + '</option>');
                }
            }
        }

        function loadDecollator() {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxInterfaceManagement.GetDecollator();
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            if (ajax.value != "") {
                var data = ajax.value;
                for (var i = 0; i < data.length; i++) {
                    $("#ddlSplict").append('<option value=' + data[i].Name + '>' + data[i].Name + '</option>');
                }
            }
        }


        function View() {         
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Wave/InterfaceManagementView.aspx?name=InterfaceManagementView&ID=" + idStr;
            dialog({ title: mesLang("设备接口详情"), src: openWinUrl, width: 800, height: 450 });
        }
        
        function Refresh() {
            document.forms[0].submit();
        }

        function Add() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Wave/EquipmentInterfaceEdit.aspx?name=EquipmentInterfaceEdit&ID=-1";
            dialog({ title: mesLang("新增设备接口"), src: openWinUrl, width:500, height: 350 });
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr === "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Wave/EquipmentInterfaceEdit.aspx?name=EquipmentInterfaceEdit&ID=" + idStr;
            dialog({ title: mesLang("编辑设备接口"), src: openWinUrl, width: 500, height: 350 });
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
