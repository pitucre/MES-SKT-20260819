<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="DetectionItemEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Detection.DetectionItemEdit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server"> 
    
    <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %></div>
    <table width="100%" class="EditeContentTable">       
        <tr>
            <td class="Label2">检测项编码<em>*</em></td>
            <td class="Field2">
                <asp:TextBox ID="txtDetectionCode" runat="server" CssClass="TextBox"  MaxLength="50" IsRequired="1" ></asp:TextBox>
            </td>
            <td class="Label2">检测项名称<em>*</em></td>
            <td class="Field2">
                <asp:TextBox ID="txtDetectionName" runat="server" CssClass="TextBox"  MaxLength="50" IsRequired="1"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">检测项描述</td>
            <td class="Field2" colspan="3" >
                <asp:TextBox ID="txtDetectionDesc" runat="server" CssClass="TextBox"  MaxLength="200" width="90%"></asp:TextBox>
            </td>
            
        </tr>
        <tr>
            <td class="Label2">工序</td>
            <td class="Field2">
                  <asp:TextBox ID="txtStation" runat="server" CssClass="TextBox" Enabled="false"  ClientIDMode="Static"></asp:TextBox><input
                    type="button" id="Button2" class="ButtonBox" value="..." title="<%=Resources.lang.ChooseItem %>"
                    onclick="selectItem(8);" />    
                   <asp:HiddenField ID="hdnStationId" runat="server" Value="-1" />   
            </td>    
            <td class="Label2">版本</td>
            <td class="Field2">
                <asp:TextBox ID="txtVersions" runat="server" CssClass="TextBox"  MaxLength="10"></asp:TextBox>
            </td>
                   
        </tr>
        <tr>
            <td class="Label2">SL</td>
            <td class="Field2">
                <asp:TextBox ID="txtSL" runat="server" CssClass="TextBox" ></asp:TextBox>
            </td>
            <td class="Label2">USL</td>
            <td class="Field2">
                <asp:TextBox ID="txtUSL" runat="server" CssClass="TextBox" ></asp:TextBox>
            </td>           
        </tr>
        <tr>
            <td class="Label2">LSL</td>
            <td class="Field2">
                <asp:TextBox ID="txtLSL" runat="server" CssClass="TextBox" ></asp:TextBox>
            </td>
            <td class="Label2">CL</td>
            <td class="Field2">
                <asp:TextBox ID="txtCL" runat="server" CssClass="TextBox" ></asp:TextBox>
            </td>
            
        </tr>
        <tr>
            <td class="Label2">UCL</td>
            <td class="Field2">
                <asp:TextBox ID="txtUCL" runat="server" CssClass="TextBox" ></asp:TextBox>
            </td>
            <td class="Label2">LCL</td>
            <td class="Field2">
                <asp:TextBox ID="txtLCL" runat="server" CssClass="TextBox" ></asp:TextBox>
            </td>             
        </tr>
       
    </table>

    <script type="text/javascript">

        $().ready(function () {
            $("#txtSL,#txtUSL,#txtLSL,#txtCL,#txtUCL,#txtLCL").bind("keyup", function () {
                getDecimalVal(this);
            });
        });

        var detectionItemId = '<%=Request.QueryString["ID"]%>';

         function selectItem(i) {
            chooseFlag = i;
            var pageCondition = "";
            
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=" + i.toString() + "&PageCondition=" + escape(pageCondition) + "&Multiple=false&rnd=" + Math.random(), width: 650, height: 350 });
        }

        function getChooseValue(list) {
            if (chooseFlag == 8) {
                $("#<%=this.txtStation.ClientID %>").val(list[0][1]);
                $("#<%=this.hdnStationId.ClientID %>").val(list[0][0]);
            }      
        }

        /*保存数据*/
        function Save() {
            var txtDetectionCode = $.trim($("#<%=this.txtDetectionCode.ClientID%>").val());
            var txtDetectionName = $.trim($("#<%=this.txtDetectionName.ClientID%>").val());
            var txtDetectionDesc = $.trim($("#<%=this.txtDetectionDesc.ClientID%>").val());
            var txtVersions = $.trim($("#<%=this.txtVersions.ClientID%>").val());
            var txtStationId = $("#<%=this.hdnStationId.ClientID%>").val();
            var txtSL = $("#<%=this.txtSL.ClientID%>").val();
            var txtUSL = $("#<%=this.txtUSL.ClientID%>").val();
            var txtLSL = $("#<%=this.txtLSL.ClientID%>").val();
            var txtCL = $("#<%=this.txtCL.ClientID%>").val();
            var txtUCL = $("#<%=this.txtUCL.ClientID%>").val();
            var txtLCL = $("#<%=this.txtLCL.ClientID%>").val();
            var txtCreateBy = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';           
            var txtModifyBy = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';  

        /*表单验证*/
        /*如需表单验证可以此处处理验证 开始*/


        var entity = {};

        entity.DetectionItemId = detectionItemId
        entity.DetectionCode = txtDetectionCode;
        entity.DetectionName = txtDetectionName;
        entity.DetectionDesc = txtDetectionDesc;
        entity.Versions = txtVersions;
        entity.StationId = txtStationId;
        entity.SL = parseFloat(txtSL);
        entity.USL = parseFloat(txtUSL);
        entity.LSL = parseFloat(txtLSL);
        entity.CL = parseFloat(txtCL);
        entity.UCL = parseFloat(txtUCL);
        entity.LCL = parseFloat(txtLCL);
        entity.CreateBy = txtCreateBy;        
        entity.ModifyBy = txtModifyBy;        

        var ajax = SKT.LeanMES.Web.AjaxServices.AjaxDetectionItem.DetectionItemEdit(entity);
        if (ajax.error != null) {
            alert(ajax.error.Message);
            return false;
        }
        alert('<%=Resources.Messages.SaveInSuccess%>')
        parent.window.Refresh();
    }
    </script>

</asp:Content>
