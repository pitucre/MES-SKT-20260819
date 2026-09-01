<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="InspectionRuleEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Quality.InspectionRuleEdit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
<table class="EditeContentTable" width="100%">
        <tr>
            <td colspan="4" class="Label"><%=Resources.Messages.WithAsteriskIsRequired %></td>
        </tr>
        <tr>
            <td class="Label2">
                <%=Resources.lang.InspectionRuleName%><em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtInspectionRuleName" runat="server" CssClass="TextBox"  ></asp:TextBox>
            </td>
            <td class="Label2">
                <%=Resources.lang.Status%><em>*</em>
            </td>
            <td class="Field2">
               <asp:HiddenField  ID="txtHideID" runat="server"/>
               <asp:HiddenField  ID="txtHideCreater" runat="server"/>
               <asp:HiddenField  ID="txtHideCreateTime" runat="server"/> 
               <asp:HiddenField  ID="txtHideInspectionRuleId" runat="server"/>
               <asp:DropDownList runat="server" id="ddlStatus">
                   <asp:ListItem>启用</asp:ListItem>
                   <asp:ListItem>禁用</asp:ListItem>
               </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                 InspectionTemplateIdList 
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtInspectionTemplateList" runat="server"  CssClass="TextBox" Enabled="false" MaxLength="20"></asp:TextBox>
                <input type="button" id="btnSelecUnit" class="ButtonBox" value="..." onclick="selectInspectionTemplateValue();" />
                <asp:HiddenField ID="hdnSelectTemplateIds" runat="server" Value="-1" />
            </td>
            <td class="Label2">
                <%=Resources.lang.Description%>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtDescription" runat="server" CssClass="TextBox"  ></asp:TextBox>
            </td>
        </tr>
        </table>

        <script language="javascript" type="text/javascript">
            var ReqId = '<%=Request.QueryString["ID"] %>';
            $("select").css("width", "140px");
            /*保存数据*/
            function Save() {
                var entity = {};
                entity.InspectionRuleId = $("#<%=this.txtHideInspectionRuleId.ClientID %>").val();
                entity.InspectionRuleName = $("#<%=this.txtInspectionRuleName.ClientID %>").val();
                entity.Creater = $("#<%=this.txtHideCreater.ClientID %>").val();
                entity.CreateTime = new Date($("#<%=this.txtHideCreateTime.ClientID %>").val());
                entity.Status = $("#<%=this.ddlStatus.ClientID %>").val() == '启用' ? true : false;
                entity.Description = $("#<%=this.txtDescription.ClientID %>").val();
                entity.InspectionTemplateIdList = $("#<%=this.hdnSelectTemplateIds.ClientID %>").val();
                if (entity.InspectionRuleId === '') {
                    entity.InspectionRuleId = ReqId;
                }
                if (ReqId == -1) {
                    entity.CreateTime = new Date();
                }
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxQuality.InspectionRuleEdit(entity);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }
                alert('<%=Resources.Messages.SaveInSuccess %>');
                parent.window.UpdateList($("#<%=this.ddlStatus.ClientID %>").val());
                return ajax;
            }

            function getChooseValueInspectionTemplate(list) {
                var ids = '';
                var names = '';
                $(list).each(function () {
                    var v = $(this);
                    ids += v[1] + ',';
                    names += v[2] + ',';
                });
                $("#<%=this.hdnSelectTemplateIds.ClientID %>").val(ids.substr(0, ids.length - 1));
                $("#<%=this.txtInspectionTemplateList.ClientID %>").val(names.substr(0, names.length - 1));
            }

            function selectInspectionTemplateValue() {
                dialog({
                    title: "<%=Resources.Common.ChooseWindow %>",
                    src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?" +
                    "PageId=59&CallBackFunc=getChooseValueInspectionTemplate&Multiple=true&rnd=" + Math.random(),
                    width: 400,
                    height: 250
                });
            }
    </script>
</asp:Content>
