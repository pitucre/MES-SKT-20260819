<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TurnoverRegister.aspx.cs"
    Inherits="SKT.LeanMES.Web.Turnover.TurnoverRegister" MasterPageFile="~/Masters/ViewMaster.master" %>

<asp:Content ContentPlaceHolderID="viewcontent" runat="server">
    <table width="100%" cellpadding="0" cellspacing="3" border="0">
        <tr>
            <td valign="top" width="40%">
                <div class="divHeader">
                    周转工具信息</div>
                <div style="border-left: 1px solid #d3d3d3; border-right: 1px solid #d3d3d3; border-bottom: 1px solid #d3d3d3;
                    border-top: 0px;" id="turnoverInfo">
                    <table width="100%" class="EditeContentTable">
                        <tr>
                            <td class="Label1" style="border-left: 1px solid #f7f7f7;">
                                <%= Resources.lang.TurnoverGroupName%>
                            </td>
                            <td class="Field1" style="border-right: 1px solid #f7f7f7;">
                                <asp:Label ID="lblTurnoverGroupName" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="Label1" style="border-left: 1px solid #f7f7f7;">
                                <%= Resources.lang.TurnoverTypeName%>
                            </td>
                            <td class="Field1" style="border-right: 1px solid #f7f7f7;">
                                <asp:Label ID="lblTurnoverTypeName" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="Label1" style="border-left: 1px solid #f7f7f7;">
                                <%= Resources.lang.MinStowQty%>
                            </td>
                            <td class="Field1" style="border-right: 1px solid #f7f7f7;">
                                <asp:Label ID="lblMinStowQty" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="Label1" style="border-left: 1px solid #f7f7f7;">
                                <%= Resources.lang.MaxStowQty%>
                            </td>
                            <td class="Field1" style="border-right: 1px solid #f7f7f7;">
                                <asp:Label ID="lblMaxStowQty" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="Label1" style="border-left: 1px solid #f7f7f7;">
                                <%= Resources.lang.ItemsName%>
                            </td>
                            <td class="Field1" style="border-right: 1px solid #f7f7f7;">
                                <asp:Label ID="lblItemName" runat="server"></asp:Label>
                            </td>
                        </tr>
                         <tr>
                            <td class="Label1" style="border-left: 1px solid #f7f7f7;">
                                 <%= Resources.lang.ItemCode%>
                            </td>
                            <td class="Field1" style="border-right: 1px solid #f7f7f7;">
                                <asp:Label ID="lblItemCode" runat="server" ClientIDMode="Static"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="Label1" style="border-left: 1px solid #f7f7f7;">
                                <%= Resources.lang.ValidTurnoverQty%>
                            </td>
                            <td class="Field1" style="border-right: 1px solid #f7f7f7;">
                                <asp:Label ID="lblValidTurnoverQty" runat="server" ClientIDMode="Static"></asp:Label>
                            </td>
                        </tr>
                       
                    </table>
                </div>
            </td>
            <td valign="top">
                <div class="wrap_tb" style="height: 90px;">
                    <ul class="tb">
                        <li class="current">注册条码</li>
                        <li>批量导入</li>
                        <li>移除条码</li>
                    </ul>
                    <div class="tb_c" style="padding: 5px;">
                        <div class="Tips" style="font-weight: bold; padding: 3px; line-height: 14px; margin-left: -3px;">
                            请扫描要注册到系统的周转工具条码：</div>
                        <div>
                            <input type="text" id="txtTurnoverNumberAdd" class="TextBox" onclick="selectAll(this)"
                                style="width: 99%; height: 30px; font-weight: bold; text-transform: uppercase;
                                font-size: 22px;" onkeypress="return TurnoverNumberAdd(event)" /></div>
                    </div>
                    <div style="padding: 5px;">
                        <div class="Tips" style="font-weight: bold; padding: 3px; line-height: 14px; margin-left: -3px;">
                            请选择要导入的周转工具条码文件：</div>
                        <asp:FileUpload ID="fileupTurnover" runat="server" Width="85%" />&nbsp;
                        <asp:Button ID="bt_fileupTurnover" runat="server" OnClick="bt_fileupTurnover_Click"
                            CssClass="SearchButton"  Text="<%$Resources:Buttons,COM_Import %>" ToolTip="<%$Resources:Buttons,COM_Import %>"/>
                            <div class="Tips" style=" margin:3px;">批量导入只支持(.txt)格式的文件，请在txt文件中用英文逗号(,)将条码分隔开。</div>
                    </div>
                    <div style="padding: 5px;">
                        <div class="Tips" style="font-weight: bold; padding: 3px; line-height: 14px; margin-left: -3px;">
                            请扫描要从系统中<span style="color: Red;">移除</span>的周转工具条码：</div>
                        <input type="text" id="txtTurnoverNumberDelete" class="TextBox" onclick="selectAll(this)"
                            style="width: 99%; height: 30px; font-weight: bold; text-transform: uppercase;
                            font-size: 22px; color: Red;" onkeypress="return TurnoverNumberDelete(event)" />
                    </div>
                </div>
                <div class="Tips" id="msg" style="text-align: center; height: 14px; overflow: hidden;
                    color: Red;">
                </div>
                <div style="margin: 2px 0px">
                    <!--工具条码列表开始-->
                    <div class="divHeader">
                        <div style="float:left;"><%= Resources.lang.TurnoverNumberList%></div>
                        <div style="float:left;margin-left:85px;">
                            <input type="text" id="searchNumFilter" class="TextBox" />
                            <input style="margin-left:10px;" type="button" id="searchNum" value="查询" class="SearchButton" title="查询">
                        </div>
                        <div class="clear0"></div>
                    </div>
                    <div id="divTurnoverNumberList" style="overflow: auto; border: 1px solid #d3d3d3;
                        border-top: 0px;">
                        <table width="100%" class="ListTable">
                            <tr class="ListTableHeader">
                                <th>
                                    <%= Resources.lang.TurnoverNumber%>
                                </th>
                                <th width="70px">
                                    状态
                                </th>
                            </tr>
                            <asp:Localize ID="llTurnoverSNList" runat="server"></asp:Localize>
                        </table>
                    </div>
                    <!--工具条码列表结束-->
                </div>
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        var Id = '<%= Request.QueryString["Id"]%>';
        $(document).ready(function () {
            $("#turnoverInfo").height($(window).height() - 68);
            $("#divTurnoverNumberList").height($(window).height() - 175);
            $("#searchNum").bind("click", searchNum);
            $("#searchNumFilter").bind("keydown", function (e) {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    searchNum();
                    return false;
                }
            });
        });


        //覆盖js插件中的方法(取消回车键在INPUT,SELECT下的便捷。)
        function enterToTab() { }

        function selectAll(obj) {
            $(obj).select();
        }

        /*条码注册
        只要按下回车，执行完毕后都是返回false。用于阻止其它的回车默认事件。
        按下其它键，返回true。
        */
        function TurnoverNumberAdd(event) {
            $("#msg").html("");
            var divhtmlindex = -1;
            var divhtml = "";

            var e = event || window.event
            if (e && e.keyCode == 13) {
                var txtTurnoverNumber = $("#txtTurnoverNumberAdd").val();

                if (!isNumbOrLett(txtTurnoverNumber)) {
                    //alert('<%= Resources.Messages.TurnoverNumberFormatError %>');
                    $("#msg").html('<%= Resources.Messages.TurnoverNumberFormatError %>');
                    aimRun($("#msg"));
                    $("#txtTurnoverNumberAdd").val("");
                    $("#txtTurnoverNumberAdd").focus();
                    return false;
                }
                else {
                    txtTurnoverNumber = txtTurnoverNumber.replace(/ /g, "");

                    var entity = {};
                    entity.TurnoverGroupId = Id;
                    entity.TurnoverDataId = -1;
                    entity.TurnoverStatusId = 1;
                    entity.TurnoverNumber = txtTurnoverNumber;

                    var ajaxAdd = SKT.LeanMES.Web.AjaxServices.AjaxTurnover.TurnoverNumberAdd(entity);
                    if (ajaxAdd.error != null) {
                        //alert(ajaxAdd.error.Message);
                        $("#msg").html(ajaxAdd.error.Message);
                        aimRun($("#msg"));
                        $("#txtTurnoverNumberAdd").val("");
                        $("#txtTurnoverNumberAdd").focus();
                        return false;
                    }
                    else {
                        $(".ListTableEmptyDataRow").remove();
                        $("#txtTurnoverNumberAdd").val("");
                        $("#txtTurnoverNumberAdd").focus();
                        $("#lblValidTurnoverQty").text(parseInt($("#lblValidTurnoverQty").text()) + 1);
                        var rowLen = $("#divTurnoverNumberList table tr:gt(0)").length;
                        var rowClassName = "ListTableOddRow";
                        if (rowLen % 2 == 0) {
                            rowClassName = "ListTableEvenRow";
                        }
                        else {
                            rowClassName = "ListTableOddRow";
                        }
                        var shtml = "<tr class='" + rowClassName + "'><td>" + txtTurnoverNumber + "</td><td>闲置</td></tr>";
                        $("#divTurnoverNumberList table tr:eq(0)").after(shtml);
                        $("#msg").html("<span style='color:green;'>条码：" + txtTurnoverNumber + " 注册成功！</span>");
                        aimRun($("#msg"));
                        return false;
                    }
                }
            }
            return true;
        }

        /*条码移除      
        只要按下回车，执行完毕后都是返回false。用于阻止其它的回车默认事件。
        按下其它键，返回true。
        */
        function TurnoverNumberDelete(event) {
            $("#msg").html("");
            var divhtmlindex = -1;
            var divhtml = "";

            var e = event || window.event;
            if (e && e.keyCode == 13) {
                var txtTurnoverNumber = $("#txtTurnoverNumberDelete").val();

                if (!isNumbOrLett(txtTurnoverNumber)) {
                    //alert('<%= Resources.Messages.TurnoverNumberFormatError %>');
                    $("#msg").html('<%= Resources.Messages.TurnoverNumberFormatError %>');
                    aimRun($("#msg"));
                    $("#txtTurnoverNumberDelete").val("");
                    $("#txtTurnoverNumberDelete").focus();
                    return false;
                }
                else {
                    txtTurnoverNumber = txtTurnoverNumber.replace(/ /g, "");

                    var ajaxDelete = SKT.LeanMES.Web.AjaxServices.AjaxTurnover.TurnoverNumberDelete(txtTurnoverNumber, Id);
                    if (ajaxDelete.error != null) {
                        //alert(ajaxDelete.error.Message);
                        $("#msg").html(ajaxDelete.error.Message);
                        aimRun($("#msg"));
                        $("#txtTurnoverNumberDelete").val("");
                        $("#txtTurnoverNumberDelete").focus();
                        return false;
                    }
                    else {
                        $("#txtTurnoverNumberDelete").val("");
                        $("#txtTurnoverNumberDelete").focus();
                        $("#lblValidTurnoverQty").text(parseInt($("#lblValidTurnoverQty").text()) - 1);
                        $("#divTurnoverNumberList table tr:gt(0)").each(function () {
                            if ($(this).children("td:eq(0)").html() == txtTurnoverNumber) {
                                $(this).remove();
                                return false;
                            }
                        });
                        $("#msg").html("<span style='color:green;'>条码：" + txtTurnoverNumber + " 移除成功！</span>");
                        aimRun($("#msg"));
                        return false;
                    }
                }
            }
            return true;
        }

        /* 
        用途：检查输入字符串是否为空或者全部都是空格 
        输入：str 
        返回：如果全是空返回true,否则返回false 
        */
        function isNull(str) {
            if (str == "") return true;
            var regu = "^[ ]+$";
            var re = new RegExp(regu);
            return re.test(str);
        }

        /* 
        用途：检查输入字符串是否只由汉字、字母、数字组成 并限制字符串长度不超过50
        输入：value：字符串 
        返回：如果通过验证返回true,否则返回false 
        */
        function isNumbOrLett(s) {
            var regu = "^[0-9a-zA-Z_-]{1,50}$";
            var re = new RegExp(regu);
            if (re.test(s)) {
                return true;
            } else {
                return false;
            }
        }

        var colors = ["#ffffff", "RED", "#ffffff", "RED"];
        var colorsLength = colors.length;
        var i = 0;
        var aimRun = function (aim) {
            if (aim == null) {
                clearInterval(aimInterval);
                return;
            }

            var idx = 0;
            var o = false;
            aimInterval = setInterval(function () {
                i += 1;
                if (i == 5) {
                    i = 0;
                    clearInterval(aimInterval);
                }
                aim.css({ color: colors[idx] });
                o = o ? !(--idx < 1) : ++idx + 1 > colorsLength;
            }, 100);

            setTimeout(function () { $("#msg").html(""); }, 3000);
        };

        //查询周转工具编码列表
        function searchNum() {
            var filter = $.trim($("#searchNumFilter").val());
            if (filter) {
                var rows = $("#divTurnoverNumberList table tr").not(".ListTableHeader");
                $(rows).each(function () {
                    var cols = $(this).find("td");
                    var isMatch = false;
                    $(cols).each(function () {
                        var text = $(this).text().toUpperCase();
                        if (text.indexOf(filter.toUpperCase()) != -1) {
                            isMatch = true;
                        }
                    });
                    if (isMatch) {
                        $(this).show();
                    }
                    else {
                        $(this).hide();
                    }

                });
            } else {
                $("#divTurnoverNumberList table tr:hidden").show();
            }
        }
    </script>
</asp:Content>
