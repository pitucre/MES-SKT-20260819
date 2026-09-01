<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/EditMaster.master"
    CodeBehind="CollectNCData.aspx.cs" Inherits="SKT.LeanMES.Web.Client.CollectNCData" %>

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
                <div style="background-color: Red; font-weight: bold; height: 24px; width: 70px;
                    text-align: center; line-height: 24px; margin-left: 5px;">
                    二级缺陷</div>
            </td>
            <td style="width: 60px;">
                上级缺陷&nbsp;:
            </td>
            <td>
                <div style="background-color: Red; font-weight: bold; height: 24px; width: 120px;
                    text-align: center; line-height: 24px; margin-left: 5px;">
                    <%=Request.QueryString["NCGroupCode"]%></div>
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
    <div style="height: 24px; line-height: 24px; width: 98%; margin-left: 8px;">
        缺陷信息&nbsp;:
    </div>
    <div style="height: 328px; border: 1px #B1B1B1 solid;">
        <div id="divNCData" style="height: 290px;overflow-x:auto;overflow-y:auto;">
            <ul id="ulNCData" class="ncdata">
            </ul>
        </div>
        <div style="width: 100%; text-align: center; padding-bottom: 2px;">
            <input type="button" id="btnReturn" value=" 返 回 " style=" margin-right:15px;"  onclick="ReturnToNCGroupList(hdnNCStationId.value,hdnNCSerialNumber.value,hdnNCResourceId.value,hdnNCUserId.value)"
                title="返回" />
            <input type="button" id="btnClosed" value=" 关 闭 " onclick="fnClosedPage(window)"
                 title="关闭" />
        </div>
    </div>
    <input type="hidden" id="hdnNCCodeGroupId" value='<%=Request.QueryString["NCGroupId"]%>' />
    <input type="hidden" id="hdnNCSerialNumber" value='<%=Request.QueryString["SN"]%>' />
    <input type="hidden" id="hdnNCUserId" value='<%=Request.QueryString["UserId"]%>' />
    <input type="hidden" id="hdnNCStationId" value='<%=Request.QueryString["stationid"]%>' />
    <input type="hidden" id="hdnNCResourceId" value='<%=Request.QueryString["resourceid"]%>' />
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.client.nccodecollection.js"
        type="text/javascript"></script>

    <script type="text/javascript" language="javascript">
        var hdnNCSerialNumber = -1;
        var hdnNCStationId = -1;
        var hdnNCResourceId = -1;
        var hdnNCUserId = 0;
        var NCCodeId = -1;
        var NCCode = "";
        var vaType = 5; //不良采集模块类型
        $(document).ready(
        function () {
            hdnNCSerialNumber = $("#hdnNCSerialNumber").val();
           
            hdnNCStationId = '<%=Request.QueryString["stationid"]%>';
            hdnNCResourceId = '<%=Request.QueryString["resourceid"]%>';
            hdnNCUserId = '<%=Request.QueryString["UserId"]%>';
            hdnNCGroupId = '<%=Request.QueryString["NCGroupId"]%>';
            webroot = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>";
            routeId = -1;
            proOrderId = -1;
            GetNCCodeList(hdnNCGroupId);
            //#region 注册异常类型点击事件
            $('#divNCData li a').click(function () {
                NCCodeId = $(this).attr("data-id");
                NCCode = $(this).attr("data-code");
                BindNCData();
            })
            //#endregion
        });
        function GetNCCodeList(NCGroupId) {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxClientController.uspGetNCCodeList(NCGroupId);
            if (ajax.error == null) {
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, "", ajax.error.Message);
                if (ajax.value.Rows.length > 0) {
                    var entity = ajax.value;
                    if (entity != null && entity.Rows.length > 0) {
                        var abHtml = "";
                        for (var i = 0; i < entity.Rows.length; i++) {
                            abHtml += '<li><a href="javascript:void(0)"  data-code="' + entity.Rows[i].NCCode + '" data-id="' + entity.Rows[i].NCCodeId + '">' + entity.Rows[i].NCCode + '</a></li>';
                        }
                    }
                    // abHtml += '<li><a href="javascript:void(0)"  data-code="Miscalculation" data-id="Miscalculation">误判</a></li>';
                    $("#ulNCData").append(abHtml);
                }
                else {
                    alert("工序未绑定不良代码");
                    return false;
                }
            }
            else {
                alert("工序绑定不良代码组错误!");
                return false;
            }
        }

        function BindNCData() {            
            var ajax_NC = SKT.LeanMES.Web.AjaxServices.AjaxClientController.ValidateAndExecActivity(hdnNCSerialNumber, hdnNCUserId, hdnNCResourceId, this.parent.routeId, hdnNCStationId, this.parent.proOrderId, NCCode, vaType);
            var List_NC = ajax_NC.value;
            var msg;
            if (List_NC == "不良信息采集成功!") {
                //更新送检单信息
                //window.parent.editInspection(2, hdnNCSerialNumber);              
                msg = hdnNCSerialNumber + ":" + List_NC + ":Defect Code" + ":" + NCCode;
                window.parent.showAreaMessge(msg, "messageGreen");
                window.parent.GetSNNCDetail(hdnNCSerialNumber, window.parent.stationId);
                window.parent.$("#collectionlist tr").find("td:eq(1)").each(function () {
                    if ($(this).text() == hdnNCSerialNumber) {
                        $(this).removeClass("collection-list-ok").addClass("collection-list-ng");
                        $(this).next().removeClass("collection-list-ok").addClass("collection-list-ng");
                        var statusControl = $(this).find('a').eq(0);
                        statusControl.removeClass("collection-list-ok").addClass("collection-list-ng");

                        statusControl = $(this).next().find('a').eq(0);
                        statusControl.text("NG");
                        statusControl.removeClass("collection-list-ok").addClass("collection-list-ng"); 
                    }
                });
            }
            else {
                msg = hdnNCSerialNumber + ":" + List_NC;
                window.parent.showAreaMessge(msg, "messageRed");
            } 
            alert(List_NC);
        }
       
    </script>
</asp:Content>
