<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master"
    AutoEventWireup="true" CodeBehind="UpdateGRNState.aspx.cs" Inherits="SKT.LeanMES.Web.Material.UpdateGRNState" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label4">GRN<em>*</em>
            </td>
            <td class="Field4">
                <asp:TextBox ID="txtGRN" runat="server" CssClass="TextBox"  ClientIDMode="Static" Width="80%"></asp:TextBox>
            </td>
        </tr>
    </table>
    <div style="height: 5px"></div>
    <div id="activeinfo" class="active-info">
        <div id="activeinfoarea" class="active-info-area"></div>
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
            overflow: auto;
            font-size: 14px;
            font-weight: normal;
            line-height: 16px;
            padding: 3px;
            min-height: 70px;
        }
    </style>
    <script type="text/javascript">
        $(function () {
            $("#txtGRN").keydown(function (e) {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    UpdateGRNState();
                    return false;
                }
            });

        })

        //修改GRN状态
        function UpdateGRNState() {
            var GRN = $("#txtGRN").val();
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.UpdateGRNState(GRN);
            if (ajax.error != null) {
                showAreaMessge("GRN：[" + GRN + "]" + ajax.error.Message, "messageRed"); //messageRed,messageGreen
                $("#txtGRN").val("").focus();
                return false;
            }
            showAreaMessge("GRN：[" + GRN + "]修改状态成功", "messageGreen"); //messageRed,messageGreen
            $("#txtGRN").val("").focus();
        }
        //#region 设置消息提示框样式
        /*
        * 设置消息提示框样式
        */
        function showAreaMessge(information, styleClass) {
            var currentTime = getDateTime();
            var messageBox = $("#activeinfoarea");
            var rows = 100;

            messageBox.find("span").eq(rows - 2).nextAll().remove();        
            var html = "<span  class=" + styleClass + " style='font-size: 13px'>" + "[" + currentTime + "] " + information + "</span>" + '<br/>' + messageBox.html();
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
        //#endregion
    </script>
</asp:Content>
