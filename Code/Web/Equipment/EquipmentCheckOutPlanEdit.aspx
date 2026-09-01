<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="True"
    CodeBehind="EquipmentCheckOutPlanEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Equipment.EquipmentCheckOutPlanEdit" Title="Edit EquipmentCheckOutPlan" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div class="Label infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired%>
    </div>
    <table width="100%" class="EditeContentTable" id="tblExpand">
          <tr>

              <td class="Label2">
               校验对象<em>*</em>
            </td>
            <td class="Field2" colspan="3">
                  <asp:DropDownList ID="ddlPlanObject" runat="server" ClientIDMode="Static">
                    <asp:ListItem Value="1">--设备--</asp:ListItem>
                    <asp:ListItem Value="2">--设备类型--</asp:ListItem>
                </asp:DropDownList>
                
            </td>
        </tr>
       
        <tr id="trEqptmpCheck">
            <td class="Label2"><%= Resources.lang.EquipmentCode %><em>*</em></td>
            <td class="Field2">
                <asp:TextBox ID="txtEqCode" runat="server" CssClass="TextBox" 
                    ReadOnly="true"></asp:TextBox><input type="button" id="btnEquipmentCode" class="ButtonBox"
                        value="..." onclick="selectEquipmentName()" />
            </td>
            <td class="Label2"><%= Resources.lang.EquipmentName %><em>*</em></td>
            <td class="Field2">
                <asp:Label runat="server" ID="lblEqName"></asp:Label>
            
            </td>
        </tr>
         <tr id="trPlanObject" >
            <td class="Label2">
                <%= Resources.lang.EquipmentTypeName%><em>*</em>
            </td>
            <td class="Field2" colspan="3">
                <asp:TextBox runat="server" ID="ddlEquipmentType" CssClass="TextBox" Enabled="false"></asp:TextBox>
                <input type="button" value="..." class="ButtonBox" onclick="selectEqType()" id="btnEqType"  />
                <asp:HiddenField ID="HiddenEquipmentTypeId" runat="server" ClientIDMode="Static" />
            </td>
        </tr>
        <tr> <td class="Label2">校验类型</td>
            <td class="Field2">
                <asp:DropDownList runat="server" ID="txtCheckType">
                    <asp:ListItem Value="1">内检</asp:ListItem>
                    <asp:ListItem Value="2">外检</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td class="Label2">校验项目<em>*</em></td>
            <td class="Field2">
                <asp:TextBox ID="txtCheckProject" runat="server" CssClass="TextBox" MaxLength="50" IsRequired="1"
                    Enabled="false" ClientIDMode="Static">
                </asp:TextBox>
                <input type="button" value="..." class="ButtonBox" onclick="selectCheckProject()" />
                <asp:HiddenField ID="HiddentxtCheckProject" runat="server" Value="-1" />
            </td>
          
        </tr>
        <tr>  <td class="Label2"><%= Resources.lang.CycleType %></td>
            <td class="Field2">
                <asp:DropDownList ID="txtCycleType" runat="server" ClientIDMode="Static">
                    <asp:ListItem Value="1">--By Hours--</asp:ListItem>
                    <asp:ListItem Value="2">--By Day--</asp:ListItem>
                    <asp:ListItem Value="3">--By Week--</asp:ListItem>
                    <asp:ListItem Value="4">--By Month--</asp:ListItem>
                    <asp:ListItem Value="5">--By Year--</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td class="Label2"><%= Resources.lang.Cycle %><em>*</em></td>
            <td class="Field2">
                <asp:TextBox ID="txtCycle" runat="server" CssClass="TextBox" IsNumber="1" IsRequired="1"></asp:TextBox>
                <asp:Label ID="labCycleTime" runat="server" ClientIDMode="Static">By Hours</asp:Label>
            </td>
        </tr>
         <tr>
            <td class="Label2">上次校验时间
            </td>
            <td class="Field2">
             <%--   <asp:Label ID="lblLastCheckTime" runat="server" ClientIDMode="Static"></asp:Label>--%>
               <asp:TextBox ID="lblLastCheckTime" runat="server" class="DateTimeBox" Width="150" 
                    ClientIDMode="Static"></asp:TextBox>
            </td>
            <td class="Label2">下次校验时间<em>*</em>
            </td>
            <td class="Field2">
               
                <asp:Label runat="server" id="lblNextCheckTime" Width="150"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">提前预警:<em>*</em>
            </td>
            <td class="Field2">
               <asp:TextBox ID="WarningTime" runat="server" CssClass="TextBox" IsNumber="1" IsRequired="1"></asp:TextBox>天           
            </td>
        </tr>
    </table>

    <script type="text/javascript">
        var equipmentCheckOutPlanId = '<%=Request.QueryString["ID"]%>';
        _isHms = true;
        var times = 60;//周期转化为分钟数
        var objectType = <%=ObjectType%>;
        var tab = document.getElementById("tblExpand");
        tab.rows[1].style.display = "";
        tab.rows[2].style.display = "none";
        $(function () {

            if (equipmentCheckOutPlanId > 0) {
                SetTrDisplay(1);
            }
            
            $("#<%=this.txtCycle.ClientID%>").blur(function () {
                // SetNextCheckTime(times);         
                $("#txtCycleType").change();
            });

            $("#<%=this.lblLastCheckTime.ClientID%>").bind('input propertychange blur', function(event) {
                $("#txtCycleType").change();
            });
            $("#<%=this.ddlPlanObject.ClientID %>").change(function() {

                SetTrDisplay(this.value);

            });
            Date.prototype.Format = function (fmt) {
                var o = {
                    "M+": this.getMonth() + 1, //月份 
                    "d+": this.getDate(), //日 
                    "h+": this.getHours(), //小时 
                    "m+": this.getMinutes(), //分 
                    "s+": this.getSeconds(), //秒 
                    "q+": Math.floor((this.getMonth() + 3) / 3), //季度 
                    "S": this.getMilliseconds() //毫秒 
                };
                if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
                for (var k in o)
                    if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
                return fmt;
            }
        });


        // 据保养类型显示相应的单位
        $("#txtCycleType").change(function() {
            var type = $("#txtCycleType option:selected").val();
            var cycle = $("#<%=this.txtCycle.ClientID%>").val();

            if (type == "1") {
                $("#labCycleTime").text("　Hours");
                times = 60;
            }
            if (type == "2") {;
                $("#labCycleTime").text("　Day");
                times = 60 * 24;
            }
            if (type == "3") {
                $("#labCycleTime").text("　Week");
                times = 60 * 24 * 7;
            }
            if (type == "4") {
                $("#labCycleTime").text("　Month");
                times = 60 * 24 * 30;
            }
            if (type == "5") {
                $("#labCycleTime").text("　Year");
                times = 60 * 24 * 365;
            }
            if (cycle != "") {
                SetNextCheckTime(times*cycle);
            }
        });

        function SetTrDisplay(o) {
            if (equipmentCheckOutPlanId > 0) {
                $("#btnEqType").attr("disabled","disabled");
                $("#btnEquipmentCode").attr("disabled","disabled");
                $("#<%=this.ddlPlanObject.ClientID%>").attr("disabled","disabled");
            }
            if (o == 1 ) {  //设备
                    tab.rows[1].style.display = "";
                    tab.rows[2].style.display = "none";
                  
                } else {
                    tab.rows[1].style.display = "none";
                    tab.rows[2].style.display = "";
                   
                }

        }

        function SetNextCheckTime(times) {
            var lblLastCheckTime=$("#lblLastCheckTime").val();
            var date = new Date();
            if(lblLastCheckTime!="")
            {
              //  date=new Date(lblLastCheckTime)
                date = new Date(lblLastCheckTime.replace(/-/g,"/"));

            }
                var min = date.getMinutes();
                date.setMinutes(min + times);
                $("#<%=this.lblNextCheckTime.ClientID%>").html(date.Format("yyyy-MM-dd hh:mm:ss"));
        }

        /*选择供应商*/
        function selectCheckProject() {
            temp = 2;
            var PaC = " IsEnable =1 ";
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=673&PageCondition=" + PaC + "&Multiple=false&rnd=" + Math.random(), width: 650, height: 350 });
        }
        function selectEquipmentName() {
            temp = 1;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=54&Multiple=false&rnd=" + Math.random(), width: 650, height: 350 });
        }
        function getChooseValue(list) {
            if (temp == 1) {
                $("#<%=this.txtEqCode.ClientID%>").val(list[0][1]);
                 $("#<%=this.lblEqName.ClientID%>").html(list[0][2]);
           
                
            }
            if (temp == 2) {
           
                $("#<%=this.txtCheckProject.ClientID%>").val(list[0][2]);
                $("#<%=this.HiddentxtCheckProject.ClientID%>").val(list[0][1]);
            }
        }
        /*保存数据*/
        function Save() {
            var txtEqCode = $.trim($("#<%=this.txtEqCode.ClientID%>").val());
            var txtCheckType = $("#<%=this.txtCheckType.ClientID%>").val();
            var txtCheckProject = $.trim($("#<%=this.HiddentxtCheckProject.ClientID%>").val());
            var txtCycleType = $.trim($("#<%=this.txtCycleType.ClientID%>").val());
            var txtCycle = $("#<%=this.txtCycle.ClientID%>").val();
            var txtCreateBy = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';
            var objectType = $.trim($("#<%=this.ddlPlanObject.ClientID%>").val());
            var equimentTypeid= $.trim($("#<%=this.HiddenEquipmentTypeId.ClientID%>").val());
            
            var LastTime=$("#<%=this.lblLastCheckTime.ClientID%>").val();
            var WarningTime=$("#<%=this.WarningTime.ClientID%>").val();
            var nextTime=$("#<%=this.lblNextCheckTime.ClientID%>").text();

            if (objectType == 1) {
                equimentTypeid = 0;
                if (txtEqCode == "") {
                    alert("带*不可为空.");
                    return;
                }
            } else {
                if (equimentTypeid <=0) {
                    alert("带*不可为空.");
                    return;
                }
            }

            /*表单验证*/
            /*如需表单验证可以此处处理验证 开始*/


            var entity = {};

            entity.EquipmentCheckOutPlanId = equipmentCheckOutPlanId
            entity.EqCode = txtEqCode;
            entity.CheckType = txtCheckType;
            entity.CheckProject = txtCheckProject;
            entity.CycleType = txtCycleType;
            entity.Cycle = txtCycle;
            entity.CreateBy = txtCreateBy;
            entity.ObjectType =objectType;
            entity.EquipmentType = equimentTypeid;
           entity.NextTimeStr=nextTime;
           entity.LastTimeStr=LastTime;
            entity.WarningDays=WarningTime;
  
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEquipmentCheckOutPlan.EquipmentCheckOutPlanEdit(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            alert('<%=Resources.Messages.SaveInSuccess%>')
            if ('<%=Request.QueryString["inMenu"] %>' == "true") {
                openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/User/UserEdit.aspx?name=Account_UserEdit&ID=" + parseInt(ajax.value);
                location.href = openWinUrl;
            }
            else {
                parent.window.Refresh();
            }
        }
         function selectEqType() {
            var openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/EquimentTypeDialog.aspx?name=Equipment_EquimentTypeDialog&controlId=controlId";
            dialog({ title: "设备类型", src: openWinUrl, width: 255, height: 350 });
        }
         SetValue = function (list) {
            closeDialog();
            $("#HiddenEquipmentTypeId").val(list[0].id);
            $("#<%=ddlEquipmentType.ClientID%>").val(list[0].name);
        }
    </script>

</asp:Content>
