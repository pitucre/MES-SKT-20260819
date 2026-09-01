<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ScheduleAllottedList.aspx.cs" Inherits="SKT.LeanMES.Web.Schedule.ScheduleAllottedList" MasterPageFile="~/Masters/ListMaster.master" %>
<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">

    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">
                <%//=Resources.lang.TurnoverTypeName%>工单号码
            </td>
            <td class="Field2">
                <input type="text" id="txtMoCode" class="TextBox" runat="server"/>
                <input type="button" class="ButtonBox" value="..." onclick="choosepage(44)"/>
            </td>
            <td class="Label2">
                <%//=Resources.lang.TurnoverTypeName%>产品编码
            </td>
            <td class="Field2">
                <input type="text" id="txtInvCode" class="TextBox" runat="server"/>
                <input type="button" class="ButtonBox" value="..." onclick="choosepage(1)"/>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%//=Resources.lang.TurnoverTypeName%>产线名称
            </td>
            <td class="Field2">
                <input type="text" id="txtLineName" class="TextBox" runat="server"/>
                <input type="button" class="ButtonBox" value="..." onclick="choosepage(21)"/>
            </td>
            <td class="Label2">
                <%//=Resources.lang.TurnoverTypeName%>作业编号
            </td>
            <td class="Field2">
                <input type="text" id="txtWorkSEQ" class="TextBox" runat="server"/>
                <input type="button" class="ButtonBox" value="..." onclick="choosepage(50)"/>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="searchConditions" runat="server" ContentPlaceHolderID="GridviewContent">
    <asp:GridView ID="GridView1" AutoGenerateColumns="false" runat="server" 
        onrowdatabound="GridView1_RowDataBound">
        <Columns>
            <asp:BoundField DataField="MPID" HeaderText="<%$ Resources:lang,PlanNO %>" ItemStyle-Width="150px" />
            <asp:BoundField DataField="MoCode" HeaderText="<%$ Resources:lang,ShopOrder %>" ItemStyle-Width="150px" />
            <asp:BoundField DataField="InvCode" HeaderText="<%$ Resources:lang,ItemCode %>" ItemStyle-Width="150px" />
            <asp:BoundField DataField="InvName" HeaderText="<%$ Resources:lang,ItemName %>" ItemStyle-Width="150px" />
            <asp:BoundField DataField="WorkSEQ" HeaderText="作业编号" ItemStyle-Width="150px" />
            <asp:BoundField DataField="LineName" HeaderText="产线" ItemStyle-Width="150px" />
            <asp:BoundField DataField="ShiftName" HeaderText="班次" ItemStyle-Width="150px" />
            <asp:BoundField DataField="AllotQty" HeaderText="<%$ Resources:lang,AllotQty %>" ItemStyle-Width="150px" />
            <asp:BoundField DataField="PlanBeginDate" HeaderText="<%$ Resources:lang,Planned_Start_Time %>" ItemStyle-Width="150px" />
            <asp:BoundField DataField="PlanEndTime" HeaderText="<%$ Resources:lang,Planned_Completed_Date %>" ItemStyle-Width="150px" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Schedule.BLL.Schedules"
        SelectMethod="GetAllottedScheduleAll" SelectCountMethod="GetCount">
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

        //对当前 未发布的排程分配信息 进行发布
        function scheduleAllottedPublish() {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSchedule.ScheduleAllottedPublish(user)
            if (ajax.error != null) {
                alert(ajax.error.Message)
                return false;
            } else {
                alert("分配排程发布成功！")
                refresh();
            }
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
            if (flag == 1) {
                $("#<%=this.txtInvCode.ClientID %>").val(list[0][2])
            }
            else
                if (flag == 44) {
                    $("#<%=this.txtMoCode.ClientID %>").val(list[0][1])
                }
                else
                    if (flag == 21) {
                        $("#<%=this.txtLineName.ClientID %>").val(list[0][1])
                    }
                    else
                        if (flag == 50) {
                            $("#<%=this.txtWorkSEQ.ClientID %>").val(list[0][1])
                        }

        }
    </script>
</asp:Content>