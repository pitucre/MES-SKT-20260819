<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/EditMaster.master" CodeBehind="FinishedSaleReturnListJudgeQuality.aspx.cs" Inherits="SKT.LeanMES.Web.Warehouse.FinishedSaleReturnListJudgeQuality" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">


    <style>
        .dtlTable 
        {
            position: absolute;
            left: 20%;
            z-index:10;
            width: 60%;
            background-color: #c6ddff;
            text-align: center;
        }
    </style>
    <table class="EditeContentTable" width="100%" >
        <tr>
            <td class="Label2" align="center">销退单号</td>
            <td class="Field2" align="center">
                <label id="lblSaleReturnNo"></label>
            </td>
             <td class="Label2" align="center">销退单行号</td>
             <td class="Field2" align="center">
                 <label id="lblSaleReturnRowId"></label>
             </td>
        </tr>
          <tr>
              <td class="Label2" align="center">客户编号</td>
              <td class="Field2" align="center">
                  <label id="lblCustomerCode"></label>
              </td>
               <td class="Label2" align="center">客户名称</td>
               <td class="Field2" align="center">
                   <label id="lblCustomerName"></label>
               </td>
          </tr>
        <tr>
           <td class="Label2" align="center">物料编号</td>
           <td class="Field2" align="center">
               <label id="lblItemCode"></label>
           </td>
            <td class="Label2" align="center">物料名称</td>
            <td class="Field2" align="center">
                <label id="lblItemName"></label>
            </td>
       </tr>
        <tr>
            <td class="Label2" align="center">退货数量</td>
            <td class="Field2" align="center">
                <label id="lblSaleReturnQty"></label>
            </td>
            <td class="Label2" align="center">已退数量</td>
            <td class="Field2" align="center">
                <label id="lblCurrentReturnQty"></label>
            </td>
          </tr>
    </table>
    <table class="ListTable" width="100%" id="item-list">
        <thead>
            <tr class="ListTableHeader">
                <th style="width: 40px;" align="center">序号</th>
                <th align="center">退货条码</th>
                <th align="center">退货数量</th>
                <th align="center">结果</th>
                <th align="center">备注</th>
            </tr>
            
        </thead>
        <tbody>
        </tbody>
    </table>

    <script type="text/javascript">
        var SaleReturnDtlId = "<%=Request.QueryString["SaleReturnDtlId"]%>";       
        var userName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
        var userId = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserId %>";
        var currentTime = "<%=DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")%>";

        $(document).ready(function () {
            GetSaleReturnDataById();
        });

         function GetSaleReturnDataById() {
             var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSaleReturn.GetSaleReturnDetailByDtlId(parseInt(SaleReturnDtlId));
             /*
             var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSaleReturn.GetSaleReturnByDel(parseInt(SaleReturnDtlId));
             if (ajax.error != null) {
                 alert(ajax.error.Message);
                 return false;
             }

             var list = ajax.value;
             if (!list || !list[0].SaleReturnId) {
                 alert("未获取到退货信息");
                 return false;
             }
    

             var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSaleReturn.GetSaleReturnDetail({ SaleReturnNo: list[0].SaleReturnNo });
             */
             if (ajax.error != null) {
                 alert(ajax.error.Message);
                 return false;
             }
             var list = ajax.value;
             if (!list || !list[0].SaleReturnNo) {
                 alert("未获取到退货信息");
                 return false;
             }

             $("#lblSaleReturnNo").text(list[0].SaleReturnNo);             
             $("#lblSaleReturnRowId").text(list[0].SaleReturnRowId);             
             $("#lblCustomerCode").text(list[0].CustomerCode);
             $("#lblCustomerName").text(list[0].CustomerName);
             $("#lblItemCode").text(list[0].ItemCode);             
             $("#lblItemName").text(list[0].ItemName);
             $("#lblSaleReturnQty").text(list[0].SaleReturnQty);
             $("#lblCurrentReturnQty").text(list[0].CurrentReturnQty);

            var entity =
            {
                SaleReturnNo: list[0].SaleReturnNo,
                SaleReturnRowId:list[0].SaleReturnRowId
            };
            var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspGetSaleReturnMaterialUnit", JSON.stringify(entity));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            var list = JSON.parse(ajax.value).data;
            var htmlStr = "";
            if(list.length > 0){
                for (var i = 0; i < list.length; i++) {
                    var entity = list[i];
                    htmlStr +=`<tr class="ListTableOddRow">
                                    <td align="center" class="Field">${i+1}</td>
                                    <td align="center" class="Field SerialNumber">${entity.SerialNumber}</td>
                                    <td align="center" class="Field">${entity.Quantity}</td>
                                    <td align="center" class="Field Result">  
                                        <input type="radio" name="checkResult${i}" value="1" ${entity.Result == 1?'checked':''}/>NG   
                                        <input type="radio" name="checkResult${i}" value="2" ${entity.Result == 2?'checked':''}/>OK
                                    </td>
                                    <td align="center" class="Field"><input type="text" class="remark" id="txtSN" class="scan-center-sn" style="width: 90%" value="${entity.Remark}"/> </td>
                                </tr>`;                   
                }
            }
            else{
                 htmlStr +=`<tr class="ListTableOddRow">
                                <td colspan="5" align="center">未查询到数据</td>
                            </tr>`;       
            }
            $("#item-list tbody").append(htmlStr);
         }

        //保存数据
        function Save() {
            var trs = $("#item-list tbody tr");
            if (trs.length <= 0) {
                alert("请先添加明细信息");
                return;
            }
   
            //遍历需要新增、编辑的数据
            var arr = [];
            var trObj;
            var item = {};
            trs.each(function () {
                trObj = $(this);
                item = {};
                item.SaleReturnNo = $.trim($("#lblSaleReturnNo").text());  
                item.SaleReturnRowId = $.trim($("#lblSaleReturnRowId").text());      
                item.SerialNumber = $.trim(trObj.find(".SerialNumber").text());            
                item.Result = parseInt($.trim(trObj.find(".Result input[name*='checkResult']:checked").val()||"0"));    
                item.Remark = $.trim(trObj.find(".remark").val()); 
                arr.push(item);
            });
            var entity = {};
            entity.jsonStr = JSON.stringify(arr);
            entity.createBy = userName;
            var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspSaveSaleReturnQualityResult", JSON.stringify(entity));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            
            alert('<%=Resources.Messages.SaveInSuccess%>');
            window.parent.Refresh();
        }

      

        //获取时间字符串形式
        function getDateString(date) {
            if (!date) {
                return "";
            }
            var today = new Date(date);
            return today.Format();
        }

        //时间转字符串
        Date.prototype.Format = function (fmt) {
            if (undefined == fmt || null == fmt) {
                fmt = "yyyy-MM-dd HH:mm:ss";
            }
            var t = this;
            var tf = function (str, len) {
                if (str.length < len) {
                    for (var i = 0; i < len - str.length; i++) {
                        str = "0" + str;
                    }
                }
                return str
            };
            var opt = {
                "y+": t.getFullYear().toString(),        // 年
                "M+": (t.getMonth() + 1).toString(),     // 月
                "d+": t.getDate().toString(),            // 日
                "H+": t.getHours().toString(),           // 时
                "m+": t.getMinutes().toString(),         // 分
                "s+": t.getSeconds().toString()          // 秒
                // 有其他格式化字符需求可以继续添加，必须转化成字符串
            };
            var ret;
            for (var k in opt) {
                ret = new RegExp("(" + k + ")").exec(fmt);
                if (ret) {
                    fmt = fmt.replace(ret[1], ret[1].length == 1 ? opt[k] : tf(opt[k], ret[1].length));
                }
            }
            return fmt;
        }

        
    </script>
</asp:Content>
