<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    CodeBehind="CollectNCGroup.aspx.cs" Inherits="SKT.LeanMES.Web.Client.CollectNCGroup" %>

<%@ MasterType VirtualPath="~/Masters/EditMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <link href="../Content/productioncollection.css" rel="Stylesheet" type="text/css" />
    <table cellpadding="0" cellspacing="0" border="0" width="100%" style="padding: 6px;
        border: 1px #B1B1B1 solid;">
        <tr style="">
            <td style="width: 60px;">
                当前配置&nbsp;:
            </td>
            <td>
                <div style="background-color: Red; font-weight: bold; height: 24px; width: 120px;
                    text-align: center; line-height: 24px; margin-left: 5px;">
                    一级缺陷</div>
            </td>
            <td style="width: 60px; text-align: right;">
                当前条码&nbsp;:
            </td>
            <td style="width: 150px; text-align: right;">
                <div style="background-color: #fff; height: 24px; width: 140px; text-align: left;
                    line-height: 24px; margin-left: 5px; border: 1px #B1B1B1 solid;">
                    <span title="<%=Request.QueryString["SN"]%>"><%=Request.QueryString["SN"].ToString().Length > 17 ? Request.QueryString["SN"].ToString().Substring(0, 17) + ".." : Request.QueryString["SN"].ToString()%></span></div>
            </td>
        </tr>
    </table>
    
    <input type="hidden" id="hdnNCCodeGroup" value="" />
    <input type="hidden" id="hdnNCSerialNumber" value='<%=Request.QueryString["SN"]%>' />
    <input type="hidden" id="hdnNCUserId" value='<%=Request.QueryString["UserId"]%>' />
    <input type="hidden" id="hdnNCStationId" value='<%=Request.QueryString["stationid"]%>' />
    <input type="hidden" id="hdnNCResourceId" value='<%=Request.QueryString["resourceid"]%>' />
    <div style="height: 24px; line-height: 24px; width: 98%; margin-left: 8px;">
        缺陷信息&nbsp;:&nbsp;<input type="checkbox" id="chkOutAllError" /> 误判,解绑所有不良
    </div>
    <div style="height: 328px; border: 1px #B1B1B1 solid;">
        <div id="divNCGroup" style="height: 290px;overflow-x:auto;overflow-y:auto; ">
            <ul id="ulNCGroup" class="inmune">
            </ul>
        </div>
        <div style="width:100%; text-align:center; padding-bottom:2px;">
            <input type="button" id="btnReturn" value=" 返 回 " onclick="fnClosedPage(window)" style=" margin-right:15px;" 
                  title="返回" />
            <input type="button" id="btnClosed" value=" 关 闭 " onclick="fnClosedPage(window)"
                title="关闭" />
        </div>
    </div>
    <link href="../Content/productioncollection.css" rel="Stylesheet" type="text/css" />
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.client.nccodecollection.js"
        type="text/javascript"></script>
    <script type="text/javascript" language="javascript">
        var hdnNCSerialNumber = -1;
        var hdnNCStationId = -1;
        var hdnNCResourceId = -1;
        $(document).ready(
        function () {
            hdnNCSerialNumber = $("#hdnNCSerialNumber").val();
            hdnNCStationId = '<%=Request.QueryString["stationid"]%>';
            hdnNCResourceId = '<%=Request.QueryString["resourceid"]%>';
            hdnNCUserId = '<%=Request.QueryString["UserId"]%>';
            webroot = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>";
            userId = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserId %>";
            window.parent.GetSNNCDetail(hdnNCSerialNumber, window.parent.stationId);
            GetNCCodeGroupList(hdnNCStationId);
            //#region 注册异常类型点击事件
            $('#divNCGroup li a').click(function () {
                NCGroupId = $(this).attr("data-id");
                NCGroupCode = $(this).attr("data-code");

                OpenNCCode(hdnNCSerialNumber, hdnNCStationId, hdnNCResourceId, NCGroupId, NCGroupCode);
            });           
           
            //#endregion
        });
        function GetNCCodeGroupList(OperationId) {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxClientController.GetNCCodeGroupList(OperationId);
            if (ajax.error == null) {
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, "", ajax.error.Message);
                if (ajax.value.Rows.length > 0) {
                    var entity = ajax.value;
                    if (entity != null && entity.Rows.length > 0) {
                        var abHtml = "";
                        for (var i = 0; i < entity.Rows.length; i++) {
                            abHtml += '<li><a href="javascript:void(0)" data-code="' + entity.Rows[i].NCGroupName + '" data-id="' + entity.Rows[i].NCGroupId + '">' + entity.Rows[i].NCGroupName + '</a></li>';
                        }
                    }
                    abHtml += '<li><a href="javascript:void(0)"  data-code="Miscalculation" data-id="Miscalculation">误判</a></li>';
                    $("#ulNCGroup").append(abHtml);
                }
                else {
                    alert("工序未绑定不良代码组");
                    return false;
                }
            }
            else {
                alert("工序绑定不良代码组错误!");
                return false;
            }
        }
       
    </script>
</asp:Content>
