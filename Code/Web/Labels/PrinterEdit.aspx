<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="True"
    CodeBehind="PrinterEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Labels.PrinterEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired%>
    </div>
    <table width="100%" class="EditeContentTable" style="min-width: 645px;">
        <tr>
            <td class="Label1">打印机名称<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtName" runat="server" IsRequired="1" Enabled="false" CssClass="TextBox"
                    MaxLength="100"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label1">分组
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtGroupName" runat="server" CssClass="TextBox"
                    MaxLength="15"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label1">备注
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtRemark" runat="server" CssClass="TextArea" TextMode="MultiLine" MaxLength="50" Width="270px" Height="70px"></asp:TextBox>
            </td>
        </tr>
    </table>
    <style type="text/css">
        .selectgroup {
            position: absolute;
            z-index: 99999;
            background: #fff;
            width: 144px;
            overflow-x: hidden;
            overflow-y: auto;
            border: 1px solid #ccc;
            text-align: center;
            cursor:pointer;
        }

            .selectgroup div {
                line-height: 25px;
            }

                .selectgroup div:hover {
                    background: #eee;
                }
    </style>
    <script type="text/javascript">
        $(function () {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxLabels.GetPrinterGroup();
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return;
            }
            $("#<%= this.txtGroupName.ClientID %>").focus(function () {
                $(".selectgroup").remove();
                var str = "";
                for (var i = 0; i < ajax.value.length; i++) {
                    str += "<div>" + ajax.value[i] + "</div>";
                }
                $("<div class='selectgroup'></div>").appendTo($("body")).append(str).css({
                    top: $(this).offset().top + $(this).height(),
                    left: $(this).offset().left + 7,
                    height:0
                }).animate({ height: 200 }, 200);
                $(".selectgroup div").click(function () {
                    $("#<%= this.txtGroupName.ClientID %>").val($(this).text());
                });
            }).blur(function () {
                $(".selectgroup").animate({ height: 0 }, 200, "swing", function () {
                    $(this).remove();
                });
            });
        });
        /*保存数据*/
        function Save() {
            var entity = {};
            entity.Id = '<%=Request.QueryString["Id"]%>';
            entity.GroupName =$.trim($("#<%= this.txtGroupName.ClientID %>").val());
            entity.Remark = $("#<%= this.txtRemark.ClientID %>").val();
            entity.ModifyBy = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxLabels.EditPrinter(entity);
            if (ajax.error == null) {
                alert('<%=Resources.Messages.SaveInSuccess%>');
                parent.window.UpdateList();
            } else {
                alert(ajax.error.Message);
                return false;
            }
        }
    </script>
</asp:Content>
