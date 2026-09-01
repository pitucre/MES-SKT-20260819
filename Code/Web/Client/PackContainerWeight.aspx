<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="PackContainerWeight.aspx.cs" Inherits="SKT.LeanMES.Web.Client.PackContainerWeight" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <link href="../Content/productioncollection.css" rel="Stylesheet" type="text/css" />
      <div id="scancenter" class="scan-center">
        <table cellpadding="0" cellspacing="0" border="0" width="100%">
            <tr>
                <td align="left" style="font-size:14px; letter-spacing:1px;">
                 当前重量：<span id="lblCurrentWeight" style="font-weight: bold; width: 80px; display: inline-block;font-size:15px;">0</span> 称重状态：<span id="lblCurrentState" style="font-weight: bold; font-size:15px;"></span>
                </td>              
            </tr>
            <tr>
                <td align="left">
                   <span style="float: left; font-weight: bolder; font-size: 16px;font-family: Verdana, 微软雅黑,黑体, 宋体; margin: 10px 0px 10px 0px;letter-spacing:1px;">请扫描 包装箱号或箱内产品条码：</span> <input type="text" id="txtSNPack" class="scan-center-sn" style="height: 40px; font-size: 18px;" />
                </td>               
            </tr>
            <tr>
                <td>
                    <span id="lblMsg" style="font-size:14px;font-family: Verdana, 微软雅黑,黑体, 宋体; margin-top:10px;letter-spacing:1px;"></span>
                </td>
            </tr>
        </table>
    </div>
     
    <script type="text/javascript" src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/layui/layui.all.js"></script>
    <link href="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/layui/css/layui.css" rel="stylesheet" />
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.utility.store.js" type="text/javascript"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/ws.js" type="text/javascript"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.ElectronicEquipment.js" type="text/javascript"></script>
    <script type="text/javascript">
        var resultWeigh = 0;
        

        $(document).ready(function () {
            //初始化称重插件
            stationId = getQueryString("stationid");
            resourceId = getQueryString("resourceid");
            isCheckStationConfig = false;   //配置未不需要检查工位配置
            initElectronic();

            setTimeout(function () {
                if (isOpen == false) {
                    alert("当前电子秤端口未打开！");
                }
            }, 1000);

            //扫描框回车事件
            $("#txtSNPack").keydown(
                function (e) {
                    var curKey = 0, e = e || window.event;
                    curKey = e.keyCode || e.which || e.charCode;

                    if (curKey == 13) {
                        if (this.value == "") {
                            return;
                        }
                        afterScan(this.value);
                    }
                    if (curKey == 46) {
                        $("#txtSNPack").val("");
                    }
                }
            );

        });

        function afterScan(sn) {

            checkWeight2(sn, 2, function (isOK) {
                if (!isOK)
                    return false;

                $("#lblMsg").css("color", "green").text("包装箱[" + sn + "]称重成功！重量: " + resultWeigh + " " + units);
                $("#txtSNPack").select();
            });
        }

        function checkWeight2(scanSN, weightType, callback) {//称重类型：1为通用过站称重SN、2为包装称重SN（包装称重SN重量不足时不能强制过站）
            if (isWeight) {//需要称重操作
                GetWeight(function () {
                    resultWeigh = prodWeight;  //获取重量结果

                    //验证重量范围
                    ajax = SKT.LeanMES.Web.AjaxServices.AjaxContainerWeight.CheckSNWeight(scanSN, parseFloat(resultWeigh), stationId, resourceId, weightType);
                    if (ajax.error != null) {
                        // alert(ajax.error.Message);
                        $("#lblMsg").css("color", "red").text(ajax.error.Message)
                        $("#txtSNPack").select();
                        //写入日志
                        //SaveUserUILog("一般", stationId, resourceId, scanSN, ajax.error.Message);
                        callback(false);
                        return;
                    }
                    callback(true);
                });
            }
            else {
                callback(true);
            }
        }
    </script>
</asp:Content>
