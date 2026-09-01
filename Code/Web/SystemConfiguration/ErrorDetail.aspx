<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ViewMaster.master" AutoEventWireup="true" CodeBehind="ErrorDetail.aspx.cs" Inherits="SKT.LeanMES.Web.SystemConfiguration.ErrorDetail" %>
<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="server">
<table class="EditeContentTable" width="100%">
    <tr>
        <td class="Label" style="width:110px; text-align:right;">错误发生时间</td>
        <td class="Field">
            <label id="lblOccrTime"></label>
        </td>
    </tr>
    <tr>
        <td class="Label" style="width:110px; text-align:right;">操作人</td>
        <td class="Field">
            <label id="lblOperateUser"></label>
        </td>
    </tr>
    <tr>
        <td class="Label" style="width:110px; text-align:right;">错误信息</td>
        <td class="Field" style="word-break:break-all;word-wrap:break-word; word-spacing:normal; padding:3px;">
            <label id="lblErrorMessage" style="line-height:18px;"></label>
        </td>
    </tr>
</table>
<script type="text/javascript" language="javascript">
    $(document).ready(function () {
        getErrorDetail();
    });

    function getErrorDetail() {
        var yearMonth = '<%=Request.QueryString["yearMonth"] %>';
        var occrTime = '<%=Request.QueryString["time"] %>';
        occrTime = decodeURIComponent(occrTime);
        var ajax = SKT.LeanMES.Web.AjaxServices.AjaxErrorLog.GetErrorDetail(yearMonth,occrTime);
        if (handleAjaxError(ajax.error)) {
            var entity = ajax.value;
            $("#lblOccrTime").text(entity.OccurTime);
            $("#lblOperateUser").text(entity.OperateUser);
            $("#lblErrorMessage").text(entity.ErrorMessage);
        }
    }
</script>
</asp:Content>
