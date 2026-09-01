<%@ Page Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="True"
    CodeBehind="PrinterList.aspx.cs" Inherits="SKT.LeanMES.Web.Labels.PrinterList" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label3">打印机名称
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">分组名称</td>
            <td class="Field3"><asp:TextBox ID="txtGroupName" runat="server" CssClass="TextBox"></asp:TextBox></td>
            <td class="Label3"></td>
            <td class="Field3"></td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1"
        OnRowDataBound="GridView1_RowDataBound">
        <Columns>
            <asp:BoundField DataField="Name" HeaderText="打印机名称" HeaderStyle-Width="180px" SortExpression="Name" />
            <asp:BoundField DataField="GroupName" HeaderText="分组名称" HeaderStyle-Width="100px" SortExpression="GroupName" />
            <asp:BoundField DataField="ComputerMAC" HeaderText="来源MAC" HeaderStyle-Width="100px" SortExpression="ComputerMAC" />
            <asp:BoundField DataField="WSIP" HeaderText="IP" HeaderStyle-Width="100px" SortExpression="WSIP" />
            <asp:BoundField DataField="WSPort" HeaderText="端口" HeaderStyle-Width="100px" SortExpression="WSPort" />
            <asp:BoundField DataField="Remark" HeaderText="备注" HeaderStyle-Width="100px" SortExpression="Remark" />
            <asp:BoundField DataField="CreateBy" HeaderText="<%$ Resources:lang, CreateBy %>" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="<%$ Resources:lang, CreateDateTime %>" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
            <asp:BoundField DataField="ModifyBy" HeaderText="<%$ Resources:lang, ModifyBy %>" />
            <asp:BoundField DataField="ModifyDateTime" HeaderText="<%$ Resources:lang, ModifyDateTime %>" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Labels.BLL.Printer"
        SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <script src="../Content/plugin/layui/layui.all.js" type="text/javascript"></script>
    <link href="../Content/plugin/layui/css/layui.css" type="text/css" rel="stylesheet" />
    <script src="../Content/js/ws.js" type="text/javascript"></script>
    <script type="text/javascript">
        isMultiple = false;
        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");
        function Import() {
            layer.open({
                type: 1,
                area: ["400px", "240px"],
                title: "获取打印机",
                content: "<br/><div class='layui-form-item'>"
                            + "<div class='layui-inline'>"
                                 + "<label class='layui-form-label'>IP</label>"
                                 + "<div class='layui-input-inline'><input type='text'  maxlength='15' id='txtip' value='' class='layui-input'></div>"
                            + "</div>"
                            + "<div class='layui-inline'>"
                                 + "<label class='layui-form-label'>端口</label>"
                                 + "<div class='layui-input-inline'><input type='text' maxlength='4' id='txtport' value='9000' class='layui-input'></div>"
                            + "</div>"
                        + "</div>",
                btn: ['确定', '取消'],
                btn1: function (index, layero) {
                    var ip = $("#txtip").val();
                    if ($.trim(ip) == "") {
                        layer.open({ content: '请输入IP' });
                        return;
                    }
                    if (!/^\d+\.\d+\.\d+\.\d+$/.test(ip)) {
                        layer.open({ content: 'IP格式错误' });
                        return;
                    }
                    var port = $("#txtport").val();
                    if (!/^\d+(.\d+|\d*)$/.test(port)) {
                        layer.open({ content: '端口格式错误' });
                        return;
                    }
                    layer.close(index);
                    ImportPrinter(ip, port);
                }
            });
        }
        function ImportPrinter(ip, port) {
            var loading_id = layer.load(1, { shade: [0.5, '#000'] });
            var macaddress = null;

            var getPrinter = function () {
                $.initWebSocket({
                    Ip: ip,
                    Port: port,
                    Method: "GetPrinter",
                    Data: "1",
                    onMessage: function (ws, msg) {
                        var data = JSON.parse(msg.data);
                        if (!data.Success) {
                            layer.close(loading_id);
                            layer.open({ content: data.Error });
                            return;
                        }
                        var str = "";
                        for (var field in data.Result) {
                            if (str != "")
                                str += ",";
                            str += field;
                        }
                        var ajax = SKT.LeanMES.Web.AjaxServices.AjaxLabels.AddPrinter(ip, port, macaddress, str);
                        layer.close(loading_id);
                        if (ajax.error != null) {
                            alert(ajax.error.Message);
                            return;
                        }
                        layer.close(loading_id);
                        UpdateList();
                    },
                    onClose: function (ws, msg) {
                        layer.close(loading_id);
                        if (ws && ws.readyState != 1) {
                            layer.open({ content: "连接尚未建立请确认服务是否开启" });
                        }
                    }
                });
            }

            $.initWebSocket({
                Ip: ip,
                Port: port,
                Method: "GetMacAddress",
                Data: null,
                onMessage: function (ws, msg) {
                    var data = JSON.parse(msg.data);
                    if (!data.Success) {
                        layer.close(loading_id);
                        layer.open({ content: data.Error });
                        return;
                    }
                    macaddress = data.Result;
                    getPrinter();
                },
                onClose: function (ws, msg) {
                    layer.close(loading_id);
                    if (ws && ws.readyState != 1) {
                        layer.open({ content: "连接尚未建立请确认服务是否开启" });
                    }
                }
            });
        }
        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Labels/PrinterEdit.aspx?name=PrinterEdit&Id=" + idStr;
            dialog({ title: "<%= Resources.Pages.Labels_LabelDocumentEdit %>", src: openWinUrl, width: 700, height: 400 });
        }

        function Delete() {
            var idStr = getDeletingRecordIdString();
            if (idStr == "") return false;
            hdnOperate.val("delete");
            hdnIdString.val(idStr);
            document.forms[0].submit();
        }

        function UpdateList() {
            document.forms[0].submit();
        }
    </script>
</asp:Content>
