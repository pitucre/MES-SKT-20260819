<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ManualMaterial.aspx.cs"
    MasterPageFile="~/Masters/EditHeadMaster.master" Inherits="SKT.LeanMES.Web.Client.ManualMaterial" %>
<%@ Import Namespace="Resources" %>
<%@ Import Namespace="SKT.LeanMES.Web" %>
<%@ MasterType VirtualPath="~/Masters/EditHeadMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <%--<link href="../Content/productioncollection.css" rel="Stylesheet" type="text/css" />--%>
    <link href="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/datetimepicker/jquery.datetimepicker.css" rel="stylesheet" />
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.utility.tablelist.js?v=20211209"
        type="text/javascript"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.utility.validation.js"
        type="text/javascript"></script>
     <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/datetimepicker/jquery.js" type="text/javascript"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/datetimepicker/jquery.datetimepicker.min.js" type="text/javascript"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/datetimepicker/jquery.datetimepicker.full.js" type="text/javascript"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/datetimepicker/jquery.datetimepicker.js" type="text/javascript"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/datetimepicker/jquery.datetimepicker.min.js" type="text/javascript"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/datetimepicker/jquery.datetimepicker.full.min.js" type="text/javascript"></script>
    <div id="" class="">
        <table class="EditeContentTable" width="100%">
            <tr>
                <td class="infoTips" colspan="4">
                    <%=Resources.Messages.WithAsteriskIsRequired %>
                </td>
            </tr>
            <tr class="clear5">
            </tr>
            <tr>
                <td class="Label4">
                    <%= lang.ShopOrder %><em>*</em>
                </td>
                <td class="Field4">
                    <asp:TextBox ID="txtOrderNO" runat="server" CssClass="TextBox" Enabled="false" ClientIDMode="Static"
                        Width="64%"></asp:TextBox><input type="button" id="btnSelectOrder" class="ButtonBox" value="..."
                        title="Select" onclick="openChoosePage(116);" />
                    <asp:HiddenField ID="hfOrderId" runat="server" Value="-1" ClientIDMode="Static" />
                </td>
                <td class="Label4">
                    产品编码
                </td>
                <td id="txtOrderItemCode" class="Field4">
                </td>
            </tr>
            <tr>
                <td class="Label4">
                    物料编码<em>*</em>
                </td>
                <td class="Field4">
                    <asp:TextBox ID="txtItemName" runat="server" CssClass="TextBox" Enabled="false" ClientIDMode="Static"
                        Width="64%"></asp:TextBox><input type="button" id="btnSelectItem" class="ButtonBox" value="..."
                        title="Select" onclick="openChoosePage(112);" /> 
                    <asp:HiddenField ID="hdnItemId" runat="server" Value="-1" ClientIDMode="Static" />
                </td>
                <td class="Label4">
                    物料描述
                </td>
                <td id="txtProductDesc" class="Field4">
                </td>
            </tr>
            <tr>
                <td class="Label4">
                    需求时间<em>*</em>
                </td>
                <td class="Field4">
                    <asp:TextBox ID="txtReqTime" runat="server"  isrequired='1' 
                        Width="140" ClientIDMode="Static">
                    </asp:TextBox>
                    <img style="vertical-align: middle; cursor: pointer; margin-top: -2px; margin-left: -18px;
                        margin-right: 5px" class="ui-datepicker-trigger" src="../Content/plugin/calendar/skin/images/calendar2.png"
                        alt="选择日期" title="选择日期">
                </td>
                <td class="Label4">
                    单位用量
                </td>
                <td class="Field4" id="txtPerNum">
                  
                </td>
            </tr>
            <tr>
                <td class="Label4">
                    叫料数量<em>*</em>
                </td>
                <td class="Field4">
                    <input type="text" id="txtCallNum" isnumber='1' minvalue='12' isrequired='1' maxlength='10'>
                </td>
                <td class="Label4">
                    计划用量
                </td>
                <td class="Field4" id="txtTotalNum">
                </td>

            </tr>
            <tr>
                <td class="Label4">
                </td>
                <td class="Field4" id="txtEndNum">
                </td>
                <td class="Label4">
                    累计叫料
                </td>
                <td class="Field4" id="txtSumOutNum">
                </td>

                <%--<td class="Label4">
                    合计用量
                </td>--%>

            </tr>
        </table>
    </div>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
        <div class="divHeader">叫料记录</div>
        <div>
        <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" OnRowDataBound="GridView1_OnRowDataBound">
            <Columns>
                <asp:BoundField DataField="OrderNO" HeaderText="工单号" HeaderStyle-Width="80px" SortExpression="ItemCode" />
                <asp:BoundField DataField="ItemCode" HeaderText="物料编码" SortExpression="ItemCode" />
                <asp:BoundField DataField="ItemName" HeaderText="物料描述" HeaderStyle-Width="65px" SortExpression="ItemName" />
                <asp:BoundField DataField="PerNum" HeaderText="单位用料" HeaderStyle-Width="50px" SortExpression="PerNum" />
                <%--<asp:BoundField DataField="OutQty" HeaderText="合计总数" HeaderStyle-Width="60px" SortExpression="OutQty" />--%>
                <asp:BoundField DataField="Qty" HeaderText="叫料数量" HeaderStyle-Width="80px" SortExpression="Qty" />
                <asp:BoundField DataField="SumQty" HeaderText="累计总数" HeaderStyle-Width="60px" SortExpression="SumQty" />
                <asp:BoundField DataField="States" HeaderText="状态" HeaderStyle-Width="60px" SortExpression="States" />
                <asp:BoundField DataField="RequireTime" HeaderText="需求时间" HeaderStyle-Width="60px"
                    SortExpression="RequireTime" />
                <asp:BoundField DataField="CreateBy" HeaderText="创建人" HeaderStyle-Width="60px" SortExpression="CreateBy" />
                <asp:BoundField DataField="CreateDateTime" HeaderText="创建时间" HeaderStyle-Width="60px"
                    SortExpression="CreateDateTime" />
            </Columns>
        </asp:GridView>
        <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
            MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Product.BLL.OrderBom"
            SelectMethod="GetMenCallInfo" SelectCountMethod="GetCount">
            <SelectParameters>
                <asp:Parameter Name="searchSettings" Type="Object" />
            </SelectParameters>
        </asp:ObjectDataSource>
        </div>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <script type="text/javascript">
        var isMultiple = false;
        
        var globalFlag= -1;
        var userName = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';
        var userId = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserId %>';
        var orderNoId= -1;
        var lineName = '<%= Request.QueryString["line"] %>';
        var stationId= <%= Request.QueryString["sid"] %>;
        var itemId;
        var resId=<%= Request.QueryString["resId"] %>;
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");

        $(document).ready(function () {
            $.datetimepicker.setLocale('ch');//设置中文
        $('#txtReqTime').datetimepicker({
            dayOfWeekStart: 1,
            lang: 'ch',
            step:10

           
        });
        });

        function Cancel() {
            var idStr = getDeletingRecordIdString();
            if (idStr === "") return false;
            hdnOperate.val("delete");
            hdnIdString.val(idStr);
            document.forms[0].submit();
        }

        function Add() {
            var tNum = $("#txtTotalNum").html()*1;
            var tPNum = $("#txtPerNum").html()*1;
            var endNum = $("#txtEndNum").html()*1;
            var sumOutNum = $("#txtSumOutNum").html()*1;
            var callNum = $("#txtCallNum").val()*1;
            var dateNow = (new Date()).getDate();
        //数量日期验证
            if (callNum > (tNum-sumOutNum)) {
                alert("叫料数量已超出计划总数");
                return false;
            }
            if (!($("#txtOrderNO").val() !== '' && $("#txtCallNum").val() !== '' 
                                            && $("#txtReqTime").val() !== '')) {
                alert("请填写带星号信息");
                return false;
            }
            var rdate = (new Date($("#txtReqTime").val())).getDate();
            if (dateNow > rdate) {
                alert("需求时间不能小于当前日期");
                return false;
            }

            rdate = $("#txtReqTime").val();
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxClient.AddMenCall(orderNoId,itemId,stationId,resId,callNum,rdate,userName);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, "", ajax.error.Message);
                return false;
            } else {
                alert("<%=Resources.Messages.SaveInSuccess %>");
                document.forms[0].submit();
            }
        }

        function openChoosePage(flags) {
            var condition = "";
            globalFlag = flags;
            switch (flags) {
                case 116:
                //工单过滤，产线，状态
                    condition = " Status =1 ";
                    break;
                case 112:
                if ($("#txtOrderNO").val() === '') {
                    alert("请先选择工单");
                    return false;
                }
                //物料过滤，工单，工序
                    condition = " OrderNO ='"+$("#txtOrderNO").val()+"' ";
                    break;
                default:
                   // condition = "1=1";
                    break;
            }
            dialog({
                title: "<%= Common.ChooseWindow %>",
                src: "<%= WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=" + flags +
                "&Multiple=false&PageCondition=" +
                escape(condition) +
                "&rnd=" +
                Math.random(),
                width: 600,
                height: 300
            });

        }

        function getChooseValue(list) {
            if (globalFlag * 1 === 112) { //可选物料    
                $("#txtItemName").val(list[0][1]);
                itemId = list[0][0];
                $("#hdnItemId").val(list[0][0]);
                $("#txtProductDesc").html(list[0][2]);
            }
            if (globalFlag * 1 === 116) {    //可选工单
                $("#txtOrderNO").val(list[0][1]);
                $("#txtOrderItemCode").html(list[0][5]);
                orderNoId = list[0][0];
                $("#hfOrderId").val(list[0][0]);
            }
            if ($("#txtOrderNO").val()!=='' && $("#txtItemName").val()!=='') {
                getDetailInfo();
            }
        }

        function getDetailInfo() {
            var _orderId = orderNoId;
            var _stationId = stationId;
            var _itemId = itemId;
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxClient.GetMenCallDetailInfo(_orderId,_stationId,_itemId);
            if (ajax.error !== null) {
                alert("获取详细数量信息失败");
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, "", ajax.error.Message);
                return false;
            }
            var objResult = $.parseJSON(ajax.value);
            if (objResult.length === 0) {
                return false;
                }
            $("#txtTotalNum").html(objResult[0].TotalNum);
            $("#txtPerNum").html(objResult[0].PerNum);
            //$("#txtEndNum").html(objResult[0].EndNum);
            $("#txtSumOutNum").html(objResult[0].SumOutNum);

        }
    </script>
</asp:Content>
