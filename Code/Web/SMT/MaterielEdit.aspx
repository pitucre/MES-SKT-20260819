<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    CodeBehind="MaterielEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Product.MaterielEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="infoTips" align="left" colspan="4">
                <%=Resources.Messages.WithAsteriskIsRequired %>
            </td>
        </tr>
        <tr class="clear5">
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.ItemCode %>
            </td>
            <td class="Field2">
                <asp:HiddenField runat="server" ID="hideItemId" />
                <asp:HiddenField runat="server" ID="hideItemCode" />
                <input id="hdnItemId" type="hidden" value="-1" />
                <input type="text" id="txtItemCode" class="TextBox" value="" disabled="disabled"
                    style="width: 200px;" />
                <input type="button" onclick="selectItems();" class="ButtonBox" value="..." />
            </td>
            <td class="Label2">
                <%= Resources.lang.ItemName%>
            </td>
            <td class="Field2">
                <asp:Label ID="lblItemName" runat="server" ClientIDMode="Static"></asp:Label>
            </td>
        </tr>
        <tr   id="showUpload" style="display:none;">
            <td class="Label2">
                清单上传路径
            </td>
            <td class="Field2" style="text-align: left">
                <asp:FileUpload ID="fuLoadingList" runat="server" onchange="uploadFile(this.value)" />
                <asp:LinkButton ID="linkUploadFile" runat="server" OnClick="linkUploadFile_Click"></asp:LinkButton>
            </td>
            <td class="Label2">
            </td>
            <td class="Field2">
            </td>
        </tr>
    </table>
    <br />
    <br />
    <table id="tableParam" width="100%" class="ListTable" cellpadding="0px" cellspacing="0px"
        style="text-align: center">
        <thead>
            <tr class="ListTableTitle" style="text-align: center">
                <th style="width: 30%">
                    <%= Resources.lang.ItemCode %>
                </th>
                <th style="width: 12%">
                    <%= Resources.lang.Usage%>
                </th>
                <th style="width: 20%">
                    <%= Resources.lang.MLocation %>
                </th>
                <th style="width: 15%">
                    <%= Resources.lang.Station%>
                </th>
                <th style="width: 15%">
                    <%= Resources.lang.Line %>
                </th>
                <th style="width: 15%">
                    <%= Resources.lang.AC_Operate %>
                </th>
            </tr>
        </thead>
    </table>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <input type="hidden" value="" id="hdnOperation" name="hdnOperation" />
    <script type="text/javascript">
        var qid = "<%=preDetailId%>"
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");
        $(function () {
            if (qid != "-1") {
                $("#showUpload").show();
                $("#hdnItemId").val($("#<%=this.hideItemId.ClientID %>").val());
                $("#txtItemCode").val($("#<%=this.hideItemCode.ClientID %>").val());
                itemId = $("#hdnItemId").val();
                var itemcode = $("#txtItemCode").val();
                var list = SKT.LeanMES.Web.AjaxServices.AjaxPreAssemblySetting.GetSubList(itemId, itemcode);
                if (list.error != null) {
                    alert(list.error.Message);
                    return false;
                } else {
                    for (i = 0; i < list.value.length; i++) {
                        addRowFromData(list.value[i]);
                    }
                }
            }
        });
        var count = 1;
        var itemId = $('#hdnItemId').val();

        function addRowFromData(rowdata) {
            var tableParam = document.getElementById("tableParam");
            count = $("#tableParam tr").length;

            var row, cel;

            row = tableParam.insertRow(tableParam.rows.length);
            row.className = "ListTableEvenRow";
            row.id = rowdata.ID.toString();

            cel = row.insertCell(0);
            cel.innerHTML = '<input type="hidden" id="hdnPartID' + count + '" name="hdnPartNo' + count + '" value="' + rowdata.PartID + '" /> <input id="txtPartNO' + count + '"  class="TextBox" style="width: 88%" isrequired="1" disabled="disabled" value="' + rowdata.PartNo + '" /><input type="button" id="btnPartNo' + count + '"  class="ButtonBox" value="..." onclick="selectSubItems(this);" />';

            cel = row.insertCell(1);
            cel.innerHTML = '<input type="text" style="width:70%" CssClass="TextBox" IsRequired="1" IsNumber="1" MaxLength="10" name="txtParamValue" value="' + rowdata.Use_QTY + '" /><em>*</em>';

            cel = row.insertCell(2);
            cel.innerHTML = '<input type="text" style="width:70%" CssClass="TextBox" IsRequired="1" MaxLength="20" name="txtParamValue" value="' + rowdata.Location + '" /><em>*</em>';

            cel = row.insertCell(3);
            cel.innerHTML = '<input type="text" style="width:70%" CssClass="TextBox" IsRequired="1" MaxLength="20" name="txtParamValue" value="' + rowdata.Station + '" /><em>*</em>';

            cel = row.insertCell(4);
            cel.innerHTML = '<input type="hidden" id="hdnLineID' + count + '" name="hdnLineID' + count + '" value="' + rowdata.LineID + '" /> <input id="txtLine' + count + '" class="TextBox" style="width: 70%"  disabled="disabled" value="' + rowdata.Line + '" /> <input type="button" id="btnLine' + count + '" class="ButtonBox" value="..." onclick="selectLine(this);" />';

            cel = row.insertCell(5);
            cel.innerHTML = '<input type="button" value="<%= Resources.Buttons.COM_Delete %>" style="width: 96%;" onclick="DeleteParam(this)" />';

        }

        function BuildRow(itmecode) {
            var tableParam = document.getElementById("tableParam");
            count = $("#tableParam tr").length;

            var row, cel;

            row = tableParam.insertRow(tableParam.rows.length);
            row.className = "ListTableEvenRow";
            row.id = "-1";

            cel = row.insertCell(0);
            cel.innerHTML = '<input type="hidden" id="hdnPartID' + count + '" name="hdnPartNo' + count + '" value="-1" /><input id="txtPartNO' + count + '" class="TextBox" style="width: 88%" isrequired="1" disabled="disabled" /><input type="button" id="btnPartNo' + count + '" class="ButtonBox" value="..." onclick="selectSubItems(this);" />';

            cel = row.insertCell(1);
            cel.innerHTML = '<input type="text" style="width:88%" CssClass="TextBox" IsRequired="1" MaxLength="50" name="txtParamValue" />';

            cel = row.insertCell(2);
            cel.innerHTML = '<input type="text" style="width:88%" CssClass="TextBox" IsRequired="1" MaxLength="50" name="txtParamValue" />';

            cel = row.insertCell(3);
            cel.innerHTML = '<input type="text" style="width:88%" CssClass="TextBox" IsRequired="1" MaxLength="50" name="txtParamValue" />';

            cel = row.insertCell(4);
            cel.innerHTML = '<input type="hidden" id="hdnLineID' + count + '" name="hdnLineID' + count + '" value="-1" /> <input id="txtLine' + count + '" class="TextBox" style="width: 70%"  disabled="disabled" /><input type="button" id="btnLine' + count + '" class="ButtonBox" value="..." onclick="selectLine(this);" />';

            cel = row.insertCell(5);
            cel.innerHTML = '<input type="button" value="<%= Resources.Buttons.COM_Delete %>" style="width: 96%;" onclick="DeleteParam(this)" />';

        }
        //新增行
        function AddParam() {
            var itemcode = $("#txtItemCode").val();
            if (itemcode) {
                if ($("#txtPartNO" + count).val() == '') {
                    alert("请选择子产品");
                } else {

                    BuildRow(itemcode);
                }
            } else {
                alert("请选择产品");
            }
        }

        //删除行
        function DeleteParam(obj) {
            $(obj).parent().parent().remove();
            count -= 1;
        }

        /* 清空指定table中数据 */
        function clearWaitGrnTable() {
            if ($("#tableParam tr").length > 1) {
                $("#tableParam tr:not(:first)").remove();
            }
        }

        function Save() {
            var str = $("#<%=this.lblItemName.ClientID %>").text();
            if (str !== '') {
                if ($("#tableParam tr").length > 1) {
                    var rows = $("#tableParam tr:gt(0)");
                    var entitys = [];
                    $(rows).each(function () {
                        var curRow = $(this);
                        var entity = {};
                        entity.ID = curRow[0].id;
                        entity.ModelID = $("#hdnItemId").val();
                        entity.ModelNo = $("#txtItemCode").val();
                        entity.PartID = curRow[0].cells[0].children[0].value;
                        entity.PartNo = curRow[0].cells[0].children[1].value;
                        entity.Use_QTY = curRow[0].cells[1].children[0].value;
                        entity.Location = curRow[0].cells[2].children[0].value;
                        entity.Station = curRow[0].cells[3].children[0].value;
                        entity.StationID = parseInt(-1);
                        entity.LineID = curRow[0].cells[4].children[0].value;
                        entity.Line = curRow[0].cells[4].children[1].value;
                        entitys.push(entity);
                    });

                    var ajaxresult = SKT.LeanMES.Web.AjaxServices.AjaxPreAssemblySetting.EditAll(entitys);
                    if (ajaxresult.error != null) {
                        alert(ajaxresult.error.Message);
                        return false;
                    }
                    parent.window.UpdateList($("#txtItemCode").val());
                    alert("<%= Resources.Messages.SaveSuccess %>");
                } else {
                    alert("请选择子产品");
                }
            } else {
                alert("请选择产品");
            }
        }

        function selectItems() {
            var pageCondition = " ItemType in(2,3) ";
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=1&CallBackFunc=getChooseValue&PageCondition="
                    + escape(pageCondition) + "&Multiple=false&rnd=" + Math.random(), width: 600, height: 300
            });
        }

        var selectRowCount;
        function selectSubItems(obj) {
            var btnPartNoId = $(obj).attr("id");
            selectRowCount = btnPartNoId.substr(9);
            var pageCondition = " ItemType in(1,4) ";
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=1&CallBackFunc=getSubChooseValue&PageCondition="
                    + escape(pageCondition) + "&Multiple=false&rnd=" + Math.random(), width: 600, height: 300
            });
        }

        function selectLine(obj) {
            var btnLineId = $(obj).attr("id");
            selectRowCount = btnLineId.substr(7);
            dialog({ title: "<%=Resources.Common.ChooseWindow %>",
                src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=21&CallBackFunc=getLineChooseValue" +
                    "&Multiple=false&rnd=" + Math.random(), width: 600, height: 300
            });
        }

        function getChooseValue(list) {
            $("#lblItemName").text(list[0][2]);
            $("#hdnItemId").val(list[0][0]);
            $("#txtItemCode").val(list[0][1]);
            itemId = $("#hdnItemId").val();
            //新增时加载数据
            var list = SKT.LeanMES.Web.AjaxServices.AjaxPreAssemblySetting.GetSubList(list[0][0], list[0][1]);
            if (list.error != null) {
                alert(list.error.Message);
                return false;
            } else {
                for (i = 0; i < list.value.length; i++) {
                    addRowFromData(list.value[i]);
                }
            }
        }

        function getSubChooseValue(list) {
            $("#hdnPartID" + selectRowCount).val(list[0][0]);
            $("#txtPartNO" + selectRowCount).val(list[0][1]);
            //itemId = $("#hdnPartID" + selectRowCount).val();
        }

        function getLineChooseValue(list) {
            $("#hdnLineID" + selectRowCount).val(list[0][0]);
            $("#txtLine" + selectRowCount).val(list[0][1]);
            //itemId = $("#hdnLineID" + selectRowCount).val();
        }

        //导出
        function ImportIn() {
            hdnOperate.val("Import");
            document.forms[0].submit();
        }


        function uploadFile(filePath) {
            if (filePath.length > 0) {
                var str = '';
                var postback = $('#<%= linkUploadFile.ClientID %>').attr('href');
                var funcStartIndex = postback.indexOf('\'');
                var funcEndIndex = postback.indexOf('\',');
                if (funcStartIndex != -1 && funcEndIndex != -1) {
                    var str = postback.substring(funcStartIndex + 1, funcEndIndex);
                    __doPostBack(str, '');
                } else {
                    return false;
                }
            }
        }
    </script>
</asp:Content>
