<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    CodeBehind="StationParamAdd.aspx.cs" Inherits="SKT.LeanMES.Web.Station.StationParamAdd" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <div style="min-width: 560px;">
        <table width="100%" class="EditeContentTable">
            <tr>
                <td class="Label2">
                    <%= Resources.lang.StationName %><em>*</em>
                </td>
                <td class="Field2" style="min-width: 250px">
                    <input id="hdStationId" type="hidden" value="-1" />
                    <input type="text" id="txtStationName" class="TextBox" value="" isrequired="1" disabled="disabled"
                        style="width: 200px;" /><input type="button" onclick="selectItems();" class="ButtonBox"
                            value="..." />
                </td>
                <td class="Label2">
                    <%= Resources.lang.StationType %>
                </td>
                <td class="Field2">
                    <asp:Label ID="lblStationType" runat="server" ClientIDMode="Static"></asp:Label>
                </td>
            </tr>
        </table>
        <div class="clear5">
        </div>
        <div class="divHeader">
            工序工艺参数列表</div>
        <table id="tableParam" width="100%" class="ListTable">
            <tr class="ListTableHeader">
                <th style="width: 60px">
                    <%= Resources.lang.Sequence %>
                </th>
                <th style="width: 160px">
                    <%= Resources.lang.ParamName %><em>*</em>
                </th>
                <th>
                    <%= Resources.lang.ParamValue %><em>*</em>
                </th>
                <th style="width: 80px">
                    <a href="javascript:void(0)" onclick="AddParam()">添加参数</a>
                </th>
            </tr>
            <tr class="ListTableEmptyDataRow">
                <td colspan="4">
                    <span>
                    当前选择工序还没有任何工艺参数，请点击'添加参数'来为工序增加工艺参数
                        </span>
                </td>
            </tr>
        </table>
    </div>
    <script type="text/javascript">
        var stationId = $('#hdStationId').val();
        $(document).ready(function () {
            var stdId = '<%=Request.QueryString["ID"] %>';
            if (parseInt(stdId) != -1) {
                $(".ButtonBox").attr("disabled", "disabled");
                ShowParamList(stdId);
                var stationName = '<%=Request.QueryString["StationName"] %>';
                var stationTypeName = '<%=Request.QueryString["StationTypeName"] %>';
                $("#hdStationId").val(stdId);
                $("#txtStationName").val(decodeURIComponent(stationName));
                $("#lblStationType").text(decodeURIComponent(stationTypeName));
            }
        });


        //新增一个参数
        function AddParam() {
            $(".ListTableEmptyDataRow").remove()
            var tableParam = document.getElementById("tableParam");
            var count = $("#tableParam tr").length;
            var row, cel;

            row = tableParam.insertRow(tableParam.rows.length);
            row.className = "ListTableEvenRow";

            cel = row.insertCell(0);
            cel.style.cssText = "text-align:center";
            cel.innerHTML = '<input type="text" class="NumericBox50" IsRequired="1" MaxLength="50" name="txtSeq" value="' + count + '" />' +
                            '<input type="hidden" value="-1" name="hdnStationParamId" />';

            cel = row.insertCell(1);
            cel.innerHTML = '<input type="text" style="width:90%" CssClass="TextBox" IsRequired="1" MaxLength="50" name="txtParamName" onblur="valiDateParam(this)" />';

            cel = row.insertCell(2);
            cel.innerHTML = '<input type="text" style="width:96%" CssClass="TextBox" IsRequired="1" MaxLength="50" name="txtParamValue" />';

            cel = row.insertCell(3);
            cel.style.cssText = "text-align:center";
            cel.innerHTML = '<a href="javascript:void(0)" onclick="DeleteParam(this)"><%= Resources.Buttons.COM_Delete %></a>';
        }

        //删除一个参数
        function DeleteParam(obj) {
            $(obj).parent().parent().remove();
            if ($("#tableParam tr").length == 1) {
                $("#tableParam").append("<tr class='ListTableEmptyDataRow'><td colspan='4'>" + mesLang("当前选择工序还没有任何工艺参数，请点击'添加参数'来为工序增加工艺参数") +"</td></tr>");
            }
            else {
                $("#tableParam tr:gt(0)").each(function (i) {
                    $(this).children("td:eq(0)").children("input[name='txtSeq']").val(i + 1);
                });
            }
        }

        /* 清空指定table中数据 */
        function clearWaitGrnTable() {
            if ($("#tableParam tr").length > 1) {
                $("#tableParam tr:not(:first)").remove();
                $("#tableParam").append("<tr class='ListTableEmptyDataRow'><td colspan='4'>" + mesLang("当前选择工序还没有任何工艺参数，请点击'添加参数'来为工序增加工艺参数") +"</td></tr>");
            }
        }

        //显示已配置参数列表
        function ShowParamList(id) {
            if (id == -1) {
                $("#txtStationName").val("无产品信息");
                return false;
            }
            var tableParam = document.getElementById("tableParam");

            var row, cel;
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxProduct.GetStationParamList(-1, id);

            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            } else if (ajax.value != null && ajax.value != undefined && ajax.value.length > 0) {
                $("#tableParam tr:gt(0)").remove();
                var entity = ajax.value;

                for (var i = 0; i < entity.length; i++) {
                    row = tableParam.insertRow(tableParam.rows.length);
                    row.className = "ListTableEvenRow";

                    cel = row.insertCell(0);
                    cel.style.cssText = "text-align:center";
                    cel.innerHTML = '<input type="text" class="NumericBox50" IsRequired="1" MaxLength="50" name="txtSeq" value="' + entity[i].ParamSeq + '" />'
                                    + '<input type="hidden" style="display:none" value="' + entity[i].StationParamId + '" name="hdnStationParamId" />';

                    cel = row.insertCell(1);
                    cel.innerHTML = '<input type="text" style="width:90%" class="TextBox" IsRequired="1" MaxLength="50" value="' + entity[i].ParamName + '" name="txtParamName" onblur="valiDateParam(this)" />';

                    cel = row.insertCell(2);
                    cel.innerHTML = '<input type="text" style="width:96%" class="TextBox" IsRequired="1" MaxLength="50" value="' + entity[i].ParamValue + '" name="txtParamValue" />';

                    cel = row.insertCell(3);
                    cel.style.cssText = "text-align:center";
                    cel.innerHTML = '<a href="javascript:void(0)" onclick="DeleteParam(this)"><%= Resources.Buttons.COM_Delete %></a>';
                }
            } else {
                clearWaitGrnTable();
            }
        }

        var rowValidate = true;
        /*保存数据*/
        function Save() {
            stationId = $('#hdStationId').val();
            if (stationId == -1) {
                alert("请选择工序名称！");
                return false;
            }
            var isSeq = true;
            var paramXML = '<ParamList>';

            if ($("input[name='txtSeq']").length == 0) {
                alert("当前选择工序还没有任何工艺参数，无需保存。\n您可以点击'添加参数'来为工序增加工艺参数。");
                return false;
            }

            $("#tableParam tr").each(function (i, e) {
                if (i > 0) {
                    //                    paramXML += '<Data>';
                    //                    paramXML += '<StationParamId>' + $(e).find("[name='hdnStationParamId']").val() + '</StationParamId>'; ; ;
                    //                    paramXML += '<ParamSeq>' + $(e).find("[name='txtSeq']").val() + '</ParamSeq>';
                    //                    paramXML += '<ParamName>' + $(e).find("[name='txtParamName']").val() + '</ParamName>';
                    //                    paramXML += '<ParamValue>' + $(e).find("[name='txtParamValue']").val() + '</ParamValue>';
                    //                    paramXML += '<StationId>' + $('#hdStationId').val() + '</StationId>';
                    //                    paramXML += '</Data>';

                    /* XMl转义字符串处理 chenglong.zhu 2016.11.22 */
                    var value = $(e).find("[name='txtParamValue']").val();
                    if (value.indexOf("<") >= 0 || value.indexOf(">") >= 0 || value.indexOf("&") >= 0) {
                        value = value.replace(/\&/g, "&amp;").replace(/\</g, "&lt;").replace(/\>/g, "&gt;");
                    }
                    var name = $(e).find("[name='txtParamName']").val();
                    if (name.indexOf("<") >= 0 || name.indexOf(">") >= 0 || name.indexOf("&") >= 0) {
                        name = name.replace(/\&/g, "&amp;").replace(/\</g, "&lt;").replace(/\>/g, "&gt;");
                    }
                    paramXML += '<Data>';
                    paramXML += '<StationParamId>' + $(e).find("[name='hdnStationParamId']").val() + '</StationParamId>'; ; ;
                    paramXML += '<ParamSeq>' + $(e).find("[name='txtSeq']").val() + '</ParamSeq>';
                    paramXML += '<ParamName>' + name + '</ParamName>';
                    paramXML += '<ParamValue>' + value + '</ParamValue>';
                    paramXML += '<StationId>' + $('#hdStationId').val() + '</StationId>';
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
                entity.ItemId = -1;
                entity.StationId = stationId;
                entity.ParamName = paramXML;
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxProduct.StationParamEdit(entity);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }

                alert('<%=Resources.Messages.SaveInSuccess%>');
                parent.window.UpdateList($("#txtStationName").val());
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
                    if (nowValue == allValue && allValue != "")
                        count = count + 1;
                    if (count == 2) {
                        rowValidate = false;
                        $(e).find("[name='txtParamName']").css("background-color", "yellow");
                        $(e).find("[name='txtParamName']").attr("title", "参数名称有重复");
                        $(e).find("[name='txtParamName']").focus();
                        return false;
                    } else {
                        rowValidate = true;
                        $(e).find("[name='txtParamName']").css("background-color", "");
                        $(e).find("[name='txtParamName']").removeAttr("title")
                    }
                }
            });
        }

        function selectItems(obj) {
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=8&Multiple=false&rnd=" + Math.random(), width: 650, height: 320 });
        }


        function getChooseValue(list) {
            $("#txtStationName").val(list[0][1]);
            $("#hdStationId").val(list[0][0]);
            $("#lblStationType").html(list[0][2]);
            stationId = $("#hdStationId").val();
            ShowParamList(list[0][0]);
        }
    </script>
</asp:Content>
