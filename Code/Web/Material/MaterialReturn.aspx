<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ViewMaster.master" AutoEventWireup="true"
    CodeBehind="MaterialReturn.aspx.cs" Inherits="SKT.LeanMES.Web.Material.MaterialReturn" %>

<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="server">
    <table width="100%" class="EditeContentTable">
        <tr class="Label">
            <td align="left">
                <span class="information16"></span>请输入或扫描要退料的物料条码和库位条码
            </td>
            <td align="right">
                <span class="informationlink"></span><a href="#" onclick="openCombineMaterial();">物料合并</a>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                物料条码<em>*</em>
            </td>
            <td class="Field1">
                <input type="text" value="" id="txtGRN" class="TextBox" style="width: 250px; height: 25px;
                    font-size: 16px; font-weight: bold; text-transform: uppercase;" />
            </td>
        </tr>
        <tr>
            <td class="Label1">
                库位条码<em>*</em>
            </td>
            <td class="Field1">
                <input type="text" value="" id="txtWareCode" class="TextBox" style="width: 250px;
                    height: 25px; font-size: 16px; font-weight: bold; text-transform: uppercase;" />
            </td>
        </tr>
        <tr>
            <td class="Label1">
                退料数量<em>*</em>
            </td>
            <td class="Field1">
                <input type="text" id="txtQty" class="TextBox" value="0" onafterpaste="if(isNaN(value))execCommand('undo')"
                    style="width: 100px; height: 25px; text-transform: uppercase; font-size: 15px;
                    font-weight: bold; text-align: right" isnumber='1' isrequired='1' disabled="disabled" />
                <input type="button" id="btnReturn" class="ButtonBox" value="..." style="height: 27px;
                    font-weight: bold; text-transform: uppercase;" />
            </td>
        </tr>
        <tr>
            <td class="Label1">
                部门
            </td>
            <td class="Field1">
                <input type="text" value="" id="txtDepartment" class="TextBox" style="width: 250px;
                    height: 25px; font-size: 16px; font-weight: bold; text-transform: uppercase;" />
                <input id="button2" class="ButtonBox" type="button" onclick="selectDepartmentValue()"
                    value="..." isrequired='1' title="选择部门"  style="height: 27px;
                    font-weight: bold; text-transform: uppercase;"/>
                <asp:HiddenField ID="hfDepartId" runat="server" Value="-1" />
            </td>
        </tr>
    </table>
    <div class="clear5">
    </div>
    <div style="text-align: center;" class="Tips" id="msg">
    </div>
    <div class="clear5">
    </div>
    <div class="ListTableTitle">
        <div style="position: absolute; left: 10px; top: 5px; line-height: 18px;">
            退料历史记录
        </div>
        <div style="position: absolute; right: 10px; top: 5px; line-height: 18px;">
            <a href="javascript:clearScreen();">清空列表</a>
        </div>
    </div>
    <div id="tblInfo" style="text-align: left; color: #810000; height: 25px; line-height: 22px;
        background: #f7f7f7; padding-left: 10px; border-left: 1px solid #d3d3d3; border-right: 1px solid #d3d3d3;">
        <img src="../Content/images/icon/comment.png" style="vertical-align: middle;" alt="" />您可以扫描物料条码和库位条码来退料。
    </div>
    <div style="overflow: auto;" id="tblList">
        <table class="ListTable" width="100%" id="tblRecHistory">
            <tr class="ListTableHeader">
                <th>
                    序号
                </th>
                <th>
                    物料条码
                </th>
                <th>
                    物料名称
                </th>
                <th>
                    物料描述
                </th>
                <th>
                    库位条码
                </th>
                <th>
                    退料数量
                </th>
                <th>
                    退料人
                </th>
                <th>
                    退料时间
                </th>
            </tr>
            <tr id="trNewInfo" class="ListTableOddRow">
                <td colspan="8" style="text-align: center;">
                    暂无数据
                </td>
            </tr>
        </table>
    </div>
    <script type="text/javascript">
        $("form").submit(function (e) {
            if (e && e.preventDefault) {
                e.preventDefault();
            }
            else {
                window.event.returnValue = false;
            }
            return false;
        })
        function enterToTab()
        { }
        $(document).ready(function () {
            $("#txtGRN").focus();
            /*扫描物料条码*/
            $("#txtGRN").keydown(function () {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    $("#txtWareCode").focus();
                }
            });
            /*扫描库位条码*/
            $("#txtWareCode").keydown(function () {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    $("#txtQty").val("");
                    GetQuantityByGRN($.trim($("#txtGRN").val()), $.trim($("#txtWareCode").val())); //根据grn，货位条码带出数量
                }
            });
            $("#btnReturn").bind("click", function () {
                Save();
            });
        });
        function GetQuantityByGRN(grn, barCode) {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.GetQuantityByQty(grn, barCode);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                $("#txtGRN").focus();
                $("#txtGRN").select();
                return false;
            }
            else {
                $("#txtQty").val(parseFloat(ajax.value));
                $("#txtQty").focus();
                $("#txtQty").select();
            }
        }
        function Save() {
            var txtQty = $("#txtQty").val();
            $("#msg").html("正在退料，请稍后...");
            $("#msg").css("color", "");

            setTimeout(function () {
                var grn = $.trim($("#txtGRN").val());
                var warCode = $.trim($("#txtWareCode").val());
                var qty = parseFloat(txtQty);
                var deptId = $("#<%=this.hfDepartId.ClientID %>").val();

                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.ReturnMaterial(grn, warCode, qty,deptId);
                if (ajax.error != null) {
                    $("#txtGRN").focus();
                    $("#txtGRN").select();
                    $("#msg").html(ajax.error.Message);
                    $("#msg").css("color", "red");
                    return false;
                }
                $("#txtGRN").val("");
                $("#txtWareCode").val("");
                $("#txtQty").val("");
                $("#txtGRN").focus();
                $("#msg").html("[" + grn + "] 退料成功!");
                $("#msg").css("color", "green");

                /******显示退料列表*******/
                //add  by weixia on 2015/5/8 移除数据
                $("#trNewInfo").remove();
                var list = ajax.value;
                var r = "";
                for (var i = 0; i < list.length; i++) {
                    r += "<tr class='ListTableOddRow'><td></td>";
                    r += "<td>" + list[i].SerialNumber + "</td><td>" + list[i].ItemName + "</td><td>" + list[i].ItemDesc + "</td><td>" + list[i].CBarCode + "</td><td>" + list[i].BalanceQty + "</td><td>" + list[i].ModifyBy + "</td><td>" + list[i].PackTime + "</td>";
                    r += "</tr>";
                }
                if ($("#tblRecHistory tr").length == 1) {
                    $("#tblRecHistory tr:eq(0)").after(r);
                }
                else {
                    $("#tblRecHistory tr:eq(1)").before(r);
                }
                var j = 0;
                $("#tblRecHistory tr").each(function () {
                    $(this).children("td:eq(0)").html(j.toString());
                    j++;
                });
                $("#tblInfo").html("<img src=\"../Content/images/icon/comment.png\" style=\"vertical-align:middle;\" alt=\"\"/>当前共有退料记录：<b>" + ($("#tblRecHistory tr").length - 1).toString() + "</b> 条,本次扫描新增加记录：<b>" + (list.length).toString() + "</b> 条");

            }, 10);
        }
        function clearScreen() {
            if (confirm("是否确定要清空退料列表？")) {
                $("#tblRecHistory tr:not(:first)").each(function () {
                    $(this).remove();
                });
                $("#tblInfo").html("<img src=\"../Content/images/icon/comment.png\" style=\"vertical-align:middle;\" alt=\"\"/>您可以扫描物料条码或库位条码来退料。");
                //add by weixia on 2015/5/7 加上暂无数据
                var leftStr = "<tr id='trNewInfo' class='ListTableOddRow'><td colspan='8' style='text-align:center;'>暂无数据</td></tr>";
                $(leftStr).appendTo($("#tblRecHistory"));
            }
        }
        function openCombineMaterial() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Material/MaterialCombine.aspx?name=Material_MaterialCombine";
            dialog({ title: "物料合并", src: openWinUrl, width: 750, height: 450 });
        }

        function selectDepartmentValue() {
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=13&CallBackFunc=getChooseValueDepartment&Multiple=false&rnd=" + Math.random(), width: 500, height: 300 });
        }

        function getChooseValueDepartment(list) {
            $("#txtDepartment").val(list[0][2]);
            $("#<%=this.hfDepartId.ClientID %>").val(list[0][0]);
        }
    </script>
</asp:Content>
