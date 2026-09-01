<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/ViewMaster.master"
    CodeBehind="LabelFieldView.aspx.cs" Inherits="SKT.LeanMES.Web.Labels.LabelFieldView" %>

<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="Server">
    <table width="100%" class="ContentTable">
        <tr>
            <td class="Label2">
                <%= Resources.lang.LabelFieldName %>
            </td>
            <td class="Field2">
                <asp:Label ID="txtLabelFieldName" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                字体
            </td>
            <td class="Field2">
                <asp:Label ID="txtFont" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                加粗
            </td>
            <td class="Field1">
                <asp:CheckBox runat="server" ID="chkIsBold" Enabled="false" />
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%=Resources.lang.Description %>
            </td>
            <td class="Field2">
                <asp:Label ID="txtDesc" runat="server"></asp:Label>
            </td>
        </tr>
    </table>
    <div class="clear5">
    </div>
    <div class="ListTableTitle">
        <%=Resources.lang.LabelFieldDefinition %>
    </div>
    <div style="height: 200px; border-top: 0px solid #cccccc; border-left: 1px solid #cccccc;
        border-right: 1px solid #cccccc; border-bottom: 1px solid #cccccc; font-size: 11px;
        padding-top: 5px; padding-left: 5px; position: relative;">
        <div style="width:99%; float: left; position: absolute; height: 190px; left: 3px;
            top: 3px; overflow: auto;">
            <table width="100%" cellpadding="1" cellspacing="1" border="0" id="fieldList">
            </table>
        </div>
    </div>
    <div id="fielddemo" style="display:none;">
    </div>
    <script type="text/javascript">
        $(function () {
            initPageData();
        });
        //加载数据
        function initPageData() {
            var id = '<%=Request.QueryString["ID"] %>';
            if (id == -1) return false;
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxLabels.GetInfo(id);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var entity = ajax.value;
            if (entity != null && entity.Rows.length > 0) {
                $("#<%=this.txtLabelFieldName.ClientID %>").html(entity.Rows[0]["FieldDfName"]);
                $("#<%=this.txtDesc.ClientID %>").html(entity.Rows[0]["FieldDfDesc"]);
                $("#<%=this.txtFont.ClientID %>").html(entity.Rows[0]["Font"]);
                $("#<%=this.chkIsBold.ClientID %>").prop("checked", entity.Rows[0]["IsBold"]);
                var s = "";
                for (var i = 0; i < entity.Rows.length; i++) {
                    s += fieldDefString(entity.Rows[i]["DfContent"], entity.Rows[i]["DfType"]);
                }
                $("#fieldList").html(s);

            }
        }

        function fieldDefString(s, t) {
            var h = "";
            h += '<tr class="OddTableRow"><td>';
            h += '<span>' + s + '</span>';
            h += '</td></tr>';
            return h;
        }

        function Edit() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Labels/LabelFieldEdit.aspx?name=Labels_LabelFieldEdit&ID=" + '<%= Request.QueryString["ID"] %>';
            location.href = openWinUrl;
        }
    </script>
</asp:Content>
