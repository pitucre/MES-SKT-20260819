<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="True"
    CodeBehind="EquipmentRepairEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Equipment.EquipmentRepairEdit" Title="Edit EquipmentRepair" %>


<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div class="Label infoTips" style="margin-top: -5px; !margin-top: -25px;">
        <%=Resources.Messages.WithAsteriskIsRequired%>
    </div>
    <div class="wrap_tb" style="min-height: 350px; min-width: 600px">
        <ul class="tb">
            <li type="base-info" class="current" title="故障信息">故障信息
            </li>
            <li type="Repair" title="扩展信息">维修信息</li>
        </ul>

        <div class="tb_c">

            <table width="100%" class="EditeContentTable">
                <tr>
                    <td class="Label2"><%= Resources.lang.RepairNo %><em>*</em></td>
                    <td class="Field2" colspan="3">
                        <asp:Label runat="server" ID="txtRepairNo"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="Label2"><%= Resources.lang.EquipmentCode %><em>*</em></td>
                    <td class="Field2">
                        <asp:TextBox ID="txtEquipmentName" runat="server" CssClass="TextBox" Enabled="false"
                            ReadOnly="true"></asp:TextBox><input type="button" id="btnEquipmentName" class="ButtonBox"
                                value="..." onclick="selectEquipmentName()" isrequired='1' />
                        <asp:HiddenField ID="txtEqCode" runat="server" Value="-1" />
                    </td>
                    <td class="Label2"><%= Resources.lang.EquipmentName %><em>*</em></td>
                    <td class="Field2">
                        <asp:Label ID="EquipmentName" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="Label2">送修时间<em>*</em></td>
                    <td class="Field2">
                        <asp:TextBox ID="txtRepairTime" runat="server" CssClass="DateTimeBox" IsRequired="1" Width="150px" ReadOnly="true"></asp:TextBox>
                    </td>
                    <td class="Label2">送修人<em>*</em>
                    </td>
                    <td class="Field2">
                        <asp:TextBox ID="txtSongCarRen" runat="server" CssClass="TextBox" MaxLength="50" IsRequired="1"
                            Enabled="false" ClientIDMode="Static">
                        </asp:TextBox>
                        <input type="button" value="..." class="ButtonBox" onclick="selectBy(3)" />
                        <input  type="hidden" id="hdSongCarRen" runat="server"/>
                    </td>


                </tr>
                <tr>
                    <td class="Label2"><%= Resources.lang.RepairDesc %><em>*</em></td>
                    <td class="Field2" colspan="3">
                        <asp:TextBox ID="txtRepairDesc" runat="server" CssClass="TextArea" IsRequired="1" MaxLength="200" TextMode="MultiLine" Width="95%"></asp:TextBox>
                    </td>
                </tr>

            </table>

        </div>
        <div  class="tab-Repair">

            <table width="100%" class="EditeContentTable">
                <tr>
                    <td class="Label2">维修人<em>*</em></td>
                    <td class="Field2" colspan="3">
                        <asp:TextBox ID="txtRepairBy" runat="server" CssClass="TextBox" MaxLength="50"
                            Enabled="false" ClientIDMode="Static">
                        </asp:TextBox>
                        <input type="button" value="..." class="ButtonBox" onclick="selectBy(4)" />
                        <input  type="hidden" id="hdRepairBy" runat="server"/>
                    </td>
                    <%--<td class="Label2"><%= Resources.lang.Status %></td>
                    <td class="Field2">
                        <asp:DropDownList runat="server" ID="txtStatus">
                            <asp:ListItem Value="1">进行中</asp:ListItem>
                            <asp:ListItem Value="2">完成</asp:ListItem>
                        </asp:DropDownList>
                    </td>--%>
                </tr>
                <tr>
                    <td class="Label2">维修开始时间<em>*</em></td>
                    <td class="Field2">
                        <asp:TextBox ID="txtRepairSTime" runat="server" CssClass="DateTimeBox" Width="150px" ReadOnly="true"></asp:TextBox>
                    </td>
                    <td class="Label2">维修结束时间</td>
                    <td class="Field2">
                        <asp:TextBox ID="txtRepairETime" runat="server" CssClass="DateTimeBox" Width="150px" ReadOnly="true"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="Label2">更换备件</td>
                    <td class="Field2">
                        <asp:TextBox ID="txtPartContent" runat="server" CssClass="TextBox" MaxLength="50"
                            Enabled="false" ClientIDMode="Static">
                        </asp:TextBox>
                        <input type="button" value="..." class="ButtonBox" onclick="selectPart()" />
                        <asp:HiddenField ID="HiddenField1" runat="server" ClientIDMode="Static" />
                        <input type="button" value="清除" onclick="Clean()" style="margin: 5px 0 0 0" />
                    </td>
                    <td class="Label2">更换备件</td>
                    <td class="Field2">
                        <asp:Label runat="server" ID="PartList"></asp:Label>
                    </td>
                </tr>
                <tr>

                    <td class="Label2">故障分析及处理<em>*</em></td>
                    <td class="Field2" colspan="3">
                        <asp:TextBox ID="txtHandleContent" runat="server" CssClass="TextArea" MaxLength="500" TextMode="MultiLine" Width="95%"></asp:TextBox>
                    </td>
                </tr>
            </table>
            <%--           <span class="Tips">故障信息</span>
            <table id="tblPj" class="ListTable" style="border-width:0px;width:100%;border-collapse:collapse; height: 26px;background-color: #F7F7F7" cellspacing="0" cellpadding="2">
                <tr>
                    <th>序号</th>
                    <th>备件名称</th>
                    <th>数量</th>
                    <th>操作</th>
                </tr>
            </ta--%>
        </div>
    </div>

    <asp:HiddenField runat="server" ID="StartTime" />
    <asp:HiddenField runat="server" ID="EndTime" />
    <asp:HiddenField runat="server" ID="RepairTime" />
    <script type="text/javascript" src="../Content/js/jquery-3.1.0.min.js"></script>
    <script type="text/javascript" src="../Content/plugin/calendar/js/jquery.ui.datepicker.js"></script>
    <script type="text/javascript">
        var equipmentRepairId = '<%=Request.QueryString["ID"]%>';
        var userName = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';
        var userCName = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().EmployeeCName%>';
        var name = '<%=Request.QueryString["name"]%>';
       
        $(document).ready(function () {
         
            $(".DateTimeBox").datepicker("option", "showHms", true);
            $("#<%=this.txtRepairSTime.ClientID%>").val($("#<%=this.StartTime.ClientID%>").val());
            $("#<%=this.txtRepairETime.ClientID%>").val($("#<%=this.EndTime.ClientID%>").val());
            $("#<%=this.txtRepairTime.ClientID%>").val($("#<%=this.RepairTime.ClientID%>").val());
            
         
            if (name == "EquipmentRepairListAdd") {
                $(".wrap_tb li[type=\"Repair\"]").hide();
                $("#<%=this.txtSongCarRen.ClientID %>").val(userCName);
                $("#<%=this.hdSongCarRen.ClientID %>").val(userName);
                var mynowdate = GetNowDate();
                $("#<%=this.txtRepairTime.ClientID %>").val(mynowdate);
            }
            else if (name == "EquipmentRepairListEdit") {
                $(".wrap_tb li[type=\"Repair\"]").hide();
            } else if (name == "EquipmentRepairListView") {
                $(".tb_c input,.tb_c textarea,.tb_c select").prop("disabled", true);
                $(".tb_c .ui-datepicker-trigger").hide();
                $(".tab-Repair input,.tab-Repair textarea,.tab-Repair select").prop("disabled", true);
                $(".tab-Repair .ui-datepicker-trigger").hide();
            } else if (name == "EquipmentRepairListRepair") {
                $(".tb_c input,.tb_c textarea,.tb_c select").prop("disabled", true);
                $(".tb_c .ui-datepicker-trigger").hide();
                $("ul.tb li[type=\"Repair\"]").click();
                $("#<%=this.txtRepairBy.ClientID %>").val(userCName);
                $("#<%=this.hdRepairBy.ClientID %>").val(userName);
            }
        });
        function update(result) {
            closeDialog();


            if ($("#<%=this.PartList.ClientID%>").html() == "") {
                var str = result;
                $("#<%=this.PartList.ClientID%>").html(str);
            } else {
                var str = $("#<%=this.PartList.ClientID%>").html();
                if (result != "") {
                    var aa = result.split('|');
                    if (str.indexOf(aa[0]) > -1) {
                        alert('备件已存在');
                        return;
                    }
                }
                str += "," + result;
                $("#<%=this.PartList.ClientID%>").html(str);
            }
        }
        function Clean() {
            $("#<%=this.PartList.ClientID%>").html("");
        }
        /*保存数据*/
        function Save() {
            var txtRepairNo = $.trim($("#<%=this.txtRepairNo.ClientID%>").html());
            var txtEqCode = $.trim($("#<%=this.txtEqCode.ClientID%>").val());
            var txtRepairDesc = $.trim($("#<%=this.txtRepairDesc.ClientID%>").val());
            var txtCreateBy = $.trim($("#<%=this.hdSongCarRen.ClientID%>").val());
            var txtRepairBy = $.trim($("#<%=this.hdRepairBy.ClientID%>").val());
            var txtRepairTime = $("#<%=this.txtRepairTime.ClientID%>").val();
            var txtRepairSTime = $("#<%=this.txtRepairSTime.ClientID%>").val();
            var txtRepairETime = $("#<%=this.txtRepairETime.ClientID%>").val();
            var txtHandleContent = $.trim($("#<%=this.txtHandleContent.ClientID%>").val());
            var txtPartContent = $.trim($("#<%=this.PartList.ClientID%>").html());

            var st = new Date(txtRepairSTime.replace("-", "/").replace("-", "/"));
            var et = new Date(txtRepairETime.replace("-", "/").replace("-", "/"));
            if (et < st) {
                alert("开始时间不能大于结束时间");
                return false;
            }
            /*表单验证*/
            if (name == "EquipmentRepairListRepair") {
                if (txtHandleContent == "") {
                    alert("请填写故障分析及处理");
                    return false;
                }
                if (txtRepairSTime == "") {
                    alert("请填写维修开始时间");
                    return false;
                }
                if (txtRepairBy == "") {
                    alert("请填写维修人");
                    return false;
                }
            }

            var entity = {};
            entity.EquipmentRepairId = equipmentRepairId;
            entity.RepairNo = txtRepairNo;
            entity.EqCode = txtEqCode;
            entity.RepairDesc = txtRepairDesc;
            entity.CreateBy = txtCreateBy;
            entity.Status = -1;
            entity.RepairBy = txtRepairBy;
            entity.RepairTime = txtRepairTime ? new Date(Date.parse(txtRepairTime.replace(/-/g, "/"))) : null;
            entity.RepairSTime = txtRepairSTime ? new Date(Date.parse(txtRepairSTime.replace(/-/g, "/"))) : null;
            entity.RepairETime = txtRepairETime ? new Date(Date.parse(txtRepairETime.replace(/-/g, "/"))) : null;
            entity.HandleContent = txtHandleContent;
            entity.PartContent = txtPartContent;
            entity.Reserve1 = "";
            entity.Reserve2 = "";
            entity.Reserve3 = "";

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEquipmentRepair.EquipmentRepairEdit(entity, name);
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
        function selectEquipmentName() {
            temp = 1;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=54&Multiple=false&rnd=" + Math.random(), width: 650, height: 350 });
        }
        function selectPart() {
            if ($("#<%=this.txtEqCode.ClientID%>").val() == -1) {
                alert("请选择设备");
                return false;
            }
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/EquipmentPositionEditDtl.aspx?&EqCode=" + $("#<%=this.txtEqCode.ClientID%>").val();
            dialog({ title: "<%=Resources.Pages.EquipmentRepairListEdit %>", src: openWinUrl, width: 670, height: 370 });
        }

        /*保管人*/
        function selectBy(id) {
            temp = id;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=12&Multiple=false&rnd=" + Math.random(), width: 650, height: 350 });
        }
        function getChooseValue(list) {
            if (temp == 1) {
                var result = SKT.LeanMES.Web.AjaxServices.AjaxEquipmentRepair.CheckEquimentRepair(list[0][1]);
                if (result.value == 1) {
                    alert("该机器已经存在未完成的维修单");
                    return;
                }
                $("#<%=this.txtEquipmentName.ClientID %>").val(list[0][1]);
                $("#<%=this.EquipmentName.ClientID %>").html(list[0][2]);
                $("#<%=this.txtEqCode.ClientID %>").val(list[0][1]);


            }
            else if (temp == 2) {

                var str = $("#<%=this.PartList.ClientID%>").html();
                str += "," + list[0][0];
                $("#<%=this.PartList.ClientID%>").html(str);
            }
            else if (temp == 3) {
                $("#<%=this.txtSongCarRen.ClientID %>").val(list[0][3]);
                $("#<%=this.hdSongCarRen.ClientID %>").val(list[0][2]);
            }
            else if (temp == 4) {
                $("#<%=this.txtRepairBy.ClientID %>").val(list[0][3]);
                $("#<%=this.hdRepairBy.ClientID %>").val(list[0][2]);
            }
        }

        //获取当前时间。带时分秒
        function GetNowDate() {
            var myDate = new Date;
            var year = myDate.getFullYear(); //获取当前年
            var mon = myDate.getMonth() + 1; //获取当前月
            var date = myDate.getDate(); //获取当前日
            var h = myDate.getHours();//获取当前小时数(0-23)
            var m = myDate.getMinutes();//获取当前分钟数(0-59)
            var s = myDate.getSeconds();//获取当前秒
            var NowDate = year + "-" + mon + "-" + date + " " + h + ":" + m + ":" + s;
            return NowDate;
        }

    </script>
</asp:Content>
