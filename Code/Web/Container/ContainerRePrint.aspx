<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ContainerRePrint.aspx.cs" Inherits="SKT.MES.Web.BasalData.ContainerRePrint" MasterPageFile="~/Masters/ViewMaster.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="server">
    <div id="noprtplg" class="Tips">
    </div>
    <div id="printerHolder">
    </div>
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label1">
                <%=Resources.lang.MoveToRight %>
            </td>
            <td class="Field1">
                <input type="text" id="txtLeft" class="TextBox" style="height: 25px; width: 20px;
                    text-transform: uppercase; font-size: 16px; font-weight: bold;"  onkeyup="this.value=this.value.replace(/\D/g,'')"
                    onafterpaste="this.value=this.value.replace(/\D/g,'')"
                    value="0" />
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%=Resources.lang.SelectWONumber%><em>*</em>
            </td>
            <td class="Field1">
                <input type="text" id="txtOrder" class="TextBox" style="height: 25px; width: 250px;
                    text-transform: uppercase; font-size: 16px; font-weight: bold;" />
                <input   type="button" id="btnSelectVendorCode" class="ButtonBox"  style="height: 25px;
                    text-transform: uppercase; font-size: 16px; font-weight: bold;"  value="..." onclick="selectProduct()" />
            </td>
        </tr>
        <tr>
            <td class="Label1">
                品名规格   
            </td>
            <td class="Field1">
                <input type="text" id="txtModelSpec" class="TextBox" style="height: 25px; width: 250px;
                    text-transform: uppercase; font-size: 16px; font-weight: bold;" />
            </td>
        </tr>
        <tr>
            <td class="Label1">
                包装箱条码<em>*</em>
            </td>
            <td class="Field1">
                <input type="text" id="txtCaontainerSN" class="TextBox" style="height: 25px; width: 250px;
                    text-transform: uppercase; font-size: 16px; font-weight: bold;"  />
            </td>
        </tr>
        <tr>
            <td class="Label1">
                可包装最大数量<em>*</em>
            </td>
            <td class="Field1">
                <input type="text" id="txtPackMaxQuantity" class="TextBox" style="height: 25px; width: 250px;
                    text-transform: uppercase; font-size: 16px; font-weight: bold;" onkeyup="this.value=this.value.replace(/\D/g,'')"
                    onafterpaste="this.value=this.value.replace(/\D/g,'')" value ="1" />
            </td>
        </tr>
    </table>
     <div id="lblMessage" class="Tips">
    </div>
    <div id="lblPt" class="Tips">
    </div>
    <div class="clear5">
    </div>
    <div id="info" style="text-align: center; color: Green; font-weight: bold; text-transform: uppercase;">
    </div>
    <script type="text/javascript" src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/printerAcx.js?v=1.0.11"></script>
    <script type="text/javascript">
     <% if (Request.QueryString["ID"] == null) { %>
        var ContainerID = -1;
    <% } else { %>
        var ContainerID = <%= Request.QueryString["ID"] %>;
    <% } %>
        var typeValue = '<%=Request.QueryString["typeValue"] %>';
        var conDataID = -1;
        var prodOrderId = 0;    //工单id
        var orderNo  ="";     //工单号
        var modelSpec ="";    //品名规格
        var Quantity = 0 ;   
        var  maxQuantity = 0;  //最大包装数量
        NoPrinterPlugin = "<%=Resources.Messages.NoPrinterPlugin %>";
        $(document).ready(function () {
            pendPrintPluginDom($("#printerHolder"));
            checkPrintPlugin($("#noprtplg"));
        });
        /*******打印方法*******/
        function RePrint() {
            modelSpec = $("#txtModelSpec").val();
            if ($("#txtOrder").val()=="") {
                alert("<%=Resources.Messages.OrderEmptyWei %>");
                $("#txtOrder").focus();
                $("#txtOrder").select();
                return false;
            }
            else  if($("#txtCaontainerSN").val()=="")
            {
              alert("扫描卡通SN");
              return false;
            }
            /*获取conDataID*/
            var userId = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserId %>';
            var conTainerNumber = $("#txtCaontainerSN").val();
            /*End*/
            /**********开始打印*************************/
            if (!window.confirm("<%=Resources.Messages.ConfirmPrintTheseGRNs %>")) {
                return false;
            }
            $("#lblMessage").html("正在生成GRN，请稍后...");
            if(conTainerNumber!=null)
            {
                $("#lblMessage").html("<%=Resources.Messages.GenGrnFinishAndPrintInProcess %>");
                 setTimeout(function () {
                        printCartonSN(conTainerNumber);
                    }, 100);
            }
        }
        /******打印条码*******/
          var  conNumberArr;
          var  txtLeft  = 0;
          var labelPrintingPlugin;
          function printCartonSN(conNumberStr) {
             /*得到标签右移的单位*/
            txtLeft = $("#txtLeft").val();
            if (txtLeft > 0) {
                txtLeft = txtLeft + "0";
            }
            else {
                txtLeft = "00";
            }
            /*****判断是否可以进入打印**********/
            if (!checkPrintPlugin($("#noprtplg"))) {
                return false;
            }

            labelPrintingPlugin = document.getElementById("labelPrintingPlugin");

            if (conNumberStr == null) {
                return false;
            }
//            conNumberStr  =conNumberStr.substring(0,conNumberStr.lastIndexOf(","));
//            conNumberArr = conNumberStr.split(",");
            printCartonNumber();
           }

            var iCount = 0;
            function  printCartonNumber()
            {
               var __cartonSN =$("#txtCaontainerSN").val();
               var OrderNO=$("#txtOrder").val();
               var modelSpec=$("#txtModelSpec").val();
               var ajaxLabel = SKT.LeanMES.Web.AjaxServices.AjaxContainer.GetCartonLabelData(ContainerID, OrderNO, '100',__cartonSN,modelSpec, txtLeft);
               if (ajaxLabel.error != null) {
                   alert(ajaxLabel.error.Message);
                   return false;
               }

               if (ajaxLabel.value != ""){   
                  doPrintGrn(labelPrintingPlugin, ajaxLabel.value);
               }
               else{
                  alert("标签内容为空！");
                  return false;
               }
               window.location = location.href;
               $("#lblPt").html("打印完成！");
            }
           /*********打印具体的内容**********/

        /****End*****/
        $(function () {
            $("#txtOrder").focus();
            /*获取可包装最大数量*/
              var ajaxContainer = SKT.LeanMES.Web.Controls.PageSQLService.Search("QcCSylVv9LdUkBRYuMz9lCSsBUsvqwptSOpyA4agYhDDrcTsFYbGmA==",
            "r9sPMEsX/LDr7IhRL5gnECa8ECd56YOmzQLYMUalCGiysDFgwuhpiQ==","lxPVkm9sxjnlTknuonZmfosiCoXVPNpk4tsthJb8C8OqlnNI6AV6i/IzxXBkU0u3qml6QrDPiiwTQubmwALPpQ==","r9sPMEsX/LA1/jyA5ie6t2J4xeIm33DN#{" + ContainerID + "}#+rp516xMJ2A=", "hO1qKGfB1AtAJv+eXkOgaA==");
            if (ajaxContainer.error == null) {
                var entityAry = ajaxContainer.value;
                var entity = {};
                for (var i = 0; i < entityAry.length; i++) {
                    entity = entityAry[i];
                    $("#txtPackMaxQuantity").val(entity.Field4);
                    maxQuantity  = entity.Field4;
                    }
                 }
               else 
               {
                alert(ajaxContainer.error.Message);
                return false;
               }
            /*End*/
            /*扫描条码*/
            $("#txtPackMaxQuantity").keypress(function () {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    Print();
                    return false;
                }
            });
        });

        /*根据工单在对应ERP找到对应的数据*/
        var endor = "克利可";
        var rohs = "";       //是否环保
        var po = "";         //订单号
        var model = "";      //机种型号
        var erpOrder ="";    //工单号
        function   findInfoByOrderNo(orderNo){
        /*****根据工单找到对应的数据**********/
        if (orderNo.indexOf("_") > 0) {
            var ajaxPrintCarton = SKT.LeanMES.Web.Controls.PageSQLService.Search("ivkgQHawZckX+e9Kb3ntEJACc06rzCmv", "YeIGilu0VPFge6a/JBgdmw==",
            "Sy/ky8GgMip/mY/rwZpAhSB7pRze977we8LPqw2Qgkr9OgomT2+xtXJ8j0nfmZnXS+pm0dlXQwcfbD8Q02vR8jURkf60YBMk5kxp2RG5BGLc8AAf7VLREsOJck+pHoMmzjOkGYPtjSt1v+FgxBt1YYz6Zu1C1s0k",
            "oTKENZD/OzL6+zviZuMR7G5U40g5f22EtAoEKFS1f1Agw24SenfGzQ==#{" + orderNo + "}#xgKJsRKfHKc=", "xgKJsRKfHKc=");
            if (ajaxPrintCarton.error == null) {
                var entityAry = ajaxPrintCarton.value;
                if (entityAry[0] != null) {
                    erpOrder = entityAry[0].Field2; //工单号
                    po = entityAry[0].Field3;     //订单号
                    model = entityAry[0].Field4;  //机种型号
                    rohs = entityAry[0].Field6;  //环保;
                }
                else {
                    alert(getResource("Messages", "ERPNoOrderNotPrint"));
                    return false;
                }
            }
        }
        else {
            var ajaxPrintCartonStr = SKT.LeanMES.Web.Controls.PageSQLService.Search("ivkgQHawZckX+e9Kb3ntEJACc06rzCmv", "YeIGilu0VPFge6a/JBgdmw==",
            "oTKENZD/OzIWgDvwGGipYH2wVo7GHCU672Byq0ZtHEUiyhvTfcZcOMNrNKRuUsmzGLUyS+t5oHS9QsJGienMVN2OYz+Ahl2jgmYqwuCWXzVd7O0lNsraXg==",
            "oTKENZD/OzJ4YgvdnQolVrXw7KrFsi+R#{'" + orderNo + "'}#xgKJsRKfHKc=", "xgKJsRKfHKc=");
            if (ajaxPrintCartonStr.error == null) {
                var entityAry = ajaxPrintCartonStr.value;
                if (entityAry[0] != null) {
                    erpOrder = entityAry[0].Field2; //工单号
                    po = entityAry[0].Field3;     //订单号
                    model = entityAry[0].Field4;  //机种型号
                    rohs = entityAry[0].Field6;  //环保
                }
                else {
                    alert(getResource("Messages", "ERPNoOrderNotPrint"));
                    return false;
                }
            }
        }
   }
        /**/
        //选择工单
        function selectProduct() {
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=36&Multiple=false&rnd=" + Math.random(), width: 500, height: 400 });
        }
        function getChooseValue(list) {
            prodOrderId = list[0][0];
            orderNo =list[0][1];
            $("#txtOrder").val(list[0][1]);
            $("#txtOrder")[0].focus();
        }
    </script>
</asp:Content>
