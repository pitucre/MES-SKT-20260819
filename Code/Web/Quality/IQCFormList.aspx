<%@ Page Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" CodeBehind="IQCFormList.aspx.cs" Inherits="SKT.LeanMES.Web.Quality.IQCFormList" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
    <style type="text/css">
        .STYLE1 {font-size: 12px}
    </style>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label3">
                采购订单号
            </td>
            <td class="Field3">
                <asp:TextBox runat="server" ID="txtPoCode" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">
                供应商代码
            </td>
            <td class="Field3">
                <asp:TextBox runat="server" ID="txtVendorCode" CssClass="TextBox"></asp:TextBox><input type="button" value="..."
                            class="ButtonBox" onclick="chooseVendor(34)" />
            </td>
            <td class="Label3">
                收货时间
            </td>
            <td class="Field3">
                <input type="text" id="txtDateFrom" class="DateTimeBox" runat="server" readonly="readonly" />
                -
                <input type="text" id="txtDateTo" class="DateTimeBox" runat="server" readonly="readonly" />
                 <img title="点击清除日期" id="timeClear" style="margin-bottom:-5px;  cursor: pointer;" onclick="clearDataTime2(this);" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAA8UlEQVQ4T6WS4Q0BURCEPx3ogA7oAB0ogQrQgQ7QgRKoAB1QASXogHzyNnl3eeckJrk/t29mZ3e2w5/o/MgfAgtgBTxzzi8Ckg/AFegBk1ykTUDyKXXeA2tgmr6HTr4JdIF7Rg7nM2ALjHXVJCDZzjvAznUsk4txSSDIF8CHJfhfB9OSwBlwPq2W4A50VRzBgg58VEIkYt1UKkuU7AMF7K6THJHIPMX6qcUIEY+2+onsnLHAxqWGgLGMsiOxmw4U8YhM5JjuoGIrX6LdBjUR/72AW9NS6ynEkWxSG504lg7rMOZzKUY3LLENjlgUaCNW6m+WQjQRQeRbMQAAAABJRU5ErkJggg==">
            </td>
         </tr>
         <tr>
            <td class="Label3">
                送货单号
            </td>
            <td class="Field3">
                <asp:TextBox runat="server" ID="txtDeliNo" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">
                检验员
            </td>
            <td class="Field3">
                <asp:TextBox runat="server" ID="txtInspectionUser" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">
                检验时间
            </td>
            <td class="Field3">                
                <input type="text" id="txtDateF" class="DateTimeBox" runat="server" readonly="readonly" />
                -
                <input type="text" id="txtDateT" class="DateTimeBox" runat="server" readonly="readonly" />
                 <img title="点击清除日期" id="timeClear" style="margin-bottom:-5px;  cursor: pointer;" onclick="clearDataTime2(this);" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAA8UlEQVQ4T6WS4Q0BURCEPx3ogA7oAB0ogQrQgQ7QgRKoAB1QASXogHzyNnl3eeckJrk/t29mZ3e2w5/o/MgfAgtgBTxzzi8Ckg/AFegBk1ykTUDyKXXeA2tgmr6HTr4JdIF7Rg7nM2ALjHXVJCDZzjvAznUsk4txSSDIF8CHJfhfB9OSwBlwPq2W4A50VRzBgg58VEIkYt1UKkuU7AMF7K6THJHIPMX6qcUIEY+2+onsnLHAxqWGgLGMsiOxmw4U8YhM5JjuoGIrX6LdBjUR/72AW9NS6ynEkWxSG504lg7rMOZzKUY3LLENjlgUaCNW6m+WQjQRQeRbMQAAAABJRU5ErkJggg==">
            </td>
        </tr>
        <tr>
            <td class="Label3">
                物料编码
            </td>
            <td class="Field3">
                <asp:TextBox runat="server" ID="txtItemCode" CssClass="TextBox"></asp:TextBox><input type="button" value="..." class="ButtonBox"
                            onclick="chooseMaterial()" />
            </td>
            <td class="Label3">
                单据状态
            </td>
            <td class="Field3">
                <select name="selIQCType" id="selIQCType" class="selIQCType" runat="server">
                    <option value="">请选择</option>
                    <option value="1" selected="selected">待检验</option>
                    <option value="2">已检验</option>
                </select>&nbsp;
                检验结果<select name="selInspectionResult" id="selInspectionResult" class="selInspectionResult" runat="server">
                    <option value="" selected="selected">全部</option>
                    <option value="0">不合格</option>
                    <option value="1">合格</option>
                </select><br />
                是否审核<select name="selIsVerify" id="selIsVerify" class="selIsVerify" runat="server">
                    <option value="" selected="selected">未知</option>
                    <option value="0">未审核</option>
                    <option value="1">已审核</option>
                </select>
                
                <%--检验单状态
                <select name="selIQCType" id="selIQCType" runat="server">
                    <option value="">请选择</option>
                    <option value="1" selected="selected">待检验</option>
                    <option value="2">已检验</option>
                    <option value="3">已退货</option>
                    <option value="4">已交接</option>
                    <option value="5">已入库</option>
                </select>
                --%>
            </td>
            <td class="Label3">
                IQC判定结果方式
            </td>
            <td class="Field3">
                <select name="selIQCResult" id="selIQCResult" runat="server">
                    <option value="" selected="selected">请选择</option>
                    <option value="-3">待处理</option>
	                <option value="2">批量退货</option>
	                <option value="3">特采</option>
	                <option value="4">挑选</option>
                </select>                
            </td>
        </tr>
        <tr>
               <td class="Label3">
                <%=Resources.lang.InspectionOrderNo%>
            </td>
            <td class="Field3">
                <asp:TextBox runat="server" ID="txtIqcBatchNO" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">
                GRN
            </td>
            <td class="Field3">
                <asp:TextBox runat="server" ID="txtGrn" CssClass="TextBox"></asp:TextBox>
            </td> 
            <td class="Label3">
              订单号
            </td>
            <td class="Field3">
                <input type="text" id="txtSOCode" class="TextBox" runat="server" />
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
    <asp:GridView ID="GridView1" AutoGenerateColumns="false" runat="server" OnRowDataBound="GridView1_RowDataBound" style="table-layout:fixed;word-wrap:break-word;word-break:break-all">
        <Columns>
            <%--按JD客户要求排列列表--%>
            <asp:BoundField DataField="InspectionNo" HeaderText="检验单号" SortExpression="InspectionNo" HeaderStyle-Width="140px"/>
            <asp:BoundField DataField="UrgentName" HeaderText="紧急情况" SortExpression="UrgentName" HeaderStyle-Width="80px"/>
            <asp:BoundField DataField="VendorName" HeaderText="供应商名称" SortExpression="VendorName" HeaderStyle-Width="220px"/>
            <asp:BoundField DataField="ItemCode" HeaderText="物料编码" SortExpression="ItemCode" HeaderStyle-Width="140px"/>
            <asp:BoundField DataField="ItemName" HeaderText="物料名称" SortExpression="ItemName" HeaderStyle-Width="140px"/>
            <asp:BoundField DataField="ItemSpec" HeaderText="规格" SortExpression="ItemSpec" HeaderStyle-Width="320px"/>
            <asp:TemplateField HeaderText="收货数量" SortExpression="InspectionQty"  HeaderStyle-Width="100px">
                <ItemTemplate>
                    <%#Eval("InspectionQty","{0:G0}").ToString() %>
                </ItemTemplate>
            </asp:TemplateField>
         <%--   <asp:BoundField DataField="InspectionQty" HeaderText="收货数量" SortExpression="InspectionQty" HeaderStyle-Width="150px"/>--%>
            <asp:BoundField DataField="WarehouseBarCode" HeaderText="库位条码" SortExpression="WarehouseBarCode" HeaderStyle-Width="120px"/>
            <asp:BoundField DataField="SOCode" HeaderText="订单号" SortExpression="SOCode" HeaderStyle-Width="150px"/>
            <asp:BoundField DataField="StatusName" HeaderText="单据状态"  SortExpression="StatusName" HeaderStyle-Width="80px" ItemStyle-CssClass="bill-status"/>
            <asp:BoundField DataField="ReciveBy" HeaderText="接收人" SortExpression="ReciveBy" HeaderStyle-Width="80px" ItemStyle-CssClass="recive-by"/>
            <asp:BoundField DataField="VerifyBy" HeaderText="审核人" SortExpression="ReciveBy" HeaderStyle-Width="80px" ItemStyle-CssClass="recive-by"/>
            <asp:BoundField DataField="POrder" HeaderText="采购单号" SortExpression="POrder" HeaderStyle-Width="140px"/>
            <%--<asp:BoundField DataField="POTypeName" HeaderText="采购类型"  SortExpression="POTypeName"  HeaderStyle-Width="80px"/>--%>
            <asp:BoundField DataField="DeliverNo" HeaderText="送货单号" SortExpression="DeliverNo" HeaderStyle-Width="140px"/>
            <asp:BoundField DataField="CategoryOne" HeaderText="物料大类" SortExpression="CategoryOne" HeaderStyle-Width="150px"/>
            <asp:BoundField DataField="CategoryTwo" HeaderText="物料中类" SortExpression="CategoryTwo" HeaderStyle-Width="150px"/>
            <asp:BoundField DataField="CategoryThree" HeaderText="物料小类" SortExpression="CategoryThree" HeaderStyle-Width="150px"/>
            <asp:BoundField DataField="SuplierCode" HeaderText="供应商编码" SortExpression="SuplierCode" HeaderStyle-Width="120px"/>
            <asp:BoundField DataField="InspectionResult" HeaderText="检验结果"  SortExpression="InspectionResult" HeaderStyle-Width="80px"/>
            <asp:BoundField DataField="CheckType" HeaderText="IQC判定结果方式" SortExpression="CheckType"  HeaderStyle-Width="80px"/>            
            <%--<asp:BoundField DataField="IsFile" HeaderStyle-HorizontalAlign="Center" HeaderText="档案文件" SortExpression="IsFile" HeaderStyle-Width="80px"/>--%>
            <asp:BoundField DataField="CreateBy" HeaderText="创建人" SortExpression="CreateBy" HeaderStyle-Width="80px"/>
            <asp:BoundField DataField="CreateDateTime" HeaderText="收料时间" SortExpression="CreateDateTime" HeaderStyle-Width="140px"/>
            <asp:BoundField DataField="ReciveTime" HeaderText="接收时间" SortExpression="ReciveTime" HeaderStyle-Width="140px"/>
            <asp:BoundField DataField="VerifyTime" HeaderText="审核时间" SortExpression="ReciveTime" HeaderStyle-Width="140px"/>
            <asp:BoundField DataField="InspectionUser" HeaderText="检验员" ItemStyle-Wrap="false" HeaderStyle-Width="80px"/>
            <asp:BoundField DataField="InspectionStartTime" HeaderText="开始检验时间" SortExpression="InspectionStartTime" ItemStyle-Wrap="false" HeaderStyle-Width="140px"/>
            <asp:BoundField DataField="CheckDate" HeaderText="检验完成时间" SortExpression="CheckDate" ItemStyle-Wrap="false" HeaderStyle-Width="140px"/>
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Material.BLL.MaterialIQC"
        SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <%--<input type="hidden" id="hdnOperate" name="hdnOperate" value="" />--%>
    <asp:HiddenField ID="hdnOperate" runat="server" ClientIDMode="Static" OnValueChanged="Operate_Changed"/>
    <input type="hidden" id="hdnIdString"  name="hdnIdString" value="" />
    <script type="text/javascript" src="../Content/js/jquery-3.1.0.min.js"></script>
    <script type="text/javascript" src="../Content/plugin/jquery-easyui-1.4.2/layer/layer.js"></script>
    <script language="javascript" type="text/javascript">
        $(document).ready(function () {
            gridCellsChangeNo = true;
            //$("#ckbMultipleSelected").parent().hide();

            //检验结果改变事件
            $(".selIQCType").change(function () {
                var selValue = this.value;
                if (selValue == "2") {
                    $(".selInspectionResult").prop("disabled", false);
                    $(".selIsVerify").prop("disabled", false);
                } else {
                    $(".selInspectionResult").prop("disabled", true);
                    $(".selIsVerify").prop("disabled", true);
                }
            });
            $(".selInspectionResult").prop("disabled", $(".selIQCType").val() == "2" ? false : true);
            $(".selIsVerify").prop("disabled", $(".selIQCType").val() == "2" ? false : true);
            
        })
        var username = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';
        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");

        var chooseFlag = -1;
        function chooseVendor(flag) {
            chooseFlag = flag;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=34&CallBackFunc=setVendor&Multiple=false&rnd=" + Math.random(), width: 650, height: 350 });
        }

        function chooseMaterial() {
            chooseFlag = 1;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=1&Multiple=false&rnd=" + Math.random(), width: 650, height: 350 });
        }

        /*获取供应商信息*/
        function setVendor(list) {
            $("#<%=this.txtVendorCode.ClientID %>").val(list[0][1]);
        }

        /*获取物料信息*/
        function getChooseValue(list) {
            $("#<%=this.txtItemCode.ClientID %>").val(list[0][2]);
        }

        function Add() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Material/IQCFormEdit.aspx?name=Material_IQCFormAdd&ID=-1";
            dialog({ title: "<%=Resources.Pages.Material_IQCFormAdd %>", src: openWinUrl, width: 650, height: 400 });
        }

        function View() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            <%--            dialog({ title: "检验单检验",
                src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Quality/Inspection.aspx?name=Material_IQCFormView&TypeId=2&InspectionTypeId=1&IOrderId=" + idStr + "&rnd=" + Math.random(), width: 1200, height: 600
            });--%>
           var src= "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Quality/Inspection.aspx?name=Material_IQCFormView&TypeId=2&InspectionTypeId=1&IOrderId=" + idStr;
            window.open(src);
        }

        function Edit() {
            IQCcheck()
            //             var idStr = getOneRecordId();
            //             if (idStr == "") return false;
            //             openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Material/IQCFormEdit.aspx?name=Material_IQCFormEdit&ID=" + idStr;
            //             dialog({ title: "<%=Resources.Pages.Material_IQCView %>", src: openWinUrl, width: 600, height: 360 });
        }

        function Delete() {
            var idStr = getOneRecordId();//删除只能一个一个进行删除，防止删错，删错无法撤回

            if (idStr == "") return false;
            hdnOperate.val("delete");
            hdnIdString.val(idStr);
            document.forms[0].submit();
        }
        
        //批量质检合格
        function ALLIQCcheck() {
            var entity = {};
            var idStr = getRecordIdString();
            if (idStr == "") return false;
            if (confirm("是否批量质检合格？")) {
                entity.InspectionIds = idStr;
                entity.ModifyBy = username;
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxInspection.SaveIqcALLCheck(JSON.stringify(entity));
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return;
                }
                alert("检验成功！");
                document.forms[0].submit();
            }
        }

        function UpdateList(txtIqcBatchNO) {
            $("#<%=this.txtIqcBatchNO.ClientID %>").val(txtIqcBatchNO);
            document.forms[0].submit();
        }

        function IQCcheck() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            var status = true;
            for (var i = 0; i < $("input[name='chkSelect']").length; i++) {
                var $_input = $($("input[name='chkSelect']")[i]);
                if ($_input.val() == idStr) {
                    if ($_input.parent().parent().find("td:eq(" + GetGridCellsChangNo(10)+ ")").html() == "待检验") {
                        status = false;
                    }
                }
            }

