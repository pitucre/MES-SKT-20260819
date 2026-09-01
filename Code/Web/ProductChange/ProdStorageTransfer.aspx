<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="ProdStorageTransfer.aspx.cs" Inherits="SKT.LeanMES.Web.ProductChange.ProdStorageTransfer" %>
<%@ MasterType VirtualPath="~/Masters/EditHeadMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
 <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %>请扫描对应的移库方式、扫描条码、库位条码</div>
<table width="100%" class="EditeContentTable">
        <tr class="Label">
            <td align="left" colspan="2">
                
            </td>
        </tr>
        <tr>
            <td class="Label1">
                移库方式<em>*</em>
            </td>
            <td class="Field1">
                <div style="width: 700px; marign: 0 auto; font-size: 13px;">
                    <input type="radio" name="rdoTransType" value="1" checked="true" />按卡板移库&nbsp;&nbsp;&nbsp;<input
                        type="radio" name="rdoTransType" value="2" />按卡通箱移库&nbsp;&nbsp;&nbsp;<input type="radio"
                            name="rdoTransType" value="3" />按产品移库
                </div>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                扫描条码<em>*</em>
            </td>
            <td class="Field1">
                <input type="text" id="txtGRN" class="TextBox" style="width: 250px; height: 25px;
                    font-size: 16px; font-weight: bold;" />
            </td>
        </tr>
        <tr>
            <td class="Label1">
                库位条码<em>*</em>
            </td>
            <td class="Field1">
                <input type="text" id="txtCode" class="TextBox" style="width: 250px; height: 25px;
                    font-size: 16px; font-weight: bold;" />
            </td>
        </tr>
    </table>
    <div style="text-align: center;" class="Tips" id="msg">
        <span id="showMessage"></span>
    </div>
    <table id="tblExpand" cellspacing="0" cellpadding="4" style="border-width: 0px; width: 100%;
        border-collapse: collapse; margin-top: 5px;" class="ListTable">
        <tr class="ListTableHeader">
            <th scope="col" align="center">
                序号
            </th>
            <th scope="col" align="center">
                卡板号
            </th>
            <th scope="col" align="center">
                卡通箱号
            </th>
            <th scope="col" align="center">
                产品条码
            </th>
            <th scope="col" align="center">
                当前库位
            </th>
            <th scope="col" align="center">
                产品名称
            </th>
        </tr>
        <tr>
        <td colspan="6" align="center" class="ListTableOddRow">暂无数据</td>
        </tr>
    </table>
    <script type="text/javascript">
        var flag = 0, isCheck = 0;
        var userName = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';

        $(function () {
            $("#txtGRN").focus();
            //扫描GRN自动验证是否存在
            $("#txtGRN").keydown(function (e) {
                var curKey = 0, e = e || window.event;
       
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    if ($("#txtGRN").val() != "") {
                        $("#txtCode").focus();
                        GetSotrageInfo();
                    }
                }
            });
            //扫描库位条码
            //            $("#txtCode").keydown(function () {
            //                var curKey = 0, e = e || window.event;
            //                curKey = e.keyCode || e.which || e.charCode;
            //                if (curKey == 13) {                
            //                    Save();
            //                }
            //            });
        });
        // 保存事件
        function Save() {
            var txtGRN = $("#txtGRN").val();
            if (txtGRN == "") {
                setMessage("扫描条码不能为空,请扫描条码！", "red");
                setInputValue("txtGRN");
                return false;
            }
            var txtCode = $("#txtCode").val();
            if (txtCode == "") {
                setMessage("库位条码不能为空,请重新扫描！", "red");
                setInputValue("txtCode");
                return false;
            }
            if (isCheck == 0) {
                setMessage("未找到扫描条码相关的库位信息！", "red");
                return;
            }
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxStorage.ProdStorageTransfer(txtGRN, txtCode, userName,$('input[name="rdoTransType"]:checked ').val())
            if (ajax.error != null) {
                setMessage(ajax.error.Message, "red");
                return false;
            }
            $(".ListTableOddRow").remove();
            setMessage("库位转移成功！", "green")
            $("input[type='text']").val("");
            $("#txtGRN").select();

        }

        function GetSotrageInfo() {
            var txtGRN = $("#txtGRN").val();
            if (txtGRN == "") {
                setMessage("扫描条码不能为空,请扫描条码！", "red");
                setInputValue("txtGRN");
                return false;
            }
            var scanType = $('input[name="rdoTransType"]:checked ').val();
            var list = SKT.LeanMES.Web.AjaxServices.AjaxStorage.GetStorageInfo(txtGRN, scanType)
            if (list.error != null) {
                setMessage(list.error.Message, "red");
                $("#txtGRN").focus();
                isCheck = 0;
                return false;
            }
            setMessage("", "red");

            var row, cell;
            var entityAry = list.value;
            var entity = {};
            var flage = "";
            var setTable = document.getElementById("tblExpand");
            if (entityAry.length > 0) {
                $(".ListTableOddRow").remove();

                /***动态创建表***/
                for (var i = 0; i < entityAry.length; i++) {
                    entity = entityAry[i];
                    row = setTable.insertRow(setTable.rows.length);
                    row.className = "ListTableOddRow";

                    cell = row.insertCell(0);
                    cell.align = "center";
                    cell.innerHTML = entity.Id;
                    cell.className = "Field";

                    cell = row.insertCell(1);
                    cell.align = "center";
                    cell.innerHTML = entity.PalletSN;
                    cell.className = "Field";

                    cell = row.insertCell(2);
                    cell.align = "center";
                    cell.innerHTML = entity.PackSN;
                    cell.className = "Field";

                    cell = row.insertCell(3);
                    cell.align = "center";
                    cell.innerHTML = entity.ProductSN;
                    cell.className = "Field";

                    cell = row.insertCell(4);
                    cell.align = "center";
                    cell.innerHTML = entity.LocationCode;
                    cell.className = "Field";

                    cell = row.insertCell(5);
                    cell.align = "center";
                    cell.innerHTML = entity.ItemName;
                    cell.className = "Field";
                }
                isCheck = 1;
            }
            else {
                $(".ListTableOddRow").remove();
                isCheck = 0;
            }
        }

        /*显示提示信息*/
        function setMessage(msg, color) {
            $("#showMessage").html(msg);
            $("#showMessage").css("color", color);
        }
        /*清空指定信息，并聚焦*/
        function setInputValue(inputName) {
            var txtInputName = $("#" + inputName);
            txtInputName.val("");
            txtInputName.focus();
        }
    </script>
</asp:Content>
