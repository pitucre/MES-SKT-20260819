<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="AQLGetValue.aspx.cs" Inherits="SKT.LeanMES.Web.Quality.AQLGetValue" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server"> 
<div class="infoTips">
                带<em>*</em>为必填项</div>
<table class="EditeContentTable" width="100%">
        <tr  >
            <td class="Label2">
                <%=Resources.lang.InspectionValue%><em>*</em>
            </td>
            <td class="Field2" colspan="2">
                <asp:TextBox ID="txtInspectionValue" MaxLength='9'  onkeyup='getIntVal(this)' runat="server" CssClass="TextBox" Width="95%" ></asp:TextBox>
            </td>
            <td align="center">
                <asp:Button runat="server" id="btn_GetFnViValue" OnClick="btn_GetFnViValue_OnClick" Text="" CssClass="LogBtn"/>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%=Resources.lang.FN%>
            </td>
            <td class="Field2">
               <asp:Label runat="server" id="lblFN"></asp:Label>
            </td>
            <td class="Label2">
                外观
            </td>
            <td class="Field2">
               <asp:Label runat="server" id="lblVI"></asp:Label>
            </td>
        </tr>
        </table>
        <script type="text/javascript">
            $("Input[type=submit]").css({ "background-color": "blue", "color": "white", "font-size": "15px" });

            $(function () {
                $("#<%=this.txtInspectionValue.ClientID%>").keydown(function (event) {
                    event = document.all ? window.event : event;
                    if ((event.keyCode || event.which) === 13) {
                        $("#<%=btn_GetFnViValue.ClientID %>").click();
                    }
                });
            });
        </script>
</asp:Content>
