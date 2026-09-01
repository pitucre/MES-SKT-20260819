<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MaintenancePlanEdit.aspx.cs"
    Inherits="SKT.LeanMES.Web.Maintenance.MaintenancePlanEdit" MasterPageFile="~/Masters/EditMaster.master" %>

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
            <td class="Field2" colspan="3">
               <asp:TextBox runat="server" ID="txtPlanName" isRequired="1"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.MaintainWay%>
            </td>
            <td class="Field2">
                <asp:DropDownList ID="ddlMaintainWay" runat="server" ClientIDMode="Static">
                    <asp:ListItem Value="1">--周期--</asp:ListItem>
                    <asp:ListItem Value="2">--使用次数--</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td class="Label2">
                <%= Resources.lang.CycleType%>
            </td>
            <td class="Field2">
                <asp:DropDownList ID="ddlCycleType" runat="server" ClientIDMode="Static">
                    <asp:ListItem Value="1">--小时--</asp:ListItem>
                    <asp:ListItem Value="2">--天--</asp:ListItem>
                    <asp:ListItem Value="3">--周--</asp:ListItem>
                    <asp:ListItem Value="4">--月--</asp:ListItem>
                    <asp:ListItem Value="5">--年--</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="Label2">
              
                <%= Resources.lang.PreWarning%><em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtPrewarning" runat="server" CssClass="TextBox" MaxLength="50"
                    isRequired="1" isNumber="1" ClientIDMode="Static"></asp:TextBox>
                <asp:Label ID="labPrewarning" runat="server" ClientIDMode="Static"></asp:Label>
            </td>
            <td class="Label2">
                
                <%= Resources.lang.CycleTime%><em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtCycleTime" runat="server" isRequired="1" isNumber="1" CssClass="TextBox"
                    MaxLength="50" ClientIDMode="Static"></asp:TextBox>
                <asp:Label ID="labCycleTime" runat="server" ClientIDMode="Static"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
              
                <%= Resources.lang.MaintainActionPerson%><em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtMaintainPerson" runat="server" CssClass="TextBox" MaxLength="50"
                    Enabled="false" ClientIDMode="Static">
                </asp:TextBox>
                <input type="button" value="..." class="ButtonBox" onclick="selectBy()" />
            </td>
            <td class="Label2">
                
                <%= Resources.lang.PreWarningReceivePerson%><em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtWarningTo" runat="server" CssClass="TextBox" MaxLength="50"
                    Enabled="false" ClientIDMode="Static">
                </asp:TextBox>
                <input type="button" value="..." class="ButtonBox" onclick="selectBy1()" />
            </td>
        </tr>
    </table>
    <div class="clear5">
    </div>
    <input type="button" id="btnSelectDemo" class="ButtonBox" value="选择保养项目" style="width: 100px; height: 25px; font-size: 12px; font-weight: 200;"
        onclick="selectDemo();" /><em>*</em>
    <table class="ListTable" id="tbDemo" style="width: 100%;">
        <tr class="ListTableHeader">
            <th style="width: 20%;">
                <%= Resources.lang.MaintenanceDemoName%>
            </th>
            <th style="width: 30%;">作业项编号
            </th>
            <th style="width: 30%;">作业项名称
            </th>
            <th style="width: 30%;">作业内容
            </th>
            <th style="width: 3%;">
                <%= Resources.lang.AC_Operate%>
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

            //如果是在列表页点击的新增，编辑。
            if (Id > -1) {
                GetDemoListByPlanId(Id);
              
                 $("#btnEqType").attr("disabled", "True");
            } 
            $(".DateTimeBox").datepicker({ showHms: _isHms });
        })


        /*选择保养项目*/
        function selectDemo(){
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=55&Multiple=true&rnd=" + Math.random(), width: 600, height: 300 });
        }

        function selectBy() {
            chooseFlag = 1;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=12&CallBackFunc=selectby&Multiple=false&rnd=" + Math.random(), width: 600, height: 300 });
        }
        function selectBy1() {
            chooseFlag = 2;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=12&CallBackFunc=selectby&Multiple=false&rnd=" + Math.random(), width: 600, height: 300 });
        }
        function selectby(list) {
       
            if (chooseFlag == 1) {
                $("#<%=this.txtMaintainPerson.ClientID %>").val(list[0][2]);
            }
            else{
                $("#<%=this.txtWarningTo.ClientID %>").val(list[0][2]);
               <%-- $("#<%=this.txtWarningEmail.ClientID%>").val(list[0][4]);--%>
            }
        }
        function getChooseValue(list){
            var demoNameString = "";
            var notSubDemoNameString = "";
            setTimeout(function()
            {
                for(var i = 0 ; i < list.length ; i++)
                {
                    /*判断重复*/
                    if(demoIdString.indexOf(list[i][0])<0){
                        demoIdString += list[i][0]+",";
                    }
                        //如果重复，那么记录此保养项名称，终止此项目的添加，继续下一项的添加。
                    else{
                        demoNameString = list[0][2] + "；";
                        continue;
                    }

                    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaintenanceDemoSub.GetDemoSubList(list[i][0]);
                    if (ajax.error != null) {
                        alert(ajax.error.Message);
                        return false;
                    }
                    else{
                        var subList = ajax.value
                        if( subList != null && subList.length > 0)
                        { 
                       
                            /*list[0][0]为保养项目的id,list[0][1]为编号，list[0][2]为名称，list[0][3]描述*/
                            var tbody =$("#tbody");
                            var html = "";
                            for(var k =0 ; k < subList.length ; k++)
                            {
                                html = "";
                                html+="<tr class='ListTableOddRow' name='tr"+list[i][0]+"'>";
                                if(k == 0)
                                {
                                    html+= subList.length > 1 ? "<td rowspan='"+ subList.length +"'>" : "<td>";
                                    html+=list[i][2];
                                    html+="</td>";
                                }

                                 html+="<td style='text-align:center;'>";
                                html+= subList[k].DemoSubCode;
                                html+="</td>";

                                html+="<td style='text-align:center;'>";
                                html+= subList[k].DemoSubName;
                                html+="</td>";

                             

                                html+="<td style='text-align:center;'>";
                                html+= subList[k].Remark;
                                html+="</td>";

                                if(k == 0)
                                {
                                    html+= subList.length > 1 ? "<td rowspan='"+ subList.length +"'>" : "<td>";
                                    html+="<img src='../Content/images/delete.gif' onclick='reMoveDEmo(this, \""+ list[i][0] + "\")' style='cursor:hand;' />";
                                    html+="</td>";
                                }
                           
                                html += "</tr>";

                                tbody.append(html);
                            }//for
                        }//if
                        else
                        {
                            notSubDemoNameString += list[0][2] + "；";
                        }
                    }//else
            
                }//for


                if(demoNameString != "")
                {
                    alert("以下项目未能添加！因为，项目已存在于计划中！" + demoNameString)
                
                }


                if(notSubDemoNameString != "")
                {
                    alert("以下项目未能添加！因为，项目不包含作业步骤！" + notSubDemoNameString)
                
                }
            }, 30)//timeout

        }
        /*移除保养项目*/
        function reMoveDEmo(obj, demoId){
            //demoIdString = demoIdString.replace(demoId+",","");
            //$("#tbody [name='tr"+ demoId.toString()+"']").each(function(i, e)
            //{
            //    $(e).remove();
            //})
            //计划id
            var myajax = SKT.LeanMES.Web.AjaxServices.AjaxMaintenancRelation.DeleteRelation(Id,demoId);
            if (myajax.error != null) {
                alert(myajax.error.Message);
                return false;
            }
            location.reload();
            alert("删除成功！");
           
        }

        /*通过计划id获取保养项目列表*/
        function GetDemoListByPlanId(planId) {
        
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

                    if(parseInt(objTd.length)<=0||objTd==null)
                    {
                        html+= count > 1 ? "<td style='text-align:center;'  rowspan='"+count+"'>" : "<td style='text-align:center;'>";
                        html+="<img src='../Content/images/delete.gif' onclick='reMoveDEmo(this, \""+ demoID + "\")' style='cursor:pointer;' />";
                        html+="</td>";
                    }

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

        // 据保养类型显示相应的单位
        $("#ddlCycleType").change(function(){
            var  type =$("#ddlCycleType option:selected").val();
            if(type=="1")
            {
                $("#labLifeTime").text("　小时");
                $("#labPrewarning").text("　小时");
                $("#labCycleTime").text("　小时");
            }
            if(type=="2")
            {
                $("#labLifeTime").text("　天");
                $("#labPrewarning").text("　天");
                $("#labCycleTime").text("　天");
            }
            if(type=="3")
            {
                $("#labLifeTime").text ("　周");
                $("#labPrewarning").text("　天");
                $("#labCycleTime").text("　周");
            }
            if(type=="4")
            {
                $("#labLifeTime").text("　月");
                $("#labPrewarning").text("　天");
                $("#labCycleTime").text("　月");
            }
            if(type=="5")
            {
                $("#labLifeTime").text("　年");
                $("#labPrewarning").text("　天");
                $("#labCycleTime").text("　年");
            }
        })

        // 根据保养方式，改变对应单位，是否禁用类型下拉。
        $("#ddlMaintainWay").change(function(){
            var  way =$("#ddlMaintainWay").val();
            if(way=="1")
            {
                var  type =$("#ddlCycleType option:selected").val();
                if(type=="1")
                {
                    $("#labLifeTime").text("　小时");
                    $("#labPrewarning").text("　小时");
                    $("#labCycleTime").text("　小时");
                }
                if(type=="2")
                {
                    $("#labLifeTime").text("　天");
                    $("#labPrewarning").text("　天");
                    $("#labCycleTime").text("　天");
                }
                if(type=="3")
                {
                    $("#labLifeTime").text ("　周");
                    $("#labPrewarning").text("　天");
                    $("#labCycleTime").text("　周");
                }
                if(type=="4")
                {
                    $("#labLifeTime").text("　月");
                    $("#labPrewarning").text("　天");
                    $("#labCycleTime").text("　月");
                }
                if(type=="5")
                {
                    $("#labLifeTime").text("　年");
                    $("#labPrewarning").text("　天");
                    $("#labCycleTime").text("　年");
                }
                $("#ddlCycleType").attr("disabled",false);
            }
            else
            {
                $("#ddlCycleType").attr("disabled",true);
                $("#labLifeTime").text("　时间");
                $("#labPrewarning").text("　时间");
                $("#labCycleTime").text("　时间");
            }
        })

        function Save()
        {
            console.log(demoIdString);
       
            var errStr = "";
            //如果是增加模式，则从下拉框获取编码，编辑模式不存在下拉框，则从label获取编码。
            var ddlMaintainWay = $("#ddlMaintainWay option:selected").val();

            //如果选择的是按次数，那么保养类型将被赋值为0。
            if( ddlMaintainWay =='1' )
            {
                var ddlCycleType = $("#ddlCycleType option:selected").val();
            }
            else
            {
                var ddlCycleType = '0';
            }
            
            var textCycleTime = $("#txtCycleTime").val();
            var textPrewarning = $("#txtPrewarning").val();
            var textLifeTime = $("#txtLifeTime").val();
            var planName=$("#<%=this.txtPlanName.ClientID %>").val();
       
            //周期间隔必须大于警报提前
            <%--    if( (parseInt(textCycleTime) - parseInt(textPrewarning)) <= 0 && ddlMaintainWay =="2")
            {
                alert('<%=Resources.Messages.CycleTimeMustGreaterPrewarning %>');
                return false;
            }--%>
            var IsSave=true;
            switch (ddlCycleType) {
                case "3":
                    if( (parseInt(textCycleTime*7) - parseInt(textPrewarning)) <= 0)
                    {
                        IsSave=false;
                    }
                    break;
                case "4":
                    if( (parseInt(textCycleTime*30) - parseInt(textPrewarning)) <= 0)
                    {
                        IsSave=false;
                    }
                    break;
                case "5":
                    if( (parseInt(textCycleTime*365) - parseInt(textPrewarning)) <= 0)
                    {
                        IsSave=false;
                    }
                    break;
                default:
                    if( (parseInt(textCycleTime) - parseInt(textPrewarning)) <= 0)
                    {
                        IsSave=false;
                    }
        
            }
            if(!IsSave)
            {
                alert('<%=Resources.Messages.CycleTimeMustGreaterPrewarning %>');
                return false;
            }

            //设备寿命必须大于周期间隔
            if( (parseInt(textLifeTime) - parseInt(textCycleTime)) <= 0 )
            {
                alert('<%=Resources.Messages.LifeTimeMustGreaterCycleTime %>');
                return false;
            }

            if(!isNumber(textCycleTime))
            {
                errStr +="<%=Resources.Messages.CycleTimeMustGreaterZero %>"
                }

                if(!isNumber(textPrewarning)) {
                    errStr += "<%=Resources.Messages.PreWarningMustGreaterZero %>";
                }
            if(demoIdString == ""){
                errStr+="请选择保养项目！";
            }
            var textMaintainPerson = $("#txtMaintainPerson").val();
            var textWarningTo = $("#txtWarningTo").val();
            var textWarningEmail = $("#txtWarningEmail").val();
            if(textMaintainPerson=="")
            {
                alert("请选择保养人!");
                return false;

            }
            if(textWarningTo=="")
            {
                alert("请选择接收人!");
                return false;

            }
            var textRemark = "";
            if (errStr != "") {
                alert(errStr);
                return false;
            }
    
         
     
      
            
            var entity = {};
            entity.MaintenancePlanId = Id;
            entity.PlanName = planName;
            entity.MaintainWay = ddlMaintainWay;
            entity.CycleType = ddlCycleType;
            entity.CycleTime = textCycleTime;
            entity.LifeTime = textLifeTime;
            entity.Prewarning = textPrewarning;
            entity.MaintainPerson = textMaintainPerson;
            entity.WarningTo = textWarningTo;
            entity.MaintainContents = "";
            entity.WarningEmail = textWarningEmail;
            entity.Remark = textRemark;
      
            var ajaxsave = SKT.LeanMES.Web.AjaxServices.AjaxMaintenance.EditMaintenancePlan(entity, demoIdString);
            if (ajaxsave.error != null) {
                alert(ajaxsave.error.Message);
                return false;
            }

            alert('<%=Resources.Messages.SaveSuccess %>');
            parent.window.UpdateList(planName);
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

       