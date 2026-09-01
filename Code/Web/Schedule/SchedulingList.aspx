<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SchedulingList.aspx.cs" Inherits="SKT.LeanMES.Web.Schedule.SchedulingList" MasterPageFile="~/Masters/ListMaster.master"%>
<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label3">
                <%//=Resources.lang.TurnoverTypeName%>工单号码
            </td>
            <td class="Field3">
                <input type="text" id="txtMoCode" class="TextBox" runat="server" />
                <input type="button" class="ButtonBox" value="..." onclick="choosepage(44)"/>
            </td>
            <td class="Label3">
                <%//=Resources.lang.TurnoverTypeName%>工厂编号
            </td>
            <td class="Field3">
                <input type="text" id="txtMDeptCode" class="TextBox" runat="server" />
                <input type="button" class="ButtonBox" value="..." onclick="choosepage(47)"/>
            </td>
            <td class="Label3">
                <%//=Resources.lang.TurnoverTypeName%>作业编号
            </td>
            <td class="Field3">
                <input type="text" id="txtWorkSEQ" class="TextBox" runat="server" />
                <input type="button" class="ButtonBox" value="..." onclick="choosepage(50)"/>
            </td>
<%--            <td class="Label2">
                <%//=Resources.lang.TurnoverTypeName%>产品编码
            </td>
            <td class="Field2">
                <input type="text" id="txtInvCode" class="TextBox" runat="server" />
                <input type="button" class="ButtonBox" value="..." onclick="choosepage(1)"/>
            </td>--%>
        </tr>
        <tr>

            <td class="Label3">
                <%//=Resources.lang.TurnoverTypeName%>线体
            </td>
            <td class="Field3">
                <input type="text" id="txtLine" class="TextBox" runat="server" />
                <input type="button" class="ButtonBox" value="..." onclick="choosepage(21)"/>
            </td>
            <td class="Label3">
                <%//=Resources.lang.TurnoverTypeName%>班次
            </td>
            <td class="Field3">
                <input type="text" id="txtShift" class="TextBox" runat="server" />
                <input type="button" class="ButtonBox" value="..." onclick="choosepage(49)"/>
            </td>
            <td class="Label3">
                <%//=Resources.lang.TurnoverTypeName%>日期
            </td>
            <td class="Field3">
                <input type="text" id="txtDate" class="DateTimeBox" runat="server" />
            </td>
        </tr>
    </table>

   <div style="width:220px;height:60px;border:solid 2px blue;margin:90px 100px; display:none; z-index:9999" id="divChangeQty">
        <span>请输入变更数量<br /></span>
        <input type="text" id="txtChangeQty" class="TextBox" />
   </div>
