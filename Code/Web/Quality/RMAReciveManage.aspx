<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="RMAReciveManage.aspx.cs" Inherits="SKT.LeanMES.Web.Quality.RMAReciveManage" %>

<%@ MasterType VirtualPath="~/Masters/EditMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label3">RMA单号
            </td>
            <td class="Field3">
                <span id="lblRMANo" runat="server"></span>
            </td>
            <td class="Label3">客户
            </td>
            <td class="Field3">
                <span id="lblCustomerName" runat="server"></span>
            </td>
            <td class="Label3">产品名称
            </td>
            <td class="Field3">
                <span id="lblItemName" runat="server"></span>
            </td>
        </tr>
        <tr>
            <td class="Label3">申请数量
            </td>
            <td class="Field3">
                <span id="lblNumber" runat="server"></span>
            </td>
            <td class="Label3">产品编码
            </td>
            <td class="Field3">
                <span id="lblItemCode" runat="server"></span>
            </td>
            <td class="Label3">规格
            </td>
            <td class="Field3">
                <span id="lblItemSpec" runat="server"></span>
            </td>
        </tr>
        <tr>
            <td class="Label3">良品数量
            </td>
            <td class="Field3">
                <span id="lblGoodNum" runat="server"></span>
            </td>
            <td class="Label3">不良数量
            </td>
            <td class="Field3">
                <span id="lblFailNum" runat="server"></span>
            </td>
            <td class="Label3">废品数量
            </td>
            <td class="Field3">
                <span id="lblScrapNum" runat="server"></span>
            </td>
        </tr>
        <tr>
            <td class="Label3">仓库<em>*</em>
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtWhInfo" runat="server" CssClass="TextBox" MaxLength="20" Enabled="false" Width="145px"
                    IsRequired='1' ClientIDMode="Static"> 
                </asp:TextBox><input type="button" id="btnselectWhInfo" class="ButtonBox" value="..."
                    title="Select" onclick="selectWhInfo();"/>
                <asp:HiddenField ID="hdnWhCode" runat="server" Value="" ClientIDMode="Static" />
            </td>
            <td class="Label3">库位
            </td>
            <td class="Field3" colspan="3">
               
                 <asp:TextBox ID="txtBarcode" runat="server" CssClass="TextBox" ClientIDMode="Static"
                            ReadOnly="true"></asp:TextBox><input id="button2" class="ButtonBox" type="button" onclick="selectWhBarCodeList()"
                                value="..." title="选择库位" />
                <%-- <asp:TextBox ID="txtBarcode" CssClass="text" Width="155px" runat="server"></asp:TextBox>--%>
            </td>
        </tr>
        <tr>
            <td class="Label3">产品状态<em>*</em>
            </td>
            <td class="Field3">
                <asp:DropDownList runat="server" ID="ddlProductionStatus" Width="163px" Height="25px">
                    <asp:ListItem Text="良品" Value="0"></asp:ListItem>
                    <asp:ListItem Text="不良品" Value="1"></asp:ListItem>
                    <asp:ListItem Text="报废品" Value="2"></asp:ListItem>
                </asp:DropDownList>
            </td>
            <td class="Label3">不良代码
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtNCCodeId" runat="server" CssClass="TextBox" ClientIDMode="Static"
                    ReadOnly="true"></asp:TextBox><input type="button" id="Button1" class="ButtonBox"
                        value="..." onclick="selectChoosePage(113);" />
                <asp:HiddenField ID="hidNCCodeId" runat="server" Value="-1" />
            </td>
            <td class="Label3">产品条码<em>*</em>
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtSerialNumber" CssClass="TextBox" Width="163px" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td colspan="6" align="center" style="height:30px">
                <input type="button" class="button" id="btnRecive" value="   接收   " style="font-size: 12px;font-family:Verdana,微软雅黑,黑体, 宋体;color: #000000;
               height: 23px; background: #f1f1f1; border: 1px solid #d3d3d3;" onclick="AddRecive()" />
            </td>
        </tr>
        <tr>
            <td style="text-align: center" colspan="6">
                <div id="msg"></div>
            </td>
        </tr>
    </table>
    <div id='ReportList'></div>
    <input id="txtOldSN" name="txtOldSN" />
    <link href="../Content/plugin/jquery-easyui-1.4.2/themes/default/easyui.css" rel="stylesheet" type="text/css" />
    <link href="../Content/plugin/jquery-easyui-1.4.2/themes/icon.css" rel="stylesheet" type="text/css" />
    <script src="../Content/plugin/jquery-easyui-1.4.2/jquery.min.js" type="text/javascript"></script>
    <script src="../Content/plugin/jquery-easyui-1.4.2/jquery.easyui.min.js" type="text/javascript"></script>
    <script src="../Content/plugin/layer/layer.js" type="text/javascript"></script>
    <script language="javascript" type="text/javascript">
        var flag = -1;
        var iRMAID = '<%=Request.QueryString["ID"]%>';
        $(document).ready(function() {
            recive();
            $("#<%= txtSerialNumber.ClientID %>").keydown(function () {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {                    
                    AddRecive();
                    e.preventDefault();
                }
            });
        });

        function selectWhInfo() {
            flag = 14
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=14&Multiple=false&rnd=" + Math.random(), width: 500, height: 300 });            
        }

        function selectChoosePage(iflag) {
            flag = iflag;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=113&PageCondition=&Multiple=false&rnd=" + Math.random(), width: 500, height: 300 });
        }

           /**
        *选择库位
        **/
        function selectWhBarCodeList() {
            var whCode = $("#hdnWhCode").val();
            if (whCode == "") {
                alert("请先选择仓库！");
                return false;
            }
            var conditions = " CWhCode = '" + whCode + "'";
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=117&Multiple=false&CallBackFunc=setWhBarCode&PageCondition=" + escape(conditions) + "&rnd=" + Math.random(), width: 500, height: 300 });
        }

        /**
        *设置库位
        **/
        function setWhBarCode(list) {
            $("#<%= txtBarcode.ClientID %>").val(list[0][3]);
        }

        function getChooseValue(list) {
            if (flag == 14) {
                if (list[0][0] != "-1") {
                    $("#txtWhInfo").val(list[0][1] + "|" + list[0][2]);
                }
                else {
                    $("#txtWhInfo").val("");
                }
                $("#hdnWhCode").val(list[0][1]);
            }
            else if (flag == 113) {
                if ($("#<%= ddlProductionStatus.ClientID %>").val() == "1") {
                    $("#<%=this.hidNCCodeId.ClientID %>").val(list[0][0]);
                    $("#<%=this.txtNCCodeId.ClientID %>").val(list[0][1]);
                }
                else {//modified by zhi.li 增加验证
                    $("#<%= hidNCCodeId.ClientID %>").val("-1");
                    $("#<%=this.txtNCCodeId.ClientID %>").val("");
                    alert("良品和报废品不需要填【不良代码】!");
                    return;
                }     
            }
        }

        function AddRecive() {            
            var number = parseInt($("#<%= lblNumber.ClientID %>").text());
            var goodnum = parseInt($("#<%= lblGoodNum.ClientID %>").text());
            var failnum = parseInt($("#<%= lblFailNum.ClientID %>").text());
            var scrapnum = parseInt($("#<%= lblScrapNum.ClientID %>").text());            
            if (goodnum + failnum + scrapnum + 1 > number) {
                alert("已接收数量不能大于申请数量!");
                return;
            }

            var entity = {};
            entity.RMAUnitID = -1;
            entity.RMAID = iRMAID;
            entity.SerialNumber = $.trim($("#<%= txtSerialNumber.ClientID %>").val());
            entity.Status = $("#<%= ddlProductionStatus.ClientID %>").val();
            entity.FailCode = $("#<%= hidNCCodeId.ClientID %>").val();
            entity.cWhCode = $.trim($("#hdnWhCode").val());
            entity.cBarCode = $("#<%= txtBarcode.ClientID %>").val();

            if (entity.SerialNumber == "") {
                alert("请输入产品序列号!");
                //$("#msg").html("请输入产品序列号!").css("color", "red");
                return;
            }

            if ($("#txtWhInfo").val() == "") {
                alert("请选择仓库!");
                //$("#msg").html("请选择仓库!").css("color", "red");
                return;
            }

            if (entity.Status == "1" && entity.FailCode == "-1") {
                alert("状态为“不良品”的产品需要选择“不良代码”!");
                //$("#msg").html("状态为“不良品”的产品需要选择“不良代码”!").css("color", "red");
                return;
            }
         
            var ajax = SKT.LeanMES.Web.Quality.RMAReciveManage.AddReciveData(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            //如果接收数量完成，则关闭当前RMA单，刷新主界面
            if (goodnum + failnum + scrapnum + 1 == number) {
                alert("接收成功,全部产品接收完成！");
                parent.window.Refresh();
            }
            else {
                alert("接收成功!");

                if (entity.Status == 0) {
                    goodnum = parseInt($("#<%= lblGoodNum.ClientID %>").text());
                    $("#<%= lblGoodNum.ClientID %>").text((goodnum + 1));
                }
                else if (entity.Status == 1) {
                    failnum = parseInt($("#<%= lblFailNum.ClientID %>").text());
                    $("#<%= lblFailNum.ClientID %>").text((failnum + 1));
                }
                else if (entity.Status == 2) {
                    scrapnum = parseInt($("#<%= lblScrapNum.ClientID %>").text());
                    $("#<%= lblScrapNum.ClientID %>").text((scrapnum + 1));
                }

                recive();

                $("#<%= txtSerialNumber.ClientID %>").focus().select();
            }            
        }

        function Delete(RMAUnitID, Status) {
            var ajax = SKT.LeanMES.Web.Quality.RMAReciveManage.DeleteReciveData(RMAUnitID);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert("删除成功");
            var goodnum = parseInt($("#<%= lblGoodNum.ClientID %>").text());
            var failnum = parseInt($("#<%= lblFailNum.ClientID %>").text());
            var scrapnum = parseInt($("#<%= lblScrapNum.ClientID %>").text());    
            if (Status == 0) {
                $("#<%= lblGoodNum.ClientID %>").text(goodnum - 1);
            }
            else if (Status == 1) {
                $("#<%= lblFailNum.ClientID %>").text(failnum - 1);
            }
            else if (Status == 2) {
                $("#<%= lblScrapNum.ClientID %>").text(scrapnum - 1);
            }
            recive();
        }

        function recive() {            
            $('#ReportList').datagrid({
                height: $(window).height() - 250,
                url: '../Handler/MenCallMaterial.ashx', //查询数据地址
                queryParams: {
                    type: "GetRMAUnitInfo", RMAID: iRMAID
                },
                
                striped: true,
                //fit:true,
                fitColumns: false,
                singleSelect: false, //多选
                rownumbers: false,  //显示行号
                pagination: true, //分页
                nowrap: false,
                width: '100%',
                showFooter: true,
                loadMsg: '加载中，请稍候…',
                pageSize: 10,
                pageList: [10, 20, 50, 100, 150, 200],
                idField: 'RMAUnitID',
                columns: [[
                    {
                        field: '序号', title: mesLang('序号'), width: 35, align: 'left',
                                formatter: function (value, row, index) {   //格式化函数添加一个操作列
                                    var str =index+1;
                                    return str;
                                }
                            },
                    { field: 'RmaNo', title: mesLang('RMA单号'), width: 90, align: 'left' },
                    { field: 'SN', title: mesLang('产品条码'), width: 100, align: 'left' },
                    { field: 'StatusName', title: mesLang('产品状态'), width: 90, align: 'left' },
                    { field: 'ItemCode', title: mesLang('产品编码'), width: 100, align: 'left' },
                    { field: 'ItemName', title: mesLang('产品名称'), width: 90, align: 'left' },
                    { field: 'ItemSpec', title: mesLang('规格'), width: 90, align: 'left' },
                    { field: 'CWhName', title: mesLang('仓库名称'), width: 90, align: 'left' },
                    { field: 'cBarCode', title: mesLang('库位'), width: 90, align: 'left' },
                    {
                        field: '操作', title: mesLang('操作'), width: 40, align: 'left',
                                 formatter: function (value, row, index) {   //格式化函数添加一个操作列
                                     var str = '<a href="#" style ="height:23px;" onclick="Delete(\'' + row.RMAUnitID + '\',\'' + row.Status + '\')">' +mesLang('删除')+'</a>';
                                     return str;
                                 }
                             }
                ]],
                onLoadError: function (XMLHttpRequest, textStatus, errorThrown) {                    
                    alert("加载接收产品数据失败");
                },
                onLoadSuccess: function (data) {
                   
                }
            });

            //#region 格式化分页提示
            var p = $('#ReportList').datagrid('getPager');
            $(p).pagination({
                beforePageText: '第', //页数文本框前显示的汉字           
                afterPageText: '页    共 {pages} 页',
                displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录'
            });
            //#endregion

            //清除选中状态
            $('#ReportList').datagrid('clearSelections');
        }
    </script>
</asp:Content>
