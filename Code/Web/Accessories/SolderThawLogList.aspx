<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SolderThawLogList.aspx.cs"
    Inherits="SKT.LeanMES.Web.Accessories.SolderThawLogList" MasterPageFile="~/Masters/ListMaster.master" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">
                <%=Resources.lang.StartTime%>
            </td>
            <td class="Field2">
                <asp:TextBox ID="TextBox1" runat="server" ClientIDMode="Static" Style="display: none"></asp:TextBox>
                <asp:TextBox ID="txtThawStarTime" runat="server" CssClass="DateTimeBox" ClientIDMode="Static"
                   ></asp:TextBox>
            </td>
            <td class="Label2">
                <%=Resources.lang.EndTime%>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtThawEndTime" runat="server" CssClass="DateTimeBox" ClientIDMode="Static"
                  ></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="searchConditions" runat="server" ContentPlaceHolderID="GridviewContent">
    <asp:GridView ID="GridView1" AutoGenerateColumns="false" runat="server">
        <Columns>
            <asp:BoundField DataField="BARCODE" HeaderText="<%$ Resources:lang,Accessorie_BARCODE %>"
                ItemStyle-Width="90px" />
            <asp:BoundField DataField="PN" HeaderText="<%$ Resources:lang,Accessorie_PN %>" ItemStyle-Width="90px" />
            <asp:BoundField DataField="CREATEDTIMEStr" HeaderText="<%$ Resources:lang,Accessorie_CREATEDTIME %>"
                ItemStyle-Width="90px" />
            <asp:BoundField DataField="UseTimeStr" HeaderText="<%$ Resources:lang,UseTime %>"
                ItemStyle-Width="90px" />
            <asp:BoundField DataField="ExpireTimeStr" HeaderText="<%$ Resources:lang,Accessorie_EXPIREDDATE %>"
                ItemStyle-Width="90px" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Accessories.BLL.LOG"
        SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <script type="text/javascript">
        _isHms = true;

        function SelectThawLogInfo() {
            var errStr = "";
            var txtThawStarTime = $("#txtThawStarTime").val();
            if (isNull(txtThawStarTime)) {
                errStr = "<%=Resources.Messages.WithAsteriskIsRequiredAlert %>";
            }
            var txtThawEndTime = $("#txtThawEndTime").val();
            if (isNull(txtThawEndTime)) {
                errStr = "<%=Resources.Messages.WithAsteriskIsRequiredAlert %>";
            }
            if (errStr != "") {
                alert(errStr.toString());
                return false;
            }
            var starTime = new Date(txtThawStarTime.replace(/-/g, "\/"));
            var endTime = new Date(txtThawEndTime.replace(/-/g, "\/"));

            if (starTime > endTime) {
                alert("<%=Resources.Messages.StarTimeCannotEndTime %>");
                return false;
            } else {
                //$("#searchSubmit").click();
            }
        }
        function SetInvilitedInfo() {
            var idStr = getOneRecordId();
            if (idStr != "") {
                //xiang.yan 2024-4-26  列取值由索引改为列明,菜单已无此页面
                // 1 改为 BARCODE
                var barcode = getOneRecordCellTextByFiled("BARCODE");
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxServiceSolderLog.SetInvalidatedInfo(barCode);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }
                alert('<%=Resources.Messages.SaveInSuccess %>');
                UpdateList();
            }
        }
        function Register() {
            dialog({ title: "<%= Resources.lang.Accessories_Register %>", src: "AccessoriesEdit.aspx?name=Accessories_Register&ID=-1", width: 700, height: 350, resizeable: true });
        }

        function UpdateList() {
            document.forms[0].submit();
        }
        function isNull(str) {
            if (str == "") return true;
            var regu = "^[ ]+$";
            var re = new RegExp(regu);
            return re.test(str);
        }
        function Delete() {
            var idStr = getDeletingRecordIdString();
            if (idStr == "") return false;
            hdnOperate.val("delete");
            hdnIdString.val(idStr);
            document.forms[0].submit();
        }
    </script>
    <link href="../Content/plugin/calendar/skin/datepicker.css" rel="stylesheet" type="text/css" />
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/formValidation.js?t=1.0.0"
        type="text/javascript"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/calendar/js/jquery.ui.core.js"
        type="text/javascript"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/calendar/js/jquery.ui.datepicker.js"
        type="text/javascript" charset="GBK"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/calendar/js/jquery.ui.datepicker.zn.js"
        type="text/javascript"></script>
    <script type="text/javascript">
        $(function () {
            $(".DateTimeBox").datepicker({
                showOn: "both",
                buttonImageOnly: true,
                buttonText: "<%=Resources.lang.ChooseDate %>"
            }).attr("readonly","readonly");
        });
    </script>
</asp:Content>
