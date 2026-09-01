<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GRNTransfer.aspx.cs" Inherits="SKT.LeanMES.Web.MobileApp.GRNTransfer" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, minimum-scale=1, maximum-scale=1" />
    <link href="theme/flatui/jquery.mobile.flatui.min.css?v=11" rel="stylesheet" type="text/css" />
    <link href="css/common.css" rel="stylesheet" type="text/css" />
    <script src="js/jquery.min.js" type="text/javascript"></script>
    <script src="js/jquery.mobile-1.4.5.min.js" type="text/javascript"></script>
    <script src="js/Common.js" type="text/javascript"></script>
    <script src="js/skt.mobile.material.js" type="text/javascript"></script>
    <title>GRN转移</title>
    <style type="text/css">
        .clear
        {
            clear: both;
            height: 2px;
        }    .ui-title {
            line-height: 30px;
            
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div data-role="page" id="pageOne">
        <div data-role="header" id="header" data-position="fixed">
            <h5 style="padding: 4px; margin: 0px;">            
                  <div>
                        <label style="font-size: 17px !important; font-weight: bold; color: #FFFFFF">GRN转移</label>
                    </div>
            </h5>
             <a href="" data-rel="back" data="" role="button" class="ui-btn-left" data-icon="back"
                    data-transition="none" data-ajax="false">返回</a> 
            <%--<div data-role="navbar" data-theme="c">
                <ul>
                    <li><a href="#" data-transition="none" data-theme="c">设置</a></li>
                    <li><a href="#pageTwo" data-transition="none" data-theme="c">上料</a></li>
                    <li><a href="#AddMaterial" data-transition="none" data-theme="c">续料</a></li>
                    <li><a href="#" data-transition="none" data-theme="c" onclick="Search()">查询</a></li>
                </ul>
            </div>--%>
        </div>
        <div data-role="content">
            <div data-role="fieldcontain">
                <label for="fline">
                      &nbsp;&nbsp;&nbsp;&nbsp;源GRN</label>
                  <input class="txtGrn" id="txtGrn" type="text" data-mini="true" value="" />
                <div class="clear">
                </div>
                <label for="fRes">
                    目标GRN</label>
                <input class="txtTargetGrn" id="txtTargetGrn" type="text" data-mini="true" value="" />
                <div class="clear">
                </div> 
                <label for="fRes">
                    转移数量</label>
                <input class="txtTargetQty" id="txtTargetQty" type="text" data-mini="true" value="" />
                <div class="clear">
                </div>               
            </div>
        </div>
        <div data-role="footer" data-position="fixed">
            <div data-role="navbar">
                <ul>
                    <li><a href="#" data-transition="none" onclick="GRNTransfer();" style="background-color: Gray">
                        保存</a></li>                    
                </ul>
            </div>
        </div>
    </div>
        </form>
     <script type="text/javascript">

         $(document).ready(function () {
             $("#txtGrn").select();
         });

         /*扫描物料条码*/
         $("#txtGrn,#txtTargetGrn,#txtTargetQty").on("keydown", function (e) {
             var curKey = 0, e = e || window.event;
             curKey = e.keyCode || e.which || e.charCode;
             if (curKey == 13) {
                 if (this.value == "") {
                     return false;
                 }
                 if (this.id == "txtGrn") {
                     $("#txtTargetGrn").select();
                     return false;
                 }
                 if (this.id == "txtTargetGrn") {
                     $("#txtTargetQty").select();
                     return false;
                 }
                 GRNTransfer();
             }
         });

         $("#txtTargetQty").on("keyup", function (e) {
             getDecimalVal(this);
         });

         function GRNTransfer() {
             var grn = $.trim($("#txtGrn").val());
             var targetGrn = $.trim($("#txtTargetGrn").val());
             var qty =  parseFloat($.trim($("#txtTargetQty").val()));

             if (grn == "") {
                 confirmDialogFocus("请扫描源GRN！", function () {
                     $("#txtGrn").select();
                 });
                 return false;
             }
             if (targetGrn == "") {
                 confirmDialogFocus("请扫描目标GRN！", function () {
                     $("#txtTargetGrn").select();
                 });
                 return false;
             }

             var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.GRNTransfer(grn, targetGrn, qty);

             if (ajax.error != null) {
                 var seq = ajax.error.Message.substring(0, 1);
                 var error = ajax.error.Message.substring(1);
                 confirmDialogFocus(error, function () {
                   
                     if (seq == "1") {
                         $("#txtGrn").select();
                     }
                     else if (seq == "2") {
                         $("#txtTargetGrn").select();
                     }
                     else if (seq == "3") {
                         $("#txtTargetQty").select();
                     }
                     else {
                         $("#txtGrn").select();
                     }
                 });                 
                 return false;
             }
             confirmDialogFocus("GRN转移成功！", function () {
                 $("#txtGrn").val("").select().focus();
                 $("#txtTargetGrn").val("");
                 $("#txtTargetQty").val("");
             });
         }

         /**
        *   限制输入为数字和小数点
        **/
         function getDecimalVal(obj) {
             //得到第一个字符是否为负号
             var t = obj.value.charAt(0);
             //先把非数字的都替换掉，除了数字和. 
             obj.value = obj.value.replace(/[^\d\.]/g, '');
             //必须保证第一个为数字而不是. 
             obj.value = obj.value.replace(/^\./g, '');
             //保证只有出现一个.而没有多个. 
             obj.value = obj.value.replace(/\.{2,}/g, '.');
             //保证.只出现一次，而不能出现两次以上 
             obj.value = obj.value.replace('.', '$#$').replace(/\./g, '').replace('$#$', '.');
             //如果第一位是负号，则允许添加
             //  if (t == '-') {
             //      obj.value = '-' + obj.value;
             //  }
         }
     </script>    
</body>
</html>
