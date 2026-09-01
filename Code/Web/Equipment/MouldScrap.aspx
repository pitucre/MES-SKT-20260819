<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="True"
    CodeBehind="MouldScrap.aspx.cs" Inherits="SKT.LeanMES.Web.Equipment.MouldScrap" Title="Edit EquipmentPosition" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div class="Label infoTips" style="margin-top: -5px; !margin-top: -25px;">
        <%=Resources.Messages.WithAsteriskIsRequired%>
    </div>
    <table width="100%" class="EditeContentTable">
       
        <tr>
            <td class="Label2">模具编码</td>
            <td class="Field2">
                <asp:Label ID="lblMouldCode" runat="server" ></asp:Label>
            </td>
              <td class="Label2">发生机台<em>*</em></td>
            <td class="Field2">
                <asp:TextBox ID="txtEquipmentName" runat="server" CssClass="TextBox" MaxLength="100" IsRequired='1'></asp:TextBox><input type="button" id="btnEquipmentName" class="ButtonBox"
                                value="..." onclick="selectEquipmentName()" />
           <asp:HiddenField runat="server" ID="hidEquipmentId" Value="=-1"/>
             </td>
        </tr>
        <tr>
            <td class="Label2">报废原因<em>*</em></td>
            <td class="Field2">
               <select id="sltScrapType">
                   <option value=""> &nbsp;  -请选择-   &nbsp;</option>
                   <option value="设备故障"> &nbsp;设备故障</option>
                   <option value="模具拆装"> &nbsp;模具拆装</option>
                   <option value="操作失误"> &nbsp;操作失误</option>
                   <option value="自然报废"> &nbsp;自然报废</option>
                   <option value="压力超标"> &nbsp;压力超标</option>
               </select>
            </td>
              <td class="Label2">报废人</td>
            <td class="Field2">
               <asp:Label runat="server" ID="lblScrapBy"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">责任部门<em>*</em></td>
            <td class="Field2">
              <asp:TextBox ID="txtDep" runat="server" CssClass="TextBox" MaxLength="50"
                    Enabled="false" ClientIDMode="Static"  IsRequired='1'>
                </asp:TextBox>
                <input type="button" value="..." class="ButtonBox" onclick="selectDep()" />
                <asp:HiddenField ID="HiddDep" runat="server" ClientIDMode="Static" />
            </td>
              <td class="Label2">责任人<em>*</em></td>
            <td class="Field2">
                <asp:TextBox ID="txtPersonInCharge" runat="server" CssClass="TextBox" MaxLength="50"
                     ClientIDMode="Static"  IsRequired='1'></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">报废说明<em>*</em></td>
            <td class="Field2" colspan="3">
                <asp:TextBox ID="txtRemark" runat="server" CssClass="TextArea" MaxLength="500" TextMode="MultiLine" Width="90%" Height="65" IsRequired='1'></asp:TextBox>
            </td>
        </tr>
    </table>
    <input type="hidden" id="hdParentEquipmentCode"/>
    <script type="text/javascript">
        var mouldId = '<%=Request.QueryString["ID"]%>';
        var mouldCode = '<%=Request.QueryString["MouldCode"]%>';

        $(function() {
            $("#<%=this.lblMouldCode.ClientID%>").text(mouldCode);
            $("#<%=this.lblScrapBy.ClientID%>").text('<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().EmployeeCName%>');
        });
        /*保存数据*/
        function Save() {
            var sltScrapType = $.trim($("#sltScrapType").val());
            var hidEquipmentId = $.trim($("#<%=this.hidEquipmentId.ClientID%>").val());
            var txtRemark = $.trim($("#<%=this.txtRemark.ClientID%>").val());
            var txtCreateBy = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().EmployeeCName%>';
            var departmentId = $("#<%=this.HiddDep.ClientID%>").val();
            var personInCharge = $("#<%=this.txtPersonInCharge.ClientID%>").val()
            if (sltScrapType == "") {
                alert("请您选择报废类型!");
                return false;
            }
        /*表单验证*/
        /*如需表单验证可以此处处理验证 开始*/
        var entity = {};
        entity.Id = -1;
        entity.MouldId = mouldId;
        entity.EquipmentId = hidEquipmentId;
        entity.ScrapType = sltScrapType;
        entity.Remark = txtRemark;
        entity.CreateBy = txtCreateBy;
        entity.DepartmentId = departmentId;
        entity.PersonInCharge = personInCharge;

        var ajax = SKT.LeanMES.Web.Equipment.MouldScrap.MouldScrapEn(entity);
        if (ajax.error != null) {
            alert(ajax.error.Message);
            return false;
        }
        alert('<%=Resources.Messages.SaveInSuccess%>');
            parent.window.UpdateList(mouldCode);
        
      }

        var chooseFlag = -1;
         function selectEquipmentName() {
             chooseFlag = 1;
             var condition = "";
             dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=54&SearchCondition=" + condition + "&Multiple=false&rnd=" + Math.random(), width: 420, height: 300 });

         }

          /*责任部门*/
        function selectDep() {
            chooseFlag = 2;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=13&Multiple=false&rnd=" + Math.random(), width: 500, height: 300 });
        }

           function getChooseValue(list) {
               if (chooseFlag == 1) {
                $("#<%=this.txtEquipmentName.ClientID %>").val(list[0][1]);
                $("#<%=this.hidEquipmentId.ClientID %>").val(list[0][0]);
            }
            else  if (chooseFlag == 2) {
                $("#<%=this.txtDep.ClientID %>").val(list[0][2]);
                $("#<%=this.HiddDep.ClientID %>").val(list[0][0]);
            } 
        }
       
          
    </script>

</asp:Content>
