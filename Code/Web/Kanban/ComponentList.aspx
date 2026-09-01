<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/ListMaster.master"
    CodeBehind="ComponentList.aspx.cs" Inherits="SKT.LeanMES.Web.Kanban.ComponentList" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">控件名称
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtTemplName" runat="server" CssClass="TextBox" MaxLength="20"></asp:TextBox>
            </td>
            <td class="Label2">控件类型
            </td>
            <td class="Field2" id="tdSelType">
                <asp:DropDownList ID="ddlSelType" runat="server" ClientIDMode="Static">
                </asp:DropDownList>
                <asp:HiddenField runat="server" ID="hfSelectedType" Value="-1" ClientIDMode="Static" />
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" OnRowDataBound="GridView1_OnRowDataBound">
        <Columns>
            <asp:BoundField DataField="ComponentName" HeaderText="控件名称" HeaderStyle-Width="180px"
                SortExpression="ComponentName" />
            <asp:BoundField DataField="TypeName" HeaderText="控件类型" HeaderStyle-Width="180px"
                SortExpression="TypeName" />
            <asp:BoundField DataField="DataSource" HeaderText="数据源" HeaderStyle-Width="180px" />
            <asp:BoundField DataField="RefreshSec" HeaderText="刷新频率/秒" HeaderStyle-Width="180px"
                SortExpression="RefreshSec" />
            <asp:BoundField DataField="CreateBy" HeaderText="创建人" />
            <asp:BoundField DataField="CreateTime" HeaderText="创建时间" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
            <asp:BoundField DataField="ModifyBy" HeaderText="修改人" />
            <asp:BoundField DataField="ModifyTime" HeaderText="修改时间" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
            <asp:BoundField DataField="Remark" HeaderText="备注" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Kanban.BLL.Master"
        SelectMethod="GetAllComponent" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <asp:HiddenField ID="hfCompTypeJson" runat="server" ClientIDMode="Static" />

    <script type="text/javascript">
        isMultiple = false;
        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");
        var w = $(window).width() - 150;
        var h = $(window).height() - 70;
        $(document).ready(function () {
            //setSelType($("#hfCompTypeJson").val(), $("#hfSelectedType").val());
            //$("#ddlCompType").live("change", function () {
            //    $("#hfSelectedType").val($("#ddlCompType").val());
            //});

            $("#<%=this.ddlSelType.ClientID %>").live("change", function () {
                $("#<%=this.hfSelectedType.ClientID %>").val($(this).val());
                  });

        });
              function Add() {
                  openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Kanban/ComponentEdit.aspx?name=ComponentAdd&ID=-1";
            dialog({ title: "新增控件", src: openWinUrl, width: w, height: h });
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") { return false; }

            var wins = $(window.parent);
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Kanban/ComponentEdit.aspx?name=ComponentEdit&ID=" + idStr;
            dialog({ title: "编辑控件", src: openWinUrl, width: w, height: h });
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
        //    var ddlHtml = "<select class='ddlCompType' id='ddlCompType'> ";
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





