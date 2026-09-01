<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MaintenanceEquimentPlanView.aspx.cs"
    Inherits="SKT.LeanMES.Web.Maintenance.MaintenanceEquimentPlanView" MasterPageFile="~/Masters/ViewMaster.master" %>

<asp:Content ContentPlaceHolderID="viewcontent" runat="server">
<style type="text/css">
        .tdspan
        {
            display: block;
            border-top: 1px solid #d3d3d3;
            width: 105%;
            padding-bottom: 2px;
            margin-left: -7px;
        }
        .span0
        {
            border: none;
        }
    </style>
    <table class="EditeContentTable" width="100%">
          <tr>
          
            <td class="Label2">
               计划名称：
            </td>
            <td class="Field2" colspan="3" >
                   <asp:Label runat="server" ID="lblPlanName"></asp:Label>
             <asp:HiddenField ID="hdMaintenancePlanId" runat="server" ClientIDMode="Static" />
            </td>
           <%--  <td class="Label2">
                <%= Resources.lang.LineName%>
            </td>
            <td class="Field2">
                <asp:Label runat="server" ID="lblLineName"></asp:Label>
            </td>--%>
        </tr>
        <tr>
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
                <%= Resources.lang.PreWarning%>
            </td>
            <td class="Field2">
                <asp:Label ID="lblPrewarning" runat="server"></asp:Label>
            </td>
            <td class="Label2">
                <%= Resources.lang.CycleTime%>
            </td>
            <td class="Field2">
                <asp:Label ID="lblCycleTime" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.MaintainActionPerson%>
            </td>
            <td class="Field2">
                <asp:Label ID="lblMaintainActionPerson" runat="server"></asp:Label>
            </td>
            <td class="Label2">
                <%= Resources.lang.PreWarningReceivePerson%>
            </td>
            <td class="Field2">
                <asp:Label ID="lblPreWarningReceivePerson" runat="server"></asp:Label>
            </td>
        </tr>
       <%-- <tr>
            <td class="Label2">
                <%= Resources.lang.PreWarningReceiveEmail%>
            </td>
            <td class="Field2">
                <asp:Label ID="lblPreWarningReceiveEmail" runat="server"></asp:Label>
            </td>
            <td class="Label2">
                <%= Resources.lang.EquipmentLifeTime%>
            </td>
            <td class="Field2">
                <asp:Label ID="lblLifeTime" runat="server"></asp:Label>
            </td>
        </tr>--%>
        <%-- <tr>
            <td class="Label2">
                <%= Resources.lang.MaintainDetail%>
            </td>

            <td colspan="3" style="height:100px;">
                <asp:Label ID="lblMaintainDetail" runat="server" ></asp:Label>
            </td>
        </tr>--%>
          <tr>
            <td class="Label2"><%= Resources.lang.LastMaintainTime%>
            </td>
            <td class="Field2">
                <asp:Label ID="txtLastTime" runat="server" ClientIDMode="Static"></asp:Label>
            </td>
            <td class="Label2"><%= Resources.lang.NextMaintainTime%><em>*</em>
            </td>
            <td class="Field2">
                 <asp:Label ID="lblMaintainTime" runat="server" ></asp:Label>
               
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
                <th style="width: 30%;">
                    作业项编号
                </th>
                <th style="width: 30%;">
                    作业项名称
                </th>
                <th style="width: 30%;">
                    作业内容
                </th>
               <%-- <th>
                    是否已保养
                </th>--%>
            </tr>
            <tbody id="tbody">
            </tbody>
        </table>
        <div class="clear5">
        </div>
    <script type="text/javascript">
    var demoIdString = "";
    var Id = <%= Request.QueryString["Id"] == null ? -1 : Convert.ToInt32(Request.QueryString["Id"].ToString())%>
    $(document).ready(function() {
        //如果是在列表页点击的新增，编辑。
        GetDemoListByPlanId($("#<%=this.hdMaintenancePlanId.ClientID %>").val());
    });

    //编辑
    function Edit() {
        openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Maintenance/MaintenanceEquimentEdit.aspx?name=Maintenance_MaintenanceEquimentEdit&ID=" + Id;
	    $(".dlg-title.text", parent.window.document).html("<%= Resources.Pages.Maintenance_MaintenancePlanEdit %>");
	    window.location.href = openWinUrl;
    }

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
     
     </script>
</asp:Content>
