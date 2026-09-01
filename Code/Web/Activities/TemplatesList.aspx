<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/ListMaster.master" CodeBehind="TemplatesList.aspx.cs" Inherits="SKT.LeanMES.Web.Activities.TemplatesList" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1">
                模板名字
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtTemplName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" OnRowDataBound="GridView1_OnRowDataBound" DataKeyNames="Tmp_Attribute">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="Tmpl_TemplateName" HeaderText="模板名字" HeaderStyle-Width="180px" SortExpression="Tmpl_TemplateName"/>
            <asp:BoundField DataField="Flag" HeaderText="标识" HeaderStyle-Width="35px" SortExpression="Flag"/>
            <asp:BoundField DataField="CreateDateTime" HeaderText="创建时间" DataFormatString="{0:yyyy-MM-dd}" HeaderStyle-Width="85px" SortExpression="CreateDateTime"/>
            <asp:BoundField DataField="CreateBy" HeaderText="创建人" HeaderStyle-Width="75px" SortExpression="CreateBy"/>
            <asp:BoundField DataField="ModifyDateTime" HeaderText="修改时间" DataFormatString="{0:yyyy-MM-dd}" HeaderStyle-Width="85px" SortExpression="ModifyDateTime"/>
            <asp:BoundField DataField="ModifyBy" HeaderText="修改人" HeaderStyle-Width="75px" SortExpression="ModifyBy"/>
            <asp:BoundField DataField="Tmpl_TemplateDesc" HeaderText="描述" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Station.BLL.Template"
        SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <script type="text/javascript">
        $(document).ready(function () {
            //$("#ckbMultipleSelected").parent().hide();
        })
        isMultiple = false;
        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");
        function Add() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Activities/TemplatesEdit.aspx?name=Activities_TemplatesAdd&ID=-1&rnd=" + Math.random();
            window.parent.openTab(this, "<%=Resources.Pages.Activities_TemplatesAdd %>", openWinUrl, "tmplAdd0", "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/theme/Metro/images/application1.png");
        }

        function Edit() {
            var flagVal = getRowAttribute($("#<%=this.GridView1.ClientID %>")[0], "Flag");
            if (flagVal != "") {
                alert("<%=Resources.Messages.CannotModify %>");
                return false;
            }
            else {
                var idStr = getOneRecordId();
                if (idStr == "") return false;
                var tmpAttr = GetRtAtt(idStr);
                if (tmpAttr == -1) {
                    alert("该模板某些属性已被损坏，请勿手动修改模板的数据库字段属性。");
                    return false;
                }
                if (tmpAttr == 1) {
                    alert("对不起，您不能编辑系统内置的模板！");
                    return false;
                }
                //xiang.yan 2024-4-26  列取值由索引改为列明,菜单已无此页面
                // 1 改为 Tmpl_TemplateName
                var tmplName = getOneRecordCellTextByFiled("Tmpl_TemplateName");
                openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Activities/TemplatesEdit.aspx?name=Activities_TemplatesEdit&ID=" + idStr + "&rnd=" + Math.random();
                window.parent.openTab(this, "<%=Resources.Pages.Activities_TemplatesEdit %>-" + tmplName, openWinUrl, "tmplEdit" + idStr, "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/theme/Metro/images/application1.png");
            }
        }
        function Delete() {
            var flagVal = getRowAttribute($("#<%=this.GridView1.ClientID %>")[0], "Flag");
            if (flagVal != "") {
                alert("<%=Resources.Messages.CannotModify %>");
                return false;
            }
            else {
                var idStr = getDeletingRecordIdString();
                if (idStr == "") return false;
                var idStrArr = idStr.split(",");
                for (i = 0; i < idStrArr.length; i++) {
                    if (GetRtAtt(idStrArr[i]) == -1) {
                        alert("该模板某些属性已被损坏，请勿手动修改模板的数据库字段属性。");
                        return false;
                    }
                    if (GetRtAtt(idStrArr[i]) == 1) {
                        alert("对不起，您不能编辑系统内置的模板！");
                        return false;
                    }
                }               

                hdnOperate.val("delete");
                hdnIdString.val(idStr);
                document.forms[0].submit();
            }
        }
        function UpdateList(templName) {
            $("#<%=this.txtTemplName.ClientID %>").val(templName);

            document.forms[0].submit();
        }


        function GetRtAtt(tId) {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxActivity.GetRtAtt(tId);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var rtAtt = ajax.value;
            return rtAtt;
        }

        function ajaxProTest(data) {
            alert(data.value);
        }
    </script>
</asp:Content>

