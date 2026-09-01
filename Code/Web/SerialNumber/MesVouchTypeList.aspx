<%@ Page Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="True"
    CodeBehind="MesVouchTypeList.aspx.cs" Inherits="SKT.LeanMES.Web.SerialNumber.MesVouchTypeList" Title="MesVouchType List Page" %>
<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">
                大类
            </td>
            <td class="Field2">
                <asp:DropDownList ID="ddlSupClass" runat="server">
                    <asp:ListItem Text="所有类型" Value="" Selected="True"></asp:ListItem>
                    <asp:ListItem Text="货位" Value="WMSBasicfile|1"></asp:ListItem>
                    <asp:ListItem Text="产品" Value="WMSRstorage|2"></asp:ListItem>
                    <asp:ListItem Text="单据" Value="WMSOut|3"></asp:ListItem>
                </asp:DropDownList>
            </td>
            <td class="Label2">
                <%= Resources.lang.VouchTypeName%>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtKeyWords" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
    <asp:GridView ID="GridView1" AutoGenerateColumns="false" runat="server" >
        <Columns>
            <asp:BoundField DataField="VouchName" HeaderText="<%$Resources:lang,VouchTypeName %>" ItemStyle-Width="120px" ItemStyle-ForeColor="green" />
          
            <asp:BoundField DataField="EncodeStr" HeaderText="编码规则" />
            <asp:BoundField DataField="RuleStr" HeaderText="批号规则" />
            <asp:BoundField DataField="PackRuleStr" HeaderText="包装规则" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.SerialNumber.BLL.MesVouchType"
        SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <script type="text/javascript">
        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");
        var pageName = '<%=Request.QueryString["name"] %>';

        $(document).ready(function () {
            $("#<%=this.txtKeyWords.ClientID %>").focus();
        });

        function Add() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SerialNumber/MesVouchTypeEdit.aspx?name=SerialNumber_MesVouchTypeAdd&ID=-1";
            dialog({ title: "<%=Resources.Pages.SerialNumber_SerialNumberAdd %>", src: openWinUrl, width: 760, height: 450 });
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SerialNumber/MesVouchTypeEdit.aspx?name=SerialNumber_MesVouchTypeEdit&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.SerialNumber_SerialNumberEdit %>", src: openWinUrl, width: 760, height: 450 });
        }

        function Delete() {
            var idStr = getDeletingRecordIdString();
            if (idStr == "") return false;
            hdnOperate.val("delete");
            hdnIdString.val(idStr);
            document.forms[0].submit();
        }

        function View() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SerialNumber/MesVouchTypeView.aspx?name=SerialNumber_MesVouchTypeView&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.SerialNumber_MesVouchTypeView %>", src: openWinUrl, width: 760, height: 450 });
        }

        function UpdateList(obj) {
            $("#<%=this.txtKeyWords.ClientID %>").val(obj);
            document.forms[0].submit();
        }
    </script>
</asp:Content>
