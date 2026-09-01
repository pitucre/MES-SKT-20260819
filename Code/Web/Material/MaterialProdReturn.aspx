<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ViewMaster.master" AutoEventWireup="true"
    CodeBehind="MaterialProdReturn.aspx.cs" Inherits="SKT.LeanMES.Web.Material.MaterialProdReturn" %>
<%@ Import Namespace="Resources" %>

<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="server">
<style>
    .Bg-Red {
        background: red;
    }
</style>

    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="infoTips" colspan="4">
                <%=Resources.Messages.WithAsteriskIsRequired %>
            </td>
        </tr>
        <tr class="clear5">
        </tr> 
        <tr>
            <td class="Label2">工单<em>*</em>
            </td>
            <td class="Field2">
                <input type="text" IsRequired='1' readonly="readonly" value="" id="txtProdOrder" class="TextBox" style="width: 250px; height: 25px; font-size: 16px; font-weight: bold; text-transform: uppercase;" /><input id="button2" class="ButtonBox" type="button" onclick="selectProdOrder()"
                    value="..." title="选择工单" style="height: 27px; font-weight: bold; text-transform: uppercase;" />
                <asp:HiddenField ID="hfOrderId" runat="server" Value="-1" ClientIDMode="Static" />
            </td>

            <td class="Label2">退料部门<em>*</em>
            </td>
            <td class="Field2">
                <input type="text" IsRequired='1' readonly="readonly" value="" id="txtDepartment" class="TextBox" style="width: 250px; height: 25px; font-size: 16px; font-weight: bold; text-transform: uppercase;" /><input id="button2" class="ButtonBox" type="button" onclick="selectDepartmentValue()"
                    value="..." title="选择部门" style="height: 27px; font-weight: bold; text-transform: uppercase;" />
                <asp:HiddenField ID="hfDepartId" runat="server" Value="-1" ClientIDMode="Static" />
            </td>
        </tr>
    </table>

    <table id="tblExpand" cellspacing="0" cellpadding="4" style="border-width: 0px; width: 100%;
        border-collapse: collapse; margin-top: 5px;" class="EditeContentTable">
        <tr class="ListTableHeader">
            <th scope="col" style="width: 4%;">
                行号
            </th>
            <th scope="col" style="width: 35%;">
                物料编码
            </th>
            <th scope="col" style="width: 30%;">
                物料名称
            </th>
            <th scope="col" style="width: 8%;">
                退料数量
            </th>
<%--            <th scope="col" style="width: 8%;">
                备注
            </th>--%>
            <th scope="col" onclick="addDetail(null);" id='btnAdd' style="color: #0066CC; cursor: pointer;
                width: 5%; font-weight: bold">
                +新增
            </th>
        </tr>
        <tr id="trNewInfo" class="ListTableOddRow">
            <td colspan="6" style="text-align: center;">
                暂无数据
            </td>
        </tr>
    </table>


    <div class="clear5">
    </div>
    <div style="text-align: center;" class="Tips" id="msg">
    </div>
 
    <script type="text/javascript">
        var arrGrn = []; //扫描的GRN数组
        var curUser = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';

        $("form").submit(function(e) {
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
                    if (checkGrnExist($.trim($("#txtGRN").val()))===true) {
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
 
        //退料部门选择和获取
        function selectDepartmentValue() {
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=13&CallBackFunc=getChooseValueDepartment&Multiple=false&rnd=" + Math.random(), width: 500, height: 300 });
        }
        function getChooseValueDepartment(list) {
            $("#txtDepartment").val(list[0][2]);
            $("#<%=this.hfDepartId.ClientID %>").val(list[0][0]);
        }

        //选中生产工单
        function selectProdOrder() {
            dialog({ title: "<%=Resources.Common.ChooseWindow %>",
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
        function addDetail(entity) {
            if(!($("#txtProdOrder").val() !=='' && $("#txtDepartment").val() !=='')){
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
        }

        function isPositiveNum(obj) {//是否为正整数
            var s = $(obj).val();
            var re = /^[1-9]*[1-9][0-9]*$/;
            if (isNaN(s * 1)) {
                $(obj).val('')
                $(obj).focus();
                alert('请输入数字格式');
                return false;
            }

        }
    </script>
</asp:Content>
