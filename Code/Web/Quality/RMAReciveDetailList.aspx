<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" CodeBehind="RMAReciveDetailList.aspx.cs" Inherits="SKT.LeanMES.Web.Quality.RMAReciveDetailList" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label3">
                RMA编号
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtRMANO" runat="server"></asp:TextBox>
            </td>
            <td class="Label3">
                产品条码
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtSN" runat="server"></asp:TextBox>
            </td>
             <td class="Label3">
                产品编码
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtItemCode" runat="server"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1">
        <Columns>
            <asp:BoundField DataField="RmaNo" HeaderText="RMA编号" />
            <asp:BoundField DataField="SN" HeaderText="产品条码" />
            <asp:BoundField DataField="StatusName" HeaderText="产品状态" />
            <asp:BoundField DataField="ItemCode" HeaderText="产品编码" />
            <asp:BoundField DataField="ItemName" HeaderText="产品名称" />
            <asp:BoundField DataField="ItemSpec" HeaderText="产品规格" />
            <asp:BoundField DataField="CWhName" HeaderText="仓库名称" />
            <asp:BoundField DataField="cBarCode" HeaderText="库位" />
        </Columns>
        <EmptyDataTemplate>
            <label>没有数据</label>
        </EmptyDataTemplate>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Quality.BLL.RMAUnit"
        SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
 
    <script type="text/javascript">
        isMultiple = false;
        var hdnOperate = $("#hdnOperate");

        function Import() {
            hdnOperate.val("exportexcel");
            document.forms[0].submit();
            hdnOperate.val("")
        }
        /*补打RMA产品*/
        function Print() {
            
            var idStr = getRecordIdString();
            if (idStr == "") {
                return false;
            }
            dialog({ title: "<%= Resources.Pages.RMA_Reprint %>", src: "RMARePrint.aspx?name=RMARePrint&idStr=" + idStr + "&rnd=" + Math.random(), width: 450, height: 200 });
        }
        function GetSelectSN() {
            var SNInfo = [];
            $("input[name='chkSelect']:checked").each(function () {
                SNInfo.push($.trim($(this)[0].parentElement.parentElement.cells[2].innerText));
            });
            return SNInfo;
        }

       // function Print() {
            //var idStr = getRecordIdString();
            //var ajax = SKT.LeanMES.Web.Quality.RMAReciveDetailList.CheckRePrintData(idStr);
            //if (ajax.error != null) {
            //    alert(ajax.error.Message);
            //    return false;
            //}

            //SNInfo = [];
            //labelItemId = ajax.value;
            //if (labelItemId == -1) {
            //    alert("获取产品数据失败！")
            //    return;
            //}

            //var snStr = "";
            //$("input[name='chkSelect']:checked").each(function () {
            //    snStr = $.trim($(this)[0].parentElement.parentElement.cells[2].innerText);
            //    SNInfo.push(snStr);
            //});

            //if (getDocumentInfo()) {
            //    usePrinMethod();
            //}
      // }

        /********************************************标签打印 开始  （zhibin.Chen 2016-03-11 整理）************************************************/

        //var ibs;                    //秒
        //var labelDocumentId = -1    //Label文档Id
        //var lableTypeQty = 1;       //连板数量
        //var printName = "";         //打印机名称
        //var labelItemId = -1;    //ItemId
        //var labelProdOrderId = -1;
        //var labelStationId = -1;    //工位Id
        //var labelType = -2;         //标签类型  (-2: 产品条码 -3：物料条码-4：包装箱条码-5: 栈板条码-6：批次号-7：送货单-8：到货单-9:入库单-10:领料单-11:退料单)
        //var labelSequence = 1;      //标签序号
        //var labelPrintWayId = -1;   //打印方式 78=Lab  79=ZPL

        //var lableArr = null;        //标签信息的SN序列号集合对象
        //var SNInfo;                 //当前释放标签的信息集合对象
        //var labelContent = "";      //标签ZPL指令内容
        //var labelJsonData = "";     //标签Lab方式的 数据Json格式字符串
        //var tempatePath = "";       //Lab模板文件路径



        ////获取文档模板基础信息
        //function getDocumentInfo() {
        //    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPrint.GetLabelDocumentInfo(labelItemId, labelStationId, labelType, labelSequence);
        //    if (ajax.error == null) {
        //        var entity = ajax.value;
        //        if (entity == null) {
        //            alert("未找到模板信息！");
        //            return false;
        //        }
        //        labelDocumentId = entity.LabelDocumentId;
        //        lableTypeQty = entity.PlateQty;
        //        printName = entity.PrinterName;
        //        labelPrintWayId = entity.PrintWayId;
        //        tempatePath = entity.TemplatePath.replace("\\", "\\\\");
        //    }
        //    else {
        //        alert(ajax.error.Message);
        //        $("#lblMessage").html(ajax.error.Message);
        //        return false;
        //    }

        //    return true;
        //}

        ////根据打印方式决定 调用ZPL还是Lab打印
        //function usePrinMethod() {
        //    //根据文档使用的打印方式，决定调用Lab模板方式，还是指令方式。
        //    if (labelPrintWayId == 78) {
        //        //codesoft打印  Lab模板方式
        //        mesLabLabelPrint();
        //    }
        //    else if (labelPrintWayId == 79) {
        //        //指令方式
        //        mesZPLPrintLabel();
        //    }
        //}

        ////codesoft打印  Lab模板方式
        //function mesLabLabelPrint() {
        //    //从已释放的标签信息集合中，获取SN序列号集合。
        //    lableArr = SNInfo;

        //    for (var i = 0; i < lableArr.length;) {
        //        //lableArr[i]
        //        //找到doucumentId打印文档id
        //        var labelStr = "";

        //        if (lableTypeQty == 1) {
        //            labelStr = lableArr[i];
        //        }
        //        else {
        //            for (var j = 0; j < lableTypeQty; j++) {
        //                if (lableArr[i + j] == null || lableArr[i + j] == "undefined") {
        //                }
        //                else {
        //                    //根据联板数，拼接SN字符串。 
        //                    labelStr += lableArr[i + j] + ",";
        //                }
        //            }
        //        }

        //        i = i + lableTypeQty;

        //        //每发送一次打印指令 初始化标签内容变量。
        //        labelContent = "";

        //        //获取标签模板中的标签值 集合
        //        var ajaxLabContent = SKT.LeanMES.Web.AjaxServices.AjaxPrint.returnLabelInfoForLab(labelDocumentId, labelStr, -1, -1, -1, labelItemId, labelProdOrderId);

        //        if (ajaxLabContent.error == null) {
        //            //接收打印的ZPL标签  
        //            try {
        //                var list = ajaxLabContent.value;

        //                if (list.length > 0) {

        //                    for (var h = 0; h < list.length; h++) {
        //                        labelContent += '{name:"' + list[h].LabelName + '",value:"' + list[h].LabelValue + '"}' + ",";
        //                    }

        //                    labelContent = labelContent.substring(0, labelContent.length - 1);
        //                    labelJsonData = "[{LabelContent:[" + labelContent + "]}]";

        //                    printLabel(tempatePath, labelJsonData, printName, "lab");
        //                    //条码打印记录
        //                }
        //            } catch (e) {
        //                alert(e);
        //                $("#lblMessage").html(e);
        //                return false;
        //            }
        //        }
        //        else {
        //            alert(ajaxLabContent.error.Message);
        //            $("#lblMessage").html(ajaxLabContent.error.Message);
        //            return false;
        //        }
        //    }

        //}

        ////指令方式
        //function mesZPLPrintLabel() {
        //    lableArr = SNInfo;
        //    for (var i = 0; i < lableArr.length;) {

        //        //lableArr[i]
        //        //找到doucumentId打印文档id
        //        var labelStr = "";
        //        if (lableTypeQty == 1) {
        //            labelStr = lableArr[i];
        //        }
        //        else {
        //            for (var j = 0; j < lableTypeQty; j++) {
        //                if (lableArr[i + j] == null || lableArr[i + j] == "undefined") {
        //                }
        //                else {
        //                    labelStr += lableArr[i + j] + ",";
        //                }
        //            }
        //        }

        //        i = i + lableTypeQty;

        //        //获取此标签的zpl指令
        //        var ajaxZplContent = SKT.LeanMES.Web.AjaxServices.AjaxPrint.returnZplContent(labelDocumentId, labelStr, -1, -1, -1, labelItemId, labelProdOrderId);
        //        if (ajaxZplContent.error == null) {
        //            zplStr = ajaxZplContent.value;
        //            try {
        //                printLabel("", zplStr, printName, "zpl");

        //            } catch (e) {
        //                alert(e);
        //                $("#lblMessage").html(e);
        //                return false;
        //            }
        //        } else {
        //            alert(ajaxZplContent.error.Message);
        //            $("#lblMessage").html(ajaxZplContent.error.Message);
        //            return false;
        //        }
        //    }

        //}

        /********************************************标签打印 结束   （zhibin.Chen 2016-03-11 整理）************************************************/
    </script>
</asp:Content>
