<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master"
    AutoEventWireup="true" CodeBehind="AccessoryPrintEdit.aspx.cs" Inherits="SKT.LeanMES.Web.AccessoryManagement.AccessoryPrintEdit" %>


<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %>
    </div>
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label2"><%= Resources.lang.AccessoryCode %><em>*</em></td>
            <td class="Field2">
                <asp:TextBox ID="txtAccessoryName" runat="server" CssClass="TextBox" MaxLength="100" disabled="disabled" IsRequired='1'></asp:TextBox>
                <input type="button" class="ButtonBox" value="..." onclick="chooseAccessoryName()" />
            </td>
            <td class="Label2"><%= Resources.lang.AccessoryType %><em>*</em></td>
            <td class="Field2">
                <asp:Label runat="server" ID="textAccessoryType"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">打印个数<em>*</em></td>
            <td class="Field2">
                <asp:TextBox ID="txtSumQty" runat="server" CssClass="TextBox" IsNumber='1' IsRequired='1'></asp:TextBox>
            </td>
            <td class="Label2">入库数量<em>*</em></td>
            <td class="Field2">
                <asp:TextBox ID="txtMinQty" runat="server" CssClass="TextBox" IsNumber='1' IsRequired='1'></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2"><%= Resources.lang.FSupplierName %><em>*</em></td>
            <td class="Field2">
                <asp:TextBox ID="txtSupplierCode" runat="server" CssClass="TextBox" MaxLength="50" disabled="disabled" IsRequired='1'></asp:TextBox>
                <input type="button" class="ButtonBox" value="..." onclick="chooseSupplier()" />
            </td>
            <td class="Label2"><%= Resources.lang.AC_OBA_LotNo %></td>
            <td class="Field2">
                <asp:TextBox ID="txtLot" runat="server" CssClass="TextBox" MaxLength="50"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2"><%= Resources.lang.ProdDateTime %><em>*</em></td>
            <td class="Field2">
                <asp:TextBox ID="txtProdDateTime" runat="server" ReadOnly="true" IsRequired='1'></asp:TextBox>
            </td>
            <td class="Label2"><%= Resources.lang.LoseTime %><em>*</em></td>
            <td class="Field2">
                <asp:TextBox ID="txtLoseTime" runat="server" ReadOnly="true" IsRequired='1'></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">打印机名称</td>
            <td class="Field2" colspan="3">
                <select id="selPrintersList" style="width: 250px;">
                </select>
                <a href="#" onclick="bindPrinters('selPrintersList');">重新加载打印机列表</a>
            </td>
        </tr>
    </table>
    <div style="text-align: center; margin-top: 5px">
        <input type="button" value="确认打印" onclick="Save()">
    </div>
    <div id="lblMessage" class="Tips" style="text-align: center; margin-top: 5px">
    </div>
    <script type="text/javascript" src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/layui/layui.all.js"></script>
    <link href="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/layui/css/layui.css" rel="stylesheet" />
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/ws.js" type="text/javascript"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.utility.printer.js?v=3" type="text/javascript"></script>
    <script type="text/javascript">
        var accessoryId = '<%=Request.QueryString["ID"]%>';
        var labelItemId = -1; //打印产品
        var accessoryListId = -1;//产品辅料Id

        $(function () {
            //绑定日期选择框
            $("#<%=this.txtLoseTime.ClientID%>").datepicker({
                buttonImageOnly: true,
                showHms: true
            });

            //绑定生产日期选择框
            $("#<%=this.txtProdDateTime.ClientID%>").datepicker({
                buttonImageOnly: true,
                showHms: false
            });

            bindPrinters('selPrintersList');
            /*setTimeout(function () {
                bindPrinters();
            }, 100);*/
        });
        //辅料
        function chooseAccessoryName() {
            flag = 0;
            chooseFlag = 504;
            pageCondition = "";
            dialog({ title: "", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Framework/ChoosePage.aspx?PageId=" + chooseFlag + "&PageCondition=" + pageCondition + "&Multiple=false&rnd=" + Math.random(), width: 650, height: 300 });
        }
        //供应商
        function chooseSupplier() {
            flag = 1;
            chooseFlag = 34;
            pageCondition = "";
            dialog({ title: "", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Framework/ChoosePage.aspx?PageId=" + chooseFlag + "&PageCondition=" + pageCondition + "&Multiple=false&rnd=" + Math.random(), width: 650, height: 300 });
        }
        function getChooseValue(list) {
            if (flag == 0) {
                $("#<%=this.txtAccessoryName.ClientID%>").val(list[0][2]);
                txtAccessoryCodoe = list[0][1];          
                $("#<%=this.textAccessoryType.ClientID%>").html(list[0][3]);
                AccessoryType = list[0][4];
                accessoryListId = list[0][0];
            } else if (flag == 1) {
                $("#<%=this.txtSupplierCode.ClientID%>").val(list[0][2]);
                    SupplierCode = list[0][1];
                }
        }


        /*保存数据*/
        function Save() {
            $("#lblMessage").html("正在生成GRN，请稍候...");
            setTimeout(function () {
                var txtLoseTime= $("#<%=this.txtLoseTime.ClientID%>").val();

                var txtAccessoryName = $.trim($("#<%=this.txtAccessoryName.ClientID%>").val());
                var txtLot = $.trim($("#<%=this.txtLot.ClientID%>").val());
                var txtLoseTime =  new Date(Date.parse(txtLoseTime.replace(/-/g, "/")));
                var txtSupplierCode = SupplierCode;
                var txtSumQty = $("#<%=this.txtSumQty.ClientID%>").val(); // 打印个数
                var txtMinQty = $("#<%=this.txtMinQty.ClientID%>").val(); // 入库数量
                var txtProdDateTime = $("#<%=this.txtProdDateTime.ClientID%>").val();
                var txtCreateBy = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';

                if (txtLoseTime <= new Date()) {
                    alert("失效时间不能小于当前日期");
                    return false;
                }                
                /*表单验证*/
                /*如需表单验证可以此处处理验证 开始*/

                //根据辅料代码获取物料Id
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxAccessoryList.GetInfo(accessoryListId);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }
                var info = ajax.value;
                if (info != null) {
                    labelItemId = info.ItemId;
                }
                var entity = {};

                entity.AccessoryId = accessoryId
                entity.AccessoryCodoe = txtAccessoryCodoe;
                entity.AccessoryName = txtAccessoryName;
                entity.Lot = txtLot;
                entity.LoseTime = new Date(txtLoseTime);
                entity.SupplierCode = txtSupplierCode;
                entity.ProdDateTime = new Date(Date.parse(txtProdDateTime.replace(/-/g, "/")));
                entity.CreateBy = txtCreateBy;
                entity.AccessoryType = AccessoryType;
                ajax = SKT.LeanMES.Web.AjaxServices.AjaxAccessory.AccessoryPrintSerialNumber(entity, txtSumQty, parseFloat(txtMinQty));
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    $("#lblMessage").html(ajax.error.Message);
                    $("#lblMessage").css("color", "red");
                    return false;
                }
                var arr = ajax.value;
                if (arr != null) {
                    $("#lblMessage").html("<%=Resources.Messages.GenGrnFinishAndPrintInProcess %>");
                    setTimeout(function () {
                        try {
                            printGRN(arr);
                        }
                        catch (e) {
                            alert(e);
                            $("#lblMessage").html(e);
                        }
                    }, 100);
                }
                //$("#lblMessage").html('条码打印完成!');
                //alert('条码打印完成!');
                //parent.document.forms[0].submit();
                //parent.window.location.reload();
            }, 100);
        }
    
        function printGRN(arr) {
            if (arr == null) {
                return false;
            }
            //arr[0] = arr[0].substring(0, arr[0].lastIndexOf(","));
            //arr[1] = arr[1].substring(0, arr[1].lastIndexOf(","));
            //grnArr = arr[0].split(","); //物料条码            
            arr.pop();
            //将GRN信息添加到SNInfo的SNInfo.SNList集合中
            SNInfo = {};
            SNInfo.SNList = arr;

            debugger;
            console.log(SNInfo);
            
            //根据打印方式决定 调用ZPL还是Lab打印
            usePrinGRNMethod();
            //if (bigCartonQty != 0) {
            //    usePrintCartonMethod();
            //}
            //打印完成刷新页面
            //document.forms[0].submit();
        }

        /********************************************标签打印 开始  （zhibin.Chen 2016-03-11 整理）************************************************/

        var ibs;                    //秒
        var labelDocumentId = -1    //Label文档Id
        var lableTypeQty = 1;       //连板数量
        var printName = "";         //打印机名称
        var labelStationId = -1;    //工位Id
        var labelType = -17;          //标签类型  (-2: 产品条码 -3：物料条码-4：包装箱条码-5: 栈板条码-6：批次号-7：送货单-8：到货单-9:入库单-10:领料单-11:退料单)
        var labelSequence = 6;      //标签序号
        var labelPrintWayId = -1;   //打印方式 78=Lab  79=ZPL

        var lableArr = null;        //标签信息的SN序列号集合对象
        var SNInfo;                 //当前释放标签的信息集合对象
        var tempatePath = "";       //Lab模板文件路径

        //获取物料条码文档模板基础信息
        function getGRNDocumentInfo() {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPrint.GetLabelDocumentInfo(labelItemId, labelStationId, labelType, labelSequence);
            if (ajax.error == null) {
                var entity = ajax.value;
                var entity = ajax.value;
                if (entity == null) {
                    alert("未找到打印模板信息");
                    return false;
                }
                labelDocumentId = entity.LabelDocumentId; //Label文档Id
                lableTypeQty = entity.PlateQty;           //连板数量
                //获取打印机名称值
                printName = $("#selPrintersList").val();
                //printName = entity.PrinterName;
                labelPrintWayId = entity.PrintWayId;      //打印方式 78=Lab  79=ZPL
                tempatePath = entity.TemplatePath.replace("\\", "\\\\");
            }
            else {
                alert(ajax.error.Message);
                $("#lblMessage").html(ajax.error.Message);
                return false;
            }
        }

      

        //根据打印方式决定 调用ZPL还是Lab打印
        function usePrinGRNMethod() {
            getGRNDocumentInfo();
            mesLabLabelPrint(1);
        }

   


        //codesoft打印  Lab模板方式
        function mesLabLabelPrint(printType) {
            lableArr = SNInfo.SNList;

            var labelStr = "";
            var printdata = [];
            for (var i = 0; i < lableArr.length;) {
                //连片数
                if (lableTypeQty == 1) {
                    labelStr = lableArr[i];
                }
                else {
                    //每次重置一下
                    labelStr = "";
                    for (var j = 0; j < lableTypeQty; j++) {
                        if (lableArr[i + j] == null || lableArr[i + j] == "undefined") {
                        }
                        else {
                            //根据联板数，拼接SN字符串。 
                            labelStr += lableArr[i + j] + ",";
                        }
                    }
                }
                i = i + lableTypeQty; //连片的递增
                //获取标签模板中的标签值 集合
                var ajaxLabContent = SKT.LeanMES.Web.AjaxServices.AjaxPrint.returnLabelInfoForLab(labelDocumentId, labelStr, -1, -1, -1, labelItemId, -1);
                if (ajaxLabContent.error == null) {
                    try {
                        var list = ajaxLabContent.value;
                        if (list.length > 0) {
                            var page = { LabelContent: [] };
                            for (var k = 0; k < list.length; k++) {
                                page.LabelContent.push({ name: list[k].LabelName, value: list[k].LabelValue });
                            }
                            printdata.push(page);
                        }

                    } catch (e) {
                        printdata = [];
                        alert(e);
                        $("#lblMessage").html(e);
                        return false;
                    }
                }
                else {
                    printdata = [];
                    alert(ajaxLabContent.error.Message);
                    $("#lblMessage").html(ajaxLabContent.error.Message);
                    return false;
                }
            }
            if (printdata.length == 0)
            {
                $("#lblMessage").html("");
                return;
            }
            
            try {
                sendPrintContent(JSON.stringify(printdata), printName, 1, labelDocumentId);
            } catch (e) {
                alert(e);
                $("#lblMessage").html(e);
                return false;
            }
            ibs = 3;
            setTimeout(function () {
                $("#lblMessage").html('条码打印完成!');
                parent.document.forms[0].submit();
            }, 300);
        }

        function toThousands(s) {
            if (/[^0-9\.]/.test(s)) return "不是数值类型";
            s = s.replace(/(\d)(?=(?:\d{3})+$)/g, '$1,');
            return s;
        }
    </script>

</asp:Content>