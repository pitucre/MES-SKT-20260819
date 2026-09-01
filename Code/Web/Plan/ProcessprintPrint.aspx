<%@ Page Language="C#" MasterPageFile="~/Masters/Masters.master" AutoEventWireup="true" CodeBehind="ProcessprintPrint.aspx.cs" Inherits="SKT.LeanMES.Web.Plan.ProcessprintPrint" %>

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
        <object id="WebBrowser" style="display: none;margin:auto" classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2"
            height="0" width="0">
        </object>
        <center>
    <div style="font-size: 20px; font-weight: bolder; text-align: center; font-family: @宋体;">工艺流程卡</div>    <table class="head">
        <tr>
          <td align="left">工单：<span id="OrderNo"></span>  
          </td>
           <td align="center">图号:<span id="ItemSpec"></span></td>
          <td align="right">产品编码:<span id="ItemCode"></span></td>
          <%--<td align="right"><img id="barcode"/></td>--%>
        </tr>
        <tr>
            <td align="left">
                产品名称:<span id="ItemName"></span>
            </td>
            <td align="center">
                工艺路线:<span id="R_Name"></span>
            </td>
            <td align="right">
                计划生产数量:<span id="Qty_to_Build"></span>
            </td>
        </tr>
        <tr>
            <td align="left">
                母单号:<span id="Finishedorder"></span>
            </td>
            <td align="center">
                成品料号:<span id="FinishedNo"></span>
            </td>
            <td align="right">
               
            </td>
        </tr>
    </table>
      <table class="middle" id="tblMiddle">
          <thead>
              <th style="width:8%">工序条码</th> 
              <th style=" width:10%">工序名称</th>
              <th style=" width:20%">工艺说明</th>
              <th style=" width:10%">质量关键控制点</th>
              <th style="width:5%">首件确认</th>
          </thead> 
        <tbody id="idbody">
        </tbody>
    </table>    </center>
 
        <script type="text/javascript">
           
            var Id = '<%=Request.QueryString["ID"]%>';
            var barContent = '';
            //$(document).ready(function () {
            //    GetData(Id);
            //});
           
            //获取数据
            function GetData(id) {
                //加载
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPlan.GetRnamePrint(Id);
                if (ajax.error == null) {
                    //表头信息
                    var e = $.parseJSON(ajax.value).data[0];
                    $("#OrderNo").html(e.OrderNO);
                    $("#ItemSpec").html(e.ItemSpec);
                    $("#ItemCode").html(e.ItemCode);
                    $("#ItemName").html(e.ItemName);
                    $("#R_Name").html(e.R_Name);
                    $("#Qty_to_Build").html(e.Qty_to_Build);
                    $("#Finishedorder").html(e.Finishedorder);
                    $("#FinishedNo").html(e.FinishedNo);
                    //$("#SpanCode").html(e.ApplyNo);
                    //barContent=e.ApplyNo;

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
                    //if (list[i].Units == "0") {
                    //    list[i].Units = "";
                    //}
                    row += "<tr>" +
                  //"<td class='lbDtl' style='text-align:center;'>" + parseInt(i + 1) + "</td>" +
                  "<td class='lbDtl' style='text-align:center;' id='rcode'>" + qrcode.makeCode(list[i].Station) + "</td>" +
                  "<td class='lbDtl' style='text-align:center;'>" + list[i].Station + "</td>" +
                  "<td class='lbDtl' style='text-align:center;'>" + list[i].Remrk + "</td>" +
                  "<td class='lbDtl' style='text-align:center;'>" + list[i].Control + "</td>" +
                  "<td class='lbDtl' style='text-align:center;'></td></tr>";
                }
                $("#idbody").append(row);
            }

            //打印单据
            function PrintForm() {
                if (document.all.WebBrowser) {
                    document.all.WebBrowser.ExecWB(6, 6)
                }
                else {
                    //  window.print();
                    WebBrowser.ExecWB(6, 6)
                }
            }
        </script>
        <script src="../Content/plugin/barCode/jquery-barcode.js" type="text/javascript"></script>
        <script src="../Content/plugin/barCode/qrcode.min.js" type="text/javascript"></script>
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
