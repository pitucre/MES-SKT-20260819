<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="AccessoryRegister.aspx.cs" Inherits="SKT.LeanMES.Web.AccessoryManagement.AccessoryRegister" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %>
    </div>
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label2">锡膏物料条码(GRN)<em>*</em>
            </td>
            <td class="Field2" colspan="3">
                <input class="TextBox" id="txtHWMaterialCode"  style="width:80%;height:38px;font-size:18px;"/>
            </td>
        </tr>
    </table>
    <div id="activeinfo" class="active-info">
        <div id="activeinfoarea" class="active-info-area" >
        </div>
    </div>
    <style type="text/css">
        .active-info
        {
            padding-right: 10px;
            padding-top: 5px;
            padding-left: 1px;
        }

        .active-info-area
        {
            color: Red;
            background-color: #ebebe4;
            width: 100%;
            outline: none;
            border: 1px solid #d3d3d3;
            overflow:auto;
            font-size:12px;
            font-weight:normal;
            line-height:16px;
            padding:3px;
            height:100%;
        }
    </style>
    <script type="text/javascript">
        $(function () {
            $("#activeinfoarea").css("height", $(window).height() - 150 + "px");
        });
        $(document).ready(function () {
            $("#txtHWMaterialCode").focus();
            //条码回车
            $("#txtHWMaterialCode").keydown(function (e) {
                var eventflag = 0;
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    var grn = $.trim($("#txtHWMaterialCode").val());//华为物料条码
                    if (grn == "") {
                        alert("条码不能为空，请扫描！");
                        $("#txtHWMaterialCode").val("");
                        return false;
                    }
                    Save();
                }
            });
            //showAreaMessge("测试", "messageRed");
        });
        /*保存数据*/
        function Save() {
            var grn = $.trim($("#txtHWMaterialCode").val());//华为物料条码
            if (grn == "") {
                alert("条码不能为空，请扫描！");
                $("#txtHWMaterialCode").val("");
                return false;
            }
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxAccessory.AccessrySupplierMaterialRegister(grn);
            if (ajax.error != null) {
                showAreaMessge(ajax.error.Message, "messageRed");
                alert(ajax.error.Message);
                return false;
            }
            else {
                showAreaMessge("条码:" + grn + "注册成功！", "messageGreen");
                $("#txtHWMaterialCode").val("");
            }
        }
            //#region 设置消息提示框样式
            /*
            * 设置消息提示框样式
            */
        function showAreaMessge(information, styleClass) {
            var currentTime = getDateTime();
            var messageBox = $("#activeinfoarea");
            var rows = 100;


            messageBox.find("span").eq(rows - 2).nextAll().remove(); //显示50条扫描记录        
            var html = "<span  style='font-size:13px;font-weight:normal;' class=" + styleClass + ">" + "[" + currentTime + "] " + information + "</span>" + '<br/>' + messageBox.html();
            messageBox.empty();
            messageBox.append(html);

        }
            /**
            *获取当前时间
            */
        function getDateTime() {
            var now = new Date();
            var year = now.getFullYear();
            var month = now.getMonth() + 1;
            var date = now.getDate();
            var hour = now.getHours();
            var min = now.getMinutes();
            var sec = now.getSeconds();
            var day = now.getDay();

            month = (month < 10) ? '0' + month.toString() : month.toString();
            date = (date < 10) ? '0' + date.toString() : date.toString();
            hour = (hour < 10) ? '0' + hour.toString() : hour.toString();
            min = (min < 10) ? '0' + min.toString() : min.toString();
            sec = (sec < 10) ? '0' + sec.toString() : sec.toString();
            return year.toString() + '年' + month.toString() + '月' + date.toString() + "日  " + hour.toString() + ":" + min.toString() + ":" + sec.toString();
        }

        function isIE() { //ie?
            if (!!window.ActiveXObject || "ActiveXObject" in window)
                return true;
            else
                return false;
        }
        
    </script>

</asp:Content>
