<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master"
    AutoEventWireup="true" CodeBehind="BarCodeScopeImport.aspx.cs" Inherits="SKT.LeanMES.Web.Product.BarCodeScopeImport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <fieldset style="height: 210px">
        <legend><%=Resources.lang.MainInformation %></legend>
        <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %></div>
        <table width="100%" class="EditeContentTable">
            <tr>
                <td class="Label3">工单号<em>*</em>
                </td>
                <td class="Field3">
                    <asp:TextBox ID="txtOrderNo" runat="server" CssClass="TextBox" ClientIDMode="Static" isrequired="1"></asp:TextBox>
                    <input type="button" id="bnOper" class="ButtonBox" onclick="openChoosePage()" value="..." />
                </td>
                <td class="Label3">订单号
                </td>
                <td class="Field3">
                    <%--<asp:TextBox ID="txtCustomerOrder" runat="server" CssClass="TextBox"  ClientIDMode="Static"</asp:TextBox>--%>
                    <asp:Label ID="CustomerOrder" runat="server" ClientIDMode="Static"></asp:Label>
                </td>
                <td class="Label3">数量<em>*</em>
                </td>
                <td class="Field3">
                    <asp:TextBox ID="txtQty" runat="server" CssClass="TextBox" ClientIDMode="Static" isrequired="1"  onkeyup="if(isNaN(value))execCommand('undo')"
                        onafterpaste="if(isNaN(value))execCommand('undo')"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="Label3">号码类型<em>*</em>
                </td>
                <td class="Field3">
                    <asp:DropDownList ID="ddlNumberType" runat="server" ClientIDMode="Static" isrequired="1" Width="63%">
                    </asp:DropDownList>
                </td>
                <td class="Label3">号码分类<em>*</em>
                </td>
                <td class="Field3">
                    <asp:DropDownList ID="ddlClass" runat="server" ClientIDMode="Static" isrequired="1" Width="56%">
                        <asp:ListItem Value="普通类型">普通类型</asp:ListItem>
                        <asp:ListItem Value="MAC类型">MAC类型</asp:ListItem>
                        <asp:ListItem Value="STB类型">STB类型</asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td class="Label3">主号码<em>*</em>
                </td>
                <td class="Field3">
                    <asp:DropDownList ID="ddlIsMain" runat="server" ClientIDMode="Static" isrequired="1" Width="56%">
                        <asp:ListItem Value="否">否</asp:ListItem>
                        <asp:ListItem Value="是">是</asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td class="Label3">设置导入列1<em>*</em>
                </td>
                <td class="Field3">
                    <asp:TextBox ID="txtColumn1" runat="server" CssClass="TextBox" Width="62%" ClientIDMode="Static" isrequired="1"></asp:TextBox>
                </td>
                <td class="Label3">
                </td>
                <td class="Field3">
                    
                </td>
                <td class="Label3">
                </td>
                <td class="Field3">
                    <input id="btnEmpty" type="button" value="导入规则说明" onclick="ShowRule()" />
                </td>
            </tr>
            <tr>
                <td class="Label3">导入文件<em>*</em>
                </td>
                <td class="Field3" colspan="5">
                    <asp:FileUpload ID="fuPickList" Width="52%" runat="server"   onchange="uploadFile(this.value)"/>
                    <asp:LinkButton ID="linkUploadFile" runat="server" OnClick="linkUploadFile_Click"></asp:LinkButton>
                </td>
            </tr>
        </table>
    </fieldset>

    <div class="ListTableTitle">
        <div style="left: 10px; top: 0px; line-height: 18px;">
            错误号码列表
        </div>
    </div>
    <table class="ListTable" width="100%" id="tblErrorBarCode" >
        <thead>
            <tr class="ListTableHeader" style="text-align: center">
                <th style="width:5%">序号</th>
                <th style="width:10%">号码类型</th>
                <th style="width:10%">号码分类</th>
                <th>号码</th>
                <th style="width:7%">是否主条码</th>
                <th>错误信息</th>
            </tr>
        </thead>
        <tbody>
            <tr id="trLast" class="ListTableOddRow">
                <td colspan="6" style="text-align: center;">暂无数据
                </td>
            </tr>
        </tbody>
    </table>
    <style type="text/css">
        fieldset {
            border: #2491BF solid 1px;
        }

        legend {
            font-size: 13px;
            font-weight: bold;
            color: #296AA0;
            background-repeat: no-repeat;
            height: 24px;
            padding-top: 2px;
            padding-left: 5px;
        }
    </style>
    <script type="text/javascript" src="../Content/js/jquery-3.1.0.min.js"></script>
    <script type="text/javascript" src="../Content/plugin/jquery-easyui-1.4.2/layer/layer.js"></script>
    <script type="text/javascript">
        
        $(function () {
            $('#ddlClass').change(function () {
                
            });
            //$("#txtCustomerOrder").attr("readonly", "readonly");
            $("#txtQty").attr("readonly", "readonly");
        });

        function uploadFile(filePath) {
            if (filePath != "") {
                var NumberType = $("#ddlNumberType").val();//号码类型
                var NumberClass = $("#ddlClass").val();//号码分类
                var IsMain = $("#ddlIsMain").val();//是否主号码
                var OrderNo = $("#txtOrderNo").val();//工单
                var CustomerOrder = $("#CustomerOrder").text();//订单
                var Qty = $("#txtQty").val();//数量
                var Column1 = $("#txtColumn1").val();//导入列

                //判断是否选择号码类型
                if (NumberType == "") {
                    alert("请选择号码类型");
                    return false;
                }
                //判断是否选择号码分类
                if (NumberClass == "") {
                    alert("请选择号码分类");
                    return false;
                }
                //判断是否选择主号码
                if (IsMain == "") {
                    alert("请选择是否主号码");
                    return false;
                }
                //判断是否选择工单
                if (OrderNo == "") {
                    alert("请选择工单号码");
                    $('#<%= fuPickList.ClientID %>').val('');
                    return false;
                }
                //判断是否输入订单
                <%--if (CustomerOrder.replace(/(^\s*)|(\s*$)/g, "") == "") {
                    alert("请输入订单号码");
                    $('#<%= fuPickList.ClientID %>').val('');
                    return false;
                }--%>
                //判断是否选择号码类型
                if (Qty == "") {
                    alert("请输入数量");
                    $('#<%= fuPickList.ClientID %>').val('');
                    return false;
                }
                //判断是否选择号码类型
                if (Column1 == "") {
                    alert("请输入导入列1");
                    $('#<%= fuPickList.ClientID %>').val('');
                    return false;
                }
                //判断是否选择号码类型
                if (parseInt(Column1) <= 1) {
                    alert("导入列必须大于1");
                    $('#<%= fuPickList.ClientID %>').val('');
                    return false;
                }


                //var index = layer.load(2, { shade: false });
                //$("#spmessinfo").text("正在加载中...");
                if (filePath.length > 0) {
                    var str = '';
                    var postback = $('#<%= linkUploadFile.ClientID %>').attr('href');
                    var funcStartIndex = postback.indexOf('\'');
                    var funcEndIndex = postback.indexOf('\',');
                    if (funcStartIndex != -1 && funcEndIndex != -1) {
                        var str = postback.substring(funcStartIndex + 1, funcEndIndex);
                        __doPostBack(str, '');
                    } else {
                        return false;
                    }
                }
            }
        }

        function openChoosePage(flags) {
            dialog({ title: "选择窗口", src: "../Framework/ChoosePage.aspx?PageId=44&Multiple=false&rnd=" + Math.random(), width: 600, height: 300 });
        }
        function getChooseValue(list) {
            $("#txtOrderNo").val(list[0][1]);
            $("#CustomerOrder").text(list[0][6]);
            $("#txtQty").val(list[0][3]);
        }

        
        function ShowErrorBarCode(entity) {
            setTimeout(function () {
                load(entity);
            }, 500);
        }

        function load(entity) {
            var NumberType = $("#ddlNumberType").val();//号码类型
            var NumberClass = $("#ddlClass").val();//号码分类
            var IsMain = $("#ddlIsMain").val();//是否主号码

            var logList = '';
            var _css = 'ListTableOddRow';
            $("#tblErrorBarCode tr:gt(0)").remove();
            for (var i = 0; i < entity.length; i++) {
                if (i % 2 == 0) _css = 'ListTableEvenRow';
                else _css = 'ListTableOddRow';
                logList += '<tr onclick="trClick(this)" class="' + _css + '">';
                logList += '<td>' + (i + 1).toString() + '</td>';
                logList += '<td>' + NumberType + '</td>';
                logList += '<td>' + NumberClass + '</td>';
                logList += '<td>' + entity[i].SerialNumber + '</td>';
                logList += '<td>' + IsMain + '</td>';
                logList += '<td>' + entity[i].ErrorMessage + '</td>';
                logList += '</tr>';
            }
            $("#tblErrorBarCode").append(logList);
            if (entity.length <= 0) {
                alert("导入成功！");
                EmptyText();
                document.forms[0].submit();
            }
        }
        //清空文本框
        function EmptyText() {
            $("#ddlClass").val("普通类型");//号码分类
            $("#ddlIsMain").val("否");//是否主号码
            $("#txtOrderNo").val("");//工单
            $("#CustomerOrder").text("");//订单
            $("#txtQty").val("");//数量
            $("#txtColumn1").val("");//导入列
        }


        //隐藏/显示TR
        function HideShow() {
            
        }

        //行点击事件
        function trClick(obj) {
            $("#tblErrorBarCode tbody").find("td").css('background', '#fff');
            $(obj).find("td").css('background', '#ACBAD4');
        }

        function ShowRule() {
            layer.alert('1、导入Excel的第一行必须是表头行</br>2、第一列必须有一列为编号列</br>3、设置导入列意思为取Excel的第几列数据导入</br>4、设置导入列必须大于1因为第一列为编号列', { skin: 'layui-layer-bai', closeBtn: 0 });
        }
    </script>
</asp:Content>

