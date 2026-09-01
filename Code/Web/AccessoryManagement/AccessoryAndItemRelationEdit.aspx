<%@ Page Language="C#" MasterPageFile="~/Masters/EditHeadMaster.master"
    AutoEventWireup="true" CodeBehind="AccessoryAndItemRelationEdit.aspx.cs" Inherits="SKT.LeanMES.Web.AccessoryManagement.AccessoryAndItemRelationEdit" %>


<%@ MasterType VirtualPath="~/Masters/EditHeadMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div class="Tips" id="NotAllowModify" runat="server">
    </div>
    <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %>
    </div>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">
                <%= Resources.lang.ItemCode %><em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtItemCode" runat="server" CssClass="TextBox" IsRequired='1' ReadOnly="true"
                    ClientIDMode="Static"></asp:TextBox><input type="button" id="btnSelectItem" class="ButtonBox" value="..." title="Select"
                        onclick="openChoosePage(1)" />
                <asp:HiddenField ID="hdnItemId" runat="server" Value="-1" ClientIDMode="Static" />
            </td>
            <td class="Label2">产品描述
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtMachine" runat="server"
                    MaxLength='20' ClientIDMode="Static"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
    <div class="ListTableTitle">
        <%=Resources.lang.MaterialList%>&nbsp;<span id="bomCompList"></span>
    </div>
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" DataSourceID="ObjectDataSource1">
        <Columns>
            <%-- To Do --%>
            <%--<asp:BoundField DataField="ItemLevel" HeaderText="阶次" />--%>
            <asp:BoundField DataField="AccessoryCode" HeaderText="辅料编码" />
            <asp:BoundField DataField="Value" HeaderText="单位用量" />
            <asp:BoundField DataField="UnitName" HeaderText="单位" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.AccessoryManagement.BLL.AccessoryItemRelationDtl"
        SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <asp:HiddenField ID="hdnBomId" runat="server" Value="-1" />
    <asp:HiddenField ID="hdnHasCopy" runat="server" Value="-1" />
    <script type="text/javascript">
        loadfloatButtons("bomCompList");
        isMultiple = true;
        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");
        var bomName = "";
        var Id = <%=Request.QueryString["ID"] %>;
        var username = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
        var data = [];

        function AddComponent() {
            if ($("#<%=this.txtItemCode.ClientID%>").val() == "") {
                alert("请选择产品");
                return false;
            }
            var bomId = $("#<%=this.hdnBomId.ClientID %>").val();
            if (bomId == -1) {
                if (!saveData()) {
                    return false;
                }
            }
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/AccessoryManagement/AccessoryAndItemRelationDtlEdit.aspx?name=AccessoryAndItemRelationDtlAdd&ID=-1&BOMID=" + $("#<%=this.hdnBomId.ClientID %>").val();
            dialog({ title: "<%=Resources.Pages.Product_BomMatAdd %>", src: openWinUrl, width: 650, height: 400 });
        }

        function EditComponent() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;

            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/AccessoryManagement/AccessoryAndItemRelationDtlEdit.aspx?name=AccessoryAndItemRelationDtlEdit&ID=" + idStr + "&BOMID=" + $("#<%=this.hdnBomId.ClientID %>").val();
            dialog({ title: "<%=Resources.Pages.Product_BomMatEdit %>", src: openWinUrl, width: 650, height: 400 });
        }

        function RemoveComponent() {
            var idStr = getDeletingRecordIdString();
            if (idStr == "") return false;
            hdnOperate.val("delete");
            hdnIdString.val(idStr);
            document.forms[0].submit();
        }

        function Save() {
            if (!saveData()) {
                return false;
            }
            else {
                alert("<%=Resources.Messages.SaveInSuccess %>");
                parent.window.UpdateList(bomName);
            }
        }
        function saveData() {
            Id=$("#<%=this.hdnBomId.ClientID %>").val();
            var ItemCode = $("#txtItemCode").val();
            var MachineType = $("#txtMachine").val();
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxAccessoryItemRelation.Edit(Id,ItemCode, MachineType, username);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            $("#<%=this.hdnBomId.ClientID %>").val(ajax.value);
                        return true;
                    }

                    function update(Id) {
                        $("#<%=this.hdnBomId.ClientID %>").val(Id);
            document.forms[0].submit();
        }

        function openChoosePage(flags) {
            var condition = "";
            flag = flags;
            dialog({
                title: "<%= Resources.Common.ChooseWindow %>",
                src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=" +
                flags +
                "&Multiple=false&SearchCondition=" +
                condition +
                "&rnd=" +
                Math.random(),
                width: 650,
                height: 400
            });
        }

        function getChooseValue(list) {
            if (flag == 1) {
                $("#txtItemCode").val(list[0][2]);
                $("#lblItemName").html(list[0][1]);
                $("#hdnItemId").val(list[0][0]);
            }
        }
    </script>
</asp:Content>
