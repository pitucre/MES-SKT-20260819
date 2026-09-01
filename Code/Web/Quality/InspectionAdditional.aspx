<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/Masters.master" AutoEventWireup="true" CodeBehind="InspectionAdditional.aspx.cs" Inherits="SKT.LeanMES.Web.Quality.InspectionAdditional" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../Content/plugin/autocomplete/jquery.autocomplete.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        #tblExpand tr td { text-align:center; }
        #spanInspectionOrderNo { font-weight:bold; }
        #spanSerialNumber { font-weight:bold; }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<table class="EditeContentTable" width="100%">
        <tr id="trInspectionOrderNo">
            <td class="Label1">
                <asp:Label ID="lbInspectionTypeName" runat="server" Text="检单号"></asp:Label><em>*</em>
            </td>
             <td class="Field1">
                <asp:TextBox ID="InspectionOrderNo" runat="server" CssClass="TextBox"  IsRequired='1'  Enabled="false"></asp:TextBox>
                <input id="button1" class="ButtonBox" type="button" onclick="selectInspectionOrderNo()" value="..." title="选择检验单" /> 
                <asp:HiddenField ID="hfInspectionOrderId" runat="server" Value="-1" />
            </td>
        </tr>
          <tr id="trInspectionSerialNumber">
            <td class="Label1">
                条码<em>*</em>
            </td>
             <td class="Field1">
                <asp:TextBox ID="txtSerialNumber" runat="server" CssClass="TextBox" IsRequired="1" ></asp:TextBox>
            </td>
        </tr>
        <tr id="trBadGrades">
            <td class="Label1">
                缺陷等级
            </td>
             <td class="Field1">
                 <asp:DropDownList ID="ddlBadGrades" runat="server">
                 </asp:DropDownList>
            </td>
        </tr>
    </table>
    <div  style=" margin-top:15px; margin-bottom:15px; ">
        <div id="divInspectionAction">
        
            <table class="EditeContentTable" width="100%">
                <tr>
                    <td class="Label3">
                        检验单号
                    </td>
                     <td class="Field3">
                        <span id="spanInspectionOrderNo">
                        </span>
                    </td>
                    <td class="Label3">
                        此单产品
                    </td>
                     <td class="Field3">
                         <span id="spanInspectionItemCode">
                         </span>
                    </td>
                    <td class="Label3">
                        此单数量
                    </td>
                     <td class="Field3">
                         <span id="spanInspectionOrderQty">
                         </span>
                    </td>
                </tr>
                <tr id="trSaveOrderBtn" >
                    <td class="Field3" colspan="6" style=" text-align:center; " >
                          <input id="InspectionBtn" type="button" value=" 检 验 " onclick="OpenInspectionOrderMember()" />
                          <input type="button" value=" 批 过 " onclick="SaveInspectionOrderMember('批过',this)" />
                          <input type="button" value="批不过" onclick="SaveInspectionOrderMember('批不过',this)"  />
                    </td>
                </tr>
        </table>    
        
        </div>
         <div id="divInspectionObj" style=" margin-top:15px; margin-bottom:15px; " >
            <table class="EditeContentTable" width="100%">
                 <tr>
                    <td class="Label3">
                        受检条码
                    </td>
                     <td class="Field3">
                           <span id="spanSerialNumber" ></span>
                    </td>
                    <td class="Label3">
                        最小包装
                    </td>
                     <td class="Field3" colspan="4">
                          <span  id="spanMinPackagingQty" style=" float:left; margin-top:5px;">0</span>
                          <span style=" float:right; margin-left:10px; " >
                            &nbsp;
                          </span>
                          <input type="button" value="不合格" style=" float:right; margin-left:10px; "  onclick="SaveInspectionOrderMemberResult('不合格',this)" />
                          <input type="button" value=" 合 格 " style=" float:right; " onclick="SaveInspectionOrderMemberResult('合格',this)" />
                    </td>
                </tr>
            </table>
         </div>
    </div>
   <table id="tblExpand" class="ListTable" style="border-width:0px;width:100%;border-collapse:collapse; margin-top:5px;"  >
        <tr class="ListTableHeader" >
            <th rowspan="2" >序号</th>
            <th rowspan="2" >检验项</th>
            <th  colspan="2" >检验规格</th>
            <th rowspan="2" >特殊<br />要求</th>
             <th rowspan="2" >累计</th>
            <th rowspan="2" >检验值</th>
            <th rowspan="2" >检验<br />结果</th>
            <th rowspan="2" >检验<br />依据</th>
            <th rowspan="2" >检验员</th>
            <th rowspan="2" >备注</th>
            <th rowspan="2" ><input  onclick="SaveAll(this)" type="button" value="保存所有项" /></th>
        </tr>
          <tr class="ListTableHeader"  >
            <th >最小值</th>
            <th >最大值</th>
        </tr>
   </table>

   <script type="text/javascript" >
       var tab = document.getElementById("tblExpand");
       var TypeId = '<%=Request["TypeId"] %>'; /*页面布局  1：审核 2：检验  10：综合*/
       var InspectionTypeId = '<%=Request["InspectionTypeId"]  %>';  /*验检单类型 */
       var IOrderId = '<%=IOrderId %>';                /*检验单ID*/
       var IOrderNo = '<%=IOrderNo %>';                /*检验单号*/
       var IOMemberId = -1;              /*受检对象ID*/
       var userName = "<%=userName %>";
       var ItemCode = "<%=ItemCode %>";

       var ShowMessCount = 0;

       function OpenInspectionOrderMember() {
           if (IOrderId == -1) {
               alert("请选择检验单！");
               return;
           }
           dialog({ title: "检验单检验",
               src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Quality/Inspection.aspx?TypeId=2&InspectionTypeId=1&IOrderId=" + IOrderId + "&IOrderNo=" + IOrderNo + "&rnd=" + Math.random(), width: 950, height: 450
           });
       }

       /*页面模板设计*/
       function PageModelSetting() {

           $("#trBadGrades").css("display", "none");

           if (InspectionTypeId == 2) {
               $("#trBadGrades").css("display", "block"); 
           }

           if (TypeId == 1) {
               $("#divInspectionObj").css("display", "none");
               $("#tblExpand").css("display", "none");
               $("#trInspectionSerialNumber").css("display", "none");
           }
           else if (TypeId == 2) {
               $("#trInspectionOrderNo").css("display", "none");
               $("#trSaveOrderBtn").css("display", "none");
              
           }
           /*追加检验模式*/
           else if (TypeId == 9) {
               if (IOrderId > 0) {
                   $("#trInspectionOrderNo").css("display", "none");
               }
               $("#InspectionBtn").css("display", "none");
               $("#divInspectionAction").css("display", "none");
               $("#divInspectionObj").find("input[type='button']").css("display", "none");
           }
           else if (TypeId == 10) {
               $("#InspectionBtn").css("display", "none");
               if (IOrderId > 0) {
                   $("#trInspectionOrderNo").css("display", "none");
               }
           }
       }


       $(function () {
           PageModelSetting();

           $("#<%=this.txtSerialNumber.ClientID%>").keydown(function (e) {
               var curKey = 0, e = e || window.event;
               curKey = e.keyCode || e.which || e.charCode;
               if (curKey == 13) {
                   var SerialNumber = $(this).val();
                   if (false == parent.ScanValidation(SerialNumber)) {
                       $(this).val("");
                       return;
                   }
                   LoadInspectionOrderMember($("#spanInspectionOrderNo").html(), SerialNumber);
                   $(this).val("");

               }
           });

           LoadInspectionItem(IOrderNo);
           if (TypeId == 9) {
               parent.SetInspectionOrder(IOrderId, IOrderNo);
           }
       })

       function selectInspectionOrderNo() {

           var condition = " Statue =1 AND InspectionTypeId = " + InspectionTypeId;
           dialog({ title: "<%=Resources.Common.ChooseWindow %>",
               src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=69&CallBackFunc=getChooseValueWO&SearchCondition=" + condition + "&Multiple=false&rnd=" + Math.random(), width: 500, height: 200
           });
       }

       function getChooseValueWO(list) {
           $("#<%=this.hfInspectionOrderId.ClientID%>").val(list[0][0]);
           $("#<%=this.InspectionOrderNo.ClientID%>").val(list[0][1]);

           IOrderId = list[0][0];
           IOrderNo = list[0][1];
           LoadInspectionItem(IOrderNo);

       }

       function LoadInspectionOrderMember(InspectionOrderNo, SerialNumber) {
           if (InspectionOrderNo == "") {
               alert("请先选择或扫描检验号！");
               return;
           }
           if (TypeId == 9) {
              var ajax =   SKT.LeanMES.Web.AjaxServices.AjaxInspection.AdditionalSerialNumber(InspectionTypeId, -1, ItemCode, SerialNumber, userName, IOrderId)
              if (ajax.error != null) {
                  alert(ajax.error.Message);
                  return;
              }
           }
           ajax = SKT.LeanMES.Web.AjaxServices.AjaxInspection.GetInspectionOrderMemberByOrderNoAndSN(InspectionOrderNo, SerialNumber);
           if (ajax.error != null) {
               alert(ajax.error.Message);
               return;
           }
           var entityAry = ajax.value;
           if (entityAry.length > 0) {
               $("#spanMinPackagingQty").html(entityAry[0].Qty);
               $("#spanSerialNumber").html(entityAry[0].SerialNumber);
               IOMemberId = entityAry[0].IOMemberId;
           }
           else {
               alert(InspectionOrderNo + "不存在列码" + SerialNumber);
               $("#spanMinPackagingQty").html("");
               $("#spanSerialNumber").html("");
               IOMemberId = -1;
           }
       }

       /*通过检验单号加载检验项目*/
       function LoadInspectionItem(InspectionOrderNo) {
           if (InspectionOrderNo == null || typeof (InspectionOrderNo) == undefined || InspectionOrderNo == "") {
               return;
           }
           ClearInspectionItemTable();    /*清除检验项目列表*/
           var ajax = SKT.LeanMES.Web.AjaxServices.AjaxInspection.GetInspectionTemplateMember(InspectionOrderNo);
           if (ajax.error != null) {
               alert(ajax.error.Message);
               return;
           }
           var entityAry = ajax.value;
           $(tab).find(".ListTableOddRow").empty().remove();
           for (var i = 0; i < entityAry.length; i++) {
               addDetail(entityAry[i]);
           }

           var ajaxEn = SKT.LeanMES.Web.AjaxServices.AjaxInspection.GetInspectionOrderInfo(InspectionOrderNo);
           if (ajaxEn.error != null) {
               alert(ajaxEn.error.Message);
               return;
           }
           var info = ajaxEn.value;

           /*设置检验单信息*/
           SetInspectionOrderInfo(info.InspectionOrderNo, info.ItemCode, info.InspectionQty)

           $(this).val(InspectionOrderNo);
           $("#<%=this.txtSerialNumber.ClientID%>").focus();
       }

       /*设置检验单信息*/
       function SetInspectionOrderInfo(InspectionOrderNo, ItemCode, InspectionOrderQty) {
           $("#spanInspectionOrderNo").html(InspectionOrderNo);
           $("#spanInspectionItemCode").html(ItemCode);
           $("#spanInspectionOrderQty").html(InspectionOrderQty);
       }

       /*清除检验项目列表*/
       function ClearInspectionItemTable() {
           $(tab).find(".ListTableOddRow").empty().remove();
           $("#spanInspectionOrderQty").html("");
           $("#spanSerialNumber").html("");
           $("#spanMinPackagingQty").html("0");
       }

       function ClearSerialNumber() {
           IOMemberId = -1;
           $("#spanSerialNumber").html("");
           $("#spanMinPackagingQty").html("0");
       }

       /*清除所有*/
       function ClearAll() {
           IOrderId = -1;                   /*将检验单号赋值为-1*/
           IOrderNo = "";
           $(tab).find(".ListTableOddRow").empty().remove();


           $("#<%=this.InspectionOrderNo.ClientID%>").val("");
           $("#<%=this.txtSerialNumber.ClientID%>").val("");
           $("#<%=this.hfInspectionOrderId.ClientID%>").val("-1");

           $("#spanInspectionOrderNo").html("");
           $("#spanInspectionItemCode").html("");
           $("#spanInspectionOrderQty").html("");
           $("#spanSerialNumber").html("");
           $("#spanMinPackagingQty").html("0");
       }

       /*为检验列表添加检验行*/
       function addDetail(entity) {
           var row, cell;
           rowNewIdx = tab.rows.length;
           row = tab.insertRow(rowNewIdx);
           row.className = "ListTableOddRow";

           cell = row.insertCell(0);
           cell.align = "center";
           cell.className = "Field";
           cell.innerHTML = (rowNewIdx - 1);

           cell = row.insertCell(1);
           cell.align = "left";
           cell.className = "Field";
           cell.id = "InspectionItemName" + entity.InspectionTemplateMemberId;
           cell.innerHTML = entity.InspectionItemName;

           cell = row.insertCell(2);
           cell.align = "center";
           cell.className = "Field";
           cell.id = "StandardMinValue" + entity.InspectionTemplateMemberId;
           cell.innerHTML = entity.MinValue;

           cell = row.insertCell(3);
           cell.align = "center";
           cell.className = "Field";
           cell.id = "StandardMaxValue" + entity.InspectionTemplateMemberId;
           cell.innerHTML = entity.MaxValue;

           cell = row.insertCell(4);
           cell.align = "center";
           cell.className = "Field";
           cell.id = "SpecialRequest" + entity.InspectionTemplateMemberId
           cell.innerHTML = entity.SpecialRequest;

           cell = row.insertCell(5);
           cell.align = "center";
           cell.id = "InspectionItemOrderEDQty" + entity.InspectionTemplateMemberId
           cell.className = "Field";
           cell.innerHTML = 0;

           cell = row.insertCell(6);
           cell.align = "center";
           cell.width = "85px";
           cell.className = "Field";
           cell.innerHTML = '<input id="InspectionValue' + entity.InspectionTemplateMemberId + '" type="text" style=" width:80% " /> ';

           cell = row.insertCell(7);
           cell.align = "center";
           cell.className = "Field";
           cell.width = "85px";
           cell.innerHTML = '<select id="InspectionResult' + entity.InspectionTemplateMemberId + '"><option value="合格">合格</option><option value="不合格">不合格</option></select>';

           cell = row.insertCell(8);
           cell.align = "center";
           cell.className = "Field";
           cell.id = "InspectionAccording" + entity.InspectionTemplateMemberId;
           cell.innerHTML = entity.InspectionAccording;

           cell = row.insertCell(9);
           cell.align = "center";
           cell.className = "Field";
           cell.innerHTML = userName;

           cell = row.insertCell(10);
           cell.align = "center";
           cell.className = "Field";
           cell.width = "84px";
           cell.innerHTML = '<input id = "Remark' + entity.InspectionTemplateMemberId + '" type="text"  style=" width:80% "/> ';

           cell = row.insertCell(11);
           cell.align = "center";
           cell.className = "Field";
           cell.innerHTML = '<input type="button" class="SaveInspectionItem" id="_' + entity.InspectionTemplateMemberId + '" value="保存" />'
           +'&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" class="EditInspectionItem" id="_edit' + entity.InspectionTemplateMemberId + '" value="更新" />';

           BingSaveInspectionItemBtn('_' + entity.InspectionTemplateMemberId);
           BingEditInspectionItemBtn('_edit' + entity.InspectionTemplateMemberId);
//           $("#InspectionEDQty" + entity.InspectionTemplateMemberId).html(GetInspectionQty(entity.InspectionItemName));
           $("#InspectionItemOrderEDQty" + entity.InspectionTemplateMemberId).html(GetInspectionItemQty(entity.InspectionItemName, 1));
//           $("#InspectionItemEDQty" + entity.InspectionTemplateMemberId).html(GetInspectionItemQty(entity.InspectionItemName, 2));
       }

       function BingEditInspectionItemBtn(id) {
           $("#" + id).click(function () {
               ShowMessCount = ShowMessCount - 1;
               $(this).attr("disabled", "disabled");
               if (IOMemberId == -1) {
                   alert("请扫描受检条码!");
                   this.removeAttribute("disabled");
                   return;
               }

               var id = $(this).attr("id").replace("_edit", "");
               var entity = {};
               entity.IOMItemId = -1;
               entity.IOrderId = IOrderId;
               entity.IOMemberId = IOMemberId;
               entity.InspectionItemName = $("#InspectionItemName" + id).html();
               entity.SnspectionItemName = $("#SnspectionItemName" + id).html();
               entity.StandardMaxValue = $("#StandardMaxValue" + id).html();
               entity.StandardMinValue = $("#StandardMinValue" + id).html();
               entity.InspectionAccording = $("#InspectionAccording" + id).html();
               entity.SpecialRequest = $("#SpecialRequest" + id).html();
               entity.InspectionResult = $("#InspectionResult" + id).val();
               entity.InspectionValue = $("#InspectionValue" + id).val();
               entity.Remark = $("#Remark" + id).val();
               entity.CreateBy = userName;
               entity.ModifyBy = "";
               var ajax = SKT.LeanMES.Web.AjaxServices.AjaxInspection.UpdateInspectionOrderMemberItem(entity);
               if (ajax.error != null) {
                   if (ShowMessCount <= 0 || ShowMessCount == $(".SaveInspectionItem").length) {
                       alert(ajax.error.Message);
                   }
                
                   this.removeAttribute("disabled");
                   return;
               }
               $("#Remark" + id).val("");
               $("#InspectionValue" + id).val("")
               this.removeAttribute("disabled");
               $("#InspectionEDQty" + id).html(GetInspectionQty(entity.InspectionItemName));
               $("#InspectionItemOrderEDQty" + id).html(GetInspectionItemQty(entity.InspectionItemName, 1));
               $("#InspectionItemEDQty" + id).html(GetInspectionItemQty(entity.InspectionItemName, 2));

               //更新受检对象的缺陷等级
               UpdateBadGrades();
           })
       }



       /*保存受检条码检验项目结果*/
       function BingSaveInspectionItemBtn(id) {
           $("#" + id).click(function () {
               ShowMessCount = ShowMessCount - 1;
               $(this).attr("disabled", "disabled");
               if (IOMemberId == -1) {
                   alert("请扫描受检条码!");
                   this.removeAttribute("disabled");
                   return;
               }
               var id = $(this).attr("id").replace("_", "");
               var entity = {};
               entity.IOMItemId = -1;
               entity.IOrderId = IOrderId;
               entity.IOMemberId = IOMemberId;
               entity.InspectionItemName = $("#InspectionItemName" + id).html();
               entity.SnspectionItemName = $("#SnspectionItemName" + id).html();
               entity.StandardMaxValue = $("#StandardMaxValue" + id).html();
               entity.StandardMinValue = $("#StandardMinValue" + id).html();
               entity.InspectionAccording = $("#InspectionAccording" + id).html();
               entity.SpecialRequest = $("#SpecialRequest" + id).html();
               entity.InspectionResult = $("#InspectionResult" + id).val();
               entity.InspectionValue = $("#InspectionValue" + id).val();
               entity.Remark = $("#Remark" + id).val();
               entity.CreateBy = userName;
               entity.ModifyBy = "";
               var ajax = SKT.LeanMES.Web.AjaxServices.AjaxInspection.SaveInspectionOrderMemberItem(entity);
               if (ajax.error != null) {
                   if (ShowMessCount <= 0 || ShowMessCount == $(".SaveInspectionItem").length) {
                       alert(ajax.error.Message);
                   }
                   this.removeAttribute("disabled");
                   return;
               }
               this.removeAttribute("disabled");
               $("#InspectionEDQty" + id).html(GetInspectionQty(entity.InspectionItemName));
               $("#InspectionItemOrderEDQty" + id).html(GetInspectionItemQty(entity.InspectionItemName, 1));
               $("#InspectionItemEDQty" + id).html(GetInspectionItemQty(entity.InspectionItemName, 2));

               //更新受检对象的缺陷等级
               UpdateBadGrades();
           })
       }

       //更新受检对象的缺陷等级
       function UpdateBadGrades() {
           var BadGrades = $("#<%=this.ddlBadGrades.ClientID%>").val();
           var ajax = SKT.LeanMES.Web.AjaxServices.AjaxInspection.UpdateBadGrades(IOMemberId, BadGrades);
           if (ajax.error != null) {
               alert(ajax.error.Message);
           }
       }

       //通过检验项获取实抽对象个数
       function GetInspectionQty(InspectionItemName) {
           if (IOrderId == -1) {
               return;
           }
           var ajax = SKT.LeanMES.Web.AjaxServices.AjaxInspection.GetInspectionQty(IOrderId, InspectionItemName);
           return ajax.value;
       }

       //通过检验项获取检验资数  flag｛1：检验单  2:受检对象｝
       function GetInspectionItemQty(InspectionItemName, flag) {
           if (IOrderId == -1) {
               return;
           }
           var ajax = SKT.LeanMES.Web.AjaxServices.AjaxInspection.GetInspectionItemObjQty(IOrderId, IOMemberId, InspectionItemName, flag);
           return ajax.value;
       }


       /*保存受检条码结果*/
       function SaveInspectionOrderMemberResult(result, obj) {
           if (IOMemberId == -1) {
               alert("请扫描受检条码!");
               return;
           }
           $(obj).attr("disabled", "disabled");
           var ajax = SKT.LeanMES.Web.AjaxServices.AjaxInspection.SaveInspectionOrderMemberResult(IOMemberId, result);
           if (ajax.error != null) {
               alert(ajax.error.Message);
               obj.removeAttribute("disabled");
               return;
           }
           obj.removeAttribute("disabled");
           ClearSerialNumber();
       }



       /*保存受检单结果*/
       function SaveInspectionOrderMember(result, obj) {
           if (IOrderId == -1) {
               alert("请选择检验单！")
               return;
           }
           $(obj).attr("disabled", "disabled");
           var r = confirm("你将审批" + IOrderNo + "为" + result);
           if (r == false) {
            return;
           }
           var ajax = SKT.LeanMES.Web.AjaxServices.AjaxInspection.SaveInspectionOrderResult(IOrderId, result);
           if (ajax.error != null) {
               alert(ajax.error.Message);
               obj.removeAttribute("disabled");
               return;
           }
           obj.removeAttribute("disabled");
           alert("审核成功！");
           ClearAll();
           if ($("#trInspectionOrderNo").css("display") == "none") {
               parent.CloseDialog();
           }
       }


       function SaveAll(obj) {
           if (IOMemberId == -1) {
               alert("请扫描受检条码!");
               obj.removeAttribute("disabled");
               return;
           }
           $(obj).attr("disabled", "disabled");
           ShowMessCount = $(".SaveInspectionItem").length;
           $(".SaveInspectionItem").click();
           obj.removeAttribute("disabled");
       }
    
   </script>
   
</asp:Content>
