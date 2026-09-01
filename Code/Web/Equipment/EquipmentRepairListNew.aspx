<%@ Page Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" CodeBehind="EquipmentRepairListNew.aspx.cs" Inherits="SKT.LeanMES.Web.Equipment.EquipmentRepairListNew" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <style>
        /*.repair-fun { position: relative; overflow: hidden; width: 200px; height: 55px; line-height: 30px; font-size: 20px; }
            .repair-fun:after { position: absolute; bottom: 0; right: 0; content: '...'; background: url(ellipsis_bg.png) repeat-y; }*/
        .repair-fun { width: 200px; overflow: hidden; white-space: nowrap; text-overflow: ellipsis; -o-text-overflow: ellipsis; -icab-text-overflow: ellipsis; -khtml-text-overflow: ellipsis; -moz-text-overflow: ellipsis; -webkit-text-overflow: ellipsis; }
    </style>
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label3">维修单号</td>
            <td class="Field3">
                <asp:TextBox ID="txtRepairNo" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3"><%=Resources.lang.EquipmentCode%></td>
            <td class="Field3">
                <asp:TextBox ID="txtEquipmentCode" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">状态</td>
            <td class="Field3">
                <asp:DropDownList ID="ddlStatus" runat="server" AutoPostBack="false">
                    <asp:ListItem Selected="True" Value="">请选择</asp:ListItem>
                    <asp:ListItem Value="0">待处理</asp:ListItem>
                    <asp:ListItem Value="1">维修中</asp:ListItem>
                    <asp:ListItem Value="2">已报废</asp:ListItem>
                    <asp:ListItem Value="3">外修</asp:ListItem>
                    <asp:ListItem Value="4">已完成</asp:ListItem>
                    <asp:ListItem Value="5">已验收</asp:ListItem>
                    <asp:ListItem Value="6">已拒收</asp:ListItem>
                    <asp:ListItem Value="7">已审核</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="Label3">报修时间</td>
            <td class="Field3">
                <asp:TextBox CssClass="DateTimeBox" ID="txtCreateTimeStart" Style="width: 76px;" runat="server"></asp:TextBox>
                -
                <asp:TextBox CssClass="DateTimeBox" ID="txtCreateTimeEnd" Style="width: 76px;" runat="server"></asp:TextBox>
            </td>
            <td class="Label3">维修结束时间</td>
            <td class="Field3">
                <asp:TextBox CssClass="DateTimeBox" ID="txtRepairTimeStart" Style="width: 76px;" runat="server"></asp:TextBox>
                -
                <asp:TextBox CssClass="DateTimeBox" ID="txtRepairTimeEnd" Style="width: 76px;" runat="server"></asp:TextBox>
            </td>
            <td class="Label3">工序</td>
            <td class="Field3">
                <asp:TextBox ID="txtStation" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label3">维修人</td>
            <td class="Field3">
                <asp:TextBox ID="RepairName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3"></td>
            <td class="Field3">
            </td>
            <td class="Label3"></td>
            <td class="Field3">
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="RepairNo" HeaderText="维修单号" SortExpression="RepairNo" ItemStyle-CssClass="repair-no" />
            <asp:BoundField DataField="EquipmentCode" HeaderText="<%$ Resources:lang, EquipmentCode %>" SortExpression="EquipmentCode" />
            <asp:BoundField DataField="EquipmentName" HeaderText="设备名称" />
        <%--    <asp:BoundField DataField="AnormalTypeName" HeaderText="异常类型" />--%>
            <asp:BoundField DataField="Station" HeaderText="工序" />
            <asp:BoundField DataField="FaultLocation" HeaderText="故障部位" />
        <%--    <asp:BoundField DataField="FaultCause" HeaderText="故障状况" />--%>
            <asp:BoundField DataField="AnormalDesc" HeaderText="故障描述" />
            <asp:BoundField DataField="CreateName" HeaderText="报修人" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="报修时间" SortExpression="CreateDateTime" />
             <asp:BoundField DataField="ModifyBy" HeaderText="<%$ Resources:lang, ModifyBy %>" />
            <asp:BoundField DataField="ModifyDateTime" HeaderText="<%$ Resources:lang, ModifyDateTime %>" />
            <asp:BoundField DataField="StatusName" HeaderText="状态" SortExpression="StatusName" ItemStyle-CssClass="status" />
            <asp:BoundField DataField="UrgencyName" HeaderText="紧急程序" SortExpression="UrgencyName"/>
            <asp:BoundField DataField="StopFlagName" HeaderText="是否停机" SortExpression="StopFlagName"/>
            <asp:BoundField DataField="RepairName" HeaderText="维修人" />
            <asp:BoundField DataField="RepairStartTime" HeaderText="维修开始时间" SortExpression="RepairStartTime" />
            <asp:BoundField DataField="RepairEndTime" HeaderText="维修结束时间" SortExpression="RepairStartTime" />
            <asp:BoundField DataField="PartNo" HeaderText="备件编码" />
            <asp:BoundField DataField="PartQty" HeaderText="备件数量" />
            <asp:BoundField DataField="StopHour" HeaderText="停机时长(H)" />
            <asp:BoundField DataField="RepairHour" HeaderText="维修时长(H)" />
            <asp:BoundField DataField="RepairFunction" HeaderText="维修方法" ItemStyle-CssClass="td-repair" HeaderStyle-Width="200" ItemStyle-Width="200" />
            <asp:BoundField DataField="AcceptName" HeaderText="验收人" />
            <asp:BoundField DataField="AcceptTime" HeaderText="验收时间" SortExpression="AcceptTime" />
            <asp:BoundField DataField="AuditName" HeaderText="审核人" />
            <asp:BoundField DataField="AuditTime" HeaderText="审核时间" SortExpression="AuditTime" />
            <%--<asp:TemplateField HeaderText="故障图片">
                <ItemTemplate>
                    <asp:Image ID="Image1" CssClass="img-anormal" runat="server" Height="80px" Width="80px" ImageUrl='<%# SKT.LeanMES.Web.WebHelper.EquipmentFailureRoot + Eval("AnormalImg")%>' />
                </ItemTemplate>
            </asp:TemplateField>--%>
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true"
        StartRowIndexParameterName="startRow" MaximumRowsParameterName="maxRows" SortParameterName="sortExpression"
        TypeName="SKT.LeanMES.Equipment.BLL.EquipmentRepair" SelectMethod="GetRepairAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <script src="../Content/js/skt.oa.js?ver=1.1"></script>
    <script type="text/javascript">
        isMultiple = true;
        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");
        var dic = "<%= SKT.LeanMES.Web.WebHelper.EquipmentFailureRoot%>";

        $(function () {

            $(".td-repair").each(function () {
                $(this).attr("title", $.trim($(this).text())).html("<div class=\"repair-fun\">" + $.trim($(this).text()) + "</div>");
            });

        });

        function View() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/EquipmentRepairView.aspx?name=EquipmentRepairView&Id=" + idStr;
            dialog({ title: mesLang("查看维修单"), src: openWinUrl, width: 850, height: 500 });
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;

            var repairNo = getTextByClass("repair-no");
            var status = getTextByClass("status");
            if (status != "已验收") {
                alert("维修单不是已验收状态，不能编辑");
                return false;
            }

            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/EquipmentRepairEditNew.aspx?name=EquipmentRepairEditNew&Id=" + idStr;
            dialog({ title: mesLang("编辑维修方法"), src: openWinUrl, width: 850, height: 500 });
        }

        //审核
        function Audit() {
            AuditRepair(6);
        }

        //审核NG
        function AuditNG() {
            AuditRepair(7);
        }

        //审核
        function AuditRepair(flag) {
            var repairNos = "";
            var isOk = true;
            //遍历需要审核的维修单
            $("#<%=this.GridView1.ClientID%> tbody input[name=\"chkSelect\"]:checked").each(function (i) {
                var repairNo = $.trim($(this).parent().siblings(".repair-no").text());
                var status = $.trim($(this).parent().siblings(".status").text());
                if (flag == 6) {
                    if (status != "已验收") {
                        alert("维修单" + repairNo + "不是已验收状态，不能审核");
                        isOk = false;
                        return false;
                    }
                } else {
                    if (status != "外修" && status != "报废") {
                        alert("维修单" + repairNo + "不是外修或报废状态，不能审核NG");
                        isOk = false;
                        return false;
                    }
                }
                repairNos += (i == 0 ? "" : ",") + repairNo;
            });
            if (!isOk) {
                return false;
            }

            var entity =
            {
                RepairNo: repairNos,                   //维修单号
                Flag: flag,                           //操作类型（0 开始维修 1：报废 2：外修 3：维修完成 4：验收 5：拒收 6：审核 7：审核NG）
                AnormalTypeName: "",
            };
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEquipment.EquipmentRepairOperate(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert("审核成功！");
            //UpdateList();
        }


        //外修时自动提交报错，此处可重新提交
        function SubmitOA() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            var repairNo = getTextByClass("repair-no");
            var msg = submitEquipmentRepairToOA(repairNo);
            if (msg == "") {
                alert("提交OA处理成功！");
            } else {
                alert("提交OA处理失败：" + msg);
            }
        }

        //根据样式名获取文本
        function getTextByClass(cls) {
            return $.trim($("#<%=this.GridView1.ClientID%> tbody input[name=\"chkSelect\"]:checked").parent().siblings("." + cls).text());
        }

        function Export() {
            hdnOperate.val("export");
            document.forms[0].submit();
            hdnOperate.val("");
        }

        //更新列表
        function UpdateList() {
            document.forms[0].submit();
        }
    </script>
</asp:Content>

