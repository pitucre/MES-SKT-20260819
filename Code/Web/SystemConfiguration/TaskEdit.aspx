<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/EditMaster.master" CodeBehind="TaskEdit.aspx.cs" Inherits="SKT.LeanMES.Web.SystemConfiguration.TaskEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <table width="100%" class="EditeContentTable">
        <tr>
            <td colspan="4" class="Label"><%=Resources.Messages.WithAsteriskIsRequired %></td>
        </tr>
        <tr>
            <td class="Label2"><%=Resources.lang.TaskName%><em>*</em></td>
            <td class="Field2" colspan="3">
                <asp:TextBox ID="txtTaskName" runat="server" CssClass="TextBox" IsRequired='1' ClientIDMode="Static"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2"><%=Resources.lang.ExecDll%><em>*</em></td>
            <td class="Field2" colspan="3">
                <asp:TextBox ID="txtExecDll" runat="server" CssClass="TextBox" IsRequired='1' ClientIDMode="Static" Style="width: 95%;"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2"><%=Resources.lang.StartTime%><em>*</em></td>
            <td class="Field2">
                <asp:TextBox ID="txtStartTime" runat="server" CssClass="TextBox" IsRequired='1' ClientIDMode="Static" Style="width: 150px;"></asp:TextBox>
            </td>
            <td class="Label2"><%=Resources.lang.EndTime%></td>
            <td class="Field2">
                <asp:TextBox ID="txtEndTime" runat="server" CssClass="TextBox" ClientIDMode="Static" Style="width: 150px;" autocomplete="off"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2"><%=Resources.lang.IntervalTime%></td>
            <td class="Field2" colspan="3">
                <asp:TextBox ID="txtIntervalTime" runat="server" CssClass="TextBox" IsRequired='1' ClientIDMode="Static" autocomplete="off"></asp:TextBox>Min
            </td>
        </tr>
        <tr>
            <td class="Label2"><%=Resources.lang.Trigger%><em>*</em></td>
            <td class="Field2" colspan="3">
                <asp:DropDownList ID="ddlTigger" runat="server" ClientIDMode="Static" Width="80px">
                    <asp:ListItem Value="1" Text="<%$ Resources:lang, EveryDay %>"></asp:ListItem>
                    <asp:ListItem Value="2" Text="<%$ Resources:lang, EveryWeek %>"></asp:ListItem>
                </asp:DropDownList>
                <span class="trigger day"></span>
                <span class="trigger week" style="display: none;">
                    <input type="checkbox" name="week" value="7" /><%=Resources.lang.Sunday%>
                    <input type="checkbox" name="week" value="1" /><%=Resources.lang.Monday%>
                    <input type="checkbox" name="week" value="2" /><%=Resources.lang.Tuesday%>
                    <input type="checkbox" name="week" value="3" /><%=Resources.lang.Wednesday%>
                    <input type="checkbox" name="week" value="4" /><%=Resources.lang.Thursday%>
                    <input type="checkbox" name="week" value="5" /><%=Resources.lang.Friday%>
                    <input type="checkbox" name="week" value="6" /><%=Resources.lang.Saturday%>
                </span>
            </td>
        </tr>
        <tr>
            <td class="Label2"><%=Resources.lang.TaskDesc%></td>
            <td class="Field2" colspan="3">
                <asp:TextBox ID="txtTaskDesc" runat="server" CssClass="TextBox" ClientIDMode="Static" Style="width: 95%;"></asp:TextBox>
            </td>
        </tr>
        <asp:HiddenField ID="hidTaskId" runat="server" ClientIDMode="Static" />
        <asp:HiddenField ID="hidTiggerValue" runat="server" ClientIDMode="Static" />
    </table>
    <script type="text/javascript">
        $(function () {
            //绑定日期选择框
            $("#<%=this.txtStartTime.ClientID%>").datepicker({
                buttonImageOnly: true,
                showHms: true
            });

            //绑定生产日期选择框
            $("#<%=this.txtEndTime.ClientID%>").datepicker({
                buttonImageOnly: true,
                showHms: true
            });

            $("#ddlTigger").change(function () {
                showTigger();
            });
            var tiggerValue = $("#hidTiggerValue").val();
            if (tiggerValue != "") {
                var arr = tiggerValue.split(",");
                $("input[name=\"week\"]").each(function (idx) {
                    //tiggerValue += idx == 0 ? "" : "," + $(this).val();
                    if (arr.indexOf($(this).val()) > -1) {
                        $(this).prop("checked", true);
                    }
                });
            }

            showTigger();

        });

        function showTigger() {
            var val = $("#ddlTigger").val();
            if (val == "1") {
                $(".trigger").hide();
                $(".day").show();
            } else if (val == "2") {
                $(".trigger").hide();
                $(".week").show();
            }
        }

        /*保存数据*/
        function Save() {
            var txtTaskName = $.trim($("#<%=this.txtTaskName.ClientID%>").val());
            var txtExecDll = $.trim($("#<%=this.txtExecDll.ClientID%>").val());
            var txtStartTime = $.trim($("#<%=this.txtStartTime.ClientID%>").val());
            var txtEndTime = $.trim($("#<%=this.txtEndTime.ClientID%>").val());
            var txtIntervalTime = $.trim($("#<%=this.txtIntervalTime.ClientID%>").val());
            var txtTaskDesc = $.trim($("#<%=this.txtTaskDesc.ClientID%>").val());
            var ddlTigger = $.trim($("#<%=this.ddlTigger.ClientID%>").val());
            var tiggerValue = "";
            $("input[name=\"week\"]:checked").each(function (idx) {
                tiggerValue += idx == 0 ? $(this).val() : "," + $(this).val();
            });


            /*表单验证*/
            /*如需表单验证可以此处处理验证 开始*/
            if (txtIntervalTime == "") {
                txtIntervalTime = -1;
            } else if (!isInteger(txtIntervalTime)) {
                alert("时间间隔（分钟）格式不正确");
                return false;
            }

            var entity = {};
            entity.TaskId = parseInt($("#hidTaskId").val());
            entity.TaskName = txtTaskName;
            entity.ExecDll = txtExecDll;
            //entity.StartTime = txtStartTime;
            //entity.EndTime = txtEndTime;
            entity.IntervalTime = parseInt(txtIntervalTime);
            entity.TaskDesc = txtTaskDesc;
            entity.Trigger = parseInt(ddlTigger);
            entity.Trigger_Value = tiggerValue;

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxTask.EditTask(entity, txtStartTime, txtEndTime);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            alert('<%=Resources.Messages.SaveInSuccess%>')
            parent.window.Refresh();
        }

        //验证整数（包括0）
        function isInteger(val) {
            var reg = /^-?\d+$/;
            return reg.test(val);
        }
    </script>
</asp:Content>
