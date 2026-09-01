<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ScrapNoBillOutEdit.aspx.cs"
    MasterPageFile="~/Masters/EditMaster.master" Inherits="SKT.LeanMES.Web.Scrap.ScrapNoBillOutEdit" %>

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
            <td class="Label2">请扫物料条码<em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtGRN" runat="server" CssClass="TextBox" ClientIDMode="Static"
                    Style="width: 250px;"></asp:TextBox>
                <input type="hidden" id="txtPartId" />
            </td>
            <td class="Label2">当前仓库
            </td>
            <td class="Field2">
                <asp:Label ID="lblWarehouse" runat="server"></asp:Label>
                <input type="hidden" id="WarehouseId" />
                <input type="hidden" id="hidCode" />
            </td>
        </tr>

    </table>
    <table id="tblExpand" cellspacing="0" cellpadding="4" style="border-width: 0px; width: 100%; border-collapse: collapse; margin-top: 5px;"
        class="EditeContentTable">
        <tr class="ListTableHeader">
            <th scope="col" style="width: 10%;">当前仓库</th>
            <th scope="col" style="width: 20%;">物料条码</th>
            <th scope="col" style="width: 15%;">物料号</th>
            <th scope="col" style="width: 15%;">物料名称</th>
            <th scope="col" style="width: 15%;">库位条码</th>
            <%--            <th scope="col" style="width: 20%;">
                库存数量
            </th>--%>
            <th scope="col" style="width: 20%;">可调数量</th>
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
        //物料列表
        var List = [];

        $(function () {
            $("#txtGRN").keydown(function () {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
  
                    //验证条码
                    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.GetItemIdByMaterialGRN($("#txtGRN").val().trim());
                    if (ajax.error != null) {
                        alert(ajax.error.Message);
                        closeWaiting();
                        return false;
                    }
                    //显示报废信息列表
                    showTransfOutInfo($("#txtGRN").val().trim());
                }
            });
      
        });
        //显示报废信息列表

        var rowCount = 0;
        function showTransfOutInfo(SN) {
            ///add by zhi.li 20180608 判断重复
            var tableData = document.getElementById("tblExpand");
            var rl = tableData.rows.length;

            for (i = 0; i < rl; i++) {
                if (i > 0) {
                    if (tableData.rows[i].cells.length > 1) {
                        var serialNumber = tableData.rows[i].cells[1].innerHTML;
                        if (serialNumber == SN && serialNumber != "") {
                            alert("该物料条码已经扫描，不能重复扫描！");
                            return false;
                        }
                    }
                }
            }
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxScrapNoBillOut.ShowScrapNoBillOutInfo(SN);
            if (ajax.error != null) {
                $("#txtGRN").focus();
                return false;
            }

            var entity = {};
            entity = ajax.value;
            if (entity != null && entity.length > 0) {
                var entityAry = ajax.value;
                var entity = ajax.value[0];


                for (var i = 0; i < entityAry.length; i++) {
                    rowCount++;
                    addDetail(entityAry[i], i);
                }
            }
        }

        //删除行操作  add by zhi.li 20180608
        function deleteItem(itemCode, t) {
            var index = -1;
            $(t).parent().parent().remove();
            List.splice(index, 1);
            rowCount--;
        }

        //显示新增
        var tab = document.getElementById("tblExpand");
        var i = 0;
        function addDetail(entity, j) {
            //先清原来的数据，再绑定
            //clearTableInfo();
            if (entity == null && IsTrue == true) {
                alert("该报废单已经生成报废，不能新增！");
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
            model.WarehouseId = entity.WarehouseId; //仓别ID
            model.BWhPos = entity.Code; //调出货位
            List.push(model);

            if (entity == null) {
                entity = {};
                entity.ItemCode = "";
                entity.ItemName = "";
                entity.ApplyNumber = 0; //总数量
                entity.AdjustNumber = 0; //可用数量 
                entity.Code = ""; //存位条码
            }

            //仓别
            $("#<%=this.lblWarehouse.ClientID %>").text(entity.WareHouseName);
            $("#WarehouseId").val(entity.WarehouseId);
            $("#txtPartId").val(entity.ItemID);
            $("#hidCode").val(entity.Code);
            i += 1;
            $("#trNewInfo").remove();
            var row, cell;
            rowNewIdx = tab.rows.length;
            row = tab.insertRow(rowNewIdx);
            row.className = "ListTableOddRow";

            //仓库
            cell = row.insertCell(0);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = entity.WareHouseName;

            //物料条码
            cell = row.insertCell(1);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = entity.SerialNumber;

            //物料号
            cell = row.insertCell(2);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = entity.ItemCode;

            //物料名称
            cell = row.insertCell(3);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = entity.ItemName;

            //调出货位
            cell = row.insertCell(4);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = entity.Code;

            ////库存数量
            //cell = row.insertCell(3);
            //cell.align = "center";
            //cell.className = "Field";
            //cell.innerHTML = entity.ApplyNumber;

            //可调数量
            cell = row.insertCell(5);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = entity.AdjustNumber;

            //操作
            cel = row.insertCell(6);
            cel.align = "center";
            cel.className = "Field";
            cel.innerHTML = "<span style=\"CURSOR: pointer; COLOR: #0000ff;\" onclick=\"deleteItem('" + entity.ItemCode + "', this)\"><%= Resources.Buttons.COM_Delete %></span>";
        }

        //保存
        function Save() {
  
            var str = $.trim($("#tblExpand tr:last").children("td:eq(0)").text());
            if (str == '暂无数据') {
                alert("无报废明细，不支持保存!");
                return false;
            }
            var userName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";

            var trList = $("#tblExpand").find("tr");
            var entity = {};
            entity.UserName = userName;
            //entity.SerialNumber = $("#<%=this.txtGRN.ClientID %>").val(); //刷的条码
            entity.ScrapNoBillOutDtl = JSON.stringify(List);//明细数据
            //showWaiting(); //添加加载提示
            setTimeout(function () {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxScrapNoBillOut.SaveScrapNoBillOut(JSON.stringify(entity));
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    //closeWaiting();
                    return false;
                }
                alert('<%=Resources.Messages.SaveSuccess %>');
                parent.window.UpdateList();
                closeWaiting(); //关闭加载提示
            }, 50);
        }
        //生成ERP报废
        function Generate() {
            var forFlag = 0;
            //可调数量不为0的才生成ERP报废
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
                var ajaxErp = SKT.LeanMES.Web.AjaxServices.AjaxScrapNoBillOut.SaveGenerateERP(userName, docNo, docLineNoStr,
                itemIdStr, adjustQtyStr, outLocationStr, binLineNoStr);
                if (ajaxErp.error != null) {
                    alert(ajaxErp.error.Message);
                    //closeWaiting();
                    return false;
                }
                alert("成功生成报废单号:" + ajaxErp.value);
                closeWaiting(); //关闭加载提示
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
        }

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
    </script>
</asp:Content>
