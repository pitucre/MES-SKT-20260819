<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/EditMaster.master"
    CodeBehind="InspectionFileManageUpLoad.aspx.cs" Inherits="SKT.LeanMES.Web.Quality.InspectionFileManageUpLoad" %>



<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">

    <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %>
    </div>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">
                <%= Resources.lang.FielLoadPath %><em>*</em>
            </td>
            <td class="Label2" style="text-align: left">
                <asp:FileUpload ID="fuLoadingList" runat="server" onchange="uploadFile(this.value)" ClientIDMode="Static" />
                <asp:LinkButton ID="linkUploadFile" runat="server" OnClick="linkUploadFile_Click" ClientIDMode="Static"></asp:LinkButton>
                <asp:Label runat="server" ClientIDMode="Static" ID="lbFileReady" CssClass="redFont" ForeColor="Red">未载入</asp:Label>
                <asp:Label runat="server" ClientIDMode="Static" ID="Label1" CssClass="redFont" Visible="false">111</asp:Label>
            </td>
            <td class="Label2">产品编码<em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtitemcode" name="ModelName" runat="server" CssClass="TextBox"
                    IsRequired="1" Enabled="false" ClientIDMode="Static" Width="64%"></asp:TextBox><input type="button" id="btnSelectItems" onclick="selectItems(this);" class="ButtonBox" value="..." />
                <asp:HiddenField ID="HiddenField1" runat="server" Value="-1" ClientIDMode="Static" />
                <asp:HiddenField ID="HiddenField2" runat="server" Value="" ClientIDMode="Static" />
            </td>
        </tr>
        <tr>
            <td class="Label2">供应商<em>*</em>
            </td>
            <td class="Field2" colspan="1">
                <input type="hidden" value="-1" id="hdnItemId" />
                <input type="hidden" value="-1" id="hdnRowId" />
                <input type="text" id="txtsupplier" class="TextBox" disabled="disabled" value="" isrequired='1' /><input
                    type="button" id="supplier" class="ButtonBox" value="..." onclick="selectCustomer()" />
            </td>

        </tr>
        <tr>
        </tr>
        <tr class="clear5"></tr>
    </table>
    <asp:HiddenField ID="filepaths" runat="server" Value="-1" ClientIDMode="Static" />
    <script type="text/javascript">
        var userName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
        function Save() {
            var entity = {};
            var fileName = $('#<%= lbFileReady.ClientID %>').html();
            var itemCode = itemcode;
            var supplierCode = supplier;
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialIQC.InspectionFileSave( itemCode, supplierCode,fileName, userName);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert("载入成功");
            parent.document.forms[0].submit();
           // parent.location.reload();
            //parent.Closess();
        }
        function selectItems(obj) {
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=1&Multiple=false&rnd=" + Math.random(), width: 650, height: 300 });
        }
        function getChooseValue(list) {
            $("#txtitemcode").val(list[0][2]);
            itemcode = list[0][2];
        }
        function selectCustomer(obj) {
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=34&Multiple=false&CallBackFunc=getChooseValueCustomer&rnd=" + Math.random(), width: 650, height: 300 });
        }
        function getChooseValueCustomer(list) {
            $('#txtsupplier').val(list[0][2]);
            supplier = list[0][1];
        }
        function uploadFile(filePath) {
            if (filePath.length > 0) {
                var str = '';
                var postback = $('#<%= linkUploadFile.ClientID %>').attr('href');
                var funcStartIndex = postback.indexOf('\'');
                var funcEndIndex = postback.indexOf('\',');
                if (funcStartIndex != -1 && funcEndIndex != -1) {
                    var str = postback.substring(funcStartIndex + 1, funcEndIndex);

                    __doPostBack(str, '');
                } else {
                    return false;
                }
                //$("#linkUploadFile").click();
            }
        }
    </script>
</asp:Content>
