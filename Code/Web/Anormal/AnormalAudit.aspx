<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="AnormalAudit.aspx.cs" Inherits="SKT.LeanMES.Web.Anormal.AnormalAudit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <div class="wrap_tb">
        <ul class="tb">
            <li class="current">异常信息</li>
            <li id="audittab">审核备注</li>
        </ul>
         <div class="tb_c" id="userInfo_tb">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">工单号码</td>
            <td class="Field2">
                <asp:Label ID="txtOrderNo" runat="server"></asp:Label>
                <asp:HiddenField ID="hdnOrderId" runat="server" Value="-1" ClientIDMode="Static" />
            </td>
            <td class="Label2">产品编码</td>
            <td class="Field2">
                 <asp:Label ID="txtItemCode" runat="server"></asp:Label>
                <asp:HiddenField ID="hdnItemId" runat="server" Value="-1" ClientIDMode="Static" />
            </td>
        </tr>
        <tr>
            <td class="Label2">线别</td>
            <td class="Field2">
                <asp:Label ID="txtLineName" runat="server"></asp:Label>
                <asp:HiddenField ID="hdnLineId" runat="server" Value="-1" ClientIDMode="Static" />
            </td>
            <td class="Label2">班次</td>
            <td class="Field2">
                <asp:Label ID="lblShift" runat="server"></asp:Label>
                <asp:DropDownList ID="ddlShift" runat="server">
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="Label2">工位</td>
            <td class="Field2" colspan="3">
                <asp:Label ID="txtStation" runat="server"></asp:Label>
                <asp:HiddenField ID="hdnStationId" runat="server" Value="-1" ClientIDMode="Static" />
            </td>
        </tr>
        <tr>
            <td class="Label2">部门</td>
            <td class="Field2">
                <asp:Label ID="txtDeptName" runat="server"></asp:Label>
               <asp:HiddenField ID="hdnDeptId" runat="server" Value="-1" ClientIDMode="Static" />
            </td>
            <td class="Label2">异常负责人</td>
            <td class="Field2">
                <asp:Label ID="txtAnormalOwner" runat="server"></asp:Label>
                <asp:HiddenField ID="hdnAnormalOwnerId" runat="server" Value="-1" ClientIDMode="Static" />
            </td>
        </tr>
        <tr>
            <td class="Label2">异常时长</td>
            <td class="Field2">
                <asp:Label ID="txtAnormalTime" runat="server"></asp:Label><asp:Label ID="lblUnit" runat="server"></asp:Label>
                <asp:DropDownList ID="ddlUnit" runat="server" ToolTip="异常时长单位">
                    <asp:ListItem Value="分" Text="分"></asp:ListItem>
                    <asp:ListItem Value="时" Text="时"></asp:ListItem>
                    <asp:ListItem Value="天" Text="天"></asp:ListItem>
                    <asp:ListItem Value="周" Text="周"></asp:ListItem>
                    <asp:ListItem Value="月" Text="月"></asp:ListItem>
                </asp:DropDownList>
            </td>
            <td class="Label2">影响人数</td>
            <td class="Field2">
                <asp:Label ID="txtEffectPerson" runat="server"/>
            </td>
        </tr>
        <tr>
            <td class="Label2">是否停线</td>
            <td class="Field2" colspan="3">
                <asp:CheckBox ID="ckbIsLineStop" runat="server"/><span>已停线</span>
            </td>
        </tr>
        <tr>
            <td class="Label2">异常描述</td>
            <td class="Field2" colspan="3">
                 <asp:Label ID="txtAnormalDesc" runat="server"/>
            </td>
        </tr>
        <tr>
            <td class="Label2">异常类型</td>
            <td class="Field2">
                <asp:Label ID="lblAnormalType" runat="server"/>
                <asp:DropDownList ID="ddlAnormalType" runat="server"></asp:DropDownList>
            </td>
            <td class="Label2">异常名称</td>
            <td class="Field2">
                <asp:Label ID="lblAnormal" runat="server"/>
                <select id="selAnormal"></select>
                <asp:HiddenField ID="hdnAnormalId" runat="server" Value="-1" ClientIDMode="Static" />
            </td>
        </tr>
        <tr>
            <td class="Label2">异常处理人</td>
            <td class="Field2" colspan="3">
                <asp:Label ID="txtActionPerson" runat="server"/>
            </td>
        </tr>
        <tr>
            <td class="Label2">异常处理<br/>方案</td>
            <td class="Field2" colspan="3">
                <asp:Label ID="txtAnormalSolution" runat="server"/>
            </td>
        </tr>
        <tr>
            <td class="Label2">RCCA报告</td>
            <td class="Field2" colspan="3">
                <asp:Label ID="lblRCCAPath" runat="server"></asp:Label>  
            </td>
        </tr>
    </table>
             </div>
         <div id="userRole_tb">
                <div class="divHeader">备注</div>
             <table class="EditeContentTable" width="100%">
                 <tr>
                    
                     <td class="Field1" colspan="2">
                         <asp:TextBox ID="txtAuditRemark" runat="server" TextMode="MultiLine" CssClass="TextArea" Width="95%"></asp:TextBox>
                     </td>
                 </tr>
             </table>
         </div>
        </div>
    <asp:HiddenField ID="anormalObject" runat="server" Value=""/>
    <script type="text/javascript">
        var id = '<%=Request.QueryString["ID"]%>';
        $(function () {
             var anormalTypeId = $("#<%=this.ddlAnormalType.ClientID%>").val();
                GetAnormalTypeList(anormalTypeId);
            try {
                var anormalObject = $("#<%=this.anormalObject.ClientID%>").val();
                var obj = jQuery.parseJSON(anormalObject);
                if (obj != null) {
                    $('#<%=this.txtOrderNo.ClientID%>').text(obj.order);
                    $('#<%=this.hdnOrderId.ClientID%>').val(obj.orderid);
                    $('#<%=this.txtItemCode.ClientID%>').text(obj.itemcode);
                    $('#<%=this.hdnItemId.ClientID%>').val(obj.itemid);
                    $('#selAnormal').val(obj.anormalid);
                }
            }
            catch (ex) { alert(ex);}
            var ckbIsLineStop = $("#<%=this.ckbIsLineStop.ClientID%>");
            if (!ckbIsLineStop[0].checked) {
                ckbIsLineStop.next().html("未停线");
            }
            else {
                ckbIsLineStop.next().css("color", "red");
            }
            ckbIsLineStop.hide();
            
             
            $("#<%=this.lblShift.ClientID%>").text($("#<%=this.ddlShift.ClientID%>").find("option:selected").text());
            $("#<%=this.lblUnit.ClientID%>").text($("#<%=this.ddlUnit.ClientID%>").find("option:selected").text());
            $("#<%=this.lblAnormalType.ClientID%>").text($("#<%=this.ddlAnormalType.ClientID%>").find("option:selected").text());
            $("#<%=this.lblAnormal.ClientID%>").text($("#selAnormal").find("option:selected").text());

            $("#<%=this.ddlShift.ClientID%>,#<%=this.ddlUnit.ClientID%>,#<%=this.ddlAnormalType.ClientID%>,#selAnormal").hide();
               
            
        });

        function GetAnormalTypeList(id) {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxProdAnormal.GetAnormalList(id);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var list = ajax.value;
            var selAnormal = "";
            for (var i = 0, j = list.length; i < j; i++) {
                selAnormal += "<option value='" + list[i].AnormalTypeId + "'>" + list[i].AnormalTypeName + "</option>";
            }
            $("#selAnormal").html(selAnormal);
        }

        function Audit()
        {
            var txtAuditRemark = $("#<%=this.txtAuditRemark.ClientID%>").val();
            if (txtAuditRemark == "") {
                if (confirm("确定不填写任何备注直接审核吗？")) {
                    SaveAuditData(txtAuditRemark);
                }
                else {
                    $("#audittab").click();
                    $("#<%=this.txtAuditRemark.ClientID%>").focus();
                }
            }
            else {
                if (confirm("是否确定审核？")) {
                    SaveAuditData(txtAuditRemark);
                }
            }
        }

        function SaveAuditData(remark)
        {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxProdAnormal.AuditAnormal(id, remark);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            if (confirm("审核成功，是否关闭窗口？"))
            {
                parent.refresh();
            }
        }
    </script>
</asp:Content>
