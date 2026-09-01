<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/EditMaster.master"
    CodeBehind="KanbanTemplateEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Kanban.KanbanTemplateEdit" %>

<%@ Import Namespace="Resources" %>
<%@ Import Namespace="SKT.LeanMES.Web" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <link href="../Content/plugin/colorpicker/css/jquery.cxcolor.css" rel="stylesheet"
        type="text/css" />
    <script src="../Content/plugin/colorpicker/jquery.cxcolor.min.js" type="text/javascript"></script>
    <style type="text/css">
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
        .table > tbody > tr > td, .table > tbody > tr > th, .table > tfoot > tr > td, .table > tfoot > tr > th, .table > thead > tr > td, .table > thead > tr > th
        {
            padding: 8px;
            vertical-align: top;
            border-top: 1px solid #ddd;
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
    </style>
    <div class="wrap_tb">
        <ul class="tb">
            <li class="current">看板信息</li>
            <li>看板设计</li>
        </ul>
        <div class="tb_c">
            <div class="infoTips">
                <%=Resources.Messages.WithAsteriskIsRequired %>
            </div>
            <table width="100%" class="EditeContentTable">
                <tr class="ReportInfo">
                    <td class="Label1">
                        看板名称(中文)<em>*</em>
                    </td>
                    <td class="Field1">
                        <asp:TextBox ID="txtReportCNName" runat="server" CssClass="TextBox" MaxLength="20" IsRequired="1" 
                            ClientIDMode="Static"></asp:TextBox>
                        <asp:HiddenField ID="hdnReportName" runat="server" />
                    </td>
                </tr>
                <tr class="ReportInfo">
                    <td class="Label1">
                        看板名称(英文)<em>*</em>
                    </td>
                    <td class="Field1">
                        <asp:TextBox ID="txtReportENName" runat="server" CssClass="TextBox" MaxLength="20" IsRequired="1" ClientIDMode="Static"></asp:TextBox>
                    </td>
                </tr>
                <tr class="ReportInfo">
                    <td class="Label1">
                        看板图标
                    </td>
                    <td class="Field1">
                        <span id="reportIcon" style="vertical-align: middle">无</span><span style="margin-left: 5px;"><a
                            href="javascript:void(0)" onclick="chooseIcon();">选择图标</a></span>
                        <asp:HiddenField ID="hdnIcon" runat="server" />
                    </td>
                </tr>
                <tr class="ReportInfo">
                    <td class="Label1">
                        <%=Resources.lang.Sequence %>
                    </td>
                    <td class="Field1">
                        <asp:TextBox ID="txtSequence" runat="server" CssClass="NumericBox50" Text="0" onkeyup="this.value=this.value.replace(/\D/g,'')"
                            onafterpaste="this.value=this.value.replace(/\D/g,'')"></asp:TextBox>
                    </td>
                </tr>
                <tr class="ReportInfo">
                    <td class="Label1">
                        看板类型<em>*</em>
                    </td>
                    <td class="Field1" id="tdSelType">
                        <%--                        <SKTControl:ReportDDL runat="server" ID="ddlReport" ClientIDMode="Static">
                        </SKTControl:ReportDDL>--%>
                    </td>
                </tr>
                <tr class="ReportInfo">
                    <td class="Label1">
                        <%=Resources.lang.Description %>
                    </td>
                    <td class="Field1">
                        <asp:TextBox ID="txtTmplDesc" runat="server" CssClass="TextArea" TextMode="MultiLine"></asp:TextBox><br/><input type="button"  value="看板穿越" id="btnKanbanAcross"  style="margin:3px;"/><img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAA3ElEQVQ4T6WTUQ3CQBBEXx0gAQlIwAF88gkOkIAEHFD++AMcIAEJSEACec0d2RzX0qSTXNJeZmdnt9OGiWgm1tMnMANWwDw1eAF34F02rAlsgT3QAs9UsAC8P6b7r04pIMmzrnTT1S0JKN4hCkh4AMui2CIdOcYPJwrYWYI2IzbAJVwo5i46F1HgkBzoIsPuiuoqw2eP/L8C7sIFduSEXoHaCBb6JXSS0TtCbYmO47w6EYNLlFB+Ru3nLFh8Bc4xC0NBOhVB2o0JUp7TbtqOUXYPo6JcxGD4dfLf+AGA3TQRRJP8MgAAAABJRU5ErkJggg==" title="看板穿越功能是为了方便切换终端设备上显示的看板而设计的,通过将要穿越到的终端设备的MAC地址维护在上面的【描述】中，格式:{00-00-00-00-00-00},点击穿越按钮5分钟后所对应的终端设备自动切换显示此看板。"/>
                    </td>
                </tr>
            </table>
        </div>
        <!--设计编辑-->
        <div>
            <div class="divHeader">
                <h3>
                    看板头部设计：
                </h3>
            </div>
            <!--头部设计table-->
            <table width="100%" class="EditeContentTable" id="tbHeadEdit" cellspacing="0" cellpadding="4"
                style="border-width: 0px; min-width: 560px; width: 100%; overflow: auto; border-collapse: collapse;">
                <tr class="ListTableHeader">
                    <th align="center">
                        位置
                    </th>
                    <th align="center">
                        类型
                    </th>
                    <th align="center">
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
                        </select>
                    </td>
                    <td align="center" style="border: 1px; border-style: solid; border-color: #d3d3d3;">
                        <input type="text" id="txtTitleLeft" style="width: 70%" class="txtContent"
                            runat="server" clientidmode="Static" />
                        <span class="btnResetType" style="cursor: pointer; color: #0000ff;">Reset</span>
                    </td>
                    <td align="center" style="border: 1px; border-style: solid; border-color: #d3d3d3;">
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
                                    runat="server" clientidmode="Static" />
                            </div>
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
                        </select>
                    </td>
                    <td align="center" style="border: 1px; border-style: solid; border-color: #d3d3d3;">
                        <input type="text" id="txtTitleMid" style="width: 70%" class="txtContent"
                            runat="server" clientidmode="Static" />
                        <span class="btnResetType" style="cursor: pointer; color: #0000ff;">Reset</span>
                    </td>
                    <td align="center" style="border: 1px; border-style: solid; border-color: #d3d3d3;">
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
                        </select>
                    </td>
                    <td align="center" style="border: 1px; border-style: solid; border-color: #d3d3d3;">
                        <input type="text"  id="txtTitleRight" style="width: 70%" class="txtContent"
                            runat="server" clientidmode="Static" />
                        <span class="btnResetType" style="cursor: pointer; color: #0000ff;">Reset</span>
                    </td>
                    <td align="center" style="border: 1px; border-style: solid; border-color: #d3d3d3;">
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
                                    runat="server" clientidmode="Static" />
                            </div>
                        </div>
                    </td>
                </tr>
            </table>
            <div class="divHeader">
                <h3>
                    看板尾部设计：
                </h3>
            </div>
            <!--尾部设计table-->
            <table width="100%" class="EditeContentTable" id="tbFootEdit" cellspacing="0" cellpadding="4"
                style="border-width: 0px; min-width: 560px; width: 100%; overflow: auto; border-collapse: collapse;">
                <tr class="ReportInfo">
                    <td class="Label4">
                       尾部元素(HTML)
                    </td>
                    <td class="Field4">
                        <asp:TextBox ID="txtFoot" runat="server" CssClass="TextArea"  Width="100%" TextMode="MultiLine" ClientIDMode="Static"></asp:TextBox>
                    </td>
                </tr>
            </table>
            <div class="clear5">
            </div>
            <div class="divHeader">
                <h3>
                    容器绑定：
                </h3>
            </div>
            <div id="divEdit" align="center">
                <table class="ListTable" cellspacing="0" cellpadding="4" style="border-width: 0px;
                    min-width: 560px; width: 100%; overflow: auto; border-collapse: collapse;">
                    <thead>
                        <tr class="ListTableHeader">
                            <th scope="col" align="center" style="width: 20px">
                                播放顺序
                            </th>
                            <th scope="col" align="center" style="width: 300px">
                                容器名称
                            </th>
                            <th scope="col" align="center">
                                描述
                            </th>
                            <th scope="col" align="center" style="width: 60px">
                                播放时间（秒）
                            </th>
                            <th scope="col" onclick="addContainer(null, true, this);" style="color: #0066CC;
                                cursor: pointer; width: 80px; vertical-align: middle;" align="center">
                                <img src="../Content/images/icon/Add.png" class="imgText" />
                                <%= Buttons.COM_Add %>
                            </th>
                        </tr>
                    </thead>
                    <tbody id="tbCon">
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <asp:HiddenField runat="server" ID="hfDesignJson" Value="" ClientIDMode="Static" />
    <asp:HiddenField runat="server" ID="hfRptTypeJson" ClientIDMode="Static" />
    <asp:HiddenField runat="server" ID="hfSelectedType" Value="-1" ClientIDMode="Static" />
    <script type="text/javascript">
        var reportId = '<%=Request.QueryString["ID"] %>';
        var tabCon = document.getElementById("tbCon");
        var rowObj = {};

        //2017-09-07 Alen 看板穿越
        $(function () {
            $("#btnKanbanAcross").click(function () {
                var macAddress = $("#<%=this.txtTmplDesc.ClientID%>").val();
                var kanbanName = $("#<%=this.hdnReportName.ClientID%>").val();
                if (macAddress.indexOf("}") == -1 || kanbanName == "") {
                    alert("请在备注中输入要穿越到的设备的MAC地址保存成功后，再回来此页面穿越，格式:{00-00-00-00-00-00}");
                    return false;
                }
                macAddress = macAddress.substring(1, macAddress.indexOf("}"));
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxKanban.AcrossKanban(kanbanName,macAddress);
                if (ajax.error != null)
                {
                    alert(ajax.error.Message);
                    return false;
                }
                alert("看板穿越成功，5分钟后将在对应的MAC地址中显示。");
            });
        })

        $(document).ready(function () {
            $(function () {
                $(document).keydown(function (e) {
                    if (e.which == 83 && e.ctrlKey) {
                        Save();
                    }
                });
            });
            $(".txtContent").attr("disabled", "true");
            //看板分类下拉框绑定
            setSelType($("#hfRptTypeJson").val(), $("#hfSelectedType").val()); 
            //报表类型选择事件
            $("#ddlReport").live("change", function () {                        
                $("#hfSelectedType").val($("#ddlReport").val());
            });
            //看板Title选择事件
            $(".selType").live("change", function () {
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
                    $(this).parent().next().find(".txtContent").removeAttr("disabled");
                }
                if ($(this).val() * 1 === 2) {
                    rowObj.cells[2].children[0].value = '时间:YYYY-MM-DD HH:MM:SS';
                    $(this).parent().next().find(".txtContent").attr("disabled", "disabled");
                }
            });
            //看板Title内容清空按钮
            $(".btnResetType").click(function () {
                $(this).prev().val('');
                $(this).prev().attr("disabled", "true");
                $(this).parent().prev().find(".selType").val('-1');
            })
            //编辑时加载已有信息
            if (reportId !== '-1') {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxKanban.GetMapMaster(reportId);
                if (ajax.error == null && ajax.value != null) {
                    var entityAry = ajax.value;
                    for (var i = 0; i < entityAry.length; i++) {
                        addContainer(entityAry[i], false);
                    }
                } else if (ajax.error != null) {
                    alert(ajax.error.Message);
                }
            }
            /*设置看板标题左、中、右样式*/
            setTitleCss("cssLeft", $("#txtTitleLAttr").val());
            setTitleCss("cssMid", $("#txtTitleMAttr").val());
            setTitleCss("cssRight", $("#txtTitleRAttr").val());
        });

        var cxColorPicker = $("#color_b").cxColor({
            color: "#404a59"
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
            $("span", $(obj).parent()).removeClass("selected");
            $(obj).toggleClass("selected");
        }

        function setFontAlignR(obj) {
            $("span", $(obj).parent()).removeClass("selected");
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
            $("#" + posId + " ul li")
                .each(function(i) {
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
                            if (cssArr[_i] != "" &&
                                $.trim(cssArr[_i].substring(0, cssArr[_i].indexOf(":"))) == "font-weight") {
                                $("span:eq(0)", this).addClass("selected"); /*加粗*/
                            } else if (cssArr[_i] != "" &&
                                $.trim(cssArr[_i].substring(0, cssArr[_i].indexOf(":"))) == "font-style") {
                                $("span:eq(1)", this).addClass("selected"); /*倾斜*/
                            } else if (cssArr[_i] != "" &&
                                $.trim(cssArr[_i].substring(0, cssArr[_i].indexOf(":"))) == "text-decoration") {
                                $("span:eq(2)", this).addClass("selected"); /*下划线*/
                            }
                        }
                    }
                    var p = posId.replace("css", "");
                    if (i == 3) { /*对齐*/
                        for (var _i = 0, _j = cssArr.length; _i < _j; _i++) {
                            if (cssArr[_i] != "" &&
                                    $.trim(cssArr[_i].substring(0, cssArr[_i].indexOf(":"))) == "text-align"
                            ) {
                                if ($.trim(cssArr[_i].substring(cssArr[_i].indexOf(":") + 1)) == "left") {
                                    if (p == "Left") {
                                        $("#l_alignleft", this).addClass("selected");
                                    } else if (p == "Mid") {
                                        $("#m_alignleft", this).addClass("selected");
                                    } else if (p == "Right") {
                                        $("#r_alignleft", this).addClass("selected");
                                    }
                                } else if ($.trim(cssArr[_i].substring(cssArr[_i].indexOf(":") + 1)) == "center") {
                                    if (p == "Left") {
                                        $("#l_alignmid", this).addClass("selected");
                                    } else if (p == "Mid") {
                                        $("#m_alignmid", this).addClass("selected");
                                    } else if (p == "Right") {
                                        $("#r_alignmid", this).addClass("selected");
                                    }
                                } else if ($.trim(cssArr[_i].substring(cssArr[_i].indexOf(":") + 1)) == "right") {
                                    if (p == "Left") {
                                        $("#l_alignright", this).addClass("selected");
                                    } else if (p == "Mid") {
                                        $("#m_alignright", this).addClass("selected");
                                    } else if (p == "Right") {
                                        $("#r_alignright", this).addClass("selected");
                                    }
                                }
                            }
                        }
                    }
                    if (i == 4) { /*字体颜色*/
                        for (var _i = 0, _j = cssArr.length; _i < _j; _i++) {
                            if (cssArr[_i] != "" && $.trim(cssArr[_i].substring(0, cssArr[_i].indexOf(":"))) == "color"
                            ) {
                                switch (posId) {
                                case 'cssLeft':
                                    cxColorPicker_a.color($.trim(cssArr[_i].substring(cssArr[_i].indexOf(":") + 1)));
                                    break;
                                case 'cssMid':
                                    cxColorPicker_ma_font
                                        .color($.trim(cssArr[_i].substring(cssArr[_i].indexOf(":") + 1)));
                                    break;
                                case 'cssRight':
                                    cxColorPicker_tt_font
                                        .color($.trim(cssArr[_i].substring(cssArr[_i].indexOf(":") + 1)));
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
                            if (cssArr[_i] != "" &&
                                    $.trim(cssArr[_i].substring(0, cssArr[_i].indexOf(":"))) == "background"
                            ) {
                                switch (posId) {
                                case 'cssLeft':
                                    cxColorPicker_c.color($.trim(cssArr[_i].substring(cssArr[_i].indexOf(":") + 1)));
                                    break;
                                case 'cssMid':
                                    cxColorPicker_ma_bg
                                        .color($.trim(cssArr[_i].substring(cssArr[_i].indexOf(":") + 1)));
                                    break;
                                case 'cssRight':
                                    cxColorPicker_tt_bg
                                        .color($.trim(cssArr[_i].substring(cssArr[_i].indexOf(":") + 1)));
                                    break;
                                default:
                                    break;
                                }
                            }
                        }
                    }
                });
        }
        
        function setSelType(strJson, selectedItem) {
            var objJson;
            if (typeof strJson === 'undefined' || strJson === "") {
                return;
            } else {
                objJson = $.parseJSON(strJson);
            }
            var ddlHtml = "<select class='ddlReport' id='ddlReport' IsRequired='1' > ";
            ddlHtml += "<option value=''>=选择=</option> ";
            for (i = 0; i < objJson.length; i++) {
                var ItemValue = objJson[i].ItemValue;
                var ItemName = objJson[i].ItemName;
                if (selectedItem == ItemValue) {
                    ddlHtml += "<option selected=true value='" + ItemValue + "'>" + ItemName + "</option> ";
                } else {
                    ddlHtml += "<option value='" + ItemValue + "'>" + ItemName + "</option> ";
                }
            }
            ddlHtml += "</select>";
            $("#tdSelType").html(ddlHtml);
        }


        //新增
        function addContainer(entity, doClick, type) {
            if (entity == null && doClick !== false) {
                entity = {};
                entity.KanbanContainerId = -1;
                entity.ContainerName = '';
                entity.PlayMinutes = 120;
                //entity.LayoutType ='';
                entity.Remark = '';
                //entity.ShowSeq = 0;
            }
            var row, cell ,rowNewIdx;
            rowNewIdx  = tabCon.rows.length;
            row = tabCon.insertRow(rowNewIdx);
            var cellNum = 0;
            row.className = "ListTableOddRow";

            //顺序调整
            cell = row.insertCell(cellNum++);
            cell.align = "center";
            cell.innerHTML = "<a href='#' onclick='up(this)'><img src='../Content/images/arrowUp.gif' /></a>" +
                        "<a href='#' onclick='down(this)'><img src='../Content/images/arrowDown.gif'/></a>";

            //容器名字
            cell = row.insertCell(cellNum++);
            cell.align = "center";
            cell
            .innerHTML =
            '<input type="hidden" name="txtConID" class="txtConID" value="'+entity.KanbanContainerId+'" />' +
            '<input type="text" name="txtConName" readonly="readonly" class="txtConName" value="' + entity.ContainerName + '" style="width: 200px"/>' +
            '<input type="button" id="btnSelectItems" onclick="openChoosePage(69,this);" class="ButtonBox chkEditableBOM"  value="..."  />';

            //描述
            cell = row.insertCell(cellNum++);
            cell.align = "center";
            cell.innerHTML += entity.Remark;

            //播放时间
            cell = row.insertCell(cellNum++);
            cell.align = "center";
            cell.innerHTML += '<input type="text" name="txtPlayTime" maxlength="5" value="' + entity.PlayMinutes + '" style="width:60px"' +
                ' onkeyup="this.value=this.value.replace(/\\D/g,\'\')" onafterpaste="this.value=this.value.replace(/\\D/g,\'\')" />';

            //操作按钮
            cell = row.insertCell(cellNum++);
            cell.align = "center";
            cell.innerHTML = "<span style=\"CURSOR: pointer; COLOR: #0000ff;\" onclick=\"deleteCon(this)\"><%= Buttons.COM_Delete %></span>";
 
        }

        //删除容器
        function deleteCon(obj) {
            tabCon.deleteRow(obj.parentElement.parentElement.rowIndex-1);
        }
        
        function up(obj) {
            var objParentTR = $(obj).parent().parent();
            var prevTR = objParentTR.prev();
            if (prevTR.length > 0) {
                prevTR.insertAfter(objParentTR);
            }
        }
        function down(obj) {
            var objParentTR = $(obj).parent().parent();
            var nextTR = objParentTR.next();
            if (nextTR.length > 0) {
                nextTR.insertBefore(objParentTR);
            }
        }
  
        function openChoosePage(pageId,obj) {
            var condition = "";
            rowObj = obj.parentElement.parentElement;
            dialog({
                title: "<%= Common.ChooseWindow %>",
                src: "<%= WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=" +
                pageId +
                "&Multiple=false&SearchCondition=" +
                condition +
                "&rnd=" +
                Math.random(),
                width: 600,
                height: 300
            });
        }
        function getChooseValue(list) {
            rowObj.cells[1].children[0].value = list[0][0]; //ID
            rowObj.cells[1].children[1].value = list[0][1]; //name
            rowObj.cells[2].innerHTML=list[0][2]; //remark
        }

        function getImage(img) {
            rowObj.cells[2].children[0].value = img;
        }

        //选择图标
        function chooseIcon() {
            dialog({ title: '<%=Resources.lang.ChooseIcon %>', src: 'ChooseIcon.aspx', width: 400, height: 300 });
        }

        //显示选中的图标
        function setIcon(icon, iconname) {
            $("#reportIcon").html("<img src='" + icon + "'/>");
            $("#<%=this.hdnIcon.ClientID %>").val(iconname);
            closeDialog();
        }

        function Save() {
            var _rtId = reportId;
            var _reportCNName = $("#<%=this.txtReportCNName.ClientID %>").val();
            var _reportENName = $("#<%=this.txtReportENName.ClientID %>").val();
            var _reportIcon = $("#<%=this.hdnIcon.ClientID %>").val();
            var _reportSequence = $("#<%=this.txtSequence.ClientID %>").val();
            var _rtName = $("#<%=this.hdnReportName.ClientID %>").val();
            var _rtDescription = $("#<%=this.txtTmplDesc.ClientID %>").val();
            var _rtContent = "";
            var _reportType = $("#ddlReport").val();
            var _currentUser = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
            var tValueL = $("#txtTitleLeft").val();
            var tAttrL = getTitleCss("cssLeft"); //$("#txtTitleLAttr").val();
            var tValueM = $("#txtTitleMid").val();
            var tAttrM = getTitleCss("cssMid"); //$("#txtTitleMAttr").val();
            var tValueR = $("#txtTitleRight").val();
            var tAttrR = getTitleCss("cssRight"); //$("#txtTitleRAttr").val();
            var tTypeL = $("#selTypeL").val();
            var tTypeM = $("#selTypeM").val();
            var tTypeR = $("#selTypeR").val();
            var footHtml = $("#txtFoot").val();
            var conList = document.getElementsByName("txtConID");
            var playTime = document.getElementsByName("txtPlayTime");
            //中文名不能为空
            if ($.trim(_reportCNName) == "") {
                alert("中文名不能为空");
                $("#<%=this.txtReportCNName.ClientID %>").focus();
                return false;
            }
            //英文名不能为空
            if ($.trim(_reportENName) == "") {
                alert("英文名不能为空");
                $("#<%=this.txtReportENName.ClientID %>").focus();
                return false;
            }
            //报表类型不能为空
            if ($.trim(_reportType) === "" || $.trim(_reportType)==='-1') {
                alert("类型不能为空");
                return false;
            }
            //至少绑定一个容器
            if (conList.length < 1) {
                alert("请至少绑定一个容器");
                return false;
            }

            var entity = {};
            entity.TemplateId = _rtId;
            entity.ReportCNName = _reportCNName;
            entity.ReportENName = _reportENName;
            entity.ReportIcon = _reportIcon;
            entity.ReportSequence = _reportSequence;
            entity.TemplateName = _rtName !== '' ? _rtName : '0';
            entity.TemplateDesc = _rtDescription;
            entity.TemplateContent = _rtContent;
            entity.ReportType = _reportType;
            entity.CreateBy = _currentUser;
            entity.ModifyBy = _currentUser;
            entity.DesignJson = "";
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
            entity.FootHtml = footHtml;
            entity.BindContList = "";       
            entity.ContPlayTimeList = "";   
            //保存容器绑定
            for (var i = 0; i < conList.length; i++) {
                entity.BindContList += conList[i].value + ',';
                entity.ContPlayTimeList += playTime[i].value + ',';
                if (playTime[i].value * 1 < 10) {
                    alert("看板容器的刷新时间不应少于10秒");
                    return false;
                }
                if (conList[i].value === '' || conList[i].value === '-1') {
                    alert("存在未选择的容器");
                    return false;
                }
            }
            entity.BindContList = entity.BindContList.slice(0, -1);//容器  
            entity.ContPlayTimeList = entity.ContPlayTimeList.slice(0, -1);//容器播放时间

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxKanban.EditKanbanTemplate(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }


            alert("<%=Resources.Messages.SaveInSuccess %>");
            window.parent.UpdateList(_reportCNName);
        }

        function getTitle() {
            var strHtml = '<div class="container-fluid"><div class="row">' +
                '<div class="col-md-12 divTitle divMasterTitle">';
            var leftType, leftValue, leftCss;
            var midType, midValue, midCss;
            var rightType, rightValue, rightCss;
            leftType = $("#selTypeL").val();
            leftValue = $("#txtTitleLeft").val();
            //leftCss = $("#txtTitleLAttr").val();
            leftCss = getTitleCss("cssLeft"); 
            midType = $("#selTypeM").val();
            midValue = $("#txtTitleMid").val();
            midCss = getTitleCss("cssMid");
            //midCss = $("#txtTitleMAttr").val();
            rightType = $("#selTypeR").val();
            rightValue = $("#txtTitleRight").val();
            //rightCss = $("#txtTitleRAttr").val();
            rightCss = getTitleCss("cssRight");
            strHtml += ' <div class="divL col-md-4" style="' + leftCss + '">';
            switch (leftType) {
                case '0':  //文字
                    strHtml += leftValue;
                    break;
                case '1':  //图片
                    strHtml += '<img src="' + leftValue + '">';
                    break;
                case '2':  //时间
                    strHtml += '<div class="showTimeNow"></div>';
                    break;
            }
            strHtml += ' </div><div class="divM col-md-4" style="' + midCss + '">';
            switch (midType) {
                case '0':  //文字
                    strHtml += midValue;
                    break;
                case '1':  //图片
                    strHtml += '<img src="' + midValue + '">';
                    break;
                case '2':  //时间
                    strHtml += '<div class="showTimeNow"></div>';
                    break;
            }
            strHtml += ' </div><div class="divR col-md-4" style="' + rightCss + '">';
            switch (rightType) {
                case '0':  //文字
                    strHtml += rightValue + ' ';
                    break;
                case '1':  //图片
                    strHtml += '<img src="' + rightValue + '">';
                    break;
                case '2':  //时间
                    strHtml += '<div class="showTimeNow"></div>';
                    break;
            }
            strHtml += ' </div></div></div></div>';
            return strHtml;
        }

    </script>
</asp:Content>
