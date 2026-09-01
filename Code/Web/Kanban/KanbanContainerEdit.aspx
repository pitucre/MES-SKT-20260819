<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="KanbanContainerEdit.aspx.cs"
    MasterPageFile="~/Masters/KanbanMaster.master" Inherits="SKT.LeanMES.Web.Kanban.KanbanContainerEdit" %>

<%@ Import Namespace="Resources" %>
<%@ Import Namespace="SKT.LeanMES.Web" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <%--<link href="../Content/theme/bootstrap/css/bootstrap.css" rel="stylesheet" type="text/css" />--%>
    <link href="../Content/plugin/colorpicker/css/jquery.cxcolor.css" rel="stylesheet"
        type="text/css" />
    <link href="../Content/plugin/jquery-ui-1.10.4/jquery-ui.min.css" rel="stylesheet"type="text/css" />
    <script src="../Content/plugin/jquery-ui-1.10.4/jquery-1.10.2.js" type="text/javascript"></script>
    <script src="../Content/plugin/jquery-ui-1.10.4/jquery-ui.min.js" type="text/javascript"></script>
        
    <%--KanbanMaster.master加载 <script src="../Content/Kanban/echarts.js" type="text/javascript"></script>--%>
    <!--[if lt IE 9]>
    <script type="text/javascript" src="../Content/theme/bootstrap/js/respond.js"></script>
    <![endif]-->
    <style type="text/css">
        #divPreView
        { 
            border-left: 1px solid #d3d3d3;
            border-right: 1px solid #d3d3d3;
        }
        .contUnit
        {
            border-color: #d3d3d3 !important;
            min-height: 200px;
            border: solid 1px;
            text-align: center;
            padding-top:80px;
            border-collapse: collapse;
            overflow: auto;
        }
        html, body
        {
            height: 100%;
            overflow: hidden;
        }
        .clock
        {
            float: right;
        }
        .clock ul li
        {
            float: left;
            font-size: large;
        }
        #DateContainer
        {
            margin-right: 10px;
        }
        .Date
        {
            font-family: Arial;
            font-size: large;
            text-align: center;
        }
        .divL
        {
            text-align: left;
        }
        .divM
        {
            text-align: center;
        }
        .divR
        {
            text-align: right;
        }
        .table > tbody > tr > td, .table > tbody > tr > th, .table > tfoot > tr > td, .table > tfoot > tr > th,
         .table > thead > tr > td, .table > thead > tr > th
        {
            padding: 8px;
            vertical-align: top;
            border-top: 1px solid #ddd;
            text-align: center;
        }
        #divTitle
        {
            padding: 0px;
            max-height: 50px;
            overflow: hidden;
        }
        #picker
        {
            width: 200px !important;
            height: 200px !important;
            z-index: 1001;
        }
        #slide
        {
            width: 30px !important;
            height: 200px !important;
            z-index: 1001;
        }
        .tb > li.current
        {
            line-height: 25px;
            background: #ffffff;
            font-weight: bold;
        }
        .dlg-nc .nebutton.close, .dlg-nc .nebutton.close:hover, .dlg-nc .nebutton.close:focus
        {
            opacity: 1;
            filter: alpha(opacity=100);
            margin-top: -1px;
        }
        .fontcss
        {
            padding: 5px;
        }
        .fontcss ul
        {
            padding: 0px;
            margin: 0px;
        }
        .fontcss ul li
        {
            padding: 0px;
            margin: 0px;
            float: left;
            list-style: none;
            line-height: 25px;
            vertical-align: middle;
        }
        .fontcss ul li select
        {
            padding: 0px;
            margin: 0px 0px 0px 2px;
        }
        .fontcss ul li .fontwiu span
        {
            font-weight: bold;
            padding: 3px 5px;
            width: 16px;
            height: 16px;
            margin-left: 3px;
            margin-right: 3px;
            border: 1px solid #fff;
        }
        .fontcss ul li .fontwiu span:hover
        {
            font-weight: bold;
            padding: 3px 5px;
            width: 16px;
            height: 16px;
            margin-left: 3px;
            margin-right: 3px;
            cursor: pointer;
            background: #f1f1f1;
            border: 1px solid #d3d3d3;
        }
        .fontcss .selected
        {
            font-weight: bold;
            padding: 3px 5px;
            width: 16px;
            height: 16px;
            margin-left: 3px;
            margin-right: 3px;
            cursor: pointer;
            background: #d3d3d3;
            border: 1px solid #666;
        }
        .fontcss ul li .textalign
        {
            margin-top: 5px;
        }
        .fontcss ul li .textalign span
        {
            padding: 3px;
            width: 16px;
            height: 16px;
            margin-left: 3px;
            margin-right: 3px;
            border: 1px solid #fff;
        }
        .fontcss ul li .textalign span:hover
        {
            padding: 3px;
            width: 16px;
            height: 16px;
            margin-left: 3px;
            margin-right: 3px;
            cursor: pointer;
            background: #f1f1f1;
            border: 1px solid #d3d3d3;
        }
        table tr:nth-child(even) {
            background: rgba(254, 210, 210, 0.20);
        }
    </style>
    <div class="wrap_tb">
        <ul class="tb">
            <li class="current">容器类型</li>
            <li id="setContAttr">容器属性设置</li>
            <li>数据绑定</li>
            <li id="showPrv">预览</li>
        </ul>
        <!--选择容器类型-->
        <div class="tb_c">
            <div class="infoTips">
                <%=Resources.Messages.WithAsteriskIsRequired %>
            </div>
            <div id="divContType">
                <table width="100%" class="EditeContentTable">
                    <tr>
                        <td class="Label1" align="left">
                            容器命名：<em>*</em>
                        </td>
                        <td class="Field1" align="left">
                            <asp:TextBox ID="txtContName" runat="server" CssClass="TextBox" IsRequired="1" MaxLength="20" ClientIDMode="Static"
                                Width="250px">
                            </asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="Label1" align="left">
                            备注信息：
                        </td>
                        <td class="Field1" align="left">
                            <asp:TextBox ID="txtRemark" runat="server" Text="" CssClass="TextArea" TextMode="MultiLine"
                                ClientIDMode="Static" Width="250px">
                            </asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" style=" background:#f7f7f7; height:30px; text-align:center; font-weight:bold;">
                            容器布局<em>*</em> 
                        </td>
                    </tr>
                    <tr>
                        <td class="Field1" align="left" colspan="2">
                            <div id="divShowIcron">
                            </div>
                            <div style="display: none;">
                                <asp:TextBox ID="txtContType" runat="server" CssClass="TextBox" Height="24px"  IsRequired="1" Enabled="false"
                                    ClientIDMode="Static" Width="250px">
                                </asp:TextBox><input type="button" id="btnContType" class="ButtonBox" style="width: 65px;
                                    line-height: 12px; background: #ccc; font-size: 12px;" value="选择布局" title="点击打开布局列表"
                                    onclick="openChoosePage('contType');" />
                                <asp:HiddenField ID="hfContTypeID" runat="server" Value="-1" ClientIDMode="Static" />
                            </div>
                        </td>
                    </tr>
                    
                </table>
            </div>
        </div>
        <!--容器属性设置-->
        <div id="divUserSet">
            <table width="100%" class="EditeContentTable">
                <tr>
                    <td class="Label1" align="left">
                        背景颜色：
                    </td>
                    <td class="Field1" align="left">
                        <div class="color_picker">
                            <input id="color_b" type="text" class="input_cxcolor" readonly="readonly" /></div>
                    </td>
                </tr>
            </table>
            <div class="clear5">
            </div>
            <div class="divHeader">
                容器头部设置
            </div>
            <table width="100%" class="EditeContentTable" id="tbDataSource" cellspacing="0" cellpadding="4"
                style="border-width: 0px; min-width: 560px; width: 100%; overflow: auto; border-collapse: collapse;">
                <tr class="ListTableHeader">
                    <th align="center" width="3%">
                        位置
                    </th>
                    <th align="center" width="8%">
                        类型
                    </th>
                    <th align="center" width="34%">
                        内容
                    </th>
                    <th align="center">
                        样式属性
                    </th>
                </tr>
                <tr class="ListTableOddRow">
                    <td align="center" style="border: 1px; border-style: solid; border-color: #d3d3d3;">
                        左
                    </td>
                    <td align="center" style="border: 1px; border-style: solid; border-color: #d3d3d3;">
                        <select class="selType" id="selTypeL" runat="server" clientidmode="Static">
                            <option value="-1">无</option>
                            <option value="0">文字</option>
                            <option value="1">图片</option>
                            <option value="2">时间</option>
                            <%--<option value="3">服务器时间</option>--%>
                        </select>
                    </td>
                    <td align="center" style="border: 1px; border-style: solid; border-color: #d3d3d3;">
                        <input type="text" style="width: 80%" id="txtTitleLeft" class="txtContent" runat="server"
                            clientidmode="Static" />
                        <span class="btnResetType" style="cursor: pointer; color: #0000ff;">Reset</span>
                    </td>
                    <td align="left" style="border: 1px; border-style: solid; border-color: #d3d3d3;">
                        <div class="fontcss" id="cssLeft">
                            <ul>
                                <!--字体-->
                                <li>
                                    <select title="选择字体">
                                        <option value="arial">Arial</option>
                                        <option value="impact">Impact</option>
                                        <option value="andale mono">andale mono</option>
                                        <option value="\u5b8b\u4f53">宋体</option>
                                        <option value="\u9ed1\u4f53">黑体</option>
                                        <option value="\u5fae\u8f6f\u96c5\u9ed1" selected="selected">微软雅黑</option>
                                        <option value="\u6977\u4f53">楷体</option>
                                    </select>
                                </li>
                                <!--字号-->
                                <li>
                                    <select title="选择字体大小">
                                        <option value="8px">8px</option>
                                        <option value="9px">9px</option>
                                        <option value="10px">10px</option>
                                        <option value="11px">11px</option>
                                        <option value="12px" selected="selected">12px</option>
                                        <option value="14px">14px</option>
                                        <option value="16px">16px</option>
                                        <option value="18px">18px</option>
                                        <option value="20px">20px</option>
                                        <option value="22px">22px</option>
                                        <option value="24px">24px</option>
                                        <option value="26px">26px</option>
                                        <option value="30px">30px</option>
                                        <option value="36px">36px</option>
                                        <option value="48px">48px</option>
                                        <option value="58px">58px</option>
                                        <option value="68px">68px</option>
                                        <option value="78px">78px</option>
                                    </select>
                                </li>
                                <!--加粗-->
                                <li>
                                    <div class="fontwiu">
                                        <span onclick="setFontWeight(this)" title="加粗">B</span><span onclick="setFontI(this)"
                                            title="倾斜"><i>I</i></span><span onclick="setFontUnderline(this)" title="下划线"><u>U</u></span></div>
                                </li>
                                <!--文字对齐-->
                                <li>
                                    <div class="textalign" id="textalign">
                                        <span onclick="setFontAlignL(this)" id="l_alignleft" title="左对齐">
                                            <img src="../Content/images/alignleft.png" /></span><span onclick="setFontAlignM(this)"
                                                id="l_alignmid" title="中间对齐"><img src="../Content/images/alignmid.png" /></span><span
                                                    onclick="setFontAlignR(this)" id="l_alignright" title="右对齐"><img src="../Content/images/alignright.png" /></span>
                                    </div>
                                </li>
                                <!--字体颜色-->
                                <li>
                                    <div class="color_picker" style="margin-left: 5px;">
                                        <span style="vertical-align: middle;">字体颜色：</span><input id="color_a" title="设置字体颜色"
                                            type="text" class="input_cxcolor" readonly /></div>
                                </li>
                                <!--背景颜色-->
                                <li>
                                    <div class="color_picker" style="margin-left: 10px;">
                                        <span style="vertical-align: middle;">背景颜色：</span><input id="color_c" title="设置背景颜色"
                                            type="text" class="input_cxcolor" readonly /></div>
                                </li>
                                <!--自定义-->
                                <li>
                                    <div style="margin-left: 10px;">
                                        <a href="#" onclick="setCustomerCss(this)" title="自定义样式">自定义</a></div>
                                </li>
                            </ul>
                            <div>
                                <input type="text" style="width: 80%; display: none;" id="txtTitleLAttr" class="txtAttr"
                                    runat="server" clientidmode="Static" /></div>
                        </div>
                    </td>
                </tr>
                <tr class="ListTableOddRow">
                    <td align="center" style="border: 1px; border-style: solid; border-color: #d3d3d3;">
                        中
                    </td>
                    <td align="center" style="border: 1px; border-style: solid; border-color: #d3d3d3;">
                        <select class="selType" id="selTypeM" runat="server" clientidmode="Static">
                            <option value="-1">无</option>
                            <option value="0">文字</option>
                            <option value="1">图片</option>
                            <option value="2">时间</option>
                            <%--<option value="3">服务器时间</option>--%>
                        </select>
                    </td>
                    <td align="center" style="border: 1px; border-style: solid; border-color: #d3d3d3;">
                        <input type="text" style="width: 80%" id="txtTitleMid" class="txtContent" runat="server"
                            clientidmode="Static" />
                        <span class="btnResetType" style="cursor: pointer; color: #0000ff;">Reset</span>
                    </td>
                    <td align="left" style="border: 1px; border-style: solid; border-color: #d3d3d3;">
                        <div class="fontcss" id="cssMid">
                            <ul>
                                <!--字体-->
                                <li>
                                    <select title="选择字体">
                                        <option value="arial">Arial</option>
                                        <option value="impact">Impact</option>
                                        <option value="andale mono">andale mono</option>
                                        <option value="\u5b8b\u4f53">宋体</option>
                                        <option value="\u9ed1\u4f53">黑体</option>
                                        <option value="\u5fae\u8f6f\u96c5\u9ed1" selected="selected">微软雅黑</option>
                                        <option value="\u6977\u4f53">楷体</option>
                                    </select>
                                </li>
                                <!--字号-->
                                <li>
                                    <select title="选择字体大小">
                                        <option value="8px">8px</option>
                                        <option value="9px">9px</option>
                                        <option value="10px">10px</option>
                                        <option value="11px">11px</option>
                                        <option value="12px" selected="selected">12px</option>
                                        <option value="14px">14px</option>
                                        <option value="16px">16px</option>
                                        <option value="18px">18px</option>
                                        <option value="20px">20px</option>
                                        <option value="22px">22px</option>
                                        <option value="24px">24px</option>
                                        <option value="26px">26px</option>
                                        <option value="30px">30px</option>
                                        <option value="36px">36px</option>
                                        <option value="48px">48px</option>
                                        <option value="58px">58px</option>
                                        <option value="68px">68px</option>
                                        <option value="78px">78px</option>
                                    </select>
                                </li>
                                <!--加粗-->
                                <li>
                                    <div class="fontwiu">
                                        <span onclick="setFontWeight(this)" title="加粗">B</span><span onclick="setFontI(this)"
                                            title="倾斜"><i>I</i></span><span onclick="setFontUnderline(this)" title="下划线"><u>U</u></span></div>
                                </li>
                                <!--文字对齐-->
                                <li>
                                    <div class="textalign" id="Div1">
                                        <span onclick="setFontAlignL(this)" id="m_alignleft" title="左对齐">
                                            <img src="../Content/images/alignleft.png" /></span><span id="m_alignmid" onclick="setFontAlignM(this)"
                                                title="中间对齐"><img src="../Content/images/alignmid.png" /></span><span id="m_alignright"
                                                    onclick="setFontAlignR(this)" title="右对齐"><img src="../Content/images/alignright.png" /></span>
                                    </div>
                                </li>
                                <!--字体颜色-->
                                <li>
                                    <div class="color_picker" style="margin-left: 5px;">
                                        <span style="vertical-align: middle;">字体颜色：</span><input id="color_ma_font" title="设置字体颜色"
                                            type="text" class="input_cxcolor" readonly /></div>
                                </li>
                                <!--背景颜色-->
                                <li>
                                    <div class="color_picker" style="margin-left: 10px;">
                                        <span style="vertical-align: middle;">背景颜色：</span><input id="color_ma_bg" title="设置背景颜色"
                                            type="text" class="input_cxcolor" readonly /></div>
                                </li>
                                <!--自定义-->
                                <li>
                                    <div style="margin-left: 10px;">
                                        <a href="#" onclick="setCustomerCss(this)" title="自定义样式">自定义</a></div>
                                </li>
                            </ul>
                            <div>
                                <input type="text" style="width: 80%; display: none;" id="txtTitleMAttr" class="txtAttr"
                                    runat="server" clientidmode="Static" /></div>
                        </div>
                    </td>
                </tr>
                <tr class="ListTableOddRow">
                    <td align="center" style="border: 1px; border-style: solid; border-color: #d3d3d3;">
                        右
                    </td>
                    <td align="center" style="border: 1px; border-style: solid; border-color: #d3d3d3;">
                        <select class="selType" id="selTypeR" runat="server" clientidmode="Static">
                            <option value="-1">无</option>
                            <option value="0">文字</option>
                            <option value="1">图片</option>
                            <option value="2">时间</option>
                            <%--<option value="3">服务器时间</option>--%>
                        </select>
                    </td>
                    <td align="center" style="border: 1px; border-style: solid; border-color: #d3d3d3;">
                        <input type="text" style="width: 80%" id="txtTitleRight" class="txtContent" runat="server"
                            clientidmode="Static" />
                        <span class="btnResetType" style="cursor: pointer; color: #0000ff;">Reset</span>
                    </td>
                    <td align="left" style="border: 1px; border-style: solid; border-color: #d3d3d3;">
                        <div class="fontcss" id="cssRight">
                            <ul>
                                <!--字体-->
                                <li>
                                    <select title="选择字体">
                                        <option value="arial">Arial</option>
                                        <option value="impact">Impact</option>
                                        <option value="andale mono">andale mono</option>
                                        <option value="\u5b8b\u4f53">宋体</option>
                                        <option value="\u9ed1\u4f53">黑体</option>
                                        <option value="\u5fae\u8f6f\u96c5\u9ed1" selected="selected">微软雅黑</option>
                                        <option value="\u6977\u4f53">楷体</option>
                                    </select>
                                </li>
                                <!--字号-->
                                <li>
                                    <select title="选择字体大小">
                                        <option value="8px">8px</option>
                                        <option value="9px">9px</option>
                                        <option value="10px">10px</option>
                                        <option value="11px">11px</option>
                                        <option value="12px" selected="selected">12px</option>
                                        <option value="14px">14px</option>
                                        <option value="16px">16px</option>
                                        <option value="18px">18px</option>
                                        <option value="20px">20px</option>
                                        <option value="22px">22px</option>
                                        <option value="24px">24px</option>
                                        <option value="26px">26px</option>
                                        <option value="30px">30px</option>
                                        <option value="36px">36px</option>
                                        <option value="48px">48px</option>
                                        <option value="58px">58px</option>
                                        <option value="68px">68px</option>
                                        <option value="78px">78px</option>
                                    </select>
                                </li>
                                <!--加粗-->
                                <li>
                                    <div class="fontwiu">
                                        <span onclick="setFontWeight(this)" title="加粗">B</span><span onclick="setFontI(this)"
                                            title="倾斜"><i>I</i></span><span onclick="setFontUnderline(this)" title="下划线"><u>U</u></span></div>
                                </li>
                                <!--文字对齐-->
                                <li>
                                    <div class="textalign" id="Div2">
                                        <span onclick="setFontAlignL(this)" id="r_alignleft" title="左对齐">
                                            <img src="../Content/images/alignleft.png" /></span><span onclick="setFontAlignM(this)"
                                                id="r_alignmid" title="中间对齐"><img src="../Content/images/alignmid.png" /></span><span
                                                    onclick="setFontAlignR(this)" id="r_alignright" title="右对齐"><img src="../Content/images/alignright.png" /></span>
                                    </div>
                                </li>
                                <!--字体颜色-->
                                <li>
                                    <div class="color_picker" style="margin-left: 5px;">
                                        <span style="vertical-align: middle;">字体颜色：</span><input id="color_tt_font" title="设置字体颜色"
                                            type="text" class="input_cxcolor" readonly /></div>
                                </li>
                                <!--背景颜色-->
                                <li>
                                    <div class="color_picker" style="margin-left: 10px;">
                                        <span style="vertical-align: middle;">背景颜色：</span><input id="color_tt_bg" title="设置背景颜色"
                                            type="text" class="input_cxcolor" readonly /></div>
                                </li>
                                <!--自定义-->
                                <li>
                                    <div style="margin-left: 10px;">
                                        <a href="#" onclick="setCustomerCss(this)" title="自定义样式">自定义</a></div>
                                </li>
                            </ul>
                            <div>
                                <input type="text" style="width: 80%; display: none;" id="txtTitleRAttr" class="txtAttr"
                                    runat="server" clientidmode="Static" /></div>
                        </div>
                    </td>
                </tr>
            </table>
        </div>
        <!--控件绑定-->
        <div id="divCompBind" style="text-align: center;">
            <div class="ListTableEmptyDataRow">
                请先选择容器类型</div>
         </div>
        <!--预览-->
        <div id="divDataPreV" class="divPrev " style="text-align: center;">
            <div class="ListTableEmptyDataRow">
                未能加载预览信息
            </div>
        </div>
    </div>
    <asp:HiddenField runat="server" ID="hfIcronsName" ClientIDMode="Static" />
    <asp:HiddenField runat="server" ID="hfEditOptinJS" ClientIDMode="Static" />
    <asp:HiddenField runat="server" ID="hfBackgroundCol" ClientIDMode="Static" />
    <script src="../Content/plugin/colorpicker/jquery.cxcolor.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        var contId = '<%=Request.QueryString["ID"] %>';
        var user = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
        var picRootPath = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/Kanban/LayoutIcron/";
        var chosingObj, chosingData;
        var rowObj = {};
        var winHeight = $(document.body).height() - 25; //        浏览器当前窗口文档body的高度： 
        var winH = document.documentElement.clientHeight||document.body.offsetHeight||0;
        var winWidth = $(document.body).width() - 25; //浏览器当前窗口文档body的宽度：
        var echartDom = [];     //记录echart的DOM ID

        /*Add By Alen 2016-09-14 颜色选择器，增加获取选择的颜色的方法和设置颜色的方法：getPickerColor(),setPickerColor(clr) clr:要设置的颜色代码字符串，如：#404a59*/
        var cxColorPicker = $("#color_b").cxColor({
//            color: "#404a59"
            color: "#fff"
        });
        var cxColorPicker_a = $("#color_a").cxColor({
            color: "#000000"
        });
        var cxColorPicker_c = $("#color_c").cxColor({
            color: "#fff"
        });
        var cxColorPicker_ma_font = $("#color_ma_font").cxColor({
            color: "#000000"
        });
        var cxColorPicker_ma_bg = $("#color_ma_bg").cxColor({
            color: "#fff"
        });
        var cxColorPicker_tt_font = $("#color_tt_font").cxColor({
            color: "#000000"
        });
        var cxColorPicker_tt_bg = $("#color_tt_bg").cxColor({
            color: "#fff"
        });

        /*获取颜色选择器选中的颜色*/
        function getPickerColor() {
            return cxColorPicker.color();
        }

        /*设置颜色到选择器中*/
        function setPickerColor(clr) {
            cxColorPicker.color(clr);
        }

        /*字体样式*/
        function setFontWeight(obj) {
            $(obj).toggleClass("selected");
        }

        function setFontI(obj) {
            $(obj).toggleClass("selected");
        }

        function setFontUnderline(obj) {
            $(obj).toggleClass("selected");
        }

        function setFontAlignL(obj) {
            $("span", $(obj).parent()).removeClass("selected");
            $(obj).toggleClass("selected");
        }

        function setFontAlignM(obj) {
            $("span", $(obj).parent()).removeClass("selected")
            $(obj).toggleClass("selected");
        }

        function setFontAlignR(obj) {
            $("span", $(obj).parent()).removeClass("selected")
            $(obj).toggleClass("selected");
        }

        function setCustomerCss(obj) {
            $(obj).parent().parent().parent().parent().children("div").children("input").toggle();
        }

        /*获取样式*/
        function getTitleCss(posId) {
            var titlCssStr = "";
            $("#" + posId + " ul li").each(function (i) {
                if (i == 0) {
                    titlCssStr += "font-family:" + $("select", this).val() + ";"; /*字体*/
                }
                if (i == 1) {
                    titlCssStr += "font-size:" + $("select", this).val() + ";"; /*字号*/
                }
                if (i == 2) {
                    if ($("span:eq(0)", this).hasClass("selected")) {
                        titlCssStr += "font-weight:bold;"; /*加粗*/
                    }
                    if ($("span:eq(1)", this).hasClass("selected")) {
                        titlCssStr += "font-style:italic;"; /*倾斜*/
                    }
                    if ($("span:eq(2)", this).hasClass("selected")) {
                        titlCssStr += " text-decoration:underline;"; /*下划线*/
                    }
                }
                if (i == 3) { /*对齐*/
                    var text_align = $(".selected", this).attr("id");
                    if (text_align != undefined) {
                        text_align = text_align.substring(2);
                        switch (text_align) {
                            case 'alignleft':
                                titlCssStr += "text-align:left;";
                                break;
                            case 'alignmid':
                                titlCssStr += "text-align:center;";
                                break;
                            case 'alignright':
                                titlCssStr += "text-align:right;";
                                break;
                            default:
                                break;
                        }
                    }
                }
                if (i == 4) { /*字体颜色*/
                    switch (posId) {
                        case 'cssLeft':
                            titlCssStr += "color:" + cxColorPicker_a.color() + ";";
                            break;
                        case 'cssMid':
                            titlCssStr += "color:" + cxColorPicker_ma_font.color() + ";";
                            break;
                        case 'cssRight':
                            titlCssStr += "color:" + cxColorPicker_tt_font.color() + ";";
                            break;
                        default:
                            break;
                    }
                }
                if (i == 5) { /*背景颜色*/
                    switch (posId) {
                        case 'cssLeft':
                            titlCssStr += "background:" + cxColorPicker_c.color() + ";";
                            break;
                        case 'cssMid':
                            titlCssStr += "background:" + cxColorPicker_ma_bg.color() + ";";
                            break;
                        case 'cssRight':
                            titlCssStr += "background:" + cxColorPicker_tt_bg.color() + ";";
                            break;
                        default:
                            break;
                    }
                }
            });
            return titlCssStr;
        }

        /*设置样式*/
        function setTitleCss(posId, titleCssString) {
            var cssArr = titleCssString.split(";");
            var titlCssStr = "";
            $("#" + posId + " ul li").each(function (i) {
                if (i == 0) {
                    for (var _i = 0, _j = cssArr.length; _i < _j; _i++) {
                        if (cssArr[_i] != "" && cssArr[_i].substring(0, cssArr[_i].indexOf(":")) == "font-family") {
                            $("select", this).val(cssArr[_i].substring(cssArr[_i].indexOf(":") + 1)) /*字体*/
                            break;
                        }
                    }
                }
                if (i == 1) {
                    for (var _i = 0, _j = cssArr.length; _i < _j; _i++) {
                        if (cssArr[_i] != "" && cssArr[_i].substring(0, cssArr[_i].indexOf(":")) == "font-size") {
                            $("select", this).val(cssArr[_i].substring(cssArr[_i].indexOf(":") + 1)) /*字号*/
                            break;
                        }
                    }
                }
                if (i == 2) {
                    for (var _i = 0, _j = cssArr.length; _i < _j; _i++) {
                        if (cssArr[_i] != "" && $.trim(cssArr[_i].substring(0, cssArr[_i].indexOf(":"))) == "font-weight") {
                            $("span:eq(0)", this).addClass("selected"); /*加粗*/
                        }
                        else if (cssArr[_i] != "" && $.trim(cssArr[_i].substring(0, cssArr[_i].indexOf(":"))) == "font-style") {
                            $("span:eq(1)", this).addClass("selected"); /*倾斜*/
                        }
                        else if (cssArr[_i] != "" && $.trim(cssArr[_i].substring(0, cssArr[_i].indexOf(":"))) == "text-decoration") {
                            $("span:eq(2)", this).addClass("selected"); /*下划线*/
                        }
                    }
                }
                var p = posId.replace("css", "");
                if (i == 3) { /*对齐*/
                    for (var _i = 0, _j = cssArr.length; _i < _j; _i++) {
                        if (cssArr[_i] != "" && $.trim(cssArr[_i].substring(0, cssArr[_i].indexOf(":"))) == "text-align") {
                            if ($.trim(cssArr[_i].substring(cssArr[_i].indexOf(":") + 1)) == "left") {
                                if (p == "Left") {
                                    $("#l_alignleft", this).addClass("selected");
                                }
                                else if (p == "Mid") {
                                    $("#m_alignleft", this).addClass("selected");
                                }
                                else if (p == "Right") {
                                    $("#r_alignleft", this).addClass("selected");
                                }
                            }
                            else if ($.trim(cssArr[_i].substring(cssArr[_i].indexOf(":") + 1)) == "center") {
                                if (p == "Left") {
                                    $("#l_alignmid", this).addClass("selected");
                                }
                                else if (p == "Mid") {
                                    $("#m_alignmid", this).addClass("selected");
                                }
                                else if (p == "Right") {
                                    $("#r_alignmid", this).addClass("selected");
                                }
                            }
                            else if ($.trim(cssArr[_i].substring(cssArr[_i].indexOf(":") + 1)) == "right") {
                                if (p == "Left") {
                                    $("#l_alignright", this).addClass("selected");
                                }
                                else if (p == "Mid") {
                                    $("#m_alignright", this).addClass("selected");
                                }
                                else if (p == "Right") {
                                    $("#r_alignright", this).addClass("selected");
                                }
                            }
                        }
                    }
                }
                if (i == 4) { /*字体颜色*/
                    for (var _i = 0, _j = cssArr.length; _i < _j; _i++) {
                        if (cssArr[_i] != "" && $.trim(cssArr[_i].substring(0, cssArr[_i].indexOf(":"))) == "color") {
                            switch (posId) {
                                case 'cssLeft':
                                    cxColorPicker_a.color($.trim(cssArr[_i].substring(cssArr[_i].indexOf(":") + 1)));
                                    break;
                                case 'cssMid':
                                    cxColorPicker_ma_font.color($.trim(cssArr[_i].substring(cssArr[_i].indexOf(":") + 1)));
                                    break;
                                case 'cssRight':
                                    cxColorPicker_tt_font.color($.trim(cssArr[_i].substring(cssArr[_i].indexOf(":") + 1)));
                                    break;
                                default:
                                    break;
                            }
                            break;
                        }
                    }

                }
                if (i == 5) { /*背景颜色*/
                    for (var _i = 0, _j = cssArr.length; _i < _j; _i++) {
                        if (cssArr[_i] != "" && $.trim(cssArr[_i].substring(0, cssArr[_i].indexOf(":"))) == "background") {
                            switch (posId) {
                                case 'cssLeft':
                                    cxColorPicker_c.color($.trim(cssArr[_i].substring(cssArr[_i].indexOf(":") + 1)));
                                    break;
                                case 'cssMid':
                                    cxColorPicker_ma_bg.color($.trim(cssArr[_i].substring(cssArr[_i].indexOf(":") + 1)));
                                    break;
                                case 'cssRight':
                                    cxColorPicker_tt_bg.color($.trim(cssArr[_i].substring(cssArr[_i].indexOf(":") + 1)));
                                    break;
                                default:
                                    break;
                            }
                        }
                    }
                }
            });
        }

        $(document).ready(function () {
            $(function () {
                $(document)
                    .keydown(function (e) {
                        if (e.which == 83 && e.ctrlKey) {
                            Save();
                        }
                    });
            });

            $(".txtContent").attr("disabled", "true");
            //-------------------------------------布局图标点击事件
            $("#divShowIcron").on("click","img",
                    function () {
                        var arrName = $(this).attr("id").split('.');
                        $("#txtContType").val(arrName[0]);
                        $(".picInList").css("border", "");
                        $(this).css("border", "3px solid #E62448");
                        if (arrName[0] === 'Others') {
                            openChoosePage("contType",null,"PositionType = 1");
                        } else {
                            getContHtml(arrName[0]);    
                        }

                    });

            //-------------------------------------------------Title类型选择设计
            $("#selTypeL,#selTypeM,#selTypeR").on("change", function () {
                //定位操作行
                rowObj = this.parentElement.parentElement;
                //图片类型弹出选择框
                if ($(this).val() * 1 === 1) {
                    dialog({
                        title: "<%= Common.ChooseWindow %>",
                        src: "./ChooseImage.aspx?Folder=KanbanTitle" + Math.random(),
                        width: 680,
                        height: 380
                    });
                    $(this).parent().next().find(".txtContent").attr("disabled", "disabled");
                }
                if ($(this).val() * 1 === -1) {
                    rowObj.cells[2].children[0].value = '';
                }
                if ($(this).val() * 1 === 0) {
                    rowObj.cells[2].children[0].value = '';
                    $(this).parent().next().find(".txtContent").removeAttr("disabled");
                }
                if ($(this).val() * 1 === 2 || $(this).val() * 1 === 3) {
                    rowObj.cells[2].children[0].value = '时间:YYYY-MM-DD HH:MM:SS';
                    $(this).parent().next().find(".txtContent").attr("disabled", "disabled");
                }
            });
            //-----------------------------------------Title类型选择设计 END

            $(".btnResetType").click(function () {
                $(this).prev().val('');
                $(this).prev().attr("disabled", "true");
                $(this).parent().prev().find(".selType").val('-1');
            })

            $("#color_b").change(function () {
                $(".bodyContainer").css("background-color", getPickerColor());
            })

            initCompBind();
            showPicList(); //模板图标
            if (contId !== '-1') {
                initPage(); //初始化编辑页面信息      
            }

        })
        //=======document.ready  END

        function initPage() {
            if ($("#txtContType").val() !== "") {
                $(".picInList").css("border", "");
                $("#" + $("#txtContType").val()).css("border", "3px solid #E62448");
                getContHtml($("#txtContType").val());
            } else {
                return false;
            }

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxKanban.GetMapContainer(contId);
            if (ajax.error == null && ajax.value != null) {
                var entityAry = ajax.value;
                $('.txtCompName').each(function (key, value) {
                    $(this).val(entityAry[key].ComponentName);
                });
                $('.txtCompId').each(function (key, value) {
                    $(this).val(entityAry[key].KanbanComponentId);
                });
            } else if (ajax.error != null) {
                alert(ajax.error.Message);
            }
            //userSetting加载
            var strUset = $("#hfEditOptinJS").val();
            var objUset = $.parseJSON(strUset);
            var bodyColor = objUset.bodyColor;
            setPickerColor(bodyColor);
            $(".bodyContainer").css("background-color", bodyColor);

            /*设置看板标题左、中、右样式*/
            setTitleCss("cssLeft", $("#txtTitleLAttr").val());
            setTitleCss("cssMid", $("#txtTitleMAttr").val());
            setTitleCss("cssRight", $("#txtTitleRAttr").val());
        }

        function Save() {
            var tValueL = $("#txtTitleLeft").val();
            var tAttrL = getTitleCss("cssLeft"); //$("#txtTitleLAttr").val();
            var tValueM = $("#txtTitleMid").val();
            var tAttrM = getTitleCss("cssMid"); //$("#txtTitleMAttr").val();
            var tValueR = $("#txtTitleRight").val();
            var tAttrR = getTitleCss("cssRight"); //$("#txtTitleRAttr").val();
            var tTypeL = $("#selTypeL").val();
            var tTypeM = $("#selTypeM").val();
            var tTypeR = $("#selTypeR").val();
            var contName = $("#txtContName").val();
            var compArr = document.getElementsByName("txtCompId");
            //验证相关
            if (contName === "") {
                alert("容器命名不能为空");
                return false;
            }
            if ($("#txtContType").val() === "") {
                alert("容器类型不能为空");
                return false;
            }
            if (getTitle() === 'error') {
                return false;
            }
            var entity = {};
            entity.KanbanContainerId = contId;
            entity.LayoutType = $("#txtContType").val();
            entity.ComponentName = "";
            for (var i = 0; i < compArr.length; i++) {
                entity.ComponentName += compArr[i].value + ',';
            }
            entity.ComponentName = entity.ComponentName.slice(0, -1);
            entity.ContainerName = contName;
            entity.Remark = $("#txtRemark").val();
            entity.EditOption = getUserSetting();
            entity.TitleLValue = tValueL;
            entity.TitleLCss = tAttrL;
            entity.TitleMValue = tValueM;
            entity.TitleMCss = tAttrM;
            entity.TitleRValue = tValueR;
            entity.TitleRCss = tAttrR;
            entity.TitleLType = tTypeL;
            entity.TitleMType = tTypeM;
            entity.TitleRType = tTypeR;
            entity.Title = getTitle();
            entity.CreateBy = user;
            entity.ModifyBy = user;
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxKanban.EditContainer(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            } else {
                alert("<%=Resources.Messages.SaveInSuccess %>");
                window.parent.UpdateList(contName);
            }
        }

        function getUserSetting() {
            var usObj = {};
            usObj.bodyColor = getPickerColor();
            //usObj.bodyFontSize = _compTFontSize;
            var strUserSetting = JSON.stringify(usObj);
            return strUserSetting;
        }

        function openChoosePage(obj, e ,condition) {
            var searchSettings = condition?condition:"";
            chosingObj = e;
            if (obj === 'contType') {
                chosingData = 'contType';
                dialog({ title: "<%=Resources.Common.ChooseWindow %>"
                , src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=70&Multiple=false&CallBackFunc=getChooseValue&PageCondition=" + searchSettings + "&rnd=" + Math.random()
                , width: 600, height: 300
                });
            }
            if (obj === 'comp') {
                chosingData = 'comp';
                dialog({ title: "<%=Resources.Common.ChooseWindow %>"
                , src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=71&Multiple=false&CallBackFunc=getChooseValue&PageCondition=" + searchSettings + "&rnd=" + Math.random()
                , width: 600, height: 300
                });
            }

        }
        function getChooseValue(list) {
            if (chosingData === 'contType') {
                $("#<%=this.txtContType.ClientID %>").val(list[0][1]);
                $("#<%=this.hfContTypeID.ClientID %>").val(list[0][0]);

                if ($("#" + list[0][1]).length) {
                    $(".picInList").css("border", "");
                    $("#" + list[0][1]).css("border", "3px solid #E62448");
                }
                getContHtml(list[0][1]);
            }
            if (chosingData === 'comp') {
                $(chosingObj).siblings(".txtCompId").val(list[0][0]);
                $(chosingObj).siblings(".txtCompName").val(list[0][1]);
                if (list[0][0] === '-1') {          //Fix BirongLiang 2017-1-11 点击清空后清空相关赋值
                    $(chosingObj).siblings(".txtCompId").val('');
                    $(chosingObj).siblings(".txtCompName").val('');
                }
            } 

        }

        function getImage(img) {
            rowObj.cells[2].children[0].value = img;
        }

        function showPicList() {
            var strList = $("#hfIcronsName").val();
            var objList = JSON.parse(strList);
            var strHtml = "<ul>";
            for (var i = 0; i < objList.length; i++) {
                var arrItem = objList[i].split('.');
                strHtml += "<li style='display:inline;padding:20px '><div style='display: inline-block;;padding:10px'>" +
                "<a href='#'><img class='picInList' id='" + arrItem[0] + "' src='" + picRootPath + objList[i] + "'></a>" +
                "</div></li>";
            }

            strHtml += "</ul>";
            $("#divShowIcron").html(strHtml);
        }

        function initCompBind() {
            $(".contUnit")
                .html('<div style=" margin:auto auto;"><input type="text" class="txtCompId" name="txtCompId" style="display: none" />' +
                    '<input type="text" class="txtCompName" name="txtCompName" style="width: 150px; height:24px;" readonly="readonly" />' +
                    '<input type="button" class="ButtonBox btnComp" ' +
                        'style="width:65px; line-height:12px; background:#ccc;font-size:12px; "' +
                        'value="选择控件" title="点击选择控件"' +
                    ' onclick="openChoosePage(\'comp\',this);" /> <input type="button"  class="AdaptButton"  style="margin:2px;width:80px;border:1px;" value="新增控件" onclick="AddControls()" /></div>');
        }

        function getContHtml(type) {
            if (type === 'undefined' || type === "") {
                alert("未能获取容器类型，描绘版面失败");
                return false;
            }
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxKanban.GetContainerHtml(type);
            var objResult = JSON.parse(ajax.value);
            console.log(objResult);
            var contHtml = objResult[0].RawCode;
            var posType = objResult[0].PositionType;   //是否绝对定位，判断生成容器布局是否需要设置高宽,=1不需要
            $("#divCompBind").html(contHtml);     //描绘绑定框架
            initCompBind();                     //绑定框架数据源选择
            $("#divDataPreV").html(contHtml); //描绘预览
            $(".bodyContainer").css("background-color", getPickerColor());
            setUnitAttrInPreV(posType); //设置预览控件所在ID、高宽数值

        }

        function setUnitAttrInPreV(posFlag) {
            var compWidthArr = [];
            var sumCompWidth = 0;
            var unitHeight = 0;
//            alert(winHeight)
//            alert(winH)
            //循环体1，取值计算
            $('.txtCompId').each(function (key, value) {
                //计算每个comp高度
                //alert($(this).parent().parent(".contUnit").css("width"))
                sumCompWidth += $(this).parent().parent(".contUnit").css("width").slice(0, -1) * 0.01 * winWidth;
                compWidthArr[key] = $(this).parent().parent(".contUnit").css("width").slice(0, -1) * 0.01 * winWidth;
            });
            var r = Math.ceil(sumCompWidth / winWidth);
            unitHeight = Math.round(winH / r) - 20;
            
            //循环体2，赋值
            for (var i = 0; i < compWidthArr.length; i++) {
                //设置ID
                $("#divDataPreV").find(".contUnit").eq(i).attr("id", "divShowComp" + i);
                $("#divDataPreV").find(".contUnit").eq(i).addClass("showUnit");
                $("#divShowComp" + i).css("padding", "5px");
                //设置div长宽（echart必须）@2016-09-26只需要高度
                //$("#divShowComp" + i).css("height", unitHeight);
                if (posFlag * 1 === 0) {
                    $(".contUnit").css("height", unitHeight);
                } else {
                    $(".containerbody").css("height", winH);
                }
            }

        }

        //预览按钮
        $("#showPrv").click(function () {
            $(".titleContainer").remove();
            $(".bodyContainer").css("background-color", getPickerColor());
            var titleCode = getTitle();
            if (titleCode == 'error') {
                return false;
            }
            if ($(".showUnit").length > 0) {
                $(".showUnit").html("");
            }
            $("#divDataPreV").prepend(titleCode); //标题
            $(".titleContainer").css("background-color", getPickerColor());
            showClock();

            /**
            在多个标签页里，那些初始隐藏的标签在初始化图表的时候因为获取不到容器的实际高宽，
            可能会绘制失败，因此在切换到该标签页时需要手动调用 resize 方法获取正确的高宽并且刷新画布。**/
            echartDom = [];             //clear echart dom
            //$.when($("#divShowComp0").width()>0).done(showComponents);
            showComponents();
            setTimeout(echartResize, 100);
        })

        function showComponents() {
            var compData = [];
            var compObjArr = [];
            var ajax;
            $('.txtCompId').each(function (key, value) {
                compData[key] = $(this).val();
            });
            for (var i = 0; i < compData.length; i++) {
                var ajaxResult = [{ DataSource: null, Param1: null, Param2: null, compRe: null, compEditOption: null, compDOM: null}];
                if (compData[i] !== "" && compData[i] !== "0") {
                    ajax = SKT.LeanMES.Web.AjaxServices.AjaxKanban.GetCompParamById(compData[i]);
                    ajaxResult = ajax.value;
                    if (ajax.value === null || ajax.value.error !== null) {
                        //return false;
                    }
                }
                compObjArr.push({
                    "compData": ajaxResult[0].DataSource == null ? '' : ajaxResult[0].DataSource,
                    "compDsType": ajaxResult[0].SourceType,
                    "compPara1": ajaxResult[0].Param1 == null ? '' : ajaxResult[0].Param1,
                    "compPara2": ajaxResult[0].Param2 == null ? '' : ajaxResult[0].Param2,
                    "compRe": ajaxResult[0].RefreshSec == null ? '' : ajaxResult[0].RefreshSec,
                    "compEditOption": ajaxResult[0].EditOption == null ? '' : ajaxResult[0].EditOption,
                    "compDOM": "divShowComp" + i
                });
                if (ajaxResult[0].Param2 === 'echart') {
                    showChart(compObjArr[i]);
                    echartDom.push(compObjArr[i].compDOM);     //save echart dom id
                    //echartResize();
                }
                if (ajaxResult[0].Param2 === 'text') {
                    showText(compObjArr[i]);
                }
                if (ajaxResult[0].Param2 === 'web') {
                    showPage(compObjArr[i]);
                }
                if (ajaxResult[0].Param2 === 'table') {
                    showTable(compObjArr[i]);
                }
                if (ajaxResult[0].Param2 === 'highchart') {
                    showHightChart(compObjArr[i]);
                }
            }
        }
        
        function showChart(paraObj) {
            var defTheme = getCompTheme();
            var _table = paraObj.compData;
            var _compChartType = paraObj.compPara1;
            var compEditOption = $.parseJSON(paraObj.compEditOption);
            var _compTitle = compEditOption.titleText;
            var compTheme = compEditOption.compTheme * 1; //获取所选主题号码
            var backgroundColor = defTheme.backgroundColor[compTheme];
            var textStyle = defTheme.textStyle[compTheme];
            var titleStyle = defTheme.titleStyle[compTheme];
            var titleSize = compEditOption.titleSize * 1;
            var titleLoc = compEditOption.titleLoc;
            var lineStyle = defTheme.lineStyle[compTheme];

            var showDom = paraObj.compDOM;
            //var ajxService = SKT.LeanMES.Web.AjaxServices.AjaxKanban.GetDataJson(_table);
            var procParas = compEditOption.dsParas == null ? '' : compEditOption.dsParas;
            var ajxService = ExecProc(_table, procParas);

            var strJson = ajxService.value;
            //console.log(strJson);
            var dataObj = $.parseJSON(strJson);
            if (dataObj === null || !dataObj[0] || dataObj[0].length <= 1) {
                //console.log(_table + "数据为空");
                return;
            }
            var objLen = dataObj.length;
            var dataGroup = -1;      //数据集数量(列名),从-1开始因为第一列是XLabel
            var atrName = [];       //存放数据属性名
            var oneDimensionData = [];    //一维数据类型   [{name:XXX,value:xxx}]
            for (var attr in dataObj[0]) {
                atrName.push(attr);
                dataGroup++;
            }
            var mySeries = [];
            var dataSet = [];     //数据集数组(二维数组)
            var xLabel = [];                        //X轴标示
            if (_compChartType === 'pie' || _compChartType === 'funnel' || _compChartType === 'gauge') {
                dataGroup = 1;      //一维数据的chart类型，数据集只拿一次
            }
            for (var d = 0; d <= dataGroup; d++) {
                var ts = [];
                for (var i = 0; i < objLen; i++) {
                    if (d === 0) {
                        xLabel.push(dataObj[i][atrName[0]]); //每{}第一属性}
                    } else {
                        ts.push(dataObj[i][atrName[d]]);    //构造 Y-Value
                        oneDimensionData.push({
                            name: dataObj[i][atrName[0]], value: dataObj[i][atrName[d]]
                        });
                    }
                }
                if (d > 0) {
                    dataSet.push(ts);              //构造 dataSet
                    mySeries.push({ name: atrName[d], type: _compChartType, data: ts });
                }
            }
            var myChart = echarts.getInstanceByDom(document.getElementById(showDom));
            //if (!myChart) {
                myChart = echarts.init(document.getElementById(showDom));
            //}
            // 指定图表的配置项和数据
            var option = {
                backgroundColor: backgroundColor,
                textStyle: textStyle,
                title: {
                    text: _compTitle,
                    textStyle: titleStyle,
                    left: titleLoc,
                    subtext: ''
                },
                tooltip: {},
                xAxis: null,
                yAxis: null
                //series: mySeries
            };
            option.title.textStyle.fontSize = titleSize; //titleSize

            switch (_compChartType) {
                case 'line':
                    option.xAxis = { data: xLabel, axisLine: { lineStyle: lineStyle} };
                    option.yAxis = { axisLine: { lineStyle: lineStyle} };
                    option.series = mySeries;
                    break;
                case 'bar':
                    option.xAxis = { data: xLabel, axisLine: { lineStyle: lineStyle} };
                    option.yAxis = { axisLine: { lineStyle: lineStyle} };
                    option.series = mySeries;
                    break;
                case 'pie':
                    option.series = { name: atrName[0], type: _compChartType, data: oneDimensionData };
                    break;
                case 'gauge': //仪表盘
                    option.series = { name: atrName[0], type: _compChartType, data: oneDimensionData };
                    break;
                case 'funnel':
                    option.series = { name: atrName[0], type: _compChartType, data: oneDimensionData };
                    break;
                default:
                    {
                        alert("未支持的类型");
                        return false;
                    }
            }
            myChart.setOption(option);
            myChart.resize();
        }

        function showHightChart(paraObj) {
            var defTheme = getCompTheme();
            var dataSource = paraObj.compData;                              //默认主题配色
            var compChartType = paraObj.compPara1;                     //控件类型：column，pie
            var compEditOption = $.parseJSON(paraObj.compEditOption);   //用户配置内容
            var compTitle = compEditOption.titleText;                  //标题
            var showDom = paraObj.compDOM;                                  //生成chart的DOM节点
            //var ajxService = SKT.LeanMES.Web.AjaxServices.AjaxKanban.GetDataJson(dataSource);
            var procParas = compEditOption.dsParas == null ? '' : compEditOption.dsParas;
            var ajxService = ExecProc(dataSource, procParas);

            var strJson = ajxService.value;
            var dataObj = $.parseJSON(strJson);
            if (!dataObj[0] || dataObj[0].length <= 1) {
                //console.log(dataSource + "数据为空");
                return;
            }
            var objLen = dataObj.length;
            var dataGroup = -1;      //数据集数量(列名),从-1开始因为第一列是XLabel
            var atrName = [];       //存放数据属性名
            var oneDimensionData = [];    //一维数据类型   [{name:XXX,value:xxx}]

            for (var attr in dataObj[0]) {
                atrName.push(attr);
                dataGroup++;
            }
            var mySeries = [];
            var dataSet = [];     //数据集数组(二维数组)
            var xLabel = [];       //X轴标示
            var myOption3D = {};    //3D参数设置
            for (var d = 0; d <= dataGroup; d++) {
                var ts = [];
                for (var i = 0; i < objLen; i++) {
                    if (d === 0) {
                        xLabel.push(dataObj[i][atrName[0]]); //每{}第一属性}
                    } else {
                        ts.push(dataObj[i][atrName[d]] * 1);    //构造 Y-Value  转换成数字数组2017-1-22 by BirongLiang
                        if (d <= 1) {       //一维数据集
                            oneDimensionData.push(
                            [dataObj[i][atrName[0]], dataObj[i][atrName[d]] * 1]
                        );
                        }
                    }
                }
                if (d > 0) {
                    dataSet.push(ts);              //构造 dataSet
                    mySeries.push({ name: atrName[d], data: ts });
                }
            }

            switch (compChartType) {
                case 'column':
                    //mySeries = mySeries;
                    myOption3D = {
                        enabled: true,
                        alpha: 15,
                        beta: 15,
                        depth: 50,
                        viewDistance: 25
                    };
                    break;
                case 'pie':
                    mySeries = [{ type: compChartType, data: oneDimensionData}];
                    myOption3D = {
                        enabled: true,
                        alpha: 45,
                        beta: 0
                    };
                    break;
                default:
                    {
                        alert("未支持的类型");
                        return false;
                    }
            }

            var chart = new Highcharts.Chart({
                chart: {
                    renderTo: showDom,          //图表位置 DOM 
                    type: compChartType,        //图类型
                    options3d: myOption3D       //3D参数设置
                },
                title: {
                    text: compTitle
                },
                subtitle: {
                    //text: '副标题'
                },
                plotOptions: {
                    column: {       //柱形图设置
                        depth: 35
                    },
                    pie: {          //饼状图设置
                        allowPointSelect: true,
                        cursor: 'pointer',
                        depth: 35,
                        dataLabels: {
                            enabled: true,
                            format: '{point.name}'
                        }
                    }
                },
                xAxis: {
                    categories: xLabel
                },

                yAxis: {
                    allowDecimals: true,  //坐标轴上是否允许小数。
                    min: 0,
                    title: {
                        text: '' //Y轴标题
                    }
                },
                series: mySeries            //数据主体赋值
            });
        }

        function showText(paraObj) {
            var myData = paraObj.compData;
            //var compEditOption = $.parseJSON(paraObj.compEditOption);
            var showDom = paraObj.compDOM;
            $("#" + showDom).html(myData);
        }

        function showPage(paraObj) {
            var myData = paraObj.compData;
            //var _compEditOption = $.parseJSON(paraObj.compEditOption);
            var showDom = paraObj.compDOM;
            $("#" + showDom).html("<iframe style='width:100%;height:100%' src='" + myData + "'></iframe>");
        }

        function showTable(paraObj) {
            var myTable = paraObj.compData;
            var compEditOption = $.parseJSON(paraObj.compEditOption);
            var defTheme = getCompTheme();
            var compTheme = compEditOption.compTheme * 1;
            var backgroundColor = defTheme.backgroundColor[compTheme];
            var fontColor = defTheme.textStyle[compTheme].color;
            var dsType = paraObj.compDsType;            //数据源类型
            var pageSize = compEditOption.showRowNum * 1;               //每页显示行数
            var titleSize = compEditOption.titleSize;
            var titleLoc = compEditOption.titleLoc; //not use
            var tbHeadCss = compEditOption.tHeadCss;
            var showDom = paraObj.compDOM;
            var tableEvenColor = defTheme.tableEven[compTheme].color;
            var procParas = compEditOption.dsParas == null ? '' : compEditOption.dsParas;
            var ajxService;
            if (dsType.toLowerCase() === 'procedure') {
                //ajxService = SKT.LeanMES.Web.AjaxServices.AjaxKanban.GetDataJson(myTable);
                ajxService = ExecProc(myTable, procParas);
            } else {
                ajxService = SKT.LeanMES.Web.AjaxServices.AjaxKanban.GetTabelByPager(0, pageSize, myTable);
            }
            var strJson = ajxService.value;

            //console.log(strJson);
            var dataObj = $.parseJSON(strJson);
            if (dataObj === null || !dataObj[0] || dataObj[0].length <= 1) {
                //console.log(myTable + "数据为空");
                return;
            }
            var myHtml = "<table width='100%' class=' table table-bordered table-striped' " +
                "style='background-color: " + backgroundColor + ";color: " + fontColor + "'>" +
                "<tr style='font-size: " + titleSize + "px;" + tbHeadCss + "'>";
            var objLen = dataObj.length;
            var dataGroup = 0;
            var atrName = [];       // 列名
            for (var attr in dataObj[0]) {
                atrName.push(attr);
                dataGroup++;
                myHtml += "<th>" + attr + "</th>";
            }

            myHtml += "</tr><tbody>";
            for (var r = 0; r < objLen; r++) {
                if (r % 2 == 1) {
                    myHtml += "<tr class='' style='background-color:" + tableEvenColor + "'>";

                } else {
                    myHtml += "<tr class=''>";
                }
                for (var c = 0; c < atrName.length; c++) {
                    myHtml += "<td>" + dataObj[r][atrName[c]] + "</td>";
                }
                myHtml += "</tr>";
            }
            myHtml += "</tbody></table>";
            $("#" + showDom).html(myHtml);
        }

        function getTitle() {
            var strHtml = '<div class="container-fluid titleContainer" style="padding:0px;margin:0px">' +
                '<div class="row" style="vertical-align:middle;margin:0px;line-height:45px;">' +
                '<div id ="divTitle" class="col-md-12 col-sm-12 divTitle">';
            var leftType, leftValue, leftCss;
            var midType, midValue, midCss;
            var rightType, rightValue, rightCss;
            leftType = $("#selTypeL").val();
            leftValue = $("#txtTitleLeft").val();
            leftCss = getTitleCss("cssLeft");  //$("#txtTitleLAttr").val();
            midType = $("#selTypeM").val();
            midValue = $("#txtTitleMid").val();
            midCss = getTitleCss("cssMid");  //$("#txtTitleMAttr").val();
            rightType = $("#selTypeR").val();
            rightValue = $("#txtTitleRight").val();
            rightCss = getTitleCss("cssRight");  //$("#txtTitleRAttr").val();
            var tCount = 0;
            var tArr = [leftType, midType, rightType];
            for (var t = 0; t < tArr.length; t++) {
                if (tArr[t] == '2') {
                    tCount = tCount + 1;
                }
            }
            if (tCount > 1) {
                alert('只能设置一个时间类型');
                return 'error';
            }
            strHtml += ' <div class="divL col-md-4 col-sm-4" style="' + leftCss + '">';
            switch (leftType) {
                case '0':  //文字
                    strHtml += leftValue;
                    break;
                case '1':  //图片
                    strHtml += '<img src="' + leftValue + '" style="line-height:45px;">';
                    break;
                case '2':  //时间
                    strHtml += '<div class="showTimeNow contTime localTime"></div>';
                    break;
                case '3':  //服务器时间
                    strHtml += '<div class="showTimeNow contTime serverTime"></div>';
                    break;
            }
            strHtml += ' </div><div class="divM col-md-4 col-sm-4" style="' + midCss + '">';
            switch (midType) {
                case '0':  //文字
                    strHtml += midValue;
                    break;
                case '1':  //图片
                    strHtml += '<img src="' + midValue + '">';
                    break;
                case '2':  //时间
                    strHtml += '<div class="showTimeNow contTime localTime"></div>';
                    break;
                case '3':  //服务器时间
                    strHtml += '<div class="showTimeNow contTime serverTime"></div>';
                    break;
            }
            strHtml += ' </div><div class="divR col-md-4 col-sm-4" style="' + rightCss + '">';
            switch (rightType) {
                case '0':  //文字
                    strHtml += rightValue + ' ';
                    break;
                case '1':  //图片
                    strHtml += '<img src="' + rightValue + '">';
                    break;
                case '2':  //时间
                    strHtml += '<div class="showTimeNow contTime localTime"></div>';
                    break;
                case '3':  //服务器时间
                    strHtml += '<div class="showTimeNow contTime serverTime"></div>';
                    break;
            }
            strHtml += ' </div></div></div></div>';
            return strHtml;
        }

        function showClock(userStyle) {
            if ($(".showTimeNow").length === 0) {
                return;
            }
            var clockCss = typeof userStyle != "string" ? '' : userStyle;
            var clockHtml = '<div class="clock contClock" style="' + clockCss + '">' +
            //'<div id="DateContainer"></div>' +
                '<ul style="margin:0 auto; padding:0px; list-style:none; text-align:center;">' +
            //                '<li id="DateContainer"></li>' +
                '<li class="Date"></li>' +
                '<li class="hours"></li>' +
                '<li id="point">:</li><li class="min"> </li>' +
                '<li id="point">:</li><li class="sec"> </li>' +
                '</ul>' +
                '</div>';
            $(".showTimeNow").html(clockHtml);

            var monthNames = ["1月", "2月", "3月", "4月", "5月", "6月", "7月", "8月", "9月", "10月", "11月", "12月"];
            var dayNames = ["星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"];

            // 创建一个日期对象
            var newDate = new Date();
            newDate.setDate(newDate.getDate());

            // 输出年月日
            //$('#DateContainer').html(newDate.getFullYear() + "年 " + monthNames[newDate.getMonth()] + ' ' + newDate.getDate() + '日 ' + dayNames[newDate.getDay()]);
            $('.Date').html(newDate.getFullYear() + "年 " + monthNames[newDate.getMonth()] + ' ' + newDate.getDate() + '日 ' + dayNames[newDate.getDay()]);

            setInterval(function () {
                //创建时间对象，并取得当前时间的秒数值
                var seconds = new Date().getSeconds();
                $(".sec").html((seconds < 10 ? "0" : "") + seconds);
            }, 1000);

            setInterval(function () {
                // 取得当前时间的分钟数值
                var minutes = new Date().getMinutes();
                $(".min").html((minutes < 10 ? "0" : "") + minutes);
            }, 1000);

            setInterval(function () {
                var hours = new Date().getHours();
                $(".hours").html((hours < 10 ? "0" : "") + hours);
            }, 1000);
        }
        
        function echartResize() {
            //Birong@20160928添加echart的resize事件
            if (echartDom.length > 0) {
                $('.contUnit')
                    .each(function (k) {
                        var myEchart = echarts.getInstanceByDom(document.getElementById(echartDom[k]));
                        myEchart.resize();
                    });
            }
        }
        function getCompTheme() {
            //控件主题配色，默认无色，第二个深色
            var titleSize = [18, 28, 38];
            var compTheme = {
                backgroundColor: ['', '#2c343c'],
                textStyle: [{ color: '#333' }, { color: '#ccc'}],
                titleStyle: [{ color: '#333' }, { color: '#ccc'}],
                lineStyle: [{ color: '#333' }, { color: '#eee'}],      // lineStyle1{},lineStyle2{}
                tableEven: [{ color: '#FFFFE0' }, { color: '#424242;'}]    //表格的隔行换色 IE8不支持CSS3
            }
            return compTheme;
        }
        //BirongLiang 存储过程数据源更新为支持参数运行 2017-3-22
        var ExecProc = function (procName,paras) {
            if (procName == null || procName ==='') return '';
            var dsParas = paras;
            return SKT.LeanMES.Web.AjaxServices.AjaxKanban.GetKanbanProcData(procName, dsParas);
        }

        function jqUiAction() {
            if ($(".contUnit").length === 0) return;
            /*和tab控件不兼容*/
            //$("#divDataPreV .contUnit").draggable();
            //$(".contUnit").resizable();
        }

       function AddControls(){            
           openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Kanban/ComponentEdit.aspx?name=ComponentAdd&ID=-1&IsRefresh=1";
           dialog({ title: "新增控件", src: openWinUrl, width:700, height: 650 });
  
        }

        function InputGRNResultBckFunction(){
             closeDialog();
        }
         
    </script>
</asp:Content>
