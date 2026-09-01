<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="PrePalletRegister.aspx.cs" Inherits="SKT.LeanMES.Web.Product.PrePalletRegister" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <table width="100%" class="EditeContentTable">
        <tr>
            <%-- <td class="Label2">工单号<em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtOrderNo" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
                <input type="button" class="ButtonBox" onclick="openChoosePage()" value="..." />
            </td>--%>
            <td class="Label1">产品编号<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtItemCode" runat="server" CssClass="TextBox" IsRequired='1' ReadOnly="true" Enabled="false"
                    ClientIDMode="Static"></asp:TextBox><input type="button" id="btnSelectItem" class="ButtonBox" value="..." title="Select" onclick="selectItemCode();" />
                <asp:HiddenField ID="hdnItemId" runat="server" Value="-1" ClientIDMode="Static" />
            </td>
        </tr>
        <tr>
            <td class="Label1">栈板条码<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtPalletNo" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
                <input type="button" id="btnAddPalletSN" value="增加" onclick="addPalletSN()" style=" margin-left:10px; padding:0px 7px;"/>
            </td>
        </tr>
    </table>

    <table class="ListTable" width="100%" id="palletSNList">
        <thead>
            <tr class="ListTableHeader" style="text-align: center">
                <th>序号</th>
                <th>栈板条码</th>
                <th>操作</th>
            </tr>
        </thead>
        <tbody>
            <tr id="trLast" class="ListTableOddRow">
                <td colspan="3" style="text-align: center;"><span>暂无数据</span>
                </td>
            </tr>
        </tbody>
    </table>

    <script type="text/javascript">
        var arrPallet = []; //栈板号

        $(function () {
            //栈板号回车事件
            $("#txtPalletNo").keydown(function (event) {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    addPalletSN();
                }
                if (curKey == 46) {
                    this.value = "";
                }
            });
        });

        //增加栈板号
        function addPalletSN() {
            var objPalletSN = document.getElementById("txtPalletNo");
            var palletNo = $.trim(objPalletSN.value);
            if (!palletNo) {
                alert("请输入栈板条码");
                objPalletSN.focus();
                return;
            }
            var idx = $.inArray(palletNo, arrPallet);
            if (idx != -1) {
                alert("栈板号已存在于列表中");
                objPalletSN.value = "";
                objPalletSN.focus();
                return;
            }
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPreSNPrint.ValidatePalletExists(palletNo);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                objPalletSN.select();
                objPalletSN.focus();
                return;
            }
            arrPallet.push(palletNo);
            ReLayout();
            objPalletSN.value = "";
        }

        //选择物料
        function selectItemCode() {
            flag = 2;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=1&Multiple=false&rnd=" + Math.random(), width: 680, height: 300 });
        }

        function getChooseValue(list) {
            if (flag == 2) {
                $("#txtItemCode").val(list[0][2]);
                $("#hdnItemId").val(list[0][0]);
                itemId = list[0][0];
            }
        }

        //栈板注册
        function Save() {
            var itemId = $("#hdnItemId").val();
            if (itemId == -1) {
                alert("请选择产品编号");
                return;
            }
            if (arrPallet.length <= 0) {
                alert("请输入栈板条码");
                $("#txtPalletNo").focus();
                return;
            }
            var palletSNs = arrPallet.join(",");
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPreSNPrint.PalletRegister(palletSNs, itemId);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return;
            }
            alert("栈板注册成功！");
            window.parent.Refresh();
        }

        //删除
        function Delete(obj, palletSN) {
            $(obj).parent().parent().remove();
            for (var i = 0; i < arrPallet.length; i++) {
                if (arrPallet[i] == palletSN) {
                    arrPallet.splice(i, 1);
                    break;
                }
            }
            ReLayout();
        }

        //重新布局
        function ReLayout() {
            var hl = "";
            var css = "";
            for (var i = 0; i < arrPallet.length; i++) {
                css = i % 2 == 0 ? "ListTableOddRow" : "ListTableEvenRow";
                hl += "<tr class='" + css + "'><td>" + (i + 1) + "</td><td>" + arrPallet[i] + "</td><td><img title=\"删除\" src=\"../Content/images/delete.gif\" onclick=Delete(this,'" + arrPallet[i] + "')></img></td></tr>";
            }
            $("#palletSNList tbody").html(hl);
        }

    </script>
</asp:Content>
