<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="ElectronicCallSet.aspx.cs" Inherits="SKT.LeanMES.Web.Client.ElectronicCallSet" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <div class="wrap_tb" style="min-width: 650px;">
        <div class="tb_c" style="min-height: 300px;">
            <table class="EditeContentTable" width="100%">
                <tr>
                    <td class="Label2">串口名称：<em>*</em></td>
                    <td class="Field2">
                        <select id="sltCom" isrequired="1"></select>
                    </td>
                    <td class="Label2">波特率：<em>*</em></td>
                    <td class="Field2">
                        <select id="sltBaudRate">
                            <option value="300">300</option>
                            <option value="600">600</option>
                            <option value="1200">1200</option>
                            <option value="2400">2400</option>
                            <option value="4800">4800</option>
                            <option value="9600" selected="selected">9600</option>
                            <option value="19200">19200</option>
                            <option value="38400">38400</option>
                            <option value="43000">43000</option>
                            <option value="56000">56000</option>
                            <option value="57600">57600</option>
                            <option value="115200">115200</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td class="Label2">数据位：<em>*</em></td>
                    <td class="Field2">
                        <select id="sltDataBits">
                            <option value="5">5</option>
                            <option value="6">6</option>
                            <option value="7">7</option>
                            <option value="8" selected="selected">8</option>
                        </select>
                    </td>
                    <td class="Label2">停止位：<em>*</em></td>
                    <td class="Field2">
                        <select id="sltStop">
                            <option value="1" selected="selected">1</option>
                            <option value="1.5">1.5</option>
                            <option value="2">2</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td class="Label2">稳定标识：</td>
                    <td class="Field2">
                        <input type="text" id="txtState" value="ST" style="width: 70px;" />
                        电子秤稳定信号标识。例如：ST
                    </td>
                    <td class="Label2">校验位：<em>*</em></td>
                    <td class="Field2">
                        <select id="sltParity">
                            <option value="无">无</option>
                            <option value="奇校验">奇校验</option>
                            <option value="偶校验">偶校验</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td class="Label2">单位：<em>*</em></td>
                    <td class="Field2">
                        <select id="sltUnits">
                            <option value="g">g</option>
                            <option value="kg">kg</option>
                            <option value="lb">lb</option>
                        </select>
                    </td>
                    <td class="Label2">保留小数位：<em>*</em></td>
                    <td class="Field2">
                        <input type="text" id="txtDecimalPoint" value="4" style="width: 70px;" maxlength="3" isrequired="1" /></td>
                </tr>
                <tr>
                    <td class="Label2">发送指令：</td>
                    <td class="Field2" colspan="3">
                        <input type="text" id="txtSendCode" value="" style="width: 70px; float: left; margin-right: 5px;" /><div>
                            <span>16进制数据字符串（每2位1个空格分隔），用于需要发送指令才能获取称重的设备，为空则不启用该功能。<br />
                                例如：双杰牌的电子秤需要发送指令（1B 70）获取称重数据</span>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="Label2">重量取值范围：<em>*</em></td>
                    <td class="Field2" colspan="3">
                        <input type="text" id="txtWeightRange" value="8:7" style="width: 70px; float: left; margin-right: 5px;" isrequired="1" /><div>
                            <span>范围用于解析重量信息。<br />
                                例如：ST NT +0000047 g,范围【8:7】表示从第8位开始获取7个长度字符,即值为0000047</span>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="Label2">单位取值范围：<em>*</em></td>
                    <td class="Field2" colspan="3">
                        <input type="text" id="txtUnitsRange" value="16:1" style="width: 70px; float: left; margin-right: 5px;" isrequired="1" /><div>
                            <span>范围用于解析单位信息。<br />
                                例如：ST NT +0000047 g,范围【16:1】表示从第16位开始获取1个长度字符,即值为g</span>
                        </div>
                    </td>

                </tr>
                <tr>
                    <td class="Label2"></td>
                    <td class="Field2" colspan="3">
                        <input type="button" id="btnSave" style="cursor: pointer;" value=" 保 存 " onclick="setElectronic()" />

                        <input type="button" id="btnGet" style="cursor: pointer;" value=" 测 试 " onclick="getElectronicStr()" />
                        <span>当前电子秤通讯字符串为：<span id="lblComStr" style="margin-left: 10px; font-size: 14px; font-weight: bold;">点击测试按钮获取通讯字符串信息</span></span>
                    </td>
                </tr>
            </table>

        </div>
    </div>
       <script type="text/javascript" src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/layui/layui.all.js"></script>
    <link href="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/layui/css/layui.css" rel="stylesheet" />
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/ws.js" type="text/javascript"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.client.productioncollection.js" type="text/javascript"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.utility.store.js" type="text/javascript"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.ElectronicEquipment.js" type="text/javascript"></script>

    <script type="text/javascript">
        var scanSN = "";
        var stationId = getQueryString("stationid");
        var resourceId = getQueryString("resourceid");

        $(document).ready(function () {
            //初始化称重插件
            initElectronic(false);

            if (isWeight == false) {
                alert("当前工序不需要称重操作，不需维护电子秤参数！");
                $("#btnSave").hide();
                return false;
            }
            setTimeout(function () {
                bindCom(function () {
                    getElectronic();
                });
                
            }, 600)

            $("#txtDecimalPoint").keyup(function () {
                getIntVal(this);
            });
        });

        /**
        *绑定串口信息
        **/
        function bindCom(callBack) {
            Plugin.GetPortNames(function (success, data, error) {
                if (!success) {
                    console.log(error);
                    return;
                }
                var comList = data;
                comList = comList.split(";");
                var options = "";
                for (var i = 0; i < comList.length; i++) {
                    options += "<option value = '" + comList[i] + "' >" + comList[i] + "</option>";
                }
                $("#sltCom").html(options);
                if (callBack)
                    callBack();
            });
        }

        /**
        *获取本机保存的串口信息
        **/
        function getElectronic() {
            var setStr = store.get("ElectronicWeightSet" + resourceId);

            if (setStr != null && setStr != "") {
                var entity = {};
                entity = JSON.parse(setStr);
                $("#sltCom").val(entity.PortName);
                $("#sltBaudRate").val(entity.BaudRate);
                $("#sltDataBits").val(entity.DataBits);
                $("#sltStop").val(entity.Stop);
                $("#sltUnits").val(entity.Units);
                $("#txtState").val(entity.State);
                $("#sltParity").val(entity.Parity);
                $("#txtDecimalPoint").val(entity.DecimalPoint);
                $("#txtWeightRange").val(entity.WeightRange);
                $("#txtUnitsRange").val(entity.UnitsRange);
                $("#txtSendCode").val(entity.SendCode);
            }
        }

        /**
       *存储本机的串口信息
       **/
        function setElectronic(flag) {
            if (!SubmitValidation()) {
                return false;
            }

            var entity = {};
            entity.PortName = $("#sltCom").val();
            entity.BaudRate = $("#sltBaudRate").val();
            entity.DataBits = $("#sltDataBits").val();
            entity.Stop = $("#sltStop").val();
            entity.Units = $("#sltUnits").val();
            entity.State = $("#txtState").val();
            entity.Parity = $("#sltParity").val();
            entity.DecimalPoint = $("#txtDecimalPoint").val();
            entity.WeightRange = $("#txtWeightRange").val();
            entity.UnitsRange = $("#txtUnitsRange").val();
            entity.SendCode = $("#txtSendCode").val();

            store.set("ElectronicWeightSet" + resourceId, JSON.stringify(entity));

            if (flag == 1) {
                return;
            }
            alert("设备串口信息保存成功！");

            window.parent.location.reload();
        }

        function getElectronicStr() {
            try {
                var isOpen = false;
                setStr = store.get("ElectronicWeightSet" + resourceId);
                try {
                    if ((setStr == null || setStr == "")) {
                        setElectronic(1);
                        setStr = store.get("ElectronicWeightSet" + resourceId);
                        Open(GetComStr);
                    }
                    else {
                        var entity = {};
                        entity = JSON.parse(setStr);
                        if (entity.PortName != $("#sltCom").val()) {
                            setElectronic(1);
                        }
                        Open(GetComStr);
                    }
                }
                catch (e) {
                    console.log(e);
                }

            }
            catch (e) {
                console.log(e);
            }
        }

        function GetComStr() {
            Plugin.GetComStr($("#sltCom").val(), function (success, data, error) {
                if (!success) {
                    console.log(error);
                    return;
                }
                $("#lblComStr").text(data);
            });
        }
    </script>
</asp:Content>
