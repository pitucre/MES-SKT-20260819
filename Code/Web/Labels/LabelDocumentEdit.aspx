<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="True"
    CodeBehind="LabelDocumentEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Labels.LabelDocumentEdit"
    Title="Edit LabelDocument" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired%>
    </div>
    <table width="100%" class="EditeContentTable" style="min-width: 645px;">
        <tr>
            <td class="Label2">标签名称<em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtDocumentName" runat="server" IsRequired="1" CssClass="TextBox"
                    MaxLength="20"></asp:TextBox>
            </td>
            <td class="Label2">
                <%=Resources.lang.Status %>
            </td>
            <td class="Field2">
                <asp:DropDownList ID="ddlStatus" runat="server">
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="Label2">模板类型</td>
            <td class="Field2">
                <select id="printtype">
                    <option value="0" selected="selected">系统模板</option>
                    <option value="1">lab或btw模板</option>
                    <option value="2">zpl指令</option>
                    <option value="3">postek指令</option>
                </select>
            </td>
            <td class="Label2">
                <%=Resources.lang.TemplateName %><em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtTemplateName" IsRequired="1" runat="server" CssClass="TextBox" ReadOnly="true"></asp:TextBox><input type="button" id="btnDataType" class="ButtonBox" value="..." title="" onclick="selectDateType();" />
                <asp:HiddenField ID="txtTemplateID" runat="server" Value="-1" />
            </td>
        </tr>
        <tr id="trtemplatepath" style="display: none;">
            <td class="Label2">
                <%=Resources.lang.TemplatePath %><em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtTemplatePath" ReadOnly="true" runat="server" CssClass="TextBox"></asp:TextBox>
                <input type="file" id="txtfile" style="display: none" />
                <a style="display: none;" id="a_downloadfile">下载</a>
            </td>
            <td class="Field2" colspan="2">
                <span style="color:red;">离线模板必须放在安装的打印服务路径下面，如：D:\plugin\print</span>
            </td>
        </tr>
        <tr id="trcommand" style="display: none;">
            <td class="Label2">指令<em>*</em>
            </td>
            <td class="Field2" colspan="3">
                <asp:TextBox ID="txtCommand" runat="server" CssClass="TextArea" TextMode="MultiLine" MaxLength="50" Width="500px" Height="200px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%=Resources.lang.PrinterName %>
            </td>
            <td class="Field2" title="打印机名称,IP,端口">
                <asp:TextBox ID="txtPrinterName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label2">打印份数
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtPrintQty" runat="server" CssClass="NumericBox50" Text="1" onkeyup="this.value=this.value.replace(/\D/g,'')"
                    onafterpaste="this.value=this.value.replace(/\D/g,'')"></asp:TextBox>
            </td>
        </tr>
        <tr style="display: none;">
            <td class="Label2">
                <%=Resources.lang.PrintBy %>
            </td>
            <td class="Field2">
                <asp:DropDownList ID="ddlPrintBy" runat="server">
                </asp:DropDownList>
            </td>
            <td class="Label2">
                <%=Resources.lang.PrintMethod %>
            </td>
            <td class="Field2">
                <asp:DropDownList ID="ddlPrintMethod" runat="server">
                </asp:DropDownList>
            </td>
        </tr>
        <tr style="display: none;">
            <td class="Label2">
                <%=Resources.lang.DocumentType %>
            </td>
            <td class="Field2">
                <asp:DropDownList ID="ddlDocumentType" runat="server">
                </asp:DropDownList>
            </td>
            <td class="Label2">
                <%=Resources.lang.PlateQty %>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtPlateQty" runat="server" CssClass="NumericBox50" IsNumber="1" Text="1" onkeyup="this.value=this.value.replace(/\D/g,'')"
                    onafterpaste="this.value=this.value.replace(/\D/g,'')">
                </asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%=Resources.lang.Description %>
            </td>
            <td class="Field2" colspan="3">
                <asp:TextBox ID="txtDescription" runat="server" CssClass="TextArea" MaxLength="50" Width="500px"></asp:TextBox>
            </td>
        </tr>
    </table>
    <div id="infoBartender" class="infoTips" style="color:black;display:none;">注：Bartender软件目前支持(2016_R4/2016_R7/2019_R4/2019_R9/2021_R6/2021_R7)这些版本，更换软件版本需要重新安装服务！
    </div>
    <script type="text/javascript">
        $(function () {
            $("#printtype").change(function () {
                var type = parseInt($(this).val());
                $("#trtemplatepath").hide();
                $("#trcommand").hide();
                if (type == 0) {
                    //系统模板
                    $("#<%=this.txtTemplatePath.ClientID %>").val("");
                    $("#infoBartender").hide();
                } else if (type == 1) {
                    //lab,btw
                    $("#trtemplatepath").show();
                    $("#infoBartender").show();
                } else {
                    //zpl   //postek
                    $("#trcommand").show();
                    $("#infoBartender").hide();
                }
            });

            $("#<%=this.txtTemplatePath.ClientID %>").click(function () {
                $("#txtfile").click();
            }).attr("placeholder", "点击上传lab或btw文件");

            $("#txtfile").change(function () {
                var fileName = this.files[0].name;
                var fileNameWithoutExt = fileName.substr(0, fileName.lastIndexOf('.'));
                var ext = fileName.substr(fileName.lastIndexOf('.'));
                //检测是否重名
                $.ajax({
                    url: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Handler/PrintUpdate.ashx",
                    type: "POST",
                    data: { "fileName": fileName, "action": "IsTemplateFileExist" },
                    async: false,
                    success: function (data) {
                        if (data == "1") {
                            fileName = fileNameWithoutExt + "_" + commonFormatDate(new Date(), "yyyyMMddHHmmss") + ext;
                        }
                        $("#<%=this.txtTemplatePath.ClientID %>").val(fileName);
                    },
                    error: function (data, status, ex) {
                        console.log(ex);
                    }
                });
            });
            var fname = $("#<%=this.txtTemplatePath.ClientID %>").val().toLocaleLowerCase();
            if (fname) {
                if (fname.indexOf(".lab") > 0 || fname.indexOf(".btw") > 0) {
                    $("#printtype").val("1");
                    $("#trtemplatepath").show();
                    $("#infoBartender").show();
                    $("#a_downloadfile").attr("href", "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Handler/PrintUpdate.ashx?action=DownLoadUpdateFile&fileType=1&fileName=" + $("#<%=this.txtTemplatePath.ClientID %>").val()).show();
                } else if (fname.indexOf(".zpl") > 0) {
                    $("#printtype").val("2");
                    $("#trcommand").show();
                } else if (fname.indexOf(".postek") > 0) {
                    $("#printtype").val("3");
                    $("#trcommand").show();
                }
            }
        });
        var labelDocumentId = '<%=Request.QueryString["ID"]%>';

        //模板名称
        function selectDateType() {
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=812&Multiple=false&rnd=" + Math.random(), width: 500, height: 300 });
        }
        function getChooseValue(list) {
            $("#<%=this.txtTemplateName.ClientID %>").val(list[0][1]);
            $("#<%=this.txtTemplateID.ClientID %>").val(list[0][0]);
        }

        /*保存数据*/
        function Save() {

            var errStr = "";
            var txtDocumentName = $("#<%= this.txtDocumentName.ClientID %>").val();
            var txtTemplateName = $("#<%=this.txtTemplateName.ClientID %>").val();

            var txtTemplateID = $("#<%=this.txtTemplateID.ClientID %>").val();
            var txtPrintQty = $("#<%=this.txtPrintQty.ClientID %>").val();
            var ddlStatus = $("#<%=this.ddlStatus.ClientID %>").val();
            var ddlPrintBy = $("#<%=this.ddlPrintBy.ClientID %>").val();
            var ddlDocumentType = $("#<%= this.ddlDocumentType.ClientID %>").val();
            var textDesc = $("#<%=this.txtDescription.ClientID %>").val();
            var ddlPrintMethod = $("#<%=this.ddlPrintMethod.ClientID %>").val();
            var txtPlateQty = $("#<%=this.txtPlateQty.ClientID %>").val();
            var txtPrinterName = $("#<%=this.txtPrinterName.ClientID %>").val();
            var txtCommand = $("#<%=this.txtCommand.ClientID %>").val();
            var txtCreateBy = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';
            var txtModifyBy = txtCreateBy;
            var entity = {};
            entity.TemplatePath = "";
            if (!txtTemplateName) {
                alert("请选择模板");
                return;
            }
            var file;
            var printtype = parseInt($("#printtype").val());
            if (printtype == 1) {
                entity.TemplatePath = $("#<%=this.txtTemplatePath.ClientID %>").val();
                file = document.getElementById("txtfile").files[0];
                if (!file && !entity.TemplatePath) {
                    alert("请选择文件");
                    return;
                }
                if (file && file.name.toLocaleLowerCase().indexOf(".lab") <= 0 && file.name.toLocaleLowerCase().indexOf(".btw") <= 0) {
                    alert("请选择lab或btw文件");
                    return;
                }
                //if ((file.PostedFile != null) && file.PostedFile.ContentLength > 0) {
                //    alert("选择的上传文件为0字节,请重新选择上传");
                //    return;
                //}
            } else if (printtype == 2) {
                if (!txtCommand) {
                    alert("请输入zpl指令");
                    return;
                }
            } else if (printtype == 3) {
                if (!txtCommand) {
                    alert("请输入postek指令");
                    return;
                }
            }
            if (txtDocumentName.length <= 0) {
                alert("<%=Resources.Messages.DocumentNameEmpty %>");
                return false;
            }
            var action = '<%=Request.QueryString["Action"] %>';
            if (action == "Copy") {
                entity.LabelDocumentId = -2;
            }
            else {
                entity.LabelDocumentId = labelDocumentId;
            }
            entity.DocumentName = txtDocumentName;
            entity.Status = ddlStatus;
            entity.Description = textDesc;
            entity.TemplateID = txtTemplateID;
            entity.TemplateName = txtTemplateName;
            entity.Print_Qty = txtPrintQty == "" ? 1 : txtPrintQty;
            entity.Print_By = ddlPrintBy;
            entity.Print_Method = ddlPrintMethod;
            entity.Document_Type = ddlDocumentType;
            entity.PlateQty = txtPlateQty == "" ? 1 : txtPlateQty;
            entity.PrinterName = txtPrinterName;
            entity.CreateBy = txtCreateBy;
            entity.ModifyBy = txtModifyBy;
            entity.Remark = "";

            entity.PrintWayId = 78;


            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxLabels.LabelDocumentEdit(entity);
            if (ajax.error == null) {
                //上传指令
                if (printtype == 2 || printtype == 3) {
                    $.ajax({
                        url: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Handler/PrintUpdate.ashx",
                        type: "POST",
                        data: { id: ajax.value, action: "UploadCommandFile", type: printtype, command: txtCommand },
                        async: false,
                        success: function (data) {
                            data = JSON.parse(data);
                            if (!data.success) {
                                alert(data.msg);
                                return;
                            }
                            alert('<%=Resources.Messages.SaveInSuccess%>');
                            parent.window.UpdateList(txtDocumentName);
                        },
                        error: function (data, status, ex) {
                            alert("指令上传错误");
                        }
                    });
                    return;
                }
                //上传文件
                if (file) {
                    var formData = new FormData();
                    formData.append(file.name, file);
                    formData.append("id", ajax.value);
                    formData.append("action", "UploadTemplateFile");
                    formData.append("fileName", $("#<%=this.txtTemplatePath.ClientID %>").val());
                    $.ajax({
                        url: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Handler/PrintUpdate.ashx",
                        type: "POST",
                        data: formData,
                        async: false,
                        contentType: false,
                        processData: false,
                        success: function (data) {
                            data = JSON.parse(data);
                            if (!data.success) {
                                alert(data.msg);
                                return;
                            }
                            alert('<%=Resources.Messages.SaveInSuccess%>');
                            parent.window.UpdateList(txtDocumentName);
                        },
                        error: function (data, status, ex) {
                            alert("文件上传错误");
                        }
                    });
                } else {
                    alert('<%=Resources.Messages.SaveInSuccess%>');
                    parent.window.UpdateList(txtDocumentName);
                }
            } else {
                alert(ajax.error.Message);
                return false;
            }
        }

        function isPathRight(path) {
            var patrn = /^[a-zA-Z]:\\[a-zA-Z_0-9\\]*/;
            if (!patrn.exec(path)) {
                return false;
            }
            return true;
        }

    </script>
</asp:Content>
