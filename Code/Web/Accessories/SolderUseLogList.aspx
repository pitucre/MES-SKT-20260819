<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SolderUseLogList.aspx.cs"
    Inherits="SKT.LeanMES.Web.Accessories.SolderUseLogList" MasterPageFile="~/Masters/Masters.master" %>

<%@ MasterType VirtualPath="~/Masters/Masters.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2" style="width: 49%">
                <%=Resources.lang.Accessorie_BARCODE%><em>*</em>
            </td>
            <td class="Field2" style="width: 49%">
                <asp:TextBox ID="txtBarCode" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
                &nbsp;&nbsp;
                <%--<input type="button" class="AdaptButton" value="查询" onclick="SelectUseLogInfo()" />--%>
            </td>
        </tr>
    </table>
    <table width="100%" id="tb1" class="EditeContentTable">
        <tr>
            <td class="Label2">
                <%=Resources.lang.Accessorie_PN%>:
            </td>
            <td class="Field2">
                <label id="labPN">
                </label>
            </td>
            <td class="Label2">
                <%=Resources.lang.Accessorie_EXPIREDDATE%>:
            </td>
            <td class="Field2">
                <label id="labExpiredDateTime">
                </label>
            </td>
        </tr>
    </table>
    <table id="tbLogInfoList" class="EditeContentTable" width="100%">
        <tr class="ListTableHeader">
            <th>
                <%= Resources.lang.Accessorie_CREATEDTIME %>
            </th>
            <th>
                <%= Resources.lang.Accessorie_CUR_STATUS%>
            </th>
            <th>
                <%= Resources.lang.AC_Operate%>
            </th>
        </tr>
    </table>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <script type="text/javascript">
        //        $(document).ready(function () {
        //            var obj = $("#searchSubmit").parent();     
        //            obj.hide();
        //        });

        function enterToTab() { }

        //        function BarCodeKeydown(e) {
        //            var curKey = 0, e = e || window.event;
        //            curKey = e.keyCode || e.which || e.charCode;

        //            if (curKey == 13) {
        //                SelectUseLogInfo();
        //            }
        //            if (curKey == 46) {
        //                $("#txtBarCode").val("");
        //            }
        //            
        //        }

        function SelectUseLogInfo() {
            var errStr = "";
            var txtBarCode = $("#txtBarCode").val();
            if (isNull(txtBarCode)) {
                errStr += "<%=Resources.Messages.WithAsteriskIsRequiredAlert %>";
            }
            if (errStr != "") {
                alert(errStr.toString());
                return false;
            }

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxServiceSolderLog.GetUseLogInfoByBarCode(txtBarCode);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            } else {
                DeleteShowTable();
                MakeTable(ajax.value);
            }
        }

        //报废
        function SetInvilitedInfo() {
            var errStr = "";
            var txtBarCode = $("#txtBarCode").val();
            if (isNull(txtBarCode)) {
                errStr += "<%=Resources.Messages.WithAsteriskIsRequiredAlert %>";
            }
            if (errStr != "") {
                alert(errStr.toString());
                return false;
            }

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxServiceSolderLog.SetInvalidatedInfo(txtBarCode);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            SelectUseLogInfo();
            //UpdateList() 
            alert("<%=Resources.Messages.SaveInSuccess %>");
        }

        //生成表格列表
        function MakeTable(objArr) {
            var newTb = document.getElementById("tbLogInfoList");
            var row, cell;
            var entityArr = objArr;
            var entity = {};
            if (entityArr.length == 0) {
                alert("没有记录！")
                return false;
            }

            for (var i = 0; i < entityArr.length; i++) {
                entity = entityArr[i];

                row = newTb.insertRow(newTb.rows.length);
                row.className = "ListTableOddRow";

                cell = row.insertCell(0);
                cell.innerHTML = entity.CreateTime;

                cell = row.insertCell(1);
                cell.innerHTML = entity.ACTION;

                cell = row.insertCell(2);
                cell.innerHTML = entity.LoginID;

                $("#labPN").html(entity.PN);
                $("#labExpiredDateTime").html(entity.EXPIREDDATE);
            }
            var mTable = document.getElementById("tbLogInfoList");
            var mTr;
            if (mTable.rows.length > 0) {
                for (var j = 0; j < mTable.rows.length; j++) {
                    mTr = mTable.rows[j];
                    mTr.onclick = function () {
                        $(this).css('background-color', '#0277bd');
                        $(this).siblings().css('background-color', '#fff');
                    }
                }
            }
        }

        /* 清空指定table中数据 */
        function DeleteShowTable() {
            if ($("#tbLogInfoList tr").length > 1) {
                $("#tbLogInfoList tr:not(:first)").remove();
            }
        }

        function UpdateList() {
            document.forms[0].submit();
        }

        function isNull(str) {
            if (str == "") return true;
            var regu = "^[ ]+$";
            var re = new RegExp(regu);
            return re.test(str);
        }

        function isNumber(s) {
            var regu = "^[0-9]+$";
            var re = new RegExp(regu);
            if (s.search(re) != -1) {
                return true;
            } else {
                return false;
            }
        }

        $(document).ready(function () {
            $("form").submit(function (e) {
                SelectUseLogInfo();
                e.preventDefault();
            });
        })

    </script>
    <style type="text/css">
        #tbLogInfoList td, th
        {
            height: 25px;
            border: solid 1px #ccc;
        }
        .ListTableOddRow
        {
            cursor: pointer;
            background: #fff;
            font-family: Verdana, 微软雅黑,黑体, 宋体;
            font-size: 14px;
            height: 26px;
        }
        .ListTableHeader
        {
            font-size: 15px;
            font-weight: bold;
            text-align: left;
            height: 21px;
            line-height: 18px;
            color: #183152;
            margin-left: 3px;
            border: 0px;
            padding: 1px;
            font-family: Verdana, 微软雅黑,黑体, 宋体;
        }
    </style>
</asp:Content>
