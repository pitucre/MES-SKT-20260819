<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FinishedProductRework.aspx.cs" Inherits="SKT.LeanMES.Web.Rework.FinishedProductRework" MasterPageFile="~/Masters/EditMaster.master"%>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent"  runat="server">
<div class="infoTips">
                带<em>*</em>为必填项</div>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1">
                <%//= Resources.lang.SerialNumber%>原工单<em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtProd" runat="server" CssClass="TextBox" ClientIDMode="Static" Enabled="false"></asp:TextBox>
                <input type="button" class="ButtonBox" value="..." onclick="selList(44)"/>
            </td>
            <td class="Field2" style="border-left:0px;border-right:0px;width:1%;padding:0px 5px;"><input type="checkbox" id="chkProdOrderBatchRework"/></td>
            <td class="Field2" style="border-left:0px;">工单整批返工</td>
        </tr>
        <tr>
            <td class="Label2">
                <%//= Resources.lang.LotCode%>返工工单<em>*</em>
            </td>
            <td class="Field2" colspan="3">
                <asp:TextBox ID="txtReProd" runat="server" CssClass="TextBox" ClientIDMode="Static" Enabled="false"></asp:TextBox>
                <input type="button" class="ButtonBox" value="..." onclick="selList(51)"/>
            </td>
        </tr>

        <tr>
            <td class="Label2"> 
                <%//=Resources.lang.ProduceDate %>产品序列号<em>*</em>
            </td>
            <td class="Field2" colspan="3">
                <asp:TextBox ID="txtSN" class="TextBox" runat="server" ClientIDMode="Static"  Width="160"/>
            </td>
        </tr>
    </table>
    <div class="clear5">
    </div>

    <div id="msg" style="height:30px;line-height:30px; text-align:center"></div>

    <div class="divHeader">成品返工历史</div>
    <table class="ListTable" width="100%" id="reworkHistory">
        <thead class="ListTableHeader">
            <tr>
                <th>序号</th>
                <th>产品序列号</th>
                <th>原工单</th>
                <th>返工工单</th>
                <th>返工时间</th>
            </tr>
        </thead>
    </table>

    <script type="text/javascript">
        var userId = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserId %>";
        var prodId = -1;
        var reProdId = -1;
        var flags = -1;

        $(document).ready(function () {

            $("#chkProdOrderBatchRework").click(function () {

                if ($(this).prop("checked")) {
                    $("#txtSN").prop("disabled", "disabled");

                } else {
                    $("#txtSN").prop("disabled", "");
                }
            })

            $("#txtSN").keydown(function () {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    btRework();
                }
            })
        })

        function btRework() {
            if (prodId <= 0) {
                setMsg("请选择工单！", "red");
                $("#txtProd").css("background-color", "yellow");
                return false;
            }

            if (reProdId <= 0) {
                setMsg("请选择返工工单！", "red");
                $("#txtReProd").css("background-color", "yellow");
                return false;
            }

            $("#txtProd").css("background-color", "");
            $("#txtReProd").css("background-color", "");

            if ($("#chkProdOrderBatchRework").prop("checked")) {
                BatchRework();
            }
            else {
                Rework();
            }
        }

        function Rework() {
            var sn = $("#txtSN").val();

            if (isNull(sn)) {
                $("#txtSN").focus();
                setMsg("请输入要返工的产品序列号!", "red");
                $("#txtSN").css("background-color", "yellow");
                return false;
            }

            $("#txtSN").css("background-color", "");

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxRework.FinishedProductRework(prodId, reProdId, sn, userId, 2);

            if (ajax.error != null) {
                $("#txtSN").focus();
                setMsg(ajax.error.Message + "　　" + sn + "：返工失败！", "red");
                return false;
            }
            else {
                setMsg(sn + "返工成功！", "green");
                init();
            }

            var entity = ajax.value;

            if (entity[0] != "") {
                var html = "<tr class='ListTableOddRow'>";
                html += "<td>" + $("#reworkHistory tr").length + "</td>";
                html += "<td>" + entity[0] + "</td>";
                html += "<td>" + entity[1] + "</td>";
                html += "<td>" + entity[2] + "</td>";
                html += "<td>" + entity[3] + "</td>";
                html += "</tr>";

                $("#reworkHistory").append(html);
            }
        }

        function BatchRework() {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxRework.FinishedProductRework(prodId, reProdId, "", userId, 1);

            if (ajax.error != null) {
                setMsg(ajax.error.Message + "　　工单整批返工失败！", "red");
                return false;
            }
            else {
                setMsg("工单整批返工成功！", "green");
            }
        }

        function selList(flag) {
            flags = flag;

            if (flags == 44) {
                dialog({ title: "<%=Resources.Pages.ShopOrderList %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=" + flags + "&Multiple=false&rnd="
            + Math.random(), width: 500, height: 380
                });
            }
            else
                if (flags == 51) {
                    dialog({ title: "<%=Resources.Pages.ShopOrderList %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=" + flags + "&Multiple=false&rnd="
            + Math.random(), width: 500, height: 380
                    });
                }


        }

        function getChooseValue(list) {

            if (flags == 44) {
                $("#txtProd").val(list[0][1]);
                prodId = list[0][0];
                $("#txtProd").css("background-color", "");

                clear();

            }
            else if (flags == 51) {
                $("#txtReProd").val(list[0][1]);
                reProdId = list[0][0];

                $("#txtReProd").css("background-color", "");

                $("#txtSN").focus();
                $("#txtSN").select();
            }

            flags = -1;
            $("#msg").html("", "")
        }

        function setMsg(str, color) {
            $("#msg").html(str).css("color", color);
        }

        function clear() {
            $("#reworkHistory tr:gt(0)").remove();
            $("#msg").html("", "")
        }

        function init() {
            prodId = -1;
            reProdId = -1;
            $("#txtProd").val('');
            $("#txtReProd").val('');
        }
    </script>

</asp:Content>


