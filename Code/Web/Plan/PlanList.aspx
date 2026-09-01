<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/Masters.master"  AutoEventWireup="true" 
CodeBehind="PlanList.aspx.cs" Inherits="SKT.LeanMES.Web.Plan.PlanList" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<%--选项卡 开始--%>
    <div class="infoTabs">
        <%--选项卡-未排期工单--%>
        <div id="Div1" class="infoTabItem-selected" title="未排期工单" >
            未排期工单
        </div>

        <%--选项卡-已排期工单--%>
        <div id="Div2"  title="已排期工单">
            已排期工单
        </div>

        <%--选项卡-排期完成工单--%>
        <div id="Div3"  title="排期完成工单">
            已完成工单
        </div>

        <%--选项卡-排期完成工单--%>
        <div id="Div4"  title="排期完成工单">
            已完成工单
        </div>
    </div> <div class="clear5"></div>
  <%--选项卡内容 开始--%>
    <div class="infoTabContent">
        <%--选项卡内容-未排期工单--%>
        <div class="infoTabContent-selected">
            <SKTControl:UGridView ID="waitGridView" runat="server" OnRowDataBound="waitOnRowDataBound">
             <Columns>
                   <%-- <asp:BoundField DataField="FBILLNO" HeaderText="工单编号"  />
                    <asp:BoundField DataField="FName" HeaderText="物料名称"  /> 
                    <asp:BoundField DataField="FModel" HeaderText="物料规格型号"  /> 
                   <asp:BoundField DataField="fbiller" HeaderText="制单人"  /> 
                    <asp:BoundField DataField="FQty" HeaderText="数量"  /> 
                    <asp:BoundField DataField="FDATE" HeaderText="下单日期"  /> 
                   <asp:BoundField DataField="FPlanCommitDate" HeaderText="计划开始日期"  /> 
                   <asp:BoundField DataField="FPlanFinishDate" HeaderText="计划完成日期"  /> --%>
                    <asp:BoundField DataField="OrderNO" HeaderText="<%$ Resources:lang,ShopOrder %>" />
                    <asp:BoundField DataField="ItemName" HeaderText="<%$ Resources:lang,ItemsName %>" />
                    <asp:BoundField DataField="qty_to_Build" HeaderText="<%$ Resources:lang,Qty_to_Build %>" />
                    <asp:BoundField DataField="Status" HeaderText="<%$ Resources:lang,Status %>" />
                    <asp:BoundField DataField="Priority" HeaderText="<%$ Resources:lang,Priority %>" />
                    <asp:BoundField DataField="BOMName" HeaderText="<%$ Resources:lang,Bom %>" />
                    <asp:BoundField DataField="RouterName" HeaderText="<%$ Resources:lang,RouterName %>" />
                    <asp:BoundField DataField="CustomerName" HeaderText="<%$ Resources:lang,CustomerName %>" />
                    <asp:BoundField DataField="Qty_Released" HeaderText="<%$ Resources:lang,Qty_Released %>" />
                    <asp:BoundField DataField="Release_date" HeaderText="<%$ Resources:lang,Release_date %>" />
                    <asp:BoundField DataField="Qty_Done" HeaderText="<%$ Resources:lang,Qty_Done %>" />
                    <asp:BoundField DataField="Qty_Scrapped" HeaderText="<%$ Resources:lang,Qty_Scrapped %>" />
                    <asp:BoundField DataField="Actual_Start_Date" HeaderText="<%$ Resources:lang,Actual_Start_Date %>" />
                    <asp:BoundField DataField="Actual_Completed_Date" HeaderText="<%$ Resources:lang,Actual_Completed_Date %>" />
                </Columns>
           </SKTControl:UGridView>
            <asp:ObjectDataSource ID="waitDataSource" runat="server" EnablePaging="true" 
                StartRowIndexParameterName="startRow" MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" 
                TypeName="SKT.LeanMES.Order.BLL.ShopOrder" SelectMethod="GetAll" SelectCountMethod="GetCount">
                <SelectParameters>
                    <asp:Parameter Name="searchSettings" Type="Object"  />
                </SelectParameters>
            </asp:ObjectDataSource>
            <div class="clear5"></div>
        </div>

        <%--选项卡内容-已排期工单--%>
        <div>
            <SKTControl:UGridView ID="alreadyGridView" runat="server" OnRowDataBound="AlreadyOnRowDataBound" >
               <Columns>
                    <asp:BoundField DataField="FInterID" HeaderText="<%$Resources:lang,OrderNumber %>" />
                     <asp:BoundField DataField="LineId" HeaderText="LineId" />
                     <asp:BoundField DataField="FQty" HeaderText="计划产量" />
                     <asp:BoundField DataField="FStockQty" HeaderText="已生产量" />
                      <asp:BoundField DataField="FPlanCommitDate" HeaderText="计划开始时间"   />
                     
               </Columns>
            </SKTControl:UGridView>
            <asp:ObjectDataSource ID="alreadyObjectDataSource" runat="server" EnablePaging="true" 
                StartRowIndexParameterName="startRow" MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" 
                TypeName="SKT.LeanMES.Plan.BLL.LinePlan" SelectMethod="GetAll" SelectCountMethod="GetCount">
                <SelectParameters>
                    <asp:Parameter Name="searchSettings" Type="Object"  />
                </SelectParameters>
            </asp:ObjectDataSource>
            <div class="clear5"></div>
        </div>

        <%--选项卡内容-已完成工单--%>
        <div>
            <div class="clear5"></div>
        </div>


    </div>


