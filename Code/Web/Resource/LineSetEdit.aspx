<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="LineSetEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Resource.LineSetEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <script type="text/javascript" src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/uploadify/jquery.uploadify.min.js"></script>
    <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %>
    </div>
    <table width="100%" class="EditeContentTable">

        <tr>
            <td class="Label3">日期<em>*</em></td>
            <td class="Field3">
                <asp:TextBox ID="txtLineSetDate" runat="server" CssClass="DateTimeBox" ClientIDMode="Static" IsRequired="1"></asp:TextBox>
            </td>
            <td class="Label3">线别<em>*</em></td>
            <td class="Field3">
                <asp:TextBox ID="txtLineName" runat="server" CssClass="TextBox" Enabled="false" ClientIDMode="Static" Width="120px" IsRequired="1"></asp:TextBox><input
                    type="button" id="btnSelectDefaultOpt" class="ButtonBox" value="..." title="选择线别"
                    onclick="selectLine();" />
                <asp:HiddenField ID="hdnLineId" runat="server" Value="-1" ClientIDMode="Static" />
            </td>
            <td colspan="2" rowspan="3" align="center" style="width: 120px;">

                <div style="width: 120px; height: 130px; border: 1px solid #ccc; margin-left: auto; margin-right: auto;">
                    <img src="../Content/images/portraits/default.png" id="imgPortraits" style="width: 100%; height: 100%;"
                        alt="头像" title="点击更换头像" />
                    
                </div>
                <input type="file" accept="image/gif,image/jpeg,image/png,image/bmp" id="uploadify" name="uploadify" style="width: 74px;" />
                 <p style="color:red"><%=Resources.lang.SupportedImageFormats %></p>
            </td>

        </tr>
        <tr>
            <td class="Label3">班制<em>*</em></td>
            <td class="Field3">
                <asp:TextBox ID="txtShiftList" runat="server" IsRequired='1' CssClass="TextBox"
                    MaxLength="30" ReadOnly="true" Width="120px"></asp:TextBox><input type="button" id="btnShiftList" class="ButtonBox" value="..." title="" onclick="selectShiftList();" />
                <asp:HiddenField ID="hdfShiftList" runat="server" Value="-1" />
            </td>
            <td class="Label3">A班负责人<em>*</em></td>
            <td class="Field3">
                <input type="hidden" id="hidPrincipal" value="-1" runat="server" />
                <asp:TextBox ID="txtPrincipal" runat="server" CssClass="TextBox" ReadOnly="true" Width="120px" IsRequired="1"></asp:TextBox><input type="button" class="ButtonBox" value="..." onclick="selectUser(12)" />
            </td>

        </tr>
        <tr>
            <td class="Label3">标准人数<em>*</em></td>
            <td class="Field3">
                <asp:TextBox ID="txtStandardHuman" runat="server" CssClass="TextBox" ClientIDMode="Static" Width="120px" IsRequired="1"></asp:TextBox>
            </td>
            <td class="Label3">实到人数<em>*</em></td>
            <td class="Field3">
                <asp:TextBox ID="txtActualHuman" runat="server" CssClass="TextBox" ClientIDMode="Static" Width="120px" IsRequired="1"></asp:TextBox>
            </td>

        </tr>
        
    </table>
    <table>
        <tr>
            <td class="Label3">
            
            </td>
            <td class="Field3"></td>
            <td class="Label3">B班负责人<em>*</em></td>
            <td class="Field3">
                <input type="hidden" id="hidSecond" value="-1" runat="server" />
                <asp:TextBox ID="txtSecond" runat="server" CssClass="TextBox" ReadOnly="true" Width="120px" IsRequired="1"></asp:TextBox><input type="button" class="ButtonBox" value="..." onclick="selectSecUser(13)" />
            </td>
            <td colspan="2" rowspan="3" align="center" style="width: 120px;">

                <div style="width: 120px; height: 130px; border: 1px solid #ccc; margin-left: auto; margin-right: auto;">
                    <img src="../Content/images/portraits/default.png" id="imgSectraits" style="width: 100%; height: 100%;"
                        alt="头像" title="点击更换头像" />
                    
                </div>
                <input type="file" accept="image/gif,image/jpeg,image/png,image/bmp" id="uploadifysec" name="uploadifysec" style="width: 74px;" />
                 <p style="color:red"><%=Resources.lang.SupportedImageFormats %></p>
            </td>
        </tr>
    </table>
    <div id="msg" style="text-align: center"></div>
    <script type="text/javascript">
        var lineSetId = '<%=Request.QueryString["ID"]%>';

        $(document).ready(function () {
            $("#txtStandardHuman,#txtActualHuman").keyup(function () {
                getDecimalVal(this);
            });
            $("#uploadify").uploadfile({
                fileTypeExts: 'image/gif,image/jpeg,image/png,image/bmp',
                buttonText: '<%=Resources.lang.ClickChangeTheAvatar%>',
                uploader: '<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Handler/UploadPortraits.ashx',
                fileSizeLimit: 1,
                formData: function (file) {
                    return {
                        'Type': 'Upload',
                        'UserId': $("#<%=hidPrincipal.ClientID %>").val()
                    };
                },
                onSelectError: function (file, errorCode) {
                    switch (errorCode) {
                        case -110:
                            //alert("文件 [" + file.name + "] 大小超出系统限制的1MB！");
                            $("#msg").html("文件 [" + file.name + "] 大小超出系统限制的1MB！").css("color", "red");
                            break;
                        case -130:
                            //alert("文件 [" + file.name + "] 类型不正确！");
                            $("#msg").html("文件 [" + file.name + "] 类型不正确！").css("color", "red");
                            break;
                    }
                },
                onUploadSuccess: function (file, data) {
                    $("#msg").html("");
                    $("#imgPortraits").attr("src", "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/Images/Portraits/" + data + "?rnd=" + Math.random());
                },
                onUploadError: function (file, msg) {
                    if (parseInt($("#<%=hidPrincipal.ClientID %>").val()) < 1) {
                        //alert("请先选择责任人！");
                        $("#msg").html("请先选择责任人！").css("color", "red");
                    } else {
                        //alert(msg);
                        $("#msg").html(msg).css("color", "red");
                    }
                }
            });
            $("#uploadifysec").uploadfile({
                fileTypeExts: 'image/gif,image/jpeg,image/png,image/bmp',
                buttonText: '上传文件',
                uploader: '<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Handler/UploadPortraits.ashx',
                fileSizeLimit: 1,
                formData: function (file) {
                    return {
                        'Type': 'Upload',
                        'UserId': $("#<%=hidSecond.ClientID %>").val()
                    };
                },
                onSelectError: function (file, errorCode) {
                    switch (errorCode) {
                        case -110:
                            //alert("文件 [" + file.name + "] 大小超出系统限制的1MB！");
                            $("#msg").html("文件 [" + file.name + "] 大小超出系统限制的1MB！").css("color", "red");
                            break;
                        case -130:
                            //alert("文件 [" + file.name + "] 类型不正确！");
                            $("#msg").html("文件 [" + file.name + "] 类型不正确！").css("color", "red");
                            break;
                    }
                },
                onUploadSuccess: function (file, data) {
                    $("#msg").html("");
                    $("#imgSectraits").attr("src", "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/Images/Portraits/" + data + "?rnd=" + Math.random());
                },
                onUploadError: function (file, msg) {
                    if (parseInt($("#<%=hidSecond.ClientID %>").val()) < 1) {
                        //alert("请先选择责任人！");
                        $("#msg").html("请先选择责任人！").css("color", "red");
                    } else {
                        //alert(msg);
                        $("#msg").html(msg).css("color", "red");
                    }
                }
            });
            if ($("#<%=hidPrincipal.ClientID %>").val() > 0) {
                setTimeout("RefreshImg()", 100);
            }
            if ($("#<%=hidSecond.ClientID %>").val() > 0) {
                setTimeout("RefreshSecImg()", 100);
            }
        });

        function RefreshImg() {
            $.ajax({
                type: 'GET',
                url: '<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Handler/UploadPortraits.ashx',
                data: { 'Type': 'Refresh', 'UserId': $("#<%=hidPrincipal.ClientID %>").val() },
                dataType: 'text',
                success: function (data) {
                    $("#imgPortraits").attr("src", "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/Images/Portraits/" + data + "?rnd=" + Math.random());
                },
                error: function () {
                    return false;
                }
            });
            }
        function RefreshSecImg() {
            $.ajax({
                type: 'GET',
                url: '<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Handler/UploadPortraits.ashx',
                data: { 'Type': 'Refresh', 'UserId': $("#<%=hidSecond.ClientID %>").val() },
                dataType: 'text',
                success: function (data) {
                    $("#imgSectraits").attr("src", "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/Images/Portraits/" + data + "?rnd=" + Math.random());
                },
                error: function () {
                    return false;
                }
            });
          }

            /*选择用户*/
            function selectUser(obj) {
                flag = obj;
                dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=12&Multiple=false&rnd=" + Math.random(), width: 600, height: 300 });
            }
        /*选择用户*/
        function selectSecUser(obj) {
            flag = obj;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=12&Multiple=false&rnd=" + Math.random(), width: 600, height: 300 });
            }
            /*选择线别*/
            function selectLine() {
                flag = 7;
                var searchCondition = "";
                dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=21&Multiple=false" + searchCondition + "&rnd=" + Math.random(), width: 650, height: 320 });
            }

            function selectShiftList() {
                flag = 49
                dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=49&Multiple=false&rnd=" + Math.random(), width: 400, height: 230 });
            }

            function getChooseValue(list) {
                if (flag == 12) {
                    $("#<%=hidPrincipal.ClientID %>").val(list[0][0]);
                    $("#<%=txtPrincipal.ClientID %>").val(list[0][2]);
                    RefreshImg();
                }
                else if(flag == 13) {
                    $("#<%=hidSecond.ClientID %>").val(list[0][0]);
                    $("#<%=txtSecond.ClientID %>").val(list[0][2]);
                    RefreshSecImg();
                }
                else if (flag == 7) {
                    $("#hdnLineId").val(list[0][0]);
                    $("#txtLineName").val(list[0][1]);
                }
                else if (flag == 49) {
                    $("#<%=this.txtShiftList.ClientID %>").val(list[0][1]);
                    $("#<%=this.hdfShiftList.ClientID %>").val(list[0][0]);
                }
                flag = -1;
    }

    /*保存数据*/
    function Save() {
        var txtLineSetDate = $("#<%=this.txtLineSetDate.ClientID%>").val();
        var txtLineId = $("#<%=this.hdnLineId.ClientID%>").val();
        var txtShiftId = $("#<%=this.hdfShiftList.ClientID%>").val();
        var txtPrincipal = $("#<%=this.hidPrincipal.ClientID%>").val();
        var txtSecond = $("#<%=this.hidSecond.ClientID%>").val();
        var txtStandardHuman = $("#<%=this.txtStandardHuman.ClientID%>").val();
        var txtActualHuman = $("#<%=this.txtActualHuman.ClientID%>").val();
        var txtCreateBy = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';
        var txtModifyBy = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';

        /*表单验证*/
        /*如需表单验证可以此处处理验证 开始*/


        var entity = {};

        entity.LineSetId = lineSetId
        entity.LineSetDate = txtLineSetDate.todate();
        entity.LineId = txtLineId;
        entity.ShiftId = txtShiftId;
        entity.Principal = txtPrincipal;
        entity.Seccipal = txtSecond;
        entity.StandardHuman = parseFloat(txtStandardHuman);
        entity.ActualHuman = parseFloat(txtActualHuman);
        entity.CreateBy = txtCreateBy;
        entity.ModifyBy = txtModifyBy;

        var ajax = SKT.LeanMES.Web.AjaxServices.AjaxServiceResource.LineSetEdit(entity);
        if (ajax.error != null) {
            alert(ajax.error.Message);
            return false;
        }

        alert('<%=Resources.Messages.SaveInSuccess%>')
    parent.window.Refresh();

}

    </script>

</asp:Content>
