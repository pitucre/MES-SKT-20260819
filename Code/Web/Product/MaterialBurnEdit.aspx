<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="MaterialBurnEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Product.MaterialBurnEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <div id="materialBurnEditPage" class="tb_c" style="min-height: 385px; overflow: auto;">
        <div class="infoTips">
            <%=Resources.Messages.WithAsteriskIsRequired %>
        </div>
        <div>
            <table width="100%" class="EditeContentTable">
                <tr>
                    <td class="Label2">软件名称<em>*</em></td>
                    <td class="Field2">
                        <asp:TextBox ID="txtSoftName" runat="server" CssClass="TextBox" IsRequired='1' MaxLength="50"></asp:TextBox>
                    </td>
                    <td class="Label2">测试仪器</td>
                    <td class="Field2">
                        <asp:TextBox ID="txtTestMachine" runat="server" CssClass="TextBox" MaxLength="50"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="Label2">适用客户</td>
                    <td class="Field2">
                        <asp:TextBox ID="txtCustomer" runat="server" CssClass="TextBox" MaxLength="50"></asp:TextBox>
                    </td>
                    <td class="Label2">软件作者 </td>
                    <td class="Field2">
                        <asp:TextBox ID="txtSoftCreator" runat="server" CssClass="TextBox" MaxLength="50"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="Label2">接收日期</td>
                    <td class="Field2">
                        <asp:TextBox ID="txtReceiveDate" runat="server" CssClass="DateTimeBox" options="{showHms:'false'}"></asp:TextBox>
                    </td>
                    <td class="Label2">更新内容</td>
                    <td class="Field2">
                        <asp:TextBox ID="txtUpdateContent" runat="server" CssClass="TextBox" MaxLength="50"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="Label2">上传烧录软件<em>*</em></td>
                    <td class="Field2" colspan="3">
                        <input type="button" id="txtFileName" title="重新上传" value="重新上传" class="button" onclick="changefile(this.value)" /><asp:Label ID="lblFileName" runat="server" ></asp:Label>
                        <input type="file" id="Filedata" name="Filedata" title="上传烧录软件" style="width: 90%;display:none" /><br />
                        <asp:TextBox ID="txtSoftPath" runat="server" CssClass="TextBox" MaxLength="200" Style="display: none"></asp:TextBox>
                        <input type="text" style="display: none" id="IsUploadAgin" value="0" />
                    </td>
                </tr>
                <tr>
                    <td class="Label2">检验码<em>*</em></td>
                    <td class="Field2">
                        <asp:TextBox ID="txtVerifyCode" runat="server" CssClass="TextBox" IsRequired='1' MaxLength="50"></asp:TextBox>
                    </td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td class="Label2">下载目录<em>*</em></td>
                    <td class="Field2">
                        <asp:TextBox ID="txtDownloadDir" runat="server" CssClass="TextBox" IsRequired='1' MaxLength="200"></asp:TextBox>
                    </td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td class="Label2">描述</td>
                    <td class="Field2" colspan="3">
                        <asp:TextBox ID="txtRemark" runat="server" CssClass="TextArea" TextMode="MultiLine" Width="98%" Height="80px" MaxLength="200"></asp:TextBox>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <script type="text/javascript">
        var materialBurnId = '<%=Request.QueryString["ID"]%>';

        $(document).ready(function () {            
            $(".DateTimeBox").datepicker("option", "showHms", false);            

            if (materialBurnId == -1) {
                $("#txtFileName").hide();
                $("#<%=this.lblFileName.ClientID%>").hide();

                $("#Filedata").show();
            } else {
                $("#txtFileName").show();
                $("#<%=this.lblFileName.ClientID%>").show();

                $("#Filedata").hide();
            }

            $("#Filedata").bind("change", function (e) {                
                $("#IsUploadAgin").val("1");
            })
        })

        function changefile() {
            $("#txtFileName").hide();
            $("#<%=this.lblFileName.ClientID%>").hide();

            $("#Filedata").show();

        }

        /*保存数据*/
        function Save() {
            var txtSoftName = $.trim($("#<%=this.txtSoftName.ClientID%>").val());
            var txtTestMachine = $.trim($("#<%=this.txtTestMachine.ClientID%>").val());
            var txtSoftCreator = $.trim($("#<%=this.txtSoftCreator.ClientID%>").val());
            var txtCustomer = $.trim($("#<%=this.txtCustomer.ClientID%>").val());
            var txtFilename = $.trim($("#<%=this.lblFileName.ClientID%>").text());
            var txtVerifyCode = $.trim($("#<%=this.txtVerifyCode.ClientID%>").val());
            var txtReceiveDate = $("#<%=this.txtReceiveDate.ClientID%>").val();
            var txtUpdateContent = $.trim($("#<%=this.txtUpdateContent.ClientID%>").val());
            var txtSoftPath = $.trim($("#<%=this.txtSoftPath.ClientID%>").val());
            var txtDownloadDir = $.trim($("#<%=this.txtDownloadDir.ClientID%>").val());
            var txtRemark = $.trim($("#<%=this.txtRemark.ClientID%>").val());
            
            /*表单验证*/
            /*如需表单验证可以此处处理验证 开始*/
            var entity = {};
            entity.BurnId = materialBurnId;
            entity.SoftName = txtSoftName;
            entity.SoftCreator = txtSoftCreator;
            entity.TestMachine = txtTestMachine;
            entity.Customer = txtCustomer;
            entity.Filename = txtFilename;
            entity.VerifyCode = txtVerifyCode;
            if (txtReceiveDate != "") {
                entity.ReceiveDate = new Date(txtReceiveDate);
            }
            else {
                entity.ReceiveDate = new Date();
            }
            entity.UpdateContent = txtUpdateContent;
            entity.SoftPath = txtSoftPath;
            entity.DownloadDir = txtDownloadDir;
            entity.Remark = txtRemark;

            if (materialBurnId == -1 && $("#Filedata").val() == "") {
                alert("请选择需要上传的文件");
                return;
            }
            var reg = /^[a-zA-Z]:\\[a-zA-Z_0-9\\]*/;
            if (!reg.test(txtDownloadDir)) {
                alert('下载目录必须是有效的电脑路径(例如： C:\Program Files)'); //请将“日期”改成你需要验证的属性名称! 
                $("#<%=this.txtDownloadDir.ClientID%>").select().focus();
                return;
            }
            if ($("#IsUploadAgin").val() == "1") {
                entity.Filename = $("#Filedata").val();
                ajaxUpload(entity);
            }
            else {
                savedata(entity);                 
            }
        }
        function ajaxUpload(entity)
        {
            var file = document.getElementById("Filedata").files[0];
            //上传文件
            if (file) {
                var loading = $('<div id="dialogLoadingMessage" style="position:absolute; top:30%; left:40%; width:150px; text-align:center; "><div style="border:1px solid #d3d3d3; color:#21adf7; width:170px; height:40px; margin-left:auto; margin-right:auto;background:#fafafa; line-height:25px;">正在保存数据中...<br/><img src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/dialog/skin/default/images/loadinga.gif"/></div></div>');
                var shape = $('<divid="dialogLoadingShape" style="position: fixed;z-index: 19871029;top: 0;left: 0;height: 100%;width: 100%;opacity: 0;"></div>')
                $("#materialBurnEditPage").append(loading);
                $("#materialBurnEditPage").append(shape);
                var formData = new FormData();
                formData.append("Filedata", file);
                $.ajax({
                    url: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Handler/UploadHander.ashx?Action=BurnSoft&rnd=" + Math.random(),
                    type: "POST",
                    data: formData,
                    contentType: false,
                    processData: false,
                    success: function (data) {
                        var filepath = entity.Filename;
                        entity.Filename = filepath.substring(filepath.lastIndexOf("\\") + 1);
                        entity.SoftPath = data;
                        savedata(entity);
                    },
                    error: function (data, status, ex) {
                        $("#dialogLoadingMessage").remove();
                        $("#dialogLoadingShape").remove();
                        alert("文件上传错误");
                    }
                });
            }
        }

        function savedata(entity) {
            var txtReceiveDate = $("#<%=this.txtReceiveDate.ClientID%>").val();
            if (txtReceiveDate != "") {
                entity.ReceiveDate = new Date(txtReceiveDate);
            }
            else {
                entity.ReceiveDate = new Date();
            } 
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMolding.MaterialBurnEdit(entity);
            if (ajax.error != null) {
                $("#dialogLoadingMessage").remove();
                $("#dialogLoadingShape").remove();
                alert(ajax.error.Message);
                return false;
            }
            else {
                $("#dialogLoadingMessage").remove();
                $("#dialogLoadingShape").remove();
                alert('<%=Resources.Messages.SaveInSuccess%>');
                parent.window.Refresh();
                return true;
            }
        }
    </script>
</asp:Content>
