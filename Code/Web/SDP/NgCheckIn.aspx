<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="NgCheckIn.aspx.cs" Inherits="SKT.LeanMES.Web.SDP.NgCheckIn" ClientIDMode="Static" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %>
    </div>
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label2">工单号<em>*</em></td>
            <td class="Field2">
                <asp:TextBox ID="txtProdOrder" runat="server" CssClass="TextBox" Width="120px" IsRequired="1"></asp:TextBox>
                <input type="button" class="ButtonBox" value="..." title="选择工单号" onclick="openChoosePage(44);" />
                <asp:HiddenField ID="hdnProdOrderId" runat="server" Value="-1" />
            </td>
            <td class="Label2">机台/线别<em>*</em></td>
            <td class="Field2">
                <asp:TextBox ID="txtRes" runat="server" CssClass="TextBox" Width="120px" IsRequired="1"></asp:TextBox>
                <input type="button" class="ButtonBox" value="..." title="选择线别" onclick="openChoosePage(2020061701);" />
                <asp:HiddenField ID="hdnResId" runat="server" Value="-1" />
            </td>
        </tr>
        <tr>
            <td class="Label2">工序<em>*</em></td>
            <td class="Field2">
                <asp:TextBox ID="txtOpe" runat="server" CssClass="TextBox" Width="120px" IsRequired="1"></asp:TextBox>
                <input type="button" class="ButtonBox" value="..." title="选择工序" onclick="openChoosePage(2020061702);" />
                <asp:HiddenField ID="hdnOpeID" runat="server" Value="-1" />
            </td>
            <td class="Label2">不良现象<em>*</em></td>
            <td class="Field2">
                <asp:TextBox ID="txtDefect" runat="server" CssClass="TextBox" Width="120px" IsRequired="1"></asp:TextBox>
                <input type="button" class="ButtonBox" value="..." title="选择不良现象" onclick="openChoosePage(2020061703);" />
                <asp:HiddenField ID="hdnDefectId" runat="server" Value="-1" />
            </td>
        </tr>
        <tr>
            <td class="Label2">不良数量<em>*</em></td>
            <td class="Field2">
                <asp:TextBox ID="txtDefQTY" runat="server" CssClass="TextBox" Width="140px" IsRequired="1"></asp:TextBox>
            </td>
            <td class="Label2">不良原因<em>*</em></td>
            <td class="Field2">
                <asp:TextBox ID="txtReason" runat="server" CssClass="TextBox" Width="120px" IsRequired="1"></asp:TextBox>
                <input type="button" class="ButtonBox" value="..." title="选择不良原因" onclick="openChoosePage(2020061704);" />
                <asp:HiddenField ID="hdnReasonId" runat="server" Value="-1" />
            </td>
        </tr>
        <tr>
            <td class="Label2">不良总数量</td>
            <td class="Field2" colspan="3">
               <asp:TextBox ID="NgCountQty" runat="server" CssClass="TextBox" Width="140px" disabled="disabled"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">备注</td>
            <td class="Field2" colspan="3">
                <textarea id="txtRemark" rows="3" cols="4" style="width: 92%"></textarea>
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        var flag = -1;

        var ProdOrderId = getQueryString("ProdOrderId");
        var OrderNo = getQueryString("OrderNo");
        var LineName = '<%=Request.QueryString["LineName"].ToString() %>';
        var LineId = getQueryString("LineId");
        var LinePlanCode = getQueryString("LinePlanCode");
        var userId = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserId %>";
        debugger
        if (LineName != "")
        {
            $("#txtProdOrder").val(OrderNo);
            $("#txtRes").val(LineName)
            $("#hdnProdOrderId").val(ProdOrderId)
            $("#hdnResId").val(LineId)

        }

        $(function () {
            var paramObj = {
                OrderId: ProdOrderId,
                LineId: LineId
            }
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSDP.ExecUDFProc("uspGetNgCountQty", JSON.stringify(paramObj));
            if (!!ajax.error) {
                var msg = !!ajax.error.Message ? ajax.error.Message : ajax.error;
                alert(msg)
                $("#hdnProdOrderId").val("-1");
                $("#txtProdOrder").val("");
                return false;
            }
            if (ajax.value.length != 0) {
                var data = JSON.parse(ajax.value);
                $("#NgCountQty").val(data[0].NgCountQty);
            }

            $("#txtProdOrder").keydown(function (event) {
                if (event.keyCode == 13) {
                    var value = $(this).val();
                    if (!!value) {

                        var paramObj = {
                            OrderNO: value
                        }
                        var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSDP.ExecUDFProc("uspGetOrderInfoByNo", JSON.stringify(paramObj));
                        if (!!ajax.error) {
                            var msg = !!ajax.error.Message ? ajax.error.Message : ajax.error;
                            alert(msg)
                            $("#hdnProdOrderId").val("-1");
                            $("#txtProdOrder").val("");
                            return false;
                        }
                        if (ajax.value.length == 0) {
                            $("#hdnProdOrderId").val("-1");
                            $("#txtProdOrder").val("");
                            return false;
                        }
                        var data = JSON.parse(ajax.value);
                        $("#hdnProdOrderId").val(data[0].ProdOrderID);
                        $("#txtProdOrder").val(data[0].OrderNO);
                        setTimeout(function () { $("#txtRes").focus(); }, 100);
                    }
                }
            })
           

            $("#txtRes").keydown(function (event) {
                if (event.keyCode == 13) {
                    var value = $(this).val();
                    if (!!value) {
                        var orderId = $("#hdnProdOrderId").val() * 1;
                        if (flag != 44 && orderId <= 0) {
                            alert("请选择工单！");
                            return false;
                        }
                        var paramObj = {
                            LineName: value,
                            OrderId: orderId
                        }
                        var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSDP.ExecUDFProc("uspGetResNgRecordByNo", JSON.stringify(paramObj));
                        if (!!ajax.error) {
                            var msg = !!ajax.error.Message ? ajax.error.Message : ajax.error;
                            alert(msg)
                            $("#hdnResId").val("-1");
                            $("#txtRes").val("");
                            return false;
                        }
                        if (ajax.value.length == 0) {
                            $("#hdnResId").val("-1");
                            $("#txtRes").val("");
                            return false;
                        }
                        var data = JSON.parse(ajax.value);
                        $("#hdnResId").val(data[0].LineId);
                        $("#txtRes").val(data[0].LineName);
                        setTimeout(function () { $("#txtOpe").focus(); }, 100);
                    }
                }
            });

            $("#txtOpe").keydown(function () {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    var value = $(this).val();
                    if (!!value) {
                        var orderId = $("#hdnProdOrderId").val() * 1;
                        if (flag != 44 && orderId <= 0) {
                            alert("请选择工单！");
                            return false;
                        }
                        var paramObj = {
                            Station: value,
                            OrderId: orderId
                        }
                        var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSDP.ExecUDFProc("uspGetStationNgRecordByNo", JSON.stringify(paramObj));
                        if (!!ajax.error) {
                            var msg = !!ajax.error.Message ? ajax.error.Message : ajax.error;
                            alert(msg)
                            $("#hdnOpeID").val("-1");
                            $("#txtOpe").val("");
                            return false;
                        }
                        if (ajax.value.length == 0) {
                            $("#hdnOpeID").val("-1");
                            $("#txtOpe").val("");
                            return false;
                        }
                        var data = JSON.parse(ajax.value);
                        $("#hdnOpeID").val(data[0].StationId);
                        $("#txtOpe").val(data[0].Station);
                  
                        setTimeout(function () { $("#txtDefect").focus(); }, 100);
                        
                    }
                }
            });

            $("#txtDefect").keydown(function () {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    var value = $(this).val();
                    if (!!value) {

                        var opeId = $("#hdnOpeID").val();
                        if (opeId == "" || opeId == "-1") {
                            alert("请选择工序！");
                            return false;
                        }

                        var paramObj = {
                            NCCode: value,
                            OpeID: opeId
                        }
                        var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSDP.ExecUDFProc("uspGetNCCodeNgRecordByCode", JSON.stringify(paramObj));
                        if (!!ajax.error) {
                            var msg = !!ajax.error.Message ? ajax.error.Message : ajax.error;
                            alert(msg)
                            $("#hdnDefectId").val("-1");
                            $("#txtDefect").val("");
                            return false;
                        }
                        if (ajax.value.length == 0) {
                            $("#hdnDefectId").val("-1");
                            $("#txtDefect").val("");
                            return false;
                        }
                        var data = JSON.parse(ajax.value);
                        $("#hdnDefectId").val(data[0].NCCodeId);
                        $("#txtDefect").val(data[0].NCCode);
                        setTimeout(function () { $("#txtReason").focus(); }, 100);
                    }
                }
            });

            $("#txtReason").keydown(function () {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    var value = $(this).val();
                    if (!!value) {

                        var opeId = $("#hdnOpeID").val();
                        if (opeId == "" || opeId == "-1") {
                            alert("请选择工序！");
                            return false;
                        }

                        var paramObj = {
                            NCCode: value,
                            OpeID: opeId
                        }
                        var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSDP.ExecUDFProc("uspGetNCCodeNgRecordByCode", JSON.stringify(paramObj));
                        if (!!ajax.error) {
                            var msg = !!ajax.error.Message ? ajax.error.Message : ajax.error;
                            alert(msg)
                            $("#hdnReasonId").val("-1");
                            $("#txtReason").val("");
                            return false;
                        }
                        if (ajax.value.length == 0) {
                            $("#hdnReasonId").val("-1");
                            $("#txtReason").val("");
                            return false;
                        }
                        var data = JSON.parse(ajax.value);
                        $("#hdnReasonId").val(data[0].NCCodeId);
                        $("#txtReason").val(data[0].NCCode);
                    }
                }
            });
        })

        function openChoosePage(flags) {
            var condition = "";
            flag = flags;
            var orderId = $("#hdnProdOrderId").val() * 1;
            if (flag != 44 && orderId <= 0) {
                alert("请选择工单！");
                return false;
            }
            var opeId = $("#hdnOpeID").val() * 1;
            if (flag == 2020061703 || flag == 2020061704) {
                if (opeId <= 0) {
                    alert("请选择工序！");
                    return false;
                }
            }
            switch (flag) {
                case 2020061701:
                    titleName = "选择线别";
                    condition = "OrderId=" + orderId;
                    break;
                case 2020061702:
                    titleName = "选择工序";
                    condition = "OrderId=" + orderId;
                    break;
                case 2020061703:
                    titleName = "不良现象";
                    condition = "DataType='不良现象' and OpeId=" + opeId;
                    break;
                case 2020061704:
                    titleName = "不良原因";
                    condition = "DataType='不良原因' and OpeId=" + opeId;
                    break;
                default:
                case 44:
                    titleName = "选择工单";
                    break;
            }

            dialog({ title: "选择窗口", src: "../Framework/ChoosePage.aspx?PageId=" + flags + "&Multiple=false&PageCondition=" + condition + "&rnd=" + Math.random(), width: 600, height: 300 });
        }

        function getChooseValue(list) {
            if (flag == 2020061701) {
                //线别
                $("#txtRes").val(list[0][1]);
                $("#hdnResId").val(list[0][0]);
            }
            else if (flag == 2020061702) {
                //工序
                $("#txtOpe").val(list[0][1] + "(" + list[0][2] + ")");
                $("#hdnOpeID").val(list[0][0]);
            }
            else if (flag == 2020061703) {
                //不良现象
                $("#txtDefect").val(list[0][1] + "(" + list[0][2] + ")");
                $("#hdnDefectId").val(list[0][0]);

            }
            else if (flag == 2020061704) {
                //不良原因
                $("#txtReason").val(list[0][1]);
                $("#hdnReasonId").val(list[0][0]);
            }
            else if (flag == 44) {
                $("#txtProdOrder").val(list[0][1]);
                $("#hdnProdOrderId").val(list[0][0]);
            }
            flag = -1;
        }

        function Save() {
            debugger;
            var prodOrderId = $("#hdnProdOrderId").val();
            if (prodOrderId == "" || prodOrderId == "-1") {
                alert("请选择工单号！");
                return false;
            }

            var opeId = $("#hdnOpeID").val();
            if (opeId == "" || opeId == "-1") {
                alert("请选择工序！");
                return false;
            }

            var resId = $("#hdnResId").val();
            if (resId == "" || resId == "-1") {
                alert("请选择机台/线别！");
                return false;
            }

            var defect = $("#hdnDefectId").val();
            if (defect == "" || defect == "-1") {
                alert("请选择不良现象！");
                return false;
            }

            var reason = $("#hdnReasonId").val();
            if (reason == "" || reason == "-1") {
                alert("请选择不良原因！");
                return false;
            }

            var defQty = $("#txtDefQTY").val() * 1;
            if (defQty <= 0 || defQty == NaN) {
                alert("请输入不良数量！");
                return false;
            }

            var paramObj = {
                ProdOrderID: prodOrderId,
                OpeID: opeId,
                ResID: resId,
                Defect: defect,
                DefQTY: defQty,
                Reason: reason,
                Remark: $("#txtRemark").val(),
                userId: userId,
                LinePlanCode: LinePlanCode
            }
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSDP.ExecUDFProc("uspinsertNgRecord", JSON.stringify(paramObj));
            if (!!ajax.error) {
                var msg = !!ajax.error.Message ? ajax.error.Message : ajax.error;
                alert(msg)
                return false;
            }

            alert("不良登记成功！");
            
        }
    </script>
</asp:Content>
