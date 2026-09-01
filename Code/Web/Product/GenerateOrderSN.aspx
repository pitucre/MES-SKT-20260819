<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="GenerateOrderSN.aspx.cs" Inherits="SKT.LeanMES.Web.Product.GenerateOrderSN" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
<script type="text/javascript" src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.utility.printer.js"></script>
    <asp:HiddenField ID="hfOrderID" runat="server" />
    <asp:HiddenField ID="hfDate" runat="server" />
    <div id="noprtplg" class="Tips">
    </div>
     <div id="lblMessage" class="Tips">
    </div>
    <div id="lblPt" class="Tips">
    </div>
    <div id="info">
    </div>
    <div id="printerHolder">
    </div>
    
    <div id="divLable">
    </div>
     <script type="text/javascript" src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.utility.printer.js"></script>
    <script>
        var lableArr = null; 
        NoPrinterPlugin = "<%=Resources.Messages.NoPrinterPlugin %>";
        var FLAG = -1//'<%//=SKT.LeanMES.Web.AccountController.GetCurrentUser().IsSystemUser %>';
        var IS_VENDOR = (FLAG == -1) ? false : true;
        var VENDOR_CODE = "";
        var labelPrintingPlugin;
        $(function () {
            pendPrintPluginDom($("#printerHolder"));
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
            checkPrintPlugin($("#noprtplg"));

            if (IS_VENDOR) {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.GetVendorCode();
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }
                VENDOR_CODE = ajax.value;
                var vdc = "";
                if (VENDOR_CODE.indexOf("|1") >= 0) {
                    vdc = VENDOR_CODE.replace("|1", "");
                }
                else {
                    vdc = VENDOR_CODE;
                }
            }

            inity();
        });
        function inity() {
            var orderID = $("#<%=hfOrderID.ClientID.ToString() %>").val();
            var date = $("#<%=hfDate.ClientID.ToString() %>").val();
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxShopOrder.GetSNByOrderID(orderID, date);
            if (ajax.error == null) {
                var labelStr = "";
                lableArr = ajax.value;
                for (var i = 0; i < lableArr.length; i++) {
                    labelStr += "<div>" + lableArr[i] + "<div>";
                }
                $("#divLable").html(labelStr);
            }
        }

        var lableIndex = 0;
        function Save() {
            lableIndex=0;
            prtLabel();
        }

        var printValue = "^XA"
                + "^PRA"
                + "^LH0,0^FS"
                + "^LL152"
                + "^MD0"
                + "^MNY"
                + "^LH0,0^FS"
                + "^BY2,3.0^FO50,46^BCN,100,N,N,N"
                + "^FR"
                + "^FD@Value^FS"
                + "^FT110,190"
                + "^A0N,44,46^FD@Value"
                + "^FS"
                + "^PQ1,0,0,N"
                + "^XZ";
        function prtLabel() {
             var  left=10;
             var top =0;
             var columnsDistance=0;
             var barcodeHeigth = 0;
            if (checkPrintPlugin($("#noprtplg"))) {
                labelPrintingPlugin = document.getElementById("labelPrintingPlugin");
            }

            for (var j; lableIndex < lableArr.length; lableIndex++) {
                var s = "... ...";
                if ((lableArr.length - (lableIndex + 1)) == 0) {
                    $("#lblPt").html("已打印完毕！");
                }
                else {
                    $("#lblPt").html("正在排队打印，还有" + (lableArr.length - (lableIndex + 1)) + "个条码等待打印");
                }
                var value = (printValue.replace("@Value", lableArr[lableIndex]).replace("@Value", lableArr[lableIndex]));
                doPrintGrn(labelPrintingPlugin, value);
                setTimeout(prtLabel, 500);
            }
           
        }

    </script>
</asp:Content>
