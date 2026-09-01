<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true"
    Inherits="SKT.MES.Web.Production.ShopOrderList" CodeBehind="ShopOrderList.aspx.cs"
    ValidateRequest="false" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label3">
                <%=Resources.lang.OrderNumber%>
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtOrderNo" runat="server"></asp:TextBox>
            </td>
            <td class="Label3">工单类型
            </td>
            <td class="Field3">
                <asp:DropDownList ID="ddlOrderType" runat="server">
                    <asp:ListItem Value="-1" Text="所有"> </asp:ListItem>
                    <asp:ListItem Value="1" Text="正常"> </asp:ListItem>
                    <asp:ListItem Value="2" Text="RMA"> </asp:ListItem>
                    <asp:ListItem Value="3" Text="返工"> </asp:ListItem>
                    <asp:ListItem Value="4" Text="委外加工"> </asp:ListItem>
                    <asp:ListItem Value="5" Text="受托加工"> </asp:ListItem>
                    <asp:ListItem Value="6" Text="重复生产"> </asp:ListItem>
                </asp:DropDownList>
            </td>
            <td class="Label3">工单来源
            </td>
            <td class="Field3">
                <asp:DropDownList ID="ddlIsMESadd" runat="server">
                    <asp:ListItem Value="-1" Text="所有"> </asp:ListItem>
                    <asp:ListItem Value="0" Text="ERP导入"> </asp:ListItem>
                    <asp:ListItem Value="1" Text="MES创建"> </asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="Label3">
                <%= Resources.lang.ItemCode %>
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtItem" runat="server" CssClass="TextBox"></asp:TextBox><input
                    type="button" id="btnSelectItem" onclick="openChoosePage(1);" class="ButtonBox"
                    value="..." />
            </td>

            <td class="Label3">
                <%= Resources.lang.CustomerName%>
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtCustName" runat="server"></asp:TextBox><input
                    type="button" id="Button2" onclick="chooseCustName();" class="ButtonBox"
                    value="..." />
            </td>
            <td class="Label3">订单号
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtCustomerOrder" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <%--<td class="Label3">
                线别
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtLine" runat="server"></asp:TextBox><input
                    type="button" id="Button1" onclick="chooseLine();" class="ButtonBox"
                    value="..." />
            </td>--%>
        </tr>
        <tr>
            <td class="Label3">计划开始时间
            </td>
            <td class="Field3">
                <asp:TextBox CssClass="DateTimeBox" ID="txtPlanBegin" runat="server"></asp:TextBox>
            </td>
            <td class="Label3">工单状态
            </td>
            <td class="Field3" id="showChkBox">
                <asp:HiddenField runat="server" ID="hfStrOrderStatus" ClientIDMode="Static" />
            </td>
            <td class="Label3">路由
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtRouter" runat="server"></asp:TextBox><input
                    type="button" id="btnSelectRouter" onclick="openChoosePage(22);" class="ButtonBox"
                    value="..." />
                <asp:HiddenField ID="hdnRId" runat="server" Value="-1" />
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" AutoGenerateColumns="false"
        OnRowDataBound="GridView1_OnRowDataBound" ClientIDMode="Static" Style="table-layout: fixed; word-wrap: break-word; word-break: break-all">
        <Columns>
            <asp:BoundField DataField="ProdOrderGroupID" HeaderText="关联组" SortExpression="ProdOrderGroupID" HeaderStyle-Width="60px" />
            <asp:BoundField DataField="OrderNO" HeaderText="<%$ Resources:lang,ShopOrder %>" SortExpression="OrderNO" HeaderStyle-Width="120px" />
            <asp:BoundField DataField="CustomerOrder" HeaderText="订单号" SortExpression="CustomerOrder" HeaderStyle-Width="120px" />
            <asp:BoundField DataField="ItemCode" HeaderText="<%$ Resources:lang,ItemCode %>" SortExpression="ItemCode" HeaderStyle-Width="120px" />
            <asp:BoundField DataField="ItemName" HeaderText="<%$ Resources:lang,ItemsName %>" SortExpression="ItemName" HeaderStyle-Width="140px" />
            <asp:BoundField DataField="ItemSpec" HeaderText="<%$ Resources:lang,ItemModel %>" SortExpression="ItemSpec" HeaderStyle-Width="240px" />
            <asp:BoundField DataField="qty_to_Build" HeaderText="<%$ Resources:lang,Qty_to_Build %>" SortExpression="qty_to_Build" HeaderStyle-Width="80px" />
            <asp:BoundField DataField="Qty_Released" HeaderText="<%$ Resources:lang,Qty_Released %>" SortExpression="Qty_Released" HeaderStyle-Width="80px" />
            <asp:BoundField DataField="Qty_Done" HeaderText="<%$ Resources:lang,Qty_Done %>" SortExpression="Qty_Done" HeaderStyle-Width="80px" />
            <asp:BoundField DataField="Qty_Scrapped" HeaderText="<%$ Resources:lang,Qty_Scrapped %>" SortExpression="Qty_Scrapped" HeaderStyle-Width="80px" />
            <asp:BoundField DataField="InventoryQuantity" HeaderText="已入库数量" SortExpression="InventoryQuantity" HeaderStyle-Width="80px" />
            <asp:BoundField DataField="OrderTypeName" HeaderText="<%$ Resources:lang,OrderType %>" SortExpression="OrderTypeName" HeaderStyle-Width="70px" />
            <asp:BoundField DataField="StatusDesc" HeaderText="<%$ Resources:lang,Status %>" SortExpression="Status" HeaderStyle-Width="70px" />
            <asp:BoundField DataField="R_Name" HeaderText="<%$ Resources:lang,RouterName %>" SortExpression="R_Name" HeaderStyle-Width="100px" />
            <asp:BoundField DataField="CustomerName" HeaderText="<%$ Resources:lang,CustomerName %>" SortExpression="CustomerName" HeaderStyle-Width="100px" />
            <asp:BoundField DataField="PlanStart" HeaderText="工单计划开始日期" SortExpression="PlanStart" HeaderStyle-Width="120px" />
            <asp:TemplateField HeaderText="工单实际开始日期" SortExpression="Actual_Start_Date" HeaderStyle-Width="120px">
                <ItemTemplate>
                    <%#Eval("Actual_Start_Date").ToString() == "9999/12/31 0:00:00" ? "" : Eval("Actual_Start_Date","{0:yyyy-MM-dd}").ToString()%>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="PlanFinish" HeaderText="工单计划完成日期" SortExpression="PlanFinish" HeaderStyle-Width="120px" />
            <asp:TemplateField HeaderText="工单实际完成日期" HeaderStyle-Width="120px" SortExpression="Actual_Completed_Date">
                <ItemTemplate>
                    <%#Eval("Actual_Completed_Date").ToString() == "9999/12/31 0:00:00" ? "" : Eval("Actual_Completed_Date","{0:yyyy-MM-dd}").ToString()%>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="IsMESaddDesc" HeaderText="工单来源" SortExpression="IsMESadd" HeaderStyle-Width="80px" />
            <asp:BoundField DataField="ModifyBy" HeaderText="修改人" SortExpression="ModifyBy" ItemStyle-Width="100px" />
            <asp:BoundField DataField="ModifyDateTime" SortExpression="a.ModifyDateTime" HeaderText="<%$ Resources:lang,ModifyDateTime %>" ItemStyle-Width="160px" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Order.BLL.ShopOrder"
        SelectMethod="GetAllNoLine" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <asp:HiddenField runat="server" ID="hfCheckBox" ClientIDMode="Static" />
    <script type="text/javascript">
        isMultiple = false;
        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");
        var date = "";
        var hfcheck = $("#hfCheckBox").val();
        setCheckBox(hfcheck, 'showChkBox');
        $(function () {
            gridCellsChangeNo = true;
            var oname = $.trim(window.localStorage.getItem("OrganizationName"));
            if (oname) {
                if (oname != "集团总部") {
                    $('div.toolbar-btn[title="数据下发"]').hide();
                    $('div.toolbar-btn[title="数据下发"]').next("div.btn-line").hide();
                }
            } else {
                $('div.toolbar-btn[title="数据下发"]').hide();
                $('div.toolbar-btn[title="数据下发"]').next("div.btn-line").hide();
            }
        });
        //新增
        function Add() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Product/ShopOrderEdit.aspx?name=ShopOrder_Add&ID=-1";
            dialog({ title: "<%=Resources.Pages.ShopOrder_Add %>", src: openWinUrl, width: 980, height: 480 });
            //window.parent.openLeftMenu(this, "<%=Resources.Pages.ShopOrder_Add %>", openWinUrl, '-1');

        }

        //编辑
        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;

            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Product/ShopOrderEdit.aspx?name=ShopOrder_Edit&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.ShopOrder_Edit %>", src: openWinUrl, width: 980, height: 480 });
            //window.parent.openLeftMenu(this, "<%=Resources.Pages.ShopOrder_Edit %>", openWinUrl, idStr);

        }

        //删除 只可单条删除
        function Delete() {
            var idStr = getDeletingRecordIdString();
            if (idStr == "") return false;
            hdnOperate.val("delete");
            hdnIdString.val(idStr);
            document.forms[0].submit();
        }

        function UpdateList(namestr) {
            $("#txtOrderNO").val(namestr);
            document.forms[0].submit();
        }

        function openChoosePage(flags) {
            flag = flags;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=" + flags + "&Multiple=false&rnd=" + Math.random(), width: 680, height: 350 });
        }

        function chooseLine() {
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=21&Multiple=false&CallBackFunc=setLine&rnd=" + Math.random(), width: 680, height: 350 });
        }

        function chooseCustName() {
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=10&Multiple=false&CallBackFunc=setCustomerName&rnd=" + Math.random(), width: 680, height: 350 });
        }

        function getChooseValue(list) {
            if (flag == 1) {
                $("#<%= this.txtItem.ClientID %>").val(list[0][2]);
            }
            if (flag == 22) {
                $("#<%= this.txtRouter.ClientID %>").val(list[0][1]);
                $("#<%= this.hdnRId.ClientID %>").val(list[0][0]);
            }
            flag = -1;
        }

        function setLine(list) {

        }

        function setCustomerName(list) {
            $("#<%=this.txtCustName.ClientID %>").val(list[0][1]);
        }

        //释放工单
        function Release() {
            var idStr = getOneRecordId();
            if (idStr == "") { return false; }

            if (checkIsReady(idStr, 'one')) {
                //xiang.yan 2024-4-28  列取值由索引改为列明
                // 1 改为 OrderNO
                // 3 改为 ItemCode
                // 7 改为 Qty_Released
                // 8 改为 ItemCode
                var orderNO = getOneRecordCellTextByFiled("OrderNO");
                var itemCode = getOneRecordCellTextByFiled("ItemCode");
                var orderType = -9//getOneRecordCellText(5);
                var canReleaseQty = getOneRecordCellTextByFiled("Qty_Released") - getOneRecordCellTextByFiled("Qty_Done");
                var ItemID = getRowAttribute(document.getElementById("GridView1"), "ItemID");
                var RouteID = getRowAttribute(document.getElementById("GridView1"), "RouteID");
                var ItemVer = getRowAttribute(document.getElementById("GridView1"), "ItemVer");
                var ItemName2 = getRowAttribute(document.getElementById("GridView1"), "ItemName2");
                var BOMID = getRowAttribute(document.getElementById("GridView1"), "BOMID");

                var url = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>"
                    + "/Product/ShopOrderRelease.aspx?name=ShopOrder_Release&orderNO=" + escape(orderNO)
                    + "&orderType=" + escape(orderType)
                    + "&itemCode=" + escape(itemCode)
                    + "&canReleaseQty=" + canReleaseQty
                    + "&ItemID=" + ItemID
                    + "&RouteID=" + RouteID
                    + "&ItemVer=" + escape(ItemVer)
                    + "&ItemName2=" + escape(ItemName2)
                    + "&BOMID=" + BOMID
                    + "&OrderID=" + idStr;
                OpenReleaseDialog(url, "释放工单");
            }

        }

        //one:释放工单/释放拼版   all:释放批次条码
        //释放批次条码
        function ReleaseBatch() {
            var idStr = getOneRecordId();
            if (idStr == "") { return false; }

            if (checkIsReady(idStr, 'all')) {
                //xiang.yan 2024-4-28  列取值由索引改为列明
                // 1 改为 OrderNO
                // 4>3 改为 ItemCode
                // 7 改为 Qty_Released
                // 8 改为 ItemCode
                var orderNO = getOneRecordCellTextByFiled("OrderNO");
                var itemCode = getOneRecordCellTextByFiled("ItemCode");
                var orderType = -9//getOneRecordCellText(5);
                var canReleaseQty = getOneRecordCellTextByFiled("Qty_Released") - getOneRecordCellTextByFiled("Qty_Done");
                var ItemID = getRowAttribute(document.getElementById("GridView1"), "ItemID");
                var RouteID = getRowAttribute(document.getElementById("GridView1"), "RouteID");
                var ItemVer = getRowAttribute(document.getElementById("GridView1"), "ItemVer");
                var ItemName2 = getRowAttribute(document.getElementById("GridView1"), "ItemName2");
                var BOMID = getRowAttribute(document.getElementById("GridView1"), "BOMID");

                var url = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>"
                    + "/Product/ShopOrderReleaseBatch.aspx?name=ShopOrder_ReleaseBatch&orderNO=" + escape(orderNO)
                    + "&orderType=" + escape(orderType)
                    + "&itemCode=" + escape(itemCode)
                    + "&canReleaseQty=" + canReleaseQty
                    + "&ItemID=" + ItemID
                    + "&RouteID=" + RouteID
                    + "&ItemVer=" + escape(ItemVer)
                    + "&ItemName2=" + escape(ItemName2)
                    + "&BOMID=" + BOMID
                    + "&OrderID=" + idStr
                    + "&mySNQty=" + mySNQty;
                OpenReleaseDialog(url, "释放批次条码");
            }

        }

        /*释放工单/释放批次条码共用一个校验存储过程，校验通过，获取返回的每批次条码数量*/
        var mySNQty = 1;
        function checkIsReady(soid, type) {
            var isOk = true;
            var entity = {};
            entity.ProOrderId = soid; //工单ID
            entity.type = type; //类型
            var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("Prod_OrderCheckCanbeReleaseNew", JSON.stringify(entity));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                isOk = false;
            }
            else {
                var en = $.parseJSON(ajax.value);
                mySNQty = en.data[0].SNCount;
            }
            return isOk;
        }

        function OpenReleaseDialog(url, mytitle) {
            dialog({ title: mytitle, src: url, width: 680, height: 350, resizeable: true });
        }



        //ERP导入的工单路由绑定  add  zhibin.chen  2015-09-21
        function RouterBind() {
            var idStr = getOneRecordId();
            if (idStr == "") { return false; }
            var isMESadd = getRowAttribute(document.getElementById("GridView1"), "IsMESadd");
            if (isMESadd != "0") {
                alert("请选择从ERP导入的工单！");
                return false;
            }

            var routerName = getRowAttribute(document.getElementById("GridView1"), "RouterName");
            if (routerName != "") {
                if (!window.confirm("该工单的产品已绑定路由(" + routerName + ")，是否仍要绑定其他路由!")) {
                    return false;
                }
            }

            var url = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>"
                + "/Product/RouterBind.aspx?name=ShopOrder_RouterBind&"
                + "&OrderID=" + idStr;
            OpenRouterBindDialog(url);
        }

        function checkDateTimeBox() {
            $(".DateTimeBox").bind("change", function () {
                var date = $(this);
                if (date.val().length == 10) {
                    date.val(date.val().substr(0, 10) + " 00:00");
                }
                if (date.val().length != 16 && date.val().length != 0) {
                    alert("<%=Resources.Messages.InvalidateDate %>");
                    $(this).val("");
                    return;
                }
            });
        }

        function OpenRouterBindDialog(url) {
            dialog({ title: "<%=Resources.Pages.RouterBind %>", src: url, width: 680, height: 420, resizeable: true });
        }

        //根据得到的JSON生成checkBox  Birong@2016-07-15
        function setCheckBox(strJson, showID) {
            var objJson;
            var checkedStatus = $("#hfStrOrderStatus").val();
            var status = [];
            if (typeof strJson === 'undefined' || strJson === "") { return; }
            else { objJson = $.parseJSON(strJson); }
            if (typeof objJson === 'undefined') { return; }
            for (i = 0; i < objJson.length; i++) {
                var ItemIndex = objJson[i].ItemIndex;
                var ItemName = objJson[i].ItemName;
                var isChecked = '';
                if (checkedStatus !== '' && checkedStatus.indexOf(ItemIndex) !== -1) { isChecked = "checked = 'checked'"; }
                if (checkedStatus === '') { isChecked = "checked = 'checked'"; }
                if (ItemIndex == '4' || ItemIndex == '7') {
                    isChecked = "";
                }
                else {
                    status.push(ItemIndex)
                }
                //float: left; vertical - align: middle;  float:left; padding-right:5px; vertical-align:middle; line-height:18px;
                var checkbox = "<input type='checkbox' style='' class='chkBox' " + isChecked + " name='OrChkBox' value=" + ItemIndex + " alt=" + ItemName + " /><span style=''>" + ItemName + "</span>";
                $("#" + showID).append(checkbox);
                $("#hfStrOrderStatus").val(status.join(','));
            }

        }
        //绑定checkBox事件
        $(".chkBox").change(function () {
            var strChecked = "";
            $("input[name='OrChkBox']:checked").each(function () { strChecked += $(this).val() + ','; })
            $("#hfStrOrderStatus").val(strChecked.slice(0, -1));

        })

        function checkOrderIsPrintPanel(prodOrderId) {
            var orderId = parseInt(prodOrderId);
            var isOk = true;
            //uspCheckOIsPrintPanel
            var cmd = "W0CZRQx9vs5ZLXyCuYm76yNXGHsJffGxZyvMHuDAM18=";
            var params = [], param = {};
            //@ProOrderId
            param.ParamName = "CUQDKTtX5AcM4ynRRYIExWPN8I2vS4SJ"; //@ProdOrderId
            //INT
            param.ParamType = "1o/d3CICk7c=";
            param.ParamValue = orderId;
            param.ParamSize = 0;
            params.push(param);

            param = {};
            param.ParamName = "ne+2qABn/VXMeJU9YR2mWQ=="; //@SNCount
            param.ParamType = "5oOl+OlrvoeNaXvVzIdtQw==";
            param.ParamValue = snCount;
            param.ParamSize = 0;
            params.push(param);


            var result = SKT.LeanMES.Web.Controls.PageSQLService.ExecuteNonQuery(cmd, params);
            if (result.error != null) {
                alert(result.error.Message);
                isOk = false;
            } else {
                snCount = parseInt(result.value);
            }
            return isOk;
        }
        //释放拼板
        var snCount = 1;//子板数量
        function ReleasePanel() {
            var idStr = getOneRecordId(); //获取工单id
            if (idStr == "") { return false; }

            if (checkOrderIsPrintPanel(idStr)) {
                //xiang.yan 2024-4-28  列取值由索引改为列明
                // 1 改为 OrderNO
                // 2>3 改为 ItemCode
                // 4>7 改为 Qty_Released
                //6> 8 改为 ItemCode
                var orderNO = getOneRecordCellTextByFiled("OrderNO");
                var itemCode = getOneRecordCellTextByFiled("ItemCode");
                var orderType = -9//getOneRecordCellText(5);
                var canReleaseQty = getOneRecordCellTextByFiled("Qty_Released") - getOneRecordCellTextByFiled("Qty_Done");
                var ItemID = getRowAttribute(document.getElementById("GridView1"), "ItemID");
                var RouteID = getRowAttribute(document.getElementById("GridView1"), "RouteID");
                var ItemVer = getRowAttribute(document.getElementById("GridView1"), "ItemVer");
                var ItemName2 = getRowAttribute(document.getElementById("GridView1"), "ItemName2");
                var BOMID = getRowAttribute(document.getElementById("GridView1"), "BOMID");

                var url = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>"
                    + "/Product/ShopOrderReleasePanel.aspx?name=ShopOrder_ReleasePanel&orderNO=" + escape(orderNO)
                    + "&orderType=" + escape(orderType)
                    + "&itemCode=" + escape(itemCode)
                    + "&canReleaseQty=" + canReleaseQty
                    + "&ItemID=" + ItemID
                    + "&RouteID=" + RouteID
                    + "&ItemVer=" + escape(ItemVer)
                    + "&ItemName2=" + escape(ItemName2)
                    + "&BOMID=" + BOMID
                    + "&OrderID=" + idStr
                    + "&snCount=" + snCount;
                OpenReleaseDialog(url);
            }
        }
        function Refresh() {
            document.forms[0].submit();
        }
        //数据下发
        function DataDistributionOperate() {
            var idStr = getRecordIdString();
            if (idStr == "") {
                return false;
            }
            var oname = $.trim(window.localStorage.getItem("OrganizationName"));
            if (oname != "集团总部") {
                alert("事业部不能下发数据!");
                return false;
            }
            //xiang.yan 2024-4-29 根据列号去值，改为根据列名取值
            // 1 改为 OrderNO
            var ShopOrderNumberList = getRecordCellTextsByFiled("OrderNO");
            localStorage.setItem("ShopOrderNumberList", ShopOrderNumberList);
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/DataDistribution/CommonHelperDataDistribution.aspx?name=ShopOrderDataDistributionOperate&pra=1";
            dialog({ title: "数据下发", src: openWinUrl, width: 700, height: 400 });
        }
        //绑定工单
        function AddGroup() {
            if (!window.confirm("确定要关联绑定的工单?")) {
                return false;
            }
            var idStr = getRecordIdString();// getRecordIdString();
            if (idStr == "") return false;
            hdnOperate.val("bindgroup");
            hdnIdString.val(idStr);
            document.forms[0].submit();
        }
        //解除绑定
        function ReleaseGroup() {
            if (!window.confirm("确定要解除关联绑定的工单?")) {
                return false;
            }
            var idStr = getRecordCellTextsByFiled('ProdOrderGroupID');
            if (idStr == "") return false;
            hdnOperate.val("releasegroup");
            hdnIdString.val(idStr);
            document.forms[0].submit();
        }
    </script>
</asp:Content>
