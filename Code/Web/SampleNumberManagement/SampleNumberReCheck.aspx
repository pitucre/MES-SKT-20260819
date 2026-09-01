<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SampleNumberReCheck.aspx.cs" MasterPageFile="~/Masters/EditMaster.master" Inherits="SKT.LeanMES.Web.SampleNumberManagement.SampleNumberReCheck" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1">样机序号
            </td>
            <td class="Field1">
                <label id="SampleNumber"></label>
            </td>
        </tr>
        <tr>
            <td class="Label1">失效日期
            </td>
            <td class="Field1">
                <label id="ExpirationDate"></label>
            </td>
            <tr>
            </tr>
        <td class="Label1">下一失效日期
        </td>
        <td class="Field1">
            <input type="text" id="NextExpirationDate" class='DateTimeBox' readonly='readonly' isrequired='1' />
        </td>
        </tr>
    </table>

    <script type="text/javascript">
        var SampleNumber = '<%=Request.QueryString["SampleNumber"]%>';
        var ExpirationDate = '<%=Request.QueryString["ExpirationDate"]%>';
        var modifyBy = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUserInfo().UserName%>';
        _isHms = false;

        $(function () {
            $("#SampleNumber").text(SampleNumber);
            $("#ExpirationDate").text(ExpirationDate);
        })

        //保存数据
        function Save() {
            var sampleNumber = $.trim($("#SampleNumber").text());
            var nextExpirationDate = $.trim($("#NextExpirationDate").val());
            var entity =
            {
                SampleNumber: sampleNumber,
                NextExpirationDate: nextExpirationDate,
                ModifyBy: modifyBy,
            }
            var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspPrototypeRecheck", JSON.stringify(entity));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert('<%=Resources.Messages.SaveSuccess %>');
            parent.window.UpdateList();
        }
    </script>
</asp:Content>
