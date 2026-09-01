<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PrepMaSubitemChangeHist.aspx.cs" Inherits="SKT.LeanMES.Web.MaterialDelivery.PrepMaSubitemChangeHist" MasterPageFile="~/Masters/ViewMaster.master"%>


<asp:Content ContentPlaceHolderID="viewcontent" runat="server">
    <div class="divHeader">备料清单子项变更历史</div>
    <table class="ListTable" width="100%">
        <tr class="ListTableHeader" id="trPrepHeadertList">
            
        </tr>
    </table>

    <div style="overflow:auto;height:300px;width:100%">
        <table class="ListTable" width="100%" id="tbPrepDetailList">
    
        </table>
    </div>

<script type="text/javascript">

    var Id = <%= Request.QueryString["Id"] == null ? -1 : Convert.ToInt32(Request.QueryString["Id"].ToString())%>

    $(document).ready(function () {
        setPrepareHeader();
        getSubitemChangeHistory();

    })


    //获取备料单变更明细列表
    function getSubitemChangeHistory() {
        var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialDelivery.GetSubitemChangeHistory(Id)
        if (ajax.error != null) {
            alert(ajax.error.Message)
            return false;
        }
        var html = "";
        var list = ajax.value;


        if (list.length > 0) {
            var imghtml = "<img src='<%=SKT.LeanMES.Web.WebHelper.WebRoot%>/content/images/arrowDown.gif'/>";

            for (var i = 0; i < list.length; i++) {
                if(list[i].IsCurrent == true)
                {
                    imghtml = "End";
                }
                html += list[i].RecordTypeStr == "删除" ? "<tr class='ListTableOddRow' style='color:gray;'>" : "<tr class='ListTableOddRow'>";
                html += "<td style='width:9%'>"+ imghtml +"</td>";
                html += "<td style='width:20%'>" + list[i].MaterialNO + "</td>";
                html += "<td style='width:10%'>" + list[i].RequestQty + "</td>";
                html += "<td style='width:15%'>" + list[i].CreateBy + "</td>";
                html += "<td style='width:20%'>" + list[i].CreateDateTime.toLocaleString() + "</td>";
                html += "<td style='width:8%'>" + list[i].RecordTypeStr + "</td>";
                html += "<td style='width:8%'>" + list[i].IsCurrentStr + "</td>";
 
                html += "</tr>";
            }

            $("#tbPrepDetailList").html(html);
        }
        else {
            html += "<tr class='ListTableEmptyDataRow'><td colspan='7'>暂无数据</td></tr>";
            $("#tbPrepDetailList").html(html);
        }
    }

    function setPrepareHeader() {
        var html = "";

            html += '<th style="width:9%">变更方向</th>'
            html += '<th style="width:20%">物料编码</th>'
            html += '<th style="width:10%">数量</th>'
            html += '<th style="width:15%">创建人</th>'
            html += '<th style="width:20%">创建时间</th>'
            html += '<th style="width:8%">操作类型</th>'
            html += '<th style="width:8%">版本</th>'


        $("#trPrepHeadertList").html(html);
    }
</script>
</asp:Content>
