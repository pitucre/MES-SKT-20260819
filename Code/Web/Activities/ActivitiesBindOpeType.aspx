<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/EditMaster.master" CodeBehind="ActivitiesBindOpeType.aspx.cs" Inherits="SKT.LeanMES.Web.Activities.ActivitiesBindOpeType" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">   
    <table class="ListTable" width="100%" id="tblExpand">
    <tr class="ListTableHeader">
        <th scope="col" style="width:25%;">
            <%=Resources.lang.StationType%>
        </th>
        <th scope="col"  style="width:20%;">
            <%=Resources.lang.Description%>
        </th>
        <th scope="col"  style="width:45%;">
            <%=Resources.lang.ActivitySequence%>
        </th>
        <th scope="col" onclick="addDetail(null);" style="color:#0066CC;cursor:pointer; width:10%;">
            +<%= Resources.Buttons.COM_Add%>
        </th>
    </tr>
    </table>
    <script type="text/javascript">
        var acid = '<%=Request.QueryString["ID"] %>';
        var ac_name = '<%=Request.QueryString["acname"] %>';
        var tab = document.getElementById("tblExpand");

        $(function () {
            initBindOpeTypeList(acid);
            if (tab.rows.length < 2) {
                addDetail(null);
            }
        });

        var rowIndex = -1;
        var rowObj = null;

        function selectItems(obj) {
            rowObj = obj.parentNode.parentNode;
            rowIndex = rowObj.rowIndex;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=4&Multiple=false&rnd=" + Math.random(), width: 600, height: 300 });
        }

        function getChooseValue(list) {
            if (!checkIsRepeat(list[0][0])) {
                rowObj.cells[0].children[2].value = list[0][0];
                rowObj.cells[0].children[0].value = list[0][1];
                rowObj.cells[1].innerHTML = list[0][2];

                if (parseInt(list[0][0]) != -1) {
                    /*get binded activity list*/
                    updateBindCellActivity(list[0][0], rowObj, false);
                    updateBindSequence(rowObj.cells[2].children[0]);
                }
                else {
                    rowObj.cells[2].innerHTML = "";
                }
            }
        }

        function addDetail(entity) {
            if (entity == null) {
                entity = {};
                entity.OpeTypeId = "-1";
                entity.OpeType = "";
                entity.OpeDescription = "";
            }

            var row, cell;
            rowNewIdx = tab.rows.length;
            row = tab.insertRow(rowNewIdx);
            row.className = "ListTableOddRow";

            cell = row.insertCell(0);
            cell.align = "center";
            cell.innerHTML = "<input type=\"text\" name=\"txtOpeType\" class=\"TextBox\" value=\"" + entity.OpeType + "\" disabled=\"disabled\"><input type=\"button\" id=\"btnSelectItems\" onclick=\"selectItems(this);\" class=\"ButtonBox\" value=\"...\" /><input type=\"hidden\" name=\"hdnOpeTypeId\" value=\"" + entity.OpeTypeId + "\" />";

            cell = row.insertCell(1);
            cell.align = "center";
            cell.innerHTML = entity.OpeDescription;

            cell = row.insertCell(2);
            cell.align = "center";
            cell.innerHTML = "";

            cell = row.insertCell(3);
            cell.align = "center";
            cell.innerHTML = "<span style=\"CURSOR: pointer; COLOR: #0000ff;\" onclick=\"deleteItem(tab,this)\"><%= Resources.Buttons.COM_Delete %></span>";
        }


        function deleteItem(tabobj, obj) {
            tabobj.deleteRow(obj.parentNode.parentNode.rowIndex);
        }

        function Save() {
            /*base info*/
            var entity = {};
            entity.AC_ID = acid;
            entity.AC_Name = "";
            entity.AC_Description = "";
            entity.AC_FunctionName = "";
            entity.AC_FunctionCode = "";
            entity.CreateBy = "";
            entity.ModifyBy = "";

            /*options list*/
            var aoidString = "", ac_param_nameString = "", ac_param_valueString = "", ac_param_remarkString = "", ac_sequenceString = "", seq = "^";

            /*bind operationType*/
            var tabString = "";
            var opeTypeIdString = "", acIdString = "", seqString = "";
            var idSeq = ",", trSeq = "^", tabSeq = "~";
            for (var i = 1; i < tab.rows.length; i++) {
                if (tab.rows[i].cells[0].children[2].value != "-1") {
                    opeTypeIdString = "", acIdString = "", seqString = "";
                    var syncTab = $("#tab" + i + "")[0];
                    /*build idString*/
                    for (var h = 1; h < syncTab.rows.length; h++) {
                        var syncRow = syncTab.rows[h];
                        opeTypeIdString += syncRow.cells[3].children[1].value + idSeq;
                        acIdString += syncRow.cells[3].children[2].value + idSeq;
                        seqString += syncRow.cells[3].children[3].value + idSeq;
                    }
                    tabString += opeTypeIdString + trSeq + acIdString + trSeq + seqString + trSeq + tabSeq;
                }
            }
            /*Save Event*/
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxActivity.EditActivity(entity, aoidString, ac_param_nameString, ac_param_valueString, ac_param_remarkString, ac_sequenceString, tabString, 1);
            if (ajax.error == null) {
                alert("<%=Resources.Messages.SaveInSuccess %>");
                window.parent.UpdateList(ac_name);
            } else {
                alert(ajax.error.Message);
            }
        }

        function updateBindSequence(objTab) {
            for (var i = 1; i < objTab.rows.length; i++) {
                objTab.rows[i].cells[1].innerHTML = i.toString();
                objTab.rows[i].cells[3].children[3].value = i.toString();
            }
        }

        function checkIsRepeat(id) {
            var result = false;
            var idObj = document.getElementsByName("hdnOpeTypeId");
            for (var i = 0; i < idObj.length; i++) {
                if (idObj[i].value == id) {
                    result = true;
                    break;
                }
            }
            if (result) { alert("<%=Resources.Messages.RecordExists %>"); }

            return result;
        }

        function initBindOpeTypeList(acids) {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxActivity.GetActivityStation(acids);
            if (ajax.error == null) {
                var entityAry = ajax.value;
                var entity = {};
                for (var i = 0; i < entityAry.length; i++) {
                    entity.OpeTypeId = entityAry[i].StationTypeId;
                    entity.OpeType = entityAry[i].StationType;
                    entity.OpeDescription = entityAry[i].StationDesc;
                    addDetail(entity);

                    /*get binded activity list*/
                    updateBindCellActivity(entity.OpeTypeId, tab.rows[tab.rows.length - 1], true);
                }
            } else {
                alert(ajax.error.Message);
            }
        }

        function updateBindCellActivity(opeTypeId, rowObj, isInit) {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxActivity.GetActivityStationMember(opeTypeId);
            var ary = ajax.value;
            var html = "<table id='tab" + rowObj.rowIndex + "' class='ListTable' cellspacing='0' cellpadding='4' style='border-width:0px;width:100%;border-collapse:collapse;'><tr class='ListTableHeader' style='background-color:steelblue;color:#ffffff;text-align:center;'><td style='font-size:12px;'><%=Resources.lang.AC_Name%></td><td style='font-size:12px;'><%=Resources.lang.ExecuteSequence %></td><td style='font-size:12px;'><%=Resources.lang.UP %></td><td style='font-size:12px;'><%=Resources.lang.Down %></td></tr>";
            if (ary.length > 0) {
                for (var i = 0; i < ary.length; i++) {
                    html += "<tr class='ListTableOddRow' style='text-align:center;'><td>" + ary[i].AC_Name + "</td><td>" + (i + 1).toString() + "</td><td><img src='../Content/images/arrowup.gif' style='cursor:pointer;' onclick='seqUp(this);' /></td><td><img src='../Content/images/arrowdown.gif' style='cursor:pointer;' onclick='seqDown(this);' /><input type='hidden' name='hdnOpeTypeId" + rowObj.rowIndex + "' value='" + opeTypeId + "'><input type='hidden' flag='acids' name='hdnACId" + rowObj.rowIndex + "' value='" + ary[i].AC_ID + "'><input type='hidden' name='hdnSeq" + rowObj.rowIndex + "' value='" + ary[i].Seq + "'></td></tr>";
                }
            }
            if (!isInit) {
                html += "<tr class='ListTableOddRow' style='text-align:center;'><td>" + ac_name + "</td><td>" + (ary.length + 1).toString() + "</td><td><img src='../Content/images/arrowup.gif' style='cursor:pointer;' onclick='seqUp(this);' /></td><td><img src='../Content/images/arrowdown.gif' style='cursor:pointer;' onclick='seqDown(this);' /><input type='hidden' name='hdnOpeTypeId" + rowObj.rowIndex + "' value='" + opeTypeId + "'><input type='hidden' flag='acids' name='hdnACId" + rowObj.rowIndex + "' value='" + acid.toString() + "'><input type='hidden' name='hdnSeq" + rowObj.rowIndex + "' value='" + (ary.length + 1).toString() + "'></td></tr>";
            }
            html += "</table>";

            /*update activity sequence*/
            rowObj.cells[2].innerHTML = html;
        }

        function seqUp(obj) {
            var current = $(obj).parent().parent();
            var tabobj = current[0].parentNode;
            var prev = current.prev();
            if (current.index() > 1) {
                current.insertBefore(prev);
            }
            updateBindSequence(tabobj);
        }

        function seqDown(obj) {
            var current = $(obj).parent().parent();
            var tabobj = current[0].parentNode;
            var next = current.next();
            if (next) {
                current.insertAfter(next);
            }
            updateBindSequence(tabobj);
        }
    </script>
</asp:Content>
