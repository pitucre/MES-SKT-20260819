<%@ Page Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true"
    CodeBehind="IEWarningSetting.aspx.cs" Inherits="SKT.LeanMES.Web.Material.IEWarningSetting" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label4">产品编码
            </td>
            <td class="Field4">
                <asp:TextBox ID="txtItemCode" runat="server" CssClass="TextBox"></asp:TextBox><input type="button" class="ButtonBox" value="..." title="Select" onclick="selectMaterials(1);" />
            </td>
            <td class="Label4">产品名称
            </td>
            <td class="Field4">
                <asp:TextBox ID="txtItemName" runat="server" CssClass="TextBox"></asp:TextBox><input type="button" class="ButtonBox" value="..." title="Select" onclick="selectMaterials(2);" />
            </td>
            <td class="Label4">预警库龄天数
            </td>
            <td class="Field4">
                <asp:TextBox ID="txtLibraryCollar" runat="server" MaxLength="9" CssClass="TextBox" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"></asp:TextBox>
            </td>
            <td class="Label4">安全库存数
            </td>
            <td class="Field4">
                <asp:TextBox ID="txtSafetyStock" runat="server" CssClass="TextBox" MaxLength="9" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
    <asp:GridView ID="GridView1" AutoGenerateColumns="false" runat="server">
        <Columns>
            <asp:BoundField DataField="ItemCode" HeaderText="产品编码 " SortExpression="ItemCode" />
            <asp:BoundField DataField="ItemName" HeaderText="产品名称 " SortExpression="ItemCode" />
            <asp:BoundField DataField="LibraryCollar" HeaderText="预警库龄天数" HeaderStyle-Width="100px" SortExpression="LibraryCollar" />
            <asp:BoundField DataField="SafetyStock" HeaderText="安全库存数" HeaderStyle-Width="100px" SortExpression="SafetyStock" />
            <asp:BoundField DataField="CreateBy" HeaderText="<%$ Resources:lang,CreateBy%>"
                SortExpression="CreateBy" HeaderStyle-Width="60px" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="<%$ Resources:lang,CreateDateTime%>"
                SortExpression="CreateDateTime" HeaderStyle-Width="140px" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
            <asp:BoundField DataField="ModifyBy" HeaderText="<%$ Resources:lang,ModifyBy%>"
                SortExpression="ModifyBy" HeaderStyle-Width="60px" />
            <asp:BoundField DataField="ModifyDateTime" HeaderText="<%$ Resources:lang,ModifyDateTime%>"
                SortExpression="ModifyDateTime" HeaderStyle-Width="140px" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Material.BLL.EarlyWarning"
        SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <script type="text/javascript" language="javascript">
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");
        function selectMaterials(type) {

            flag = type;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=1&Multiple=false&rnd=" + Math.random(), width: 700, height: 400 });

        }
        function getChooseValue(list) {
            switch (flag) {
                case 1:
                    $("#<%=this.txtItemCode.ClientID%>").val(list[0][2]);
                    break;
                case 2:
                    $("#<%=this.txtItemName.ClientID%>").val(list[0][1]);
                    break;
                default:
                    flag = -1;
                    break;
            }

            flag = -1;
        }
        function Add() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Material/IEWarningEdit.aspx?name=Material_IEWarningAdd&ID=-1";
            dialog({ title: mesLang("新增"), src: openWinUrl, width: 700, height: 400 });
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Material/IEWarningEdit.aspx?name=Material_IEWarningEdit&ID=" + idStr;
            dialog({ title: mesLang("编辑"), src: openWinUrl, width: 700, height: 400 });
        }

        function UpdateList(txtItemCode) {
            $("#<%=this.txtItemCode.ClientID %>").val(txtItemCode);
            document.forms[0].submit();
        }

        function Delete() {
            var idStr = getDeletingRecordIdString();
            if (idStr === "") return false;
            hdnOperate.val("delete");
            hdnIdString.val(idStr);
            document.forms[0].submit();
            return idStr;
        }

    </script>
</asp:Content>
