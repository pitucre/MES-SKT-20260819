<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="SKT.LeanMES.Web.MobileApp.Index" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, minimum-scale=1, maximum-scale=1">

    <link href="theme/flatui/jquery.mobile.flatui.min.css?v=11" rel="stylesheet" type="text/css" />
    <link href="css/common.css" rel="stylesheet" type="text/css" />
    <link href="css/Index.css?v=11122" rel="stylesheet" type="text/css" />
    <script src="js/jquery.min.js" type="text/javascript"></script>
    <script src="js/jquery.mobile-1.4.5.min.js" type="text/javascript"></script>
    <script src="js/Common.js" type="text/javascript"></script>
    <script src="js/skt.mobile.cookies.js" type="text/javascript"></script>
    <title>深科特LeanMES移动客户端</title>
    <style type="text/css">
        .slide {
            display: none;
        }

        .play {
            display: block;
        }

        .slide img {
            position: static;
            position: relative;
            top: -50%;
            /*left: -50%;*/
            width: 100%;
            height: 100%;
            vertical-align: middle;
        }

        .noDisplay {
            display: block;
            /*border: 1px solid #00bfff;*/
        }

        .ui-link {
            width: 33%;
            line-height: 33%;
        }

        .titleZ {
            padding-top: 30px;
            margin-top: 10px;
            font-size: 15px;
            font-weight: bold;
        }

        .imgZx {
            padding-bottom: 10px;
            padding-top: 12px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server" style="height: 100%">


        <!--首页-->
        <div data-role="page" id="home" title="首页" data-theme="a" style="height: 100%">
            <div data-role="content" id="main2" style="height: 100%">
                <div style="height: 30%; background: #808080; margin-bottom: 0px; text-align: center;">
                    <div id="slide0" class="slide play">
                        <img src="newImages/aaa.jpg" alt="" />
                    </div>
                    <div id="slide1" class="slide">
                        <img src="newImages/bbb.jpg" alt="" />
                    </div>
                    <div id="slide2" class="slide">
                        <img src="newImages/ccc.jpg" alt="" />
                    </div>
                    <div id="slide3" class="slide">
                        <img src="newImages/ddd.jpg" alt="" />
                    </div>
                </div>

                <div style="height: 70%; width: 100%">
                  <%--  <ul class="appiconlist" id="whapp" style="height:33%; padding: 0 0em 0em; margin-bottom: 0px;">
                        <li class="noDisplay" style="height: 95px; width: 28%; border-right: 1px solid#EAEAEA; border-bottom: 1px solid #EAEAEA;" id="PDA_WareHouseInOperation">
                            <a href="#" onclick="Check(1);" style="vertical-align: bottom;">
                                <img src="newImages/dataCollection.png" class="imgZx" style="padding-bottom: 10px; padding-top: 12px;" />

                                <span class="text titleZ">定制作业 </span>
                            </a>
                        </li>
                        <li class="noDisplay" id="PDA_InStock" style="height: 95px; width: 28%; border-right: 1px solid #EAEAEA; border-bottom: 1px solid #EAEAEA;"><a href="#" onclick="Check(2);" data-transition="none" data-ajax="false" style="vertical-align: bottom;">
                            <img src="newImages/SystemManger.png" class="imgZ" style="padding-bottom: 10px; padding-top: 12px;" />

                            <span class="text titleZ">系统管理 </span></a></li>
                        <li class="noDisplay" id="PDA_WarehouseMaterialPrepare" style="height: 95px; width: 28%; border-bottom: 1px solid #EAEAEA"><a href="#" onclick="Check(3);" data-transition="none" data-ajax="false" style="vertical-align: bottom;">
                            <img src="newImages/Basicdata.png" class="imgZ" style="padding-bottom: 10px; padding-top: 12px;" />

                            <span class="text titleZ">基础数据 </span></a></li>
                    </ul>--%>
                    <ul class="appiconlist" style="height: 33%; padding: 0 0em 0em;">
                        <li class="noDisplay" id="PDA_MaterialSplit" style="margin-top: -17px; height: 95px; width: 28%; border-right: 1px solid #EAEAEA; border-bottom: 1px solid #EAEAEA;"><a href="#" onclick="javascript:location.href='MenuList.aspx?type=4';" data-transition="none">
                            <img src="images/NEW/images/仓库管理.png" class="imgZ" style="padding-bottom: 10px; padding-top: 12px;" />
                            <%--<img src="newImages/WarehouseManager.png" class="imgZ" style="padding-bottom: 10px; padding-top: 12px;" />--%>
                            <span class="text titleZ">仓库管理 </span></a></li>
                        <li class="noDisplay" id="PDA_MoveLocation" style="margin-top: -17px; height: 95px; width: 28%; border-right: 1px solid #EAEAEA; border-bottom: 1px solid #EAEAEA;"><a href="#" onclick="Check(5);" data-transition="none" data-ajax="false">
                            <img src="newImages/productionManager.png" class="imgZ" style="padding-bottom: 10px; padding-top: 12px;" />
                            <span class="text titleZ">生产管理 </span></a></li>
                        <li class="noDisplay" id="PDA_CpInStock" style="margin-top: -17px; height: 95px; width: 28%; border-bottom: 1px solid #EAEAEA;"><a href="#" onclick="Check(6);" data-transition="none" data-ajax="false">
                            <img src="images/NEW/images/设备管理.png" class="imgZ" style="padding-bottom: 10px; padding-top: 12px;" />
                            <span class="text titleZ">设备管理</span></a></li>
                    </ul>
                     <ul class="appiconlist" style="height: 33%; padding: 0 0em 0em;">
                        <li class="noDisplay" id="PDA_CpOutStock" style="margin-top: -17px; height: 95px; width: 28%; border-right: 1px solid #EAEAEA;"><a href="#" onclick="Check(7);" data-transition="none" data-ajax="false">
                            <img src="newImages/qualityManager.png" class="imgZ" style="padding-bottom: 10px; padding-top: 12px;" />
                            <span class="text titleZ">品质管理 </span></a></li>
                      <%-- <li class="noDisplay" id="PDA_WarehouseCheck" style="margin-top: -17px; height: 95px; width: 28%; border-right: 1px solid #EAEAEA;"><a href="#" onclick="Check(8);" data-transition="none" data-ajax="false">
                            <img src="newImages/KanbanManager.png" class="imgZ" style="padding-bottom: 10px; padding-top: 12px;" />
                            <span class="text titleZ">看板管理 </span></a></li>
                        <li class="noDisplay" id="PDA_WarehouseCheckReplay" style="margin-top: -17px; height: 95px; width: 28%"><a href="#" onclick="Check(9);" data-transition="none" data-ajax="false">
                            <img src="images/NEW/images/BI中心.png" class="imgZ" style="padding-bottom: 10px; padding-top: 12px;" />
                            <span class="text titleZ">BI中心 </span></a></li>--%>
                    </ul>
                </div>
            </div>
            <!--//Content-->
            <!--Footer-->
            <div data-role="footer" id="footer" data-position="fixed">
                <div data-role="navbar" style="width: 100%">
                    <ul>
                        <li><a href="#" data-icon="home" style="width: 100%; line-height: 15px;" class="ui-btn-active" data-transition="none">主页</a></li>
                        <li><a href="#" style="width: 100%; line-height: 15px;" onclick="javascript:location.href='Myprofile.aspx'" data-icon="user" data-transition="none">个人中心</a></li>
                    </ul>
                </div>
            </div>
            <!--//Footer-->

            <!--弹出层-->
            <div data-role="main" class="ui-content">
                <div data-role="popup" id="popupBasic" data-overlay-theme="b">
                    <div data-role="header">
                        <h1>定制作业</h1>
                    </div>
                    <div data-role="main" class="ui-content">
                        <div data-role="fieldcontain">
                            <table style="width: 300px">
                                <tr>
                                    <td>
                                        <label for="modelName">
                                            功能模块
                                        </label>
                                        <select id="modelName" onchange="modelNameUpdate()">
                                            <option value="-1" selected="selected">请选择</option>
                                            <option value="仓库管理">仓库管理</option>
                                            <option value="生产管理">生产管理</option>
                                            <option value="设备管理">设备管理</option>
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <label for="functionName">
                                            作业名称
                                        </label>
                                        <select id="functionName">
                                            <option value="-1" selected="selected">请选择</option>
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td align="center">
                                        <a href="#" class="ui-btn ui-corner-all ui-shadow ui-btn-inline ui-btn-b ui-icon-back ui-btn-icon-left" data-theme="f" onclick="InFunction()">进入</a>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                    <a href='javascript:void(0)' data-rel="back" class="ui-btn ui-corner-all ui-shadow ui-btn-a ui-icon-delete ui-btn-icon-notext ui-btn-right">Close</a>
                </div>
            </div>
            <!--//弹出层-->
        </div>
    </form>
    <script type="text/javascript">
        var userName = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>';
        function get_cookie(Name) {
            var search = Name + "="//查询检索的值
            var returnvalue = "undefined"; //返回值
            if (document.cookie.length > 0) {
                sd = document.cookie.indexOf(search);
                if (sd != -1) {
                    sd += search.length;
                    end = document.cookie.indexOf(";", sd);
                    if (end == -1)
                        end = document.cookie.length;
                    //unescape() 函数可对通过 escape() 编码的字符串进行解码。
                    returnvalue = unescape(document.cookie.substring(sd, end))
                }
            }
            return returnvalue;
        }
        $(document).bind("mobileinit", function () {
            $.mobile.ajaxEnabled = false;
        });

        $(function () {
            var cachSite = getCookie("cachSite");
            if (cachSite != null && cachSite != "") {
                $("#sitetitle").html("(" + cachSite + ")");
            }
            else {
                $("#sitetitle,.sitetitle").hide();
            }
            $(".appiconlist li").hover(
                function () {
                    //$(this).children("a").children("img").removeClass("gray");
                    $(this).children("a").children("span").addClass("redtext");
                },
                function () {
                    // $(this).children("a").children("img").addClass("gray");
                    $(this).children("a").children("span").removeClass("redtext");
                });
            //getModulesByUserId();
            var whappLength = $("#whapp li ").not(".noDisplay").length;
            var prodappLength = $("#prodapp li").not(".noDisplay").length;
            var equptappLength = $("#equptapp li").not(".noDisplay").length;

            if (whappLength == 0) {
                $("#h6whappcount").hide();
            }
            if (prodappLength == 0) {
                $("#h6prodappcount").hide();
            }
            if (equptappLength == 0) {
                $("#h6equptappcount").hide();
            }
            $("#whappcount").html(" (" + whappLength + ")");
            $("#prodappcount").html(" (" + prodappLength + ")");
            $("#equptappcount").html(" (" + equptappLength + ")");

            $(".applisttitle").click(function () {
                $(this).next().slideToggle();
            });

        });

        //$(document).ready(function () {
        //    $("#modelName").selectmenu({
        //        change: function () {
        //            modelNameUpdate();
        //        }
        //    });
        //})

        function modelNameUpdate() {
            $("#functionName").html('<option value="-1" selected="selected">请选择</option>');
            $('#functionName').selectmenu("refresh");
            var modelName = $.trim($("#modelName").find(":selected").val());
            if (modelName == "-1") {
                //$('#functionName').selectmenu("refresh", true);
                return false;
            }

            $.ajax({
                type: "POST",
                url: "../Handler/ChooseLineAndRes.ashx?type=GetPDAFunction",
                async: false,
                dataType: "json",
                data: { "ModelName": modelName },
                success: function (data) {
                    var entity = data;
                    for (i = 0; i < entity.length; i++) {
                        $("#functionName").append("<option value=\"" + entity[i].ModelId + "\">" + entity[i].ModelName + "</option>");
                    }

                    //$('#functionName').selectmenu().selectmenu("refresh", true);
                },
                error: function (err) {
                    confirmDialogFocus("PDA模块作业未能初始化,请联系管理员！");
                }
            });
        }

        function InFunction() {
            var modelName = $.trim($("#modelName").find(":selected").val());
            if (modelName == "-1") {
                confirmDialogFocus("请选择'功能模块'！");
                return false;
            }

            var functionName = $.trim($("#functionName").find(":selected").val());
            if (functionName == "-1") {
                confirmDialogFocus("请选择'作业名称'！");
                return false;
            }

            window.location.href = "PDAFunctionPreview.aspx?ID=" + functionName + "&type=model&rut=" + Math.random();
        }

        //幻灯片
        setInterval('playSlide()', 3000);

        function playSlide() {
            var i = 0;
            var slideId = $(".play").attr("id").replace("slide", "");
            if (parseInt(slideId) == 3) {
                i = 0;
            }
            else {
                i = parseInt(slideId) + 1;
            }
            $(".slide").removeClass("play");
            $("#slide" + i.toString()).addClass("play");
        }

        //功能菜单
        function Check(data) {
            if (data == 4 || data == 5 || data == 6 || data == 7) {
                window.location.href = "MenuList.aspx?type=" + data;
            } else if (data == 1) {
                $("#popupBasic").popup('open');
            }
            else {
                confirmDialogFocus("模块暂未开放,尽请等待！");
            }

            //if (data == 1) {
            //    window.location.href = "WarehouseCheck.aspx";
            //} else if (data == 2) {
            //    window.location.href = "WareHouseInOperation.aspx";
            //} else if (data == 3) {
            //    window.location.href = "InStock.aspx";
            //} else if (data == 4) {
            //    window.location.href = "MoveLocation.aspx";
            //} else if (data == 5) {
            //    window.location.href = "WarehouseMaterialPrepare.aspx";
            //} else if (data == 6) {
            //    window.location.href = "CpInStock.aspx";
            //} else if (data == 7) {
            //    window.location.href = "CpOutStock.aspx";
            //} else if (data == 8) {
            //    window.location.href = "WarehouseCheckEdit.aspx";
            //} else if (data == 9) {
            //    window.location.href = "HandLoadingMaterial.aspx";
            //} else if (data == 10) {
            //    window.location.href = "PrepLoadingMaterial.aspx";
            //} else if (data == 11) {
            //    window.location.href = "WarehouseCheckReplay.aspx";
            //} else if (data == 12) {
            //    window.location.href = "MaterialSplit.aspx";
            //} else if (data == 13) {
            //    window.location.href = "FeederBindMaterial.aspx";
            //} else if (data == 14) {
            //    window.location.href = "FeederAndMaterialInfo.aspx";
            //} else if (data == 15) {
            //    window.location.href = "SMTCheckMaterial.aspx";
            //} else if (data == 16) {
            //    window.location.href = "EQ_SteelNet.aspx";
            //} else if (data == 17) {
            //    window.location.href = "EQ_SteelNetWash.aspx";
            //} else if (data == 18) {
            //    window.location.href = "EQ_SteelSearch.aspx";
            //} else if (data == 16) {
            //    window.location.href = "CpPrepare.aspx";
            //} else if (data == 21) {//辅料校验
            //    window.location.href = "AccessoryLoading.aspx";
            //} else if (data == 22) {//JIT发料
            //    window.location.href = "JITStockList.aspx";
            //} else if (data == 23) {//产线接收
            //    window.location.href = "ProductionReceive.aspx";
            //} else if (data == 24) {//MSD管理
            //    window.location.href = "EncapsulationManager.aspx";
            //} else if (data == 25) {//送检
            //    window.location.href = "Reinspection.aspx";
            //} else if (data == 26) {
            //    window.location.href = "OrderAgingRpt.aspx";

            //}
        }
        $("#grid > a").each(function (i, j) {
            switch (i) {

            }
        });
        //不同的上料采集方法：checkMType:1.SMT采集 2.手插采集 3.前置加工采集
        function IsShowLineAndRes(checkMType) {
            $.ajax({
                type: "POST",
                url: "../Handler/ChooseLineAndRes.ashx?type=showHandMaterial",
                async: false,
                dataType: "json",
                data: { "loadMateriakType": checkMType, "userName": userName },
                success: function (data) {
                    if (checkMType == 2) {
                        if (data != null) {
                            window.location.href = "HandCheckMaterial.aspx?checkType=" + checkMType + "";
                        }
                        else {
                            window.location.href = "ChooseLineAndRes.aspx?checkMType=" + checkMType + "";
                        }
                    } else if (checkMType == 1) {
                        if (data != null) {
                            window.location.href = "SMTCheckMaterial.aspx?checkType=" + checkMType + "";
                        }
                        else {
                            window.location.href = "ChooseLineAndRes.aspx?checkMType=" + checkMType + "";
                        }
                    }
                },
                error: function (err) {
                    if (err.responseText != "") {
                        window.location.href = "ChooseLineAndRes.aspx?checkMType=" + checkMType + "";
                    }
                }
            });
        }

        var idArr = ["PDA_WarehouseCheck", "PDA_WareHouseInOperation", "PDA_InStock", "PDA_MoveLocation", "PDA_WarehouseMaterialPrepare",
            "PDA_CpInStock", "PDA_CpOutStock", "PDA_WarehouseCheckEdit", "PDA_HandLoadingMaterial", "PDA_PrepLoadingMaterial",
            "PDA_WarehouseCheckReplay", "PDA_MaterialSplit", "PDA_FeederBindMaterial", "PDA_SMTCheckMaterial",
            "PDA_EQ_SteelNet", "PDA_EQ_SteelNetWash", "PDA_EQ_SteelSearch",
            "PDA_JITStockList", "PDA_ProductionReceive", "PDA_EncapsulationManager", "PDA_Reinspection", "PDA_OrderAgingRpt", "PDA_DataCollection"];

        function getModulesByUserId() {
            var userId = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserId %>";
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxAccount.GetPopedomNameByUserId(parseInt(userId), "LeanMES_PDA");
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var result = ajax.value.toLowerCase();
            for (var i = 0; i < idArr.length; i++) {
                if (result.indexOf(idArr[i].toLowerCase()) != -1) {
                    $("#" + idArr[i]).removeClass("noDisplay");
                }
            }

        }
    </script>


</body>
</html>
