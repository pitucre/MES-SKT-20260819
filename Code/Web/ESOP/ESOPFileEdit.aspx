<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="True"
    CodeBehind="ESOPFileEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Product.ESOPFileEdit" Title="Edit BomComponent" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
<div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %></div>
    <table class="EditeContentTable" width="100%">

        <tr>
            <td class="Label1">
                <%=Resources.lang.ItemsName %><em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtItem" runat="server" CssClass="TextBox" Enabled="false" IsRequired='1'></asp:TextBox><input
                    type="button" id="btnSelectItem" class="ButtonBox" value="..." title="<%=Resources.lang.ChooseItem %>"
                    onclick="selectItem(1);" />
                <asp:HiddenField ID="hdnItemId" runat="server" Value="-1" />
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%=Resources.lang.AC_Operation%><em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtAssOperationName" runat="server" CssClass="TextBox" Enabled="false"></asp:TextBox><input
                    type="button" id="Button1" class="ButtonBox" value="..." title="<%=Resources.lang.ChooseOperation %>" onclick="selectItem(8);" />
                <asp:HiddenField ID="hdnAssOperationID" runat="server" Value="-1" />
            </td>
        </tr>
        
         <tr>
            <td class="Label1">
               <%=Resources.lang.File %><em>*</em>
            </td>
            <td class="Field1"> 
            <asp:FileUpload ID="flupload" runat="server" 
                         />
            </td>
        </tr>
         <tr>
            <td >
            </td>
            <td class="Field1">
                <asp:Button ID="btnUpload" runat="server" Text="<%$Resources:lang, Upload%>" 
                        onclick="btnUpload_Click"  style=" height:26px; width:60px; cursor:pointer;"/>
 <asp:Label ID="lblMessage" runat="server" Text="" ForeColor="Red" Font-Size="12px"  CssClass="message"></asp:Label>
              
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        $(function () {
            $("#<%=this.btnUpload.ClientID %>").click(function () {

                if ($("#<%=this.hdnItemId.ClientID %>").val() == "-1") {
                    $("#<%=this.lblMessage.ClientID %>").text("请选择产品！");
                    return false;
                }
                if ($("#<%=this.hdnAssOperationID.ClientID %>").val() == "-1") {
                    $("#<%=this.lblMessage.ClientID %>").text("请选择工位！");
                    return false;
                }

                var fileName = $("#<%=this.flupload.ClientID %>").val();
                if (fileName == "") {
                    $("#<%=this.lblMessage.ClientID %>").text("请选择要上传的文件！");
                    return false;
                }
                var fileExt = fileName.substring(fileName.lastIndexOf(".") + 1);
                $("#<%=this.lblMessage.ClientID %>").text("请稍后，文件正在上传...");
                return true;
            });
        });

        var chooseFlag = 0;

        function selectItem(i) {
            chooseFlag = i;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=" + i.toString() + "&Multiple=false&rnd=" + Math.random(), width: 550, height: 280 });
        }

        function getChooseValue(list) {
            if (chooseFlag == 2) {
            }
            else if (chooseFlag == 1) {
                $("#<%=this.txtItem.ClientID %>").val(list[0][1] + "(" + list[0][2] + ")");
                $("#<%=this.hdnItemId.ClientID %>").val(list[0][0]);
            }
            else if (chooseFlag == 8) {
                $("#<%=this.txtAssOperationName.ClientID %>").val(list[0][1] + "(" + list[0][2] + ")");
                $("#<%=this.hdnAssOperationID.ClientID %>").val(list[0][0]);
            }
        }

        function Save() {
            $("#<%=this.btnUpload.ClientID %>").click();
        }

    </script>
</asp:Content>
