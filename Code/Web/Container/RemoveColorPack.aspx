<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RemoveColorPack.aspx.cs" Inherits="SKT.LeanMES.Web.Container.RemoveColorPack" %>

<html>
<head id="Head1" runat="server">
    <title></title>
    <link href="../Content/Main.css" rel="stylesheet" type="text/css"  />
    <script src="../Content/js/jquery.min.js" type="text/javascript"></script>
    <style type="text/css">   
    </style>
</head>
<body>
    <table class="EditeContentTable" width="100%">
    <tr>
    <td colspan="2"><input  class="button" value="移除" type="button" onclick="Remove()"/></td>
    </tr>
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
            <th>
                <input name="chkSelect" id="chkSelect" type="checkbox" value="-1" />
            </th>
            <th align="left" colspan="2">
                <%=Resources.lang.PackedGRN %><span id="grnRecords" title="<%=Resources.lang.PackedGRNQty %>">[0]</span>
            </th>
        </tr>
    </table>
    <script language="javascript" type="text/javascript">
       /* $("form").submit(function (e) {
            if (e && e.preventDefault) {
                e.preventDefault();
            }
            else {
                window.event.returnValue = false;
            }
            return false;
        })*/
        var cartonSN = "";
        $(function () {
            $("#txtGRN").focus();
            cartonSN = '<%=Request.QueryString["carTonSn"] %>';
            $("#spnCartonSN").html(cartonSN);
            getCartonItemList(cartonSN);
            
            /*扫描条码*/
            $("#txtGRN").keypress(function () {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {

                    Delete();
                    return false;
                }
            });
        });
        $("#chkSelect").click(function () {
            if (this.checked) {
                $("input[name='chkSelect']").attr('checked', true)
            } else {
                $("input[name='chkSelect']").attr('checked', false)
            }
        });
        /*得到选中记录的值*/
        function getSelectedValues() {
            var selValues = "";
            var checkboxs = document.getElementsByName("chkSelect");
            var checkboxCount = checkboxs.length;

            for (var i = 0; i < checkboxCount; i++) {
                if (checkboxs[i].checked) {
                    if (selValues != "") {
                        selValues += ",";
                    }

                    selValues += checkboxs[i].value;
                }
            }
            return selValues;
        }

        function getCartonItemList(cartonsn) {

            var ajax = parent.SKT.LeanMES.Web.AjaxServices.AjaxClient.GetPackedItemList(cartonsn);
                             
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var list = ajax.value;
            if (list.length == 0) {
                $("<tr class='ListTableEmptyDataRow'><td colspan='3'><%=Resources.Messages.NoGrnInTheCarton %></td></tr>").appendTo($("#tblCartonItemList"));
                return false;
            }
            var l = "";
            var rows = $("#tblCartonItemList tr").length - 1;
            $("#grnRecords").html("[" + list.length + "]");
            for (var i = 0; i < list.length; i++) {
                if ((rows + i) % 2 == 0) {
                    l += "<tr class='ListTableOddRow'><td style='width:15px;'>" + (i + 1).toString() + "</td><td><input name='chkSelect' align='center' type='checkbox' value='" + list[i].MaterialUnitId + "'/></td><td style='padding-left:10px;'>" + list[i].SerialNumber + "</td></tr>";
                }
                else {
                    l += "<tr class='ListTableEvenRow'><td style='width:15px;'>" + (i + 1).toString() + "</td><td><input name='chkSelect' align='center' type='checkbox' value='" + list[i].MaterialUnitId + "'/></td><td style='padding-left:10px;'>" + list[i].SerialNumber + "</td></tr>";
                }
            }
            $(l).appendTo($("#tblCartonItemList"));
        }
        var AllUnitId = "";
        function Remove() {
            var tempGRN = "";
            AllUnitId = getSelectedValues();
            $("#errMsg").html("");
            $("#errMsg").css("color", "red");
            var txtGRN = $("#txtGRN").val();
            if (cartonSN == "") {
                alert("<%=Resources.Messages.ParameterErrorNoCartonSN %>");
                return false;
            }

            if (AllUnitId == "") {
                $("#errMsg").html("请选择需要移除的GRN");
                return false;
            }
            if (!confirm("确定从当前物料包装箱内移除选择的物料吗？")) {
                return false;
            }
            var ajax = parent.SKT.LeanMES.Web.AjaxServices.AjaxClient.RemoveGRN(cartonSN, txtGRN, AllUnitId);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                $("#txtGRN").focus();
                $("#txtGRN").select();
                return false;
            }
            $("#tblCartonItemList tr").each(function () {
                if ($($(this).find("td")[1]).find("input[name='chkSelect']").is(":checked")) {
                    tempGRN += $($(this).find("td")[2]).html() + ",";
                    $(this).slideUp(300, function () {
                        $(this).remove();
                        $("#grnRecords").html("[" + ($("#tblCartonItemList tr").length - 1).toString() + "]");
                        $("#errMsg").html(tempGRN + "- <%=Resources.Messages.RemoveGrnSuccessful %>");
                        $("#errMsg").css("color", "red");
                    });
                }
            });
            //document.forms[0].submit();

            $("#txtGRN").focus();
            $("#txtGRN").select();
        }
        /*单个回车移除GRN*/
        function Delete() {
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
            var ajax = parent.SKT.LeanMES.Web.AjaxServices.AjaxClient.RemoveGRN(cartonSN, txtGRN, AllUnitId);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                $("#txtGRN").focus();
                $("#txtGRN").select();
                return false;
            }
            $("#tblCartonItemList tr").each(function () {
                if ($(this).children("td:eq(2)").html() == txtGRN) {
                    $(this).slideUp(300, function () {
                        $(this).remove();
                        $("#grnRecords").html("[" + ($("#tblCartonItemList tr").length - 1).toString() + "]");
                        $("#errMsg").html(txtGRN + "- <%=Resources.Messages.RemoveGrnSuccessful %>");
                        $("#errMsg").css("color", "red");
                    });
                }
            });
            $("#txtGRN").focus();
            $("#txtGRN").select();
            // parent.window.UpdateList();
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
</body>
</html>
