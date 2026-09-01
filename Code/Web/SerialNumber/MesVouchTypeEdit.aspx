<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="True"
    CodeBehind="MesVouchTypeEdit.aspx.cs" Inherits="SKT.LeanMES.Web.SerialNumber.MesVouchTypeEdit" Title="Edit MesVouchType" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <div class="Label" style="margin-top: -5px; !margin-top: -25px;">
        <%=Resources.Messages.WithAsteriskIsRequired %></div>
    <table width="100%" class="EditeContentTable">
      
        <tr>
            <td class="Label1">
               单据名称
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtTypeName" CssClass="TextBox" runat="server" Enabled="false" IsRequired ='1'></asp:TextBox>
                 <input type="button" id="btnSelectPageName" class="ButtonBox" value="..." onclick="selectChoosePage()"/>
                 <em>*</em>
                <asp:HiddenField ID="hdnFrmTypeValue" runat="server" Value="" />
                <asp:HiddenField ID="hdnFrmTypeName" runat="server" Value="" />
            </td>
        </tr>
        <tr>
            <td class="Label1">
                编码规则
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtCodingRule" CssClass="TextBox" Enabled="false" runat="server"></asp:TextBox>
                <input type="button" id="btnSelecCodingRule" class="ButtonBox" value="..." onclick="selectCodingRule()" />
                <asp:HiddenField ID="hdnSelectCodingRuleId" runat="server" Value="-1" />
            </td>
        </tr>
        <tr>
            <td class="Label1">
              批号规则
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtRuleName" CssClass="TextBox" Enabled="false" runat="server"></asp:TextBox>
                <input type="button" id="btnSelecRuleName" class="ButtonBox" value="..." onclick="selectRuleName()" />
                <asp:HiddenField ID="hdnSelectRuleNameId" runat="server" Value="-1" />
            </td>
        </tr>
        <tr>
            <td class="Label1">
                包装规则
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtPackRuleName" CssClass="TextBox" Enabled="false" runat="server"></asp:TextBox>
                <input type="button" id="btnSelectPackName" class="ButtonBox" value="..." onclick="selectPackName()" />
                <asp:HiddenField ID="hdnSelectPackNameId" runat="server" Value="-1" />
            </td>
        </tr>
         <tr>
            <td class="Label1">
                备注
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtDesc" runat="server" CssClass="TextArea" MaxLength="100" TextMode ="MultiLine"></asp:TextBox>
               
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        var vouchTypeId = '<%=Request.QueryString["ID"] %>';
        var temp = 0;
        var SearchCondition = " ApplyType='3' ";
        var hdnFrmTypeName = "";   //单据名称
        var pageName = "";

      
        /*保存数据*/
        function Save() {
            var strError = "";


            var txtTypeName = $("#<%=this.txtTypeName.ClientID %>").val();
            var hdnFrmTypeName = $("#<%=this.hdnFrmTypeName.ClientID %>").val();

         
            var txtCodingRule = $("#<%=this.txtCodingRule.ClientID %>").val();
            var hdnSelectCodingRuleId = $("#<%=this.hdnSelectCodingRuleId.ClientID %>").val();


            var txtRuleName = $("#<%=this.txtRuleName.ClientID %>").val();
            var hdnSelectRuleNameId = $("#<%=this.hdnSelectRuleNameId.ClientID %>").val();
            var hdnSelectPackNameId = $("#<%=this.hdnSelectPackNameId.ClientID %>").val();
            var txtDesc = $("#<%=this.txtDesc.ClientID %>").val();
            //  alert(ddlSupClass + "\n" + txtTypeName + "\n" + hdnFrmTypeName);
            //验证类型编码
            if (isNull(txtTypeName)) {
                strError += "<%=Resources.lang.VouchTypeName + Resources.Messages.wmsIsNotNull %>\n";
            }
            if (checkStrLen(txtTypeName, 20, false)) {
                strError += "<%=Resources.lang.VouchTypeName + Resources.Messages.WMSLenNoMoreThan %>20<%=Resources.Messages.WMSChars%>\n";
            }

            if (!isNull(strError)) {
                alert(strError.toString());
                return false;
            }
            var entity = {};
            entity.MesVouchTypeId = vouchTypeId;
            entity.VouchName = hdnFrmTypeName;
            entity.PageName = "";
            entity.VouchENName = "";
            entity.MTableName = "";
            entity.CTableName = "";
            entity.EncodeRule = hdnSelectCodingRuleId;
            entity.RuleName = hdnSelectRuleNameId;
            entity.PackRule = hdnSelectPackNameId;
            entity.Remark = txtDesc;

            var ajax_vouchTypeEdit = SKT.LeanMES.Web.AjaxServices.AjaxSerialNumber.EditVouchType(entity);
            if (ajax_vouchTypeEdit.error != null) {
                alert(ajax_vouchTypeEdit.error.Message);
                return false;
            }

            alert('<%=Resources.Messages.SaveInSuccess %>');
            window.parent.UpdateList(txtTypeName);
        }

        function selectChoosePage() {
            temp = 1;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=17&Multiple=false&rnd=" + Math.random(), width: 600, height: 300 });
        }
        //选择编码规则
        function selectCodingRule() {
            SearchCondition = " Apply_Type ='编码规则'  and Type_Value ='" + hdnFrmTypeName + "'";
            temp = 2;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=18&SearchCondition=" + SearchCondition + "&Multiple=false&rnd=" + Math.random(), width: 600, height: 400 });
        }

        //批号规则
        function selectRuleName() {
            SearchCondition = " Apply_Type ='批号规则'  and Type_Value ='" + hdnFrmTypeName + "'";
            temp = 3;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=18&SearchCondition=" + SearchCondition + "&Multiple=false&rnd=" + Math.random(), width: 600, height: 400 });
        }
        //包装条码规则
        function selectPackName() {
            SearchCondition = " Apply_Type ='包装规则' and Type_Value ='" + hdnFrmTypeName + "'";
            temp = 4;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=18&SearchCondition=" + SearchCondition + "&Multiple=false&rnd=" + Math.random(), width: 600, height: 400 });
        }
       
        function getChooseValue(list) {
            switch (temp) {
                case 1:
                    $("#<%=this.txtTypeName.ClientID %>").val(list[0][1]);
                    $("#<%=this.hdnFrmTypeName.ClientID %>").val(list[0][1]);
                    $("#<%=this.hdnFrmTypeValue.ClientID %>").val(list[0][0]);
                    hdnFrmTypeName = $("#<%=this.txtTypeName.ClientID %>").val();
                    break;
                case 2:
                    $("#<%=this.txtCodingRule.ClientID %>").val(list[0][3]+list[0][4]);
                    $("#<%=this.hdnSelectCodingRuleId.ClientID %>").val(list[0][0]);
                    break;
                case 3:
                    $("#<%=this.txtRuleName.ClientID %>").val(list[0][3]+list[0][4]);
                    $("#<%=this.hdnSelectRuleNameId.ClientID %>").val(list[0][0]);
                    break;
                case 4:
                    $("#<%=this.txtPackRuleName.ClientID %>").val(list[0][3]+list[0][4]);
                    $("#<%=this.hdnSelectPackNameId.ClientID %>").val(list[0][0]);
                    break;
                default:
                    temp = 0;
                    break;
            }
            temp = 0;
        }

    </script>
</asp:Content>