<%--            dialog({ title: "检验单检验",
                src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Quality/Inspection.aspx?name=Material_IQCFormCheck&TypeId=2&InspectionTypeId=1&IOrderId=" + idStr + "&Status="+status + "&rnd=" + Math.random(), width: 1200, height: 600
            });--%>
        
            var entity = {};
            entity.InspectionId = idStr;
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialIQC.ValidateIQCRecived(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            var src = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Quality/Inspection.aspx?name=Material_IQCFormCheck&TypeId=2&InspectionTypeId=1&IOrderId=" + idStr + "&Status=" + status;
            window.open(src);
        }

        function IQCPrint() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            //if (!IQCIsBaveData(idStr)) {
            //    alert("该IQC单物料未找到检验模板，请检查模板关联！");
            //    return false;
            //}
            var url = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Quality/InspectionIQCFormPrint.aspx?name=Material_IQCFormPrint&ID=" + idStr + "&rnd=" + Math.random();
            window.open(url);
        }

        //检验报告
        function IQCReportPrint() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;

            //if (!IQCIsBaveData(idStr)) {
            //    alert("该IQC单物料未找到检验模板，请检查模板关联！");
            //    return false;
            //}

            var url = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Quality/InspectionIQCReportPrint.aspx?name=Material_IQCFormPrint&ID=" + idStr + "&rnd=" + Math.random();
            window.open(url);
        }

        //撤回
        function UndoByIQC() {
            var idStr = getOneRecordId();
            //xiang.yan 2024-4-28  列取值由索引改为列明
            // 10 改为 StatusName
            var strStatus = getOneRecordCellTextByFiled("StatusName");
            if (strStatus == "" || idStr == "") return false;
            if (strStatus == "已检验" || strStatus == "已交接") {
                if (confirm("是否确定要进行IQC撤回【待检验】状态？")) {
                    UserName = '<%= SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>';
                    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxInspection.UndoIQCByID(idStr, UserName); //SKT.AjaxCommon.DBService.ExecuteSpc("uspUndoIQCByID", JSON.stringify(entity));
                    if (ajax.error != null) {
                        alert(ajax.error.Message);
                        //写入日志
                        SaveUserUILog(orderNo, ajax.error.Message);
                        return false;
                    }
                    alert("当前IQC检验单已撤销检验！");
                    document.forms[0].submit();
                }
            }
            else {
                alert("该状态【" + strStatus + "】的IQC单不能撤销检验！");
                return false;
            }
        }

        function Refresh() {
            hdnOperate.val("");
            document.forms[0].submit();
        }
        //上传不良报告
        function IQCUpload() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            //xiang.yan 2024-4-28  列取值由索引改为列明,功能已去除
            // 1 改为 InspectionNo
            var result = getOneRecordCellTextByFiled("InspectionNo");
            dialog({ title: "上传不良报告",
                src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Quality/UploadFile.aspx?name=Quality_UploadFile&tbName=IQCFile&ID=" + result + "&rnd=" + Math.random(), width: 620, height: 300
            });
        }

        function viewFile(code) {
            dialog({ title: "查看文件",
                src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Quality/FlieView.aspx?name=Quality_FileView&tbName=IQCFile&ID=" + code + "&rnd=" + Math.random(), width: 600, height: 300
            });
        }

        //function IQCIsBaveData(id) {
        //    var entity = {};
        //    entity.InspectionId = id;
        //    var ajax = SKT.LeanMES.Web.AjaxMaterialIQC.IQCIsBaveData(entity);
        //    if (ajax.error != null) {
        //        return false;
        //    }
        //    else {
        //        return true;
        //    }
        //}

        // 导出PDF文件
        function IQCPdfPrint() {
            var idStr = getRecordIdString();
            if (idStr == "") return false;
            //   hdnOperate.val("IQCPdfPrint");
            //hdnOperate.val("iqcreportpdfprint");
            hdnIdString.val(idStr);
            //document.forms[0].submit();
            //hdnOperate.val("");
            window.open("<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Quality/IQCFormListPrint.aspx?action=iqcreportpdfprint&ID=" + idStr);
        }

        function IQCOrderPdfPrint() {
            var idStr = getRecordIdString();
            if (idStr == "") return false;
            //hdnOperate.val("iqcorderreportpdfprint");
            hdnIdString.val(idStr);
            //document.forms[0].submit();
            //hdnOperate.val("");
            window.open("<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Quality/IQCFormListPrint.aspx?action=iqcorderreportpdfprint&ID=" + idStr);
        }

        //导出到EXCEL
        function ImportToExcel() {
            hdnOperate.val("exportexcel");
            document.forms[0].submit();
            hdnOperate.val("");
        }

        //IQC接收
        function IQCRecive(){
            //待检验才能接收
            //bill-status
            //var idStr = getOneRecordId();
            //if (idStr == ""){
            //    return false;
            //}
            //var selectTr = $(".ListTable input[type='checkbox'][value='"+idStr+"']").parent();
            //var billStatus = $.trim(selectTr.siblings(".bill-status").text());
            //if(billStatus != "待检验"){
            //    alert("只允许接收“待检验”状态单据");
            //    return false;
            //}
            ////判断是否已经接收
            //var reviceStatus = $.trim(selectTr.siblings(".recive-by").text());
            //if(reviceStatus){
            //    alert("该单据已经接收");
            //    return false;
            //}

            debugger
            var idStr = getRecordIdString();
            if (idStr == "") return false;
            //接收
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialIQC.IQCBatchRecive(idStr);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return;
            }
            alert("接收成功");
            doSearch();
        }

        //删除IQC检验单
        function Delete() {
            var idStr = getDeletingRecordIdString();
            if (idStr == "") return false;
            hdnOperate.val("delete");
            hdnIdString.val(idStr);
            document.forms[0].submit();
        }

        function showData(data) {
            var mDiv = document.getElementById('carBox');
            if(mDiv){
                document.body.removeChild(mDiv);	
            }
            var oEvent = event;
            var oDiv=document.createElement('div');
            oDiv.id = "carBox";
            oDiv.style.left=(oEvent.clientX-105)+'px';  // 指定创建的DIV在文档中距离左侧的位置105
            oDiv.style.top=(oEvent.clientY-85)+'px';  // 指定创建的DIV在文档中距离顶部的位置110
            oDiv.style.border='1px solid #0000FF'; // 设置边框
            oDiv.style.borderRadius = '25px';
            oDiv.style.background = 'rgb(255, 255, 255)';
            oDiv.style.position='absolute'; // 为新创建的DIV指定绝对定位
            oDiv.style.width='260px'; // 指定宽度
            oDiv.style.height = '60px'; // 指定高度
            if (parseFloat(data.length / 30) > 2) {
                oDiv.style.height = (20 * (parseInt(data.length / 30) + 1) + 16).toString() + "px";
                oDiv.style.top = (oEvent.clientY - (85 + (parseInt(data.length / 30) - 1) * 10)) + 'px';  // 指定创建的DIV在文档中距离顶部的位置
            }
            var content = '<div style="padding: 10px;color: rgb(0, 0, 0);font-size: 10px;">' +
            '<table style="width:95%; height:7px;"  border="0" cellpadding="0" cellspacing="0"   > ' +
            '<tr style=" color: #fff; padding-left: 2px; padding-top: 0px; font-weight: bold; font-size: 12px;" >' +
            '<td><div align="right"><a href="#" class="STYLE1" onclick="closeDiv();">[关闭]</a></div></td> ' +
            '</tr> ' +
            '</table> ' +
            '<div style="width:90%;height:100%;overflow-x:hidden;overflow-y:auto;text-align:left">' + data +
            '</div>'+
            '</div>';
            oDiv.innerHTML = content;
            document.body.appendChild(oDiv);
        }

        function closeDiv() {
            var mDiv = document.getElementById('carBox');
            if (mDiv) {
                document.body.removeChild(mDiv);
            }
        }

        function clearDataTime2(el) {
            $(el).parent().find(".DateTimeBox").val("");
        }

    </script>
</asp:Content>
