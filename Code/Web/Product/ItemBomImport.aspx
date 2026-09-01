<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    EnableEventValidation="false" CodeBehind="ItemBomImport.aspx.cs" Inherits="SKT.LeanMES.Web.Product.ItemBomImport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %></div>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">
                <%= Resources.lang.ItemCode %><em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtItemCode" runat="server" CssClass="TextBox" IsRequired='1' ReadOnly="true"
                    ClientIDMode="Static"></asp:TextBox><input type="button" id="btnSelectItem" class="ButtonBox" value="..." title="Select"
                    onclick="openChoosePage(1);" />
                <asp:HiddenField ID="hdnItemId" runat="server" Value="-1" ClientIDMode="Static" />
                <asp:HiddenField ID="hdnItemCode" runat="server" Value="" ClientIDMode="Static" />
            </td>
            <td class="Label2">
                <%=Resources.lang.ItemsName %>
            </td>
            <td class="Field2">
                <asp:Label ID="lblItemName" runat="server" Text="" ClientIDMode="Static"></asp:Label>
                <asp:HiddenField ID="hdnItemName" runat="server" Value="" ClientIDMode="Static" />
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%=Resources.lang.Revision%><em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtVersion" runat="server" CssClass="NumericBox50" Text="1.0" IsRequired='1'
                    MaxLength='20' ClientIDMode="Static"></asp:TextBox>
                <asp:CheckBox ID="ckbIsCurrentRev" runat="server" Text="<%$Resources:lang,AsCurrentRevision %>"
                    Checked="true" ClientIDMode="Static" />
            </td>
            <td class="Label2">
                <%--  <%=Resources.lang.CurrentRevision %> --%>
                <%=Resources.lang.Status %>
            </td>
            <td class="Field2">
                <asp:DropDownList ID="ddlStatus" runat="server" ClientIDMode="Static">
                    <asp:ListItem Value="1">在用</asp:ListItem>
                    <asp:ListItem Value="0">停用</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%=Resources.lang.Description %>
            </td>
            <td class="Field2" colspan="3">
                <asp:TextBox ID="txtBomDesc" runat="server" CssClass="TextArea" MaxLength='200' ClientIDMode="Static"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                目标路径<em>*</em>
            </td>
            <td class="Field2" colspan="3">
                <asp:FileUpload ID="fileBomUrl" ClientIDMode="Static" runat="server" onchange="uploadFile(this.value)" />
                <asp:Button ID="btnUpload" runat="server" OnClick="Upload_Click" ClientIDMode="Static"
                    Style="display: none;" />
                <%-- <asp:Button ID="btnView" runat="server" ClientIDMode="Static" OnClick="btnView_Click" 
                    Text=" 预 览 " />  --%>
            </td>
        </tr>
    </table>
    <asp:GridView ID="GridView1" runat="server" Width="100%" OnRowDataBound="GridView1_RowDataBound">
        <Columns>
            <asp:TemplateField HeaderText="ID" Visible="true"></asp:TemplateField>
        </Columns>
    </asp:GridView>
    <asp:HiddenField ID="hdnBomId" runat="server" Value="-1" />
    <script type="text/javascript">
        var bomName = "";

        function Save() {


            var bomId = $("#<%=this.hdnBomId.ClientID %>").val();
            bomName = $("#txtItemCode").val() + "-" + $("#txtVersion").val();
            var txtItemName = $("#lblItemName").html();
            var txtItemCode = $("#txtItemCode").val();
            var itemId = $("#hdnItemId").val();
            var txtVersion = $("#<%=this.txtVersion.ClientID %>").val();
            var ddlStatus = $("#<%=this.ddlStatus.ClientID %>").val();
            var ckbIsCurrentRev = ($("#<%=this.ckbIsCurrentRev.ClientID%>").is(":checked"));
            var txtBomDesc = $("#<%=this.txtBomDesc.ClientID %>").val();
            var bomChildJosn = '<%=bomChildJson %>';

            if (txtItemCode == "" || txtVersion == "") {
                alert("带*号不可为空！");
                return false;
            }
                        
            if (bomChildJosn == "") {
                alert("请选择目标路径上传产品BOM！");
                return;
            }

            var entity = {};
            entity.OrganizationCode = "";
            entity.ItemBomId = bomId;
            entity.BomName = bomName;
            entity.ItemId = itemId;
            entity.ItemName = txtItemName;
            entity.ItemCode = txtItemCode;
            entity.Version = txtVersion;
            entity.State = ddlStatus;
            entity.Source = 2; //1、ERP下载 2、MES导入 3、MES创建
            entity.IsCurrentVer = ckbIsCurrentRev;
            entity.Description = txtBomDesc;
            entity.Default_4 = bomChildJosn;
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxProduct.ItemBomImport(entity);

            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
                   
            alert("<%=Resources.Messages.SaveInSuccess %>");
            parent.window.UpdateList(bomName);

        }
  
        function Download() {
            var filePath = '<%=SKT.LeanMES.Web.WebHelper.ExcelTemplateRoot+"产品BOM标准模板.xls" %>';
            return window.open(filePath);
        }

        function openChoosePage(flags) {
            var condition = "";
            flag = flags;
            dialog({
                title: "<%= Resources.Common.ChooseWindow %>",
                src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=" +
                flags +
                "&Multiple=false&SearchCondition=" +
                condition +
                "&rnd=" +
                Math.random(),
                width: 600,
                height: 300
            });
        }

        function getChooseValue(list) {
            if (flag == 1) {
                $("#txtItemCode,#hdnItemCode").val(list[0][2]);
                $("#hdnItemName").val(list[0][1]);
                $("#lblItemName").html(list[0][1]);
                $("#hdnItemId").val(list[0][0]);
            }
        }

        function uploadFile(filePath) {
            if (filePath.length > 0) {
                $("#btnUpload").click();
            }
        }
 
    </script>
</asp:Content>
