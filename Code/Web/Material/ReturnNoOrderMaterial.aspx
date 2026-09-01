<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="ReturnNoOrderMaterial.aspx.cs" Inherits="SKT.LeanMES.Web.Material.ReturnNoOrderMaterial" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="infoTips" colspan="4">
                <%=Resources.Messages.WithAsteriskIsRequired %>
            </td>
        </tr>
        <tr>
            <td class="Label4">工单<em>*</em>
            </td>
            <td class="Field4">
                <input type="text" isrequired='1' value="" id="txtProdOrder" class="TextBox" style="width: 250px; height: 25px;" /><input id="button2" class="ButtonBox" type="button" onclick="selectProdOrder()"
                    value="..." title="选择工单" style="height: 27px; font-weight: bold; text-transform: uppercase;" />
                <asp:HiddenField ID="hfOrderId" runat="server" Value="-1" ClientIDMode="Static" />
            </td>
            <td class="Label4">仓库<em>*</em>
            </td>
            <td class="Field4">
                <asp:TextBox ID="txtWhInfo" runat="server" CssClass="TextBox" Enabled="false" Style="width: 250px; height: 25px;"
                    IsRequired='1' ClientIDMode="Static"> 
                </asp:TextBox><input type="button" id="btnselectWhInfo" class="ButtonBox" value="..."
                    title="Select" onclick="selectWhInfo();" style="height: 27px; font-weight: bold; text-transform: uppercase;" />
                <asp:HiddenField ID="hdnWhID" runat="server" Value="-1" ClientIDMode="Static" />
                <asp:HiddenField ID="hdnWhCode" runat="server" Value="" ClientIDMode="Static" />
            </td>
        </tr>

        <tr>
            <td class="Label2">产品编码
            </td>
            <td class="Field2">
                <label id="ItemCode"></label>
            </td>
            <td class="Label2">产品名称
            </td>
            <td class="Field2">
                <label id="ItemName"></label>
            </td>
        </tr>
        <tr>
            <td class="Label4">退料部门<em>*</em>
            </td>
            <td class="Field4">
                <input type="text" isrequired='1' readonly="readonly" value="" id="txtDepartment" class="TextBox" style="width: 250px; height: 25px;" /><input id="button2" class="ButtonBox" type="button" onclick="selectDepartmentValue()"
                    value="..." title="选择部门" style="height: 27px; font-weight: bold; text-transform: uppercase;" />
                <asp:HiddenField ID="hfDepartId" runat="server" Value="-1" ClientIDMode="Static" />
            </td>
            <td class="Label4">退料原因
            </td>
            <td class="Field4" colspan="3">
                <textarea style="width: 95%" class="TextArea" id="txtRemark"></textarea>
            </td>
        </tr>
        <tr>
            <td class="Label4">物料清点【GRN/包装箱】
            </td>
            <td class="Field4">
                <input type="text" id="txtGRN" class="TextBox" style="width: 250px; height: 25px;" />
            </td>
            <td class="Label4">数量
            </td>
            <td class="Field4">
                <input type="text" id="txtGRNQty" class="TextBox" isnumber='1' style="width: 250px; height: 25px;" />
            </td>
        </tr>
    </table>
    <div class="ListTableTitle">
        <div style="position: absolute; left: 10px; top: 5px; line-height: 18px;">
            <span>备料单明细</span>
            <input type="checkbox" value="-1" id="chkMatchWholeWord" onclick="CheckAll();" /><span>全部清点</span>    
        </div>
        <div style="position: absolute; right: 200px; top: 5px; width: 50px; height: 20px; line-height: 18px;">
            已清点
        </div>
        <div style="position: absolute; right: 100px; top: 5px; width: 100px; height: 15px; line-height: 18px; background-color: gray;">
        </div>
    </div>
    <table id="tblExpand" cellspacing="0" cellpadding="4" style="border-width: 0px; width: 100%; border-collapse: collapse; margin-top: 5px; overflow:scroll"
        class="ListTable">
        <tr class="ListTableHeader">
            <th>行号
            </th>
            <th>GRN</th>
            <th>物料编码
            </th>
            <th>物料名称
            </th>
            <th>领料单名
            </th>
            <th>退料数量
            </th>
            <th>清点数量
            </th>
        </tr>
    </table>


    <div class="clear5">
    </div>
    <div style="text-align: center;" class="Tips" id="msg">
    </div>
    <script type="text/javascript" src="../Content/js/jquery-3.1.0.min.js"></script>
    <script type="text/javascript">
        var prodOrder = "";
        $(function () {
            setTimeout(function () { $("#txtProdOrder").focus(); }, 100);
        });

        //工单绑定回车事件
        $("#txtProdOrder").on("keydown", function (e) {
            var curKey = 0, e = e || window.event;
            curKey = e.keyCode || e.which || e.charCode;
            if (curKey == 13) {
                prodOrder = $.trim($("#txtProdOrder").val());
                showApplyOrderDetail(1);
                return false;
            }
        });
        //GRN，数量回车事件
        var GRN = "";
        var grnQty = 0;
        $("#txtGRN").on("keydown", function (e) {
            var curKey = 0, e = e || window.event;
            curKey = e.keyCode || e.which || e.charCode;
            if (curKey == 13) {
                GRN = $.trim($("#txtGRN").val());
                if (GRN != "") {
                    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxWarehouseCheck.GetMaInfo(GRN,2);
                    if (ajax.value == null) {
                        alert("GRN不存在或状态非【在产线】!");
                        $("txtGRN").val("");
                        $("txtGRN").focus();
                        return false;
                    }
                    $("#txtGRNQty").val(ajax.value.StockQty);
                    setTimeout(function () {
                        $("#txtGRNQty").focus();
                        $("#txtGRNQty").select();
                    }, 100);
                } else {
                    alert("请输入GRN!");
                    $("#txtGRN").focus();
                    return false;
                }
            }
        });

        //GRN数量回车
        $("#txtGRNQty").on("keydown", function (e) {
            var curKey = 0, e = e || window.event;
            curKey = e.keyCode || e.which || e.charCode;
            if (curKey == 13) {
                grnQty = $.trim($("#txtGRNQty").val());
                if (grnQty == "") {
                    alert("请输入GRN清点数量!");
                    return false;
                } else {
                    if (isPositiveNum(this, 1)) {
                        var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.CheckReturnApplyGRN(prodOrder, GRN, grnQty);
                        if (ajax.error != null) {
                            alert(ajax.error.Message);
                            clearGRNInfo();
                            return false;
                        }
                        else {
                            //如果是GRN      GRN
                            //如果是包装箱    包装箱  转 GRN
                            var result = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.GetGRNIsBoxIsGRN(GRN);
                            if (result.error != null) {
                                alert(result.error.Message);
                                return false;
                            }
                            if (null != result) {
                                var datalist = result.value;
                                if(datalist.length<=0){
                                    alert("查无GRN");
                                    return false;
                                }
                                else if(datalist.length==1){
                                    //变颜色
                                    $('#tblExpand tr[grn="' + GRN + '"]').css("backgroundColor", "gray");
                                    $("input[id='comfirmQty" + GRN + "']").val(grnQty);
                                    $("#tblExpand").append($('#tblExpand tr[grn="' + GRN + '"]'));
                                    //重新排序
                                    $("#tblExpand tr").each(function (i) {
                                        $(this).find("td").eq(0).text(i)
                                    });
                                }
                                else{
                                    for (var i = 0; i < datalist.length; i++) {
                                        //变颜色
                                        $('#tblExpand tr[grn="' + datalist[i].SerialNumber + '"]').css("backgroundColor", "gray");
                                        $("input[id='comfirmQty" + datalist[i].SerialNumber + "']").val(datalist[i].BalanceQty);
                                        $("#tblExpand").append($('#tblExpand tr[grn="' + datalist[i].SerialNumber + '"]'));
                                    }
                                    //重新排序
                                    $("#tblExpand tr").each(function (i) {
                                        $(this).find("td").eq(0).text(i)
                                    });
                                }
                            }
                            clearGRNInfo();
                        }
                    }
                }
            }
        });



        function clearGRNInfo() {
            $("#txtGRN").val("");
            $("#txtGRNQty").val("");
            setTimeout(function () { $("#txtGRN").focus(); }, 100)

        }
        //执行GRN清点
        function SaveScanGRN() {
            showApplyOrderDetail(2);
        }

        function CheckAll() {
            if (prodOrder == "") {
                alert("请选择要退料的工单!");
                return false;
            }
            else {
                if ($('#chkMatchWholeWord').is(":checked")) {
                    showApplyOrderDetail(2);
                }
                else {
                    showApplyOrderDetail(1);
                }
            }
        }

        //选中生产工单
        function selectProdOrder() {
            dialog({
                title: "<%=Resources.Common.ChooseWindow %>",
                src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=81&CallBackFunc=getChooseValueOrder&Multiple=false&rnd=" + Math.random(), width: 700, height: 400
            });
        }
        function selectWhInfo() {
            flag = 1
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=14&Multiple=false&rnd=" + Math.random(), width: 500, height: 300 });
        }

        function getChooseValue(list) {
            if (list[0][0] != "-1") {
                $("#txtWhInfo").val(list[0][1] + "|" + list[0][2]);
            }
            else {
                $("#txtWhInfo").val("");
            }
            $("#hdnWhID").val(list[0][0]);
            $("#hdnWhCode").val(list[0][1]);
        }
        //工单返回的值
        function getChooseValueOrder(list) {
            prodOrder = list[0][1];
            $("#txtProdOrder").val(list[0][1]);
            $("#hfOrderId").val(list[0][0]);
            showApplyOrderDetail(1);

        }
        //退料部门选择和获取
        function selectDepartmentValue() {
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=13&CallBackFunc=getChooseValueDepartment&Multiple=false&rnd=" + Math.random(), width: 500, height: 300 });
        }
        function getChooseValueDepartment(list) {
            $("#txtDepartment").val(list[0][2]);
            $("#<%=this.hfDepartId.ClientID %>").val(list[0][0]);
        }



        //通过工单查询信息
        //searchType：查询类型：1：正常查询  清点数量为空  2：全部选中，清点数量默认为退料数量
        function showApplyOrderDetail(searchType) {
            //每次加载删除除了第一行的数据

            $("#tblExpand tr:gt(0)").remove();
            var grnList = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.GetAllReturnMaterial(prodOrder);
            if (grnList.error != null) {
                alert(grnList.error.Message);
                clearInfo();
                return false;
            } else {
                var addHtmlStr = "";
                $("#ItemCode").html(grnList.value[0].OrderItemCode);
                $("#ItemName").html(grnList.value[0].OrderItemName);
                for (var i = 0; i < grnList.value.length; i++) {
                    var entity = grnList.value[i];
                    //push数据：
                    if (i % 2 == 0) {
                        addHtmlStr += "<tr  grn='" + entity.SerialNumber + "' class='ListTableEvenRow' >";
                    }
                    else {
                        addHtmlStr += "<tr grn ='" + entity.SerialNumber + "' class='ListTableOddRow'  >";
                    }

                    addHtmlStr += "<td>" + (i + 1) + "</td>"
                              + "<td>" + entity.SerialNumber + "</td>"
                              + "<td>" + entity.ItemCode + "</td>"
                              + "<td>" + entity.ItemName + "</td>"
                              + "<td>" + entity.ApplyNo + "</td>"
                              + "<td>" + entity.BalanceQty + "</td>"
                    if (searchType == 1) {
                        addHtmlStr += "<td><input  type ='text' id='comfirmQty" + entity.SerialNumber + "' onchange = isPositiveNum(this," + i + ") value ='' /></td>"
                    }
                    else {
                        addHtmlStr += "<td><input  type ='text' id='comfirmQty" + entity.SerialNumber + "' onchange = isPositiveNum(this," + i + ") value ='" + entity.BalanceQty + "' /></td>"
                    }

                    + "</tr>";
                }
                $("#tblExpand").append(addHtmlStr);
                if (searchType == 2) {
                    $("#tblExpand tbody tr").each(function () {
                        $(this).css("backgroundColor", "gray");
                    });
                }
            }
        }

        function isPositiveNum(obj, i) {//是否为正整数
            var s = $(obj).val();
            var re = /^[0-9]*[0-9][0-9]*$/;
            if (!re.test(s)) {
                alert("请输入正整数！");
                $(obj).val("");
                setTimeout(function () { $(obj).select().focus(); }, 100);
                return false;
            } else {
                return true;
            }
        }
        //保存清点数据
        function Save() {
            var GRNDetail = [];
            var deptId = $("#<%=this.hfDepartId.ClientID %>").val();
            var whCodeId = $("#hdnWhID").val();
            var Reson = $("#txtRemark").val();
            //遍历表中，清点的数据
            $("#tblExpand tr:gt(0)").each(function () {
                var grn = $(this).find("td").eq(1).text(); //GRN
                var grnQty = $("input[id='comfirmQty" + grn + "']").val();
                if (grnQty != "") {
                    GRNDetail.push({ "GRN": grn, "ReturnQty": grnQty });
                }
            });

            var entity = {};
            entity.ProdOrderNo = prodOrder;
            entity.DeptId = deptId;
            entity.WhId = whCodeId;
            entity.Remark = Reson;
            entity.UserName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
            entity.TbDtl = JSON.stringify(GRNDetail);
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.SaveReturnApplyGRN(JSON.stringify(entity));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert('<%=Resources.Messages.SaveSuccess %>');
            clearInfo();
            $("#tblExpand tr:gt(0)").remove();
            $("#txtWhInfo").val("");
            $("#txtDepartment").val("");
            $("#txtRemark").val("");
        }

        //清空数据
        function clearInfo() {
            prodOrder = "";
            $("#txtProdOrder").val("");
            $("#ItemCode").html("");
            $("#ItemName").html("");
            setTimeout(function () { $("#txtProdOrder").focus(); }, 100);

        }
    </script>
</asp:Content>

