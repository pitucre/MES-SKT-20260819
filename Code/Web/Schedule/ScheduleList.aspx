<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ScheduleList.aspx.cs" Inherits="SKT.LeanMES.Web.Schedule.ScheduleList" MasterPageFile="~/Masters/ListMaster.master" %>
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
    <asp:GridView ID="GridView1" AutoGenerateColumns="false" runat="server" 
        onrowdatabound="GridView1_RowDataBound">
        <Columns>
            <asp:BoundField DataField="MPID" HeaderText="<%$ Resources:lang,PlanNO %>" ItemStyle-Width="150px" />
            <asp:BoundField DataField="CreatDate" HeaderText="<%$ Resources:lang,CreateDateTime %>" ItemStyle-Width="150px" />
            <asp:BoundField DataField="MoCode" HeaderText="<%$ Resources:lang,ShopOrder %>" ItemStyle-Width="150px" />
            <asp:BoundField DataField="PublishStatus" HeaderText="<%$ Resources:lang,IsOrNotPublish %>" ItemStyle-Width="150px" />
            <asp:BoundField DataField="HaveUpdate" HeaderText="<%$ Resources:lang,HaveUpdate %>" ItemStyle-Width="150px" />
            <asp:BoundField DataField="KittingStatus" HeaderText="<%$ Resources:lang,IsOrNotKitting %>" ItemStyle-Width="150px" />
<%--            <asp:BoundField DataField="BusType" HeaderText="<%$ Resources:lang,BusinessType %>" ItemStyle-Width="150px" />
            <asp:BoundField DataField="BusTypeName" HeaderText="<%$ Resources:lang,BusinessName %>" ItemStyle-Width="150px" />--%>
            <asp:BoundField DataField="InvCode" HeaderText="<%$ Resources:lang,ItemCode %>" ItemStyle-Width="150px" />
            <asp:BoundField DataField="InvName" HeaderText="<%$ Resources:lang,ItemName %>" ItemStyle-Width="150px" />
<%--            <asp:BoundField DataField="ComUnitCode" HeaderText="<%$ Resources:lang,PartUnit %>" ItemStyle-Width="150px" />--%>
            <asp:BoundField DataField="MDeptCode" HeaderText="<%$ Resources:lang,FactoryNO %>" ItemStyle-Width="150px" />
            <asp:BoundField DataField="WorkSEQ" HeaderText="作业编号" ItemStyle-Width="150px" />
            <asp:BoundField DataField="SortSeq" HeaderText="工序序号" ItemStyle-Width="150px" />
            <asp:BoundField DataField="Qty" HeaderText="<%$ Resources:lang,Qty_to_Build %>" ItemStyle-Width="150px" />
            <asp:BoundField DataField="PlanQty" HeaderText="<%$ Resources:lang,PlanQty %>" ItemStyle-Width="150px" />
            <asp:BoundField DataField="PlanBeginDate" HeaderText="<%$ Resources:lang,Planned_Start_Time %>" ItemStyle-Width="150px" />
            <asp:BoundField DataField="PlanEndTime" HeaderText="<%$ Resources:lang,Planned_Completed_Date %>" ItemStyle-Width="150px" />


        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Schedule.BLL.Schedules"
        SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <div class='divwait'><img  src="../Content/theme/Metro/images/bigloading.gif" alt='数据导入中'/></div>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <script type="text/javascript">
        isMultiple = false;
        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");

        var user = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";

        $(document).ready(function () {
            $(".divwait").hide();
        })



        function Edit() {
            Allot();
        }

        //刷新 
        function refresh() {
            document.forms[0].submit();
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

        //齐套验证
        function Kitting() {
            var idStr = getOneRecordId();
            if (idStr == "") return;

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSchedule.KittingCheck(idStr)
            if (ajax.error != null) {
                alert(ajax.error.Message)
                return false;
            }

            alert("齐套验证成功！");
            refresh();
        }

        //取消齐套验证
        function UnKitting() {
            var idStr = getOneRecordId();
            if (idStr == "") return;

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSchedule.UnKitting(idStr)
            if (ajax.error != null) {
                alert(ajax.error.Message)
                return false;
            }

            alert("取消齐套成功！");
            refresh();
        }

        //线体班次分配
        function Allot() {
            var idStr = getOneRecordId();
            if (idStr == "") return;

            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Schedule/ScheduleAllot.aspx?name=Schedule_ScheduleAllot&Id=" + idStr;
            dialog({ title: "<%= Resources.Pages.Schedule_ScheduleAllot %>", src: openWinUrl, width: 800, height: 500, resizeable: false });
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



