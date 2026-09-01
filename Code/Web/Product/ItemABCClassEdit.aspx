<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="ItemABCClassEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Product.ItemABCClassEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <table width="100%" class="EditeContentTable">
        <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %></div>
        <tr>
            <td class="Label2">物料ABC等级</td>
            <td class="Field2">
                <asp:Label ID="lblABCClass" runat="server" Text=""></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">类型</td>
            <td class="Field2">
                <asp:DropDownList ID="ddlABCSuper" runat="server" ClientIDMode="Static">
                    <asp:ListItem Value="1">数量</asp:ListItem>
                    <asp:ListItem Value="2">百分比</asp:ListItem>
                    <asp:ListItem Value="3">数量+百分比</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr id="trVal">
            <td class="Label2">超发数<em>*</em></td>
            <td class="Field2">
                <asp:TextBox ID="txtABCVal" runat="server" CssClass="TextBox" IsRequired="1" ClientIDMode="Static"></asp:TextBox>
            </td>
        </tr>
        <tr id="trPercentVal">
            <td class="Label2">超发百分比<em>*</em></td>
            <td class="Field2">
                <asp:TextBox ID="txtABCPercentVal" runat="server" CssClass="TextBox" IsRequired="1" Enabled="true" ClientIDMode="Static"></asp:TextBox> %
            </td>
        </tr>

        <tr>
            <td class="Label2">备注</td>
            <td class="Field2" colspan="3">
                <asp:TextBox ID="txtRemark" runat="server" CssClass="TextArea" TextMode="MultiLine" MaxLength="50"></asp:TextBox>
            </td>
        </tr>
    </table>

    <script type="text/javascript">
        var itemABCId = '<%=Request.QueryString["ID"]%>';

        $().ready(function(){
            $("#txtABCVal").keyup(
                function(){
                    getIntVal(this);
                }
                );
            $("#txtABCPercentVal").keyup(
               function () {
                   getDecimalVal(this);
               }
               );

            if ($("#ddlABCSuper").val() == "1") {
                $("#trPercentVal").hide();
                $("#trVal").show();
            }
            else if ($("#ddlABCSuper").val() == "2") {
                $("#trPercentVal").show();
                $("#trVal").hide();
            }
            else if ($("#ddlABCSuper").val() == "3") {
                $("#trPercentVal").show();
                $("#trVal").show();
            }

            $("#ddlABCSuper").change(function () {
                if ($("#ddlABCSuper").val() == "1") {
                    $("#trPercentVal").hide();
                    $("#trVal").show();
                    $("#txtABCPercentVal").val(0);
                }
                else if ($("#ddlABCSuper").val() == "2") {
                    $("#trPercentVal").show();
                    $("#trVal").hide();
                    $("#txtABCVal").val(0);
                }
                else if ($("#ddlABCSuper").val() == "3") {
                    $("#trPercentVal").show();
                    $("#trVal").show();
                }
            });
        });
        /*保存数据*/
        function Save() {
            var txtABCClass = $.trim($("#<%=this.lblABCClass.ClientID%>").text());
            var txtABCSuper = $("#<%=this.ddlABCSuper.ClientID%>").val();
            var txtABCVal = $("#<%=this.txtABCVal.ClientID%>").val();
            var txtABCPercentVal = $("#<%=this.txtABCPercentVal.ClientID%>").val();            
            var txtRemark = $.trim($("#<%=this.txtRemark.ClientID%>").val());


            /*表单验证*/
            /*如需表单验证可以此处处理验证 开始*/


            var entity = {};

            entity.ItemABCId = itemABCId
            entity.ABCClass = txtABCClass;
            entity.ABCSuper = txtABCSuper;
            entity.ABCVal = txtABCVal;
            entity.ABCPercentVal = parseFloat(txtABCPercentVal);           
            entity.Remark = txtRemark;

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxItemABC.ItemABCEdit(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            alert('<%=Resources.Messages.SaveInSuccess%>')
        
            parent.window.Refresh();
         
        }
    </script>

</asp:Content>
