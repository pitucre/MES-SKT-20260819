<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="InterfaceList.aspx.cs" Inherits="SKT.LeanMES.Web.Wave.InterfaceList" %>


<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <style type="text/css">
        .ListTable {
            margin-left: 0px;
            width: 100%;
        }

            .ListTable tr td {
                background-color: #F8F8F8;
            }

        .InfoTable {
            height: 179px;
            overflow: auto;
        }

        .bold {
            font-weight: bold;
        }

        .InfoTable Table {
            margin-left: 9px;
            line-height: 16px;
        }

        .borderleft {
            border-left: 1px solid #d3d3d3;
        }

        .borderright {
            border-right: 1px solid #d3d3d3;
        }

        .listbox {
            width: 99%;
            border: 0px;
            height: 145px;
        }

        .lblprompt {
            font-weight: normal;
            margin-left: 6px;
        }

        .textLine {
            text-decoration: line-through;
            vertical-align: middle;
        }

        .divTop {
            width: 100%;
            height: 170px;
            position: relative;
        }

        .divLeft {
            width: 50%;
            height: 200px;
            position: absolute;
            left: 0px;
            top: 0px;
        }

        .divRight {
            width: 50%;
            height: 200px;
            position: absolute;
            right: 0px;
            top: 0px;
        }

        .divBottom {
            width: 100%;
            height: auto;
        }

        .divBottomLeft {
            width: 50%;
            height: 179px;
            float: left;
        }

        .divBottomRight {
            width: 50%;
            height: 179px;
            float: left;
        }

        #divPOproductlist ul {
            float: left;
            list-style-type: none;
            line-height: 22px;
            padding-left: 2%;
            width: 98%;
        }

        #divPOproductlist li {
            width: 23%;
            margin-right: 2%;
            float: left;
        }

        #divPOproductPaging {
            position: absolute;
            right: 6px;
            top: 0px;
            line-height: 20px;
            width: 50%;
            height: 22px;
            font-weight: normal;
        }

            #divPOproductPaging ul {
                float: right;
                list-style-type: none;
                line-height: 22px;
            }

            #divPOproductPaging li {
                padding: 3px 5px;
                float: left;
                cursor: pointer;
            }

        .divwait {
            position: absolute;
            left: 47.2%;
            top: 190px;
            width: 66px;
            height: 66px;
            z-index: 9999;
        }

        /*Search button ==开始*/
        .SearchButton {
            border: none;
            background: url(<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/images/btn_search.png) no-repeat;
            cursor: pointer;
            width: 43px;
            height: 23px;
            padding: 2px;
            font-size: 11px;
        }

            .SearchButton:hover {
                border: none;
                background: url(<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/images/btn_search_hover.png) no-repeat;
                cursor: pointer;
                width: 43px;
                height: 23px;
                padding: 2px;
                font-size: 11px;
            }

        .test-positon {
            width: 300px;
        }

        #tbd {
            width: 200px;
            min-height: 25px;
            line-height: 25px;
            text-align: center;
            border: 1px solid #000000;
            border-collapse: collapse;
        }

            #tbd tr {
                border: 1px solid #000000;
                border-collapse: collapse;
            }

                #tbd tr td {
                    border: 1px solid #000000;
                    border-collapse: collapse;
                }
        /*Search button ==结束*/
    </style>
    <div class="wrap_tb" id="wrap_tb_container" style="min-width: 710px; overflow: auto;">
        <ul class="tb">
            <li class="current">测试设备接口
            </li>
            <li id="liSetting">镭雕接口
            </li>
            <li>微信接口
            </li>
            <li>钉钉接口
            </li>
            <%--<li>BasalWebService
            </li>--%>
            <li>ASM贴片机接口
            </li>
            <li>智能灯控接口
            </li>
            <li>样机接口
            </li>
            <li>料塔接口
            </li>
            <li>点料机</li>
        </ul>
        <div class="tb_c" style="min-height: 900px; overflow-y: scoll;">
            <iframe name="MesATE" id="MesATE" frameborder="0" style="width: 99%; height: 100%;"
                src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/WebService/MesATEApi.asmx"></iframe>
        </div>
        <div id="divSetting" style="min-height: 900px; overflow-y: scoll;">
            <iframe name="LaserCarvingWebService" id="LaserCarvingWebService" frameborder="0" style="width: 99%; height: 100%"
                src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/WebService/LaserCarvingWebService.asmx"></iframe>
        </div>
        <div id="divWeChatAPI" style="min-height: 900px; overflow-y: scoll;">
            <iframe name="WeChatAPI" id="WeChatAPI" frameborder="0" style="width: 99%; height: 100%"
                src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/WebService/WeChatAPI.asmx"></iframe>
        </div>
         <div id="divDingTalkAPI" style="min-height: 900px; overflow-y: scoll;">
            <iframe name="WeChatAPI" id="DingTalkAPI" frameborder="0" style="width: 99%; height: 100%"
                src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/WebService/DingTalkAPI.asmx"></iframe>
        </div>
        <%--<div id="divBasalWebService" style="min-height:900px; overflow-y: scoll;">
            <iframe name="BasalWebService" id="BasalWebService" frameborder="0" style="width: 99%;
                    height: 100%" src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/WebService/BasalWebService.asmx"></iframe>
        </div>--%>
        <div id="divDSWEBAPI" style="min-height: 900px; overflow-y: scoll;">
            <iframe name="DSWEBAPI" id="DSWEBAPI" frameborder="0" style="width: 99%; height: 100%"
                src="http://172.16.1.150/ds.api/swagger/ui/index#/SKTMateriel"></iframe>
        </div>
        <div id="divDataServer" style="min-height: 900px; overflow-y: scoll;">
            <div style="margin-top: 15px; margin-left: 15px; font-size: 16px;">
                <h5>接口通迅方式:</h5>
                <br />
                <div>
                    <div>(1)、Json数据格式说明</div>
                    <br />
                    <div style="margin-left: 25px;">例如:Json={T1:[{Code:'代码',Command:'命令',Pro:'协议',Time:'时间'}],T2:[{Ce:'库位',Co:'颜色'},{Ce:'库位',Co:'颜色'}]}</div>
                    <br />
                    <div style="margin-left: 25px;">T1=协议Head,Code=亮灯代码,Comand=命令,Pro=亮灯/闪烁,Time=延时灭灯</div>
                    <br />
                    <div style="margin-left: 25px;">T2=协议Data,Ce=库位,Co=颜色</div>
                    <br />
                    <div>(2)、通迅地址，实例：<span style="color: blue;">http://10.12.x.xxx/WebService/DataServer.aspx</span> 具体IP地址视服务的部署而定。</div>
                    <br />
                    <div>
                        (3)、货位亮灯颜色设定:
                              <table id="tbd" border="1">
                                  <thead>
                                      <tr style="background-color: #CDCDCD; font: bold;">
                                          <td>功能</td>
                                          <td>颜色</td>
                                      </tr>
                                  </thead>
                                  <tbody>
                                      <tr>
                                          <td>入库</td>
                                          <td>绿色</td>
                                      </tr>
                                      <tr>
                                          <td>库龄</td>
                                          <td>橙色</td>
                                      </tr>
                                      <tr>
                                          <td>盘点</td>
                                          <td>蓝色</td>
                                      </tr>
                                      <tr>
                                          <td>超期</td>
                                          <td>红色</td>
                                      </tr>
                                      <tr>
                                          <td>第一工单发料</td>
                                          <td>红色</td>
                                      </tr>
                                      <tr>
                                          <td>第二工单发料</td>
                                          <td>橙色</td>
                                      </tr>
                                      <tr>
                                          <td>第三工单发料</td>
                                          <td>黄色</td>
                                      </tr>
                                      <tr>
                                          <td>第四工单发料</td>
                                          <td>绿色</td>
                                      </tr>
                                      <tr>
                                          <td>第五工单发料</td>
                                          <td>青色</td>
                                      </tr>
                                      <tr>
                                          <td>第六工单发料</td>
                                          <td>蓝色</td>
                                      </tr>
                                      <tr>
                                          <td>第七工单发料</td>
                                          <td>紫色</td>
                                      </tr>
                                  </tbody>
                              </table>
                    </div>
                </div>
            </div>
        </div>
        <div id="PrototypeAPI" style="min-height: 900px; overflow-y: scoll;">
            <iframe frameborder="0" style="width: 99%; height: 100%" src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/WebService/SampleCheck.asmx"></iframe>
        </div>
        <div id="divMTWebAPI" style="min-height: 900px; overflow-y: scoll;">
            <iframe name="MTWEBAPI" id="MTWEBAPI" frameborder="0" style="width: 99%; height: 100%"
                src="http://172.16.1.150/8.5.6.WebApi/swagger/ui/index#/MeterialTower"></iframe>
        </div>
        <div id="divCountingMachine" style="min-height: 900px; overflow-y: scoll;">
            <iframe name="nameCountingMachine" id="CountingMachine" frameborder="0" style="width: 99%; height: 100%"
                src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/WebService/XReyApi.asmx"></iframe>
        </div>
    </div>
    <script type="text/javascript">
          
    </script>
</asp:Content>
