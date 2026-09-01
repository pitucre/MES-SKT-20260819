<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/EditMaster.master" CodeBehind="ReturnToSupplierEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Material.ReturnToSupplierEdit" %>

<%@ Import Namespace="Resources" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="infoTips" colspan="4">
                <%=Resources.Messages.WithAsteriskIsRequired %>
            </td>
        </tr>
        <tr>
            <td class="Label2">采购单<em>*</em>
            </td>
            <td class="Field2">
                <input type="text" readonly="readonly" disabled="disabled" value="" id="txtPoCode" class="TextBox" /><input class="ButtonBox" type="button" onclick="openChoosePage(103)"
                    value="..." title="选择采购单" />
                <asp:HiddenField ID="hidPoId" runat="server" Value="-1" ClientIDMode="Static" />
            </td>
            <td class="Label2">物料编码<em>*</em>
            </td>
            <td class="Field2">
                <input type="text" readonly="readonly" disabled="disabled" value="" id="txtItemCode" class="TextBox" /><input class="ButtonBox" type="button" onclick="openChoosePage(811)"
                    value="..." title="选择物料" />
                <asp:HiddenField ID="hidItemId" runat="server" Value="-1" ClientIDMode="Static" />
                <asp:HiddenField ID="hidItemName" runat="server" Value="" ClientIDMode="Static" />
                <asp:HiddenField ID="hidLineId" runat="server" Value="-1" ClientIDMode="Static" />
                <asp:HiddenField ID="hidItemQty" runat="server" Value="-1" ClientIDMode="Static" />
            </td>
        </tr>
        <tr>
            <td class="Label2">物料名称
            </td>
            <td class="Field2">
                <label id="lblItemName"></label>
            </td>
            <td class="Label2">数量
            </td>
            <td class="Field2">
                <label id="lblItemQty"></label>
            </td>
        </tr>
        <tr>
            <%--<td class="Label2">退料部门<em>*</em>
            </td>
            <td class="Field2">
                <input type="text" isrequired='1' readonly="readonly" disabled="disabled" value="" id="txtDepartment" class="TextBox" /><input class="ButtonBox" type="button" onclick="openChoosePage(13)"
                    value="..." title="选择部门" />
                <asp:HiddenField ID="hfDepartId" runat="server" Value="-1" ClientIDMode="Static" />
            </td>--%>
            <td class="Label2">退料数量<em>*</em>
            </td>
            <td class="Field2">
                <input type="text" id="txtQty" class="TextBox" />
            </td>
            <td class="Label2">退料仓<em>*</em>
            </td>
            <td class="Field2">
                <input type="text" isrequired='1' readonly="readonly" disabled="disabled" value="" id="txtWarehouse" runat="server" clientidmode="Static" class="TextBox" /><input class="ButtonBox" type="button" onclick="openChoosePage(14)"
                    value="..." title="选择退料仓" />
                <asp:HiddenField ID="hidWarehouseId" runat="server" Value="-1" ClientIDMode="Static" />
                <asp:HiddenField ID="hidWarehouseCode" runat="server" Value="" ClientIDMode="Static" />
            </td>
        </tr>
    </table>
    <div class="ListTableTitle">
        <div style="left: 10px; top: 0px; line-height: 18px;">
            退料单明细
        </div>
    </div>
    <%--EditeContentTable--%>
    <table id="tblExpand" style="border-collapse: collapse; width: 100%;" class="ListTable">
        <thead>
            <tr class="ListTableHeader">
                <th style="width: 5%;">序号
                </th>
                <th style="width: 20%;">采购单号
                </th>
                <th style="width: 20%;">物料编码
                </th>
                <th style="width: 30%;">物料名称
                </th>
                <th style="width: 10%;">行号
                </th>
                <th style="width: 10%;">退料数量
                </th>
                <th onclick="addDetail();" id='btnAdd' style="color: #0066CC; cursor: pointer; font-weight: bold">添加
                </th>
            </tr>
        </thead>
        <tbody>
            <tr id="trNewInfo" class="ListTableOddRow">
                <td colspan="7" style="text-align: center;"><span>暂无数据</span>
                </td>
            </tr>
        </tbody>
    </table>
    <asp:HiddenField ID="hidModifyBy" runat="server" Value="" ClientIDMode="Static" />
    <asp:HiddenField ID="VenCode" runat="server" Value="" ClientIDMode="Static"/>
    <script type="text/javascript">
        var returnNo = "<%=Request.QueryString["Id"]%>";//退料单号
        var flag = -1;
        $(function () {
            $("#txtQty").keydown(function (event) {
                var e = event || window.event;
                if (e && e.keyCode == 13) {
                    $(this).blur();
                    addDetail();
                }
            });

            var entity = {};
            entity.ReturnOrder = returnNo;
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.GetReturnToVendorDetailList(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var list = ajax.value;
            var trs = "";
            if (list.length > 0) {
                $("#tblExpand tbody tr#trNewInfo").remove();
                for (var i = 0; i < list.length; i++) {
                    trs += "<tr class=" + (i % 2 == 0 ? "ListTableOddRow" : "ListTableEvenRow") + ">" +
                            "<td aglin=\"center\" class=\"serial-number\">" + (i + 1) + "</td>" +
                            "<td class=\"po-code\">" + list[i].SourceBillNo + "</td>" +
                            "<td class=\"item-code\">" + list[i].ItemCode + "</td>" +
                            "<td>" + list[i].ItemName + "</td>" +
                            "<td aglin=\"center\" class=\"line-id\">" + list[i].SourceEntryID + "</td>" +
                        "<td aglin=\"center\" class=\"return-qty\">" + list[i].Quantity + "</td>" +
                        "<td aglin=\"center\"><span style=\"cursor: pointer; color: #0000ff;\" onclick=\"deleteItem(this)\">" + mesLang("删除") + "</span></td>" +
                            "</tr>";
                }
                $("#tblExpand tbody").append(trs);
            }
        });

        //选择
        function openChoosePage(pageId) {
            var searchCondition = "";
            flag = pageId;
            if (pageId == 811) {
                var poCode = $("#txtPoCode").val();
                if (poCode == "") {
                    alert("请先选择采购单");
                    return;
                }
                //searchCondition = " POorder = '" + poCode + "'";
                searchCondition = " POCode = '" + poCode + "'";
            }
            dialog({
                title: "<%=Resources.Common.ChooseWindow %>",
                src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=" + pageId + "&Multiple=false&PageCondition=" + (searchCondition) + "&rnd=" + Math.random(), width: 700, height: 400
            });
        }

        //返回值
        function getChooseValue(list) {
            console.log(list);
            if (flag == 103) {
                //if ($("#VenCode").val() != "" && $("#VenCode").val() != list[0][2])
                //{
                //    alert("请选择相同供应商的采购订单！");
                //    return;
                //}
                $("#hidPoId").val(list[0][0]);
                $("#txtPoCode").val(list[0][1]);
                $("#VenCode").val(list[0][2]);//供应商编码
                if (!list[0][1]) {
                    $("#hidItemId").val("-1");
                    $("#txtItemCode").val("");
                    $("#hidItemName").val("");
                    $("#hidLineId").val("-1");
                    $("#hidItemQty").val("-1");
                    $("#lblItemName").html("");
                    $("#lblItemQty").html("");
                }
            } else if (flag == 811) {
                $("#hidItemId").val(list[0][0]);
                $("#txtItemCode").val(list[0][1]);
                $("#hidItemName").val(list[0][2]);
                $("#hidLineId").val(list[0][3]);

                $("#hidItemQty").val(parseFloat( list[0][4]));
                $("#lblItemName").html(list[0][2]);
                $("#lblItemQty").html(parseFloat(list[0][4]));
            } else if (flag == 13) {
                $("#txtDepartment").val(list[0][2]);
                $("#hfDepartId").val(list[0][0]);
            } else if (flag == 14) {
                if (list[0][0] != "-1") {
                    $("#txtWarehouse").val(list[0][1] + "|" + list[0][2]);
                }
                else {
                    $("#txtWarehouse").val("");
                }
                $("#hidWarehouseId").val(list[0][0]);
                $("#hidWarehouseCode").val(list[0][1]);
            }
        }

        //是否为正整数
        function isPositiveNum(str) {
            var reg = /^([0-9]{1,}[.]?[0-9]*)$/;
            if (reg.test(str)) {
                return true;
            } else {
                return false;
            }
        }

        //添加明细
        function addDetail() {
            var poCode = $("#txtPoCode").val();
            var itemCode = $("#txtItemCode").val();
            var itemName = $("#hidItemName").val();
            var lineId = $("#hidLineId").val();
            var itemQty = parseInt($("#hidItemQty").val());
            var department = $("#txtDepartment").val();
            var warehouse = $("#txtWarehouse").val();
            var qty = parseFloat($.trim($("#txtQty").val()));

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.ValidReturnMaterialUnit(poCode, itemCode, parseInt(lineId), itemQty, qty);

            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            if (poCode == "") {
                alert('请选择采购单');
                return;
            }
            if (itemCode == "") {
                alert('请选择物料');
                return;
            }
            if (qty == "") {
                alert('请输入退料数量');
                $("#txtQty").val("").focus();
                return;
            }
            if (!isPositiveNum(qty)) {
                alert("退料数量必须为正数");
                $("#txtQty").val("").focus();
                return;
            }
            if (qty > itemQty) {
                alert("退料数量不能大于物料数量");
                $("#txtQty").val("").focus();
                return;
            }
            var emptyTr = $("#tblExpand tbody tr#trNewInfo");
            if (emptyTr.length > 0) {
                emptyTr.remove();
            }
            //判断是否存在
            var arrReturn = [];
            var exists = false;
            $("#tblExpand tbody tr").each(function () {
                arrReturn.push({ "PoCode": $(this).find(".po-code").text(), "ItemCode": $(this).find(".item-code").text(), "LineId": $(this).find(".line-id").text() });
            });

            var entity = { "PoCode": poCode, "ItemCode": itemCode, "LineId": lineId };
            if (existsItem(arrReturn, entity)) {
                alert("该物料已存在于列表中！");
                return;
            }

            var trLength = $("#tblExpand tbody tr").length;
            var trCss = trLength % 2 == 0 ? "ListTableOddRow" : "ListTableEvenRow";
            var tr = "<tr class=" + trCss + ">" +
                    "<td aglin=\"center\" class=\"serial-number\">" + ($("#tblExpand tbody tr").length + 1) + "</td>" +
                    "<td class=\"po-code\">" + poCode + "</td>" +
                    "<td class=\"item-code\">" + itemCode + "</td>" +
                    "<td>" + itemName + "</td>" +
                    "<td aglin=\"center\" class=\"line-id\">" + lineId + "</td>" +
                    "<td aglin=\"center\" class=\"return-qty\">" + qty + "</td>" +
                    "<td aglin=\"center\"><span style=\"cursor: pointer; color: #0000ff;\" onclick=\"deleteItem(this)\">删除</span></td>" +
                    "</tr>";
            $("#tblExpand tbody").append(tr);
            empty();
        }

        //删除行数据
        function deleteItem(obj) {
            $(obj).parent().parent().remove();
            //列表序号重排
            $("#tblExpand tbody tr td.serial-number").each(function (i) {
                $(this).html((i + 1)).parent().attr("class", i % 2 == 0 ? "ListTableOddRow" : "ListTableEvenRow");
            });
        }

        //判断是否存在
        function existsItem(arr, entity) {
            for (var i = 0; i < arr.length; i++) {
                if (arr[i].PoCode == entity.PoCode && arr[i].ItemCode == entity.ItemCode && arr[i].LineId == entity.LineId) {
                    return true;
                }
            }
            return false;
        }

        //保存
        function Save() {
            var trLength = $("#tblExpand tbody tr").not("#trNewInfo").length;
            if (trLength <= 0) {
                alert("请添加退料明细信息");
                return;
            }
            var warehouseCode = $("#hidWarehouseCode").val();
            if (warehouseCode == "") {
                alert("请选择退料仓");
                return;
            }
            var modidyBy = $("#hidModifyBy").val();
            var arrDetail = [];
            $("#tblExpand tbody tr").each(function () {
                arrDetail.push({ "POCode": $(this).find(".po-code").text(), "ItemCode": $(this).find(".item-code").text(), "LineId": $(this).find(".line-id").text(), "ReturnQty": $(this).find(".return-qty").text() });
            });


            var entity = {};
            entity.ReturnOrder = returnNo;
            entity.VenCode = $("#VenCode").val();
            //entity.Department = "";
            entity.WarehouseCode = warehouseCode;
            entity.ReturnDetail = JSON.stringify(arrDetail);
            entity.ModifyBy = modidyBy;
            //保存
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.WarehouseReturnSupplierEdit(JSON.stringify(entity));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert('<%=Resources.Messages.SaveInSuccess%>');
            parent.window.Refresh()
        }

        //重置
        function empty() {
            $("#hidPoId").val("-1");
            $("#txtPoCode").val("");
            $("#hidItemId").val("-1");
            $("#txtItemCode").val("");
            $("#hidItemName").val("");
            $("#hidLineId").val("-1");
            $("#hidItemQty").val("-1");
            $("#lblItemName").html("");
            $("#lblItemQty").html("");
            $("#txtQty").val("");
        }

    </script>



    <script type="text/javascript">
        <%--var arrGrn = []; //扫描的GRN数组
        var curUser = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';

        $("form").submit(function (e) {
            if (e && e.preventDefault) {
                e.preventDefault();
            } else {
                window.event.returnValue = false;
            }
            return false;
        });

        $(function () {
            $("#txtGRN").focus();
            /*扫描物料条码*/
            $("#txtGRN").keydown(function () {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey === 13) {
                    //验证是否重复扫描
                    if (checkGrnExist($.trim($("#txtGRN").val())) === true) {
                        return false;
                    } else {
                        GetQuantityByGRN($.trim($("#txtGRN").val()));
                    }

                }
            });

            //$("#btnReturn").bind("click", function () {
            //    Save();
            //});
        });

        //保存
        function Save() {
            if (!confirm('是否确认退料?')) {
                return false;
            }
            var List = [];
            var deptId = $("#<%=this.hfDepartId.ClientID %>").val();//退料部门
            var proOrder = $("#txtProdOrder").val();//生产工单

            $("#tblExpand tr:not(:first)").each(function (index, element) {
                var model = {};
                model.ItemId = $(this).children("td:eq(1)").find("[name='hdItemId']").val();
                model.ItemCode = $(this).children("td:eq(1)").find("[name='txtItem']").val();
                model.ItemName = $(this).children("td:eq(2)").find('input').val();
                model.ReturnQty = $(this).children("td:eq(3)").find('input').val();
                //model.Remark = $(this).children("td:eq(4)").find('input').val();

                List.push(model);
            });
            if (List.length == 0 || typeof List[0].ItemId == 'undefined') {
                alert("请添加要申请的物料!");
                return false;
            }

            //新增
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.NewProdReturnOrder('-1', JSON.stringify(List), deptId, curUser, proOrder);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert('<%=Resources.Messages.SaveInSuccess%>');
            //parent.window.Refresh();
            location.reload();
        }



        //选中生产工单
        function selectProdOrder() {
            dialog({
                title: "<%=Resources.Common.ChooseWindow %>",
                src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=81&CallBackFunc=getChooseValueOrder&Multiple=false&rnd=" + Math.random(), width: 700, height: 400
            });
        }
        //工单返回的值
        function getChooseValueOrder(list) {
            $("#txtProdOrder").val(list[0][1]);
            $("#hfOrderId").val(list[0][0]);
        }
        //选择产品编码
        function selectItemCode(obj) {
            var $obj = $(obj);
            rowObj = obj.parentElement.parentElement;
            rowIndex = rowObj.rowIndex;
            //dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=1&CallBackFunc=getChooseValueMaterial&Multiple=false&rnd=" + Math.random(), width: 600, height: 300 });
            var searchCondition = " MoCode  ='" + $("#txtProdOrder").val() + "' ";
            dialog({
                title: "工单用料信息",
                src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=205&PageCondition="
                + escape(searchCondition) + "&Multiple=true&CallBackFunc=getChooseValueMaterial&rnd=" + Math.random(), width: 800, height: 400
            });
        }
        //获取选中产品的返回值
        function getChooseValueMaterial(list) {
            var mid = list[0][0];
            var b = true;
            var o = $("input[name='hdItemId']");
            for (var i = 0; i < o.length; i++) {
                if (mid == $(o[i]).val() && mid != '-1') {
                    b = false;
                    alert("该物料已经存在！");
                }
            }
            if (b == true) {
                rowObj.cells[1].children[0].value = list[0][0]; //产品ID
                rowObj.cells[1].children[1].value = list[0][1]; //产品编码

                rowObj.cells[2].children[0].value = list[0][2]; //产品名称
            }
        }


        //新增
        var tab = document.getElementById("tblExpand");
        var i = 0;
        function addDetail() {
            var poCode = $("#txtPoCode").val();
            var itemCode = $("#txtItemCode").val();
            var department = $("#txtDepartment").val();
            var warehouse = $("#txtWarehouse").val();
            var qty = $.trim($("#txtQty").val());

            if (poCode == "") {
                alert('请选择采购单');
                return;
            }
            if (itemCode == "") {
                alert('请选择物料');
                return;
            }
            if (qty == "") {
                alert('请输入退料数量');
                return;
            }


            if (!($("#txtProdOrder").val() !== '' && $("#txtDepartment").val() !== '')) {
                alert('请先选择工单和退料部门');
                return false;
            }
            if (entity == null) {
                entity = {};
                entity.ItemId = -1;
                entity.ItemCode = "";
                entity.ItemName = "";
                entity.ReturnQty = "";
                entity.Remark = "";
            }

            i += 1;
            $("#trNewInfo").remove();
            var row, cell;
            rowNewIdx = tab.rows.length;
            row = tab.insertRow(rowNewIdx);
            row.className = "ListTableOddRow";
            //行号
            cell = row.insertCell(0);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = i.toString();

            //产品编码
            cell = row.insertCell(1);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = "<input type='hidden' name='hdItemId' value='" + entity.ItemId + "' /><input type='text' IsRequired='1' name='txtItem' class='TextBox' value='" + entity.ItemCode + "' style='width:80%'  disabled='disabled' onblur='getItemInfo(this);'>"
            + "<input type='button' id='btnSelectItems' onclick='selectItemCode(this);' class='ButtonBox' value='...' />";

            //产品名称
            cell = row.insertCell(2);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = "<input type='text' style='width:96%' CssClass='TextBox' readonly='readonly' IsRequired='1' name='txtItemName' value='" + entity.ItemName + "' disabled='disabled'/>";

            //数量
            cell = row.insertCell(3);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = "<input type='text' MaxLength='9' IsNumber='1' IsRequired='1' style='width:90%;' value='" + entity.ReturnQty + "' class='txtQty' onblur='isPositiveNum(this) ;'/>";

            ////备注
            //cell = row.insertCell(4);
            //cell.align = "center";
            //cell.className = "Field";
            //cell.innerHTML = "<input type='text' style='width:90%;' MaxLength='20' value='" + entity.Remark + "' class='txtRemarkS' />";

            //操作
            cel = row.insertCell(4);
            cel.align = "center";
            cel.className = "Field";
            cel.innerHTML = "<span style=\"CURSOR: pointer; COLOR: #0000ff;\" onclick=\"deleteItem(this,'" + entity.ItemId + "')\"><%= Resources.Buttons.COM_Delete %></span>";

        }

        //删除行数据
        function deleteItem(obj, ItemId) {
            i = i - 1;
            tab.deleteRow(obj.parentElement.parentElement.rowIndex);
        }

        function getItemInfo(obj) {
            var $obj = $(obj);
            rowObj = obj.parentElement.parentElement;
            rowIndex = rowObj.rowIndex;

            if ($.trim($obj.val()) == "") return false;

            var txtItemCode = $obj.val();
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.GetItemInfo(txtItemCode, 2);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                $obj.val("");
                $obj.focus();
                rowObj.cells[1].children[0].value = ""; //产品ID
                rowObj.cells[1].children[1].value = ""; //产品编码
                return false;
            }

            var entity = ajax.value;
            if (entity != null) {
                var mid = entity.ItemID;
                var b = true;
                var o = $("input[name='hdItemId']");
                for (var i = 0; i < o.length; i++) {
                    if (mid == $(o[i]).val() && mid != '-1') {
                        b = false;
                        alert("该物料已经存在！");
                        $obj.val("");
                        $obj.focus();
                        rowObj.cells[1].children[0].value = ""; //产品编码
                        rowObj.cells[1].children[1].value = ""; //产品编码
                        rowObj.cells[2].children[0].value = ""; //产品名称
                    }
                }
                if (b == true) {
                    rowObj.cells[1].children[0].value = entity.ItemID; //产品编码
                    rowObj.cells[1].children[1].value = entity.ItemCode; //产品编码
                    rowObj.cells[2].children[0].value = entity.ItemName; //产品名称
                }
            }
        }--%>


    </script>
</asp:Content>
