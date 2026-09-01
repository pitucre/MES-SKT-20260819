<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="PrepareMaterialOther.aspx.cs" Inherits="SKT.LeanMES.Web.Material.PrepareMaterialOther" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">

    <table id="FTable" class="EditeContentTable" width="100%">
        <tr id="TrFrom" style="display:none">
            <td class="Label2">领料单号</td>
            <td class="Field2" colspan='3'>
                <asp:Label ID="lblFormNO" runat="server" ClientIDMode="Static"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                生产部门
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtDeptCode" runat="server" IsRequired='1' CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
                <input id="button3" class="ButtonBox" type="button" onclick="selectDeptCode()" value="..."
                    title="选择部门" />
                <asp:HiddenField ID="hdnDeptCode" runat="server" Value="-1" ClientIDMode="Static" />
            </td>
            <td class="Label2">
                仓库<em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtWhCode" runat="server" IsRequired='1' CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
                <input id="button1" class="ButtonBox" type="button" onclick="selectWhCodeList()"
                    value="..." title="选择仓库" />
                <asp:HiddenField ID="hdnWhCode" runat="server" Value="" ClientIDMode="Static" />
            </td>
        </tr>
        <tr>
            <td class="Label2">
                使用日期
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtUserDate" runat="server" CssClass="DateTimeBox" ClientIDMode="Static"></asp:TextBox>
            </td>
            <td class="Label2">
                备注
            </td>
            <td class="Field2" colspan="3">
                <asp:TextBox ID="txtRemark" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
            </td>
        </tr>
    </table>
    <table id="tblExpand"  cellspacing="0" cellpadding="4" style="border-width:0px;width:100%;border-collapse:collapse; margin-top:5px;" class="EditeContentTable">
        <tr class="ListTableHeader">
            <th scope="col" style="width: 12%;">
                存货编码
            </th>
            <th scope="col" style="width: 12%;">
                存货名称
            </th>
            <th scope="col" style="width: 20%;">
                规格型号
            </th>
            <th scope="col" style="width: 10%;">
                仓库名称
            </th>
            <th scope="col" style="width: 6%;">
                单位
            </th>
            <th scope="col" style="width: 6%;">
                领料量
            </th>
            <th scope="col" style="width: 6%;">
                已备料数量
            </th>
            <th scope="col" style="width: 6%;">
                可备料数量
            </th>
            <th scope="col" style="width: 15%;">
                备注
            </th>
            <th scope="col" onclick="addDetail(null);" id='btnAdd' style="color:#0066CC;cursor:pointer; width:6%;">
               +新增
            </th>
        </tr>
         <tr id="trNewInfo" class="ListTableOddRow"><td colspan="10" style="text-align:center;">暂无数据</td></tr>
    </table>
    
    <script type="text/javascript">

        _isHms = true; /*日期控件开启时分秒*/
        var sourceCode = '001';
        var prepareListId = '<%=Request.QueryString["ID"]%>'; //编辑时传过来的备料ID

        $(function () {

            if (prepareListId != '-1') {
                $("#TrFrom").show();
            }
            //显示备料单列表
            initItem(prepareListId);

        });

        //显示备料单列表
        function initItem(prepareListId) {
            var ajax = SKT.LeanMES.Web.AjaxServices.Material.AjaxErpMomain.MaterialRequestGetListByID(parseInt(prepareListId));
            if (ajax.error == null) {
                var entityAry = ajax.value;
                var entity = ajax.value[0];
                if (entity != null) {
                    $("#lblFormNO").text(entity["FormNo"]);
                    $("#txtDeptCode").val(entity["cDeptCode"]);
                    $("#hdnDeptCode").val(entity["cDeptCode"]);
                    $("#txtWhCode").val(entity["cWhCode"]);
                    $("#hdnWhCode").val(entity["cWhCode"]);
                    $("#txtUserDate").val(entity["PrepareDateTimeStr"]);
                    $("#txtRemark").val(entity["ZRemark"]);
                }
                for (var i = 0; i < entityAry.length; i++) {
                    addDetail(entityAry[i]);
                }
            } else {
                alert(ajax.error.Message);
            }
        }

        var tab = document.getElementById("tblExpand");
        var i = 0;
        function addDetail(entity) {

            if (entity == null) {
                entity = {};
                entity.ItemId = -1;
                entity.ProductItemCode = "";
                entity.ProductInvName = "";
                entity.CInvStd = "";
                entity.WhName = "";
                entity.Unit = "";
                entity.Qty = 0;        //领料量
                entity.RequisitionIssQty = 0; //已备数量
                entity.canAppQty = 0;  //可备数量
                entity.Remark = "";
            }
            i += 1;
            $("#trNewInfo").remove();
            var row, cell;
            rowNewIdx = tab.rows.length;
            row = tab.insertRow(rowNewIdx);
            row.className = "ListTableOddRow";

            // 存货编码
            cell = row.insertCell(0);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = "<input type=\"hidden\" class=\"ItemIdStr\" value=\"" + entity.ItemId + "\" /><input type=\"hidden\" class=\"ItemCodeStr\" value=\"" + entity.ProductItemCode + "\" />"
            + "<input type=\"text\" name=\"txtItems\" class=\"TextBox\" value=\"" + entity.ProductItemCode + "\" disabled=\"disabled\" style=\" width:75%;\" >"
            + "<input type=\"button\" id=\"btnSelectItems\" onclick=\"selectItemCode(this);\" class=\"ButtonBox\" value=\"...\" />";
            //存货名称
            cell = row.insertCell(1);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = "<input type=\"text\" name=\"txtInvName\" class=\"TextBox\" style=\" width:95%;\" disabled=\"disabled\" value=\"" + entity.ProductInvName + "\"  />"
            //存货规则
            cell = row.insertCell(2);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = "<input type=\"text\" name=\"txtInvStd\" class=\"TextBox\" style=\" width:95%;\" disabled=\"disabled\" value=\"" + entity.CInvStd + "\"  />"
            //仓库名称
            cell = row.insertCell(3);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = "<input type=\"text\" id=\"txtWhName\" IsRequired='1' style=\" width:95%;\" disabled=\"disabled\" value=\"" + entity.WhName + "\"  />"
            //单位
            cell = row.insertCell(4);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = "<input type=\"text\" name=\"txtUnit\" class=\"TextBox\" style=\" width:95%;\" disabled=\"disabled\" value=\"" + entity.Unit + "\"  />"
            //领料量
            cell = row.insertCell(5);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = "<input type=\"text\" id=\"txtQty" + i + "\" IsNumber='1' IsRequired='1' MinValue='1' style=\" width:90%;\" class=\"Qty\" value=\"" + entity.Qty + "\"  />"
            //已备料数量
            cell = row.insertCell(6);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = entity.RequisitionIssQty;
            //可备料数量
            cell = row.insertCell(7);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = "<input type=\"text\" id=\"txtCanAppQty" + i + "\" IsNumber='1'  style=\" width:90%;\" class=\"CanAppQty\" value=\"" + entity.canAppQty + "\"  />"
            //备注  
            cell = row.insertCell(8);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = "<input type=\"text\" id=\"txtRemark\" class=\"Remark\" style=\" width:90%;\" value=\"" + entity.Remark + "\"  />"
            //删除
            if (prepareListId == -1) {
                cell = row.insertCell(9);
                cell.align = "center";
                cell.className = "Field";
                cell.innerHTML = "<span style=\"CURSOR: pointer; COLOR: #0000ff;\" onclick=\"deleteItem(this)\"><%= Resources.Buttons.COM_Delete %></span>";
                cell.innerHTML += "<input type=\"hidden\" id=\"txtRequestQty\" class=\"RequestQty\" value=\"" + entity.RequisitionIssQty + "\"  />"
            } else {
                cell = row.insertCell(9);
                cell.align = "center";
                cell.className = "Field";
                cell.innerHTML = "<%= Resources.Buttons.COM_Delete %>";
                cell.innerHTML += "<input type=\"hidden\" id=\"txtRequestQty\" class=\"RequestQty\" value=\"" + entity.RequisitionIssQty + "\"  />"
            }
        }

        //保存
        function Save() {
            var whCode = $("#hdnWhCode").val(); //仓库编码
            var txtCode = $("#txtWhCode").val();
            if (txtCode == "") {
                alert("请选择对应的仓库编码信息!");
                return false;
            }
            var deptCode = $("#hdnDeptCode").val(); //部门编码
            var userDate = $("#txtUserDate").val(); //使用日期
            var remark = $("#txtRemark").val(); //备注
            var userName = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';

            var ItemIdStr = GetArrValue($(".ItemIdStr"));     //ItemID
            var ItemCodeStr = GetArrValue($(".ItemCodeStr")); //ItemCode 存货编码
            var QtyStr = GetArrValue($(".Qty"));              //领取数量
            var requisQtyStr = GetArrValue($(".RequestQty")); //已备料数量
            var canAppQtyStr = GetArrValue($(".CanAppQty"));  //可备料数量
            var RemarkStr = GetArrValue($(".Remark"));        //备注

            var ajax = SKT.LeanMES.Web.AjaxServices.Material.AjaxErpMomain.SaveOhterPrepareFormList(sourceCode, prepareListId, deptCode, whCode, userDate, userName,
                   ItemIdStr, ItemCodeStr, QtyStr, requisQtyStr, canAppQtyStr, RemarkStr, remark);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert('<%=Resources.Messages.SaveSuccess %>');
            parent.window.UpdateList(prepareListId);
        }

        //选择存货编码
        var rowIndex = -1;
        var rowObj = null;
        function selectItemCode(obj) {
            rowObj = obj.parentElement.parentElement;
            rowIndex = rowObj.rowIndex;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=68&CallBackFunc=getChooseValueMaterial&Multiple=false&rnd=" + Math.random(), width: 600, height: 300 });
        }
        //获取选中的返回值
        function getChooseValueMaterial(list) {
            var mid = list[0][0];
            var b = true;
            var o = $(".hdItemId");
            for (var i = 0; i < o.length; i++) {
                if (mid == $(o[i]).val()) {
                    b = false;
                    alert("该物料已经存在！");
                }
            }
            if (b == true) {
                rowObj.cells[0].children[0].value = list[0][0]; //ItemId
                rowObj.cells[0].children[1].value = list[0][1]; //存货编码
                rowObj.cells[0].children[2].value = list[0][1]; //存货编码

                rowObj.cells[1].children[0].value = list[0][2]; //存货名称
                rowObj.cells[2].children[0].value = list[0][3]; //存货规则
                rowObj.cells[3].children[0].value = list[0][5]; //仓库名称
                rowObj.cells[4].children[0].value = list[0][4]; //单位
            }
        }
        //选择仓库
        function selectWhCodeList() {
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=43&Multiple=false&CallBackFunc=setWhCode&rnd=" + Math.random(), width: 500, height: 300 });
        }
        function setWhCode(list) {
            $("#<%=this.txtWhCode.ClientID %>").val(list[0][1] + "|" + list[0][2]);
            $("#hdnWhCode").val(list[0][1]);
        }
        //选择部门
        function selectDeptCode() {
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=41&Multiple=false&CallBackFunc=setDeptCode&rnd=" + Math.random(), width: 500, height: 300 });
        }
        function setDeptCode(list) {
            $("#<%=this.txtDeptCode.ClientID %>").val(list[0][1] + "|" + list[0][2]);
            $("#hdnDeptCode").val(list[0][1]);
        }
        //循环获取属性值
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

        //删除行
        function deleteItem(obj) {
            tab.deleteRow(obj.parentElement.parentElement.rowIndex);
        }
    </script>

</asp:Content>
