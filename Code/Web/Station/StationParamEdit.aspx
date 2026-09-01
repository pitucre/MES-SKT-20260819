<%@ Page Title="Edit StationParam" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="StationParamEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Station.StationParamEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label2">
                <%= Resources.lang.StationName %>
            </td>
            <td class="Field2">
                <asp:Label ID="lblStationName" runat="server" ClientIDMode="Static"></asp:Label>
            </td>
            <td class="Label2">
                <%= Resources.lang.StationType %>
            </td>
            <td class="Field2">
                <asp:Label ID="lblStationType" runat="server" ClientIDMode="Static"></asp:Label>
            </td>
        </tr>
    </table>
    <br />
    <br />
    <table id="tableParam" width="100%" class="ListTable" cellpadding="0px" cellspacing="0px"
        style="text-align: center">
        <thead>
            <tr class="ListTableTitle" style="text-align: center">
                <th style="width: 10%">
                    <%= Resources.lang.Sequence %>
                </th>
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
        var stationId = <%= Request.QueryString["Id"] == null ? -1 : Convert.ToInt32(Request.QueryString["Id"].ToString())%>;

        $(document).ready(function(){
            ShowParamList();
        });

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
        function ShowParamList() {
            //clearWaitGrnTable();

            var tableParam = document.getElementById("tableParam");
                
            var row, cel;
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxProduct.GetStationParamList(-1, stationId);

            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            } else if (ajax.value != null && ajax.value != undefined && ajax.value.length > 0) {
                $("#tableParam tr:eq(1)").remove();
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
            }
        }
        var rowValidate = true;
        /*保存数据*/
        function Save() {
            //保存数据
            var isSeq = true;
            var paramXML = '<ParamList>';

            $("#tableParam tr").each(function(i, e) {
                if (i > 0) {
                    paramXML += '<Data>';
                    paramXML += '<StationParamId>' + $(e).find("[name='hdnStationParamId']").val() + '</StationParamId>';
                    paramXML += '<ParamSeq>' + $(e).find("[name='txtSeq']").val() + '</ParamSeq>';
                    paramXML += '<ParamName>' + $(e).find("[name='txtParamName']").val() + '</ParamName>';
                    paramXML += '<ParamValue>' + $(e).find("[name='txtParamValue']").val() + '</ParamValue>';
                    paramXML += '</Data>';

                    if (!isNumber($(e).find("[name='txtSeq']").val())) {
                        isSeq = false;
                        alert("序号只能为数字。");
                        return false;
                    }
                }
            });

            paramXML += '</ParamList>';
            if (isSeq && rowValidate) {
                var entity = {};

                entity.ItemId = -1;
                entity.StationId = stationId;
                entity.ParamName = paramXML;
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxProduct.StationParamEdit(entity);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }

                alert('<%=Resources.Messages.SaveInSuccess%>');
                parent.window.UpdateList($("#lblStationName").html());
            }
        }

        function valiDateParam(obj) {
            var trObj = obj.parentElement.parentElement;
            var nowValue = $(trObj).find("[name='txtParamName']").val();
            var allValue = "";
            var count = 0;
            $("#tableParam tr").each(function(i,e) {
                if (i > 0) {
                    allValue = $(e).find("[name='txtParamName']").val();  

                    if (nowValue == allValue)
                        count = count + 1;
                    if (count == 2) {
                        rowValidate = false;
                        //$("#messageText").text("第" + i + "行工序的参数名不能相同");
                        //alert('同产品同工位的参数名不能相同');
                        $(e).find("[name='txtParamName']").css("background-color", "red");
                        $(e).find("[name='txtParamName']").focus();
                        return false;
                    } else {
                       rowValidate = true;
                    }
                }
            });
        }
    </script>
</asp:Content>
