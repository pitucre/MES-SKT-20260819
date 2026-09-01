<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GenerateBoxSN.aspx.cs" Inherits="SKT.LeanMES.Web.Product.GenerateBoxSN" MasterPageFile="~/Masters/ViewMaster.master"%>

<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="server">
    <div id="noprtplg" class="Tips">
    </div>
    <div style="text-align: center; margin-top: auto; color: Green;">
        <table class="ListTable" cellspacing="0" cellpadding="4" style="border-width: 0px;
            width: 100%; border-collapse: collapse;">
            <tr class="ListTableHeader">
                <th scope="col" colspan="2" align="left">
                    工单信息
                </th>
            </tr>
            <tr class="ListTableOddRow">
                <td align="right" class="Label1">
                    <%=Resources.lang.OrderNumber %>
                </td>
                <td align="left">
                    <asp:Label ID="lbOrderNO" runat="server" Text="Label" Font-Bold="true"></asp:Label>
                </td>
            </tr>
            <tr class="ListTableOddRow">
                <td align="right" class="Label1">
                    <%=Resources.lang.ItemsName %>
                </td>
                <td align="left">
                    <asp:Label ID="lbItemName" runat="server" Text="Label"></asp:Label>
                </td>
            </tr>
            <tr class="ListTableOddRow">
                <td align="right" class="Label1">
                    <%//=Resources.lang.CanbeReleaseQuantity %>可生成数量
                </td>
                <td align="left">
                    <asp:Label ID="lbCanReleaseQty" runat="server" Text="Label"></asp:Label>
                </td>
            </tr>
            <tr class="ListTableOddRow">
                <td align="right" class="Label1">
                    <%//=Resources.lang.ReleaseQuantity %>生成数量
                </td>
                <td align="left">
                    <input id="txtReleaseQty" class="NumericBox50" IsRequired='1' IsNumber='1'/><em>*</em>
                </td>
            </tr>
        </table>
    </div>
    <div class="clear5">
    </div>
    <div style="text-align: center">
    <div id="lblMessage" class="Tips">
    </div>
        <input type="button" id="btnRelease" style="width: 82px; cursor: pointer;" value="<%= Resources.Buttons.GenerateBoxNO %>" />
        <input type="button" id="btnPrint" style="width: 82px; cursor: pointer; display:none;" value="<%= Resources.Buttons.COM_Print %>" /></div>
    <div class="clear5"></div>
    <div id="lblPt" class="Tips"  style="text-align: center">
    </div>
    <div id="info">
    </div>
    <div id="printerHolder">
    </div>
    <asp:HiddenField ID="hdnItemSNTemplate" runat="server" Value=""/>
    <script type="text/javascript" src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.utility.printer.js"></script>
    <script type="text/javascript">

        var lableArr = null;
        var canReleaseQty = '<%=Request.QueryString["canReleaseQty"] %>';
        var orderID = '<%=Request.QueryString["OrderID"] %>';

        $(function () {
            Inity();
            InityPrint();

        });

        function Inity() {
            $("#btnPrint").prop("disabled", true);
            /*生成箱号*/
            $("#btnRelease").click(function () {
                /*check Release Qty is ok*/
                if (isNull($("#txtReleaseQty").val())) { alert("请输入要生成的包装箱数量！"); return false; }
                if (!isNumber($("#txtReleaseQty").val())) { alert("生成数量只能为整型数字！"); return false; }
                if (parseInt($("#txtReleaseQty").val()) <= 0) { alert("生成数量必须大于0！"); return false; }
                if (canReleaseQty < parseInt($("#txtReleaseQty").val())) { alert("生成数量不能大于可生成数量！"); return false; }

                if (!confirm("是否确定要生成" + $("#txtReleaseQty").val() + "个包装箱号？")) {
                    return false;
                }
                $(this).prop("disabled", true);
                $("#lblMessage").html("正在生成包装箱，请耐心等待......，不要关闭窗口！");

                setTimeout(function () {
                    /*check twice*/
                        /*begin release*/

                        var itemids = '<%=Request.QueryString["ItemID"] %>';
                        var routerids = '<%=Request.QueryString["RouteID"] %>';
                        var itemvers = '<%=Request.QueryString["ItemVer"] %>';
                        var itemStr = '<%=Request.QueryString["ItemName2"] %>';
                        var BOMID = '<%=Request.QueryString["BOMID"] %>';
                        var ReleaseQty = $("#txtReleaseQty").val();

                        var ajax = SKT.LeanMES.Web.AjaxServices.AjaxShopOrder.GenerateBoxNO(ReleaseQty, orderID, itemids);
                        if (ajax.error != null) {
                            $("#lblMessage").html(ajax.error.Message);
                            $("#btnRelease").removeAttr("disabled");
                            return false;
                        }

                        lableArr = ajax.value;
                        /*begin print sn*/
                        $("#lblPt").html("<span style='color:green; font-weight:bold;'>包装箱生成成功！</span><br/>正在排队打印，" + lableArr.length + "个条码等待打印");
                        setTimeout(function () {
                            prtLabel();
                        }, 100);

                    
                    $("#lblMessage").html("");
                }, 100);
            });
        }

        /*打印机参数定义*/
        NoPrinterPlugin = "<%=Resources.Messages.NoPrinterPlugin %>";
        var labelPrintingPlugin;

        function InityPrint() {
            pendPrintPluginDom($("#printerHolder"));
            checkPrintPlugin($("#noprtplg"));
            var $target = $("input");
            $target.bind('keydown', function (e) {
                var key = e.which;
                if (key == 13) {
                    e.preventDefault();
                    var nxtIdx = $target.index(this) + 1;
                    if ($target.eq(nxtIdx - 1).attr("id") == "txtDateCode") {
                        Save();
                    }
                    else if ($target.eq(nxtIdx - 1).attr("type") == "button") {
                        $target.eq(nxtIdx - 1).click();
                        $target.eq(nxtIdx).focus();
                    }
                    else {
                        $target.eq(nxtIdx).focus();
                    }
                }
            });
        }


        /*
        var printValue = "^XA"
        + "^PRA"
        + "^LH0,0^FS"
        + "^LL152"
        + "^MD0"
        + "^MNY"
        + "^LH0,0^FS"
        + "^BY2,3.0^FO50,46^BCN,100,N,N,N"
        + "^FR"
        + "^FD%Value%^FS"
        + "^FT110,190"
        + "^A0N,44,46^FD%Value%"
        + "^FS"
        + "^PQ1,0,0,N"
        + "^XZ";
        */
        var labelContent = $("#<%=this.hdnItemSNTemplate.ClientID %>").val();
        var lableIndex = 0;
        var ibs
        function prtLabel() {
            if ($.trim(labelContent) == "") {
                alert("标签模板加载失败，您将无法打印出包装箱条码\n您可以在确认标签模板存在后，再去包装箱列表页进行重打。");
                return false;
            }
            labelPrintingPlugin = document.getElementById("labelPrintingPlugin");

            for (var i = 0; i < lableArr.length; i++) {
                labelContent = $("#<%=this.hdnItemSNTemplate.ClientID %>").val();
                labelContent = labelContent.replace("%SN1%", lableArr[i]).replace("%SN1_1%", lableArr[i]);

                labelContent = labelContent.replace("%SN1BEGIN%", "");
                labelContent = labelContent.replace("%SN1END%", "");

                doPrintGrn(labelPrintingPlugin, labelContent);
            }
            ibs = 3;
            setInterval(function () { $("#lblPt").html("打印条码完成," + ibs + "秒后关闭窗口！"); ibs-- }, 1000)
            setTimeout(function () {
                parent.form1.submit();
            }, 3000);
        }

        /*是否为空*/
        function isNull(str) {
            if (str == "") return true;
            var regu = "^[ ]+$";
            var re = new RegExp(regu);
            return re.test(str);
        }

        /*是否是数字*/
        function isNumber(s) {
            var regu = "^[0-9]+$";
            var re = new RegExp(regu);
            if (s.search(re) != -1) {
                return true;
            } else {
                return false;
            }
        }

        function showResult(msg) {
            alert(msg);
        }

    </script>
</asp:Content>
