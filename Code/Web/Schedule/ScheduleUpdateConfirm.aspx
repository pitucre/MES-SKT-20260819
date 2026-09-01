<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ScheduleUpdateConfirm.aspx.cs" Inherits="SKT.LeanMES.Web.Schedule.ScheduleUpdateConfirm" MasterPageFile="~/Masters/ListMaster.master" %>
<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">

       <style type="text/css">
            .divwait
            {
                position:absolute;
                left:47.2%;
                top:190px;
                width:66px;
                height:66px;
                z-index:9999;
            }
        </style>

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
                <%//=Resources.lang.TurnoverTypeName%>工厂编号
            </td>
            <td class="Field2">
                <input type="text" id="txtMDeptCode" class="TextBox" runat="server"/>
                <input type="button" class="ButtonBox" value="..." onclick="choosepage(47)"/>
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
    <asp:GridView ID="GridView1" AutoGenerateColumns="false" runat="server">
        <Columns>
            <asp:BoundField DataField="MPID" HeaderText="<%$ Resources:lang,PlanNO %>" ItemStyle-Width="150px" />
            <asp:BoundField DataField="CreatDate" HeaderText="<%$ Resources:lang,CreateDateTime %>" ItemStyle-Width="150px" />
            <asp:BoundField DataField="MoCode" HeaderText="<%$ Resources:lang,ShopOrder %>" ItemStyle-Width="150px" />
            <asp:BoundField DataField="BusTypeName" HeaderText="<%$ Resources:lang,BusinessName %>" ItemStyle-Width="150px" />
            <asp:BoundField DataField="InvCode" HeaderText="<%$ Resources:lang,ItemCode %>" ItemStyle-Width="150px" />
            <asp:BoundField DataField="InvName" HeaderText="<%$ Resources:lang,ItemName %>" ItemStyle-Width="150px" />
            <asp:BoundField DataField="ComUnitCode" HeaderText="<%$ Resources:lang,PartUnit %>" ItemStyle-Width="150px" />
            <asp:BoundField DataField="MDeptCode" HeaderText="<%$ Resources:lang,FactoryNO %>" ItemStyle-Width="150px" />
            <asp:BoundField DataField="WorkSEQ" HeaderText="作业编号" ItemStyle-Width="150px" />
            <asp:BoundField DataField="SortSeq" HeaderText="工序序号" ItemStyle-Width="150px" />
            <asp:BoundField DataField="Qty" HeaderText="<%$ Resources:lang,Qty_to_Build %>" ItemStyle-Width="150px" />
            <asp:BoundField DataField="PlanQty" HeaderText="<%$ Resources:lang,PlanQty %>" ItemStyle-Width="150px" />
            <asp:BoundField DataField="PlanBeginDate" HeaderText="<%$ Resources:lang,Planned_Start_Time %>" ItemStyle-Width="150px" />
            <asp:BoundField DataField="PlanEndTime" HeaderText="<%$ Resources:lang,Planned_Completed_Date %>" ItemStyle-Width="150px" />
            <asp:BoundField DataField="Pubufts"  Visible="true" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Schedule.BLL.ScheduleUpdate"
        SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <div class='divwait'><img  src="../Content/theme/Metro/images/bigloading.gif" alt='数据导入中'/></div>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <script type="text/javascript">
        isMultiple = true;
        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");
        var user = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>"

        $(document).ready(function () {
            $(".divwait").hide();
        })

        //更新内容对比
        function Compare() {
            var idStr = getOneRecordId();
            if (idStr == "") return;

            //xiang.yan 2024-4-28  列取值由索引改为列明,菜单已无此页面
            // 3 改为 MoCode
            // 12>9 改为 WorkSEQ
            var moCode = getOneRecordCellTextByFiled("MoCode");
            var workSEQ = getOneRecordCellTextByFiled("WorkSEQ");

            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Schedule/ScheduleUpdateCompare.aspx?name=Schedule_ScheduleUpdateCompare&moCode=" + moCode + "&workSEQ=" + workSEQ;
            dialog({ title: "<%= Resources.Pages.Schedule_ScheduleUpdateCompare %>", src: openWinUrl, width: 900, height: 500, resizeable: false });
        }

        //刷新 
        function refresh() {
            document.forms[0].submit();
        }

        //确认更新
        function ConfirmUpdate() {
            var idStr = getOneRecordId();
            if (idStr == "") return;

            //xiang.yan 2024-4-28  列取值由索引改为列明,菜单已无此页面
            // 3 改为 MoCode
            // 12>9 改为 WorkSEQ
            // 17>15 改为 WorkSEQ
            var moCode = getOneRecordCellTextByFiled("MoCode");
            var workSEQ = getOneRecordCellTextByFiled("WorkSEQ");
            var pubufts = getOneRecordCellTextByFiled("Pubufts");

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSchedule.ConfirmUpdate(moCode, workSEQ, pubufts, user, 2)
            if (ajax.error != null) {
                alert(ajax.error.Message)
                return false;
            }
        }

        //取消更新
        function CancelUpdate() {
            var idStr = getOneRecordId();
            if (idStr == "") return;

            //xiang.yan 2024-4-28  列取值由索引改为列明,菜单已无此页面
            // 3 改为 MoCode
            // 12>9 改为 WorkSEQ
            // 17>15 改为 WorkSEQ
            var moCode = getOneRecordCellTextByFiled("MoCode");
            var workSEQ = getOneRecordCellTextByFiled("WorkSEQ");
            var pubufts = getOneRecordCellTextByFiled("Pubufts");

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSchedule.ConfirmUpdate(moCode, workSEQ, pubufts, user, 1)
            if (ajax.error != null) {
                alert(ajax.error.Message)
                return false;
            }
        }


        //马上导入排程
        function atOnceImportSchedule() {
            //等待画面
            $(".divwait").show();

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSchedule.AtOnceImportSchedule()
            if (ajax.error != null) {
                alert(ajax.error.Message)
                $(".divwait").hide();
                return false;
            }

            //隐藏等待画面
            $(".divwait").hide();
            alert('导入成功！');

            refresh();
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
                    if (flag == 47) {
                        $("#<%=this.txtMDeptCode.ClientID %>").val(list[0][1])
                    }
                    else
                        if (flag == 50) {
                            $("#<%=this.txtWorkSEQ.ClientID %>").val(list[0][1])
                        }

        }
    </script>
</asp:Content>




