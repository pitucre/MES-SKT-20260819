<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MaintenanceEquimentEdit.aspx.cs"
    Inherits="SKT.LeanMES.Web.Maintenance.MaintenanceEquimentEdit" MasterPageFile="~/Masters/EditMaster.master" %>

<%@ MasterType VirtualPath="~/Masters/EditMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <style type="text/css">
        .tdspan {
            display: block;
            border-top: 1px solid #d3d3d3;
            width: 105%;
            padding-bottom: 2px;
            margin-left: -7px;
        }

        .span0 {
            border: none;
        }
    </style>
    <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %>
    </div>
    <table class="EditeContentTable" width="100%" id="tblExpand">
         <tr>
            <td class="Label2">
                <%=Resources.lang.PlanName%><em>*</em>
            </td>
            <td class="Field2">
               <asp:TextBox runat="server" ID="txtPlanName"  ReadOnly="True"></asp:TextBox>
                  <input type="button" value="..." class="ButtonBox" onclick="selectMainPlan()" id="btnMtPlan" />
                <asp:HiddenField ID="hdMaintenancePlanId" runat="server" ClientIDMode="Static" />
            </td>
              <td class="Label2">
               <%=Resources.lang.PlanObject%>  <em>*</em>
            </td>
            <td class="Field2">
                  <asp:DropDownList ID="ddlPlanObject" runat="server" ClientIDMode="Static">
                    <asp:ListItem Value="1">--设备--</asp:ListItem>
                    <asp:ListItem Value="2">--设备类型--</asp:ListItem>
                    <asp:ListItem Value="3">--SMT设备--</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr id="trEqptmpadd" >
            <td class="Label2">
                <%= Resources.lang.EquipmentName%>
            </td>
            <td class="Field2" >
                <asp:TextBox ID="txtEquipmentName" runat="server" CssClass="TextBox" MaxLength="100"></asp:TextBox>
                 <input type="button" value="..." class="ButtonBox" onclick="selectEq()" />
                <asp:HiddenField ID="HiddenEquipmentId" runat="server" ClientIDMode="Static" />
            </td>
              <td class="Label2">
                <%= Resources.lang.EquipmentCode%>
            </td>
            <td class="Field2">
                <asp:Label runat="server" ID="lblEquimentCode" ClientIDMode="Static"></asp:Label>
            </td>
        </tr>
        <tr id="trEqptmpedit" >
            <td class="Label2">
                <%= Resources.lang.EquipmentCode%>
            </td>
            <td class="Field2">
                <asp:Label runat="server" ID="lblEquipmentCode" ClientIDMode="Static"></asp:Label>
            </td>
            <td class="Label2">
                <%= Resources.lang.EquipmentName%>
            </td>
            <td class="Field2">
                <asp:Label runat="server" ID="lblEquipmentName"></asp:Label>
            </td>
        </tr>
        <tr id="trPlanObjectadd" >
            <td class="Label2">
                <%= Resources.lang.EquipmentTypeName%>
            </td>
            <td class="Field2" colspan="3">
                <asp:TextBox runat="server" ID="ddlEquipmentType" CssClass="TextBox" Enabled="false" ></asp:TextBox>
                <input type="button" value="..." class="ButtonBox" onclick="selectEqType()" id="btnEqType" />
                <asp:HiddenField ID="HiddenEquipmentTypeId" runat="server" ClientIDMode="Static" />
            </td>
        </tr>
        <tr id="trPlanObjectedit" >
            <td class="Label2">
                <%= Resources.lang.EquipmentTypeName%>
            </td>
            <td class="Field2" colspan="3">
                <asp:Label runat="server" ID="lblEquipmentTypeName" ClientIDMode="Static"></asp:Label>
            </td>
        </tr>
        <tr id="trSMTAdd" >
            <td class="Label2">
                <%= Resources.lang.FeedSN%>
            </td>
            <td class="Field2" colspan="3">
                <asp:TextBox runat="server" ID="FeedSN" CssClass="TextBox" Enabled="false" ></asp:TextBox>
                <input type="button" value="..." class="ButtonBox" onclick="selectFD()" id="btnFD" />
                   <asp:HiddenField ID="HidFeedID" runat="server" ClientIDMode="Static" />
            </td>
        </tr>
        <tr>
            <td class="Label2"><%= Resources.lang.LastMaintainTime%><em>*</em>
            </td>
            <td class="Field2">
                <%--<asp:Label ID="txtLastTime" runat="server" ClientIDMode="Static"></asp:Label>--%>
                <asp:TextBox ID="txtLastTime" runat="server" class="DateTimeBox" Width="150" isRequired="1"
                    ClientIDMode="Static"></asp:TextBox>
            </td>
            <td class="Label2"><%= Resources.lang.NextMaintainTime%><em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtMaintainTime" runat="server" class="DateTimeBox" Width="150" isRequired="1"
                    ClientIDMode="Static"></asp:TextBox>
            </td>
        </tr>
         <tr>
            <td class="Label2"><%= Resources.lang.Remark%>
            </td>
            <td class="Field2" colspan="3">
               <asp:TextBox ID="txtRemark" CssClass="TextArea" TextMode="MultiLine" runat="server"
                    ClientIDMode="Static" Width="90%" Height="45"></asp:TextBox>
            </td>
            
        </tr>
    </table>
        <div class="clear5">
    </div>
   
    <table class="ListTable" id="tbDemo" style="width: 100%;">
        <tr class="ListTableHeader">
            <th style="width: 20%;">
                <%= Resources.lang.MaintenanceDemoName%>
            </th>
            <th style="width: 10%;">作业项编号
            </th>
            <th style="width: 20%;">作业项名称
            </th>
            <th style="width: 50%;">作业内容
            </th>
           
        </tr>
        <tbody id="tbody">
        </tbody>
    </table>        

    <div class="clear5">
    </div>
    <script type="text/javascript">
        var Id = <%= Request.QueryString["Id"] == null ? -1 : Convert.ToInt32(Request.QueryString["Id"].ToString())%>;
        var demoIdString = "";
        _isHms = true;
         var tab = document.getElementById("tblExpand");
         var planType = '<%=planObjectType %>';

        $(document).ready(function() {
            $("#<%=this.ddlPlanObject.ClientID %>").val(planType);
            SetTrDisplay(planType);
            //如果是在列表页点击的新增，编辑。
            if (Id > -1) {
                SetTrDisplay(1);
                 GetDemoListByPlanId($("#<%=this.hdMaintenancePlanId.ClientID %>").val());
                 $("#<%=ddlPlanObject.ClientID %>").attr("disabled", "True");
                 $("#btnEqType").attr("disabled", "True");
            } 

            $("#<%=this.ddlPlanObject.ClientID %>").change(function() {

                SetTrDisplay(this.value);

            });
            $(".DateTimeBox").datepicker({ showHms: _isHms });
        })

        function SetTrDisplay(o) {
          if (Id > -1) { //编辑
              if (o == 1) {  //设备
                tab.rows[1].style.display = "none";
                tab.rows[2].style.display = "";
                tab.rows[3].style.display = "none";
                tab.rows[4].style.display = "none";
                tab.rows[5].style.display = "none";
              }else if(o==3){
                  tab.rows[1].style.display = "none";
                  tab.rows[2].style.display = "none";
                  tab.rows[3].style.display = "none";
                  tab.rows[4].style.display = "none";
                  tab.rows[5].style.display = "none";
              } else {
                tab.rows[1].style.display = "none";
                tab.rows[2].style.display = "none";
                tab.rows[3].style.display = "none";
                tab.rows[4].style.display = "";
                tab.rows[5].style.display = "none";
            }
          }
          else {
             if (o == 1) {
                tab.rows[1].style.display = "";
                tab.rows[2].style.display = "none";
                tab.rows[3].style.display = "none";
                tab.rows[4].style.display = "none";
                tab.rows[5].style.display = "none";
             }else if(o==3){
                 tab.rows[1].style.display = "none";
                 tab.rows[2].style.display = "none";
                 tab.rows[3].style.display = "none";
                 tab.rows[4].style.display = "none";
                 tab.rows[5].style.display = "";
             } else {
                tab.rows[1].style.display = "none";
                tab.rows[2].style.display = "none";
                tab.rows[3].style.display = "";
                tab.rows[4].style.display = "none";
                tab.rows[5].style.display = "none";
            }
          }
           
        }
      
        /*通过计划id获取保养项目列表*/
        function GetDemoListByPlanId(planId) {
            $("#tbody").html("");
            var myajax = SKT.LeanMES.Web.AjaxServices.AjaxMaintenancRelation.GetMyRelationList(planId,2);
            if (myajax.error != null) {
                alert(myajax.error.Message);
                return false;
            }

            if(myajax!=null){
                var tbody =$("#tbody");
                var html = "";
                var demoID;
                var objTd;
                var count;
                for(var i=0;i<myajax.value.Rows.length;i++){
                    html = "";
                    html +="<tr class='ListTableOddRow' name='tr"+myajax.value.Rows[i].DemoId+"'>";
           
                    demoID = myajax.value.Rows[i].DemoId;
                    objTd = $("#td_"+demoID);
                    if(parseInt(objTd.length)<=0||objTd==null)
                    {
                        demoIdString = demoIdString + demoID.toString() + ",";
                        count = 0;
                        for(var j = 0 ;j<myajax.value.Rows.length;j++)
                        {
                            if(myajax.value.Rows[j].DemoId==demoID)
                            {
                                count+=1;
                            }
                        }
                        html += count > 1 ? "<td id='td_"+ demoID +"' rowspan='"+count+"'  >" : "<td id='td_"+ demoID +"'>";
                        html +=myajax.value.Rows[i].DemoName;
                        html +="</td>";
                    }

                    //作业编码
                    html+="<td style='text-align:center;'>";
                    html+= myajax.value.Rows[i].DemoSubCode;
                    html+="</td>";
               
                    //作业名称
                    html+="<td style='text-align:center;'>";
                    html+= myajax.value.Rows[i].DemoSubName;
                    html+="</td>";
                    //作业内容
                    html+="<td style='text-align:center;'>";
                    html+= myajax.value.Rows[i].Remark;
                    html+="</td>";

                    //if(parseInt(objTd.length)<=0||objTd==null)
                    //{
                    //    html+= count > 1 ? "<td style='text-align:center;'  rowspan='"+count+"'>" : "<td style='text-align:center;'>";
                    //    html+="<img src='../Content/images/delete.gif' onclick='reMoveDEmo(this, \""+ demoID + "\")' style='cursor:pointer;' />";
                    //    html+="</td>";
                    //}

                    html+='</tr>';

                    tbody.append(html);
                    count = 0;
                }
            }
        }
     
        // 当设备编码下拉值改变时，动态获取该设备的产线名和工位名，赋给对应label。
        $("#ddlEquipmentCodeAndName").change(function(){
            var equiCode = $("#ddlEquipmentCodeAndName option:selected").val();
            var ajaxValue = SKT.LeanMES.Web.AjaxServices.AjaxEquipment.GetLineStationName(equiCode);
            if (ajaxValue.error != null) {
                alert(ajaxValue.error.Message);
                return false;
            }
            else{
                $("#lblLineName").text( ajaxValue.value[0]);
                $("#lblStation").text( ajaxValue.value[1]);
            }
        })


        function Save()
        {
            var errStr = "";
            //如果是增加模式，则从下拉框获取编码，编辑模式不存在下拉框，则从label获取编码。
            var equimentId = $("#<%=this.HiddenEquipmentId.ClientID%>").val();
            var txtPlanObjectType=$("#ddlPlanObject option:selected").val();
          
            var textRemark = $("#<%=this.txtRemark.ClientID%>").val();
            var  txtLastTime=$("#<%=this.txtLastTime.ClientID%>").val();
           
            var equipmentTypeId = $("#<%=this.HiddenEquipmentTypeId.ClientID%>").val();
         
            var  finishDataTime = $("#txtMaintainTime").val();

            var FeedID = $("#<%=this.HidFeedID.ClientID%>").val();
      
            if (txtPlanObjectType =="2")
            {
                if (equipmentTypeId <= 0) {
                    alert("带*不能为空");
                    return false;
                }
                   equimentId =0;
            }
            else if (txtPlanObjectType =="3")
            {
                if (FeedID <= 0) {
                    alert("带*不能为空");
                    return false;
                }
                equimentId=FeedID;
                equipmentTypeId = 0;
            }
            else {
                if (equimentId <= 0) {
                    alert("带*不能为空");
                    return false;
                }
                  equipmentTypeId = 0;
            }
            
            var entity = {};
            entity.Eid = Id;
            entity.MaintenancePlanId = $("#<%=this.hdMaintenancePlanId.ClientID%>").val();
            entity.EquipmentId = equimentId;
            entity.Remark = textRemark;
            entity.FinisheDateTime = new Date(finishDataTime.replace(/-/g,"/"));
            entity.LastMaintainTime = new Date(txtLastTime.replace(/-/g,"/"));
            entity.PlanObjectType = txtPlanObjectType;
            entity.EquipmentType=equipmentTypeId;
           
            var ajaxsave = SKT.LeanMES.Web.AjaxServices.AjaxMaintenance.EditMaintenanceEquiment(entity);
            if (ajaxsave.error != null) {
                alert(ajaxsave.error.Message);
                return false;
            }

            alert('<%=Resources.Messages.SaveSuccess %>');
            
            parent.window.UpdateList($("#<%=this.txtPlanName.ClientID%>").val(),$("#<%=this.lblEquipmentCode.ClientID%>").text());
        }

        var chooseFlag ;
        function selectMainPlan() {
            chooseFlag = 1;
            dialog({ title: "<%=Resources.lang.PlanName%>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=675&Multiple=false&rnd=" + Math.random(), width: 650, height: 450 });
        }
         function selectEqType() {
             var openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/EquimentTypeDialog.aspx?name=Equipment_EquimentTypeDialog&controlId=controlId";
            dialog({ title: " <%=Resources.lang.EquipmentType%>", src: openWinUrl, width: 355, height:450 });
        }
        function selectEq() {
            chooseFlag = 2;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=54&Multiple=false&rnd=" + Math.random(), width: 650, height: 450 });
        }
        function selectFD() {
            chooseFlag = 3;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=833&Multiple=false&rnd=" + Math.random(), width: 650, height: 450 });
        }
         function getChooseValue(list) {
            if (chooseFlag == 1) {
                $("#<%=this.txtPlanName.ClientID %>").val(list[0][1]);
                $("#<%=this.hdMaintenancePlanId.ClientID %>").val(list[0][0]);
                GetDemoListByPlanId(list[0][0]);
            } else if (chooseFlag == 2) {
                $("#<%=this.txtEquipmentName.ClientID %>").val(list[0][2]);
                 $("#<%=this.lblEquimentCode.ClientID %>").text(list[0][1]);
                
                $("#<%=this.HiddenEquipmentId.ClientID %>").val(list[0][0]);
            }
             else if (chooseFlag == 3) {
                 $("#<%=this.FeedSN.ClientID %>").val(list[0][1]);
                 $("#<%=this.HidFeedID.ClientID %>").val(list[0][0]);
                 
            }
        }
         SetValue = function (list) {
            closeDialog();
            $("#HiddenEquipmentTypeId").val(list[0].id);
            $("#<%=ddlEquipmentType.ClientID%>").val(list[0].name);
        }
    </script>
    <link href="../Content/plugin/calendar/skin/datepicker.css" rel="stylesheet" type="text/css" />
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/calendar/js/jquery.ui.core.js"
        type="text/javascript"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/calendar/js/jquery.ui.datepicker.js"
        type="text/javascript" charset="GBK"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/calendar/js/jquery.ui.datepicker.zn.js"
        type="text/javascript"></script>
</asp:Content>

