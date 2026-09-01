<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TransferOutEdit.aspx.cs"
    MasterPageFile="~/Masters/EditMaster.master" Inherits="SKT.LeanMES.Web.Material.TransferOutEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <table id="FTable" class="EditeContentTable" width="100%">
        <tr>
            <td class="infoTips" colspan="4">
                <%=Resources.Messages.WithAsteriskIsRequired %>
            </td>
        </tr>
        <tr class="clear5">
        </tr>
        <tr>
            <td class="Label2">
                调入货位<em>*</em>
            </td>
            <td class="Field2">
                <input type="text" id="txtBWhPos" />
            </td>
            <td class="Label2">
                调入仓库
            </td>
            <td class="Field2">
                <span id="lblInWarehouse"></span>
                <input type="hidden" id="hdInWarehouseId" />
                <input type="hidden" id="hdInWhCode" />
            </td>
        </tr>
        <tr>
            <td class="Label2">请扫物料条码<em>*</em>
            </td>
            <td class="Field2">
                <input type="text" id="txtGRN"  style="width: 250px;"/>
                <input type="hidden" id="txtPartId" />
            </td>
            <td class="Label2">当前仓库
            </td>
            <td class="Field2">
                <span id="lblOutWarehouse"></span>
                <input type="hidden" id="OutWarehouseId" />
                <input type="hidden" id="hidOutCode" />
            </td>
        </tr>

    </table>
    <table id="tblExpand" cellspacing="0" cellpadding="4" style="border-width: 0px; width: 100%; border-collapse: collapse; margin-top: 5px;"
        class="EditeContentTable">
        <tr class="ListTableHeader">
            <th scope="col" style="width: 15%;">物料条码</th>
            <th scope="col" style="width: 15%;">物料号</th>
            <th scope="col" style="width: 15%;">物料名称</th>
            <th scope="col" style="width: 10%;">调出仓库</th>
            <th scope="col" style="width: 15%;">调出货位</th>
            <th scope="col" style="width: 10%;">调入仓库</th>
            <th scope="col" style="width: 15%;">调入货位</th>
            <th scope="col" style="width: 5%;">调拨数量</th>
            <th scope="col" style="color: #0066CC; cursor: pointer; width: 60px;">操作</th>

        </tr>
        <tr id="trNewInfo" class="ListTableOddRow">
            <td colspan="12" style="text-align: center;"><span>暂无数据</span>
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        var storeQty = 0;  //库存数量
        var rowIndex = -1;
        var rowObj = null;
        var IsTrue = false;
        var strWarehouseInfo = "";
        var isFlag = true;
        var TransId = '<%=Request.QueryString["ID"]%>'; //编辑时传过来的备料ID
        var flag = true;
        var GrnStrNew = ""; //grnstr
        var GrnStrPackArr = [];//记录扫描包装箱的STR
        var storage = window.localStorage;
        //物料列表
        var List = [];

        $(function () {
            $("#txtGRN").keydown(function () {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    var GRN =$("#txtGRN").val().trim();
                    //验证条码
                    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.GetItemIdByMaterialGRN(GRN);
                    if (ajax.error != null) {
                        alert(ajax.error.Message);
                        closeWaiting();
                        return false;
                    }
                    //by liwen 20200727
                    if (GrnStrNew.indexOf(GRN) >= 0) {
                        alert("【" + GRN + "】该条码已经扫描完成，不能重复扫描!");
                        return false;
                    }
                    //显示调拨信息列表
                    showTransfOutInfo(GRN);
                   
                }
            });

            $("#txtBWhPos").keydown(function () {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    //验证库位
                    if (!checkPosCode()) {
                        $("#txtBWhPos").val("");
                        $("#txtBWhPos").focus();
                        return false;
                    }
                }
            });
        });
        //显示调拨信息列表

        var rowCount = 0;
        function showTransfOutInfo(SN) {
            var txtBWhPos = $.trim($("#txtBWhPos").val());
            //验证库位
            if (!checkPosCode()) return false;

            var txtInWarehouse = $("#lblInWarehouse").text();

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxTransferOut.ShowTransfOutInfo(SN);
            if (ajax.error != null) {
                $("#txtGRN").focus();
                return false;
            }

            var entity = {};
            entity = ajax.value;
            if (entity != null && entity.length > 0) {
                var entityAry = ajax.value;
                var entity = ajax.value[0];

                //校验库位的产品唯一
                if (!verifyProductOnly(txtBWhPos, entity.ItemCode)) return false;

                $("#lblOutWarehouse").text(entity.WareHouseName);

                ///add by zhi.li 20180608 判断重复
                var tableData = document.getElementById("tblExpand");
                var rl = tableData.rows.length;

                for (i = 0; i < rl; i++) {
                    if (i > 0) {
                        if (tableData.rows[i].cells.length > 1) {
                            var wHouseName = tableData.rows[i].cells[3].innerHTML;
                            var serialNumber = tableData.rows[i].cells[0].innerHTML;
                            if (serialNumber == SN && serialNumber != "") {
                                alert("【" + SN + "】物料条码已经扫描，不能重复扫描！");
                                return false;
                            }

                        }
                    }
                }

                if (entity.WareHouseName == txtInWarehouse) {
                    var errMessage = "该物料在【" + entity.WareHouseName + "】,不能调入【" + txtInWarehouse + "】";
                    alert(errMessage);
                    return false;
                }
                //by liwen
                var keyValue = "";
                for (var i = 0; i < entityAry.length; i++) {
                    GrnStrNew += entityAry[i].SerialNumber + ',';
                    keyValue += entityAry[i].SerialNumber + ',';
                    if (entityAry.length > 1 && i == 0) {
                        continue;//如果是包装箱记录
                    }
                    rowCount++;
                    addDetail(entityAry[i], i);
                }
                if (entityAry.length > 1) {
                    GrnStrPackArr.push(keyValue);//将包装箱条码和物料条码存入数组中
                }
            }
            //清空GRN输入
            $("#txtGRN").val("");
            $("#txtGRN").focus();
        }

        //删除行操作  add by zhi.li 20180608
        function deleteItem(itemCode, SerialNumber, t) {
            //by liwen 20200807
            var PackSerialNumber = "";
            var indexPack = 0;
            for (var i = 0; i < GrnStrPackArr.length; i++) {
                if (GrnStrPackArr[i].indexOf(SerialNumber) > -1) { 
                    PackSerialNumber = GrnStrPackArr[i];
                    indexPack = i;
                    break;
                }
            }
            if (PackSerialNumber) {
                GrnStrNew = GrnStrNew.replace(PackSerialNumber, '');
                $(".ListTableOddRow").each(function (index,ele) {
                    var str = $(this).children("td").eq(0).html();
                    if (PackSerialNumber.indexOf(str)>-1) {
                        $(this).remove();
                    }
                });
            } else {
                var $row = $(t).parent().parent();
                $.each(List, function (i, o) {
                    if (o.SerialNumber == SerialNumber) {
                        List.splice(i, 1);
                        return false;
                    }
                });
                $row.remove();
                GrnStrNew = GrnStrNew.replace(SerialNumber, '');
                rowCount--;
            }
        }

        //显示新增
        var tab = document.getElementById("tblExpand");
        var i = 0;
        function addDetail(entity, j) {
            
            if (entity == null && IsTrue == true) {
                alert("该调拨单已经生成调拨，不能新增！");
                return false;
            }
            if (entity.AdjustNumber <= 0) {
                alert("该物料条码可用数量小于等于0，不能新增！");
                return false;
            }

            //add by zhi.li on 2018-06-11
            var model = {};
            model.SerialNumber = entity.SerialNumber; //刷的条码
            model.PartId = entity.ItemID; //物料ID 
            model.InWarehouseId = $("#hdInWarehouseId").val(); //调入仓别ID   
            model.OutWarehouseId = entity.OutWarehouseId; //调出仓别ID
            model.OutBWhPos = entity.Code; //调出货位
            model.InBWhPos = $.trim($("#txtBWhPos").val());
            model.ItemCode = entity.ItemCode;   
            List.push(model);

            if (entity == null) {
                entity = {};
                entity.ItemCode = "";
                entity.ItemName = "";
                entity.ApplyNumber = 0; //总数量
                entity.AdjustNumber = 0; //可用数量 
                entity.Code = ""; //存位条码
            }

            //调出仓别
            $("#lblOutWarehouse").text(entity.WareHouseName);
            $("#OutWarehouseId").val(entity.OutWarehouseId);
            $("#txtPartId").val(entity.ItemID);
            $("#hidOutCode").val(entity.Code);
            i += 1;
            $("#trNewInfo").remove();
            var row, cell;
            rowNewIdx = tab.rows.length;
            row = tab.insertRow(rowNewIdx);
            row.className = "ListTableOddRow";

            //物料条码
            cell = row.insertCell(0);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = entity.SerialNumber;

            //物料号
            cell = row.insertCell(1);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = entity.ItemCode;

            //物料名称
            cell = row.insertCell(2);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = entity.ItemName;

            //调出仓库
            cell = row.insertCell(3);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = entity.WareHouseName;

            //调出货位
            cell = row.insertCell(4);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = entity.Code;

            //调入仓库
            cell = row.insertCell(5);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = $("#hdInWhCode").val();

            //调入货位
            cell = row.insertCell(6);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = $.trim($("#txtBWhPos").val());

            //可调数量
            cell = row.insertCell(7);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = entity.AdjustNumber;

            //操作
            cel = row.insertCell(8);
            cel.align = "center";
            cel.className = "Field";
            cel.innerHTML = "<span style=\"CURSOR: pointer; COLOR: #0000ff;\" onclick=\"deleteItem('" + entity.ItemCode + "','" + entity.SerialNumber + "', this)\"><%= Resources.Buttons.COM_Delete %></span>";
        }

        //保存
        function Save() {

            var str = $.trim($("#tblExpand tr:last").children("td:eq(0)").text());
            if (str == '暂无数据') {
                alert("无调拨明细，不支持保存!");
                return false;
            }
            //校验库位的产品唯一
            var isOK = true;
            $.each(List, function (i, o) {
                if (!verifyProductOnly(o.InBWhPos, o.ItemCode)) {
                    isOK = false;
                    return false;
                }
            });
            if (!isOK) return false;

            var userName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";

            var trList = $("#tblExpand").find("tr");
            var entity = {};
            entity.UserName = userName;
            entity.TransferOutDtl = JSON.stringify(List);//明细数据
            entity.OpSource = 1;
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxTransferOut.SaveTransferOut(JSON.stringify(entity));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                closeWaiting();
                return false;
            }
            alert('<%=Resources.Messages.SaveSuccess %>');
            parent.window.UpdateList();
        }
        //生成ERP调拨
        function Generate() {
            var forFlag = 0;
            //可调数量不为0的才生成ERP调拨
            var userName = 'MES';
            var docNo = "";                           //单号
            var docLineNoStr = "";                    //行号组合
            var itemIdStr = "";                       //物料ID字符串
            var adjustQtyStr = "";                    //可调数量
            var outLocationStr = "";                  //调出货位
            var binLineNoStr = "";                    //货位行号
            //循环遍历数据
            var adjustQty = $(".txtAdjustNumber");
            var outLocation = $(".OutLocationIdStr");
            var itemId = $(".ItemIdStr");
            for (var i = 0; i < adjustQty.length; i++) {
                if (parseInt($(adjustQty[i]).val()) != 0) {
                    itemIdStr += $(itemId[i]).val() + ",";
                    adjustQtyStr += $(adjustQty[i]).val() + ",";
                    outLocationStr += $(outLocation[i]).val() + ",";
                }
            }
            itemIdStr = itemIdStr.substring(0, itemIdStr.length - 1);
            adjustQtyStr = adjustQtyStr.substring(0, adjustQtyStr.length - 1);
            outLocationStr = outLocationStr.substring(0, outLocationStr.length - 1);
            //showWaiting(); //添加加载提示
            setTimeout(function () {
                var ajaxErp = SKT.LeanMES.Web.AjaxServices.AjaxTransferOut.SaveGenerateERP(userName, docNo, docLineNoStr,
                itemIdStr, adjustQtyStr, outLocationStr, binLineNoStr);
                if (ajaxErp.error != null) {
                    alert(ajaxErp.error.Message);
                    closeWaiting();
                    return false;
                }
                alert("成功生成调拨单号:" + ajaxErp.value);
                //closeWaiting(); //关闭加载提示
            }, 50);
        }
        //选择调入仓
        function selectInWarhouse() {
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=64&Multiple=false&rnd=" + Math.random(), width: 500, height: 300 });
        }
        //设置调入仓
        function getChooseValue(list) {

            ///add by zhi.li 20180608 判断有明细，改调入仓库的情况
            var tableData = document.getElementById("tblExpand");
            var rl = tableData.rows.length;

            for (i = 0; i < rl; i++) {
                if (i > 0) {
                    if (tableData.rows[i].cells.length > 1) {
                        var wareHouseName = tableData.rows[i].cells[0].innerHTML;
                        if (wareHouseName == list[0][2]) {
                            alert("更改的调入仓库与该物料当前仓库相同,不能更改！");
                            return false;
                        }
                    }
                }
            }
            $("#hdnInWarhouseId").val(list[0][0]);
        }

        //清空表数据
        //function clearTableInfo() {
        //    $("#tblExpand tr:not(:first)").each(function () {
        //        $(this).remove();
        //    });
        //}

        //拼接字符串
        function GetArrValue(o) {
            var str = "";
            for (var i = 0; i < o.length; i++) {
                if (i == 0) {
                    str = $(o[i]).val();
                }
                else {
                    str += "," + $(o[i]).val();
                }
            }
            return str;
        }

        //校验货位产品唯一
        function verifyProductOnly(cBarCode, itemCode) {
            var array = [];
            var list = List;
            //当前正在扫描的GRN的物料编码(无该参数则校验已扫描的GRN)
            if (itemCode) {
                array.push(itemCode);
            }
            //去重复
            if (list && list.length > 0) {
                for (var i = 0; i < list.length; i++) {
                    //相同的库位（多个库位条码调拨时处理）
                    if (list[i].InBWhPos == cBarCode) {
                        if (array.indexOf(list[i].ItemCode) === -1) {
                            array.push(list[i].ItemCode)
                        }
                    }
                }
            }
            //校验
            if (array.length > 0) {
                if (array.length == 1) {
                    var result = isItemCanPlacedInWarehouseLocation("", array[0], cBarCode);
                    if (result == -1) {
                        return false;
                    }
                    if (result == 0) {
                        alert("当前库位不支持存放多种产品，请扫描其他库位！");
                        $("#txtPosCode").val("").focus();
                        return false;
                    }
                }
                else {
                    var isProductOnly = isItemCanPlacedInWarehouseLocation("", "", cBarCode);
                    if (isProductOnly == -1) {
                        return false;
                    }
                    if (isProductOnly == 1) {
                        alert("当前库位不支持存放多种产品，请扫描其他库位！");
                        $("#txtPosCode").val("").focus();
                        return false;
                    }
                }
            }
            return true;
        }

        //判断产品是否能放入当前库位
        function isItemCanPlacedInWarehouseLocation(grn, itemCode, cBarCode) {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxWarehouse.IsItemCanPlacedInWarehouseLocation(grn, itemCode, cBarCode);
            if (ajax.error != null) {
                alert(ajax.error.Message, 0);
                return -1;
            }
            return ajax.value ? 1 : 0;
        }

        //验证库位条码
        function checkPosCode() {
            var posCode = $.trim($("#txtBWhPos").val());
            if (posCode == "") {
                alert("请扫描库位！");
                $("#txtBWhPos").focus();
                return false;
            }
            var entity = {};
            entity.PosCode = posCode;
            var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspGetWarehouseInfoByPosCode", JSON.stringify(entity));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var result = $.parseJSON(ajax.value).data;
            if (!result || result.length == 0) {
                alert("无效的库位条码!");
                return false;
            }
            //显示库位相关的仓库
            $("#lblInWarehouse").text(result[0].CWhName);
            $("#hdInWarehouseId").val(result[0].WarehouseId);
            $("#hdInWhCode").val(result[0].CWhCode);
            return true;
        }
    </script>
</asp:Content>
