<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    CodeBehind="WarningSettings.aspx.cs" Inherits="SKT.LeanMES.Web.Sparepart.WarningSettings" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="infoTips" colspan="4">
                <%=Resources.Messages.WithAsteriskIsRequired %>
            </td>
        </tr>
        <tr class="clear5">
        </tr>
        <tr>
            <td colspan="2" class="Label" align="left">
                <b><%=Resources.lang.WarningSetting%></b>
            </td>
        </tr>
        <tr>
            <td class="Label1"> 
                <%=Resources.lang.OpenWarning%>
            </td>
            <td class="Field1">
                <input type="checkbox" id="chkIsWarning" />
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%=Resources.lang.WaringRate%><em>*</em>
            </td>
            <td class="Field1">
                <input id="rdaily" type="radio" name="r" value="daily"  style=" padding-right:3px;"/><%=Resources.Common.Daily %>
                <input id="rweekly" type="radio" name="r" value="weekly"  style=" padding-right:3px;"/><%=Resources.Common.Weekly%>
                <input id="rmonthly" type="radio" name="r" value="monthly"  style=" padding-right:3px;"/><%=Resources.Common.Monthly%>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%=Resources.lang.WarningTime%>
            </td>
            <td class="Field1">
                <input id="txtWarningTime" type="text" class="TextBox" style="width: 50px;" />
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%=Resources.lang.Receive1%><em>*</em>
            </td>
            <td class="Field1">
                <input id="txtWarningReceive1" disabled="disabled" readonly="readonly" type="text" IsRequired="1" class="TextBox" style="width: 60%" /><input
                    type="button" class="ButtonBox" value="..." onclick="selectFirst();" />
                <input id="hdfValue1" type="hidden" />
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%=Resources.lang.Receive2%><em>*</em>
            </td>
            <td class="Field1">
                <input id="txtWarningReceive2" disabled="disabled" readonly="readonly" type="text"
                    isrequired="1" class="TextBox" style="width: 60%" /><input
                    type="button" class="ButtonBox" value="..." onclick="selectSecond();" />
                <input id="hdfValue2" type="hidden" />
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%=Resources.lang.Receive3%><em>*</em>
            </td>
            <td class="Field1">
                <input id="txtWarningReceive3" disabled="disabled" readonly="readonly" type="text"
                    isrequired="1" class="TextBox" style="width: 60%" /><input
                    type="button" class="ButtonBox" value="..." onclick="selectThird();" />
                <input id="hdfValue3" type="hidden" />
            </td>
        </tr>
        </table>
        <div class="clear5"></div>
        <table class="EditeContentTable" width="100%">
        <tr>
            <td colspan="2" class="Label" align="left">
                <b><%=Resources.lang.InventorySetting%></b>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%=Resources.lang.OpenInventory%>
            </td>
            <td class="Field1">
                <input type="checkbox" id="chkInventory" />
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%=Resources.lang.InventoryRate %><em>*</em>
            </td>
            <td class="Field1">
                <input id="fdaily" type="radio" name="f" value="daily"  style=" padding-right:3px;"/><%=Resources.Common.Daily %>
                <input id="fweekly" type="radio" name="f" value="weekly"  style=" padding-right:3px;"/><%=Resources.Common.Weekly%>
                <input id="fmonthly" type="radio" name="f" value="monthly"  style=" padding-right:3px;"/><%=Resources.Common.Monthly%>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%=Resources.lang.InventoryTime%>
            </td>
            <td class="Field1">
                <input id="txtInventoryTime" type="text" class="TextBox" style="width: 50px;" />
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%=Resources.lang.Receive1%><em>*</em>
            </td>
            <td class="Field1">
                <input id="txtInventoryReceive1" readonly="readonly" disabled="disabled" type="text"
                    isrequired="1" class="TextBox" style="width: 60%" /><input type="button" class="ButtonBox" value="..." onclick="selectFour();" />
                <input id="hdfValue4" type="hidden" />
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%=Resources.lang.Receive2%><em>*</em>
            </td>
            <td class="Field1">
                <input id="txtInventoryReceive2" disabled="disabled" readonly="readonly" type="text"
                    isrequired="1" class="TextBox" style="width: 60%" /><input type="button" class="ButtonBox" value="..." onclick="selectFive();" />
                <input id="hdfValue5" type="hidden" />
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%=Resources.lang.Receive3%><em>*</em>
            </td>
            <td class="Field1">
                <input id="txtInventoryReceive3" disabled="disabled" readonly="readonly" type="text"
                    isrequired="1" class="TextBox" style="width: 60%" /><input type="button" class="ButtonBox" value="..." onclick="selectSix();" />
                <input id="hdfValue6" type="hidden" />
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        var ID = "";
        $(function () {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSparepart.GetSetting();
            if (ajax.error == null) {
                if (ajax.value == null) {
                    ID = -1;
                }
                else {
                    ID = ajax.value.WSId;
                    $("#chkIsWarning")[0].checked = ajax.value.WSIsWarning;
                    $("#r" + ajax.value.WSWarningRate)[0].checked = true;
                    $("#txtWarningTime").val(ajax.value.WSWarningTime);
                    $("#txtWarningReceive1").val(ajax.value.WSText.split(';')[0]);
                    $("#hdfValue1").val(ajax.value.WSWarningFirst);
                    $("#txtWarningReceive2").val(ajax.value.WSText.split(';')[1]);
                    $("#hdfValue2").val(ajax.value.WSWarningSecond);
                    $("#txtWarningReceive3").val(ajax.value.WSText.split(';')[2]);
                    $("#hdfValue3").val(ajax.value.WSWarningThird);
                    $("#chkInventory")[0].checked = ajax.value.WSIsInventory;
                    $("#f" + ajax.value.WSInventoryRate)[0].checked = true;
                    $("#txtInventoryTime").val(ajax.value.WSInventoryTime);
                    $("#txtInventoryReceive1").val(ajax.value.WSText.split(';')[3]);
                    $("#hdfValue4").val(ajax.value.WSInventoryFirst);
                    $("#txtInventoryReceive2").val(ajax.value.WSText.split(';')[4]);
                    $("#hdfValue5").val(ajax.value.WSInventorySecond);
                    $("#txtInventoryReceive3").val(ajax.value.WSText.split(';')[5]);
                    $("#hdfValue6").val(ajax.value.WSInventoryThird);
                }
            } else {
                alert(ajax.error.Message);
            }
        });
        var temp = "";
        var id1 = "", value1 = "",
            id2 = "", value2 = "",
            id3 = "", value3 = "",
            id4 = "", value4 = "",
            id5 = "", value5 = "",
            id6 = "", value6 = "";
        function selectFirst() {
            temp = 1;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=12&Multiple=false&rnd=" + Math.random(), width: 600, height: 300 });
        }
        function selectSecond() {
            temp = 2;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=12&Multiple=false&rnd=" + Math.random(), width: 600, height: 300 });
        }
        function selectThird() {
            temp = 3;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=12&Multiple=false&rnd=" + Math.random(), width: 600, height: 300 });
        }
        function selectFour() {
            temp = 4;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=12&Multiple=false&rnd=" + Math.random(), width: 600, height: 300 });
        }
        function selectFive() {
            temp = 5;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=12&Multiple=false&rnd=" + Math.random(), width: 600, height: 300 });
        }
        function selectSix() {
            temp = 6;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=12&Multiple=false&rnd=" + Math.random(), width: 600, height: 300 });
        }
        function getChooseValue(list) {
            if (list[0][0] === '-1') {
                $("#hdfValue1").val('');
                $("#txtWarningReceive1").val('');
            }
            if (temp == 1) {
            //BirongLiang 2016-11-07 清除按钮
                if (list[0][0] === '-1') {
                    $("#hdfValue1").val('');
                    $("#txtWarningReceive1").val('');
                    return false;
                }
                if ($("#hdfValue1").val().indexOf(list[0][0]) == -1) {
                    id1 += list[0][0] + ",";
                    value1 += list[0][1] + ",";
                    if (ID == -1) {
                        $("#hdfValue1").val(id1);
                        $("#txtWarningReceive1").val(value1);
                    }
                    else {
                        $("#hdfValue1").val($("#hdfValue1").val() + id1);
                        $("#txtWarningReceive1").val($("#txtWarningReceive1").val() + value1);
                    }
                }
                else {
                    alert("<%=Resources.Messages.RecordExists %>");
                    return false;
                }
            }
            else if (temp == 2) {
                //BirongLiang 2016-11-07 清除按钮
                if (list[0][0] === '-1') {
                    $("#hdfValue2").val('');
                    $("#txtWarningReceive2").val('');
                    return false;
                }
                if ($("#hdfValue2").val().indexOf(list[0][0]) == -1) {
                    id2 += list[0][0] + ",";
                    value2 += list[0][1] + ",";
                    if (ID == -1) {
                        $("#hdfValue2").val(id2);
                        $("#txtWarningReceive2").val(value2);
                    }
                    else {
                        $("#hdfValue2").val($("#hdfValue2").val() + id2);
                        $("#txtWarningReceive2").val($("#txtWarningReceive2").val() + value2);
                    }
                }
                else {
                    alert("<%=Resources.Messages.RecordExists %>");
                    return false;
                }
            }
            else if (temp == 3) {
                //BirongLiang 2016-11-07 清除按钮
                if (list[0][0] === '-1') {
                    $("#hdfValue3").val('');
                    $("#txtWarningReceive3").val('');
                    return false;
                }
                if ($("#hdfValue3").val().indexOf(list[0][0]) == -1) {
                    id3 += list[0][0] + ",";
                    value3 += list[0][1] + ",";
                    if (ID == -1) {
                        $("#hdfValue3").val(id3);
                        $("#txtWarningReceive3").val(value3);
                    }
                    else {
                        $("#hdfValue3").val($("#hdfValue3").val() + id3);
                        $("#txtWarningReceive3").val($("#txtWarningReceive3").val() + value3);
                    }
                }
                else {
                    alert("<%=Resources.Messages.RecordExists %>");
                    return false;
                }
            }
            else if (temp == 4) {
                //BirongLiang 2016-11-07 清除按钮
                if (list[0][0] === '-1') {
                    $("#hdfValue4").val('');
                    $("#txtWarningReceive4").val('');
                    return false;
                }
                if ($("#hdfValue4").val().indexOf(list[0][0]) == -1) {
                    id4 += list[0][0] + ",";
                    value4 += list[0][1] + ",";
                    if (ID == -1) {
                        $("#hdfValue4").val(id4);
                        $("#txtInventoryReceive1").val(value4);
                    }
                    else {
                        $("#hdfValue4").val($("#hdfValue4").val() + id4);
                        $("#txtInventoryReceive1").val($("#txtInventoryReceive1").val() + value4);
                    }
                }
                else {
                    alert("<%=Resources.Messages.RecordExists %>");
                    return false;
                }
            }
            else if (temp == 5) {
                //BirongLiang 2016-11-07 清除按钮
                if (list[0][0] === '-1') {
                    $("#hdfValue5").val('');
                    $("#txtWarningReceive5").val('');
                    return false;
                }
                if ($("#hdfValue5").val().indexOf(list[0][0]) == -1) {
                    id5 += list[0][0] + ",";
                    value5 += list[0][1] + ",";
                    if (ID == -1) {
                        $("#hdfValue5").val(id5);
                        $("#txtInventoryReceive2").val(value5);
                    }
                    else {
                        $("#hdfValue5").val($("#hdfValue5").val() + id5);
                        $("#txtInventoryReceive2").val($("#txtInventoryReceive2").val() + value5);
                    }
                }
                else {
                    alert("<%=Resources.Messages.RecordExists %>");
                    return false;
                }
            }
            else if (temp == 6) {
                //BirongLiang 2016-11-07 清除按钮
                if (list[0][0] === '-1') {
                    $("#hdfValue6").val('');
                    $("#txtWarningReceive6").val('');
                    return false;
                }
                if ($("#hdfValue6").val().indexOf(list[0][0]) == -1) {
                    id6 += list[0][0] + ",";
                    value6 += list[0][1] + ",";
                    if (ID == -1) {
                        $("#hdfValue6").val(id6);
                        $("#txtInventoryReceive3").val(value6);
                    }
                    else {
                        $("#hdfValue6").val($("#hdfValue6").val() + id6);
                        $("#txtInventoryReceive3").val($("#txtInventoryReceive3").val() + value6);
                    }
                }
                else {
                    alert("<%=Resources.Messages.RecordExists %>");
                    return false;
                }
            }
        }

        function Save() {
            var chkIsWarning = $("#chkIsWarning")[0].checked ? 1 : 0;
            var warningRate = $("[name='r']:checked").val();
            var txtWarningTime = $("#txtWarningTime").val();
            var txtWarningReceive1 = $("#hdfValue1").val();
            var txtWarningReceive2 = $("#hdfValue2").val();
            var txtWarningReceive3 = $("#hdfValue3").val();

            var chkInventory = $("#chkInventory")[0].checked ? 1 : 0;
            var inventoryRate = $("[name='f']:checked").val();
            var txtInventoryTime = $("#txtInventoryTime").val();
            var txtInventoryReceive1 = $("#hdfValue4").val();
            var txtInventoryReceive2 = $("#hdfValue5").val();
            var txtInventoryReceive3 = $("#hdfValue6").val();
            
            /*
            表单逻辑判断
            */
            var valRate1 = $('input:radio[name="r"]:checked').val();
            var valRate2 = $('input:radio[name="f"]:checked').val();
            if (valRate1 == null||valRate2==null) {
                alert("<%= Resources.Messages.WithAsteriskIsRequiredAlert %>");
                return false;
            }
            var entity = {};
            entity.WSId = ID;
            entity.WSIsWarning = (parseInt(chkIsWarning) == 1 ? true : false);
            entity.WSWarningRate = warningRate;
            entity.WSWarningTime = txtWarningTime;
            entity.WSWarningFirst = txtWarningReceive1;
            entity.WSWarningSecond = txtWarningReceive2;
            entity.WSWarningThird = txtWarningReceive3;

            entity.WSIsInventory = (parseInt(chkInventory) == 1 ? true : false);
            entity.WSInventoryRate = inventoryRate;
            entity.WSInventoryTime = txtInventoryTime;
            entity.WSInventoryFirst = txtInventoryReceive1;
            entity.WSInventorySecond = txtInventoryReceive2;
            entity.WSInventoryThird = txtInventoryReceive3;
            entity.WSText = $("#txtWarningReceive1").val() + ";" + $("#txtWarningReceive2").val() + ";"
             + $("#txtWarningReceive3").val() + ";" + $("#txtInventoryReceive1").val() + ";" + $("#txtInventoryReceive2").val() + ";" + $("#txtInventoryReceive3").val();
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSparepart.EditSetting(entity);
            if (ajax.error == null) {
                alert("<%= Resources.Messages.SaveInSuccess %>");
            } else {
                alert(ajax.error.Message);
            }
            window.location.herf = window.location.herf;
        } 

    </script>
</asp:Content>
