<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/EditMaster.master" CodeBehind="SupplierExameContentEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Warehouse.SupplierExameContentEdit" %>


<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <div class="infoTips">
        带<em>*</em>为必填项
    </div>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">父节点
            </td>
            <td class="Field2">
                <%=parentName%>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                考核内容<em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtSupplierExameName" runat="server" CssClass="TextBox" IsRequired='1' Width="260"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">考核方式
            </td>
            <td class="Field2">
                <asp:DropDownList runat="server" ID="ddlSupplierExameType"  ClientIDMode="Static" onchange="supplierExameTypeChange(this)" >
                    <asp:ListItem Value="1">自动计算</asp:ListItem>
                    <asp:ListItem Value="2">手工计算</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr id="trSupplierExameCompute">
            <td class="Label2">
                计算方式<em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtSupplierExameCompute" runat="server" CssClass="TextBox" IsRequired='1' Width="260" onchange="CheckProc()" placeholder="存储过程" ToolTip="存储过程"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%=Resources.lang.Description%>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtDescription" runat="server" CssClass="TextBox" Width="260"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">
               状态
            </td>
            <td class="Field2">
                <asp:HiddenField ID="txtSupplierExameContentId" runat="server" />
                <asp:HiddenField ID="txtHideCreater" runat="server" />
                <asp:DropDownList runat="server" ID="ddlIsEnable">
                    <asp:ListItem>启用</asp:ListItem>
                    <asp:ListItem>禁用</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="Label2">排序
            </td>
            <td class="Field2">
                <asp:TextBox ID="Sorting" runat="server" CssClass="TextBox" Text="0" IsRequired='1' IsNumber='1' Width="137"></asp:TextBox>
            </td>

        </tr>
    </table>

    <script language="javascript" type="text/javascript">
        var ReqId = '<%=Request.QueryString["ID"] %>';
        var ParentId = '<%=parentId %>';
        $("select").css("width", "140px");

        $(function () {
            //
            supplierExameTypeChange($("#<%=this.ddlSupplierExameType.ClientID %>"));
        });

        /*保存数据*/
        function Save() {
            var entity = {};
            entity.SupplierExameContentId = ReqId;
            entity.ParentId = ParentId;
            entity.SupplierExameName = $.trim($("#<%=this.txtSupplierExameName.ClientID %>").val());
            entity.SupplierExameType = $("#<%=this.ddlSupplierExameType.ClientID %>").val();
            entity.SupplierExameCompute = entity.SupplierExameType == "1" ? $.trim($("#<%=this.txtSupplierExameCompute.ClientID %>").val()) : "";
            entity.Creater = $("#<%=this.txtHideCreater.ClientID %>").val();
            entity.Description = $.trim($("#<%=this.txtDescription.ClientID %>").val());
            entity.IsEnable = $("#<%=this.ddlIsEnable.ClientID %>").val() == '启用' ? true : false;
            entity.Sorting = $("#<%=this.Sorting.ClientID %>").val();
           
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSupplierExame.SupplierExameContentEdit(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert('<%=Resources.Messages.SaveInSuccess %>');
            parent.window.UpdateList();
            return ajax;
        }

        function CheckProc() {
            var SupplierExameCompute = $.trim($("#<%=this.txtSupplierExameCompute.ClientID %>").val());
            if (SupplierExameCompute == "" || $("#<%=this.ddlSupplierExameType.ClientID %>").val() == "2") {
                return false;
            }
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSupplierExame.CheckSupplierExameCompute(SupplierExameCompute);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                 $("#<%=this.txtSupplierExameCompute.ClientID %>").val("");
                return false;
            }           
        }

        function supplierExameTypeChange(element) {
            var selectedValue = $(element).find("option:selected").val();
            if (selectedValue == "1") {
                $("#trSupplierExameCompute").show();
                $("#<%=this.txtSupplierExameCompute.ClientID %>").attr("isrequired", "1");
            }
            else {
                $("#trSupplierExameCompute").hide();
                $("#<%=this.txtSupplierExameCompute.ClientID %>").attr("isrequired", "0");
            }
        }
    </script>
</asp:Content>
