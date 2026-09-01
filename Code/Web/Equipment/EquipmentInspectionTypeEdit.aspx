<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    CodeBehind="EquipmentInspectionTypeEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Equipment.EquipmentInspectionTypeEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
<div class="infoTips">
                <em>*</em><span>为必填项</span></div>
    <table class="EditeContentTable" width="100%">
        
        <tr>
            <asp:HiddenField ID="txtHideInspectionTypeId" runat="server" />
            <asp:HiddenField ID="txtHideCreater" runat="server" />
            <asp:HiddenField ID="txtHideCreateTime" runat="server" />
            <td class="Label2">
                <%=Resources.lang.InspectionTypeName %><em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox runat="server" ID="txtInspectionName" IsRequired='1'></asp:TextBox>
            </td>
            <td class="Label2">
                <%=Resources.lang.Status %><em>*</em>
            </td>
            <td class="Field2">
                <asp:DropDownList runat="server" ID="ddlStatus">
                    <asp:ListItem>启用</asp:ListItem>
                    <asp:ListItem>禁用</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
        <td class="Label2">
                点检类型<em>*</em>
            </td>
           <td class="Field2">                  
                <asp:DropDownList ID="ddlSystemType" IsRequired="1" ClientIDMode="Static" runat="server">
                <asp:ListItem Value="">--请选择--</asp:ListItem>
                <asp:ListItem Value="1">点检</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td class="Label2">
                <%=Resources.lang.Description %>
            </td>
            <td class="Field2">
                <asp:TextBox runat="server" ID="txtDescription"></asp:TextBox>
            </td>
            
            <%--<td class="Label2">
                <%= Resources.lang.SerialNumberType %>
            </td>
            <td class="Field2">
                <asp:DropDownList ID="ddlNextType" runat="server">
                </asp:DropDownList> 
            </td>--%>
        </tr>
    </table>
    <script language="javascript" type="text/javascript">
        var ReqId = '<%=Request.QueryString["ID"] %>';
        $("select").css("width", "140px");
        /*保存数据*/
        function Save() {
            var entity = {};
            entity.InspectionTypeId = ReqId;
            entity.InspectionTypeName = $("#<%=this.txtInspectionName.ClientID %>").val();
            //                entity.Creater = $("#<%=this.txtHideCreater.ClientID %>").val();
            entity.Creater = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
            entity.Status = $("#<%=this.ddlStatus.ClientID %>").val() == '启用' ? true : false;
            entity.Description = $("#<%=this.txtDescription.ClientID %>").val();
            entity.InspectionRuleIdList = "";
            entity.GenerateNumberTypeId = -1;
            entity.SystemType = $("#<%=this.ddlSystemType.ClientID %>").val();
            
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEquipmentInspectionItem.EquipmentInspectionTypeEdit(JSON.stringify(entity));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            alert('<%=Resources.Messages.SaveInSuccess %>');
            parent.window.UpdateList($("#<%=this.ddlStatus.ClientID %>").val());
            return ajax;
        }

        function selectInspectionRuleValue() {
            dialog({
                title: "<%=Resources.Common.ChooseWindow %>",
                src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?" +
                    "PageId=73&CallBackFunc=getChooseValueInspectionRule&Multiple=true&rnd=" + Math.random(),
                width: 400,
                height: 250
            });
        }
    </script>
</asp:Content>
