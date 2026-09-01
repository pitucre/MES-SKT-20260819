<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="InspectionOQCCheck.aspx.cs" Inherits="SKT.LeanMES.Web.Quality.InspectionOQCCheck" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <table class="EditeContentTable" width="100%" style="display:none">
        <tr id="trInspectionOrderNo">
            <td class="Label1">
                <asp:Label ID="lbInspectionTypeName" runat="server" Text="检单号"></asp:Label><em>*</em>
            </td>
             <td class="Field1">
                <asp:TextBox ID="InspectionOrderNo" runat="server" CssClass="TextBox"></asp:TextBox>
                <input id="button1" class="ButtonBox" type="button" onclick="selectInspectionOrderNo()" value="..." title="选择检验单" /> 
                <asp:HiddenField ID="hfInspectionOrderId" runat="server" Value="-1" />
            </td>
        </tr>
        <tr id="trInspectionSerialNumber">
        <td class="Label1">
            物料条码<em>*</em>
        </td>
            <td class="Field1">
            <asp:TextBox ID="txtSerialNumber" runat="server" CssClass="TextBox"></asp:TextBox>
        </td>
    </tr>
    </table>
    <div style=" margin-top:15px; margin-bottom:15px; ">
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
                    产品编码
                </td>
                 <td class="Field3">
                     <span id="spanInspectionItemCode">
                     </span>
                </td>
                <td class="Label3">
                    检验单数量
                </td>
                 <td class="Field3">
                     <span id="spanInspectionOrderQty">
                     </span>
                </td>
            </tr>
            <tr>
                <td class="Label3">
                    检验员
                </td>
                 <td class="Field3">
                     <input type="text" id="txtCheck" style=" width:90%"/>
                </td>
                <td class="Label3">
                    审核
                </td>
                 <td class="Field3">
                     <input type="text" id="txtSign" style=" width:90%"/>
                </td>
                <td class="Label3">
                    版本
                </td>
                 <td class="Field3">
                     <input type="text" id="txtPrintLv" value="RF-GI-QM-081-01-V1.0" style=" width:160px"/>
                </td>
            </tr>
            <tr>
                <td class="Label3">
                   最终检验结果 
                </td>
                 <td class="Field3" colspan="5">
                    <label style=" color:Red"><input id='cbFormOK' type="checkbox" onchange='FinalResult(this)'/>合格</label>&nbsp;&nbsp; 
                    <label style=" color:Red"><input id='cbFormNG' type="checkbox" onchange='FinalResult(this)'/>不合格</label>
                </td>
            </tr>
            <tr id="trSaveOrderBtn" >
                <td class="Field3" colspan="6" style=" text-align:center; " >
                    <input id="SaveBtn" type="button" value=" 保存检验结果 " onclick="if (SubmitValidation()){SaveForm();}" />
                    <input id="btnGrnNg" type="button" value=" GRN信息 " onclick="GrnNg();" style="display:none;" />
                </td>
            </tr>
        </table>    
    </div>
    <div id="divDtl">
    </div>
    <br />
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label" style=" width:20%; text-align:center">备注：</td>
            <td class="Field" style=" width:80%; text-align:center">
                <input id="txtRemark" type="text" style=" width:97%; height:30px" name="name" value="" />
            </td>
        </tr>
    </table>
   <script type="text/javascript" >
       var tab = document.getElementById("tblExpand");
       var TypeId = '<%=Request["TypeId"] %>'; /*页面布局  1：审核 2：检验  10：综合*/
       var name = '<%=Request["name"] %>'; //Material_IQCFormView查看
       var InspectionTypeId = '<%=Request["InspectionTypeId"]  %>';  /*验检单类型 */
       var ProductOQCId = '<%=Request["IOrderId"]??"-1"  %>';    /*检验单ID*/
       var IOrderId = ProductOQCId;                              /*检验单ID*/

       var userName = "<%=userName %>";
       var ItemCode = "";
       var moCount = 0; //  模版项计数
       var ShowMessCount = 0;

       //模版检验项列表
       var listItem = [];
       //模版LCR检验项列表
       var Lcrlist = [];

       /*页面模板显示*/
       function PageModelSetting() {
           if (TypeId == 1) {
               $("#divInspectionObj").css("display", "none");
               $("#tblExpand").css("display", "none");
               $("#trInspectionSerialNumber").css("display", "none");
           }
           $("#txtCheck").val(userName);
       }

       $(function () {
           PageModelSetting();

           $("#<%=this.txtSerialNumber.ClientID%>").keydown(function (e) {
               var curKey = 0, e = e || window.event;
               curKey = e.keyCode || e.which || e.charCode;
               if (curKey == 13) {
                   var SerialNumber = $(this).val();
                   LoadInspectionOrderMember($("#spanInspectionOrderNo").html(), SerialNumber);
                   $(this).val("");

                   /*通过触发点击事件获取各检验项目的实抽数量*/
                   $(".InspectionItemEDQty").click();
               }
           });
           //获取根据检验单Id获取检验信息
           if (InspectionTypeId != -1) {
               getFormInfo();
           }
           //input 事件焦点设定
           $('input:checkbox').click(function () {
               this.blur();
               this.focus();
           });
           //可否编辑
           if (name === 'Material_IQCFormView') {
               $('input').attr("disabled", "disabled");
               $("#trSaveOrderBtn").css("display", "none");
           }
       })

       function selectInspectionOrderNo() {

           var condition = " Statue =0 ";
           dialog({ title: "<%=Resources.Common.ChooseWindow %>",
               src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=69&CallBackFunc=getChooseValueWO&SearchCondition=" + condition + "&Multiple=false&rnd=" + Math.random(), width: 500, height: 200
           });
       }

       //获取检验单
       function getChooseValueWO(list) {
           $("#<%=this.hfInspectionOrderId.ClientID%>").val(list[0][0]);
           $("#<%=this.InspectionOrderNo.ClientID%>").val(list[0][1]);

           IOrderId = list[0][0];
           IOrderNo = list[0][1];
           //获取根据检验单Id获取检验信息
           getFormInfo();
       }

       //获取根据检验单Id获取检验信息
       function getFormInfo() {
           var ajax = SKT.LeanMES.Web.AjaxServices.AjaxInspectionOQC.GetOqcFormModel(IOrderId);
           if (ajax.error != null) {
               alert(ajax.error.Message);
               if (ProductOQCId != -1) {
                   parent.Refresh();
               }
               return;
           }
           if (ajax.value != null) {
               var en = $.parseJSON(ajax.value);
               ItemCode = en.data[0].ItemCode;

               $("#spanInspectionOrderNo").html(en.data[0].ProductOQCNo);
               $("#spanInspectionItemCode").html(ItemCode);
               $("#spanInspectionOrderQty").html(en.data[0].Qty);
               $("#txtSign").val(en.data[0].Auditing);
               if (en.data[0].InspectionResult === 0) {
                   $("#cbFormNG").attr("checked", "checked");
                   $("#cbFormOK").removeAttr('checked');
               }
               else if (en.data[0].InspectionResult === 1) {
                   $("#cbFormNG").removeAttr('checked');
                   $("#cbFormOK").attr("checked", "checked");
               }

               if (en.data[0].InspectionUser != null && en.data[0].InspectionUser != "") {
                   $("#txtCheck").val(en.data[0].InspectionUser);
               }
               if (en.data[0].PrintLv != null && en.data[0].PrintLv != "") {
                   $("#txtPrintLv").val(en.data[0].PrintLv);
               }
               if (en.data[0].Remark != null && en.data[0].Remark != "") {
                   $("#txtRemark").val(en.data[0].Remark);
               }

               //加载检验模版项
               moCount = 0;
               LoadInspectionItem(en.data1);
               //加载LCR检验项
               DetailLcrItem(en.data[0].ProductOQCId);

           }
       }

       function FinalResult(t) {
           var cb = $(t).attr('id') == "cbFormOK" ? "cbFormNG" : "cbFormOK";
           $("#" + cb).removeAttr('checked');
       }

       //加载检验模版项
       function LoadInspectionItem(data1) {
           $("#divDtl").append("");
           listItem = [], moCount = 0;
           for (var i = 0; i < data1.length; i++) {
               DetailItem(data1[i].ProductOQCId, data1[i].InspectionTemplateId, i);
           }
       }

       //模版检验项详细资料取得绑定
       function DetailItem(ProductOQCId, InspectionTemplateId) {
           var ajax = SKT.LeanMES.Web.AjaxServices.AjaxInspectionOQC.GetOqcFormItem(ProductOQCId, InspectionTemplateId);
           if (ajax.error != null) {
               alert(ajax.error.Message);
               return;
           }
           var value = $.parseJSON(ajax.value);
           //模版头添加
           var head = value.data[0];
           var html = "<table id='tblExpand' class='ListTable' style='border-width:0px;width:100%;border-collapse:collapse; margin-top:5px;'  >"
                          + "<tr class='ListTableHeader' ><th colspan='6' >" + head.InspectionTemplateName + "</th></tr>"
                          + "<tr class='ListTableHeader' ><th>抽样水平</th><th>" + head.LotName + "/AQL=" + head.RuleName + "</th>"
                          + "<th>抽样数量</th><th>" + head.SamplingValue + "</th>"
                          + "<th>Ac/Re</th><th>" + "Ac=  " + head.ACValue + "/ Re=  " + head.REValue + "</th></tr></table>";
           $("#divDtl").append(html);
           //加载检验项
           var Dtllist = value.data1;

           var InsItemNamestr = "", Jugestr = "", According = "", DelRow = "";

           html = "<table id='tbDtl" + head.InspectionTemplateId + "' class='ListTable' style='border-width:0px;width:100%;border-collapse:collapse; margin-top:5px;'  >"
                    + "<tr class='ListTableHeader' ><th>序号</th><th>检验项目</th><th>判定标准</th><th>检验方法</th><th>描述</th><th>检验结果</th>"
                    + (name === 'Material_IQCFormView' ? "" : "<th id='delId' style='color: #0066CC; cursor: pointer;' onclick='AddCheckItem(" + head.InspectionTemplateId + ")'>+添加检验项</th>") + "</tr>";
           for (var j = 0; j < Dtllist.length; j++) {
               Dtllist[j].CountRow = moCount;
               //复制
               var en = {}, eItem = JSON.stringify(Dtllist[j]);
               $.extend(en, Dtllist[j]);
               en.CheckResult = Dtllist[j].CheckResult === "" ? null : Dtllist[j].CheckResult;
               listItem.push(en);

               //检验项目
               InsItemNamestr = Dtllist[j].IsCustom === 1 ? ("<em>*</em><input type='text' IsRequired='1' style='width:90%' value='" +
                        Dtllist[j].InspectionItemName + "' onchange='ChangeInsItemName(" + moCount + ", $(this))'/>")
                    : Dtllist[j].InspectionItemName;
               //判断标准
               Jugestr = Dtllist[j].IsCustom === 1 ? ("<em>*</em><input type='text' style='width:90%' IsRequired='1' value='" +
                        Dtllist[j].InspectJuge + "' onchange='ChangeJuge(" + moCount + ", $(this))'/>") : Dtllist[j].InspectJuge;
               //检验方法
               According = Dtllist[j].IsCustom === 1 ? ("<em>*</em><input type='text' style='width:90%' IsRequired='1' value='" +
                        Dtllist[j].InspectionAccording + "' onchange='ChangeInsAccording(" + moCount + ", $(this))'/>") : Dtllist[j].InspectionAccording;

               DelRow = name === 'Material_IQCFormView' ? "" :
                    ("<td style='text-align:center; width:5%'>" +
                        (Dtllist[j].IsCustom === 1 ? "<span style=\"CURSOR: pointer; COLOR: #0000ff;\" onclick=\"deleteItem(" + moCount + ", $(this))\"><%= Resources.Buttons.COM_Delete %></span>" : "") + "</td>");

               html += "<tr class='ListTableOddRow'><td style='text-align:left; width:3%'>" + (j + 1).toString() + "</td>"
                        + "<td style='text-align:left; width:20%'>" + InsItemNamestr + "</td>"
                        + "<td style='text-align:left; width:23%'>" + Jugestr + "</td>"
                        + "<td style='text-align:left; width:10px'>" + According + "</td>"
                        + "<td style='text-align:left; width:30%'><input type='text' value= '" + Dtllist[j].Discretion + "' style='width:97%' onchange='ChangeDesc(" + moCount + ", $(this))'/></td>"
                        + "<td style='text-align:left; width:10%'><label><input id='cbOK" + moCount + "' type='checkbox' "
                            + (Dtllist[j].CheckResult === 1 ? " checked='checked'" : " ") + " onchange='ChangeResult(" + moCount + ", $(this))' />OK</label>&nbsp;&nbsp;"
                        + "<label><input id='cbNG" + moCount + "' type='checkbox' " + (Dtllist[j].CheckResult === 0 ? "checked='checked'" : "")
                            + " onchange='ChangeResult(" + moCount + ", $(this))' />NG</label></td>"
                        + DelRow
                        + "<tr>";

               moCount++;
           }
           html += "</table>";
           $("#divDtl").append(html);
       }

       //检验结果选择改变
       function ChangeResult(rowCount, t) {
           var cb = ($(t).attr('id').substr(0, 4) == "cbOK" ? "cbNG" : "cbOK") + rowCount;
           if ($(t).attr('checked') === "checked") {
               $("#" + cb).removeAttr('checked');
           } else {
               $("#" + cb).attr("checked", true);
           }

           $.grep(listItem, function (o, j) {
               if (o.CountRow === rowCount) {
                   o.CheckResult = $("#cbOK" + rowCount).attr('checked') ? 1 : ($("#cbNG" + rowCount).attr('checked') ? 0 : null);
               };
           });
       }

       //描述
       function ChangeDesc(rowCount, t) {
           $.grep(listItem, function (o, j) {
               if (o.CountRow === rowCount) {
                   o.Discretion = $(t).val();
               };
           });
       }

       //检验项名称
       function ChangeInsItemName(rowCount, t) {
           $.grep(listItem, function (o, j) {
               if (o.CountRow === rowCount) {
                   o.InspectionItemName = $(t).val();
               };
           });
       }

       //判定标准
       function ChangeJuge(rowCount, t) {
           $.grep(listItem, function (o, j) {
               if (o.CountRow === rowCount) {
                   o.InspectJuge = $(t).val();
               };
           });
       }
       //检验方法
       function ChangeInsAccording(rowCount, t) {
           $.grep(listItem, function (o, j) {
               if (o.CountRow === rowCount) {
                   o.InspectionAccording = $(t).val();
               };
           });
       }

       //添加额外检验项
       function AddCheckItem(index) {
           var newItem = {};
           //赋值行
           $.extend(newItem, listItem[0]);
           newItem.IQCModelCheckId = -1;
           newItem.InspectionTemplateId = index;
           newItem.InspectionItemName = "";
           newItem.InspectJuge = "";
           newItem.InspectionAccording = "";
           newItem.InspectionItemId = -1;
           newItem.CountRow = moCount;
           newItem.Discretion = "";
           newItem.CheckResult = null;
           listItem.push(newItem);

           var countRow = $("#tbDtl" + index).find(".ListTableOddRow").length + 1;

           var html = "<tr class='ListTableOddRow'><td style='text-align:center; width:5%'>" + countRow + "</td>"
                        + "<td style='text-align:center; width:15%'><em>*</em><input type='text' style='width:90%' IsRequired='1' onchange='ChangeInsItemName(" + moCount + ", $(this))'/></td>"
                        + "<td style='text-align:center; width:15%'><em>*</em><input type='text' style='width:90%' IsRequired='1' onchange='ChangeJuge(" + moCount + ", $(this))'/></td>"
                        + "<td style='text-align:center; width:15%'><em>*</em><input type='text' style='width:90%' IsRequired='1' onchange='ChangeInsAccording(" + moCount + ", $(this))'/></td>"
                        + "<td style='text-align:center; width:30%'><input type='text' style='width:90%' onchange='ChangeDesc(" + moCount + ", $(this))'/></td>"
                        + "<td style='text-align:center; width:15%'><label><input id='cbOK" + moCount + "' type='checkbox' "
                            + " onchange='ChangeResult(" + moCount + ", $(this))' />OK</label>&nbsp;&nbsp;"
                        + "<label><input id='cbNG" + moCount + "' type='checkbox' "
                            + " onchange='ChangeResult(" + moCount + ", $(this))' />NG</label></td>"
                        + "<td style='text-align:center; width:5%'><span style=\"CURSOR: pointer; COLOR: #0000ff;\" onclick=\"deleteItem(" + moCount + ", $(this))\"><%= Resources.Buttons.COM_Delete %></span></td><tr>";
           $("#tbDtl" + index).append(html);
           moCount++;
       }

       //删除检验项行
       function deleteItem(rowCount, t) {
           var index = -1;
           $.grep(listItem, function (o, j) {
               if (o.CountRow === rowCount) {
                   index = j;
               }
           });
           $(t).parent().parent().remove();
           listItem.splice(index, 1);
       }


       //模版检验项详细资料取得绑定
       function DetailLcrItem(ProductOQCId) {
           Lcrlist = [];
           var ajax = SKT.LeanMES.Web.AjaxServices.AjaxInspectionOQC.GetOqcFormLcrItem(ProductOQCId);
           if (ajax.error != null) {
               alert(ajax.error.Message);
               return;
           }
           var value = $.parseJSON(ajax.value);
           //模版头添加
           var head = value.data[0];
           var html = "<table id='tblExpand' class='ListTable' style='border-width:0px;width:100%;border-collapse:collapse; margin-top:5px;'  >"
                          + "<tr class='ListTableHeader' ><th colspan='6' >" + head.InspectionTemplateName + "</th></tr>"
                          + "<tr class='ListTableHeader' ><th>抽样水平</th><th>" + head.LotName + "/AQL=" + head.RuleName + "</th>"
                          + "<th>抽样数量</th><th>" + head.SamplingValue + "</th>"
                          + "<th>Ac/Re</th><th>" + "Ac=  " + head.ACValue + "/ Re=  " + head.REValue + "</th></tr></table>";
           $("#divDtl").append(html);
           //加载LCR检验项
           Lcrlist = value.data1;
           var itemCount = 0;

           html = "<table id='tbDtl" + head.InspectionTemplateId + "' class='ListTable' style='border-width:0px;width:100%;border-collapse:collapse; margin-top:5px;'  >";
           for (var j = 0; j < Lcrlist.length; j++) {
               html += "<tr class='ListTableOddRow'><td style='text-align:center; width:10%'>" + Lcrlist[j].IQCLcrItemName + "</td>";
               for (var a = 1; a <= 8; a++) {
                   //ID赋值
                   var Iid = j.toString() + a.toString();

                   if (Lcrlist[j].IQCLcrItemType === 2) {
                       itemCount++;
                       html += "<td style='text-align:center; width:9%'>(" + itemCount + ")</td>";
                   }
                   else if (Lcrlist[j].IQCLcrItemType === 1) {
                       html += "<td style='text-align:center; width:9%'><label><input id='cbLcrOK"
                            + j.toString() + a.toString() + "' type='checkbox' " + (Lcrlist[j]["Value" + a] === '1' ? " checked='checked'" : " ")
                            + " onchange='ChangeLCRResult(" + j + "," + a + ", $(this))' />OK<label>&nbsp;&nbsp;"
                            + "<label><input id='cbLcrNG" + j.toString() + a.toString() + "' type='checkbox' "
                            + (Lcrlist[j]["Value" + a] === '0' ? " checked='checked'" : " ")
                            + " onchange='ChangeLCRResult(" + j + "," + a + ", $(this))' />NG<label></td>";
                   }
                   else if (Lcrlist[j].IQCLcrItemType === 0) {
                       html += "<td style='text-align:center; width:9%'><input type='text' style='width:90%' value='" + Lcrlist[j]["Value" + a] + "' onchange='ChangeLcrValue(" + j + "," + a + ", $(this))'/></td>";
                   }
               }
               html += "<tr>";
           }
           html += "</table>";
           $("#divDtl").append(html);
       }

       //LCR检验项值保存
       function ChangeLcrValue(j, a, t) {
           Lcrlist[j]["Value" + a] = $(t).val();
       }

       //LCR检验结果选择改变
       function ChangeLCRResult(j, a, t) {
           var ida = j.toString() + a.toString();
           var cb = ($(t).attr('id').substr(0, 7) == "cbLcrOK" ? "cbLcrNG" : "cbLcrOK") + ida;
           $("#" + cb).removeAttr('checked');
           Lcrlist[j]["Value" + a] = $("#cbLcrOK" + ida).attr('checked') ? 1 : ($("#cbLcrNG" + ida).attr('checked') ? 0 : null);
       }

       //保存检验信息
       function SaveForm() {
           var entity = {};
           if ($("#cbFormOK").attr('checked') == null && $("#cbFormNG").attr('checked') == null) {
               alert("请选择检验结果");
               return false;
           }

           entity.ProductOQCId = ProductOQCId;
           entity.InspectionResult = $("#cbFormOK").attr('checked') ? 1 : ($("#cbFormNG").attr('checked') ? 0 : null);
           entity.InspectionUser = $.trim($("#txtCheck").val());
           entity.Auditing = $.trim($("#txtSign").val());
           entity.PrintLv = $.trim($("#txtPrintLv").val());
           entity.Remark = $.trim($("#txtRemark").val());
           entity.ModifyBy = userName;
           entity.CheckList = JSON.stringify(listItem);
           entity.LrcList = JSON.stringify(Lcrlist);

           //alert(JSON.stringify(JSON.stringify(listItem)));
           var ajax = SKT.LeanMES.Web.AjaxServices.AjaxInspectionOQC.SaveOqcCheck(JSON.stringify(entity));
           if (ajax.error != null) {
               alert(ajax.error.Message);
               return;
           }
           alert("保存成功！");
           parent.Refresh();
       }

       //GRN不合格信息
       function GrnNg() {
           dialog({ title: "IQC记录GRN信息", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Quality/IQCFormBack.aspx?name=Material_IQCFormBack&ID=" + ProductOQCId + "&rnd=" + Math.random(), width: 750, height: 368 });
       }
              
       function Refresh() {
           document.forms[0].submit();
       }

   </script>
</asp:Content>

