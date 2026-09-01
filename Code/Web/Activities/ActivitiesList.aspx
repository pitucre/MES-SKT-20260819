<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/ListMaster.master"
    CodeBehind="ActivitiesList.aspx.cs" Inherits="SKT.LeanMES.Web.Activities.ActivitiesList" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1">
                <%=Resources.lang.AC_Name%>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtAC_Name" runat="server" CssClass="TextBox" patterns="AutoComplete"
                    source="Basal_Activity" field="AC_Name" minChars="2"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" DataKeyNames="AC_Attributes"
        OnRowDataBound="GridView1_OnRowDataBound">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="AC_Name" HeaderText="<%$Resources:lang,AC_Name %>" HeaderStyle-Width="200px"
                SortExpression="AC_Name" />
            <asp:BoundField DataField="AC_Description" HeaderText="<%$Resources:lang,Description %>" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Router.BLL.Activity"
        SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <script type="text/javascript">
        isMultiple = false;
        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");
        function Add() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Activities/ActivitiesEdit.aspx?name=Activities_ActivitiesAdd&ID=-1&flag=0";
            window.parent.openTab(this, "<%=Resources.Pages.Activities_ActivitiesAdd %>", openWinUrl, "Activities_ActivitiesAdd", "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/theme/Metro/images/application1.png");
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            var actAttr = GetRtAtt(idStr);
            if (actAttr == -1) {
                alert("该业务某些属性已被损坏，请勿手动修改业务的数据库字段属性。");
                return false;
            }
            if (actAttr == 1) {
                alert("对不起，您不能编辑系统内置的业务！");
                return false;
            }
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Activities/ActivitiesEdit.aspx?name=Activities_ActivitiesEdit&flag=0&ID=" + idStr;
            window.parent.openTab(this, "<%=Resources.Pages.Activities_ActivitiesEdit %>", openWinUrl, "acedit" + idStr, "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/theme/Metro/images/application1.png");
        }

        function Delete() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            var actAttr = GetRtAtt(idStr);
            if (actAttr == -1) {
                alert("该业务某些属性已被损坏，请勿手动修改业务的数据库字段属性。");
                return false;
            }
            if (actAttr == 1) {
                alert("对不起，您不能编辑系统内置的业务！");
                return false;
            }

            if (idStr != "") {
                if (window.confirm(ConfirmDelete)) {
                    hdnOperate.val("delete");
                    hdnIdString.val(idStr);
                    document.forms[0].submit();
                }
            }
        }

        function BindOpeType() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            //xiang.yan 2024-4-26  列取值由索引改为列明,菜单已无此页面
            // 1 改为 AC_Name
            var ac_name = getOneRecordCellTextByFiled("AC_Name");
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Activities/ActivitiesBindOpeType.aspx?name=Activities_ActivitiesBindOpeAC&acname=" + ac_name + "&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.Activities_ActivitiesBindOpeAC %>", src: openWinUrl, width: 750, height: 400 });
        }

        function ConfigParam() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            //xiang.yan 2024-4-26  列取值由索引改为列明,菜单已无此页面
            // 1 改为 AC_Name
            var ac_name = getOneRecordCellTextByFiled("AC_Name");
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Activities/ActivitiesConfigParam.aspx?name=Activities_ActivitiesConfigParam&acname=" + ac_name + "&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.Activities_ActivitiesConfigParam %>", src: openWinUrl, width: 620, height: 320 });
        }

        function UpdateList(namestr) {
            $("#<%=this.txtAC_Name.ClientID %>").val(namestr);
            document.forms[0].submit();
        }

        function GetRtAtt(rtId) {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxActivity.GetRtAttActivity(rtId);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var rtAtt = ajax.value;
            return rtAtt;
        }
        
    </script>
</asp:Content>
