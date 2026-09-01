<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PlanMaintainConfirm.aspx.cs"
    Inherits="SKT.LeanMES.Web.Maintenance.PlanMaintainConfirm" MasterPageFile="~/Masters/EditMaster.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <style type="text/css">
        #layermsg {
            position: absolute;
            left: 50%;
            top: 50%;
            width: 700px;
            height: 500px;
            margin-left: -350px;
            margin-top: -250px;
            display: none;
            z-index: 999;
        }
    </style>
    <table class="EditeContentTable" width="100%">
       
        <tr id="trEquiment" runat="server">
            <td class="Label2">
                <%= Resources.lang.EquipmentCode%>
            </td>
            <td class="Field2">
                <asp:Label runat="server" ID="lblEquipmentCode"></asp:Label>
            </td>
            <td class="Label2">
                <%= Resources.lang.EquipmentName%>
            </td>
            <td class="Field2">
                <asp:Label runat="server" ID="lblEquipmentName"></asp:Label>
            </td>
        </tr>
    <%--    <tr style="display: none;">
            <td class="Label2">
                <%= Resources.lang.LineName%>
            </td>
            <td class="Field2">
                <asp:Label runat="server" ID="lblLineName"></asp:Label>
            </td>
            <td class="Label2">
                <%= Resources.lang.StationName%>
            </td>
            <td class="Field2">
                <asp:Label runat="server" ID="lblStation"></asp:Label>
            </td>
        <--%>
        <tr>
            <td class="Label2">
                <%= Resources.lang.MaintainWay%>
            </td>
            <td class="Field2">
                <asp:Label runat="server" ID="lblMaintainWay"></asp:Label>
            </td>
            <td class="Label2">
                <%= Resources.lang.CycleType%>
            </td>
            <td class="Field2">
                <asp:Label runat="server" ID="lblCycleType"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.CycleTime%>
            </td>
            <td class="Field2">
                <asp:Label runat="server" ID="lblCycleTime"></asp:Label>
            </td>
            <td class="Label2">
                <%= Resources.lang.PreWarning%>
            </td>
            <td class="Field2">
                <asp:Label runat="server" ID="lblPrewarning"></asp:Label>
            </td>
        </tr>
        <tr id="trByUsage" runat="server">
            <td class="Label2">
                <%= Resources.lang.EquipmentLifeTime%>
            </td>
            <td class="Field2">
                <asp:Label runat="server" ID="lblEquipmentLifeTime"></asp:Label>
            </td>
            <td class="Label2">
                <%= Resources.lang.EquipmentUsedTimes%>
            </td>
            <td class="Field2">
                <asp:Label runat="server" ID="lblEquipmentUserCount"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.MaintainActionPerson%>
            </td>
            <td class="Field2">
                <asp:Label runat="server" ID="lblMaintainPerson"></asp:Label>
            </td>
            <td class="Label2">
                <%=Resources.lang.PreWarningReceivePerson%>
            </td>
            <td class="Field2">
                <asp:Label runat="server" ID="lblRecipient"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.PreWarningReceiveEmail%>
            </td>
            <td class="Field2">
                <asp:Label runat="server" ID="lblRecipientEmail"></asp:Label>
            </td>
            <td class="Label2">
                <%= Resources.lang.LastMaintainTime%>
            </td>
            <td class="Field2">
                <asp:Label runat="server" ID="lblLastDateTime"></asp:Label>
            </td>
        </tr>
        <%--<tr>
            <td class="Label2">
                <%= Resources.lang.MaintainDetail%>
            </td>
            <td class="Field2" colspan="3" style="height:100px">
                <asp:Label runat="server" ID="lblMaintainContents"></asp:Label>
            </td>
        </tr>--%>
    </table>
    <div class="clear5">
    </div>
    <style type="text/css"></style>
    <asp:HiddenField runat="server" ID="hdPlanId" Value="0"/>
    <table class="ListTable" id="tbDemo" style="width: 100%;">
        <tr class="ListTableHeader">
            <th style="width: 20%;">
                <%= Resources.lang.MaintenanceDemoName%>
            </th>
       <%--     <th style="width: 30%;">
                作业编号
            </th>--%>
            <th style="width: 30%;">
                作业名称
            </th>
            <th style="width: 30%;">
                作业内容
            </th>
             <th style="width: 30%;">
                保养图片
            </th>
            <th>
                是否保养
            </th>
            
        </tr>
        <tbody id="tbody" >
        </tbody>
    </table>
        <div id="layermsg">
    </div>

    <script type="text/javascript">

        var Id = <%= Request.QueryString["Id"] == null ? -1 : Convert.ToInt32(Request.QueryString["Id"].ToString())%>;
        var isOk = 0;
        var comfirmVal = "";
        $(document).ready(function(){
            //如果是在列表页点击的新增，编辑。
           GetDemoListByPlanId(Id);  
        });

        /*通过计划id获取保养项目列表*/
        function GetDemoListByPlanId(planId)
        {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaintenancRelation.GetRelationList(planId);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            if(ajax!=null)
            {
              
               var entity = ajax.value.Rows;
               var tbody =$("#tbody");
               var html = "";
               /**************************************/
               var demoID;
               var objTd;
               var count;

               for(var i=0; i <entity.length;i++)
               {
                    html = "";
                    html +="<tr class='ListTableOddRow' name='tr"+entity[i].DemoId+"'>";
                    demoID = entity[i].DemoId;
                    objTd = $("#td_"+demoID);

                    if(parseInt(objTd.length)<=0||objTd==null)
                    {
                  
                       count = 0;
                       for(var j = 0 ;j< entity.length;j++)
                       {
                            if(entity[j].DemoId==demoID)
                            {
                                count+=1;
                            }
                       }
                       html += count > 1 ? "<td id='td_"+ demoID +"' rowspan='"+count+"'  >" : "<td id='td_"+ demoID +"'>";
                       html += entity[i].DemoName;
                       html +="</td>";
                    }
                    //作业编码
                    //html+="<td style='text-align:center;'>";
                    //html+= entity[i].DemoCode;
                    //html+="</td>";
               
                    //作业名称
                    html+="<td style='text-align:center;'>";
                    html+= entity[i].DemoSubName;
                    html+="</td>";
                    //作业内容
                    html+="<td style='text-align:center;'>";
                    html+= entity[i].DemoSubCode;
                   html += "</td>";


                   html += "<td style='text-align:center;' name='ImageClass'>";
                   if (entity[i].FileSaveName != "") {
                       var fileUrl = GetFilePath("EquipmentFailure", entity[i].FileSaveName);
                       html += "<img src =" + fileUrl + "  onclick='showPic(this.src)' style='width:60px; height:50px; cursor:pointer; ' />";
                   } 

                   html += "</td>";


                    html+="<td>";
                    html+="<label id='"+entity[i].DemoId + "and" + entity[i].DemoSubId+"'>未保养</label>";
                    html+="</td>";

                  <%--  html+="<td>";
                    html+="<input id='btn"+entity[i].DemoId + "and" + entity[i].DemoSubId
                        + "' type='button' value='待确认' class='btn-text' onclick='CheckPlan("+Id+","
                        + entity[i].DemoId +","+entity[i].DemoSubId+",this)' style='cursor:pointer;background-image:url(<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Images/btn_bg_common.gif) repeat-x;border: solid 1px #2771b7;' />";
                    html+="</td>";--%>

                    html+='</tr>';
                    tbody.append(html);
                    count = 0;
                    
                    if(entity[i].IsDone==1){
                        $("#"+entity[i].DemoId + "and" + entity[i].DemoSubId+"").html("已保养");
                        if (comfirmVal != "") {
                             comfirmVal += ",";
                        }
                        comfirmVal +=Id;
                        
                    }
                    else if(ajax.value.Rows[i].IsDone==0) {
                        isOk += 1;
                    }

               }

               /*update by peter on 2016-4-13
             
               for(var i=0;i<ajax.value.Rows.length;i++)
               {
                  html = "";
                  html+="<tr class='ListTableOddRow'><input id='hdf"+ajax.value.Rows[i].DemoId+"' type='hidden' value='"+ajax.value.Rows[i].DemoId+"' />";

                  var demoID = ajax.value.Rows[i].DemoId;
                  var objTd = $("#td_"+demoID);
                  if(parseInt(objTd.length)<=0||objTd==null)
                  {
                      var count = 1;
                      for(var j = 0 ;j<ajax.value.Rows.length;j++)
                      {
                         if(ajax.value.Rows[j].DemoId==demoID)
                         {
                            count+=1;
                         }
                      }
                      html +="<td id='td_"+ demoID +"' rowspan='"+count+"'  >";
                      html +=ajax.value.Rows[i].DemoName;
                      html +="</td>";
                   }
                   //作业编码
                   html+="<td style='text-align:center;'>";
                   html+= ajax.value.Rows[i].DemoSubCode;
                   html+="</td>";

                   //作业名称
                   html+="<td style='text-align:center;'>";
                   html+= ajax.value.Rows[i].DemoSubName;
                   html+="</td>";

              
                   html+="<td style='text-align:center;'>";
                   html+= ajax.value.Rows[i].Remark;
                   html+="</td>";

                   html+="<td>";
                   html+="<label id='"+ajax.value.Rows[i].DemoId + "and" + ajax.value.Rows[i].DemoSubId+"'>未保养</label>";
                   html+="</td>";

                   html+="<td>";
                   html+="<input id='btn"+ajax.value.Rows[i].DemoId + "and" + ajax.value.Rows[i].DemoSubId
                       +"' type='button' value='待确认' class='btn-text' onclick='CheckPlan("+Id+","+ ajax.value.Rows[i].DemoId +","+ajax.value.Rows[i].DemoSubId+",this)' style='cursor:pointer;background-image:url(/Images/btn_bg_common.gif) repeat-x;border: solid 1px #2771b7;' />";
                  /* html+="</td>";

                   tbody.append(html);
 
                   if(ajax.value.Rows[i].IsDone==1){
                        $("#"+ajax.value.Rows[i].DemoId + "and" + ajax.value.Rows[i].DemoSubId+"").html("已保养");

                        if(ajax.value.Rows[i].IsCheck==1){
                            $("#btn"+ajax.value.Rows[i].DemoId + "and" + ajax.value.Rows[i].DemoSubId).css("background-image","none").css("border","").css("background-color","#F0F0F0").prop("disabled",true).removeClass("btn-text");
                            $("#btn"+ajax.value.Rows[i].DemoId + "and" + ajax.value.Rows[i].DemoSubId).val("已确认");
                        }
                    }
                    else if(ajax.value.Rows[i].IsDone==0){
                         $("#btn"+ajax.value.Rows[i].DemoId + "and" + ajax.value.Rows[i].DemoSubId).css("background-image","none").css("border","").css("background-color","#F0F0F0").prop("disabled",true).removeClass("btn-text");
                        $("#btn"+ajax.value.Rows[i].DemoId + "and" + ajax.value.Rows[i].DemoSubId).val("未确认");
                    }
               }*/
           }
       }


        //预览图片
        function showPic(picUrl) {
            var picContent = "<div id='divClose' title='关闭'>X</div><img width=\"700\" height=\"500\" src=" + picUrl + " />";
            var bodyheight = $("body").height();
            var bodywidth = $("body").width();

            $("#layermsg").html(picContent).show();
            $("#layermsg").bind("click", function () { $("#layermsg,#layer").hide(); });
            $("#layer").css({
                height: bodyheight,
                width: bodywidth,
                display: "block"
            });
        }
        function Save() {
          
            if (isOk > 0) {
                alert("您还有未保养的项目");
                return;
            }
            if (confirm("确认操作？")) {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaintenancRelation.CheckDemo(Id);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }
                 alert("操作成功！");
                window.parent.closeDialog();
            }
        }

       function CheckPlan(Id,demoId,demoSubId,obj){
            if(confirm("确认操作？")){
              var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaintenancRelation.CheckDemo(Id,demoId,demoSubId,1);
              if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

                alert("操作成功！");
                $(obj).css("background-image","none").css("border","").css("background-color","#F0F0F0").prop("disabled",true).removeClass("btn-text");
                $(obj).val("已确认");

        }
       }
        function Confirm()
        {
            var ajaxsave = SKT.LeanMES.Web.AjaxServices.AjaxMaintenance.MaintenanceConfirm(Id);
            if (ajaxsave.error != null) {
                alert(ajaxsave.error.Message);
                return false;
            }

            alert('<%=Resources.Messages.PlanMaintainConfirmSuccess %>');
            window.parent.closeDialog();
        }

    </script>
</asp:Content>
