<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    CodeBehind="LabelPrint.aspx.cs" Inherits="SKT.LeanMES.Web.Labels.LabelPrint" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label2">zpl模板</td>
            <td class="Field2">
                <select id="selPrintDocs"></select>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                ZPL模板内容
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtZPLValue" CssClass="TextArea" runat="server" Style="width: 500px;
                    height: 350px;" TextMode="MultiLine"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.Label %>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtDescription" runat="server" CssClass="TextBox"></asp:TextBox>
                <asp:TextBox ID="txtNumber" runat="server" CssClass="NumericBox50" Width="45" Text="1"></asp:TextBox>
                <input type="checkbox" id="ckbLoop" /><%= Resources.lang.IncreaseSerialNumber %>
            </td>
        </tr>
    </table>
    <div class="clear5">
    </div>
    <center>
        <input type="button" value="<%= Resources.Buttons.PrintBarcode %>" onclick="printDemo();" />
    </center>
     
    <script src="../Content/js/skt.utility.printer.js?v=3" type="text/javascript"></script>
    <script type="text/javascript">
        var printerDemo = null;
        var zplStr = "";
        getPrintDocs();

        function printDemo() {
            zplStr = $("#<%=this.txtZPLValue.ClientID %>").val();
            var s = "";

            if (zplStr.indexOf("%") > -1) {
                var arr = reg(zplStr);
                for (var i = 0; i < arr.length; i++) {
                    s += "<tr><td class='Label1'>%" + arr[i] + "%</td><td class='Field1'><input type='text' name='zplParam' class='TextBox'/></td></tr>";
                }
                s = "<div style='overflow:auto; height:350px;'><table class='EditeContentTable' width='100%'>" + s + "</table></div>";

                var btn = { text: " <%= Resources.lang.PrintTest %> ", onclick: "doPrintDemo" };
                dialog({ title: "<%= Resources.lang.PrintTest %>", content: s, width: 550, height: 350, buttons: btn, resizeable: false });
            }
            else {
                doPrintDemo();
            }
        }
        function doPrintDemo() {
            if (zplStr.indexOf("%") > -1) {
                var zplParams = $("input[name='zplParam']");
                var arr = reg(zplStr);

                for (var i = 0; i < arr.length; i++) {
                    zplStr = zplStr.replace("%" + arr[i] + "%", $(zplParams[i]).val());
                }
            }

            try {
                printLabel("", zplStr, "", "zpl");
            }
            catch (e) {
                alert(e);
            }
        }
        /*Get Print Documents*/
        function getPrintDocs() {
            var ajax = SKT.LeanMES.Web.Labels.LabelPrint.GetPrintDocs();
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var selPrintDocs = "";
            var dt = ajax.value;
            var rows = dt.Rows;
            for (var i = 0; i < rows.length; i++) {
                selPrintDocs += '<option value="' + rows[i]["LabelDocumentId"] + '" printqty="' + rows[i]["Print_Qty"] + '" printtemplatename="' + rows[i]["TemplateName"] + '">' + rows[i]["DocumentName"] + '</option>';
            }

            $("#selPrintDocs").html(selPrintDocs);
        }

        $(function () {
            $("#selPrintDocs").bind("change", function () {
                var $selPrintDocs = $("#selPrintDocs").find("option:selected");
                var printTemplateName = $selPrintDocs.attr("printtemplatename");
                var printQty = $selPrintDocs.attr("printqty");

                var ajax = SKT.LeanMES.Web.Labels.LabelPrint.GetPrintTemplate(printTemplateName);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }
                $("#<%=this.txtZPLValue.ClientID %>").text(ajax.value);
            });
        });
    </script>
</asp:Content>
