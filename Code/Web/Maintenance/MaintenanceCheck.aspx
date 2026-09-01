<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    CodeBehind="MaintenanceCheck.aspx.cs" Inherits="SKT.LeanMES.Web.Maintenance.MaintenanceCheck" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <style type="text/css">
        .tdspan {
            display: block;
            border-top: 1px solid #d3d3d3;
            width: 105%;
            padding-bottom: 2px;
            margin-left: -7px;
        }

        .span0 {
            border: none;
        }

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

        input[type="button"]{
            cursor:pointer;
            width:55px;
        }
    </style>
    <table class="EditeContentTable" width="100%">

        <tr id="trEquiment" runat="server">
            <td class="Label2">
                <%= Resources.lang.EquipmentCode%>
            </td>
            <td class="Field2">
                <asp:Label runat="server" ID="lblEquipmentCode"></asp:Label>
            </td>
            <td class="Label2">
                <%= Resources.lang.EquipmentName%>
            </td>
            <td class="Field2">
                <asp:Label runat="server" ID="lblEquipmentName"></asp:Label>
            </td>
        </tr>
        <%--  <tr style="display: none;">
            <td class="Label2">
                <%= Resources.lang.LineName%>
            </td>
            <td class="Field2">
                <asp:Label runat="server" ID="lblLineName"></asp:Label>
            </td>
            <td class="Label2">
                <%= Resources.lang.StationName%>
            </td>
            <td class="Field2">
                <asp:Label runat="server" ID="lblStation"></asp:Label>
            </td>
        <--%>
        <tr>
            <td class="Label2">
                <%= Resources.lang.MaintainWay%>
            </td>
            <td class="Field2">
                <asp:Label runat="server" ID="lblMaintainWay"></asp:Label>
            </td>
            <td class="Label2">
                <%= Resources.lang.CycleType%>
            </td>
            <td class="Field2">
                <asp:Label runat="server" ID="lblCycleType"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.CycleTime%>
            </td>
            <td class="Field2">
                <asp:Label runat="server" ID="lblCycleTime"></asp:Label>
            </td>
            <td class="Label2">
                <%= Resources.lang.PreWarning%>
            </td>
            <td class="Field2">
                <asp:Label runat="server" ID="lblPrewarning"></asp:Label>
            </td>
        </tr>
        <tr id="trByUsage" runat="server">
            <td class="Label2">
                <%= Resources.lang.EquipmentLifeTime%>
            </td>
            <td class="Field2">
                <asp:Label runat="server" ID="lblEquipmentLifeTime"></asp:Label>
            </td>
            <td class="Label2">
                <%= Resources.lang.EquipmentUsedTimes%>
            </td>
            <td class="Field2">
                <asp:Label runat="server" ID="lblEquipmentUserCount"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.MaintainActionPerson%>
            </td>
            <td class="Field2">
                <asp:Label runat="server" ID="lblMaintainPerson"></asp:Label>
            </td>
            <td class="Label2">
                <%=Resources.lang.PreWarningReceivePerson%>
            </td>
            <td class="Field2">
                <asp:Label runat="server" ID="lblRecipient"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.PreWarningReceiveEmail%>
            </td>
            <td class="Field2">
                <asp:Label runat="server" ID="lblRecipientEmail"></asp:Label>
            </td>
            <td class="Label2">
                <%= Resources.lang.LastMaintainTime%>
            </td>
            <td class="Field2">
                <asp:Label runat="server" ID="lblLastDateTime"></asp:Label>
            </td>
        </tr>
        <%--<tr>
            <td class="Label2">
                <%= Resources.lang.MaintainDetail%>
            </td>
            <td class="Field2" colspan="3" style="height:100px">
                <asp:Label runat="server" ID="lblMaintainContents"></asp:Label>
            </td>
        </tr>--%>
    </table>
    <div class="clear5">
    </div>
    <table class="ListTable" id="tbDemo" style="width: 100%;">
        <tr class="ListTableHeader">
            <th style="width: 20%;">
                <%= Resources.lang.MaintenanceDemoName%>
            </th>
            <th style="width: 30%;">作业编号
            </th>
            <th style="width: 30%;">作业名称
            </th>
            <th style="width: 30%;">作业内容
            </th>
             <th style="width: 30%;">参考图片
            </th>
            <th style="width: 30%;">是否保养
            </th>
            <th style="width: 30%;">保养图片
            </th>
            <th>操作 <input value='一键保养'  type='button' onclick='ClickCbAll()' />
            </th>
        </tr>
        <tbody id="tbody">
        </tbody>
    </table>
    <div id="layermsg">
    </div>

    <link href="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/layui/css/layui.css" rel="stylesheet" />
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/layui/layui.all.js"></script>
    <link type="text/css" href="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/uploadify/uploadify.css"
        rel="Stylesheet" />
    <script type="text/javascript" src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/uploadify/jquery.uploadify.min.js"></script>
    <script type="text/javascript">

        var Id = <%= Request.QueryString["Id"] == null ? -1 : Convert.ToInt32(Request.QueryString["Id"].ToString())%>
            $(document).ready(function () {
                //如果是在列表页点击的新增，编辑。
                GetDemoListByPlanId(Id);
            });

        /*通过计划id获取保养项目列表*/
        function GetDemoListByPlanId(eid) {
            var myajax = SKT.LeanMES.Web.AjaxServices.AjaxMaintenancRelation.GetMyRelationList(eid, 1);
            if (myajax.error != null) {
                alert(myajax.error.Message);
                return false;
            }
            if (myajax != null) {
                var tbody = $("#tbody");

                var html = "";
                var btnHtml = "";
                var demoID;
                var demoSubId;
                var objTd;
                var count;
                for (var i = 0; i < myajax.value.Rows.length; i++) {
                    html = "";
                    html += "<tr class='ListTableOddRow' id='" + myajax.value.Rows[i].DemoSubId + "' name='tr" + myajax.value.Rows[i].DemoId + "'>";

                    demoID = myajax.value.Rows[i].DemoId;
                    demoSubId = myajax.value.Rows[i].DemoSubId;
                    objTd = $("#td_" + demoID);
                    if (parseInt(objTd.length) <= 0 || objTd == null) {
                        count = 0;
                        for (var j = 0; j < myajax.value.Rows.length; j++) {
                            if (myajax.value.Rows[j].DemoId == demoID) {
                                count += 1;
                            }
                        }
                        html += count > 1 ? "<td id='td_" + demoID + "' rowspan='" + count + "'  >" : "<td id='td_" + demoID + "'>";
                        html += myajax.value.Rows[i].DemoName;
                        html += "</td>";
                    }

                    //作业编码
                    html += "<td style='text-align:center;'>";
                    html += myajax.value.Rows[i].DemoSubCode;
                    html += "</td>";

                    //作业名称
                    html += "<td style='text-align:center;'>";
                    html += myajax.value.Rows[i].DemoSubName;
                    html += "</td>";

                    //作业内容
                    html += "<td style='text-align:center;'>";
                    html += myajax.value.Rows[i].Remark;
                    html += "</td>";



                    //参考图片
                    html += "<td style='text-align:center;'>";
                    if (myajax.value.Rows[i].SaveFileName != "") {
                        var fileUrl = GetFilePath("EquipmentFailure", myajax.value.Rows[i].SaveFileName);
                        html += "<img src =" + fileUrl + "  onclick='showPic(this.src)' style='width:60px; height:50px; cursor:pointer; ' />";
                    } 
                    html += "</td>";

                    //是否已保养
                    html += "<td style='text-align:center;' class='IsDone'>";
                    html += myajax.value.Rows[i].IsDone == 1 ? "已保养" : "未保养";
                    html += "</td>";

                    html += "<td style='text-align:center;' name='ImageClass'>";
                    if (myajax.value.Rows[i].FileSaveName != "") {
                        var fileUrl = GetFilePath("EquipmentFailure", myajax.value.Rows[i].FileSaveName);
                        html += "<img src =" + fileUrl + "  onclick='showPic(this.src)' style='width:60px; height:50px; cursor:pointer; ' /><input type='hidden' id='FileName" + demoSubId + "' value='" + myajax.value.Rows[i].FileSaveName + "'/>";
                    } else {
                        html += "<input type='hidden' id='FileName" + demoSubId + "' value=''/>";
                    }

                    html += "</td>";

                    if (myajax.value.Rows[i].IsDone == 1) {
                        btnHtml = "<input style='width:55px' id='" + demoID + "and" + demoSubId + "' value='取消保养' type='button' onclick='ClickCb(" + Id + "," + demoID + "," + demoSubId + ",this," + myajax.value.Rows[i].IsDone + ")' this.value=''''' />";

                    } else {
                        btnHtml = "<input style='width:55px' id='" + demoID + "and" + demoSubId + "' value='保养'  type='button' onclick='ClickCb(" + Id + "," + demoID + "," + demoSubId + ",this," + myajax.value.Rows[i].IsDone + ")' />";
                        btnHtml += "<input style='width:55px' demoSubId='" + demoSubId + "' value='上传图片' name='ipfileUpload' id='upload-image" + demoSubId + "'  type='button'   />";

                    }
                    //是否已保养
                    html += "<td style='text-align:center;'>";
                    html += btnHtml;
                    html += "</td>";
                    html += '</tr>';
                    tbody.append(html);
                    count = 0;
                    if (myajax.value.Rows[i].IsDone == 1) {
                        $("#" + myajax.value.Rows[i].DemoId + "and" + myajax.value.Rows[i].DemoSubId).prop("checked", true);
                    }


                }
                UpLoad();
            }
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
        function UpLoad() {
         
            var username = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';
            layui.use('upload', function () {
                var $ = layui.jquery, upload = layui.upload;

                $("input[name=ipfileUpload]").each(function () {
                  
                    var id = $(this).attr("demoSubId");
                    var idStr = '#upload-image' + id
                    //图片上传
                    upload.render({
                        elem: idStr,
                        url: '<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Handler/UploadHander.ashx',
                        data: { Action: "EquipmentFailure", userName: username },
                        exts: 'jpg|jpge|gif|png', //只允许上传excel文件
                        size: 10240,//限制文件大小，单位 KB
                        multiple: true,
                        done: function (res) {
                            debugger;
                            //如果上传失败
                            if (res.msg != "上传成功") {
                                alert("上传失败:" + res.msg);
                                return false;
                            }
                            var fileUrl = GetFilePath("EquipmentFailure", res.data.FileName);
                            var display = "<img src =" + fileUrl + "  onclick='showPic(this.src)' style='width:60px; height:50px; cursor:pointer; ' /><input type='hidden' id='FileName" + id + "' value='" + res.data.FileName + "'/>";
                            $("#" + id).find("td[name='ImageClass']").html(display);


                        },
                        before: function (obj) {
                        },
                        error: function () {
                            //debugger;
                            alert("上传失败！");
                        }
                    });

                });
            });
        }

        /*勾选*/
        function ClickCb(Id, demoId, demoSubId, obj, isDone) {
            var temp = 0;
            if (confirm("确认要操作？")) {
                if (isDone == 0) {
                    temp = 1;
                }
                else {
                    temp = 0;
                }

                var fileName = $("#FileName" + demoSubId).val();
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaintenancRelation.UpdateDemoList(parseInt(Id), parseInt(demoId), parseInt(demoSubId), temp, fileName);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }

                alert("操作成功！");
                $("#tbody").html("");
                GetDemoListByPlanId(Id);


            }
        }

        function ClickCbAll() {
            if (confirm("确认要一键保养？")) {
                $("#tbody tr").each(function (i) {
                   
                    var demoId = $(this).attr("name").replace("tr", "");
                    var demoSubId = $(this).attr("id");
                    var temp = $(this).find(".IsDone").html()=="未保养"?1:0;
                    var fileName = $("#FileName" + demoSubId).val();
                    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaintenancRelation.UpdateDemoList(parseInt(Id), parseInt(demoId), parseInt(demoSubId), temp, fileName);
                    if (ajax.error != null) {
                        alert(ajax.error.Message);
                        return false;
                    }
                })


                alert("操作成功！");
                $("#tbody").html("");
                GetDemoListByPlanId(Id);
            }
        }
    </script>
</asp:Content>
