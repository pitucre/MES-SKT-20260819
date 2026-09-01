<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/ViewMaster.master" CodeBehind="EquipmentRepairView.aspx.cs" Inherits="SKT.LeanMES.Web.Equipment.EquipmentRepairView" %>


<asp:Content runat="server" ContentPlaceHolderID="viewcontent">
    <style type="text/css">
        #layermsg {
            position: absolute;
            left: 50%;
            top: 50%;
            width: 700px;
            height: 500px;
            margin-left: -350px;
            margin-top: -250px;
            display: none;
            z-index: 999;
        }
    </style>
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label2" style="min-width: 70px;">维修单号</td>
            <td class="Field2">
                <asp:Label runat="server" ID="lblRepairNo"></asp:Label>
            </td>
            <td class="Label2">状态</td>
            <td class="Field2">
                <asp:Label runat="server" ID="lblStatusName"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2"><%= Resources.lang.EquipmentCode %></td>
            <td class="Field2">
                <asp:Label ID="lblEquipmentCode" runat="server" />
            </td>
            <td class="Label2"><%= Resources.lang.EquipmentName %></td>
            <td class="Field2">
                <asp:Label ID="lblEquipmentName" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">工序</td>
            <td class="Field2">
                <asp:Label runat="server" ID="lblStationName"></asp:Label>
            </td>
            <td class="Label2">故障部位</td>
            <td class="Field2">
                <asp:Label runat="server" ID="FaultLocation"></asp:Label>
            </td>
            <%--<td class="Label2">故障状况</td>
            <td class="Field2">
                <asp:Label runat="server" ID="FaultCause"></asp:Label>
            </td>--%>
        </tr>
        <tr>
            <%-- <td class="Label2">异常类型</td>
            <td class="Field2">
                <asp:Label runat="server" ID="lblAnormalTypeName"></asp:Label>
            </td>--%>
            <td class="Label2">
                <label>紧急程度</label>
            </td>
            <td class="Field2">
                <asp:Label runat="server" ID="lblUrgencyName"></asp:Label>
            </td>
            <td class="Label2">
                <label>是否停机</label>
            </td>
            <td class="Field2">
                <asp:Label runat="server" ID="lblStopFlagName"></asp:Label>
            </td>
        </tr>

        <tr>
            <td class="Label2">备件编码</td>
            <td class="Field2">
                <asp:Label runat="server" ID="lblPartNo"></asp:Label>
            </td>
            <td class="Label2">备件类型</td>
            <td class="Field2">
                <asp:Label runat="server" ID="lblPartType"></asp:Label>
                <%--   <asp:Label runat="server" ID="lblPartQty" Visible="true"></asp:Label>--%>
            </td>
        </tr>
        <tr>
            <td class="Label2">报修人
            </td>
            <td class="Field2">
                <asp:Label ID="lblCreateBy" runat="server"></asp:Label>
            </td>
            <td class="Label2">报修时间</td>
            <td class="Field2">
                <asp:Label ID="lblCreateDateTime" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">维修人</td>
            <td class="Field2">
                <asp:Label ID="lblRepairBy" runat="server"></asp:Label>
            </td>
            <td class="Label2">维修开始时间</td>
            <td class="Field2">
                <asp:Label ID="lblRepairSTime" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">维修结束时间</td>
            <td class="Field2">
                <asp:Label ID="lblRepairETime" runat="server"></asp:Label>
            </td>
            <td class="Label2">故障描述</td>
            <td class="Field2">
                <asp:Label ID="lblAnormalDesc" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">外修原因</td>
            <td class="Field2" colspan="3">
                <asp:Label ID="lblExternalRepairRemark" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">验收/拒收备注</td>
            <td class="Field2" colspan="3">
                <asp:Label ID="lblAcceptRemark" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">维修方法</td>
            <td class="Field2" colspan="3">
                <asp:Label ID="lblRepairFunction" runat="server"></asp:Label>
            </td>
        </tr>
       <%-- <tr>
            <td class="Label2">异常图片</td>
            <td class="Field2" colspan="3">
                <img src="" id="imgAnormalImg" style="max-width: 700px; max-height: 700px;" />
            </td>
        </tr>--%>
        <asp:HiddenField ID="hidimg" runat="server" ClientIDMode="Static" />
        <asp:HiddenField ID="hidRepairImg1" runat="server" ClientIDMode="Static" />
      
        
    </table>
    <div id="layermsg">
    </div>
    <script type="text/javascript">

        //获取文件
        function GetFilePath(action, fileName) {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEsop.LocalFileExists(fileName, action);
            var imgurl = "";
            if (ajax.value != "") {
                return ajax.value;
            }
            var fileUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/ESOP/DownLoad.aspx?Action=" + action + "&fileName=" + escape(fileName);

            $.ajax({
                url: fileUrl,
                type: "get",
                async: false,
                success: function () {

                    imgurl = "/UploadFiles/EquipmentFailure/" + fileName;

                }

            })
            return imgurl;
        }

        //var appU = $("#hidimg").val().split('/');
        //if (appU[appU.length - 1] != "") {

        //    var imgurl = GetFilePath("EquipmentFailure", appU[appU.length - 1]);
        //    $("#imgAnormalImg").attr("src", imgurl);
        //}

        var AnormalImgAttr = $("#hidimg").val().split(',');
        if (AnormalImgAttr.length > 0) {
            var display = " <td class=\"Label2\">异常图片</td><td align = 'Field2' >";
            for (var i = 0; i < AnormalImgAttr.length; i++) {
                var fileUrl = GetFilePath("EquipmentFailure", AnormalImgAttr[i]);
                display += "<img src=" + fileUrl + " onclick='showPic(this.src)' style='width:60px; height:50px; cursor:pointer; ' /> ";
            }
            $(".EditeContentTable").append("<tr>"
                + display
                + "</td></tr>");

        }


        var RepairImgAttr = $("#hidRepairImg1").val().split(',');
        if (RepairImgAttr.length > 0) {
            var display = " <td class=\"Label2\">维修图片</td><td align = 'Field2' >";
            for (var i = 0; i < RepairImgAttr.length; i++) {
                var fileUrl = GetFilePath("EquipmentFailure", RepairImgAttr[i]);
                display += "<img src=" + fileUrl + " onclick='showPic(this.src)' style='width:60px; height:50px; cursor:pointer; ' /> ";
            }
            $(".EditeContentTable").append("<tr>"
                + display
                + "</td></tr>");

        }




        //预览图片
        function showPic(picUrl) {
            var picContent = "<div id='divClose' title='关闭'>X</div><img width=\"700\" height=\"500\" src=" + picUrl + " />";
            var bodyheight = $("body").height();
            var bodywidth = $("body").width();

            $("#layermsg").html(picContent).show();
            $("#layermsg").bind("click", function () { $("#layermsg,#layer").hide(); });
            $("#layer").css({
                height: bodyheight,
                width: bodywidth,
                display: "block"
            });
        }

    </script>
</asp:Content>
