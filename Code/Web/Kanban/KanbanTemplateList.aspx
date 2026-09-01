<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/ListMaster.master"
    CodeBehind="KanbanTemplateList.aspx.cs" Inherits="SKT.LeanMES.Web.Kanban.KanbanTemplateList" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">看板名称
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtTemplName" runat="server" MaxLength="20" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label2">看板类型
            </td>
            <td class="Field2" id="tdSelType">
                <asp:DropDownList ID="ddlSelType" runat="server" ClientIDMode="Static">
                </asp:DropDownList>
                <asp:HiddenField ID="SelTypeValue" runat="server" Value="-1" ClientIDMode="Static" />
                <%-- <SKTControl:ReportDDL runat="server" ID="ddlKanBan" ClientIDMode="Static"></SKTControl:ReportDDL>--%>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" OnRowDataBound="GridView1_OnRowDataBound">
        <Columns>
            <asp:BoundField DataField="ReportCNName" HeaderText="看板名称(中文)" HeaderStyle-Width="180px" SortExpression="ReportCNName" />
            <asp:BoundField DataField="ReportENName" HeaderText="看板名称(英文)" HeaderStyle-Width="180px" SortExpression="ReportENName" />
            <asp:BoundField DataField="RTModuleCNValue" HeaderText="看板类型" HeaderStyle-Width="180px" SortExpression="ReportTypeCNName" />
            <asp:BoundField DataField="CreateBy" HeaderText="创建人" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="创建时间" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
            <asp:BoundField DataField="ModifyBy" HeaderText="修改人" />
            <asp:BoundField DataField="ModifyDateTime" HeaderText="修改时间" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />            
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Kanban.BLL.Master"
        SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <asp:HiddenField runat="server" ID="hfRptTypeJson" ClientIDMode="Static" />
    <asp:HiddenField runat="server" ID="hfSelectedType" Value="-1" ClientIDMode="Static" />
    <script type="text/javascript">
        isMultiple = false;
        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");
        var w = $(window).width() - 150;
        var h = $(window).height() - 70;

        $(document).ready(function () {
            //setSelType($("#hfRptTypeJson").val(), $("#hfSelectedType").val());
            //$("#ddlReport").live("change",function() {
            //    $("#hfSelectedType").val($("#ddlReport").val());
            //});
            $("#<%=this.ddlSelType.ClientID %>").live("change", function () {
                $("#<%=this.SelTypeValue.ClientID %>").val($(this).val());
            });

        });


        function Add() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Kanban/KanbanTemplateEdit.aspx?name=Template_TemplateAdd&ID=-1";
            dialog({ title: "新增看板", src: openWinUrl, width: w, height: h });
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") { return false; }

            var wins = $(window.parent);
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Kanban/KanbanTemplateEdit.aspx?name=Template_TemplateEdit&ID=" + idStr;
            dialog({ title: "编辑看板", src: openWinUrl, width: w, height: h });
        }

        //        function View() {
        //            Edit();
        //        }

        function Delete() {
            var idStr = getDeletingRecordIdString();
            if (idStr == "") { return false; }

            hdnOperate.val("delete");
            hdnIdString.val(idStr);
            document.forms[0].submit();
        }

        function UpdateList(templName) {
            document.forms[0].submit();
        }

        //function setSelType(strJson, selectedItem) {
        //    var objJson;
        //    if (typeof strJson === 'undefined' || strJson === "") {
        //        return;
        //    } else {
        //        objJson = $.parseJSON(strJson);
        //    }
        //    var ddlHtml = "<select class='ddlReport' id='ddlReport'> ";
        //    ddlHtml += "<option value='-1'>=选择=</option> ";
        //    for (i = 0; i < objJson.length; i++) {
        //        var ItemValue = objJson[i].ItemValue;
        //        var ItemName = objJson[i].ItemName;
        //        if (ItemValue == selectedItem) {
        //            ddlHtml += "<option selected='selected' value='" + ItemValue + "'>" + ItemName + "</option> ";
        //        } else {
        //            ddlHtml += "<option value='" + ItemValue + "'>" + ItemName + "</option> ";
        //        }
        //    }
        //    ddlHtml += "</select>";
        //    $("#tdSelType").html(ddlHtml);
        //}
    </script>
</asp:Content>