<input type="hidden" id="hdnOperate" name="hdnOperate" value=""/>
    <input type="hidden" id="hdnIdString" name="hdnIdString"  value=""/>
  <script>
      var hdnOperate = $("#hdnOperate");
      var hdnIdString = $("#hdnIdString");


    /******************全局区域开始*********************/
    var hdnOperate = $("#hdnOperate");
    var hdnIdString = $("#hdnIdString");

    $(function () {
        initTab();
    })
    /******************全局区域结束********************/


    //初始化tab功能
    function initTab() {
        $(".infoTabs > div").bind("click", function () {
            $(".infoTabs > div").removeClass("infoTabItem-selected");
            $(this).addClass("infoTabItem-selected");
            var index = $(".infoTabs > div").index($(this));
            $(".infoTabContent > div").removeClass("infoTabContent-selected");
            $($(".infoTabContent > div")[index]).addClass("infoTabContent-selected");
        })
    }

    function Scheduling() {
        waitGridViewDBClick(null, id)
    }

    function waitGridViewDBClick(obj,id) {
        openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Plan/PlanEdit.aspx?name=Plan_Scheduling&ID=" + id;
        dialog({ title: "<%=Resources.Pages.Plan_PlanEdit %>", src: openWinUrl, width: 1000, height: 420 })
    }

    /*刷新页面*/
    function Refresh() {
        document.forms[0].submit();
    }

    function CancelScheduling() {
        var idStr = GetSelectRecordID("<%=this.alreadyGridView.ClientID%>");
        if (idStr == "") {
            
            return false;
        } OrderEmptyWei
            hdnOperate.val("delete");
            hdnIdString.val(idStr);
        if (confirm("确定要撤消此工单的所有排期吗！")) {
            document.forms[0].submit();
        }
    }

    //等排程的GridView单击事件
    function onWaitGridClick(obj,id) {
        var checkBox = $(obj).find("input[type='checkbox']");
        var ch = $(checkBox).attr("checked", !$(checkBox).attr("checked"));

    }

    //等排程的GridView双击事件
    function onWaitGridDBClick(obj, id) {
        var checkBox = $(obj).find("input[type='checkbox']");
        var chBool = $(checkBox).attr("checked");
        if (chBool) {
            Edit(id);
        }
    }


    //点击行选择checkbox
    function UGridClick(obj, multiple) {
        if (!multiple) {
            var tab = obj.parentElement.parentElement;
            $(tab).find("input[class='chkSelect']").removeAttr("checked");
        }
        var checkBox = $(obj).find("input[type='checkbox']");
        var ch = $(checkBox).attr("checked", !$(checkBox).attr("checked"));
    }

    //点击全选checkbox
    function UGridCheckAll(obj) {
        var tab = obj.parentElement.parentElement.parentElement;
        $(tab).find("input[class='chkSelect']").attr("checked", !!$(obj).attr("checked"));
    }

    //获取checkbox勾选的ID值 
    function GetSelectRecordID(controlId) {
        var chObj = $("#" + controlId).find("input[class='chkSelect']");
        var str = "";
        for (var i = 0; i < chObj.length; i++) {
            if ($(chObj[i]).attr("checked")) {
                if (str.length==0) {
                    str = $(chObj[i]).val();
                }
                else {
                    str += "," + $(chObj[i]).val();
                }
            }
        }
        return str;
    }

    function alreadyDoubleClickFunction(obj, id) {
        var checkBox = $(obj).find("input[type='checkbox']");
        var chBool = $(checkBox).attr("checked");
        if (chBool) {
            var id = GetSelectRecordID("<%=this.alreadyGridView.ClientID%>");
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPlan.GetLineIdByLinePlanId(id);
            if (ajax.error != null) {
                return false;
            }
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Plan/PlanEdit.aspx?name=Plan_Scheduling&ID=" + ajax.value;
            dialog({ title: "<%=Resources.Pages.Plan_PlanEdit %>", src: openWinUrl, width: 1000, height: 420 })
        }
       
    }

</script>
</asp:Content>
