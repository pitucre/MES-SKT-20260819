<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="True"
    CodeBehind="MoldFixtureFileManageEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Equipment.MoldFixtureFileManageEdit" Title="Edit EquipmentFileManage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %>
    </div>
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label1"><%= Resources.lang.FileName %><em>*</em></td>
            <td class="Field1">
                <asp:FileUpload ID="fuLoadingList" runat="server" onchange="uploadFile(this.value)" ClientIDMode="Static" />
                <asp:LinkButton ID="linkUploadFile" runat="server" OnClick="linkUploadFile_Click" ClientIDMode="Static"></asp:LinkButton>
                <asp:Label runat="server" ClientIDMode="Static" ID="lbFileReady" CssClass="redFont" ForeColor="Red">未载入</asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label1"><%= Resources.lang.EquipmentCode %><em>*</em></td>
            <td class="Field1">
                <asp:TextBox ID="txtEqCode" runat="server" CssClass="TextBox" 
                    ReadOnly="true"></asp:TextBox><input type="button" id="btnEquipmentName" class="ButtonBox"
                        value="..." onclick="selectEquipmentName()" />
                <asp:HiddenField ID="HiddentxtEqCode" runat="server" Value="-1" />
            </td>
        </tr>
    </table>
    <asp:HiddenField ID="filepaths" runat="server" Value="-1" ClientIDMode="Static" />
    <script type="text/javascript">
        var equipmentFileManageId = '<%=Request.QueryString["ID"]%>';


        function selectEquipmentName() {
            if ($("#<%=this.lbFileReady.ClientID%>").html() == ""||$("#<%=this.lbFileReady.ClientID%>").html() == "未载入") {
                alert("请选择文件");
                return false;
            }
            <%--dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=54&Multiple=false&rnd=" + Math.random(), width: 650, height: 350 });--%>

            var searchCondition = "  EquipmentTypeId=-4";
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=701&SearchCondition=" + searchCondition + "&Multiple=true&rnd=" + Math.random(), width: 600, height: 400 });
        }
        function getChooseValue(list) {
            $("#<%=this.txtEqCode.ClientID%>").val(list[0][1]);
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
            }
        }



        /*保存数据*/
        function Save() {
            if ($("#<%=this.lbFileReady.ClientID%>").html() == ""||$("#<%=this.lbFileReady.ClientID%>").html() == "未载入"){
                alert("请选择文件");
                return false;
            }
            if ($("#<%=this.txtEqCode.ClientID%>").val()=="") {
                alert("请选择设备编码");
                return false;
            }
            var txtEqCode = $.trim($("#<%=this.txtEqCode.ClientID%>").val());
            var txtFileName = $("#<%=this.lbFileReady.ClientID%>").html();
            var txtCreateBy = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';



            /*表单验证*/
            /*如需表单验证可以此处处理验证 开始*/


            var entity = {};
            entity.MoldFixtureId = equipmentFileManageId
            entity.EqCode = txtEqCode;
            entity.FileName = txtFileName;
            entity.CreateBy = txtCreateBy;

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMoldFixture.MoldFixtureEdit(JSON.stringify(entity));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            alert('<%=Resources.Messages.SaveInSuccess%>')
            if ('<%=Request.QueryString["inMenu"] %>' == "true") {
                openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/User/UserEdit.aspx?name=Account_UserEdit&ID=" + parseInt(ajax.value);
                location.href = openWinUrl;
            }
            else {
                parent.window.Refresh();
            }
        }
    </script>

</asp:Content>
