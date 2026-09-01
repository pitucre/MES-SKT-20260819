<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="StationParamAdd.aspx.cs" Inherits="SKT.LeanMES.Web.Product.StationParamAdd" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label2">
                <%= Resources.lang.ItemCode %>
            </td>
            <td class="Field2">
                <asp:Label ID="lblItemCode" runat="server" ClientIDMode="Static"></asp:Label>
            </td>
            <td class="Label2">
                <%= Resources.lang.ItemName %>
            </td>
            <td class="Field2">
                <input id="hdnItemId" type="hidden" value="-1"/>
                <input type="text" id="txtItemName" class="TextBox" value="" disabled="disabled" style="width: 200px;" />
                <input type="button" onclick="selectItems();" class="ButtonBox" value="..." />
            </td>
        </tr>
    </table>
    <br />
    <br />
    <%--<div class="toolBar">
        <div class="toolbar-btn">
            <div class="icon-16-add">
            </div>
            <div class="btn-text" onclick="AddParam()">
                新增参数</div>
            <div id='messageText' style="color: Red">
            </div>
        </div>
    </div>--%>
    <table id="tableParam" width="100%" class="ListTable" cellpadding="0px" cellspacing="0px"
        style="text-align: center">
        <thead>
            <tr class="ListTableTitle" style="text-align: center">
                <th style="width: 10%">
                    <%= Resources.lang.Sequence %>
                </th>
                <%--<th style="width: 30%">
                    工位名称
                </th>--%>
                <th style="width: 20%">
                    <%= Resources.lang.ParamName %>
                </th>
                <th style="width: 20%">
                    <%= Resources.lang.ParamValue %>
                </th>
                <th style="width: 5%">
                    <%= Resources.lang.AC_Operate %>
                </th>
            </tr>
        </thead>
        <tr class="ListTableEvenRow">
            <td>
                <input type="text" style="width: 90%" isrequired="1" name="txtSeq" value="1" />
                    <input type="hidden" style="display: none" value="-1" name="hdnStationParamId" />
            </td>
            <%--<td class="Field2">
                <input type="hidden" id='hdnStationId' name='hdnStationId' value="-1" />
                <input id="txtStation" class="TextBox" style="width: 90%" isrequired="1" disabled="disabled" />
                <input type="button" id="btnSelectStation" class="ButtonBox" value="..." onclick="selectStation(this);" />
            </td>--%>
            <td>
                <input type="text" style="width: 96%" cssclass="TextBox" isrequired="1" name="txtParamName"
                    onblur="valiDateParam(this)" />
            </td>
            <td>
                <input type="text" style="width: 96%" cssclass="TextBox" isrequired="1" name="txtParamValue" />
            </td>
            <td>
                <input type="button" value="<%= Resources.Buttons.COM_Delete %>" onclick="DeleteParam(this)" />
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        var itemId = $('#hdnItemId').val();

        //$(document).ready(function(){
        //    ShowParamList(itemId);
        //});

        //新增一个参数
        function AddParam() {
            var tableParam = document.getElementById("tableParam");
            var count= $("#tableParam tr").length;

            var row, cel;

            row = tableParam.insertRow(tableParam.rows.length);
            row.className = "ListTableEvenRow";

            cel = row.insertCell(0);
            cel.innerHTML = '<input type="text" style="width:90%" CssClass="TextBox" IsRequired="1" MaxLength="50" name="txtSeq" value="' + count + '" />'+
                            '<input type="hidden" style="display:none" value="-1" name="hdnStationParamId" />';

            cel = row.insertCell(1);
            cel.innerHTML = '<input type="text" style="width:96%" CssClass="TextBox" IsRequired="1" MaxLength="50" name="txtParamName" onblur="valiDateParam(this)" />';

            cel = row.insertCell(2);
            cel.innerHTML = '<input type="text" style="width:96%" CssClass="TextBox" IsRequired="1" MaxLength="50" name="txtParamValue" />';

            cel = row.insertCell(3);
            cel.innerHTML = '<input type="button" value="<%= Resources.Buttons.COM_Delete %>" onclick="DeleteParam(this)" />';
        }

        //删除一个参数
        function DeleteParam(obj) {
            $(obj).parent().parent().remove();
        }

        /* 清空指定table中数据 */
        function clearWaitGrnTable() {
            if ($("#tableParam tr").length > 1) {
                $("#tableParam tr:not(:first)").remove();
            }
        }

        //显示已配置参数列表
        function ShowParamList(id) {
            if (id == -1) {
                $("#txtItemName").val("没有产品信息");
                return false;
            }
            //clearWaitGrnTable();

            var tableParam = document.getElementById("tableParam");
                
            var row , cel;
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxProduct.GetStationParamList(id, -1);

            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            } else if (ajax.value != null && ajax.value != undefined && ajax.value.length > 0) {
                $("#tableParam tr:gt(0)").remove();
                var entity = ajax.value;
              
                for(var i = 0 ; i < entity.length ; i++) {
                    row = tableParam.insertRow(tableParam.rows.length);
                    row.className = "ListTableEvenRow";

                    cel = row.insertCell(0);
                    cel.innerHTML = '<input type="text" style="width:90%" CssClass="TextBox" IsRequired="1" MaxLength="50" name="txtSeq" value="'+ entity[i].ParamSeq +'" />'
                                    +'<input type="hidden" style="display:none" value="'+ entity[i].StationParamId +'" name="hdnStationParamId" />';

                    cel = row.insertCell(1);
                    cel.innerHTML = '<input type="text" style="width:96%" CssClass="TextBox" IsRequired="1" MaxLength="50" value="'+ entity[i].ParamName +'" name="txtParamName" onblur="valiDateParam(this)" />';

                    cel = row.insertCell(2);
                    cel.innerHTML = '<input type="text" style="width:96%" CssClass="TextBox" IsRequired="1" MaxLength="50" value="'+ entity[i].ParamValue +'" name="txtParamValue" />';

                    cel = row.insertCell(3);
                    cel.innerHTML = '<input type="button" value="<%= Resources.Buttons.COM_Delete %>" onclick="DeleteParam(this)" />';
                }
            } else {
                clearWaitGrnTable();
            }
        }

        var rowValidate = true;
        /*保存数据*/
        function Save() {
            if (itemId == -1) {
                alert("请选择产品");
                return false;
            }
            var isSeq = true;
            var paramXML = '<ParamList>';

            $("#tableParam tr").each(function (i, e) {
                if (i > 0) {
                    paramXML += '<Data>';
                    paramXML += '<StationParamId>' + $(e).find("[name='hdnStationParamId']").val() + '</StationParamId>'; ; ;
                    paramXML += '<ParamSeq>' + $(e).find("[name='txtSeq']").val() + '</ParamSeq>';
                    //paramXML += '<StationId>' + $(e).find("[name='hdnStationId']").val() + '</StationId>';
                    paramXML += '<ParamName>' + $(e).find("[name='txtParamName']").val() + '</ParamName>';
                    paramXML += '<ParamValue>' + $(e).find("[name='txtParamValue']").val() + '</ParamValue>';
                    paramXML += '</Data>';

                    if (!isNumber($(e).find("[name='txtSeq']").val())) {
                        isSeq = false;
                        alert("序号只能为数字");
                        return false;
                    }
                }
            });

            paramXML += '</ParamList>';
            if (isSeq && rowValidate) {
                var entity = {};

                entity.ItemId = itemId;
                entity.StationId = -1;
                entity.ParamName = paramXML;
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxProduct.StationParamEdit(entity);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }

                alert('<%=Resources.Messages.SaveInSuccess%>');
                parent.window.UpdateList($("#txtItemName").val(), $("#lblItemCode").html());
            }
        }

        function valiDateParam(obj) {
            var trObj = obj.parentElement.parentElement;
            var nowValue = $(trObj).find("[name='txtParamName']").val();
            var allValue = "";
            var count = 0;
            $("#tableParam tr").each(function (i, e) {
                if (i > 0) {
                    allValue = $(e).find("[name='txtParamName']").val();

                    if (nowValue == allValue)
                        count = count + 1;
                    if (count == 2) {
                        rowValidate = false;
                        //$("#messageText").text("第" + i + "行产品的参数名不能相同");
                        //alert('同产品参数名不能相同');
                        $(e).find("[name='txtParamName']").css("background-color", "red");
                        $(e).find("[name='txtParamName']").focus();
                        return false;
                    } else {
                        rowValidate = true;
                    }
                }
            });
        }

        function selectItems(obj) {
            var pageCondition = " ItemType in(2,3) ";
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=1&PageCondition="
                + escape(pageCondition) + "&Multiple=false&rnd=" + Math.random(), width: 600, height: 300
            });
        }


        function getChooseValue(list) {
            $("#txtItemName").val(list[0][2]);
            $("#hdnItemId").val(list[0][0]);
            $("#lblItemCode").html(list[0][1]);
            itemId = $("#hdnItemId").val();
            ShowParamList(list[0][0]);
        }
    </script>
</asp:Content>

