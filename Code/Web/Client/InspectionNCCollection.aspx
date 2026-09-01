<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/Masters.Master" CodeBehind="InspectionNCCollection.aspx.cs" Inherits="SKT.LeanMES.Web.Client.InspectionNCCollection" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div id="toolbar" class="toolBar">
        <div class="toolbar-btn" onclick="Save()" title="保存">
            <div class="icon-16-save"></div>
            <div class="btn-text">保存</div>
        </div>
        <div class="clear0"></div>
    </div>

    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label3">不良代码
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtNCCode" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox><input type="button" id="btnSelect" class="ButtonBox" value="..." onclick="selectChoosePage(113);" />
                <div style="display: none;">
                    <asp:TextBox ID="txtHide" runat="server" CssClass="TextBox"></asp:TextBox>
                </div>
            </td>
        </tr>
    </table>
    <table id="ncCodeList" cellspacing="0" cellpadding="4" style="border-width: 0px; width: 100%; border-collapse: collapse; margin-top: 5px;" class="ListTable">
        <thead>
            <tr class="ListTableHeader">
                <th scope="col" style="width: 20%;">序号
                </th>
                <th scope="col" style="width: 60%;">不良代码
                </th>
                <th scope="col" style="width: 20%;">操作
                </th>
            </tr>
        </thead>
        <tbody>
        </tbody>
    </table>
    <asp:HiddenField ID="hidNCStationId" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="hidNCCodes" runat="server" ClientIDMode="Static" />
    <script type="text/javascript">
        var arrNCCode = [];//不良代码
        var noData = "<tr id=\"trNewInfo\" class=\"ListTableOddRow\"><td colspan=\"3\" style=\"text-align: center;\"><%=Resources.Messages.HaveNothingData%></td></tr>";

        $(function () {

            //不良代码输入回车事件
            $("#txtNCCode").bind("keyup", function (event) {
                if (event.keyCode == "13") {
                    //回车执行
                    var code = $.trim($(this).val());
                    if (code == "") {
                        alert("请输入或选择不良代码");
                        return;
                    }
                    var stationId = $.trim($("#hidNCStationId").val());
                    if (stationId == "") {
                        alert("未获取到站位信息");
                        return;
                    }
                    if (!isExists(code)) {

                        //检验是否存在于数据库中
                        var entity = {};
                        entity.StationId = stationId
                        entity.NCCode = code;
                        var ajax = SKT.LeanMES.Web.AjaxServices.AjaxNCCode.GetNCCodeInfo(entity);
                        if (ajax.error != null) {
                            alert(ajax.error.Message);
                            $(this).focus();
                            return;
                        }
                        var len = ajax.value.length;
                        if (len <= 0) {
                            alert("不良代码不存在或者不良代码类型未配置使用工位");
                            return;
                        }
                        //添加到列表中
                        arrNCCode.push(code);
                        addToList(code);
                    }
                }
            });

            //删除不良代码
            $(".nc-code-item").live("click", function () {
                var code = $(this).attr("nccode");
                //获取元素索引
                var index = arrNCCode.indexOf(code);
                if (index > -1) {
                    arrNCCode.splice(index, 1);
                    addToList();
                    showNoData();
                }
            });

            //将界面传过来的不良代码显示到界面中
            var ncCodes = $.trim($("#hidNCCodes").val());
            if (ncCodes != "") {
                arrNCCode = ncCodes.split(",");
                addToList();
            }

            showNoData();
        });

        //保存
        function Save() {
            if (arrNCCode.length == 0) {
                alert("请选择或输入不良代码");
                return;
            }
            parent.window.qcPageCallBack(arrNCCode);
        }

        function showNoData() {
            //默认显示无数据
            if ($("#ncCodeList tbody tr").length == 0) {
                $("#ncCodeList tbody").html(noData);
            }
        }

        //不良代码选择界面
        function selectChoosePage() {
            var stationId = $.trim($("#hidNCStationId").val());
            if (stationId == "") {
                alert("未获取到站位信息");
                return;
            }
            var searchCondition = " Status ='Enabled' AND Category = 'Failure' AND StationId = " + stationId + " ";
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=805&PageCondition=" + escape(searchCondition) + "&Multiple=true&rnd=" + Math.random(), width: 500, height: 300 });
        }

        //选择界面回调函数
        function getChooseValue(list) {
            var chooseCount = 0;
            //清除
            if (list[0][0] == "-1") return;
            for (var i = 0 ; i < list.length ; i++) {
                if (!isExists(list[i][1])) {
                    arrNCCode.push(list[i][1]);
                    chooseCount++;
                }
            }
            if (chooseCount > 0) {
                addToList();
            }
        }

        //判断选择的条码是否已经存在列表中
        function isExists(code) {
            var exists = false;
            for (var i = 0; i < arrNCCode.length; i++) {
                if (arrNCCode[i] == code) {
                    exists = true;
                    break;
                }
            }
            return exists;
        }

        //将不良代码添加至列表
        function addToList() {
            var hl = "";
            for (var i = 0; i < arrNCCode.length; i++) {
                hl += "<tr class=\"" + (i % 2 == 0 ? "ListTableOddRow" : "ListTableEvenRow") + "\"><td>" + (i + 1) + "</td><td>" + arrNCCode[i] + "</td><td><a href=\"#\" class=\"nc-code-item\" nccode=\"" + arrNCCode[i] + "\">删除</a></td></tr>";
            }
            $("#ncCodeList tbody").html(hl);
        }

        //查找数组元素索引
        Array.prototype.indexOf = function (val) {
            for (var i = 0; i < this.length; i++) {
                if (this[i] == val)
                    return i;
            }
            return -1;
        };

    </script>
</asp:Content>
