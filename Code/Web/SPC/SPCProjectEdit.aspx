<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    CodeBehind="SPCProjectEdit.aspx.cs" Inherits="SKT.LeanMES.Web.SPC.SPCProjectEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <style type="text/css">
        .Number
        {
            width: 50px;
            text-align: right;
        }
    </style>
    <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %></div>
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label2">
                SPC项目名称<em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtProjectName" runat="server" CssClass="TextBox" Style="width: 90%"
                    IsRequired="1" MaxLength="50"></asp:TextBox>
            </td>
            <td class="Label2">
                SPC项目描述
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtProjectDesc" runat="server" CssClass="TextBox" MaxLength="100"
                    Style="width: 90%"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                SPC图表类型<em>*</em>
            </td>
            <td class="Field2">
                <asp:DropDownList ID="ddlGraphType" runat="server" IsRequired="1">
                    <asp:ListItem Value="">--请选择--</asp:ListItem>
                    <asp:ListItem Value="X-bar R">X-bar R</asp:ListItem>
                    <asp:ListItem Value="p Chart">p Chart</asp:ListItem>
                    <asp:ListItem Value="np Chart">np Chart</asp:ListItem>
                    <asp:ListItem Value="c Chart">c Chart</asp:ListItem>
                    <asp:ListItem Value="u Chart">u Chart</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td class="Label2">
                组内样本数<em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtSampleQty" runat="server" CssClass="TextBox Number" IsRequired="1"
                    ClientIDMode="Static" MaxLength="4"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                每屏显示组数<em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtGroupQty" runat="server" CssClass="TextBox Number" IsRequired="1"
                    ClientIDMode="Static" MaxLength="2" MaxValue='31'></asp:TextBox>
            </td>
            <td class="Label2">
                样本小数位数<em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtSampleDecimalPoint" runat="server" CssClass="TextBox Number"
                    IsRequired="1" ClientIDMode="Static">2</asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                是否显示CP
            </td>
            <td class="Field2">
                <asp:CheckBox ID="chkIsShowCP" runat="server" />
            </td>
            <td class="Label2">
                是否显示CPK
            </td>
            <td class="Field2">
                <asp:CheckBox ID="chkIsShowCPK" runat="server" />
            </td>
        </tr>
        <tr>
            <td class="Label2">
                是否显示PP
            </td>
            <td class="Field2">
                <asp:CheckBox ID="chkIsShowPP" runat="server" />
            </td>
            <td class="Label2">
                是否显示PPK
            </td>
            <td class="Field2">
                <asp:CheckBox ID="chkIsShowPPK" runat="server" />
            </td>
        </tr>
        <tr style="display:none">
            <td class="Label2">
                不良/缺陷组
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtNCGroupId" runat="server" CssClass="TextBox" ClientIDMode="Static"
                    ReadOnly="true"></asp:TextBox><input type="button" id="btnSelectItem" class="ButtonBox"
                        value="..." title="<%=Resources.lang.ChooseItem %>" onclick="selectChoosePage(1);" />
                <asp:HiddenField ID="hidNCGroupId" runat="server" Value="-1" />
            </td>
            <td class="Label2">
                不良/缺陷A
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtNCCodeIdA" runat="server" CssClass="TextBox" ClientIDMode="Static"
                    ReadOnly="true"></asp:TextBox><input type="button" id="Button1" class="ButtonBox"
                        value="..." title="<%=Resources.lang.ChooseItem %>" onclick="selectChoosePage(2);" />
                <asp:HiddenField ID="hidNCCodeIdA" runat="server" Value="-1" />
            </td>
        </tr>
        <tr style="display:none">
            <td class="Label2">
                不良/缺陷B
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtNCCodeIdB" runat="server" CssClass="TextBox" ClientIDMode="Static"
                    ReadOnly="true"></asp:TextBox><input type="button" id="Button2" class="ButtonBox"
                        value="..." title="<%=Resources.lang.ChooseItem %>" onclick="selectChoosePage(3);" />
                <asp:HiddenField ID="hidNCCodeIdB" runat="server" Value="-1" />
            </td>
            <td class="Label2">
                不良/缺陷C
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtNCCodeIdC" runat="server" CssClass="TextBox" ClientIDMode="Static"
                    ReadOnly="true"></asp:TextBox><input type="button" id="Button3" class="ButtonBox"
                        value="..." title="<%=Resources.lang.ChooseItem %>" onclick="selectChoosePage(4);" />
                <asp:HiddenField ID="hidNCCodeIdC" runat="server" Value="-1" />
            </td>
        </tr>
        <tr style="display:none">
            <td class="Label2">
                不良/缺陷D
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtNCCodeIdD" runat="server" CssClass="TextBox" ClientIDMode="Static"
                    ReadOnly="true"></asp:TextBox><input type="button" id="Button4" class="ButtonBox"
                        value="..." title="<%=Resources.lang.ChooseItem %>" onclick="selectChoosePage(5);" />
                <asp:HiddenField ID="hidNCCodeIdD" runat="server" Value="-1" />
            </td>
            <td class="Label2">
                不良/缺陷E
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtNCCodeIdE" runat="server" CssClass="TextBox" ClientIDMode="Static"
                    ReadOnly="true"></asp:TextBox><input type="button" id="Button5" class="ButtonBox"
                        value="..." title="<%=Resources.lang.ChooseItem %>" onclick="selectChoosePage(6);" />
                <asp:HiddenField ID="hidNCCodeIdE" runat="server" Value="-1" />
            </td>
        </tr>
        <tr>
            <td class="Label2">
                A超控
            </td>
            <td class="Field2">
                <asp:CheckBox ID="chkIsWarnA" runat="server" />
                <span>超越控制线是否报警</span>
            </td>
            <td class="Label2">
                B超规
            </td>
            <td class="Field2">
                <asp:CheckBox ID="chkIsWarnB" runat="server" />
                <span>超越规格线是否报警</span>
            </td>
        </tr>
        <tr>
            <td class="Field2" colspan="4">
                <span style="margin-left: 20px; font-size: 13px;">(C预警)判异规则：n点在中线同一侧时是否报警</span>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                是否启用
            </td>
            <td class="Field2">
                <asp:CheckBox ID="chkIsWarnC" runat="server" ClientIDMode="Static" />
            </td>
            <td class="Label2">
                <span>格式(n)</span><em id="emc" style="display: none;">*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtWarnCVal" runat="server" CssClass="TextBox Number" ClientIDMode="Static"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Field2" colspan="4">
                <span style="margin-left: 20px; font-size: 13px;">(D预警)判异规则：n点连续上升或者下降是否报警</span>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                是否启用
            </td>
            <td class="Field2">
                <asp:CheckBox ID="chkIsWarnD" runat="server" ClientIDMode="Static" />
            </td>
            <td class="Label2">
                <span>格式(n)</span><em id="emd" style="display: none;">*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtWarnDVal" runat="server" CssClass="TextBox Number" ClientIDMode="Static"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Field2" colspan="4">
                <span style="margin-left: 20px; font-size: 13px;">(E预警)判异规则：n点上下交替是否报警</span>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                是否启用
            </td>
            <td class="Field2">
                <asp:CheckBox ID="chkIsWarnE" runat="server" ClientIDMode="Static" />
            </td>
            <td class="Label2">
                <span>格式(n)</span><em id="eme" style="display: none;">*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtWarnEVal" runat="server" CssClass="TextBox Number" ClientIDMode="Static"></asp:TextBox>
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        var sPCProjectId = '<%=Request.QueryString["ID"]%>';
        var ncCodeArr = new Array(0, 0, 0, 0, 0);

        $().ready(function () {
            if (sPCProjectId > 0) {
                var codeIds = '<%=codeIds %>';
                ncCodeArr = codeIds.split(",");
            }
            $("#txtSampleQty,#txtGroupQty,#txtSampleDecimalPoint,#txtWarnCVal,#txtWarnDVal,#txtWarnEVal").bind("keyup", function () {
                getIntVal(this);
            });

            $("#chkIsWarnC").click(function () {
                if (this.checked) {
                    $("#emc").show();
                    $("#txtWarnCVal").attr("IsRequired", "1");
                } else {
                    $("#emc").hide();
                    $("#txtWarnCVal").removeAttr("IsRequired");
                }
            });
            $("#chkIsWarnD").click(function () {
                if (this.checked) {
                    $("#emd").show();
                    $("#txtWarnDVal").attr("IsRequired", "1");
                } else {
                    $("#emd").hide();
                    $("#txtWarnDVal").removeAttr("IsRequired");
                }
            });
            $("#chkIsWarnE").click(function () {
                if (this.checked) {
                    $("#eme").show();
                    $("#txtWarnEVal").attr("IsRequired", "1");
                } else {
                    $("#eme").hide();
                    $("#txtWarnEVal").removeAttr("IsRequired");
                }
            });
        });
        /*保存数据*/
        function Save() {
            var txtProjectName = $.trim($("#<%=this.txtProjectName.ClientID%>").val());
            var txtProjectDesc = $.trim($("#<%=this.txtProjectDesc.ClientID%>").val());
            var txtGraphType = $("#<%=this.ddlGraphType.ClientID%>").val();
            var txtSampleQty = $("#<%=this.txtSampleQty.ClientID%>").val();
            var txtGroupQty = $("#<%=this.txtGroupQty.ClientID%>").val();
            var txtSampleDecimalPoint = $("#<%=this.txtSampleDecimalPoint.ClientID%>").val();
            var txtIsShowCP = $("#<%=this.chkIsShowCP.ClientID%>").is(":checked");
            var txtIsShowCPK = $("#<%=this.chkIsShowCPK.ClientID%>").is(":checked");
            var txtIsShowPP = $("#<%=this.chkIsShowPP.ClientID%>").is(":checked");
            var txtIsShowPPK = $("#<%=this.chkIsShowPPK.ClientID%>").is(":checked");
            var txtNCGroupId = $("#<%=this.hidNCGroupId.ClientID%>").val();
            var txtNCCodeIdA = $("#<%=this.hidNCCodeIdA.ClientID%>").val();
            var txtNCCodeIdB = $("#<%=this.hidNCCodeIdB.ClientID%>").val();
            var txtNCCodeIdC = $("#<%=this.hidNCCodeIdC.ClientID%>").val();
            var txtNCCodeIdD = $("#<%=this.hidNCCodeIdD.ClientID%>").val();
            var txtNCCodeIdE = $("#<%=this.hidNCCodeIdE.ClientID%>").val();
            var txtIsWarnA = $("#<%=this.chkIsWarnA.ClientID%>").is(":checked");
            var txtIsWarnB = $("#<%=this.chkIsWarnB.ClientID%>").is(":checked");
            var txtIsWarnC = $("#<%=this.chkIsWarnC.ClientID%>").is(":checked");
            var txtWarnCVal = $("#<%=this.txtWarnCVal.ClientID%>").val();
            var txtIsWarnD = $("#<%=this.chkIsWarnD.ClientID%>").is(":checked");
            var txtWarnDVal = $("#<%=this.txtWarnDVal.ClientID%>").val();
            var txtIsWarnE = $("#<%=this.chkIsWarnE.ClientID%>").is(":checked");
            var txtWarnEVal = $("#<%=this.txtWarnEVal.ClientID%>").val();

            /*表单验证*/
            /*如需表单验证可以此处处理验证 开始*/

            var entity = {};

            entity.SPCProjectId = sPCProjectId
            entity.ProjectName = txtProjectName;
            entity.ProjectDesc = txtProjectDesc;
            entity.GraphType = txtGraphType;
            entity.SampleQty = txtSampleQty;
            entity.GroupQty = txtGroupQty;
            entity.SampleDecimalPoint = txtSampleDecimalPoint;
            entity.IsShowCP = txtIsShowCP;
            entity.IsShowCPK = txtIsShowCPK;
            entity.IsShowPP = txtIsShowPP;
            entity.IsShowPPK = txtIsShowPPK;
            entity.NCGroupId = txtNCGroupId;
            entity.NCCodeIdA = txtNCCodeIdA;
            entity.NCCodeIdB = txtNCCodeIdB;
            entity.NCCodeIdC = txtNCCodeIdC;
            entity.NCCodeIdD = txtNCCodeIdD;
            entity.NCCodeIdE = txtNCCodeIdE;
            entity.IsWarnA = txtIsWarnA;
            entity.IsWarnB = txtIsWarnB;
            entity.IsWarnC = txtIsWarnC;
            entity.WarnCVal = txtWarnCVal == "" ? 0 : txtWarnCVal;
            entity.IsWarnD = txtIsWarnD;
            entity.WarnDVal = txtWarnDVal == "" ? 0 : txtWarnDVal;
            entity.IsWarnE = txtIsWarnE;
            entity.WarnEVal = txtWarnEVal == "" ? 0 : txtWarnEVal;

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSPC.SPCProjectEdit(entity);
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
            if (i == 1) {
                dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=67&Multiple=false&rnd=" + Math.random(), width: 650, height: 350 });
            }
            else {
                var groupId = $("#<%=this.hidNCGroupId.ClientID %>").val();
                if (groupId == -1) {
                    alert('请先选择不良/缺陷组！');
                    $("#<%=this.txtNCGroupId.ClientID %>").focus();
                    return;
                }
                var pageCondition = "Category = '失败品' ";
                if (groupId > 0) {
                    pageCondition = pageCondition + " and NCGroupId =" + groupId;
                }

                var nccodeIds = ncCodeArr.join(",");            
                pageCondition = pageCondition + " and NCCodeId not in(" + nccodeIds + ")"; 
            
                dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=113&PageCondition=" + escape(pageCondition) + "&Multiple=false&rnd=" + Math.random(), width: 650, height: 350 });
            }
        }

        function getChooseValue(list) {
            if (chooseFlag == 1) {
                var groupId = $("#<%=this.hidNCGroupId.ClientID %>").val();
                if (list[0][0] != groupId) {
                    $("#<%=this.hidNCCodeIdA.ClientID %>").val(-1);
                    $("#<%=this.txtNCCodeIdA.ClientID %>").val("");
                    $("#<%=this.hidNCCodeIdB.ClientID %>").val(-1);
                    $("#<%=this.txtNCCodeIdB.ClientID %>").val("");
                    $("#<%=this.hidNCCodeIdC.ClientID %>").val(-1);
                    $("#<%=this.txtNCCodeIdC.ClientID %>").val("");
                    $("#<%=this.hidNCCodeIdD.ClientID %>").val(-1);
                    $("#<%=this.txtNCCodeIdD.ClientID %>").val("");
                    $("#<%=this.hidNCCodeIdE.ClientID %>").val(-1);
                    $("#<%=this.txtNCCodeIdE.ClientID %>").val("");
                }
                $("#<%=this.hidNCGroupId.ClientID %>").val(list[0][0]);
                $("#<%=this.txtNCGroupId.ClientID %>").val(list[0][1]);
            }
            else if (chooseFlag == 2) {
                $("#<%=this.hidNCCodeIdA.ClientID %>").val(list[0][0]);
                $("#<%=this.txtNCCodeIdA.ClientID %>").val(list[0][1]);
            }
            else if (chooseFlag == 3) {
                $("#<%=this.hidNCCodeIdB.ClientID %>").val(list[0][0]);
                $("#<%=this.txtNCCodeIdB.ClientID %>").val(list[0][1]);
            }
            else if (chooseFlag == 4) {
                $("#<%=this.hidNCCodeIdC.ClientID %>").val(list[0][0]);
                $("#<%=this.txtNCCodeIdC.ClientID %>").val(list[0][1]);
            }
            else if (chooseFlag == 5) {
                $("#<%=this.hidNCCodeIdD.ClientID %>").val(list[0][0]);
                $("#<%=this.txtNCCodeIdD.ClientID %>").val(list[0][1]);
            }
            else if (chooseFlag == 6) {
                $("#<%=this.hidNCCodeIdE.ClientID %>").val(list[0][0]);
                $("#<%=this.txtNCCodeIdE.ClientID %>").val(list[0][1]);
            }

            if (chooseFlag != 1) {
                ncCodeArr[chooseFlag - 2] = list[0][0];
            }           
        }
    </script>
</asp:Content>
