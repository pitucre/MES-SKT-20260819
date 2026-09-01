<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="BurnSoftEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Product.BurnSoftEdit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <table width="100%" class="EditeContentTable">
        <tr>
            <td colspan="4" class="Label">
                <%=Resources.Messages.WithAsteriskIsRequired %>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                软件名称<em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtSoftName" runat="server" CssClass="TextBox" MaxLength="50"></asp:TextBox>
            </td>
            <td class="Label2">
                测试仪器 <em>&nbsp;</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtTestMachine" runat="server" CssClass="TextBox" MaxLength="50"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                适用客户 <em>&nbsp;</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtCustomer" runat="server" CssClass="TextBox" MaxLength="50"></asp:TextBox>
            </td>
            <td class="Label2">
                软件作者 <em>&nbsp;</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtSoftMan" runat="server" CssClass="TextBox" MaxLength="50"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                接收日期 <em>&nbsp;</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtReceiveDate" runat="server" CssClass="DateTimeBox"></asp:TextBox>
            </td>
            <td class="Label2">
                更改内容 <em>&nbsp;</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtupdatContent" runat="server" CssClass="TextBox" MaxLength="50"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                上传烧录软件 <em>*</em>
            </td>
            <td class="Label2" style="text-align: left" colspan="4">
                <div style="position: relative">
                    <asp:TextBox ID="SoftPath" ClientIDMode="Static" runat="server" Width="85%" Height="20px"
                        Style="right: -3px;" CssClass="TextBox" />
                </div>
                <div style="position: relative">
                    <asp:FileUpload ID="txtUploadControl" runat="server" onchange="uploadFile(this.value)"
                        Width="75px" name="fileInput" ContentEditable="false" Style="position: absolute;
                        right: 4px; top: 0px;" />
                    <asp:LinkButton ID="linkUploadFile" runat="server" OnClick="linkUploadFile_Click"></asp:LinkButton>
                </div>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                检验码 <em>*</em>
            </td>
            <td class="Field2" colspan="4">
                <asp:TextBox ID="verifycode" runat="server" ClientIDMode="Static" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                默认下载目录 <em>*</em>
            </td>
            <td class="Field2" colspan="4">
                <asp:TextBox ID="downloaddir" runat="server" ClientIDMode="Static" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.Remark %>
                <em>&nbsp;</em>
            </td>
            <td class="Field2" colspan="4">
                <asp:TextBox ID="txtRemark" runat="server" CssClass="TextArea" TextMode="MultiLine"
                    MaxLength="50" Width="99%" ClientIDMode="Static" Height="50"></asp:TextBox>
            </td>
        </tr>
    </table>
    <style type="text/css">
        #SoftPath
        {
            position: relative;
            z-index: 1;
        }
    </style>
    <script type="text/javascript" src="../Content/tool/tool.js"></script>
    <script type="text/javascript" src="../Content/WebPrinter/webprinter.h.js"></script>
    <script type="text/javascript" src="../Content/WebPrinter/webprinter.cpp.js"></script>
    <script type="text/javascript">

        var burnSoftId = '<%=Request.QueryString["ID"]%>';



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

            var txtSoftName = $.trim($("#<%=this.txtSoftName.ClientID%>").val());
            var txtTestMachine = $.trim($("#<%=this.txtTestMachine.ClientID%>").val());
            var txtCustomer = $.trim($("#<%=this.txtCustomer.ClientID%>").val());
            var txtSoftMan = $.trim($("#<%=this.txtSoftMan.ClientID%>").val());
            var txtReceiveDate = $("#<%=this.txtReceiveDate.ClientID%>").val();
            var txtupdatContent = $.trim($("#<%=this.txtupdatContent.ClientID%>").val());
            var txtRemark = $.trim($("#<%=this.txtRemark.ClientID%>").val());

            var downloaddir = document.getElementById("downloaddir").value;

            var verifycode = document.getElementById("verifycode").value;

            var softpath = document.getElementById("SoftPath").value;


            /*表单验证*/
            if (txtSoftName == "") {
                alert("软件名称不能为空！");
                return false;
            }
            if (verifycode == "") {
                alert("检验码不能为空！");
                return false;
            }
            if (softpath == "") {
                alert("上传烧录软件不能为空！");
                return false;
            }
            if (downloaddir == "") {
                alert("软件名称不能为空！");
                return false;
            } else {
                var patrn = /^[C|D|E|F]:\\.+\\.+$/;
                if (!patrn.exec(downloaddir)) {
                    alert("格式不正确!");
                    return false;
                }
            }

            var entity = {};

            entity.BurnSoftId = parseInt(burnSoftId);
            entity.SoftName = txtSoftName;
            entity.TestMachine = txtTestMachine;
            entity.Customer = txtCustomer;
            entity.SoftMan = txtSoftMan;
            entity.ReceiveDate = getDate(txtReceiveDate.toString());
            entity.UpdatContent = txtupdatContent;
            entity.Ramark = txtRemark;
            entity.VerifyCode = verifycode;
            entity.DownloadDir = downloaddir;
            entity.SoftPath = softpath;
            var jsonStr = JSON.stringify(entity);

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxBurnSoft.EditBurnSoft(jsonStr);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            alert('<%=Resources.Messages.SaveInSuccess%>')
            parent.window.UpdateList(txtSoftName);
        }

        //字符串转日期格式
        function getDate(strDate) {
            var date = eval('new Date(' + strDate.replace(/\d+(?=-[^-]+$)/,
                function (a) {
                    return parseInt(a, 10) - 1;
                }).match(/\d+/g) + ')'
            );
            return date;
        }

    </script>
</asp:Content>

