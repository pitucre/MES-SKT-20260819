<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    CodeBehind="MouldChangeApplyEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Equipment.MouldChangeApplyEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
     <div class="infoTips">
        <em>*</em><span>为必填项</span>
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
                    <asp:TextBox ID="txtItemName" runat="server" CssClass="TextBox" IsRequired='1'></asp:TextBox>
                      <input type="button" value="..." class="ButtonBox" onclick="selectItem()" />
                      <asp:HiddenField ID="hdnItemId" runat="server" ClientIDMode="Static" value="-1"/>
                </td>
                
                 <td class="Label3">
                     <%=Resources.lang.MouldName%><em>*</em>
                </td>
                <td class="Field3">
                  <asp:Label runat="server" ID="lblBomName"></asp:Label>
                </td>
            </tr>
             <tr>
                <td class="Label3">
                  设备编码<em>*</em>
                </td>
                <td class="Field3">
                     <asp:TextBox ID="txtEquimentCode" runat="server" CssClass="TextBox" IsRequired='1'></asp:TextBox>
                     <input type="button" value="..." class="ButtonBox" onclick="selectDequiment()" />
                      <asp:HiddenField ID="hdnEquimentId" runat="server" ClientIDMode="Static" />
                </td>
                <td class="Label3">
                    <span>设备名称</span><em></em>
                </td>
                <td class="Field3">
                     <asp:Label runat="server" ID="lblEquimentName"></asp:Label>
                </td>
              
            </tr>
                <tr>
                <td class="Label3">
                  需求使用时间<em>*</em>
                </td>
                <td class="Field3">
                  <asp:TextBox ID="txtDemandTime" runat="server" CssClass="DateTime" IsRequired='1'></asp:TextBox>
                </td>
                <td class="Label3">
                    申请部门<em>*</em>
                </td>
                <td class="Field3">
                    <asp:TextBox ID="txtDept" runat="server" CssClass="TextBox" IsRequired='1'></asp:TextBox>
                      <input type="button" value="..." class="ButtonBox" onclick="selectDep()" />
                      <asp:HiddenField ID="hdnDeptId" runat="server" ClientIDMode="Static" />
                </td>
              
            </tr>
            <tr>
                <td class="Label3">
                    申请换模备注
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
                <th scope="col" style="width: 25%;">构件名称
                </th>
                <th scope="col" style="width: 30%;" >可替代构件
                </th>
                <th scope="col" style="width: 35%;" >构件描述
                </th>
            </tr>
             <tbody id="tblExpandBody"></tbody>
            <tr id="trNewInfo" class="ListTableOddRow">
                <td colspan="4" style="text-align: center;">
                    <%=Resources.Messages.HaveNothingData%>
                </td>
            </tr>
        </table>
  
    <input type="hidden" id="controlId" />
    <input type="hidden" id="hdInspectionTypeId" runat="server" />
    <input type="hidden" id="hdStatus" value="-1" runat="server" />
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
             var condition = " ItemId in(SELECT ItemId FROM Basal_ItemMouldRelation)";
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=1&SearchCondition=" + condition + "&Multiple=false&rnd=" + Math.random(), width: 600, height: 300 });
         }

         /*申请部门*/
         function selectDep() {
             chooseFlag = 2;
             dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=13&Multiple=false&rnd=" + Math.random(), width: 500, height: 300 });
         }

          /*选择设备*/
         function selectDequiment() {
             var itemId = $("#<%=this.hdnItemId.ClientID%>").val();
             if (itemId == -1) {
                 alert("请选择新产品名称");
                 return;
             }
          
             //查询父类型=1 以及BomId 关联的设备
             var searchCondition = "  ParentTypeId =1 and EquipmentId in(SELECT EquimentId FROM [Basal_EquipmentMouldRelation] WHERE MouldId="+ $("#<%=this.hdnMouldBomId.ClientID%>").val()+" ) ";
             chooseFlag = 3;
             dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=54&SearchCondition=" + searchCondition + "&Multiple=false&rnd=" + Math.random(), width: 600, height: 400 });
            
         }

          function getChooseValue(list) {
              if (chooseFlag == 1) {
                  //根据产品ID 获取模具名称与模具bomID
                  var result= GetItemMouldRelations(list[0][0]);
                  //判断是否为空，如果为空则提示需要做数据维护
                  if (result.value.length >0) {
                      $("#<%=this.txtItemName.ClientID %>").val(list[0][1]);
                      $("#<%=this.hdnItemId.ClientID %>").val(list[0][0]);
                      $("#<%=this.lblBomName.ClientID%>").text(result.value[0].BomName);

                      $("#<%=this.hdnMouldBomId.ClientID%>").val(result.value[0].MouldId);
                      //根据BomId 得到构件名称列表
                      GetMouldBomChild(result.value[0].MouldId);
                  } else {
                      alert("产品【"+list[0][1]+"】未关联模具BOM关系");
                  }
              } else if (chooseFlag == 2) {
                $("#<%=this.txtDept.ClientID %>").val(list[0][2]);
                $("#<%=this.hdnDeptId.ClientID %>").val(list[0][0]);
            } else if (chooseFlag == 3) {
              
                $("#<%=this.txtEquimentCode.ClientID %>").val(list[0][1]);
                $("#<%=this.hdnEquimentId.ClientID %>").val(list[0][0]);
                $("#<%=this.lblEquimentName.ClientID %>").text(list[0][2]);
                
            } 
        }
     </script>
    <script language="javascript" type="text/javascript">
        var Id = <%= Request.QueryString["ID"] == null ? -1 : Convert.ToInt32(Request.QueryString["ID"].ToString())%>;
        var tab = document.getElementById("tblExpandBody");
        var selectRowClass = "selectRow";
        var index = 1;
        var inspecType = -1;
        var applyForm = <%= Request.QueryString["ApplyForm"] == null ? "'Server'" :"'"+ Request.QueryString["ApplyForm"].ToString()+"'"%>;//申请来源：UI/Server

        $(function () {

            $(".DateTime").datepicker({
                buttonImageOnly: true,
                showHms: true
            });
            if (Id > 0) {
               var result= GetItemMouldRelations($("#<%=this.hdnItemId.ClientID%>").val());
                if (result.value.length >0) {
                     
                      $("#<%=this.lblBomName.ClientID%>").text(result.value[0].BomName);
                      $("#<%=this.hdnMouldBomId.ClientID%>").val(result.value[0].MouldId);
                      //根据BomId 得到构件名称列表
                      GetMouldBomChild(result.value[0].MouldId);
                  } 
                if ($("#<%=this.hdStatus.ClientID%>").val() > 0) {
                    $(" input").attr("disabled", true);
                    $(" .ui-datepicker-trigger").attr("disabled", true);
                    $("#<%=this.txtRemark.ClientID%>").attr("disabled", true);

                }
            }
            
        });

        
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
       


        //function GetDetailAll(equimentId,cid) {
        //    var result = SKT.LeanMES.Web.Equipment.MouldChangeApplyEdit.GetDetailAll(equimentId,cid);

        //    if (result.error != null) {
        //        alert(result.error.Message);
        //        return false;
        //    }
        //    return result;
        //}


        function GetItemMouldRelations(itemId) {
            var result = SKT.LeanMES.Web.Equipment.MouldChangeApplyEdit.GetItemMouldRelations(itemId);
            if (result.error != null) {
                alert(result.error.Message);
                return false;
            }
            return result;
        }


        function GetMouldBomChild(bomId) {
            var result = SKT.LeanMES.Web.Equipment.MouldChangeApplyEdit.GetMouldBomChild(bomId);
            if (result.error != null) {
                alert(result.error.Message);
                return false;
            }
              
            if (null != result) {
                var index = 1;
                $("#tblExpandBody ").html("");
                for (var i = 0; i < result.value.length; i++) {
                    addDetail(result.value[i], index);
                    index++;
                }
            }
            return result;
        }

        //function GetEquimentMouldAll(equimentId,equimentType) {
        //    var result = SKT.LeanMES.Web.Equipment.MouldChangeApplyEdit.GetEquimentMouldAll(equimentId,equimentType);
        //    if (result.error != null) {
        //        alert(result.error.Message);
        //        return false;
        //    }
        //    return result;

        //}
        function GetIndex() {
            var list = $(tab).find("tr");
            for (var i = 0; i < list.length; i++) {
                if ($(list[i]).attr("class").indexOf(selectRowClass) > -1) {
                    return i;
                }
            }
            return tab.rows.length;
        }

        function addDetail(entity, i) {
            var row, cell;
            if (null == entity) {
                entity.EquipmentTypeName = "";
                entity.ComponentCode = "";
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
            cell.innerHTML =  entity.EquipmentTypeName;

            cell = row.insertCell(2);
            cell.align = "center";
            cell.className = "Field pointer";
            cell.innerHTML = entity.ReplaceComponentName;
            cell = row.insertCell(3);
            cell.align = "center";
            cell.className = "Field";
            cell.width = "80px";
            cell.innerHTML = entity.Describe;
            


        }
        var rowObj = null;
        var rowIndex = 0;

        <%--  function selectMould(obj,equimentType) {
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

        //function getChooseValueEquiment(list) {

        //    if (rowObj.cells[2].children[0].value == list[0][0]) {
        //        alert("在机模具与您选择更换的模具相同，请您重新选择");
        //        return false;
        //    }
           
        //    rowObj.cells[3].children[0].value = list[0][0];
        //    rowObj.cells[3].children[1].value = list[0][2];
          

        //    return true;
        //}
        



        /*保存数据*/
        function Save() {
            var docXml = "<Root>";
            var hdEquipmentTypeId = -1;
            var hdReplaceMouldId = -1;
            var hdCurrentMouldId = -1;
           
            var counts=$("#tblExpand tr:gt(0)").length;

            var j = 0;
            //for (var i = 0; i < counts; i++) {
            //    var data = $("#tblExpand tr:gt(0)")[i];
            //    hdEquipmentTypeId = $(data).find("td:eq(1) .hdEquipmentTypeId").val();
            //    hdCurrentMouldId = $(data).find("td:eq(2) .hdCurrentMouldId").val();
            //    hdReplaceMouldId = $(data).find("td:eq(3) .hdReplaceMouldId").val();
            //    if (hdCurrentMouldId <= 0 && hdReplaceMouldId <= 0) {
            //        alert("在机模具与更换模具不能同时为空");
            //        return false;
            //    }
            //    if (hdReplaceMouldId != "") {
            //        j = 1;
            //    }
               
            //    docXml += "<Detail MouldType='" + hdEquipmentTypeId + "'  CurrentMouldId='" + hdCurrentMouldId + "' ReplaceMouldId='" + hdReplaceMouldId + "'></Detail>";
            //}

           
            docXml += "</Root>";

           //if (j == 0) {
           //    alert("没有申请更换的模具");
           //    return false;
           //}
           
            var entity = {};
            entity.Cid = Id;
            entity.ApplyNo = $("#<%=this.lblChangeNo.ClientID %>").text();
            entity.ItemId = $("#<%=this.hdnItemId.ClientID %>").val();
            entity.DeptId = $("#<%=this.hdnDeptId.ClientID %>").val();
            entity.EquimentId = $("#<%=this.hdnEquimentId.ClientID %>").val() ;
            entity.ApplyRemark = $("#<%=this.txtRemark.ClientID %>").val();
            entity.MouldBomId = $("#<%=this.hdnMouldBomId.ClientID%>").val();
            entity.NeedTime =  new Date($("#<%=this.txtDemandTime.ClientID %>").val().replace(/-/g, "\/"));
            entity.ChangeoverPlanTime = new Date('1971-01-01'.replace(/-/g, "\/"));
            entity.ActualStartTime = new Date('1971-01-01'.replace(/-/g, "\/"));
            entity.ActualFinish = new Date('1971-01-01'.replace(/-/g, "\/"));
     
            var ajax = SKT.LeanMES.Web.Equipment.MouldChangeApplyEdit.Edit(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert('<%=Resources.Messages.SaveInSuccess %>');
            if(applyForm=="Server"){
                parent.window.UpdateList($("#<%=this.lblChangeNo.ClientID %>").text());
            }
            else{
                parent.window.closeDialog();
            }
            return ajax;
        }


    
    </script>
</asp:Content>