</asp:Content>
<asp:Content ID="searchConditions" runat="server" ContentPlaceHolderID="GridviewContent">
    <asp:GridView ID="GridView1" AutoGenerateColumns="false" runat="server" OnRowDataBound="GridView1_RowDataBound">
        <Columns>
            <asp:BoundField DataField="SchedulingStatus" HeaderText="<%$ Resources:lang,Status %>" ItemStyle-Width="90px" />
            <asp:BoundField DataField="ProdOrderNO" HeaderText="<%$ Resources:lang,OrderNumber %>" ItemStyle-Width="150px" />
            <asp:BoundField DataField="ProductName" HeaderText="<%$ Resources:lang,ItemName %>" ItemStyle-Width="150px" />
            <asp:BoundField DataField="FactoryName" HeaderText="<%$ Resources:lang,FactoryName %>" ItemStyle-Width="150px" />
            <asp:BoundField DataField="WorkSEQ" HeaderText="作业编号" ItemStyle-Width="150px" />
            <asp:BoundField DataField="ProdOrderQty" HeaderText="<%$ Resources:lang,Qty_to_Build %>" ItemStyle-Width="150px" />
            <asp:BoundField DataField="FinishedQty" HeaderText="<%$ Resources:lang,Qty_Done %>" ItemStyle-Width="150px" />
            <asp:BoundField DataField="PlanBeginDate" HeaderText="<%$ Resources:lang,Planned_Start_Time %>" ItemStyle-Width="150px" />
            <asp:BoundField DataField="PlanEndTime" HeaderText="<%$ Resources:lang,Planned_Completed_Date %>" ItemStyle-Width="150px" />
            <asp:BoundField DataField="ActualBeginDate" HeaderText="<%$ Resources:lang,Actual_Start_Date %>" ItemStyle-Width="150px" />
            <asp:BoundField DataField="ActualEndTime" HeaderText="<%$ Resources:lang,Actual_Completed_Date %>" ItemStyle-Width="150px" />
            <asp:BoundField DataField="SchedulingSeq" HeaderText="<%$ Resources:lang,SchedulingSeq %>" ItemStyle-Width="150px" />
            <asp:BoundField DataField="Shift" HeaderText="<%$ Resources:lang,ShiftName %>" ItemStyle-Width="150px" />
            <asp:BoundField DataField="Line" HeaderText="<%$ Resources:lang,Line %>" ItemStyle-Width="150px" />
            <asp:BoundField DataField="SchedulingQty" HeaderText="<%$ Resources:lang,SchedulingQty %>" ItemStyle-Width="150px" />

        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Schedule.BLL.Scheduling"
        SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <script type="text/javascript">
        isMultiple = false;
        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");
        var user = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";

        //顺序变更  上移
        function UpChange(i) {
            var id;

            if (i == -1) {
                var id = getOneRecordId();
                if (id == "") return;
            } else {
                id = i;
            }

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSchedule.SchedulingSeqChange(id, user, 1, -1)
            if (ajax.error != null) {
                alert(ajax.error.Message)
                return false;
            }

            refresh();
        }

        //顺序变更  下移
        function DownChange(i) {
            var id;

            if (i == -1) {
                var id = getOneRecordId();
                if (id == "") return;
            } else {
                id = i;
            }

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSchedule.SchedulingSeqChange(id, user, 2, -1)
            if (ajax.error != null) {
                alert(ajax.error.Message)
                return false;
            }

            refresh();
        }


        //顺序变更  调换
        function SwopChange(i) {
            var id;
            var swopId;

            if (i == -1) {
                var id = getOneRecordId();
                if (id == "") return;
            } else {
                id = i;
            }

            $("").prop("checked", "");

            swopId = getOneRecordId();
            if (id == "") return;

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSchedule.SchedulingSeqChange(id, user, 3, swopId)
            if (ajax.error != null) {
                alert(ajax.error.Message)
                return false;
            }

            refresh();
        }


        //数量变更
        function QtyChange() {
            var idStr = getOneRecordId();
            if (idStr == "") return;

              //alter zhibin.chen  2015-11-10 改为用户手动输入数量
//            var ajax1 = SKT.LeanMES.Web.AjaxServices.AjaxSchedule.SchedulingQtyChange(idStr, user, 1)
//            if (ajax1.error != null) {
//                alert(ajax1.error.Message)
//                return false;
//            }

//            if (!confirm("是否要将数量从　" + ajax1.value[0] + "　变更为　" + ajax1.value[1] + "?")) {
//                return false;
            //            }

            $("#divChangeQty").show();

            var changeQty = $("#txtChangeQty").val();

            if (isNaN(changeQty) || changeQty <= 0 ) {
                alert("请输入一个有效的数字！");
                return false;
            }

            var ajax2 = SKT.LeanMES.Web.AjaxServices.AjaxSchedule.SchedulingQtyChange(idStr, parseFloat(changeQty), user, 2)
            if (ajax2.error != null) {
                alert(ajax2.error.Message)
                return false;
            }

            alert("数量变更成功！");
            refresh();
        }

        //停止排产
        function StopScheduling() {
            var idStr = getOneRecordId();
            if (idStr == "") return;

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSchedule.SchedulingStopOrCancel(idStr, user, 1)
            if (ajax.error != null) {
                alert(ajax.error.Message)
                return false;
            }

            alert("排产停止成功！");
            refresh();
        }

        //取消停止排产
        function CancelStopScheduling(){
            var idStr = getOneRecordId();
            if (idStr == "") return;

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSchedule.CancelStopScheduling(idStr, user)
            if (ajax.error != null) {
                alert(ajax.error.Message)
                return false;
            }

            alert("排产取消停止操作成功！");
            refresh();
        }

        //取消排产
        function CancelScheduling() {
            var idStr = getOneRecordId();
            if (idStr == "") return;

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSchedule.SchedulingStopOrCancel(idStr, user, 2)
            if (ajax.error != null) {
                alert(ajax.error.Message)
                return false;
            }

            alert("排产取消成功！");
            refresh();
        }

        //刷新 
        function refresh() {
            document.forms[0].submit();
        }

        function UpdateList(MoCode) {
            $("#<%=this.txtMoCode.ClientID %>").val(MoCode);
            document.forms[0].submit();
        }


        var flag = -1;

        function choosepage(tag) {
            flag = tag;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=" + flag + "&Multiple=false&rnd=" + Math.random(), width: 600, height: 300 });
        }

        function getChooseValue(list) {
            if (flag == 21) {
                $("#<%=this.txtLine.ClientID %>").val(list[0][2])
            }
            else
                if (flag == 44) {
                    $("#<%=this.txtMoCode.ClientID %>").val(list[0][1])
                }
                else
                    if (flag == 47) {
                        $("#<%=this.txtMDeptCode.ClientID %>").val(list[0][1])
                    }
                    else
                        if (flag == 49) {
                            $("#<%=this.txtShift.ClientID %>").val(list[0][1])
                        }
                        else
                        if (flag == 50) {
                                $("#<%=this.txtWorkSEQ.ClientID %>").val(list[0][1])
                        }

        }
    </script>
</asp:Content>



