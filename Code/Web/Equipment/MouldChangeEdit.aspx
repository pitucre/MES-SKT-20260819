<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    CodeBehind="MouldChangeEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Equipment.MouldChangeEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
     <div class="infoTips">
        带<em>*</em>为必填项
    </div>

        <table class="EditeContentTable" width="100%">
            <tr>
                <td class="Label3">
                  换模申请单号<em>*</em>
                </td>
                <td class="Field3" colspan="3">
                 <asp:Label runat="server" ID="lblChangeNo"></asp:Label>
                </td>
               
              
            </tr>
            
            <tr>
                 <td class="Label3">
                    新产品名称<em>*</em>
                </td>
                <td class="Field3">
                   <asp:Label runat="server" ID="lblItemName"></asp:Label>
                </td>
                  <td class="Label3">
                      <%=Resources.lang.MouldName%><em></em>
                </td>
                <td class="Field3">
                   <asp:Label runat="server" ID="lblBomName"></asp:Label>
                </td>
              
            </tr>
             <tr>
                <td class="Label3">
                    设备编码
                </td>
                <td class="Field3">
                     <asp:Label runat="server" ID="lblEquimentCode"></asp:Label>
                </td>
                 <td class="Label3">
                    设备名称
                </td>
                <td class="Field3">
                     <asp:Label runat="server" ID="lblEquimentName"></asp:Label>
                </td>
            </tr>
                <tr>
                     <td class="Label3">
                  换模预计完成时间<em>*</em>
                </td>
                <td class="Field3">
                     <asp:TextBox ID="txtChangeoverPlanTime" runat="server" CssClass="DateTime" IsRequired='1' ReadOnly="true"></asp:TextBox>
                   
                </td>
                <td class="Label3">
                  换模实际开始时间<em>*</em>
                </td>
                <td class="Field3">
                  <asp:TextBox ID="txtActualStartTime" runat="server"  ClientIDMode="Static" CssClass="DateTime" IsRequired='1' ReadOnly="true"></asp:TextBox>
                </td>
             
              
            </tr>
           
            <tr>
                <td class="Label3">
                初始压制数<em>*</em>
                </td>
                <td class="Field3">
                <asp:TextBox ID="txtInitialPress" runat="server" ClientIDMode="Static"  IsRequired='1'></asp:TextBox>    
                </td>
                <td class="Label3">
                当前压制数<em>*</em>
                </td>
                <td class="Field3">
                <asp:TextBox ID="txtCurrentPress" runat="server"  ClientIDMode="Static"  IsRequired='1'></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="Label3" style=" display:none">
                    换模实际完成时间<em>*</em>
                </td>
                <td class="Field3" style=" display:none">
                    <asp:TextBox ID="txtActualFinish" runat="server" CssClass="DateTime"></asp:TextBox>
                    
                </td>
                <td class="Label3">
                  换模人<em>*</em>
                </td>
                <td class="Field3"  colspan="1">
                    <asp:TextBox ID="txtOperator" runat="server" CssClass="TextBox" IsRequired='1' ReadOnly ="true"></asp:TextBox>
                        <input type="button" value="..." class="ButtonBox" onclick="selectUser()" disabled="disabled"/>
                    <asp:HiddenField ID="hdOperator" runat="server" />
                 
                  
                     
                </td>
                <td class="Label3">
                  整机卸模
                </td>
                <td class="Field3"  colspan="1">
                    <asp:CheckBox ID="chkMouldUnload" runat="server" ClientIDMode="Static" Style="zoom: 140%" />
                </td>
              
            </tr>
            <tr>
                <td class="Label3">
                   换模备注
                </td>
                <td class="Field3" colspan="3">
                   <asp:TextBox ID="txtRemark" CssClass="TextArea" TextMode="MultiLine" runat="server"
                    ClientIDMode="Static" Width="99%" Height="75"></asp:TextBox>
                </td>
            </tr>
        </table>
        <table id="tblExpand" cellspacing="0" cellpadding="4" style="border-width: 0px; width: 100%; border-collapse: collapse; margin-top: 5px;"
            class="EditeContentTable">
            <tr class="ListTableHeader" style="text-align: center">
                 <th scope="col" style="width: 10%;">序号
                </th>
                <th scope="col" style="width: 13%;">构件名称
                </th>
                <th scope="col" style="width: 15%;" >可替代构件
                </th>
                <th scope="col" style="width: 20%;" >构件描述
                </th>
                <th scope="col" style="width: 13%;" >在机模具编码
                </th>
                 <th scope="col" style="width: 13%;" >在机<%=Resources.lang.MouldName%>
                </th>
                <th scope="col" style="width: 18%;" >更换模具编码
                </th>
                <th scope="col" style="width: 15%;" >更换<%=Resources.lang.MouldName%>
                </th>
            </tr>
             <tbody id="tblExpandBody"></tbody>
            <tr id="trNewInfo" class="ListTableOddRow">
                <td colspan="8" style="text-align: center;">
                    <%=Resources.Messages.HaveNothingData%>
                </td>
            </tr>
        </table>


      <input type="hidden" id="hdnEquimentId" value="-1" runat="server" clientidmode="Static"/>
      <input type="hidden" id="hdStatus" value="-1" runat="server" />
    <input type="hidden" id="hdnItemId" value="-1" runat="server" />
      <input type="hidden" id="hdnMouldBomId" value="-1" runat="server" />
    <script type="text/javascript" src="../Content/js/jquery-3.1.0.min.js"></script>
    <script type="text/javascript" charset="utf-8" src="../Content/plugin/jquery-easyui-1.4.2/layer/layer.js"></script>
    <style type="text/css">
        .selectRow td {
            background-color: #C4C4C4;
        }

        .pointer {
            cursor: pointer;
        }

    </style>
    
     <script type="text/javascript">
         var chooseFlag = -1;
         /*产品名称*/
         function selectItem() {
              chooseFlag = 1;
             dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=1&Multiple=false&rnd=" + Math.random(), width: 500, height: 300 });
         }

         /*换模人*/
         function selectUser() {
             chooseFlag = 2;
             dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=12&Multiple=false&rnd=" + Math.random(), width: 500, height: 300 });
         }

          /*选择设备*/
         function selectDequiment() {
             var searchCondition = "  ParentTypeId =1";
             chooseFlag = 3;
             dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=54&SearchCondition=" + searchCondition + "&Multiple=false&rnd=" + Math.random(), width: 600, height: 400 });
            
         }
          <%--function getChooseValue(list) {
           if (chooseFlag == 2) {
                $("#<%=this.txtOperator.ClientID %>").val(list[0][2]);
            }
        }--%>
     </script>
    <script language="javascript" type="text/javascript">
        var Id = <%= Request.QueryString["ID"] == null ? -1 : Convert.ToInt32(Request.QueryString["ID"].ToString())%>;
        var tab = document.getElementById("tblExpandBody");
        var selectRowClass = "selectRow";
        var index = 0;
        var inspecType = -1;
        var gobeyondnum=0;
      
        $(function () {
            $("#chkMouldUnload").click(function(){
                if(this.checked){
                    $("#tblExpandBody").find("input[class=hdReplaceMouldId],[name=txtReplaceMouldName],[id=btnSelectResource]").attr("disabled","disabled");
                    $("#tblExpandBody").find("input[class=hdReplaceMouldId],[name=txtReplaceMouldName]").val("");
                    $("#tblExpandBody").find("td:eq(7)[class='Field ReplaceMouldName']").html("<lable></lable>");
                }
                else{
                    $("#tblExpandBody").find("input").removeAttr("disabled");
                }
            });
            if (Id > 0) {
             
                var result= GetItemMouldRelations($("#<%=this.hdnItemId.ClientID%>").val());
                if (result.value.length >0) {
                     
                      $("#<%=this.lblBomName.ClientID%>").text(result.value[0].BomName);
                      $("#<%=this.hdnMouldBomId.ClientID%>").val(result.value[0].MouldId);
                      //根据BomId 得到构件名称列表
                      GetMouldBomChild($("#<%=this.hdnEquimentId.ClientID%>").val());
                  } 

               
                if ($("#<%=this.hdStatus.ClientID%>").val()==3) {
                    $(" input").attr("disabled", true);
                    $(" .ui-datepicker-trigger").attr("disabled", true);
                    $("#<%=this.txtRemark.ClientID%>").attr("disabled", true);
                }
            }
            $(".DateTime").datepicker({
                buttonImageOnly: true,
                showHms: true
                
            });
            $("#txtActualStartTime").val(GetDateStr1(0));

            //当前压制数不需要默认填写
            $("#txtCurrentPress").val('');
        });

        //获取当前时间
        function GetDateStr1(AddDayCount) {
            var dd = new Date();
            dd.setDate(dd.getDate() + AddDayCount); //获取AddDayCount天后的日期
            var y = dd.getFullYear();
            var m = dd.getMonth() + 1; //获取当前月份的日期 
            var d = dd.getDate();
            var hh = dd.getHours();
            var ff = dd.getMinutes();
            var mm = dd.getSeconds();

            m = m < 10 ? "0" + m : m;
            d = d < 10 ? "0" + d : d;

            hh = hh < 10 ? "0" + hh : hh;
            ff = ff < 10 ? "0" + ff : ff;
            mm = mm < 10 ? "0" + mm : mm;

            return y + "-" + m + "-" + d + " " + hh + ":" + ff + ":" + mm;
        }

        function GetItemMouldRelations(itemId) {
            var result = SKT.LeanMES.Web.Equipment.MouldChangeApplyEdit.GetItemMouldRelations(itemId);
            if (result.error != null) {
                alert(result.error.Message);
                return false;
            }
            return result;
        }


        function GetMouldBomChild(bomId) {
            var result = SKT.LeanMES.Web.Equipment.MouldChangeEdit.GetEquimentMouldBomChildList(bomId);
            if (result.error != null) {
                alert(result.error.Message);
                return false;
            }
              
            if (null != result) {
                var index =1;
                $("#tblExpandBody ").html("");
                
                
                for (var i = 0; i < result.value.length; i++) {
                    addDetail(result.value[i], index,result.value.length);
                    index++;
                }

                if(gobeyondnum>0) //当在当前设备的在机模具数量大于申请单提交的换模数量时
                {
                    for (var j = 0; j < gobeyondnum; j++) {
                        addDetail2(result.value[j],index)//写入超出部分申请换模数据
                        index++
                    }
                }
            }
            return result;
        }

        
        //function GetEquimentMouldType(equimentId) {
        //    var result = SKT.LeanMES.Web.Equipment.MouldChangeApplyEdit.GetEquimentMouldTypeList(equimentId);
            
        //    if (result.error != null) {
        //        alert(result.error.Message);
        //        return false;
        //    }
            
        //    if (null != result) {
        //        var index = 1;
        //        $("#tblExpandBody ").html("");
               
        //        for (var i = 0; i < result.value.length; i++) {
        //            addDetail(result.value[i], index, equimentId);
        //            index++;
        //        }
        //    }
        //}
       


        function GetDetailAll(equimentTypeId,cid) {
            var result = SKT.LeanMES.Web.Equipment.MouldChangeApplyEdit.GetDetailAll(equimentTypeId,cid);

            if (result.error != null) {
                alert(result.error.Message);
                return false;
            }
            return result;
        }


        function GetEquimentMouldAll(equimentId,equimentType) {
            var result = SKT.LeanMES.Web.Equipment.MouldChangeEdit.GetEquimentMouldAll(equimentId,equimentType);
            if (result.error != null) {
                alert(result.error.Message);
                return false;
            }
            return result;

        }
        function GetIndex() {
            var list = $(tab).find("tr");
            for (var i = 0; i < list.length; i++) {
                if ($(list[i]).attr("class").indexOf(selectRowClass) > -1) {
                    return i;
                }
            }
            return tab.rows.length;
        }

        function addDetail(entity, i,len) {
            var row, cell;
            if (null == entity) {
                entity.MouldType = -1;
                entity.MouldTypeName = "";
                entity.ComponentCode = "";
                entity.IsAdd = 0;
                entity.Describe = "";
            }
            rowNewIdx = GetIndex();
            row = tab.insertRow(rowNewIdx);
            row.className = "ListTableOddRow";

            $("#trNewInfo").remove();

            cell = row.insertCell(0);
            cell.align = "center";
            cell.className = "Field pointer";
            cell.innerHTML = i;

            cell = row.insertCell(1);
            cell.align = "center";
            cell.className = "Field pointer";
            cell.innerHTML = " <input type=\"hidden\" class=\"hdMouldTypeId\" value=\"" + entity.MouldType + "\" />" + entity.MouldTypeName;


            cell = row.insertCell(2);
            cell.align = "center";
            cell.className = "Field pointer";
            cell.innerHTML = entity.ReplaceComponentName;

            cell = row.insertCell(3);
            cell.align = "center";
            cell.className = "Field";
            cell.width = "80px";
            cell.innerHTML = entity.Describe;

            //如果状态为非新申请
            if ($("#<%=this.hdStatus.ClientID%>").val() >1) {
                var result = GetDetailAll(entity.MouldType, Id);
                if (result != null) {
                    cell = row.insertCell(4);
                    cell.align = "center";
                    cell.className = "Field pointer";
                    //如果当前模具名称为空
                    if (result.value[0].CurrentMouldName == null || result.value[0].CurrentMouldName == "") {
                        cell.innerHTML = " <input type=\"hidden\" class=\"hdCurrentMouldId\" value=\"" + result.value[0].CurrentMouldId + "\" />无";
                        cell = row.insertCell(5);
                        cell.align = "center";
                        cell.className = "Field pointer";
                        cell.innerHTML = "无";
                    } else {
                        cell.innerHTML = " <input type=\"hidden\" class=\"hdCurrentMouldId\" value=\"" + result.value[0].CurrentMouldId + "\" />" + result.value[0].CurrentMouldCode;
                        cell = row.insertCell(5);
                        cell.align = "center";
                        cell.className = "Field pointer";
                        cell.innerHTML = result.value[0].CurrentMouldName;
                       }

                    cell = row.insertCell(6);
                    cell.align = "center";
                    cell.className = "Field";
                    cell.width = "80px";

                    if (result.value[0].ReplaceMouldCode == null || result.value[0].ReplaceMouldCode == "") {
                        cell.innerHTML = "无";
                        cell = row.insertCell(7);
                        cell.align = "center";
                        cell.className = "Field";
                        cell.width = "80px";
                        cell.innerHTML = "无";
                    } else {
                        //如果状态为已确认
                        if ($("#<%=this.hdStatus.ClientID%>").val() == 3 || entity.IsAdd==0) {
                            cell.innerHTML = result.value[0].ReplaceMouldCode;
                           
                        } else {
                            cell.innerHTML = "<input type=\"hidden\" class=\"hdReplaceMouldId\" value="+result.value[0].ReplaceMouldId+"  /><input type=\"text\" name=\"txtReplaceMouldName\" value="+result.value[0].ReplaceMouldCode+" class=\"TextBox\" style=\" width:80%;\" />"
                               + "<input type=\"button\" id=\"btnSelectResource\" onclick=\"selectReplaceMould(this,\'"+entity.ReplaceComponentName+"'\,\'"+entity.MouldTypeName+"'\);\" class=\"ButtonBox\" value=\"...\" />";
                       
                        
                        }
                        cell = row.insertCell(7);
                        cell.align = "center";
                        cell.className = "Field ReplaceMouldName";
                        cell.width = "80px";
                        cell.innerHTML =result.value[0].ReplaceMouldName;
                    }
                }
                

            }else {

                var result1 = GetEquimentMouldAll($("#<%=this.hdnEquimentId.ClientID%>").val(), entity.MouldType);//在机设备列表集合
                if (null != result1 && result1.value.length > 0) {
                    if(result1.value.length>len)
                    {
                        gobeyondnum= parseInt(result1.value.length)-parseInt(len);
                    }

                    //当在机设备列表集合比申请的更换集合小或等于，按检索取出在机设备列表，需求已定不用对应构件名称类型来取出
                    if(i<=result1.value.length){
                        cell = row.insertCell(4);
                        cell.align = "center";
                        cell.className = "Field pointer";
                        cell.innerHTML = " <input type=\"hidden\" class=\"hdCurrentMouldId\" value=\"" + result1.value[i-1].MouldId + "\" />" + result1.value[i-1].MouldCode+"";
                  
                    
                        cell = row.insertCell(5);
                        cell.align = "center";
                        cell.className = "Field pointer";
                        cell.innerHTML =result1.value[i-1].MouldName;



                        cell = row.insertCell(6);
                        cell.align = "center";
                        cell.className = "Field";
                        cell.width = "80px";
                        if (entity.IsAdd == 0) {
                            cell.innerHTML = "<input type=\"hidden\" class=\"hdReplaceMouldId\" value=\"-2\" />";    

                        } else {
                            cell.innerHTML = "<input type=\"hidden\" class=\"hdReplaceMouldId\"  /><input type=\"text\" name=\"txtReplaceMouldName\" class=\"TextBox\" style=\" width:80%;\"   />"
                            + "<input type=\"button\" id=\"btnSelectResource\"onclick=\"selectReplaceMould(this,\'"+entity.ReplaceComponentName+"'\,\'"+entity.MouldTypeName+"'\,\'"+result1.value[i-1].EquipmentTypeName+"'\);\" class=\"ButtonBox\" value=\"...\"  />";    
                        }

                    }else{
                        cell = row.insertCell(4);
                        cell.align = "center";
                        cell.className = "Field pointer";
                        cell.innerHTML = "<input type=\"hidden\" class=\"hdCurrentMouldId\" value=\"0\" />无";

                        cell = row.insertCell(5);
                        cell.align = "center";
                        cell.className = "Field pointer";
                        cell.innerHTML ="无";

                        cell = row.insertCell(6);
                        cell.align = "center";
                        cell.className = "Field ReplaceMouldName";
                        cell.width = "80px";
                        if (entity.IsAdd == 0) {
                            cell.innerHTML = "<input type=\"hidden\" class=\"hdReplaceMouldId\" value=\"-2\" />";    

                        } else {
                            cell.innerHTML = "<input type=\"hidden\" class=\"hdReplaceMouldId\"  /><input type=\"text\" name=\"txtReplaceMouldName\" class=\"TextBox\" style=\" width:80%;\"   />"
                            + "<input type=\"button\" id=\"btnSelectResource\"onclick=\"selectReplaceMould(this,\'"+entity.ReplaceComponentName+"'\,\'"+entity.MouldTypeName+"'\,'');\" class=\"ButtonBox\" value=\"...\"  />";    
                        }
                    } 
                    
                    cell = row.insertCell(7);
                    cell.align = "center";
                    cell.className = "Field ReplaceMouldName";
                    cell.width = "80px";
                    cell.innerHTML = "<lable></lable>";

                } else {
                  
                    cell = row.insertCell(4);
                    cell.align = "center";
                    cell.className = "Field pointer";
                    cell.innerHTML = " <input type=\"hidden\" class=\"hdCurrentMouldId\" value=\"0\"/>无";


                    cell = row.insertCell(5);
                    cell.align = "center";
                    cell.className = "Field pointer";
                    cell.innerHTML = "无";


                    cell = row.insertCell(6);
                    cell.align = "center";
                    cell.className = "Field ReplaceMouldName";
                    cell.width = "80px";

                    if (entity.IsAdd == 0) {
                        cell.innerHTML = "<input type=\"hidden\" class=\"hdReplaceMouldId\" value=\"-2\"  />";    
                        cell = row.insertCell(7);
                        cell.align = "center";
                        cell.className = "Field";
                        cell.width = "80px";
                        cell.innerHTML = "<lable></lable>";    
                    } else {
                        cell.innerHTML = "<input type=\"hidden\" class=\"hdReplaceMouldId\"  /><input type=\"text\" name=\"txtReplaceMouldName\" class=\"TextBox\" style=\" width:80%;\"   />"
                        + "<input type=\"button\" id=\"btnSelectResource\" onclick=\"selectReplaceMould(this,\'"+entity.ReplaceComponentName+"'\,\'"+entity.MouldTypeName+"'\,'');\"  class=\"ButtonBox\" value=\"...\"  />";    
                        cell = row.insertCell(7);
                        cell.align = "center";
                        cell.className = "Field ReplaceMouldName";
                        cell.width = "80px";
                        cell.innerHTML = "<lable></lable>";    
                    }
                }
                
            } 
            
           

        }
        var rowObj = null;
        var rowIndex = 0;

        <%--      function selectMould(obj,equimentType) {

            rowObj = obj.parentElement.parentElement;
            rowIndex = rowObj.rowIndex;
            if (rowObj.cells[1].children[0].value <= 0) {
                alert("请选择线别！");
                return false;
            }


            var serachCondtion = " ParentTypeId=-4 and EquipmentTypeId="+rowObj.cells[1].children[0].value;

            dialog({ title: "<%=Resources.Common.ChooseWindow %>"
                , src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=54&PageCondition=" + serachCondtion + "&CallBackFunc=getChooseValueEquiment&Multiple=false&rnd="
                    + Math.random(), width: 600, height: 300
             });
          };--%>

        function addDetail2(entity,i) {
            var row, cell;
            rowNewIdx = GetIndex();
            row = tab.insertRow(rowNewIdx);
            row.className = "ListTableOddRow";

            $("#trNewInfo").remove();

            cell = row.insertCell(0);
            cell.align = "center";
            cell.className = "Field pointer";
            cell.innerHTML = i;

            cell = row.insertCell(1);
            cell.align = "center";
            cell.className = "Field pointer";
            cell.innerHTML = "";


            cell = row.insertCell(2);
            cell.align = "center";
            cell.className = "Field pointer";
            cell.innerHTML = "";

            cell = row.insertCell(3);
            cell.align = "center";
            cell.className = "Field";
            cell.width = "80px";
            cell.innerHTML ="";

            var result2 = GetEquimentMouldAll($("#<%=this.hdnEquimentId.ClientID%>").val(), 0);//在机设备列表集合
            if (null != result2 && result2.value.length > 0) {
                cell = row.insertCell(4);
                cell.align = "center";
                cell.className = "Field pointer";
                cell.innerHTML = " <input type=\"hidden\" class=\"hdCurrentMouldId\" value=\"" + result2.value[i-1].MouldId + "\" />" + result2.value[i-1].MouldCode+"";

                cell = row.insertCell(5);
                cell.align = "center";
                cell.className = "Field pointer";
                cell.innerHTML =result2.value[i-1].MouldName;
            }

            cell = row.insertCell(6);
            cell.align = "center";
            cell.className = "Field";
            cell.width = "80px";
            cell.innerHTML = "<input type=\"hidden\" class=\"hdfalse\" value=\"hdfalse\" />";    
            

            cell = row.insertCell(7);
            cell.align = "center";
            cell.className = "Field ReplaceMouldName";
            cell.width = "80px";
            cell.innerHTML = "";
        }

        var chooseFlag = -1;
        function  selectReplaceMould(obj, replaceComponentName,mouldTypeName,zjmouldTypeName) {
            chooseFlag = 1;
            rowObj = obj.parentElement.parentElement;
            rowIndex = rowObj.rowIndex;

            var equipmentId  = $("#hdnEquimentId").val();
            var dd = replaceComponentName.split('|');
            if (dd.length == 0) {
                alert("没有可替代模具");
                return;
            }
            //出库在产线的模具
            var searchCondition = " InOrOut=0 and StoreName='产线' and EquipmentStatus !='5' and  ComponentName in  ('"+mouldTypeName+"'";
            if (replaceComponentName != "") {
                for (var i = 0; i < dd.length; i++) {
                    searchCondition += ",'"+dd[i]+"'";
                } 
            }
            if(zjmouldTypeName!= ""){
                searchCondition += ",'"+zjmouldTypeName+"'";
            }
            searchCondition+=") AND NOT EXISTS(SELECT 1 FROM Basal_EquimentMould AS t WHERE EquipmentId=t.MouldId AND t.EquimentId != "+equipmentId+" )";
            //var searchCondition = " ComponentName  ='" + mouldTypeName + "' ";
            dialog({ title: "<%=Resources.Common.ChooseWindow %>"
                , src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot%>/Framework/ChoosePage.aspx?PageId=701&PageCondition=" + searchCondition + "&CallBackFunc=getChooseValueEquiment&Multiple=false&rnd="
                    + Math.random(), width: 600, height: 300
            });
       }

       function getChooseValueEquiment(list) {
            rowObj.cells[6].children[0].value = list[0][0];
            rowObj.cells[6].children[1].value = list[0][1];
            rowObj.cells[7].children[0].innerHTML = list[0][2];
            return true;
        }


      
       








        /*保存数据*/
        function Save() {
         

            if($('#txtInitialPress').val()!=0)
            {
                if(parseInt($('#txtInitialPress').val())> parseInt($('#txtCurrentPress').val()))
                {
                    alert("当前压制数据不能小于初始压制数");
                    return false;
                }
            }

            var docXml = "<Root>";
            var hdEquipmentTypeId = -1;
            var hdReplaceMouldId = -1;
            var hdCurrentMouldId = -1;
            var hdfalse='';
            var counts=$("#tblExpand tr:gt(0)").length;
         
            var j = 0;
            for (var i = 0; i < counts; i++) {
                var data = $("#tblExpand tr:gt(0)")[i];
                hdEquipmentTypeId = $(data).find("td:eq(1) .hdMouldTypeId").val();
                hdCurrentMouldId = $(data).find("td:eq(4) .hdCurrentMouldId").val();
                hdReplaceMouldId = $(data).find("td:eq(6) .hdReplaceMouldId").val(); 
                hdfalse= $(data).find("td:eq(6) .hdfalse").val();   //当在机模具列表大于申请单提交的模具个数时，最后一个设定不替换的默认为卸模，不加关联  add by beichang.zhong  2019.08.02
                if(hdfalse=="hdfalse"){
                    continue;
                }
                if (hdCurrentMouldId <= 0 && hdReplaceMouldId <= 0) {
                    alert("在机模具与更换模具不能同时为空");
                    return false;
                }
                if (hdReplaceMouldId != "") {
                    j = 1;
                }
               
                docXml += "<Detail MouldType='" + hdEquipmentTypeId + "'  CurrentMouldId='" + hdCurrentMouldId + "' ReplaceMouldId='" + hdReplaceMouldId + "'></Detail>";
            }
            docXml += "</Root>";

            var isMouldUnload = $("#chkMouldUnload").prop("checked");
            
            if (!isMouldUnload && j == 0) {
                alert("没有申请更换的模具");
                return false;
            }
                       
            var entity = {};

            entity.Cid = Id;
            entity.ApplyNo = $("#<%=this.lblChangeNo.ClientID %>").text();
            entity.ItemId =-1;
            entity.DeptId = -1;
            entity.EquimentId = -1 ;
            entity.ApplyRemark ="";
  
            entity.NeedTime =  new Date('1971-01-01'.replace(/-/g, "\/"));
            entity.ChangeoverPlanTime = new Date($("#<%=this.txtChangeoverPlanTime.ClientID %>").val().replace(/-/g, "\/"));
            entity.ActualStartTime = new Date($("#<%=this.txtActualStartTime.ClientID %>").val().replace(/-/g, "\/"));
            //entity.ActualFinish = new Date($("#<%=this.txtActualFinish.ClientID %>").val().replace(/-/g, "\/"));
            entity.ActualFinish = new Date('9999-12-01'.replace(/-/g, "\/"));
            entity.ChangeOverRemark = $("#<%=this.txtRemark.ClientID %>").val();
            entity.Operator = $("#<%=this.hdOperator.ClientID%>").val();
            entity.DocXml = docXml;
            entity.InitialPress=$("#<%=this.txtInitialPress.ClientID%>").val();
            entity.CurrentPress=$("#<%=this.txtCurrentPress.ClientID%>").val();

         
            var ajax = SKT.LeanMES.Web.Equipment.MouldChangeEdit.EditChange(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert('<%=Resources.Messages.SaveInSuccess %>');
            parent.window.UpdateList($("#<%=this.lblChangeNo.ClientID %>").text());
            return ajax;
        }


    
    </script>
</asp:Content>
