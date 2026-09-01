<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="True"
    CodeBehind="WorkShopEdit.aspx.cs" Inherits="SKT.LeanMES.Web.WorkShop.WorkShopEdit"
    Title="Edit WorkShop" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %>
    </div>
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label3">
                <%= Resources.lang.WorkShopName %><em>*</em>
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtWorkShopName" runat="server" IsRequired='1' CssClass="TextBox" Width="135px"
                    MaxLength="50"></asp:TextBox>
            </td>
            <td class="Label3">
                <%= Resources.lang.FactoryName %>
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtFactoryName" runat="server" IsRequired='0' CssClass="TextBox" Width="120px"
                    MaxLength="30" ReadOnly="true"></asp:TextBox><input type="button" id="btnFactory" class="ButtonBox" value="..." title="" onclick="selectFactory();" />
                <asp:HiddenField ID="hdfFactory" runat="server" Value="-1" />
            </td>
            <td colspan="2" rowspan="5" align="center" style="width: 120px;">

                <div style="width: 120px; height: 130px; border: 1px solid #ccc; margin-left: auto; margin-right: auto;">
                    <img src="../Content/images/portraits/default.png" id="imgPortraits" style="width: 100%; height: 100%;"
                        alt="头像" title="点击更换头像" />
                </div>
                <input type="file" id="uploadify" name="uploadify" accept="image/gif,image/jpeg,image/png,image/bmp" />

            </td>
        </tr>
        <tr>
            <td class="Label3">
                <%= Resources.lang.ShiftName %>
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtShiftList" runat="server" IsRequired='0' CssClass="TextBox" Width="120px"
                    MaxLength="30" ReadOnly="true"></asp:TextBox><input type="button" id="btnShiftList" class="ButtonBox" value="..." title="" onclick="selectShiftList();" />
                <asp:HiddenField ID="hdfShiftList" runat="server" Value="-1" />
            </td>
            <td class="Label3">负责人<em>*</em></td>
            <td class="Field3">
                <input type="hidden" id="hidPrincipal" value="-1" runat="server" />
                <asp:TextBox ID="txtPrincipal" runat="server" CssClass="TextBox" ReadOnly="true" Width="120px" IsRequired="1"></asp:TextBox><input type="button" class="ButtonBox" value="..." onclick="selectUser(12)" />
            </td>
        </tr>
        <tr>
            <td class="Label3">车间温度<em>*</em>
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtTemperature" runat="server" IsRequired='1' CssClass="TextBox" Width="135px" MaxLength="50"></asp:TextBox>
            </td>
            <td class="Label3">车间湿度<em>*</em>
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtHumidity" runat="server" IsRequired='1' CssClass="TextBox" Width="135px" MaxLength="50"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label3">车间简介
            </td>
            <td class="Field3" colspan="3">
                <asp:TextBox ID="txtRemark" runat="server" CssClass="TextArea" Width="95%" Height="200" TextMode="MultiLine"
                    MaxLength="50"></asp:TextBox>
            </td>

        </tr>
    </table>
    <script type="text/javascript" src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/uploadify/jquery.uploadify.min.js"></script>
    <script type="text/javascript">
        var Id = <%= Request.QueryString["Id"] == null ? -1 : Convert.ToInt32(Request.QueryString["Id"].ToString())%>

         $(document).ready(function () {

             $("#uploadify").uploadfile({
                 uploader: '<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Handler/UploadPortraits.ashx',
                 fileTypeExts: 'image/gif,image/jpeg,image/png,image/bmp',
                 fileSizeLimit: 1,
                 buttonText: mesLang('点击更换头像'),
                 formData: function () {
                     return { 'Type': 'Upload', 'UserId': $("#<%=hidPrincipal.ClientID %>").val() }
                },
                 onSelectError: function (file, errorCode) {
                     switch (errorCode) {
                         case -110:
                             alert("文件 [" + file.name + "] 大小超出系统限制的1MB大小！");
                             break;
                         case -130:
                             alert("文件 [" + file.name + "] 类型不正确！");
                             break;
                     }
                 },
                 onUploadSuccess: function (file, data) {
                     $("#imgPortraits").attr("src", "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/Images/Portraits/" + data + "?rnd=" + Math.random());
                },
                onUploadError: function (file, errorCode) {
                    if (parseInt($("#<%=hidPrincipal.ClientID %>").val()) < 1) {
                        alert("请先选择责任人！");
                    } else {
                        alert(errorCode);
                    }
                }
             });
             if ($("#<%=hidPrincipal.ClientID %>").val() > 0) {
                 setTimeout("RefreshImg()", 100);
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

            /*保存数据*/
            function Save() {
                var txtWorkShopName = $.trim($("#<%=this.txtWorkShopName.ClientID%>").val());
            var hdfFactory = $.trim($("#<%=this.hdfFactory.ClientID%>").val());
            var txtRemark = $.trim($("#<%=this.txtRemark.ClientID%>").val());
            var hdfShiftList = $.trim($("#<%=this.hdfShiftList.ClientID%>").val());
            var txtPrincipal = $("#<%=this.hidPrincipal.ClientID%>").val();
            var txtTemperature = $("#<%=this.txtTemperature.ClientID%>").val();
            var txtHumidity = $("#<%=this.txtHumidity.ClientID%>").val();

            /*表单验证*/
            /*如需表单验证可以此处处理验证 开始*/

            var entity = {};

            entity.WorkShopID = Id;
            entity.WorkShopName = txtWorkShopName;
            entity.WorkShopCode = "";
            entity.FactoryId = hdfFactory;
            entity.Remark = txtRemark;
            entity.ShiftId = hdfShiftList;
            entity.Principal = txtPrincipal;
            entity.Temperature = txtTemperature;
            entity.Humidity = txtHumidity;
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxWorkShop.WorkShopEdit(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            alert('<%=Resources.Messages.SaveInSuccess%>')
            if ('<%=Request.QueryString["inMenu"] %>' == "true") {
                openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/WorkShop/WorkShopEdit.aspx?name=WorkShopEdit&ID=" + parseInt(ajax.value);
                location.href = openWinUrl;
            }
            else {
                parent.window.Refresh();
            }
        }
        var flag = -1
        function selectFactory() {
            flag = 1;
            var searchCondition = "TypeId=1";
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=47&Multiple=false&PageCondition=" + searchCondition + "&rnd=" + Math.random(), width: 400, height: 230 });
        }

        function selectShiftList() {
            flag = 2
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=49&Multiple=false&rnd=" + Math.random(), width: 400, height: 230 });
        }

        /*选择用户*/
        function selectUser(obj) {
            flag = obj;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=12&Multiple=false&rnd=" + Math.random(), width: 600, height: 300 });
        }

        function getChooseValue(list) {
            if (flag == 1) {
                $("#<%=this.txtFactoryName.ClientID %>").val(list[0][2]);
                $("#<%=this.hdfFactory.ClientID %>").val(list[0][0]);
            }
            else if (flag == 12) {
                $("#<%=hidPrincipal.ClientID %>").val(list[0][0]);
                $("#<%=txtPrincipal.ClientID %>").val(list[0][2]);
                RefreshImg();
            }
            else if (flag == 2) {
                $("#<%=this.txtShiftList.ClientID %>").val(list[0][1]);
                $("#<%=this.hdfShiftList.ClientID %>").val(list[0][0]);
            }
}
    </script>
</asp:Content>
