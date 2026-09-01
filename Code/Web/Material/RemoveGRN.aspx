<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    CodeBehind="RemoveGRN.aspx.cs" Inherits="SKT.LeanMES.Web.Material.RemoveGRN" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1">
                <%=Resources.lang.ContainerSN%>
            </td>
            <td class="Field1">
                <span id="spnCartonSN"></span>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%=Resources.lang.ScanGRNSN %>
            </td>
            <td class="Field1">
                <input type="text" class="TextBox" style="width: 250px; height: 25px; font-size: 16px;
                    font-weight: bold; text-transform: uppercase;" id="txtGRN" />
            </td>
        </tr>
    </table>
    <div class="clear5">
    </div>
    <div>
        <span id="errMsg" class="Tips"></span>
    </div>
    <div class="clear5">
    </div>
    <table class="ListTable" width="100%" id="tblCartonItemList">
        <tr class="ListTableHeader">
            <th align="left" colspan="2">
                <%=Resources.lang.PackedGRN %><span id="grnRecords" title="<%=Resources.lang.PackedGRNQty %>">[0]</span>
            </th>
        </tr>
    </table>
    <script language="javascript" type="text/javascript">
        var cartonSN = "";
        $(function () {
            $("#txtGRN").focus();
            cartonSN = '<%=Request.QueryString["SN"] %>';
            $("#spnCartonSN").html(cartonSN);
            getCartonItemList(cartonSN);

            /*扫描条码*/
            $("#txtGRN").keydown(function (event) {
                var e = event || window.event;
                if (e && e.keyCode == 13) {
                    Remove();
                }
            });
        });

        function getCartonItemList(cartonsn) {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.GetPackedItemList(cartonsn);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var list = ajax.value;
            if (list.length == 0) {
                $("<tr class='ListTableEmptyDataRow'><td colspan='2'><%=Resources.Messages.NoGrnInTheCarton %></td></tr>").appendTo($("#tblCartonItemList"));
                return false;
            }
            var l = "";
            var rows = $("#tblCartonItemList tr").length - 1;
            $("#grnRecords").html("[" + list.length + "]");
            for (var i = 0; i < list.length; i++) {
                if ((rows + i) % 2 == 0) {
                    l += "<tr class='ListTableOddRow'><td style='width:15px;'>" + (i + 1).toString() + "</td><td style='padding-left:10px;'>" + list[i].SerialNumber + "</td></tr>";
                }
                else {
                    l += "<tr class='ListTableEvenRow'><td style='width:15px;'>" + (i + 1).toString() + "</td><td style='padding-left:10px;'>" + list[i].SerialNumber + "</td></tr>";
                }
            }
            $(l).appendTo($("#tblCartonItemList"));
        }

        function Remove() {
            $("#errMsg").html("");
            $("#errMsg").css("color", "red");
            var txtGRN = $("#txtGRN").val();
            if (cartonSN == "") {
                alert("<%=Resources.Messages.ParameterErrorNoCartonSN %>");
                return false;
            }
            if (txtGRN == "") {
                $("#errMsg").html("<%=Resources.Messages.ScanGrnToRemove %>");
                $("#txtGRN").focus();
                $("#txtGRN").select();
                return false;
            }
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.RemoveGRN(cartonSN, txtGRN);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                $("#txtGRN").focus();
                $("#txtGRN").select();
                return false;
            }
            $("#tblCartonItemList tr").each(function () {
                if ($(this).children("td:eq(1)").html() == txtGRN) {
                    $(this).slideUp(300, function () {
                        $(this).remove();
                        $("#grnRecords").html("[" + ($("#tblCartonItemList tr").length - 1).toString() + "]");
                        $("#errMsg").html(txtGRN + "- <%=Resources.Messages.RemoveGrnSuccessful %>");
                        $("#errMsg").css("color", "green");
                    });
                }
            });
            $("#txtGRN").focus();
            $("#txtGRN").select();

        }

        $(function () {
            $(".ListTableOddRow,.ListTableEvenRow,.ListTableSelectedRow").live({
                mouseenter: function () {
                    $(this).addClass("ListTableHoverRow");
                },
                mouseleave: function () {
                    $(this).removeClass("ListTableHoverRow");
                },
                click: function () {
                    $(".ListTableSelectedRow").not($(this)).removeClass("ListTableSelectedRow");
                    $(this).toggleClass("ListTableSelectedRow");
                }
            });
        });
    </script>
</asp:Content>
