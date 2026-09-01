<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PrepareMaterialDetail.aspx.cs" Inherits="SKT.LeanMES.Web.MaterialDelivery.PrepareMaterialDetail" MasterPageFile="~/Masters/ViewMaster.master"%>

<asp:Content ContentPlaceHolderID="viewcontent" runat="server">

    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">备料单号</td>
            <td class="Field2">
                <asp:Label runat="server" ID="lblPrepareNO"></asp:Label>
            </td>
            <td class="Label2">工单号码</td>
            <td class="Field2">
                <asp:Label runat="server" ID="lblOrderNO"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">工艺段</td>
            <td class="Field2">
                <asp:Label runat="server" ID="lblSection"></asp:Label>
            </td>
            <td class="Label2">产品编码</td>
            <td class="Field2">
                <asp:Label runat="server" ID="lblProductCode"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">需求数量</td>
            <td class="Field2">
                <asp:Label runat="server" ID="lblRequestQty"></asp:Label>
            </td>
            <td class="Label2">需求日期</td>
            <td class="Field2">
                <asp:Label runat="server" ID="lblRequestDate"></asp:Label>
            </td>
        </tr>
    </table>

    <div class="divHeader">备料清单明细</div>
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
    var c = <%= Request.QueryString["c"] == null ? -1 : Convert.ToInt32(Request.QueryString["c"].ToString())%>

    $(document).ready(function () {
        setPrepareHeader();

        if(c == 1)
        {
            getPrepareMaterialChangeDetailList();
        }
        else
        {
            getPrepareMaterialDetailList();
        }
    })


    //获取备料单明细列表
    function getPrepareMaterialDetailList() {

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialDelivery.GetMaterialPrepareDetail(Id)
            if (ajax.error != null) {
                alert(ajax.error.Message)
                return false;
            }
            var html = "";
            var list = ajax.value;

            if(list.length > 0)
            {
                for(var i = 0 ; i < list.length; i++)
                {
                    html += "<tr class='ListTableOddRow'>";
                    html += "<td style='width:10%'>"+ (i+1).toString() +"</td>";
                    html += "<td style='width:36%'>"+ list[i].MaterialNO +"</td>";
                    html += "<td style='width:20%'>"+ list[i].RequestQty +"</td>";
                    html += "<td style='width:17%'>"+ list[i].LineName +"</td>";
                    html += "<td style='width:17%'>"+ list[i].ShiftName +"</td>";
                    html += "</tr>";
                }

                $("#tbPrepDetailList").html(html);
            }
            else
            {
                html += "<tr class='ListTableEmptyDataRow'><td colspan='3'>暂无数据</td></tr>";
                $("#tbPrepDetailList").html(html);
            }
    }

    //获取备料单变更明细列表
    function getPrepareMaterialChangeDetailList() {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialDelivery.GetMaPrepChangeDetail(Id)
            if (ajax.error != null) {
                alert(ajax.error.Message)
                return false;
            }
            var html = "";
            var list = ajax.value;

            if(list.length > 0)
            {
                for(var i = 0 ; i < list.length; i++)
                {
                    html += list[i].RecordTypeStr == "" ? "<tr class='ListTableOddRow' style='color:gray;'>" : "<tr class='ListTableOddRow'>";
                    html += "<td style='width:3%'>"+ (i+1).toString() +"</td>";
                    html += "<td style='width:20%'>"+ list[i].MaterialNO +"</td>";
                    html += "<td style='width:9%'>"+ list[i].RequestQty +"</td>";
                    html += "<td style='width:9%'>"+ list[i].LineName +"</td>";
                    html += "<td style='width:9%'>"+ list[i].ShiftName +"</td>";
                    html += "<td style='width:9%'>"+ list[i].CreateBy +"</td>";
                    html += "<td style='width:16%'>"+ list[i].CreateDateTime.toLocaleString() +"</td>";
                    html += "<td style='width:8%'>"+ list[i].RecordTypeStr +"</td>";
                    html += "<td style='width:8%'>"+ list[i].Times +"</td>";
                    html += "<td style='width:8%'><div style='width:80%;margin:0px auto;line-height:22px;height:22px;border:solid 1px blue;text-align:center' onclick='getSubitemChangeHistory(this,"+list[i].Id+")' name='viewhis'>查看历史</div></td>"
                    html += "</tr>";
                }

                $("#tbPrepDetailList").html(html);
            }
            else
            {
                html += "<tr class='ListTableEmptyDataRow'><td colspan='10'>暂无数据</td></tr>";
                $("#tbPrepDetailList").html(html);
            }
    }

    //设置明细列表 表头
    function setPrepareHeader()
    {
        var html = "";

        if(c == 1)
        {
            html += '<th style="width:3%">行号</th>'
            html += '<th style="width:20%">物料编码</th>'
            html += '<th style="width:9%">数量</th>'
            html += '<th style="width:9%">线体</th>'
            html += '<th style="width:9%">班次</th>'
            html += '<th style="width:9%">创建人</th>'
            html += '<th style="width:16%">创建时间</th>'
            html += '<th style="width:8%">最后操作</th>'
            html += '<th style="width:8%">变更次数</th>'
            html += '<th style="width:8%">变更历史</th>'
        }
        else
        {
            html += '<th style="width:10%">行号</th>'
            html += '<th style="width:36%">物料编码</th>'
            html += '<th style="width:20%">数量</th>'
            html += '<th style="width:17%">线体</th>'
            html += '<th style="width:17%">班次</th>'
        }

        $("#trPrepHeadertList").html(html);
    }

    //获取备料子项的变更历史
    function getSubitemChangeHistory(obj,id)
    {
        $("[name='viewhis']").css("background-color","").css("color","")
        $(obj).css("background-color","#4AA9C3").css("color","white")
        openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/MaterialDelivery/PrepMaSubitemChangeHist.aspx?name=MaterialDelivery_PrepMaSubitemChangeHist&Id=" + id;
        dialog({ title: "<%= Resources.Pages.MaterialDelivery_PrepMaSubitemChangeHist %>", src: openWinUrl, width: 800, height: 500, resizeable: false });
    }
</script>
</asp:Content>