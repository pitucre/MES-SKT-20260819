<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    CodeBehind="LabelAddDBField.aspx.cs" Inherits="SKT.LeanMES.Web.Labels.LabelAddDBField" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1">
                <%=Resources.lang.ModelName %>
            </td>
            <td class="Field1">
                <asp:DropDownList ID="ddlModuleName" runat="server" OnSelectedIndexChanged="ddlModuleName_SelectedIndexChanged"
                    AutoPostBack="True">
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%=Resources.lang.FieldName %>
            </td>
            <td class="Field1">
                <asp:DropDownList ID="ddlFieldName" runat="server">
                </asp:DropDownList>
            </td>
        </tr>
        <%--<tr>
            <td class="Label1">
                <%=Resources.lang.AdvancedSettings %>
                <asp:CheckBox ID="ckbSubSet" runat="server" />
            </td>
            <td class="Field1">
                从<asp:DropDownList ID="ddlFrom" runat="server">
                </asp:DropDownList>
                到<asp:DropDownList ID="ddlTo" runat="server">
                </asp:DropDownList>
            </td>
        </tr>--%>
    </table>
    <script type="text/javascript">
        //$(document).ready(function () {
        //    if ($("#<%--<%=this.ckbSubSet.ClientID %>--%>").attr("checked")) {
        //        $("#<%--<%=this.ddlFrom.ClientID %>--%>").attr("disabled", false);
        //        $("#<%--<%=this.ddlTo.ClientID %>--%>").attr("disabled", false);
        //    } else {
        //        $("#<%--<%=this.ddlFrom.ClientID %>--%>").attr("disabled", true);
        //        $("#<%--<%=this.ddlTo.ClientID %>--%>").attr("disabled", true);
        //    }
        //});
        function Save() {
            var f = 0;
            var t = 0;
            var s = "";
            //if ($("#<%--<%=this.ckbSubSet.ClientID %>--%>").attr("checked")) {
            //    f = $("#<%--<%=this.ddlFrom.ClientID %>--%>").val();
            //    t = $("#<%--<%=this.ddlTo.ClientID %>--%>").val();
            //    if (f == t) {
            //        s = f;
            //    } else {
            //        s = f.toString() + "-" + t.toString();
            //    }
            //}
            var fieldPrev = $("#<%=this.ddlModuleName.ClientID %>").val().toLowerCase();
            var fieldCon = $("#<%=this.ddlFieldName.ClientID %>").val().toLowerCase() + "(" + s + ")";
            if (fieldPrev == "") {
                alert("<%=Resources.Messages.SelectModelName %>");
                return false;
            }
            if ($("#<%=this.ddlFieldName.ClientID %>").val() == null || $("#<%=this.ddlFieldName.ClientID %>").val() == "") {
                alert("<%=Resources.Messages.SelectFieldName %>");
                return false;
            }
            window.parent.addFieldValue("dbf" + fieldPrev + "." + fieldCon, 1);
        }

        //$(function () {
        //    $("#<%--<%=this.ckbSubSet.ClientID %>--%>").click(function () {
        //        if ($("#<%--<%=this.ckbSubSet.ClientID %>--%>").attr("checked") == "checked") {
        //            $("#<%--<%=this.ddlFrom.ClientID %>--%>").attr("disabled", false);
        //            $("#<%--<%=this.ddlTo.ClientID %>--%>").attr("disabled", false);
        //        } else {
        //            $("#<%--<%=this.ddlFrom.ClientID %>--%>").attr("disabled", true);
        //            $("#<%--<%=this.ddlTo.ClientID %>--%>").attr("disabled", true);
        //        }
        //    });

        //    $("#<%--<%=this.ddlFrom.ClientID %>--%>").change(function () {
        //        var current = $("#<%--<%=this.ddlFrom.ClientID %>--%>").val();
        //        var fieldCount = $("#<%--<%=this.ddlFieldName.ClientID %>--%> option").length;
        //        $("#<%--<%=this.ddlTo.ClientID %>--%>").empty();
        //        for (var i = current; i < fieldCount; i++) {
        //            $("<option value='" + i.toString() + "'>" + i.toString() + "</option>").appendTo($("#<%--<%=this.ddlTo.ClientID %>--%>"));
        //        }
        //    });
        //});

    </script>
</asp:Content>
