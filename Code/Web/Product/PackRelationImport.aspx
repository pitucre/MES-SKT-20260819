<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master"
    AutoEventWireup="true" CodeBehind="PackRelationImport.aspx.cs" Inherits="SKT.LeanMES.Web.Product.PackRelationImport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <fieldset style="height: 210px">
        <legend><% =Resources.lang.MainInformation %></legend>
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
                    <asp:TextBox ID="txtCustomerOrder" runat="server" CssClass="TextBox"  ClientIDMode="Static"></asp:TextBox>
                </td>
                <td class="Label3">数量<em>*</em>
                </td>
                <td class="Field3">
                    <asp:TextBox ID="txtQty" runat="server" CssClass="TextBox" ClientIDMode="Static" isrequired="1"  onkeyup="if(isNaN(value))execCommand('undo')"
                        onafterpaste="if(isNaN(value))execCommand('undo')"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="Label3">客户条码列<em>*</em>
                </td>
                <td class="Field3">
                    <asp:TextBox ID="txtColumn1" runat="server" Width="62%" CssClass="TextBox"  ClientIDMode="Static" isrequired="1"></asp:TextBox>
                </td>
                <td class="Label3">
                    大箱列<em>*</em>
                </td>
                <td class="Field3">
                    <asp:TextBox ID="txtColumn2" runat="server" CssClass="TextBox"  ClientIDMode="Static" isrequired="1"></asp:TextBox>
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
                <th>客户条码</th>
                <th>大箱</th>
                <th>错误信息</th>
            </tr>
        </thead>
        <tbody>
            <tr id="trLast" class="ListTableOddRow">
                <td colspan="4" style="text-align: center;"><span>暂无数据</span>
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
            $("#txtCustomerOrder").attr("readonly", "readonly");
            $("#txtQty").attr("readonly", "readonly");
        });

        function uploadFile(filePath) {
            if (filePath != "") {
                
                var OrderNo = $("#txtOrderNo").val();//工单
                var CustomerOrder = $("#txtCustomerOrder").val();//订单
                var Qty = $("#txtQty").val();//数量
                var Column1 = $("#txtColumn1").val();//导入列1
                var Column2 = $("#txtColumn2").val();//导入列2

                
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

                //判断是否输入工单数量
                if (Qty == "") {
                    alert("请输入数量");
                    $('#<%= fuPickList.ClientID %>').val('');
                    return false;
                }
                //判断是否输入客户条码列
                if (Column1 == "") {
                    alert("请输入客户条码列");
                    $('#<%= fuPickList.ClientID %>').val('');
                    return false;
                }
                //判断客户条码列是否大于1
                if (parseInt(Column1) <= 1) {
                    alert("客户条码列必须大于1");
                    $('#<%= fuPickList.ClientID %>').val('');
                    return false;
                }
                //判断是否输入大箱列
                if (Column1 == "") {
                    alert("请输入大箱列");
                    $('#<%= fuPickList.ClientID %>').val('');
                    return false;
                }
                //判断大箱列是否大于1
                if (parseInt(Column1) <= 1) {
                    alert("大箱列必须大于1");
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
            $("#txtCustomerOrder").val(list[0][6]);
            $("#txtQty").val(list[0][3]);
        }

        //导入成功后台调用前端方法
        function ShowErrorPackRelation(entity) {
            setTimeout(function () {
                load(entity);
            }, 500);
        }
        //显示错误条码信息
        function load(entity) {

            var logList = '';
            var _css = 'ListTableOddRow';
            $("#tblErrorBarCode tr:gt(0)").remove();
            for (var i = 0; i < entity.length; i++) {
                if (i % 2 == 0) _css = 'ListTableEvenRow';
                else _css = 'ListTableOddRow';
                logList += '<tr onclick="trClick(this)" class="' + _css + '">';
                logList += '<td>' + (i + 1).toString() + '</td>';
                logList += '<td>' + entity[i].SerialNumber + '</td>';
                logList += '<td>' + entity[i].SerialNumber1 + '</td>';
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
            $("#txtOrderNo").val("");//工单
            $("#txtCustomerOrder").val("");//订单
            $("#txtQty").val("");//数量
            $("#txtColumn1").val("");//导入列
            $("#txtColumn2").val("");//导入列
        }


        //行点击事件
        function trClick(obj) {
            $("#tblErrorBarCode tbody").find("td").css('background', '#fff');
            $(obj).find("td").css('background', '#ACBAD4');
        }

        function ShowRule() {
            var hint = "1、导入Excel的第一行必须是表头行</br>";
            hint += "2、第一列必须有一列为编号列</br>";
            hint += "3、客户条码列意思为取Excel的第几列数据作为客户条码导入</br>";
            hint += "4、大箱列意思为取Excel的第几列数据作为大箱号码导入</br>";
            hint += "5、设置客户条码列或大箱列必须大于1因为第一列为编号列</br>";
            hint += "6、客户条码列与大箱列不能相同</br>";
            layer.alert(hint, { skin: 'layui-layer-bai', closeBtn: 0,area: ['430px'], });
        }
    </script>
</asp:Content>