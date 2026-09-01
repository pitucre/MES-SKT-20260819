<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    CodeBehind="SPCTaskEdit.aspx.cs" Inherits="SKT.LeanMES.Web.SPC.SPCTaskEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <style type="text/css">
        .Number
        {
            width: 50px;
            text-align: right;
        }
        .Label2
        {
            width: 18%;
        }
    </style>
    <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %></div>
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label2">
                项目名称<em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtSPCProjectId" runat="server" CssClass="TextBox" ClientIDMode="Static"
                    ReadOnly="true"></asp:TextBox><input type="button" id="Button1" class="ButtonBox"
                        value="..." title="<%=Resources.lang.ChooseItem %>" onclick="selectChoosePage(114);" />
                <asp:HiddenField ID="hidSPCProjectId" runat="server" Value="-1" ClientIDMode="Static" />
            </td>
            <td class="Label2">
                图表类型
            </td>
            <td class="Field2">
                <asp:Label ID="lblGraphType" runat="server" ClientIDMode="Static"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                任务名称<em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtTaskName" runat="server" CssClass="TextBox" IsRequired="1" MaxLength="50"></asp:TextBox>
            </td>
            <td class="Label2">
                产品编码
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtItemId" runat="server" CssClass="TextBox" ClientIDMode="Static"
                    ReadOnly="true"></asp:TextBox><input type="button" id="Button2" class="ButtonBox"
                        value="..." title="<%=Resources.lang.ChooseItem %>" onclick="selectChoosePage(1);" />
                <asp:HiddenField ID="hidItemId" runat="server" Value="-1" ClientIDMode="Static" />
            </td>
        </tr>
        <tr>
            <td class="Label2">
                线别
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtLineId" runat="server" CssClass="TextBox" ClientIDMode="Static"
                    ReadOnly="true"></asp:TextBox><input type="button" id="Button3" class="ButtonBox"
                        value="..." title="<%=Resources.lang.ChooseItem %>" onclick="selectChoosePage(21);" />
                <asp:HiddenField ID="hidLineId" runat="server" Value="-1" ClientIDMode="Static" />
            </td>
            <td class="Label2">
                工序
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtStationId" runat="server" CssClass="TextBox" ClientIDMode="Static"
                    ReadOnly="true"></asp:TextBox><input type="button" id="Button4" class="ButtonBox"
                        value="..." title="<%=Resources.lang.ChooseItem %>" onclick="selectChoosePage(8);" />
                <asp:HiddenField ID="hidStationId" runat="server" Value="-1" ClientIDMode="Static" />
            </td>
        </tr>
        <tr>
            <td class="Label2">
                是否自动刷新
            </td>
            <td class="Field2">
                <asp:CheckBox ID="chkIsRefeshData" runat="server" ClientIDMode="Static" />
            </td>
            <td class="Label2">
                间隔时间(分钟)
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtRefeshInterval" runat="server" CssClass="TextBox Number" ClientIDMode="Static"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                规格上限(USL)<em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtUSL" runat="server" CssClass="TextBox Number" IsRequired="1"
                    ClientIDMode="Static"></asp:TextBox>
            </td>
            <td class="Label2">
                规格下限(LSL)<em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtLSL" runat="server" CssClass="TextBox Number" IsRequired="1"
                    ClientIDMode="Static"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2" >
                <span>SPC数据源获取</span><br />
               <span>存储过程</span> 
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtSPCGetDataProc" runat="server" CssClass="TextBox" MaxLength="50"></asp:TextBox>
            </td>
            <td class="Label2">单位
            </td>
            <td class="Field2">
                <asp:HiddenField ID="hdnUnitId" Value="-1" runat="server" ClientIDMode="Static" />
                <asp:TextBox ID="txtUnit" runat="server" Enabled="false" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox><input type="button" onclick="selectChoosePage(3);" class="ButtonBox" value="..." />
            </td>
            <td class="Label2" style="display: none;">
                报警后执行的<br />
                存储过程<em>*</em>
            </td>
            <td class="Field2" style="display: none;">
                <asp:TextBox ID="txtSPCActionProc" runat="server" CssClass="TextBox" Value="SPCAction_XbarR" IsRequired="0"
                    MaxLength="50"></asp:TextBox>
            </td>
        </tr>
        <tr style="display: none;">
            <td class="Label2">
                控制图表数据源<br />
                存储过程<em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtSPCAGraphProc" runat="server" CssClass="TextBox" MaxLength="50"></asp:TextBox>
            </td>
            <td class="Label2">
            </td>
            <td class="Field2">
            </td>
        </tr>
        <tr>
            <td class="Label2">
                任务描述
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtTaskDesc" runat="server" TextMode="MultiLine" CssClass="TextArea"
                    MaxLength="100"></asp:TextBox>
            </td>
            <td class="Label2">
                控制性曲线显示
            </td>
            <td class="Field2">
                <asp:CheckBox ID="chkIsCurve" runat="server" ClientIDMode="Static" />
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        var sPCTaskId = '<%=Request.QueryString["ID"]%>';

        $().ready(function () {
            $("#txtRefeshInterval,#txtUSL,#txtLSL").bind("keyup", function () {
                getDecimalVal(this);
            });
        });
        /*保存数据*/
        function Save() {
            var txtSPCProjectId = $("#<%=this.hidSPCProjectId.ClientID%>").val();
            var txtTaskName = $.trim($("#<%=this.txtTaskName.ClientID%>").val());
            var txtTaskDesc = $.trim($("#<%=this.txtTaskDesc.ClientID%>").val());
            var txtItemId = $("#<%=this.hidItemId.ClientID%>").val();
            var txtLineId = $("#<%=this.hidLineId.ClientID%>").val();
            var txtStationId = $("#<%=this.hidStationId.ClientID%>").val();
            var txtIsRefeshData = $("#<%=this.chkIsRefeshData.ClientID%>").is(":checked");
            var txtRefeshInterval = $("#<%=this.txtRefeshInterval.ClientID%>").val();
            var txtUSL = $("#<%=this.txtUSL.ClientID%>").val();
            var txtLSL = $("#<%=this.txtLSL.ClientID%>").val();
            var txtSPCGetDataProc = $.trim($("#<%=this.txtSPCGetDataProc.ClientID%>").val());
            var txtSPCActionProc = $.trim($("#<%=this.txtSPCActionProc.ClientID%>").val());
            var txtSPCAGraphProc = $.trim($("#<%=this.txtSPCAGraphProc.ClientID%>").val());
            var unitId = $("#<%=this.hdnUnitId.ClientID%>").val();
            var IsCurve = $("#<%=this.chkIsCurve.ClientID%>").is(":checked");

            /*表单验证*/
            /*如需表单验证可以此处处理验证 开始*/

            var entity = {};
            if (parseFloat(txtUSL) <= parseFloat(txtLSL)) {
                alert('规格上限值需大于规格下限值！');
                $("#<%=this.txtLSL.ClientID%>").focus();
                return false;
            }
            entity.SPCTaskId = sPCTaskId
            entity.SPCProjectId = txtSPCProjectId;
            entity.TaskName = txtTaskName;
            entity.TaskDesc = txtTaskDesc;
            entity.ItemId = txtItemId;
            entity.LineId = txtLineId;
            entity.StationId = txtStationId;
            entity.IsRefeshData = txtIsRefeshData;
            entity.RefeshInterval = parseFloat(txtRefeshInterval);
            entity.USL = parseFloat(txtUSL);
            entity.LSL = parseFloat(txtLSL);
            entity.SPCGetDataProc = txtSPCGetDataProc;
            entity.SPCActionProc = txtSPCActionProc;
            entity.SPCAGraphProc = txtSPCAGraphProc;
            entity.UnitId = unitId;
            entity.IsCurve = IsCurve;

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSPC.SPCTaskEdit(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            alert('<%=Resources.Messages.SaveInSuccess%>')
            parent.window.Refresh();

        }
        var chooseFlag = 0;
        function selectChoosePage(i) {
            chooseFlag = i;
            var cond = "";
            if (i == 3) {
                cond = "DicProperty = 'Unit'";
            }
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=" + i + "&PageCondition=" + cond + "&Multiple=false&rnd=" + Math.random(), width: 550, height: 300 });

        }
        function getChooseValue(list) {
            if (chooseFlag == 114) {//项目名称
                $("#txtSPCProjectId").val(list[0][1]);
                $("#hidSPCProjectId").val(list[0][0]);
                $("#lblGraphType").text(list[0][2]);
            }
            else if (chooseFlag == 1) {//产品
                $("#txtItemId").val(list[0][2]);
                $("#hidItemId").val(list[0][0]);
            }
            else if (chooseFlag == 8) {//工序
                $("#txtStationId").val(list[0][1]);
                $("#hidStationId").val(list[0][0]);
            }
            else if (chooseFlag == 21) {//线别
                $("#txtLineId").val(list[0][1]);
                $("#hidLineId").val(list[0][0]);
            } else if (chooseFlag == 3) {//单位                                
                $("#hdnUnitId").val(list[0][0]);
                $("#txtUnit").val(list[0][1]);
            }
        }
    </script>
</asp:Content>
