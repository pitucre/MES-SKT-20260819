<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ViewMaster.master" AutoEventWireup="true"
    CodeBehind="SNReleaseByStation.aspx.cs" Inherits="SKT.LeanMES.Web.Product.SNReleaseByStation" %>

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
                <td class="Label1">
                    <%=Resources.lang.StationName %>
                </td>
                <td class="Field1">
                    <asp:TextBox ID="txtStation" runat="server" Enabled="false" CssClass="TextBox" Text="请选择工位" ></asp:TextBox>
                    <input type="button" value="..." onclick="selStation(8)" class="ButtonBox" />
                    <input type="hidden" id="hdnStationId" value="-1" />
                </td>
            </tr>
             <tr class="ListTableOddRow">
                <td align="right" class="Label1">
                    已释放数
                </td>
                <td align="left">
                    <asp:Label ID="lblReleasedQty" runat="server" Text=""></asp:Label>
                </td>
            </tr>
            <tr class="ListTableOddRow">
                <td align="right" class="Label1">
                    <%=Resources.lang.CanbeReleaseQuantity %>
                </td>
                <td align="left">
                    <asp:Label ID="lbCanReleaseQty" runat="server" Text=""></asp:Label>
                </td>
            </tr>

            <tr class="ListTableOddRow">
                <td align="right" class="Label1">
                    <%=Resources.lang.ReleaseQuantity %>
                </td>
                <td align="left">
                    <input id="txtReleaseQty" class="NumericBox50" /><em>*</em>
                </td>
            </tr>
        </table>
    </div>
    <div class="clear5">
    </div>
    <div style="text-align: center">
    <div id="lblMessage" class="Tips">
    </div>
        <input type="button" id="btnRelease" style="width: 82px; cursor: pointer;" value="<%= Resources.Buttons.GenerateReplaceSN %>" />
        <input type="button" id="btnPrint" style="width: 82px; cursor: pointer; display:none;" value="<%= Resources.Buttons.COM_Print %>" /></div>
    <div class="clear5"></div>
    <div id="lblPt" class="Tips"  style="text-align: center">
    </div>
    <div id="info">
    </div>
    <div id="printerHolder">
    </div>
    <asp:HiddenField ID="hdnItemSNTemplate" runat="server" Value=""/>
    <asp:HiddenField ID="hdnRepeatSNconfig" runat="server" Value=""/>
    
    <script type="text/javascript" src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.utility.printer.js"></script>
    <script type="text/javascript">

        var lableArr = null;
        var canReleaseQty = '<%=Request.QueryString["canReleaseQty"] %>';
        var orderID = '<%=Request.QueryString["OrderID"] %>';
        var stationId = -1;

        var labelContent = "";
        var repeatSNconfig = "";
        var RepeatSNconfig;

        $(function () {
            Inity();
            InityPrint();

            labelContent = $("#<%=this.hdnItemSNTemplate.ClientID %>").val();
            repeatSNconfig = $("#<%=this.hdnRepeatSNconfig.ClientID %>").val();

            if (!$.trim(repeatSNconfig) == "") {
                RepeatSNconfig = eval("(" + repeatSNconfig + ")");
            }
        });

        function Inity() {
            $("#btnPrint").attr("disabled", true);
            /*释放工单*/
            $("#btnRelease").click(function () {

                if (stationId <= 0) {
                    alert("请先选择工位！"); return false;
                }

                /*check Release Qty is ok*/
                if (isNull($("#txtReleaseQty").val())) { alert("请输入工单要释放的数量！"); return false; }
                if (!isNumber($("#txtReleaseQty").val())) { alert("释放数量只能为整型数字！"); return false; }
                if (parseInt($("#txtReleaseQty").val()) <= 0) { alert("释放数量必须大于0！"); return false; }
                if (canReleaseQty < parseInt($("#txtReleaseQty").val())) { alert("本次释放数量不能大于已释放的产品数量！"); return false; }

                if (!confirm("是否确定当前工单要释放所输入的数量？")) {
                    return false;
                }
                $(this).attr("disabled", true);
                $("#lblMessage").html("正在释放工单，请不要关闭窗口耐心等稍...");

                setTimeout(function () {
                    /*check twice*/
                    if (checkIsReady(orderID)) {
                        /*begin release*/

                        var itemids = '<%=Request.QueryString["ItemID"] %>';
                        var routerids = '<%=Request.QueryString["RouteID"] %>';
                        var itemvers = '<%=Request.QueryString["ItemVer"] %>';
                        var itemStr = '<%=Request.QueryString["ItemName2"] %>';
                        var BOMID = '<%=Request.QueryString["BOMID"] %>';
                        var ReleaseQty = $("#txtReleaseQty").val();


                        var ajax = SKT.LeanMES.Web.AjaxServices.AjaxShopOrder.ReleaseReplaceSN(ReleaseQty, orderID, itemids, stationId);
                        if (ajax.error != null) {
                            $("#lblMessage").html(ajax.error.Message);
                            $("#btnRelease").removeAttr("disabled");
                            return false;
                        }

                        lableArr = ajax.value;
                        /*begin print sn*/
                        $("#lblPt").html("<span style='color:green; font-weight:bold;'>释放条码成功！</span><br/>正在排队打印，" + lableArr.length + "个条码等待打印");
                        setTimeout(function () {
                            prtLabel();
                        }, 100);


                        canReleaseQty = canReleaseQty - ReleaseQty;
                        $("#<%=this.lbCanReleaseQty.ClientID %>").text(canReleaseQty.toString());
                        $("#<%=this.lblReleasedQty.ClientID %>").text(parseInt($("#<%=this.lblReleasedQty.ClientID %>").text()) + parseInt(ReleaseQty));
                    }
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

        function checkIsReady(soid) {
            var isOk = true;
            var cmd = "rZXWNP4ukgVO3uHFZBSOJlURS/N55aqxVESsGjM1VVOmrB+7jajPcQ==";
            var params = [], param = {};
            param.ParamName = "v/FhV7W2V48XbAg4jDlkkyDPkKyMwVcP";
            param.ParamType = "1o/d3CICk7c=";
            param.ParamValue = soid;
            param.ParamSize = 0;
            params.push(param);

            var result = SKT.LeanMES.Web.Controls.PageSQLService.ExecuteNonQuery(cmd, params);
            if (result.error != null) {
                alert(result.error.Message);
                isOk = false;
            }
            return isOk;
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

        var lableIndex = 0;
        var ibs
        function prtLabel() {
            if ($.trim(labelContent) == "") {
                alert("标签模板加载失败，您将无法打印出产品条码\n您可以在确认标签模板存在后，再从【工单条码】列表中进行补打。");
                return false;
            }

            if ($.trim(repeatSNconfig) == "") {
                alert("标签模板配置信息加载失败，您将无法打印出产品条码\n您可以在确认签模板配置信息文件存在后，再从【工单条码】列表中进行补打。");
                return false;
            }

            labelPrintingPlugin = document.getElementById("labelPrintingPlugin");

            //循环 3排 每排10个打印
            repeatItemSNprint();

            /*原普通打印模板
            for (var i = 0; i < lableArr.length; i++) {
                
            labelContent = $("#<%=this.hdnItemSNTemplate.ClientID %>").val();

            labelContent = labelContent.replace("%SN1%", lableArr[i]).replace("%SN1_1%", lableArr[i]);

            labelContent = labelContent.replace("%SN1BEGIN%", "");
            labelContent = labelContent.replace("%SN1END%", "");

            doPrintGrn(labelPrintingPlugin, labelContent);
            }*/
            ibs = 3;
            setInterval(function () { $("#lblPt").html("打印条码完成,"+ibs+"秒后关闭窗口！");ibs-- }, 1000)
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


        //循环 3排 每排10个
        //add by zhibin.chen  2015-10-26
        //alter by zhibin.chen  2015-11-25 修改成 6mm   每排8个的打印方式
        function repeatItemSNprint() {
            //得出打印的配置参数
            var left = parseInt(RepeatSNconfig["Left"].toString());
            var top = parseInt(RepeatSNconfig["Top"].toString());
            var codeWidth = parseInt(RepeatSNconfig["Width"].toString());
            var codeHeight = parseInt(RepeatSNconfig["Height"].toString());
            var levelGap = parseInt(RepeatSNconfig["LevelGap"].toString());
            var verticalGap = parseInt(RepeatSNconfig["VerticalGap"].toString());

            //得出指令被发送的次数（也就是条码总数 除以 单次的规格数。如果有余数，那么发送次数加1。）
            var snCount = lableArr.length;  //条码总数
            var onceSNcount = 30; //单次指令发送条码数
            var printCount = (snCount % onceSNcount == 0) ? snCount / onceSNcount : parseInt(snCount / onceSNcount) + 1 //打印指令发送次数
            var insideRepeatCount = onceSNcount;    //组织模板内容的 内部for循环的循环次数
            var snIndex = 0; //内循环中，SN所处的索引序号。

            labelContent = $("#<%=this.hdnItemSNTemplate.ClientID %>").val();

            var labelHeader = labelContent.substring(0, labelContent.indexOf("%SN1BEGIN%")); //指令的头部
            var labelBody = labelContent.substring(labelContent.indexOf("%SN1BEGIN%") + 10, labelContent.indexOf("%SN1END%")); //指令的主体  也就是条码的变量和配置指令
            var labelStern = labelContent.substring(labelContent.indexOf("%SN1END%") + 8, labelContent.length) //指令的尾部
            var labelRepeatContent = ""; //每个条码指令的累加

            for (var i = 0; i < printCount; i++) {
                if (i == printCount - 1) {
                    insideRepeatCount = snCount - i * onceSNcount;
                }

                labelRepeatContent = ""; //发送一次打印指令之后，变量值清空。

                for (var j = 0; j < insideRepeatCount; j++) {
                    snIndex = i * onceSNcount + j;

                    labelContent = labelBody;

                    labelContent = labelContent.replace("%SN1%", lableArr[snIndex]);
                    labelContent = labelContent.replace("%SN1Left%", (left + snIndex % 8 * (codeWidth + levelGap)).toString());
                    labelContent = labelContent.replace("%SN1Top%", (top + parseInt(j / 8 + 1) * (codeHeight + verticalGap)).toString());
                    //labelContent = labelContent.replace("%SN1Width%", codeWidth);
                    //labelContent = labelContent.replace("%SN1Height%", codeHeight);
                    labelContent = labelContent.replace("%SN1BEGIN%", "");
                    labelContent = labelContent.replace("%SN1END%", "");

                    labelRepeatContent = labelRepeatContent + labelContent; //条码指令累加
                }

                labelRepeatContent = labelHeader + labelRepeatContent + labelStern; //指令加上公共部分

                doPrintGrn(labelPrintingPlugin, labelRepeatContent);
            }
        }

        var flag = -1;

        function selStation(tag) {
            flag = tag;
            var PageCondition = 'LEN(ShortLetter) > 0';
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=" + flag + "&PageCondition=" + PageCondition + "&Multiple=false&rnd=" + Math.random(), width: 600, height: 270 });
        }

        function getChooseValue(list) {
            if (flag == 8) {
                $("#<%=this.txtStation.ClientID %>").val(list[0][1])
                stationId = list[0][0];

                setTimeout("getCanReleaseQty()", 10)
            }
        }

        //根据工单，工位 获取此工单，此工位还可释放的置换条码数。
        function getCanReleaseQty() {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxShopOrder.GetCanReleaseQty(orderID, stationId);
            if (ajax.error != null) {
                $("#lblMessage").html(ajax.error.Message);
                canReleaseQty = 0;
                $("#<%=this.lbCanReleaseQty.ClientID %>").text('');
                $("#<%=this.lblReleasedQty.ClientID %>").text('');
                return false;
            }

            canReleaseQty = ajax.value[1];
            var lblReleasedQty = ajax.value[0];
            $("#<%=this.lbCanReleaseQty.ClientID %>").text(canReleaseQty.toString());
            $("#<%=this.lblReleasedQty.ClientID %>").text(lblReleasedQty.toString());
            $("#btnRelease").removeAttr("disabled");
            $("#txtReleaseQty").val('').focus();
        }
    </script>
</asp:Content>
