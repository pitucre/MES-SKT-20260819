<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/Masters.master" AutoEventWireup="true"
    CodeBehind="MaterialApplyPrint.aspx.cs" Inherits="SKT.LeanMES.Web.Material.MaterialApplyPrint" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script src="../Content/plugin/JsBarcode/JsBarcode.all.min.js" type="text/javascript"></script>  
    <div>
        <style type="text/css">
            
             #barcode{  /***条码宽度***/
                 width:200px; 
             }
            .box
            {
                margin:0 auto;
            }
            .divHead
            {
                width:95%;
                font-size:16px;
            }
            .head
            {
                width:95%;
                font-size:10px;
                height:50px;
            }
            .middle
            {
                width:95%;
                font-size:10px;
                border-collapse:collapse;
            
            } 
            .middle  thead th
            {
                height:16px;
                border: 1px solid #0000FF;
            } 
         
            .middle tbody tr
            {
                height:5px;
            }
           
         
            .middle tbody tr td
            {
                height:5px;
                border:1px solid #0000FF;
            }
                       
            .bottom
            {
                width:95%;
                height:5px;   
                font-size:10px;
            }
        </style>
        <object id="WebBrowser" style="display: none" classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2"
            height="0" width="0">
        </object>
        <center>
    <div style="font-size: 20px; font-weight: bolder; text-align: center; font-family: @宋体;">领 料 单</div>    <table class="head">
        <tr>
          <td align="left">领料部门：<span id="SpanDep"></span>  
          </td>
           <td></td>
          <td></td>
          <td align="right">日期：<span id="SpanDate"></span></td>
          <%--<td align="right">编号：<span id="SpanCode"></span></td>--%>
          <td align="right"><img id="barcode"/></td>
        </tr>
    </table>
      <table class="middle" id="tblMiddle">
          <thead>
              <th style=" width:5%">行号</th>
              <th style="width:10%">物料代码</th> 
              <th style=" width:20%">物料名称</th>
              <th style=" width:20%">规格型号</th>
              <th style=" width:5%">单位</th>
              <th style="width:5%">申请数量</th>
              <th style=" width:5%">备料数量</th>
              <th style="width:10%">备注</th>
              <th style=" width:10%">生产任务单号</th>
          </thead> 
        <tbody id="idbody">
        </tbody>
    </table>    </center>
 
        <script type="text/javascript">
            var Id = '<%=Request.QueryString["ID"]%>';
            var barContent = '';
            $(document).ready(function () {
                //GetData(Id);
                //BirongLiang 2017-2-10  增加条码，默认CODE128
                /*var barcode = document.getElementById('barcode'),
                var str = "12345678",
                var options = {
                    format: "CODE128",
                    displayValue: true,
                    fontSize: 18,
                    height: 100
                };
                JsBarcode(barcode, str, options); */

//                JsBarcode("#barcode", barContent);
//                //打印单据
//                PrintForm();
            });

            //获取数据
            function GetData(id) {
                //加载
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialApply.GetApplyPrint(id);
                if (ajax.error == null) {
                    //表头信息
                    var e = $.parseJSON(ajax.value).data[0];
                    $("#SpanDep").html(e.DepName);
                    $("#SpanDate").html(e.CreateDateTime);
                    //$("#SpanCode").html(e.ApplyNo);
                    barContent=e.ApplyNo;

                    //表身信息
                    var list = $.parseJSON(ajax.value).data1;
                    addDetail(list);

                } else {
                    alert(ajax.error.Message);
                    return false;
                }
            }
            function addDetail(list) {
                var row = "", page = 0;
                for (var i = 0; i < list.length; i++) {
                    if (list[i].Units == "0") {
                        list[i].Units = "";
                    }
                    row += "<tr>" +
                  "<td class='lbDtl' style='text-align:center;'>" + parseInt(i + 1) + "</td>" +
                  "<td class='lbDtl' style='text-align:center;'>" + list[i].ItemCode + "</td>" +
                  "<td class='lbDtl' style='text-align:center;'>" + list[i].ItemName + "</td>" +
                  "<td class='lbDtl' style='text-align:center;'>" + list[i].ItemSpec + "</td>" +
                  "<td class='lbDtl' style='text-align:center;'>" + list[i].Units + "</td>" +
                  "<td class='lbDtl' style='text-align:center;'>" + list[i].ApplyQty + "</td>" +
                  "<td class='lbDtl' style='text-align:center;'>" + list[i].StockQty + "</td>" +
                  "<td class='lbDtl' style='text-align:center;'>" + list[i].Remark + "</td>" +
                  "<td class='lbDtl' style='text-align:center;'>" + list[i].MOCode + "</td></tr>";
                }
                $("#idbody").append(row);
            }

            //打印单据
            function PrintForm() {
                if (document.all.WebBrowser) {
                    document.all.WebBrowser.ExecWB(7, 1)
                }
                else {
                    //  window.print();
                    WebBrowser.ExecWB(7, 1)
                }
            }
        </script>
        <script src="../Content/plugin/barCode/jquery-barcode.js" type="text/javascript"></script>
        <link href="../Content/plugin/calendar/skin/datepicker.css" rel="stylesheet" type="text/css" />
        <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/calendar/js/jquery.ui.core.js"
            type="text/javascript"></script>
        <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/calendar/js/jquery.ui.datepicker.js"
            type="text/javascript" charset="GBK"></script>
        <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/calendar/js/jquery.ui.datepicker.zn.js"
            type="text/javascript"></script>
        <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/jqPrint/jquery.jqprint-0.3.js"
            type="text/javascript"></script>
    </div>
</asp:Content>

