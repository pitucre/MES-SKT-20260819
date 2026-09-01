<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master"
    AutoEventWireup="true" CodeBehind="EquipmentInterfaceEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Wave.EquipmentInterfaceEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
      <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %></div>
    <asp:HiddenField runat="server" ID="txtHideId"/>
    <asp:HiddenField runat="server" ID="txtHideStatus"/>
    <asp:HiddenField runat="server" ID="txtHideCreateBy"/>
    <asp:HiddenField runat="server" ID="txtHideCreateDate"/>
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label2"> 
                设备类型
            </td>
            <td class="Field2">
                <select id="DeviceType" onchange="loadBrandType()">
                </select>
            </td>
           
        </tr>
        <tr>
            <td class="Label2">
               品牌型号
            </td>
            <td class="Field2">
              <select id="BrandType" >
                </select>
            </td>
           
        </tr>
        <tr>
            <td class="Label2">
               分割符号
            </td>
            <td class="Field2">
                <select id="ddlSplict">

                </select>
            </td>
          
        </tr>
        <tr>
            <td class="Label2">
             文件类型
            </td>
            <td class="Field2">
                <select id="ddlFileType">

                </select>
            </td>            
        </tr>
        <tr>
            <td class="Label2">
             OK对应字符
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtOKStr"  runat="server" CssClass="TextBox" MaxLength="100"></asp:TextBox>
            </td>    
            
        </tr>
        <tr>
            <td class="Label2">
             NG对应字符
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtNGStr"  runat="server" CssClass="TextBox" MaxLength="100"></asp:TextBox>
            </td>    
            
        </tr>
    </table>
    <input type="hidden" id="hdnDeviceType" name="hdnDeviceType" runat="server"  value=""/>
    <input type="hidden" id="hdnBrandType" name="hdnBrandType" runat="server"  value=""/>
    <input type="hidden" id="hdnFileType" name="hdnFileType" runat="server"  value=""/>
    <input type="hidden" id="hdnSplict" name="hdnSplict" runat="server"  value=""/>
    <script type="text/javascript">  
        var ID=<%= Request.QueryString["ID"] %>; 
        var isLoadDeviceType=false;    
        $(function () {
            loadDeviceType();
            loadFileType();
            loadDecollator();
            if(ID>0){

                $("#DeviceType").val($("#<%=this.hdnDeviceType.ClientID %>").val());
                loadBrandType();
                $("#BrandType").val($("#<%=this.hdnBrandType.ClientID %>").val());
                $("#ddlFileType").val($("#<%=this.hdnFileType.ClientID %>").val());
                $("#ddlSplict").val($("#<%=this.hdnSplict.ClientID %>").val());
            }   
        });

        function loadDeviceType() {     
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxInterfaceManagement.GetEquipmentType();
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            if (ajax.value != "") {
              $("#DeviceType option").remove();
                var data = ajax.value;
                $("#DeviceType").append("<option value=''>--请选择--</option>");
                $("#BrandType").append("<option value=''>--请选择--</option>");
                for (var i = 0; i < data.length; i++) {
                   $("#DeviceType").append('<option value=' + data[i].Name + '>' + data[i].Name + '</option>');
                }             
            }
            isLoadDeviceType=true;           
        }

        function loadBrandType() {
            //if(isLoadDeviceType==false){
            //        loadDeviceType();
            //}
            var deviceType = $("#DeviceType").find("option:selected").text();
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxInterfaceManagement.GetEquipmentBrandType(deviceType);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            $("#BrandType option").remove();
            $("#BrandType").append("<option value=''>--请选择--</option>");
            if (ajax.value != "") {
                var data = ajax.value;
                
                
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

        function Save(){
            $("#<%=this.hdnDeviceType.ClientID %>").val(($("#DeviceType").find("option:selected").text()=="--请选择--"?"":$("#DeviceType").find("option:selected").text()));
            $("#<%=this.hdnBrandType.ClientID %>").val(($("#BrandType").find("option:selected").text()=="--请选择--"?"":$("#BrandType").find("option:selected").text()));
            $("#<%=this.hdnSplict.ClientID %>").val(($("#ddlSplict").find("option:selected").text()=="--请选择--"?"":$("#ddlSplict").find("option:selected").text()));
            $("#<%=this.hdnFileType.ClientID %>").val(($("#ddlFileType").find("option:selected").text()=="--请选择--"?"":$("#ddlFileType").find("option:selected").text()));
            var deviceType =$("#<%=this.hdnDeviceType.ClientID %>").val();
            var brandType =$("#<%=this.hdnBrandType.ClientID %>").val();
            var splict =$("#<%=this.hdnSplict.ClientID %>").val();          
            var fileType =$("#<%=this.hdnFileType.ClientID %>").val();
            var OKStr =$("#<%=this.txtOKStr.ClientID %>").val();
            var NGStr =$("#<%=this.txtNGStr.ClientID %>").val();
            
            if(deviceType==""){
                alert("请选择设备类型！");
                return;
            }
            if(brandType==""){
                alert("请选择品牌型号！");
                return;
            }
            if(splict==""){
                alert("请选择分割符号！");
                return;
            }
            if(fileType==""){
                alert("请选择文件类型！");
                return;
            }
            var entity = {};
            entity.ID=ID;
            entity.DeviceType=deviceType;
            entity.BrandType=brandType
            entity.Split=splict;
            entity.FileType=fileType;
            entity.OKStr=OKStr;
            entity.NGStr=NGStr;
            
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxInterfaceManagement.EquipmentEdit(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert('<%=Resources.Messages.SaveInSuccess%>')
            parent.window.Refresh();
        }
    </script>
</asp:Content>