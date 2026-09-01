<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" CodeBehind="PreSNPrintList.aspx.cs" Inherits="SKT.LeanMES.Web.Product.PreSNPrintList" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">

    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label3">条码类型</td>
            <td class="Field3">
                <asp:DropDownList ID="ddlSNType" runat="server">
                    <asp:ListItem Value="">--请选择--</asp:ListItem>
                    <asp:ListItem Value="0">SMT包装箱</asp:ListItem>
                    <asp:ListItem Value="-22">中箱条码</asp:ListItem>
                    <asp:ListItem Value="-4">包装条码</asp:ListItem>
                    <asp:ListItem Value="-5">栈板条码</asp:ListItem>
                    <asp:ListItem Value="-16">客户条码</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td class="Label3">工单</td>
            <td class="Field3">
                <asp:TextBox ID="txtOrderNo" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">条码</td>
            <td class="Field3">
                <asp:TextBox ID="txtPSN" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="searchConditions" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="PSNType" HeaderText="条码规则类型" ItemStyle-Width="100px" ItemStyle-CssClass="sn-type" />
            <asp:BoundField DataField="OrderNo" HeaderText="工单号" />
            <asp:BoundField DataField="ItemCode" HeaderText="产品编码" />
            <asp:BoundField DataField="PSN" HeaderText="条码" ItemStyle-CssClass="sn" />
            <asp:BoundField DataField="Status" HeaderText="条码状态" ItemStyle-Width="100px" />
            <asp:BoundField DataField="CreateBy" HeaderText="打印人" ItemStyle-Width="100px" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="打印时间" ItemStyle-Width="140px" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true"
        StartRowIndexParameterName="startRow" MaximumRowsParameterName="maxRows" SortParameterName="sortExpression"
        TypeName="SKT.LeanMES.ProdUnit.BLL.PrepSerialNumber" SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <script type="text/javascript" src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/layui/layui.all.js"></script>
    <link href="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/layui/css/layui.css" rel="stylesheet" />
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/ws.js" type="text/javascript"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.utility.printer.js?v=1" type="text/javascript"></script>
    <script type="text/javascript">
        isMultiple = false;
        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");

        $(document).ready(function () {
            $("div.noInstallPrintPlugin").remove();
        });
        function loadJs(url, callback) {
            var script = document.createElement("script")
            script.type = "text/javascript";
            if (script.readyState) {
                script.onreadystatechange = function () {
                    if (script.readyState == "loaded" || script.readyState == "complete") {
                        script.onreadystatechange = null;
                        callback();
                    }
                };
            } else {
                script.onload = function () {
                    callback();
                };
            }
            script.src = url;
            document.body.insertBefore(script, document.body.firstChild);//在得到的第一个元素之前插入            
        }

        function Print() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Product/PreSNPrint.aspx?name=PreSNPrint";
            dialog({ title: "<%=Resources.Pages.PreSNPrint %>", src: openWinUrl, width: 850, height: 500 });
        }

        function RePrint() {

            SNInfo = [];
            var snStr = "";
            $("input[name='chkSelect']:checked").each(function () {
                snStr = $(this)[0].parentElement.parentElement.cells[4].innerText;
                SNInfo.push(snStr);
            });
            var idsStr=getRecordIdString();

            if(snStr=="") return;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Product/PreSNRePrint.aspx?name=PreSNRePrint&id="+idsStr+"&snInfo="+SNInfo.join(',');
            dialog({ title: "<%=Resources.Pages.PreSNRePrint %>", src: openWinUrl, width: 450, height: 200 });
            //var idStr = getRecordIdString();
            //var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPreSNPrint.GetPrepSNReprintInfo(idStr);
            //if (ajax.error != null) {
            //    alert(ajax.error.Message);
            //    return false;
            //}

            
            //labelItemId = ajax.value[0];
            //labelType = ajax.value[1];
            //labelSequence = ajax.value[2];

            
            //debugger;
            //if (getDocumentInfo()) {
            //    mesLabLabelPrint(SNInfo);
            //    setTimeout(function () {
            //        $("div.noInstallPrintPlugin").remove();
            //    }, 2000);
            //    //写系统操作日志
            //    for(var i = 0; i < SNInfo.length; i++) {
            //        var opResult= createOperationLog("补打","生产管理|条码打印","条码列表",SNInfo[i],"补打【"+ SNInfo[i] + "】");
            //        if(!opResult) return false;
            //    }
            //}
        }

        function Delete() {
            var idStr = getDeletingRecordIdString();
            if (idStr == "") return false;
            hdnOperate.val("delete");
            hdnIdString.val(idStr);
            document.forms[0].submit();
        }

        function Refresh() {
            document.forms[0].submit();
        }

        //栈板打散
        function PalletScatter() {
            var idStr = getOneRecordId();
            if (idStr == "") return;
            var obj = $(".ListTable input[type='checkbox'][value='" + idStr + "']").parent();
            var snType = $.trim(obj.siblings(".sn-type").text());
            if (snType != "栈板条码") {
                alert("该条码不是栈板条码");
                return;
            }
            if (confirm("确认要打散此栈板吗？")) {
                var sn = $.trim(obj.siblings(".sn").text());
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPreSNPrint.PalletScatter(sn);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                } else {
                    alert("栈板打散成功");
                }
            }
        }

        //栈板注册
        function PalletAdd() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Product/PrePalletRegister.aspx?name=PrePalletRegister";
            dialog({ title: mesLang("栈板注册"), src: openWinUrl, width: 700, height: 400 });
        }

        /********************************************标签打印 开始  （zhibin.Chen 2016-03-11 整理）************************************************/

        var ibs;                    //秒
        var labelDocumentId = -1    //Label文档Id
        var lableTypeQty = 1;       //连板数量
        var printName = "";         //打印机名称
        var labelItemId = -1;    //ItemId
        var labelProdOrderId = -1;
        var labelStationId = -1;    //工位Id
        var labelType = -2;         //标签类型  (-2: 产品条码 -3：物料条码-4：包装箱条码-5: 栈板条码-6：批次号-7：送货单-8：到货单-9:入库单-10:领料单-11:退料单)
        var labelSequence = 1;      //标签序号
        var labelPrintWayId = -1;   //打印方式 78=Lab  79=ZPL

        var lableArr = null;        //标签信息的SN序列号集合对象
        var SNInfo;                 //当前释放标签的信息集合对象
        var labelContent = "";      //标签ZPL指令内容
        var labelJsonData = "";     //标签Lab方式的 数据Json格式字符串
        var tempatePath = "";       //Lab模板文件路径

        var templateGroup = 1;//新打印连板数

        //获取文档模板基础信息
        function getDocumentInfo() {
            var entity;
            if (labelType == -4 || labelType == -5 || labelType == -22) {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPrint.GetPackLabelDocumentInfo(SNInfo[0]);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }
                entity = ajax.value[0];
            }
            else {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPrint.GetLabelDocumentInfo(labelItemId, labelStationId, labelType, labelSequence);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    $("#lblMessage").html(ajax.error.Message);
                    return false;
                }
                entity = ajax.value;
            }

            if (entity == null) {
                alert("未找到模板信息！");
                return false;
            }
            labelDocumentId = entity.LabelDocumentId;
            templateGroup = SKT.LeanMES.Web.AjaxServices.AjaxPrint.GetPrintTemplateGroup(labelDocumentId).value;
            lableTypeQty = entity.PlateQty;
            printName = entity.PrinterName;
            labelPrintWayId = entity.PrintWayId;
            tempatePath = entity.TemplatePath.replace("\\", "\\\\");
            return true;
        }

        function mesLabLabelPrint(list) {
            if (list.length == 0) {
                $("#lblMessage").html("打印条码完成！")
                return;
            }
            var sendQty = <%=ConfigurationManager.AppSettings["PrintSendQty"]%>;
            while (sendQty % templateGroup != 0) {
                sendQty++;
            }
            //从list中取出 sendQty 作为打印的数量，并且list截取掉sendQty
            var newlist = list.splice(sendQty);
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPrint.returnLabelInfo(labelDocumentId, list, -1, -1, -1, labelItemId, labelProdOrderId);
            if (ajax.error == null) {
                if (ajax.value.length == 0) {
                    alert("没有找到该产品关联的模板信息");
                    $("#lblMessage").html("没有找到该产品关联的模板信息");
                    return;
                }
            } else {
                alert(ajax.error.Message);
                $("#lblMessage").html(ajax.error.Message);
                return;
            }

            $("#lblMessage").html("发送条码【" + list.join() + "】打印指令到打印机,请勿关闭窗口！<br/> 当前剩余打印数量【" + newlist.length + "】");
            sendPrintByDataId(ajax.value, printName, 1, labelDocumentId, function (success, ws) {
                if (!success) {
                    if (ws && ws.readyState != 1)
                        layer.open({ content: "连接尚未建立请确认服务是否开启" });
                    return;
                }
                mesLabLabelPrint(newlist);
            },<%=ConfigurationManager.AppSettings["PrintType"]%>);
        }

        //写入系统操作日志
        function createOperationLog(logtype, modulename, pagename, oederno, logcontent) {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxErrorLog.CreateOperationLog(logtype, modulename, pagename, oederno, logcontent);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            return true;
        }
    </script>
</asp:Content>
