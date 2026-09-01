<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    CodeBehind="MenuImport.aspx.cs" Inherits="SKT.LeanMES.Web.SystemConfiguration.MenuImport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <style type="text/css">
        #parent {
            z-index: 999999;
            position: relative;
        }

        #preloader_3 {
            position: absolute; /*参照物是父容器*/
            left: 50%;
            transform: translateX(-50%); /*百分比的参照物是自身*/
        }

            #preloader_3:before {
                width: 20px;
                height: 20px;
                border-radius: 20px;
                background: blue;
                content: '';
                position: absolute;
                background: #9b59b6;
                animation: preloader_3_before 1.5s infinite ease-in-out;
            }

            #preloader_3:after {
                width: 20px;
                height: 20px;
                border-radius: 20px;
                background: blue;
                content: '';
                position: absolute;
                background: #2ecc71;
                left: 22px;
                animation: preloader_3_after 1.5s infinite ease-in-out;
            }

        @keyframes preloader_3_before {
            0% {
                transform: translateX(0px) rotate(0deg);
            }

            50% {
                transform: translateX(50px) scale(1.2) rotate(260deg);
                background: #2ecc71;
                border-radius: 0px;
            }

            100% {
                transform: translateX(0px) rotate(0deg);
            }
        }

        @keyframes preloader_3_after {
            0% {
                transform: translateX(0px);
            }

            50% {
                transform: translateX(-50px) scale(1.2) rotate(-260deg);
                background: #9b59b6;
                border-radius: 0px;
            }

            100% {
                transform: translateX(0px);
            }
        }
    </style>
    <div class="infoTips">
        更新菜单后系统会刷新，请先保存好数据
    </div>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1">菜单文件
            </td>
            <td class="Field1">
                <asp:Label ID="lblMenuFile" runat="server" Text="" CssClass="Tips"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label1">权限文件
            </td>
            <td class="Field1">
                <asp:Label ID="lblPopedomFile" runat="server" Text="" CssClass="Tips"></asp:Label>
            </td>
        </tr>
    </table>
    <asp:HiddenField runat="server" ID="hdnFileExists" Value="0" />
    <div class="clear5">
    </div>
    <div id="onprocess" style="text-align: center;">
    </div>
    <div class="clear5">
    </div>
    <div id="parent">
        <div id="preloader_3"></div>
    </div>
    <div style="text-align: center;">
        <input type="button" id="btnImport" class="button" style="width: 100px; height: 25px;" title="更新菜单后系统会刷新，请先保存好数据" value="更新菜单" onclick="var context = new Object; Fun_Callback('await', context)" />
    </div>
    <script type="text/javascript" language="javascript">
        $(document).ready(function () {
            $("#parent").hide();
        });
        function UpdateMenu(Msg) {
            setTimeout(function () {
                if (Msg == "success") {
                    alert("菜单更新成功!");
                    $("#onprocess").removeClass("Tips");
                    $("#onprocess").html("");
                    top.location.href = top.location.href;
                }
                else {
                    alert(Msg);
                }
                $("#parent").hide();
                $("#btnImport").show();
            }, 10);
        }

        function Fun_Callback(msg, context) {
            if ($("#<%=this.hdnFileExists.ClientID %>").val() == "0") {
                alert("菜单和权限文件不存在，无法更新菜单。");
                return false;
            }
            if (!confirm("更新菜单后系统会刷新，请先保存好数据，是否现在就更新菜单？")) {
                return false;
            }
            $("#parent").show();
            $("#onprocess").addClass("Tips");
            $("#onprocess").html("正在更新菜单，请稍后...");
            $("#btnImport").hide();
            <%=this.ClientScript.GetCallbackEventReference(this,"msg","UpdateMenu","context")%>
        }
    </script>
</asp:Content>
