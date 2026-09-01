<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="InterfaceManagementEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Wave.InterfaceManagementEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <!----------------------------------------------------------------------------------
                                        信息中心
创建时间：2014-11-13
更新时间:
创建人：zhibin.Chen
修改人：
------------------------------------------------------------------------------------>
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
        /*Search button ==结束*/
    </style>
    <div class="wrap_tb" id="wrap_tb_container" style="min-width: 710px; overflow: auto;">
        <ul class="tb">
            <li class="current">基本信息
            </li>
            <li id="liSetting">解析配置
            </li>
        </ul>
        <div class="tb_c" style="min-height: 460px; overflow-y: scoll;">
            <div class="Label" style="margin-top: -5px; !margin-top: -25px; line-height: 26px; padding-left: 10px;">
                <%=Resources.Messages.WithAsteriskIsRequired %>
            </div>
            <input type="hidden" id="hdnDeviceType" runat="server" value="" />
            <asp:HiddenField runat="server" ID="hidDeviceInterfaceTypeId" Value="" />
            <asp:HiddenField runat="server" ID="hidId" />
            <table width="100%" class="EditeContentTable">
                <tr>
                    <td class="Label2">设备类型<em>*</em>
                    </td>
                    <td class="Field2">
                        <select id="DeviceType" onclick="loadBrandType()" isrequired='1'>
                        </select>
                    </td>
                    <td class="Label2">品牌型号<em>*</em>
                    </td>
                    <td class="Field2">
                        <select id="BrandType" isrequired='1'>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td class="Label2">监控目录<em>*</em>
                    </td>
                    <td class="Field2">
                        <asp:TextBox ID="txtTargetFileDir" runat="server" CssClass="TextBox" Width="300" IsRequired='1' placeholder="E:\设备日志" />
                    </td>
                    <td class="Label2">文件类型<em>*</em>
                    </td>
                    <td class="Field2">
                        <asp:DropDownList ID="ddlFileType" runat="server" Width="150px" IsRequired='1'>
                            <asp:ListItem Selected="True" Value="">--请选择--</asp:ListItem>
                            <asp:ListItem Value="EXCEL">EXCEL</asp:ListItem>
                            <asp:ListItem Value="CSV">CSV</asp:ListItem>
                            <asp:ListItem Value="XML">XML</asp:ListItem>
                            <asp:ListItem Value="TXT">TXT</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
                <%--<tr>
                    <td class="Label2">用户名
                    </td>
                    <td class="Field2">
                        <asp:TextBox ID="txtUserName" runat="server" CssClass="TextBox" />
                    </td>
                    <td class="Label2">密码
                    </td>
                    <td class="Field2">
                        <asp:TextBox ID="txtPassword" TextMode="Password" runat="server" CssClass="TextBox" />
                    </td>
                </tr>--%>
                <tr>
                    <td class="Label2">默认用户<em>*</em>
                    </td>
                    <td class="Field2">
                        <asp:TextBox ID="txtDefaultUserName" runat="server" CssClass="TextBox" IsRequired='1' />
                    </td>
                    <td class="Label2">不良代码<em>*</em>
                    </td>
                    <td class="Field2">
                        <asp:TextBox ID="txtNCCode" runat="server" CssClass="TextBox" IsRequired='1' ReadOnly="true" />
                        <input type="button" class="ButtonBox" value="..." title="<%=Resources.lang.ChooseItem %>" onclick="selectChoosePage(113);" />
                        <asp:HiddenField ID="hidNCCodeId" runat="server" Value="-1" />
                    </td>
                </tr>
                <tr>
                    <td class="Label2">线别名称<em>*</em>
                    </td>
                    <td class="Field2">
                        <asp:TextBox ID="txtLineName" runat="server" CssClass="TextBox" IsRequired='1' ReadOnly="true" />
                        <input type="button" class="ButtonBox" value="..." title="<%=Resources.lang.ChooseItem %>" onclick="selectChoosePage(21);" />
                        <asp:HiddenField ID="hidLineId" runat="server" Value="-1" />
                    </td>
                    <td class="Label2">是否联版<em>*</em>
                    </td>
                    <td class="Field2">
                        <asp:DropDownList ID="ddlIsCouplet" runat="server" IsRequired='1'>
                            <asp:ListItem Selected="True" Value="">--请选择--</asp:ListItem>
                            <asp:ListItem Value="1">是</asp:ListItem>
                            <asp:ListItem Value="0">否</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
                <%--<tr>
                    <td class="Label2">序列号位置<em>*</em>
                    </td>
                    <td class="Field2" colspan="3">
                        <asp:TextBox ID="txtSnPosition" runat="server" CssClass="TextBox" IsRequired='1' Width="300" /><br />
                        （例子Excel:3,4,5; Xml参照xpath语法:/Reports/Report/Prop/Prop[@Name="SerialNumber"]/Value ）
                    </td>
                </tr>--%>
                <%--<tr class="test-list">
                    <td class="Label2">测试结果位置<em>*</em>
                    </td>
                    <td class="Field2" colspan="3">
                        <table id="testPosition" class="ListTable" style="width: 100%" cellspacing="0" cellpadding="2">
                            <thead>
                                <tr class="ListTableTitle" style="text-align: center; height: 27px;">
                                    <th width="10%">序号</th>
                                    <th>位置<em>*</em>（例子Excel:3,4,5; Xml:参照Xpath语法）
                                    </th>
                                    <th>关系
                                    </th>
                                    <th>结果<em>*</em>（例子：Pass或Fail）
                                    </th>
                                    <th><a href="#" class="test-result-add">新增</a>
                                    </th>
                                </tr>
                            </thead>
                            <tbody>--%>
                <%--<tr class="ListTableOddRow"><td align=\"center\">1</td><td><input class="test-positon" /></td><td>包含</td><td><input class="test-result" /></td><td><a href="#" class="test-delete">删除</a></td></tr>--%>
                <%--</tbody>
                        </table>
                    </td>
                </tr>--%>
            </table>
            <div class="clear5">
            </div>
        </div>
        <div id="divSetting" style="min-height: 460px; overflow-y: scoll;">
            <div style="overflow: auto; float: left; width: 70%">
                <div class="wrap_tb" id="wrap_tb_container1">
                    <ul class="tb">
                        <li class="current" id="liExcel">Excel/CSV
                        </li>
                        <li id="liXML">XML
                        </li>
                        <li id="liTXT">TXT
                        </li>
                        <li id="liTitle">标题解析
                        </li>
                    </ul>
                    <div id="divExcel" class="tb_c" style="min-height: 420px; overflow: auto;">
                        <table class="ListTable ListTableHeader">
                        </table>
                    </div>
                    <div id="divXML" style="min-height: 420px; overflow: scoll;">
                        <table class="ListTable ListTableHeader">
                        </table>
                    </div>
                    <div id="divTxt" style="min-height: 420px; overflow: scoll;">
                        <table class="ListTable ListTableHeader">
                        </table>
                    </div>
                    <div id="divTitle" style="min-height: 420px; overflow: scoll;">
                        <table class="ListTable ListTableHeader">
                            <tr>
                                <td><span>标题</span>：</td>
                                <td><label id="lblFileName"></label></td>
                            </tr>
                            <tr>
                                <td colspan="2"><span>分隔符</span></td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <input id="inputEmpty" type="checkbox" onclick="SplitTitle(this)"/><span>空格</span>( )
                                    <input id="inputWhippletree" type="checkbox" onclick="SplitTitle(this)"/><span>横杠</span>(-)
                                    <input id="inputUnderLine" type="checkbox" onclick="SplitTitle(this)"/><span>下划线</span>(_)
                                    <input id="inputNumberSign" type="checkbox" onclick="SplitTitle(this)"/><span>#号</span>(#)
                                    <input id="inputNumber" type="checkbox" onclick="SplitTitle(this)"/><span>@号</span>(@)
                                    <input id="inputBracket" type="checkbox" onclick="SplitTitle(this)"/><span>括号</span>(())
                                    <input id="inputBrackets" type="checkbox" onclick="SplitTitle(this)"/><span>方括号</span>([])
                                    <input id="inputDot" type="checkbox" onclick="SplitTitle(this)"/><span>逗号</span>(,)
                                    <%--<input type="button" name="split" onclick="SplitTitle()" value="切分"/>--%>
                                </td>
                            </tr>
                            <tr>
                                <td id="tdSplitTitle" colspan="2">
                                    <%--<input type="text" value="000003A9-D-171212-00001" name="1"  class="text" style="padding-left:5px;width:100px"/>--%>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
            <div style="float: right; width: 29%">
                <div class="wrap_tb" id="wrap_tb_container2">
                    <ul class="tb" style="width: 99%">
                        <li class="current">通用配置
                        </li>
                        <li>拼版配置
                        </li>
                    </ul>
                    <div class="tb_c" style="min-height: 220px; overflow: hidden; width: 99%;">
                        <table class="ListTable ListTableHeader" style="width: 99%">
                            <tr>
                                <td colspan="3" style="width: 240px">
                                    <input style="width: 220px" type="file" id="Filedata" name="Filedata" title="上传附件"  onchange="FileChange(this)"/><input id="btnUploadFile" type="button" class="button" value="载入" /></td>
                            </tr>
                            <tr>
                                <td style="width: 80px"><span>条码设置</span></td>
                                <td style="width: 120px">
                                    <input type="text" style="width: 120px" id="lblSNRemark" onclick="changeKey('lblSNRemark')"/></td>
                                <td style="width: 40px">
                                    <input name="inputSN" type="button" value="选择" onclick="changeKey('lblSNRemark')"/>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 80px"><span>测试结果</span></td>
                                <td style="width: 120px">
                                    <input type="text" style="width: 120px" id="lblTestResultRemark" onclick="changeKey('lblTestResultRemark')"/></td>
                                <td style="width: 40px">
                                    <input name="inputTestResult" type="button" value="选择" onclick="changeKey('lblTestResultRemark')"/>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 80px"><span>重检结果</span></td>
                                <td style="width: 120px">
                                    <input type="text" style="width: 120px" id="lblReTestResultRemark" onclick="changeKey('lblReTestResultRemark')"/></td>
                                <td style="width: 40px">
                                    <input name="inputReTestResult" type="button" value="选择" onclick="changeKey('lblReTestResultRemark')"/>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 80px"><span>合格字符</span></td>
                                <td style="width: 120px">
                                    <input type="text" style="width: 120px" id="lblTestResultGoodRemark" /></td>
                                <td style="width: 40px"></td>
                            </tr>
                            <tr>
                                <td style="width: 80px"><span>不合格字符</span></td>
                                <td style="width: 120px">
                                    <input type="text" style="width: 120px" id="lblTestResultFailRemark" /></td>
                                <td style="width: 40px"></td>
                            </tr>

                            <%--<tr>
                            <td onclick="SelectItem('TestItem')"><input name="inputTestItem" type="checkbox" title=""/> </td>
                            <td onclick="SelectItem('TestItem')"><span>测试项</span></td>
                            <td onclick="SelectItem('TestItem')" style="width:30%"><input type="text"  style ="width:50px"  id="lblTestItemRemark" /></td>
                        </tr>--%>
                        </table>
                    </div>
                    <div style="min-height: 220px; overflow: hidden; width: 99%;">
                        <table class="ListTable ListTableHeader" style="width: 99%">                            
                            <tr>
                                <td style="width: 80px"><span>拼版数据标识</span></td>
                                <td style="width: 80px">
                                    <input type="text" style="width: 80px" id="lblPanelSettingRemark" onclick="changeKey('lblPanelSettingRemark')"/></td>
                                <td>
                                    <input name="inputPanelSetting" type="button" value="选择" onclick="changeKey('lblPanelSettingRemark')"/>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 80px"><span>子板位置</span></td>
                                <td style="width: 80px">
                                    <input type="text" style="width: 80px" id="lblSubSNRemark" onclick="changeKey('lblSubSNRemark')"/></td>
                                <td>
                                    <input name="inputSubSN" type="button" value="选择" onclick="changeKey('lblSubSNRemark')"/>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 80px"><span>不良代码</span></td>
                                <td style="width: 80px">
                                    <input type="text" style="width: 80px" id="lblFailCodeRemark" onclick="changeKey('lblFailCodeRemark')"/></td>
                                <td>
                                    <input name="inputFailCode" type="button" value="选择" onclick="changeKey('inputFailCode')"/>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>

                <div id="divTXTSplitSetting">
                    <table class="ListTable ListTableHeader" style="width: 99%">
                        <tr>
                            <td  style="width: 240px;cursor:pointer;">
                                <span>TXT分割符号</span>
                            </td>
                        </tr>
                        <tr>
                            <td align="left">
                                <input id="txtEmpty" type="checkbox" onclick="changeTxtSplitChar(this, ' ')"/><span>空格</span>( )<br />
                                <input id="txtDwukropek" type="checkbox" onclick="changeTxtSplitChar(this, ':')"/><span>冒号</span>(:)<br />
                                <input id="txtDot" type="checkbox" onclick="changeTxtSplitChar(this, ',')"/><span>逗号</span>(,)<br />
                                <input id="txtSemicolon" type="checkbox" onclick="changeTxtSplitChar(this, ';')"/><span>分号</span>(;)<br />
                                <input id="txtWhippletree" type="checkbox" onclick="changeTxtSplitChar(this, '-')"/><span>横杠</span>(-)<br />
                                <input id="txtSlash" type="checkbox" onclick="changeTxtSplitChar(this, '\\')"/><span>斜杠</span>(\)<br />
                                <input id="txtBackSlash" type="checkbox" onclick="changeTxtSplitChar(this, '/')"/><span>反斜杠</span>(/)<br />
                                <input id="txtUnderLine" type="checkbox" onclick="changeTxtSplitChar(this, '_')"/><span>下划线</span>(_)<br />               
                                <input id="txtEqual" type="checkbox" onclick="changeTxtSplitChar(this, '=')"/><span>等于</span>(=)
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
        <asp:HiddenField ID="hidPwd" runat="server" />
        <asp:HiddenField ID="hidTitleSplitChar" runat="server" />
        <asp:HiddenField ID="hidTxtSplitChar" runat="server" />
        <asp:HiddenField ID="hidFileNewPath" runat="server" />
        <style>
            .test-positon {
                width: 300px;
            }
        </style>
        <script type="text/javascript">
            var pageId = -1;
            var id;
            var defaultLine = "<tr class=\"ListTableOddRow\"><td align=\"center\">1</td><td><input class=\"test-positon TextBox\" /></td><td>包含</td><td><input class=\"test-result TextBox\" /></td><td align=\"center\"><a href=\"#\" class=\"test-delete\">删除</a></td></tr>";

            var Setkey = "";

            function changeKey(id) {
                Setkey = id;
                $("#" + id).select().focus();
            }

            $(function () {
                var pd = $.trim($("#<%=this.hidPwd.ClientID %>").val());
                if (pd != "") {
                    <%--$("#<%=this.txtPassword.ClientID %>").val(pd);--%>
                }

                //加载设备类型下拉框
                loadDeviceType();
                id = $.trim($("#<%=this.hidId.ClientID %>").val());
                if (id == null || id == "" || id == "-1") {
                   <%-- $("#<%=this.txtUserName.ClientID %>").val("");
                    $("#<%=this.txtPassword.ClientID %>").val("");--%>
                    //新增    
                    $("#testPosition tbody").append(defaultLine);
                } else {
                    //加载文件内容
                    var txtSplitChar = $("#<%=hidTxtSplitChar.ClientID %>").val();
                    var formData = new FormData();
                    formData.append("fileNewPath", $("#<%=hidFileNewPath.ClientID %>").val());
                    formData.append("action", "GetFileData");
                    formData.append("SplitChar", txtSplitChar);
                    $.ajax({
                        type: "POST",  //提交方式  
                        url: "../Handler/PrintUpdate.ashx?rnd=" + Math.random(),//路径  
                        data: formData,//数据
                        contentType: false, //禁止设置请求类型
                        processData: false, //禁止jquery对DAta数据的处理,默认会处理
                        success: function (data) {//返回数据根据结果进行相应的处理  
                            data = $.parseJSON(data);
                            if (!data.success) {
                                alert(data.msg);
                                return;
                            }
                            afterUpload(data);
                            if ($("#<%= hidTxtSplitChar.ClientID %>").val() != "" && $.trim($("#lblFileName").text()) != "") {
                                SplitTitle(null);
                            }
                        },
                        error: function (xhr, status, error) {
                            alert(error);
                        }
                    });
                    //加载测试内容的设定
                    var entity = { DeviceInterfaceId: id };

                    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxInterfaceManagement.GetDeviceInterfaceTestPositionList(entity);
                    if (ajax.error != null) {
                        alert(ajax.error.Message);
                        return false;
                    }
                    //$("#liSetting").click();
                    if (ajax.value != null) {
                        var entityList = ajax.value;                        
                        for (entityIndex = 0; entityIndex < entityList.length; entityIndex++) {
                            switch (entityList[entityIndex].PonitType) {
                                case "SN":
                                    Setkey = "lblSNRemark";
                                    if (entityList[entityIndex].TestResult != "") {
                                        afterSettingData(entityList[entityIndex]);
                                    }                                    
                                    break;
                                case "TestResult":
                                    Setkey = "lblTestResultRemark";
                                    if (entityList[entityIndex].TestResult != "") {
                                        afterSettingData(entityList[entityIndex]);
                                    }
                                    break;
                                case "ReTestResult":
                                    Setkey = "lblReTestResultRemark";
                                    if (entityList[entityIndex].TestResult != "") {
                                        afterSettingData(entityList[entityIndex]);
                                    }
                                    break;
                                case "TestResultGood":
                                    Setkey = "lblTestResultGoodRemark";
                                    if (entityList[entityIndex].TestResult != "") {
                                        afterSettingData(entityList[entityIndex]);
                                    }
                                    break;
                                case "TestResultFail":
                                    Setkey = "lblTestResultFailRemark";
                                    if (entityList[entityIndex].TestResult != "") {
                                        afterSettingData(entityList[entityIndex]);
                                    }
                                    break;
                                case "PanelSetting":
                                    Setkey = "lblPanelSettingRemark";
                                    if (entityList[entityIndex].TestResult != "") {
                                        afterSettingData(entityList[entityIndex]);
                                    }
                                    break;
                                case "SubSN":
                                    Setkey = "lblSubSNRemark";
                                    if (entityList[entityIndex].TestResult != "") {
                                        afterSettingData(entityList[entityIndex]);
                                    }
                                    break;
                                case "FailCode":
                                    Setkey = "lblFailCodeRemark";
                                    if (entityList[entityIndex].TestResult != "") {
                                        afterSettingData(entityList[entityIndex]);
                                    }
                                    break;
                            }
                        }
                        Setkey = "";
                    }
                    //设置TXT分割符号
                    if($("#<%= hidTxtSplitChar.ClientID %>").val().indexOf(" ")>=0)
                        $("#txtEmpty").attr("checked", "checked");
                    if($("#<%= hidTxtSplitChar.ClientID %>").val().indexOf(":")>=0)
                        $("#txtDwukropek").attr("checked", "checked");
                    if($("#<%= hidTxtSplitChar.ClientID %>").val().indexOf(",")>=0)
                        $("#txtDot").attr("checked", "checked");
                    if($("#<%= hidTxtSplitChar.ClientID %>").val().indexOf(";")>=0)
                        $("#txtSemicolon").attr("checked", "checked");
                    if($("#<%= hidTxtSplitChar.ClientID %>").val().indexOf("-")>=0)
                        $("#txtWhippletree").attr("checked", "checked");
                    if($("#<%= hidTxtSplitChar.ClientID %>").val().indexOf("\\")>=0)
                        $("#txtSlash").attr("checked", "checked");
                    if($("#<%= hidTxtSplitChar.ClientID %>").val().indexOf("/")>=0)
                        $("#txtBackSlash").attr("checked", "checked");
                    if($("#<%= hidTxtSplitChar.ClientID %>").val().indexOf("_")>=0)
                        $("#txtUnderLine").attr("checked", "checked");    
                    if($("#<%= hidTxtSplitChar.ClientID %>").val().indexOf("=")>=0)                        $("#txtEqual").attr("checked", "checked");   

                    //设置Title分割符号
                    if($("#<%= hidTitleSplitChar.ClientID %>").val().indexOf(" ")>=0)
                        $("#inputEmpty").attr("checked","checked");
                    if($("#<%= hidTitleSplitChar.ClientID %>").val().indexOf("-")>=0)
                        $("#inputWhippletree").attr("checked","checked");
                    if($("#<%= hidTitleSplitChar.ClientID %>").val().indexOf("_")>=0)
                        $("#inputUnderLine").attr("checked","checked");
                    if($("#<%= hidTitleSplitChar.ClientID %>").val().indexOf("#")>=0)
                        $("#inputNumberSign").attr("checked","checked");
                    if($("#<%= hidTitleSplitChar.ClientID %>").val().indexOf("@")>=0)
                        $("#inputNumber").attr("checked","checked");
                    if($("#<%= hidTitleSplitChar.ClientID %>").val().indexOf("()")>=0)
                        $("#inputBracket").attr("checked","checked");
                    if($("#<%= hidTitleSplitChar.ClientID %>").val().indexOf("[]")>=0)
                        $("#inputBrackets").attr("checked","checked");
                    else if($("#<%= hidTitleSplitChar.ClientID %>").val().indexOf(",")>=0)
                        $("#inputDot").attr("checked", "checked");
                    
                }

                ////新增行
                //$(".test-result-add").bind("click", function () {
                //    var count = $("#testPosition tbody tr").length;
                //    var className = count % 2 == 0 ? "ListTableOddRow" : "ListTableEvenRow";
                //    var html = "<tr class=\"" + className + "\"><td align=\"center\">" + (count + 1) + "</td><td><input class=\"test-positon TextBox\"/></td><td>包含</td><td><input class=\"test-result TextBox\" /></td><td align=\"center\"><a href=\"#\" class=\"test-delete\">删除</a></td></tr>";
                //    $("#testPosition tbody").append(html);
                //});

                ////删除行
                //$(".test-delete").live("click", function () {
                //    //移除当前行
                //    $(this).parent().parent().remove();
                //    //列表重排
                //    $("#testPosition tbody tr").each(function (index, element) {
                //        var className = index % 2 == 0 ? "ListTableOddRow" : "ListTableEvenRow";
                //        $(this).attr("class", className).find("td").first().html(index + 1);
                //    });
                //});

                $("#btnUploadFile").click(function () {
                    var fileType = "";
                    
                    var fileName = document.getElementById('Filedata').files[0].name;
                    var txtSplitChar = $("#<%=hidTxtSplitChar.ClientID %>").val();
                    if (fileName.toLowerCase().indexOf(".txt") > 0 && txtSplitChar == "") {
                        alert("请选择txt文件的分割符");
                        return;
                    }

                    var file = document.getElementById("Filedata").files[0];
                    if (file == undefined || file == null) {
                        alert("请先选择上传文件");
                        return;
                    }

                    var formData = new FormData();
                    formData.append(file.name, file);                
                    formData.append("action", "SaveFileModel");
                    formData.append("SplitChar", txtSplitChar);
                    try {
                        $.ajax({
                            type: "POST",  //提交方式  
                            url: "../Handler/PrintUpdate.ashx?rnd=" + Math.random(),//路径  
                            data: formData,//数据
                            contentType: false, //禁止设置请求类型
                            processData: false, //禁止jquery对DAta数据的处理,默认会处理
                            success: function (data) {//返回数据根据结果进行相应的处理  
                                //$("#viewLogo").children("img").attr("src", data);
                                //alert("Logo上传成功。");
                                //top.location.href = top.location.href;
                                data = $.parseJSON(data);
                                if (!data.success) {
                                    alert(data.msg);
                                    return;
                                }
                                $("#divSetting input[type='text']").val("");
                                $("#divXML table").html("");
                                $("#divExcel table").html("");
                                $("#divTxt table").html("");
                                afterUpload(data);
                            },
                            error: function (xhr, status, error) {
                                alert(error);
                            }
                        });
                    }
                    catch (ex) {
                        alert(ex);
                    }

                });
            });
            function afterSettingData(data) {
                if (data.AnalysisType == "EXCEL") {                    
                    SelectItem(data.TestResult.split(',')[0], data.TestResult.split(',')[1]);
                }
                else if(data.AnalysisType == "XML"){
                    SelectNode(data.TestResult);
                }
                else if(data.AnalysisType == "TXT"){
                    SelectData(data.TestResult.split(',')[0], data.TestResult.split(',')[1]);
                }
                else if (data.AnalysisType == "TITLE") {
                    SelectTitle(data.TestResult);
                }
                else {
                    $("#" + Setkey).val(data.TestResult);
                }
            }

            function FileChange(obj) {
                if ($(obj).val() != "" && $(obj).val().toLowerCase().indexOf(".txt")>0) {
                    $("#divTXTSplitSetting").css("display", "");
                }
                else {
                    $("#divTXTSplitSetting").css("display", "none");
                }                
            }

            //上载文件或者修改时候从服务器拿文件模板数据回来后，反填写到界面
            function afterUpload(data) {
                $("#<%=this.ddlFileType.ClientID %> option[value='" + data.FileType + "']").attr('selected', 'true');
                $("#lblFileName").text(data.FileName);
                $("#<%=hidFileNewPath.ClientID %>").val(data.FilePath);
                
                if (data.FileType == "EXCEL") {
                    $("#liXML").css("display", "none");
                    $("#liTXT").css("display", "none");
                    $("#liExcel").css("display", "");
                    document.getElementById("liExcel").click();
                    initExcel(data.Data);
                }
                else if (data.FileType == "CSV") {
                    $("#liXML").css("display", "none");
                    $("#liTXT").css("display", "none");
                    $("#liExcel").css("display", "");
                    document.getElementById("liExcel").click();
                    initExcel(data.Data);
                }
                else if (data.FileType == "XML") {
                    $("#liExcel").css("display", "none");
                    $("#liTXT").css("display", "none");
                    $("#liXML").css("display", "");
                    document.getElementById("liXML").click();
                    initXML(data.Data);
                }
                else if (data.FileType == "TXT") {
                    $("#liExcel").css("display", "none");
                    $("#liXML").css("display", "none");
                    $("#liTXT").css("display", "");
                    document.getElementById("liTXT").click();
                    initTXT(data.Data);
                }
            }

            function changeTxtSplitChar(obj,char) {
                var txtSplitChar = $("#<%=hidTxtSplitChar.ClientID %>").val();
                if ($(obj).attr("checked") == "checked") {
                    $("#<%=hidTxtSplitChar.ClientID %>").val(txtSplitChar + char);
                } else {
                    $("#<%=hidTxtSplitChar.ClientID %>").val(txtSplitChar.replace(char, ""));
                }
            }

            function initXML(data) {
                var html = "";
                $("#divXML table").html("");
                for (k = 0; k < data.length; k++) {
                    html += "<tr>";
                    for (j = 0; j < data[k].length; j++) {
                        var nodeData = data[k][j].split(",");
                        var innerText = nodeData[0];
                        if (nodeData.length > 1) {
                            innerText = nodeData[1];
                        }
                        html += "<td onclick='SelectNode(\"" + nodeData[0] + "\")' style='cursor:pointer'>" + innerText + "</td>";
                    }
                    html += "</tr>";
                }

                $("#divXML table").html(html);
            }

            function initExcel(data) {
                var html = "";
                $("#divExcel table").html("");
                for (k = 0; k < data.length; k++) {
                    html += "<tr>";
                    for (j = 0; j < data[k].length; j++) {
                        html += "<td onclick='SelectItem(" + (k + 1) + "," + (j + 1) + ")' style='cursor:pointer'>" + data[k][j] + "</td>";
                    }
                    html += "</tr>";
                }

                $("#divExcel table").html(html);
            }

            function initTXT(data) {
                var html = "";
                $("#divTxt table").html("");
                for (k = 0; k < data.length; k++) {
                    html += "<tr>";
                    for (j = 0; j < data[k].length; j++) {
                        html += "<td onclick='SelectData(" + (k + 1) + "," + (j + 1) + ")' style='cursor:pointer'>" + data[k][j] + "</td>";
                    }
                    html += "</tr>";
                }

                $("#divTxt table").html(html);
            }

            function SelectNode(nodeData) {
                $("#" + Setkey).val(nodeData);
                $("#" + Setkey).attr("title", nodeData);
                $("#" + Setkey).attr("analysisType", "XML");
            }

            function SelectItem(row,cell) {
                $("#" + Setkey).val(row + "," + cell);
                $("#" + Setkey).attr("title", "row:" + row + ",cell:" + cell);
                $("#" + Setkey).attr("analysisType", "EXCEL");
            }

            function SelectTitle(index) {
                $("#" + Setkey).val(index);
                $("#" + Setkey).attr("title", "标题段:" + index);
                $("#" + Setkey).attr("analysisType", "TITLE");
            }

            function SelectData(row, cell) {
                $("#" + Setkey).val(row + "," + cell);
                $("#" + Setkey).attr("title", "row:" + row + ",cell:" + cell);
                $("#" + Setkey).attr("analysisType", "TXT");
            }

            function SplitTitle(obj) {
                if (obj != null) {
                    if ($(obj)[0].checked == false) {
                        $(obj).removeAttr("checked");
                    }
                }

                var fileName = $.trim($("#lblFileName").text());
                if (fileName == "") {
                    alert("请先选择文件上载");
                    return false;
                }
                var match = "";
                if ($("#inputEmpty").attr("checked") == "checked") {//空格
                    match += " ";
                }
                if ($("#inputWhippletree").attr("checked") == "checked") {//横杠
                    match += "-";
                }
                if ($("#inputUnderLine").attr("checked") == "checked") {//下划线
                    match += "_";
                }
                if ($("#inputNumberSign").attr("checked") == "checked") {//#号
                    match += "#";
                }
                if ($("#inputNumber").attr("checked") == "checked") {//@号
                    match += "@";
                } 
                if ($("#inputBracket").attr("checked") == "checked") {//括号
                    match += "()";
                }
                if ($("#inputBrackets").attr("checked") == "checked") {//中括号
                    match += "[]";
                }
                if ($("#inputDot").attr("checked") == "checked") {//逗号
                    match += ",";
                }

                if (match == "") {
                    //alert("请选择分割的字符");
                    $("#tdSplitTitle").html(fileName);
                    $("#<%=hidTitleSplitChar.ClientID %>").val(match);
                    return false;
                }
               
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxInterfaceManagement.GetSplitTitle(fileName, match);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }
                var splitTitle = ajax.value;
                var html= "";
                for (i = 0; i < splitTitle.length; i++) {
                    html += "<input type=\"text\" value=\"" + splitTitle[i] + "\" name=\"" + (i + 1) + "\"  class=\"text\" style=\"padding-left:5px;width:" + splitTitle[i].length * 10 + "px;cursor:pointer;\" onclick='SelectTitle(" + (i + 1) + ")'/>";
                }
                $("#tdSplitTitle").html(html);
                $("#<%=hidTitleSplitChar.ClientID %>").val(match);
            }

            //加载设备类型
            function loadDeviceType() {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxInterfaceManagement.GetDeviceType();
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }
                if (ajax.value != null) {
                    $("#DeviceType option").remove();
                    var data = ajax.value;
                    $("#DeviceType").append("<option value=''>--请选择--</option>");
                    $("#BrandType").append("<option value=''>--请选择--</option>");
                    for (var i = 0; i < data.length; i++) {
                        $("#DeviceType").append('<option value=' + data[i].DeviceType + '>' + data[i].DeviceType + '</option>');
                    }
                    //编辑时设置选中项的值
                    if (id != "-1") {
                        var val = $("#<%=this.hdnDeviceType.ClientID %>").val();
                        $("#DeviceType").val(val);
                        //加载品牌型号
                        loadBrandType();
                    }
                }
            }

            //加载品牌型号
            function loadBrandType() {
                var deviceType = $("#DeviceType option:selected").val();
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxInterfaceManagement.GetBrandType(deviceType);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }
                if (ajax.value != null) {
                    var data = ajax.value;
                    $("#BrandType option").remove();
                    $("#BrandType").append("<option value=''>--请选择--</option>");
                    for (var i = 0; i < data.length; i++) {
                        $("#BrandType").append('<option value=' + data[i].DeviceInterfaceTypeId + '>' + data[i].Brand + '</option>');
                    }
                    //编辑时设置选中项的值
                    if (id != "-1") {
                        var val = $("#<%=this.hidDeviceInterfaceTypeId.ClientID %>").val();
                        $("#BrandType").val(val);
                    }
                }
            }

            //新增、编辑
            function Save() {

                //测试结果位置
                var xml = null;
                                
                //检查测试结果位置是否有值
                xml = "<testResultPosition>";
                var error = false;
                //条码设置
                if ($.trim($("#lblSNRemark").val()) == "") {                    
                    $("#liSetting").click();
                    $("#lblSNRemark").focus();
                    alert("请设置'条码位置'");
                    return false;
                }
                xml += "<single>"
                            + "<AnalysisType>" + $("#lblSNRemark").attr("analysisType") + "</AnalysisType>"
                            + "<Result>" + $.trim($("#lblSNRemark").val()) + "</Result>"
                            + "<PonitType>SN</PonitType>"
                            + "</single>";
                //测试结果
                if ($.trim($("#lblTestResultRemark").val()) == "") {                    
                    $("#liSetting").click();
                    $("#lblTestResultRemark").focus();
                    alert("请设置'测试结果'位置");
                    return false;
                }
                xml += "<single>"
                            + "<AnalysisType>" + $("#lblTestResultRemark").attr("analysisType") + "</AnalysisType>"
                            + "<Result>" + $.trim($("#lblTestResultRemark").val()) + "</Result>"
                            + "<PonitType>TestResult</PonitType>"
                            + "</single>";
                //重测结果                
                xml += "<single>"
                            + "<AnalysisType>" + $("#lblReTestResultRemark").attr("analysisType") + "</AnalysisType>"
                            + "<Result>" + $.trim($("#lblReTestResultRemark").val()) + "</Result>"
                            + "<PonitType>ReTestResult</PonitType>"
                            + "</single>";
                //合格字符
                if ($.trim($("#lblTestResultGoodRemark").val()) == "") {                    
                    $("#liSetting").click();
                    $("#lblTestResultGoodRemark").focus();
                    alert("请设置'合格字符'内容");
                    return false;
                }
                xml += "<single>"
                            + "<AnalysisType></AnalysisType>"
                            + "<Result>" + $.trim($("#lblTestResultGoodRemark").val()) + "</Result>"
                            + "<PonitType>TestResultGood</PonitType>"
                            + "</single>";
                //不合格字符
                //if ($.trim($("#lblTestResultFailRemark").val()) == "") {
                //    alert("请设置不合格字符内容");
                //    return false;
                //}
                xml += "<single>"
                            + "<AnalysisType></AnalysisType>"
                            + "<Result>" + $.trim($("#lblTestResultFailRemark").val()) + "</Result>"
                            + "<PonitType>TestResultFail</PonitType>"
                            + "</single>";
                //拼版数据标识
                xml += "<single>"
                            + "<AnalysisType>" + $.trim($("#lblPanelSettingRemark").attr("analysisType")) + "</AnalysisType>"
                            + "<Result>" + $.trim($("#lblPanelSettingRemark").val()) + "</Result>"
                            + "<PonitType>PanelSetting</PonitType>"
                            + "</single>"; 
                //子板标识
                xml += "<single>"
                            + "<AnalysisType>" + $.trim($("#lblSubSNRemark").attr("analysisType")) + "</AnalysisType>"
                            + "<Result>" + $.trim($("#lblSubSNRemark").val()) + "</Result>"  
                            + "<PonitType>SubSN</PonitType>"
                            + "</single>";
                //不良代码 
                xml += "<single>"
                            + "<AnalysisType>" + $.trim($("#lblFailCodeRemark").attr("analysisType")) + "</AnalysisType>"
                            + "<Result>" + $.trim($("#lblFailCodeRemark").val()) + "</Result>" 
                            + "<PonitType>FailCode</PonitType>"
                            + "</single>";

                xml += "</testResultPosition>";

                var deviceInterfaceTypeId = $("#BrandType option:selected").val();
                var targetFileDir = $.trim($("#<%=this.txtTargetFileDir.ClientID %>").val());
                var fileType = $.trim($("#<%=this.ddlFileType.ClientID %> option:selected").val());
                <%--var userName = $.trim($("#<%=this.txtUserName.ClientID %>").val());
                var password = $.trim($("#<%=this.txtPassword.ClientID %>").val());--%>
                var titleSplitChar = $.trim($("#<%=this.hidTitleSplitChar.ClientID %>").val());
                var txtSplitChar = $.trim($("#<%=this.hidTxtSplitChar.ClientID %>").val());
                var fileNewPath = $("#<%=hidFileNewPath.ClientID %>").val();
                var defaultUserName = $.trim($("#<%=this.txtDefaultUserName.ClientID %>").val());
                var ncCodeId = $.trim($("#<%=this.hidNCCodeId.ClientID %>").val());
                var lineId = $.trim($("#<%=this.hidLineId.ClientID %>").val());
                var isCouplet = $.trim($("#<%=this.ddlIsCouplet.ClientID %>  option:selected").val());
                <%--var snPosition = $.trim($("#<%=this.txtSnPosition.ClientID %>").val());--%>

                var entity = {};
                entity.DeviceInterfaceId = id;
                entity.DeviceInterfaceTypeId = deviceInterfaceTypeId;
                entity.TargetFileDir = targetFileDir
                entity.FileType = fileType;
                entity.TitleSplitChar = titleSplitChar;
                entity.TxtSplitChar = txtSplitChar;
                entity.DefaultUserName = defaultUserName;
                entity.NCCodeId = ncCodeId;
                entity.LineId = lineId;
                entity.IsCouplet = isCouplet;
                entity.FileNewPath = fileNewPath;
                entity.TestResultPosition = xml;
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxInterfaceManagement.Edit(entity);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }
                parent.window.Refresh();
            }

            //弹出选择框
            function selectChoosePage(pid) {
                pageId = pid;
                var url = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=" + pageId + "&PageCondition=&Multiple=false&rnd=" + Math.random();
                dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: url, width: 650, height: 350 });
            }

            //获取选中的值
            function getChooseValue(list) {
                if (pageId == 113) {
                    $("#<%=this.hidNCCodeId.ClientID%>").val(list[0][0]);
                    $("#<%=this.txtNCCode.ClientID%>").val(list[0][1]);
                } else if (pageId == 21) {
                    $("#<%=this.hidLineId.ClientID%>").val(list[0][0]);
                    $("#<%=this.txtLineName.ClientID%>").val(list[0][1]);
                }
            }

            function TXTModelDownload() {
                downLoadField('<%=SKT.LeanMES.Web.WebHelper.FileModelRoot+"TXT模板.txt" %>',"txt");
                downLoadField('<%=SKT.LeanMES.Web.WebHelper.FileModelRoot+"TXT拼版模板.txt" %>',"txt拼版");
                return null;
            }

            function CSVModelDownload() {
                downLoadField('<%=SKT.LeanMES.Web.WebHelper.FileModelRoot+"CSV模板.csv" %>','csv');
                downLoadField('<%=SKT.LeanMES.Web.WebHelper.FileModelRoot+"CSV拼版模板.csv" %>','csv拼版');
                return null;
            }

            function EXCELModelDownload() {
                downLoadField('<%=SKT.LeanMES.Web.WebHelper.FileModelRoot+"EXCEL模板.xlsx" %>', 'excel');
                downLoadField('<%=SKT.LeanMES.Web.WebHelper.FileModelRoot+"EXCEL拼版模板.xlsx" %>', 'excel拼版');
                return null;
            }

            function XMLModelDownload() {
                downLoadField('<%=SKT.LeanMES.Web.WebHelper.FileModelRoot+"XML模板.xml" %>','xml');
                downLoadField('<%=SKT.LeanMES.Web.WebHelper.FileModelRoot+"XML拼版模板.xml" %>','xml拼版');
                return null;
            }

            function downLoadField(fieldPath,target) {
                window.open(fieldPath, target);
            }
        </script>
</asp:Content>
