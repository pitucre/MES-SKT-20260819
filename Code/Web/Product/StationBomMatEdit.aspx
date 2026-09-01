<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="StationBomMatEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Product.StationBomMatEdit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
<div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %></div>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1">
                产品BOM<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtItemBomName" runat="server" CssClass="TextBox" Enabled="false" IsRequired='1' ClientIDMode="Static"></asp:TextBox><input
                    type="button" id="Button1" class="ButtonBox" value="..." title="<%=Resources.lang.ChooseItem %>"
                    onclick="selectItem(108);" />
                <asp:HiddenField ID="hdnItemBomId" runat="server" Value="-1" />               
            </td>
        </tr>
        <tr>
            <td class="Label1">
                物料编码
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtItemCode" runat="server" CssClass="TextBox" Enabled="false"  ClientIDMode="Static"></asp:TextBox><input
                    type="button" id="btnSelectItem" class="ButtonBox" value="..." title="<%=Resources.lang.ChooseItem %>"
                    onclick="selectItem(109);" />
                <asp:HiddenField ID="hdnItemChildBomId" runat="server" Value="" />            
            </td>
        </tr> 
        <tr>
            <td class="Label1">
               工序<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtStation" runat="server" CssClass="TextBox" Enabled="false" IsRequired='1' ClientIDMode="Static"></asp:TextBox><input
                    type="button" id="Button2" class="ButtonBox" value="..." title="<%=Resources.lang.ChooseItem %>"
                    onclick="selectItem(8);" />    
                   <asp:HiddenField ID="hdnStationId" runat="server" Value="-1" />           
            </td>
        </tr>   
                <tr>
            <td class="Label1">
               数据类型
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtDataTypeId" runat="server" CssClass="TextBox" Enabled="false"  ClientIDMode="Static"></asp:TextBox><input
                    type="button" id="Button3" class="ButtonBox" value="..." title="<%=Resources.lang.ChooseItem %>"
                    onclick="selectItem(2);" />    
                   <asp:HiddenField ID="hidDataTypeId" runat="server" Value="-1" />           
            </td>
        </tr>    
    </table>
    <script type="text/javascript">
        var stationInBomId = '<%=Request.QueryString["ID"] %>';
      
        var chooseFlag = 0;

        function selectItem(i) {
            chooseFlag = i;
            var pageCondition = "";
            if (i == 108) {
                pageCondition = "State = 1" ;
            }
            else if (i == 109) {
                var bomid =$("#<%=this.hdnItemBomId.ClientID %>").val();
                if (bomid == "-1") {
                    alert("请先选择产品BOM！");
                    $("#<%=this.txtItemBomName.ClientID %>").css("background-color", "yellow");
                    return false;
                }
                pageCondition = "ItemBomId = " + bomid;
            }
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=" + i.toString() + "&PageCondition=" + escape(pageCondition) + "&Multiple=false&rnd=" + Math.random(), width: 650, height: 350 });
        }

        function getChooseValue(list) {
            if (chooseFlag == 8) {
                $("#<%=this.txtStation.ClientID %>").val(list[0][1]);
                $("#<%=this.hdnStationId.ClientID %>").val(list[0][0]);
            }
            else if (chooseFlag == 108) {
                $("#<%=this.txtItemBomName.ClientID %>").val(list[0][1]);
                $("#<%=this.hdnItemBomId.ClientID %>").val(list[0][0]);

                $("#<%=this.txtItemCode.ClientID %>").val("");
                $("#<%=this.hdnItemChildBomId.ClientID %>").val("-1");
            }
            else if (chooseFlag == 109) {
                $("#<%=this.txtItemCode.ClientID %>").val(list[0][1]);
                $("#<%=this.hdnItemChildBomId.ClientID %>").val(list[0][0]);
            }
            else if (chooseFlag == 2) {
                $("#<%=this.txtDataTypeId.ClientID %>").val(list[0][2]);
                $("#<%=this.hidDataTypeId.ClientID %>").val(list[0][0]);
            }

        }

        function Save() {
            var stationId = $("#<%=this.hdnStationId.ClientID %>").val();
            var hdnItemBomId = $("#<%=this.hdnItemBomId.ClientID %>").val();
            var hdnItemChildBomId = $("#<%=this.hdnItemChildBomId.ClientID %>").val();
            var dataTypeId = $("#<%=this.hidDataTypeId.ClientID %>").val();
            var entity = {};
            entity.StationInBomId = stationInBomId;
            entity.OrganizationCode = "";
            entity.StationId = stationId;
            entity.ItemBomId = hdnItemBomId;
            entity.ItemBomChildId = hdnItemChildBomId;
            entity.DataTypeId = dataTypeId;
            entity.State = 1;

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxProduct.StationInBomEdit(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert("<%=Resources.Messages.SaveInSuccess %>");
            parent.window.UpdateList();
        }     
    </script>
</asp:Content>
