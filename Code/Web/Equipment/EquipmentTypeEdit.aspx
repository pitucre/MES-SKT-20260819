<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EquipmentTypeEdit.aspx.cs"
    Inherits="SKT.LeanMES.Web.Equipment.EquipmentTypeEdit" MasterPageFile="~/Masters/EditMaster.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div class="Label infoTips" style="margin-top: -5px; !margin-top: -25px;">
        <%=Resources.Messages.WithAsteriskIsRequired %>
    </div>
    <div class="clear5">
    </div>
    <table width="100%" class="EditeContentTable">
        <tr>
            <td id="tdParentType" class="Label1">上级类型名
            </td>
            <td class="Field1">
                <span id="ParentTypeName"></span>
            </td>
        </tr>
        <%--        <tr>
            <td class="Label1">
                <%= Resources.lang.EquipmentTypeCode%><em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtEquipmentTypeCode" runat="server" CssClass="TextBox" MaxLength="20" ClientIDMode="Static" IsRequired="1"></asp:TextBox>
            </td>
        </tr>--%>
        <tr>
            <td class="Label1">
                <%= Resources.lang.EquipmentTypeName%><em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtEquipmentTypeName" runat="server" ClientIDMode="Static" IsRequired="1"></asp:TextBox>
            </td>
        </tr>
        <tr name="trEquipment">
            <td class="Label1">
                <%= Resources.lang.IsLoading%><em>*</em>
            </td>
            <td class="Field1">
                <asp:CheckBox ID="cbLoading" runat="server" Checked="false" ClientIDMode="Static" />
            </td>
        </tr>
        <tr name="trEquipment" style="display: none">
            <td class="Label1">
                <%= Resources.lang.IsOffLine%><em>*</em>
            </td>
            <td class="Field1">
                <asp:CheckBox ID="cbOffLine" runat="server" Checked="false" ClientIDMode="Static" />
            </td>
        </tr>
        <tr name="trEquipment" style="display: none">
            <td class="Label1">
                <%= Resources.lang.IsScanPos%><em>*</em>
            </td>
            <td class="Field1">
                <asp:CheckBox ID="cbScanPos" runat="server" Checked="false" ClientIDMode="Static" />
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%= Resources.lang.Remark%>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtRemark" CssClass="TextArea" TextMode="MultiLine" runat="server"
                    ClientIDMode="Static"></asp:TextBox>
            </td>
        </tr>
    </table>
    <script type="text/javascript" src="../Content/js/jquery-3.1.0.min.js"></script>
    <script type="text/javascript">
        var Id = <%= Request.QueryString["Id"] == null ? -1 : Convert.ToInt32(Request.QueryString["Id"].ToString())%>
        var name = '<%= Request.QueryString["name"] == null ? "" : Request.QueryString["name"].ToString() %>';
        $(document).ready(function(){
            var Pname= getQueryString("parentName");
            $("#ParentTypeName").html(Pname);
            Pid=getQueryString("Pid");
            if($("#cbLoading").is(":checked")){
                $("#cbOffLine").parent().parent().show();
                $("#cbScanPos").parent().parent().show();
            }else{
                $("#cbOffLine").parent().parent().hide();
                $("#cbScanPos").parent().parent().hide();
            }
           
            if(Pname != "设备"){
                $("tr[name='trEquipment']").hide();
            }
        });
        $("#cbLoading").on("click",function(){
            if($("#cbLoading").is(":checked")){
                $("#cbOffLine").parent().parent().show();
                $("#cbScanPos").parent().parent().show();
            }else{
                $("#cbOffLine").parent().parent().hide();
                $("#cbScanPos").parent().parent().hide();
            }
        });
        function Save()
        {
            var errStr = "";
            var txtEquipmentTypeCode = $("#txtEquipmentTypeCode").val();
            var txtEquipmentTypeName = $("#txtEquipmentTypeName").val();

            var Loading = $("#cbLoading")[0].checked;
            var OffLine = $("#cbOffLine")[0].checked;
            var ScanPos = $("#cbScanPos")[0].checked;
        
            if (isNull(txtEquipmentTypeCode))
            {
                errStr += "<%=Resources.Messages.WithAsteriskIsRequiredAlert %>";
            }

            if (isNull(txtEquipmentTypeName))
            {
                errStr += "<%=Resources.Messages.WithAsteriskIsRequiredAlert %>";
            }

            var txtRemark = $("#txtRemark").val();
                
            if (errStr != "") 
            {
                alert(errStr);            
                return false;
            }

            var entity = {};
            entity.EquipmentTypeId = Id;
            entity.EquipmentTypeCode = txtEquipmentTypeName;
            entity.EquipmentTypeName = txtEquipmentTypeName;
            entity.IsLoading = Loading;
            entity.IsOffLine = OffLine;
            entity.IsScanPos = ScanPos;
            entity.Remark = txtRemark;
            entity.PID = Pid;       
        
            var ajax_EquipmentType = SKT.LeanMES.Web.AjaxServices.AjaxEquipment.EditEquipmentType(entity);
            if (ajax_EquipmentType.error !=null) 
            {
                alert(ajax_EquipmentType.error.Message);
                return false;
            }
            else
            {
                alert("<%= Resources.Messages.SaveSuccess%>");
            }   
            
            parent.window.UpdateList(txtEquipmentTypeName);       
        }

    </script>
</asp:Content>
