<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true"
    CodeBehind="ProductionControlList.aspx.cs" Inherits="SKT.LeanMES.Web.Plan.ProductionControlList" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label3">排产号
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtOrderNo" runat="server"></asp:TextBox>
            </td>
            <td class="Label3">产线
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtLine" runat="server" ClientIDMode="Static" CssClass="TextBox"></asp:TextBox><input
                    type="button" id="btnSelectLine" onclick="openChoosePage(21);" class="ButtonBox"
                    value="..." />
            </td>
            <td class="Label3">产品编码
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtItemName" runat="server" CssClass="TextBox" ClientIDMode="Static"
                    Width="64%">
                </asp:TextBox><input type="button" id="Button1" runat="server" class="ButtonBox"
                    value="..." title="Select" onclick="openChoosePage(1);" />
                <asp:HiddenField ID="hdnItemId" runat="server" Value="-1" ClientIDMode="Static" />
            </td>
        </tr>
        <tr>
            <td class="Label3">计划开工时间
            </td>
            <td class="Field3">
                <asp:TextBox CssClass="DateTimeBox" ID="txtPlanBegin" runat="server"></asp:TextBox>
            </td>
            <td class="Label3">计划完工时间
            </td>
            <td class="Field3">
                <asp:TextBox CssClass="DateTimeBox" ID="txtPlanEnd" runat="server"></asp:TextBox>
            </td>
            <td class="Label3">排产日期 
            </td>
            <td class="Field3">
                <asp:TextBox CssClass="DateTimeBox" ID="txtCreateTimeStart" Style="width: 76px;" runat="server"></asp:TextBox>
                -
                <asp:TextBox CssClass="DateTimeBox" ID="txtCreateTimeEnd" Style="width: 76px;" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">排产工单状态
            </td>
            <td class="Field2" id="showChkBox" colspan="5">
                <asp:Label runat="server" ID="lblOrderStatus" ClientIDMode="Static"></asp:Label>
                <asp:HiddenField runat="server" ID="hfStrOrderStatus" ClientIDMode="Static" />
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Plan.BLL.LinePlan"
        SelectMethod="GetPlanOrderAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" style="table-layout:fixed;word-wrap:break-word;word-break:break-all">
        <Columns>
            <asp:BoundField DataField="FBILLNO" HeaderText="<%$ Resources:lang, FBILLNO %>" SortExpression="FBILLNO" HeaderStyle-Width="140px"/>
            <asp:BoundField DataField="LinePlanType" HeaderText="排产类型" SortExpression="LinePlanType" HeaderStyle-Width="70px"/>
            <asp:BoundField DataField="ItemCode" HeaderText="<%$ Resources:lang, ItemCode %>" SortExpression="ItemCode" HeaderStyle-Width="170px"/>
            <asp:BoundField DataField="ItemName" HeaderText="<%$ Resources:lang, ItemName %>" SortExpression="ItemName" HeaderStyle-Width="170px"/>
            <asp:BoundField DataField="ResName" HeaderText="<%$ Resources:lang, ResName %>" SortExpression="ResName" HeaderStyle-Width="100px"/>
            <asp:BoundField DataField="LineName" HeaderText="<%$ Resources:lang, LineName %>" HeaderStyle-Width="60px"/>
            <asp:BoundField DataField="WorkShopName" HeaderText="<%$ Resources:lang, WorkShopName %>" HeaderStyle-Width="60px"/>
            <asp:BoundField DataField="FactoryName" HeaderText="<%$ Resources:lang, FactoryName %>" HeaderStyle-Width="60px"/>
               <asp:BoundField DataField="ProductionLineSort" HeaderText="线生产排序(日)" HeaderStyle-Width="90px"/>
            <asp:BoundField DataField="LineMachineRelation" HeaderText="线别设备类型" HeaderStyle-Width="210px"/>
         
            <asp:BoundField DataField="StandardCapacity" HeaderText="标准产能" SortExpression="StandardCapacity" HeaderStyle-Width="80px"/>
            <asp:BoundField DataField="Qty_to_Build" HeaderText="工单数量" SortExpression="Qty_to_Build" HeaderStyle-Width="70px"/>
            <asp:BoundField DataField="FQty" HeaderText="排程数量" SortExpression="FQty" HeaderStyle-Width="70px"/>
            <asp:BoundField DataField="ChildrenNumber" HeaderText="拼板数量" SortExpression="ChildrenNumber" HeaderStyle-Width="70px"/>
            <asp:BoundField DataField="TableName" HeaderText="面别" SortExpression="TableName" HeaderStyle-Width="70px"/>
            <asp:BoundField DataField="Status" HeaderText="工单状态" SortExpression="Status" HeaderStyle-Width="100px"/>
            <asp:BoundField DataField="MaterialHomogeneity" HeaderText="物料齐套" ItemStyle-CssClass="homogeneity" SortExpression="MaterialHomogeneity" HeaderStyle-Width="70px"/>
            <asp:BoundField DataField="MaterialLock" HeaderText="物料锁定" SortExpression="MaterialLock" HeaderStyle-Width="70px"/>
            <asp:BoundField DataField="Planned_Start_Time" HeaderText="计划开工时间" SortExpression="Planned_Start_Time" HeaderStyle-Width="140px"/>
            <asp:BoundField DataField="Planned_Completed_Date" HeaderText="计划完工时间" SortExpression="Planned_Completed_Date" HeaderStyle-Width="140px"/>
            <asp:BoundField DataField="Actual_Start_Date" HeaderText="实际开工日期" SortExpression="Actual_Start_Date" HeaderStyle-Width="100px"/>
            <asp:BoundField DataField="Actual_Completed_Date" HeaderText="实际完工日期" SortExpression="Actual_Completed_Date" HeaderStyle-Width="140px"/>
            <asp:BoundField DataField="RouterName" HeaderText="路由名称" SortExpression="RouterName" HeaderStyle-Width="90px"/>
            <asp:BoundField DataField="ModifyBy" HeaderText="排产人" SortExpression="ModifyBy" HeaderStyle-Width="70px"/>
            <asp:BoundField DataField="ModifyTime" HeaderText="排产日期" SortExpression="ModifyTime" HeaderStyle-Width="100px"/>
        </Columns>
    </asp:GridView>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" runat="server" clientidmode="Static" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" runat="server" clientidmode="Static" />
    <asp:HiddenField runat="server" ID="hfCheckBox" ClientIDMode="Static" />
    <script type="text/javascript">
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");
        var hfcheck = $("#hfCheckBox").val();
        if ($("#hfStrOrderStatus").val() != undefined) {
            setCheckBox(hfcheck, 'lblOrderStatus');
        }
        var flag = 0;
        $(function () {
            gridCellsChangeNo = true;
        });
       

        function Scheduling(planType) {
            Edit(planType);
        }

      

        function View() {
            var id = getOneRecordId();
            if (id == "") return false;
            //xiang.yan 2024-4-28  列取值由索引改为列明
            // 5 改为 ResName
            var resName = getOneRecordCellTextByFiled("ResName");
            if (resName == "默认资源") {
                openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Plan/PlanSchedulView.aspx?ID=" + id;
            } else {
                openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Plan/PlanSchedulResouceView.aspx?ID=" + id;
            }

            dialog({ title: mesLang("查看工单排产信息"), src: openWinUrl, width: 1000, height: 420 })
        }

        /*刷新页面*/
        function Refresh() {
            hdnOperate.val("");
            hdnIdString.val("");
            document.forms[0].submit();
        }

        function openChoosePage(flags) {
            flag = flags;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=" + flags + "&Multiple=false&rnd=" + Math.random(), width: 680, height: 300 });
        }

        function getChooseValue(list) {
            if (flag == 1) {
                $("#txtItemName").val(list[0][2]);
                $("#hdnItemId").val(list[0][0]);
            }
            else if (flag == 21) {
                $("#<%= this.txtLine.ClientID %>").val(list[0][1]);
            }
        flag = -1;
    }

    //根据得到的JSON生成checkBox  Birong@2016-07-15
    function setCheckBox(strJson, showID) {
        var objJson;
        var checkedStatus = $("#hfStrOrderStatus").val();
        if (typeof strJson === 'undefined' || strJson === "") { return; }
        else { objJson = $.parseJSON(strJson); }
        if (typeof objJson === 'undefined') { return; }
        var statusArr = checkedStatus.split(',');

        for (i = 0; i < objJson.length; i++) {
            var ItemIndex = objJson[i].ItemIndex;
            var ItemName = objJson[i].ItemName;
            var isChecked = '';

            if (statusArr.length > 0 && $.inArray(ItemIndex.toString(), statusArr) > -1) {
                isChecked = "checked = 'checked'";
            }

            var checkbox = "<input type='checkbox' style='float:left' class='chkBox' " + isChecked + " name='OrChkBox' value=" + ItemIndex + " alt=" + ItemName + " /><span style='float:left'>" + ItemName + "</span>";
            $("#" + showID).append(checkbox);
        }
    }

    //绑定checkBox事件
    $(".chkBox").change(function () {
        var strChecked = "";
        $("input[name='OrChkBox']:checked").each(function () { strChecked += $(this).val() + ','; })
        $("#hfStrOrderStatus").val(strChecked.slice(0, -1));

    })

    /**
    *排产确认
    **/
    function PlanConfirm() {
        var id = getOneRecordId();
        if (id == "") return false;
        if (confirm("是否确定要进行排产确认操作！")) {
            //xiang.yan 2024-4-28  列取值由索引改为列明
            // 1 改为 FBILLNO
            var planOrderNo = getOneRecordCellTextByFiled("FBILLNO");

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPlan.ConfirmLinePlanInfo(planOrderNo);

            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert('排产信息确认成功！');
            Refresh();
        }
    }

    /**
    *电子备料清单维护
    **/
    function AddPostionAndReplaceItem() {
        //xiang.yan 2024-4-28  列取值由索引改为列明
        // 2 改为 LinePlanType
        if (getOneRecordCellTextByFiled("LinePlanType") == '其他排期') {
            alert("电子备料清单只针对【SMT排期】类型的工单，您当前选择的是【其他排期】，请重新选择");
            return false;
        }
       
        var id = getOneRecordId();
        if (id == "") return false;
        //xiang.yan 2024-4-28  列取值由索引改为列明
        // 1 改为 FBILLNO
        var planOrderNo = getOneRecordCellTextByFiled("FBILLNO");

        openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Plan/StockListEdit.aspx?name=Plan_StockList&ID=" + id + "&PlanOrderNo=" + escape(planOrderNo);
        dialog({ title: "<%=Resources.Pages.Plan_StockList %>", src: openWinUrl, width: 1000, height: 620 });
        hdnOperate.val("");
        hdnIdString.val("");
    }

    /**
    *工单换线
    **/
    function ChangeLine() {
        var id = getOneRecordId();
        if (id == "") return false;
        //xiang.yan 2024-4-28  列取值由索引改为列明
        // 1 改为 FBILLNO
        var planOrderNo = getOneRecordCellTextByFiled("FBILLNO");

        openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Plan/StockListChangeOrder.aspx?name=Plan_ChangeLine&ID=" + id + "&PlanOrderNo=" + escape(planOrderNo);
        dialog({ title: "<%=Resources.Pages.Plan_ChangeLine %>", src: openWinUrl, width: 800, height: 350 });
        hdnOperate.val("");
        hdnIdString.val("");
    }
        //撤消排期
        function CancelScheduling() {

            var chObj = $("#<%=this.GridView1.ClientID%>").find("input[name='chkSelect']");
            var idStr = "";
            for (var i = 0; i < chObj.length; i++) {
                if ($(chObj[i]).attr("checked")) {
                    idStr = $(chObj[i]).attr("value");
                }
            }
            if (idStr == "") return false;

            if (confirm("是否确定要撤消此工单的所有排期！")) {
                hdnOperate.val("delete");
                hdnIdString.val(idStr);
                document.forms[0].submit();
            }
        }
    /**
    *齐套检查
    **/
    function CheckHomogeneity() {
        var id = getOneRecordId();
        if (id == "") return false;
        //xiang.yan 2024-4-28  列取值由索引改为列明,功能已去除
        // 1 改为 FBILLNO
        var planOrderNo = getOneRecordCellTextByFiled("FBILLNO");
        var entity = {};
        entity.FBILLNO = planOrderNo;
        var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPlan.CheckMaterialHomogeneity(entity);
        if (ajax.error != null) {
            alert(ajax.error.Message);
            return false;
        }
        var value = ajax.value;
        var flag = value[0];
        var msg = value[1];
        if (msg != null && msg != "") {
            alert(msg);
            return;
        }
        var result = "";
        if (flag == "0") {
            result = "否";
            ShowHomogeneityDetail(planOrderNo);
        } else if (flag == "1") {
            result = "是";
            if (confirm("物料齐套，是否查看明细？")) {
                ShowHomogeneityDetail(planOrderNo);
            }
        } else if (flag == "2") {
            alert("排产工单物料锁定，不能进行齐套检查");
            return;
        }
        $("input[type=checkbox][name=chkSelect]:checked").parent().siblings(".homogeneity").html(result);
    }

    /**
    *显示物料齐套明细
    **/
    function ShowHomogeneityDetail(planOrderNo) {
        var url = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Plan/PlanMaterialHomogeneityDetail.aspx?planNo=" + escape(planOrderNo);
        dialog({ title: "物料齐套明细", src: url, width: 860, height: 600, end: function () { alert("asdafew"); } });
    }

    /**
    *物料锁定
    **/
    function MaterialLock() {
        var id = getOneRecordId();
        if (id == "") return false;
        //xiang.yan 2024-4-28  列取值由索引改为列明,功能已去除
        // 1 改为 FBILLNO
        var planNo = getOneRecordCellTextByFiled("FBILLNO");
        var entity = {};
        entity.FBILLNO = planNo;
        var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPlan.MaterialLock(entity);
        if (ajax.error != null) {
            alert(ajax.error.Message);
            return false;
        }
        alert("锁定成功");
        Refresh();
    }

    </script>
</asp:Content>
