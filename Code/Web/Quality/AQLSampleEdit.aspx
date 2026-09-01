<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="AQLSampleEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Quality.AQLSampleEdit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
<div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %></div>
<table class="EditeContentTable" width="100%">       
        <tr>
            <td class="Label2">
                <%=Resources.lang.AqlName %><em>*</em>
            </td>
            <td class="Field2">
                <asp:HiddenField  ID="txtHideID" runat="server"/>
                <asp:HiddenField  ID="txtHideCreateDate" runat="server"/>
                <asp:HiddenField  ID="txtHideCreate" runat="server"/>
               <%--<asp:DropDownList runat="server" id="ddlAqlName">
                   <asp:ListItem>外观</asp:ListItem>
                   <asp:ListItem>电性能</asp:ListItem>
               </asp:DropDownList>--%>
                <asp:TextBox ID="txtAqlName" runat="server" CssClass="TextBox" ></asp:TextBox>
            </td>
            <%--<td class="Label2">
                <%=Resources.lang.InspectionValue%><em>*</em>
            </td>
            <td class="Field2">
                <asp:DropDownList ID="ddlAqlValue" runat="server" CssClass="TextBox" ></asp:DropDownList>
            </td>--%>
        </tr>
       <%-- <tr>
            <td class="Label2">
                <%=Resources.lang.Description%>
            </td>
            <td class="Field2" colspan="3">
                <asp:TextBox ID="txtDescription" runat="server" CssClass="TextBox"  ></asp:TextBox>
            </td>
        </tr>--%>
        </table>

        <script language="javascript" type="text/javascript">
            var ReqId = '<%=Request.QueryString["ID"] %>';
            $("select").css("width", "140px");
            /*保存数据*/
            function Save() {
                var entity = {};
                entity.AQLSampleId = $("#<%=this.txtHideID.ClientID %>").val();
                entity.CreateDate = $("#<%=this.txtHideCreateDate.ClientID %>").val();
                entity.Create = $("#<%=this.txtHideCreate.ClientID %>").val();
                entity.AQLSampleName = $("#<%=this.txtAqlName.ClientID %>").val();
                entity.AQLSampleValue = "0";
                entity.AQLSampleDescription = "";
                if (entity.AQLSampleId === '') {
                    entity.AQLSampleId = ReqId;
                }
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxQuality.AQLSampleEdit(entity.AQLSampleId, entity.AQLSampleName, entity.AQLSampleValue, entity.AQLSampleDescription, entity.CreateDate, entity.Create);
                
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }

                alert('<%=Resources.Messages.SaveInSuccess %>');
                parent.window.UpdateList($("#<%=this.txtAqlName.ClientID %>").val());
                return ajax;
            }
    </script>
</asp:Content>
