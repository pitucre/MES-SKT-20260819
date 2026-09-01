<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GlobarParameterEdit.aspx.cs"
    Inherits="SKT.LeanMES.Web.SystemConfiguration.GlobarParameterEdit" MasterPageFile="~/Masters/EditMaster.master"
    Title="" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <table width="100%" class="EditeContentTable">
        <tr>
            <td colspan="4" class="Label">
                <%=Resources.Messages.WithAsteriskIsRequired %>
            </td>
        </tr>
        <tr>
            <asp:HiddenField runat="server" ID="txtHideID" Value="-1" />
            <td class="Label2">
                编号<em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtParaType" runat="server" CssClass="TextBox" MaxLength="20" IsRequired="1" ReadOnly="true"></asp:TextBox>
            </td>
            <td class="Label2">
                <%=Resources.lang.ParaDescription %><em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtParaDescription" runat="server" CssClass="TextBox" MaxLength="50"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%=Resources.lang.ParaName %><em>*</em>
            </td>
            <td class="Field2" colspan="3">
                <asp:TextBox ID="txtParaName" runat="server" CssClass="TextBox" MaxLength="50"></asp:TextBox>
            </td>
           
        </tr>
        <tr>
         <td class="Label2">
                <%=Resources.lang.ParaValue %><em>*</em>
            </td>
            <td class="Field2"  colspan="3">
                <div id="showT">
                    <asp:TextBox ID="txtParaValue"  TextMode="MultiLine"  runat="server" CssClass="TextArea" MaxLength="1000" Visible="true"></asp:TextBox>
                </div>

             <select name="myselect"  id="myselect" style="width:202.5px;height:24px;font-size:12px;border:1px solid #CFCFCE; position:absolute; clip:rect(auto auto auto 181px); "onchange="document.getElementById('txtPlace').value=this.value;replaceValue2(this.value);" >
                <option value="">请选择</option>
                <option value="否"> 否 </option>
                <option value="是"> 是 </option>
            </select>
            <input name="txtPlace" id="txtPlace" style=" width:200px;font-size:12px;border:1px solid #CFCFCE;margin-top:3px;"  type="text"  onblur="replaceValue()"/>   
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        var globarParameterId = '<%=Request.QueryString["ID"]%>';        
        $(function () {
            $("#showT").hide();
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxServiceGlobarParameter.GetParaType(globarParameterId);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            //$("#txtParaType").val(ajax.value);
            $("#<%=this.txtParaType.ClientID%>").val(ajax.value);

            $("#txtParaType").focus(function () { this.select() });
            var txtParaValue = $("#<%=this.txtParaValue.ClientID%>").val().trim();
            if (isNumber(txtParaValue) == true) {
                $("#myselect").attr("disabled",true);
            }
            $("#txtPlace").val(txtParaValue);
        })
        //赋值 by liwen 2020.12.10
        function replaceValue() {
            var txtValue = $.trim($("#txtPlace").val());
            $("#<%=this.txtParaValue.ClientID%>").val(txtValue);
        }
        function replaceValue2(v) {
            if (v != "") {
                $("#<%=this.txtParaValue.ClientID%>").val(v);
            }
        }
        function isNumber(val) {
            var regPos = /^\d+(\.\d+)?$/; //非负浮点数
            var regNeg = /^(-(([0-9]+\.[0-9]*[1-9][0-9]*)|([0-9]*[1-9][0-9]*\.[0-9]+)|([0-9]*[1-9][0-9]*)))$/; //负浮点数
            if (regPos.test(val) && regNeg.test(val)) {
                return true;
            } else {
                return false;
            }

        }
        /*保存数据*/
        function Save() {
            var txtID = $("#<%=this.txtHideID.ClientID%>").val();
            var txtParaType = $("#<%=this.txtParaType.ClientID%>").val();
            var txtParaName = $("#<%=this.txtParaName.ClientID%>").val().trim();
            var txtParaValue = $("#<%=this.txtParaValue.ClientID%>").val().trim();
            var txtParaDescription = $("#<%=this.txtParaDescription.ClientID%>").val().trim();
            var txtCreateBy = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';
            /*表单验证*/
            var errStr = "";
            if (isNull(txtParaType)) {
                errStr += "编号不能为空\n";
            }
            if (isNull(txtParaName)) {
                errStr += "<%=Resources.Messages.ParaNameIsRequired %>\n";
            }
            if (isNull(txtParaDescription)) {
                errStr += "<%=Resources.Messages.ParaDescriptionIsRequired %>\n";
            }
            if (isNull(txtParaValue)) {
                errStr += "<%=Resources.Messages.ParaValueIsRequired %>\n";
            }

            if (!isNull(errStr)) {
                alert(errStr);
                return false;
            }

            var entity = {};
            entity.GlobarParameterId = globarParameterId;
            entity.ID = txtID;
            entity.ParaType = txtParaType;
            entity.ParaName = txtParaName;
            entity.ParaValue = txtParaValue;
            entity.Paraription = txtParaDescription;
            entity.CreateBy = txtCreateBy;

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxServiceGlobarParameter.GlobarParameterEdit(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            alert('<%=Resources.Messages.SaveInSuccess%>');
            parent.window.UpdateList('');
        }
    </script>
</asp:Content>
