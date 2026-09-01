<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    CodeBehind="PreviewConfig.aspx.cs" Inherits="SKT.LeanMES.Web.Plan.PreviewConfig" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <div id="onprocess" style="text-align: center;">
    </div>
    <div class="wrap_tb">
        <div class="tb_c">
            <div class="infoTips">
                <%= Resources.Messages.WithAsteriskIsRequired %>
            </div>
            <div class="divHeader">
                <img src="../Content/images/icon/edit_dblink.png" class="imgText" />&nbsp;<span>预排产配置</span>
            </div>
            <table class="EditeContentTable" width="100%">

                <tr>
                    <td class="Label1">预排显示天数<em>*</em>
                    </td>
                    <td class="Field1">
                        <asp:TextBox runat="server" ID="txtDay" Text="" IsRequired='1' CssClass="TextBox MESDB"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="Label1">多线同时排产
                    </td>
                    <td class="Field1">
                        <asp:DropDownList runat="server" ID="ddlIsTsPlan">
                            <asp:ListItem Text="否" Value="0"></asp:ListItem>
                            <asp:ListItem Text="是" Value="1"></asp:ListItem>
                        </asp:DropDownList><span
                            class="Tips">注：默认为否,优先排满一条线的预排天数,再排第二条线 </span>
                    </td>
                </tr>
            </table>
            <div class="clear5">
            </div>
            <div class="divHeader">
                <img src="../Content/images/icon/edit_dblink.png" class="imgText" />&nbsp;<span>插单配置</span>
            </div>
               <table class="EditeContentTable" width="100%">
                <tr>
                    <td class="Label1">检查线别负荷
                    </td>
                    <td class="Field1">
                        <asp:DropDownList runat="server" ID="ddlIsCheckLoad">
                            <asp:ListItem Text="否" Value="0"></asp:ListItem>
                            <asp:ListItem Text="是" Value="1"></asp:ListItem>
                        </asp:DropDownList><span
                            class="Tips"></span>
                    </td>
                </tr>
            </table>
             <div class="clear5">
            </div>
            <div class="divHeader">
                <img src="../Content/images/icon/edit_dblink.png" class="imgText" />&nbsp;<span>自动排产执行配置</span>
            </div>
               <table class="EditeContentTable" width="100%">

                <tr>
                    <td class="Label1">每日计划时间<em>*</em>
                    </td>
                    <td class="Field1">
                        <asp:TextBox runat="server" ID="txtPlanTime" IsRequired='1' onblur="ValTimeZx(this,1)" onkeyup="this.value=this.value.replace(/\D/g,\'\')" onafterpaste="this.value=this.value.replace(/\D/g,\'\')" Text="" CssClass="TextBox MESDB"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="Label1">是否启用
                    </td>
                    <td class="Field1">
                        <asp:DropDownList runat="server" ID="ddlIsEnable">
                            <asp:ListItem Text="否" Value="0"></asp:ListItem>
                            <asp:ListItem Text="是" Value="1"></asp:ListItem>
                        </asp:DropDownList><span
                            class="Tips"></span>
                    </td>
                </tr>
            </table>
             <div class="clear5">
            </div>
            <div class="divHeader">
                <img src="../Content/images/icon/edit_dblink.png" class="imgText" />&nbsp;<span>备注</span>
            </div>
               <table class="EditeContentTable" width="100%">

                <tr>
                    <td class="Label1"  colspan="3"><span>备注</span>
                    </td>
                 <td class="Field1" colspan="3">
                  <asp:TextBox ID="txtRemark" CssClass="TextArea" TextMode="MultiLine" runat="server"
                    Width="400px"></asp:TextBox>
                </td>
                   
                </tr>
                
            </table>
        </div>

    </div>
    <div style="height: 38px;">
        <div id="loading" style="display: none; z-index: 111;">
            <div style="background: #cccccc; position: absolute; z-index: 112; top: 0; left: 0px; filter: Alpha(opacity=60); -moz-opacity: 0.6; opacity: 0.6;"
                id="loading-bg">
            </div>
            <div style="position: absolute; top: 35%; left: 35%; z-index: 113; background: #f7f7f7; width: 360px; border: 1px solid #333333; height: 65px; line-height: 65px; text-align: center;"
                id="loading-content">
                正在执行方法,请耐心等待...
            </div>
        </div>
    </div>
    <link href="../Content/plugin/tabs/tabs.css" rel="stylesheet" type="text/css" />
    <script src="../Content/plugin/tabs/jPlugin-tabs.js" type="text/javascript"></script>
    <script language="javascript" type="text/javascript">
        var isChanged = false;
        $(document).ready(function () {
            showCloseReason(false);
        });
        function showCloseReason(t) {
            $(".MESDB").change(function () {
                isChanged = true;
            });
        }
        function ValTimeZx(obj, type) {

            var timeValue = $(obj).val();
            if (timeValue.length <= 0) {
                return;
            }
            $(obj).val(intToTime($(obj).val()));
            timeValue = $(obj).val();
            var reg = /^(\d{1,2}):(\d{1,2})$/;
            var r = timeValue.match(reg);
            if (r == null) {
                alert("输入格式不正确，请按HH:mm的格式输入！");
                $(obj).val("");
                $(obj).focus();
                return;
            }
            var strs = new Array();
            strs = timeValue.split(":");
            if (parseInt(strs[0]) > 23 || parseInt(strs[1]) > 59) {
                alert("时间值不正确，小时不得大小23，分钟不得大于59！");
                $(obj).val("");
                $(obj).focus();
                return;
            }
        }
        function Save() {
            $("#onprocess").addClass("Tips");
            $("#onprocess").html("数据正在保存，请稍后...");
            setTimeout(function () {
                var txtDay = $("#<%=this.txtDay.ClientID %>").val();

                var entity = {};
                entity.IsEnable = $("#<%=this.ddlIsEnable.ClientID %>").val();
                entity.IsLine = $("#<%=this.ddlIsTsPlan.ClientID %>").val();
                entity.PlanTime = $("#<%=this.txtPlanTime.ClientID %>").val();
                entity.IsCheckLoad = $("#<%=this.ddlIsCheckLoad.ClientID %>").val();
                entity.PreviewDay = $("#<%=this.txtDay.ClientID %>").val();
                entity.Remark = $("#<%=this.txtRemark.ClientID %>").val();


                if (isNull(txtDay)) {
                    alert("预排天数不能为空！");
                    styleErrorControl($("#<%=this.txtDay.ClientID %>"));
                    return false;
                }
              
                if (txtDay < 0 && txtDay>31) {
                    alert("预排天数不能小于0大于31！");
                    styleErrorControl($("#<%=this.txtDay.ClientID %>"));
                    return false;
                }

                var ajax = SKT.LeanMES.Web.Plan.PreviewConfig.Save(entity);

                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                } else {
                    alert("保存成功!");
                    $("#onprocess").removeClass("Tips");
                    $("#onprocess").html("");
                }

            }, 10);

        }




    </script>
</asp:Content>
