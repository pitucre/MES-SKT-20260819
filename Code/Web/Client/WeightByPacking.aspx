<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="WeightByPacking.aspx.cs" Inherits="SKT.LeanMES.Web.Client.WeightByPacking" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <link href="../Content/productioncollection.css" rel="Stylesheet" type="text/css" />
    <div id="scancenter" class="scan-center">
        <table cellpadding="0" cellspacing="0" border="0" width="100%">
            <tr>
                <td align="left">
                    <span class="scan-center-title" style="font-size: 18px;">请扫描包装条码</span>&nbsp;&nbsp;&nbsp;&nbsp;
                </td>

            </tr>
            <tr>
                <td align="left" colspan="2">
                    <input type="text" id="txtSN" class="scan-center-sn" style="height: 30px; font-size: 15px;" />

                </td>
            </tr>
            <tr>
                <td>
                    <strong style="font-size: 18px;">称重重量(kg)</strong>
                    <input type="text" id="txtCurrentWeight" value="" style="height: 30px; width: 20%; vertical-align: middle; cursor: pointer;" readonly="readonly" />
                    &nbsp;&nbsp;               
               <strong style="font-size: 18px;">卡通重量范围</strong>
                    <asp:TextBox ID="txtCartWeight" runat="server" Style="height: 30px; width: 20%; vertical-align: middle; cursor: pointer;"></asp:TextBox>
                </td>
            </tr>
        </table>
        <!--实时信息输出-->
        <div id="activeinfo" class="active-info">
            <div id="activeinfoarea" class="active-info-area"></div>
        </div>
    </div>
    <script type="text/javascript" src="../Content/js/skt.ElectronicEquipment.js"></script>
    <script src="../Content/js/jquery.min.js" type="text/javascript"></script>
       <script type="text/javascript" src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/layui/layui.all.js"></script>
    <link href="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/layui/css/layui.css" rel="stylesheet" />
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/ws.js" type="text/javascript"></script>
    <script src="../Content/js/skt.client.productioncollection.js" type="text/javascript"></script>
    <script type="text/javascript">
        var scanSN = "";
        var CartWeight = '<%= Request.QueryString["CartWeight"] %>';
    var PackSN = '<%= Request.QueryString["PackSN"] %>';

        $(function () {
            initElectronic();
            getElectronicCallSetXml(); //获取串口配置的属性         
            setTimeout(function () {
                comSetting();//初始化串口
                openCom();//打开串口
            }, 2000);
        })

        //开始扫描
        function afterScan() {
            if ($("#txtSN").val() != "") {
                scanSN = $.trim($("#txtSN").val()); //扫描Sn
                if (scanSN != PackSN) {
                    showAreaMessge("请扫描正确的包装箱号:" + PackSN, "messageRed");
                    return false;
                }
                $("#<%=this.txtCartWeight.ClientID%>").val(CartWeight);
                getWeight(scanSN);
            }
        }


        function getWeight(scanSN) {
            var value = $("#txtCurrentWeight").val();
            if (value == "-10000000 g") {
                showAreaMessge(scanSN + ':' + "未找到称重设备", "messageRed");
                return;
            }
            //获取称重结果
            var weightSN = SKT.LeanMES.Web.AjaxServices.AjaxContainerWeight.GetWeightByPacking(scanSN, value);
            if (weightSN.error != null) {
                showAreaMessge(scanSN + ':' + weightSN.error.Message, "messageRed");
                $("#txtSN").val("").focus();
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, scanSN, weightSN.error.Message);
                return false;
            } else {
                var msg = "称重重量为:" + value + " 卡通重量范围为:" + $("#<%=this.txtCartWeight.ClientID%>").val() + "称重结果为：合格";
                    showAreaMessge(scanSN + ':' + msg, "messageRed");
                }
            }

            //异常重量变色提醒
            /*   function colorWarning(containerMinWeight,containerMaxWeight){         
                setInterval(function(){   
                  var txtCurrentWeight= $("#txtCurrentWeight").val().split(' ')[0];     
                if ( parseInt(txtCurrentWeight)>containerMinWeight && parseInt(txtCurrentWeight) < containerMaxWeight) {
                                   $("#txtCurrentWeight").css('background-color', 'Chartreuse');
                               } else {
                                   $("#txtCurrentWeight").css('background-color', 'Red');
                               }
                    }, 500);           
                }  */

            /*
            *获取包装箱串口配置文件
            */
            function getElectronicCallSetXml() {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxContainerWeight.loadElectronicCallSetXML();
                if (ajax.value.BoundRate != "" && ajax.value.PortName != "") {
                    portName = ajax.value.PortName;
                    boundRate = ajax.value.BoundRate;
                    stopBits = "StopBits.One";
                    dataBits = 8;
                    parity = "Parity.None";
                } else {
                    alert("未获取到设备配置信息！");
                    return;
                }

            }

            function comSetting() {
                var sleepTime = 500;
                if (sleepTime < 1) {
                    sleepTime = 500;
                }
                var data = new Object();
                data.PortName = portName
                data.Parity = parity;
                data.DataBits = dataBits;
                data.StopBits = stopBits;
                data.boundRate = boundRate;
                data.key = "comSetting";
                var jsonStr = JSON.stringify(data);
                socket.send(jsonStr);
            }

            function openCom() {
                var data = new Object();
                data.PortName = portName;;
                data.key = "openCom";
                var jsonStr = JSON.stringify(data);
                socket.send(jsonStr);
            }
    </script>
    <script type="text/javascript">         
        
    </script>
</asp:Content>
