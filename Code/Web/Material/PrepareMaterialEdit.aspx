<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    CodeBehind="PrepareMaterialEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Material.PrepareMaterialEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <table id="FTable" class="EditeContentTable" width="100%">
        <tr>
            <td class="Label" align="left" colspan="4">
                <span class="information16"></span>请选择备料的生产工单编号,物料编码
            </td>
        </tr>
        <tr>
            <td class="Label2">
                生产订单号<em></em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtMoCode" runat="server" IsRequired='1' CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
                <input id="button2" class="ButtonBox" type="button" onclick="selectMoallocateList()"
                    value="..." title="选中生产订单号" />
                <asp:HiddenField ID="hdnMoId" runat="server" Value="-1" ClientIDMode="Static" />
            </td>
            <td class="Label2">
                物料编码
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtItemCode" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
                <input id="button5" class="ButtonBox" type="button" onclick="selectMollocateInCode()"
                    value="..." title="选择存货编码" />
                <asp:HiddenField ID="hdnAllocateIdStr" runat="server" Value="" ClientIDMode="Static" />
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
    <table id="tblExpand" cellspacing="0" cellpadding="4" style="border-width: 0px; width: 100%;
        border-collapse: collapse; margin-top: 5px;" class="EditeContentTable">
        <tr class="ListTableHeader">
            <th scope="col" style="width: 4%;">
                序号
            </th>
            <th scope="col" style="width: 12%;">
                工单
            </th>
            <th scope="col" style="width: 12%;">
                物料编码
            </th>
            <th scope="col" style="width: 12%;">
                物料名称
            </th>
            <th scope="col" style="width: 12%;">
                工单标准量
            </th>
            <th scope="col" style="width: 12%;">
                已备料数量
            </th>
            <th scope="col" style="width: 12%;">
                可备料数量
            </th>
            <th scope="col" style="width: 12%;">
                备注
            </th>
            <th scope="col" style="color: #0066CC; cursor: pointer; width: 12%;">
                操作
            </th>
        </tr>
        <tr id="trNewInfo" class="ListTableOddRow">
            <td colspan="9" style="text-align: center;">
                暂无数据
            </td>
        </tr>
    </table>
    <asp:HiddenField ID="hdnFormSource" runat="server" Value="" />
    <input type="hidden" value="" id="hdnPararms" name="hdnPararms" />
    <input type="hidden" value="" id="hdnPararmValue" name="hdnPararmValue" />
    <input type="hidden" value="" id="hdnOperation" name="hdnOperation" />
    <input type="hidden" value="" id="hdnFileName" name="hdnFileName" />
    <script type="text/javascript">
        var sourceCode = '001';
        var prepareListId = '<%=Request.QueryString["ID"]%>'; //编辑时传过来的备料ID
        var allocateIdStr = "";
        $(function () {
            //编辑模式显示对应的信息
            if (prepareListId != '-1') {
                showMoallocateDetailInfo(prepareListId);
            }
        });

        //选中生产工单
        function selectMoallocateList() {
            dialog({ title: "<%=Resources.Common.ChooseWindow %>",
                src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=62&Multiple=false&rnd=" + Math.random(), width: 600, height: 300
            });
        }
        //备料工单返回的值
        function getChooseValue(list) {
            $("#txtMoCode").val(list[0][1]);
            $("#hdnMoId").val(list[0][0]);
        }

        //选择物料编码
        function selectMollocateInCode() {
            //通过prepareListId返回审核状态
            if (prepareListId != '-1') {
                var ajax = SKT.LeanMES.Web.AjaxServices.Material.AjaxErpMomain.GetBackCheckStatus(prepareListId);
                if (ajax.error != null) {
                    return false;
                }
                var State = ajax.value;
                if (State == 1 || State == 2) {
                    alert("该备料单已经审核不能新增!");
                    return;
                }
            }
            var txtMoCode = $("#txtMoCode").val();
            if (txtMoCode == "") {
                alert("请选择生产订单号!");
                return false;
            }
            if (txtMoCode != "") {
                searchCondition = " MoCode  ='" + txtMoCode + "' ";
            }
            else {
                searchCondition = "";
            }
            dialog({ title: "工单用料信息",
                src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=65&PageCondition="
                + escape(searchCondition) + "&Multiple=true&CallBackFunc=setInvCode&rnd=" + Math.random(), width: 600, height: 300
            });
        }
        //存货编码返回值
        function setInvCode(list) {
            var invCodeStr = "";
            $("#trNewInfo").remove();
            var row, cel
            for (var i = 0; i < list.length; i++) {
                if (allocateIdStr.indexOf(list[i][0]) >= 0) {
                    alert("<%=Resources.Messages.RecordExists %>");
                    return false;
                }
                allocateIdStr += list[i][0] + ",";
                invCodeStr += list[i][3] + ",";
                //
                row = tableList.insertRow(i + 1);
                row.className = i % 2 == 0 ? "ListTableEvenRow" : "ListTableOddRow";
                cel = row.insertCell(0);
                cel.align = "center";
                cel.className = "Field";
                cel.innerHTML = i + 1;
                cel.innerHTML += '<input type="hidden" class ="AllocateIdStr" value = "' + list[i][8] + '" />';
                cel.innerHTML += '<input type="hidden" class ="moIdStr" value = "' + list[i][6] + '" />';
                cel.innerHTML += '<input type="hidden" class ="moDIdStr" value = "' + list[i][7] + '" />';
                cel.innerHTML += '<input type="hidden" class ="itemIdStr" value = "' + list[i][9] + '" />';
                cel.innerHTML += '<input type="hidden" class ="StandardQtyStr" value = "' + list[i][4].toString() + '" />';
                cel.innerHTML += '<input type="hidden" class ="requisQtyStr" value = "' + list[i][5].toString() + '" />';
                cel.innerHTML += '<input type="hidden" id ="canAppQty' + i + '" value = "' + list[i][4].toString() + '" />'
                //生产订单号 
                cel = row.insertCell(1);
                cel.align = "center";
                cel.className = "Field";
                cel.innerHTML = list[i][1];
                //物料编码
                cel = row.insertCell(2);
                cel.align = "center";
                cel.className = "Field";
                cel.innerHTML = list[i][2];
                //物料名称
                cel = row.insertCell(3);
                cel.align = "center";
                cel.className = "Field";
                cel.innerHTML = list[i][3];
                //工单标准量
                cel = row.insertCell(4);
                cel.align = "center";
                cel.className = "Field";
                cel.innerHTML = list[i][4].toString();
                //已备料数量
                cel = row.insertCell(5);
                cel.align = "center";
                cel.className = "Field";
                cel.innerHTML = list[i][5].toString();
                //可备料数量
                cel = row.insertCell(6);
                cel.align = "center";
                cel.className = "Field";
                cel.innerHTML = "<input type='text' name='canNumber'  style= 'width:90%;' id ='canAppQtyStr" + i + "' class='canAppQtyStr' value='0'/>";
                //备注
                cel = row.insertCell(7);
                cel.align = "center";
                cel.className = "Field";
                cel.innerHTML = "<input type='text'  style= 'width:90%;'  id='remarkStr'  class ='remarkStr' value ='' />";
                //操作
                if (prepareListId == -1) {
                    cel = row.insertCell(8);
                    cel.align = "center";
                    cel.className = "Field";
                    cel.innerHTML = "<span style=\"CURSOR: pointer; COLOR: #0000ff;\" onclick=\"deleteItem(this,'" + list[i][0].toString() + "')\"><%= Resources.Buttons.COM_Delete %></span>";
                } else {
                    cel = row.insertCell(8);
                    cel.align = "center";
                    cel.className = "Field";
                    cel.innerHTML = "<%= Resources.Buttons.COM_Delete %>";
                }
            }
            if (prepareListId == -1) {
                $("#hdnAllocateIdStr").val(allocateIdStr);
                $("#txtItemCode").val(invCodeStr);
            }
            else {
                $("#hdnAllocateIdStr").val($("#hdnAllocateIdStr").val() + allocateIdStr);
            }
        }

        //选择仓库
        function selectWhCodeList() {
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=14&Multiple=false&CallBackFunc=setWhCode&rnd=" + Math.random(), width: 500, height: 300 });
        }
        function setWhCode(list) {
            $("#<%=this.txtWhCode.ClientID %>").val(list[0][1] + "|" + list[0][2]);
            $("#hdnWhCode").val(list[0][1]);
        }
        //选择部门
        function selectDeptCode() {
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=13&Multiple=false&CallBackFunc=setDeptCode&rnd=" + Math.random(), width: 500, height: 300 });
        }
        function setDeptCode(list) {
            $("#<%=this.txtDeptCode.ClientID %>").val(list[0][1] + "|" + list[0][2]);
            $("#hdnDeptCode").val(list[0][1]);
        }
        //显示子件明细
        var tableList = document.getElementById("tblExpand");
        function showMoallocateDetailInfo(prepareListId) {
            $("#tblExpand tr:not(:first)").each(function () {
                $(this).remove();
            });
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.ShowMoallocateDetail(prepareListId);
            if (ajax.error != null) {
                return false;
            }
            else {
                var entity = ajax.value;
                if (entity != null && entity.length > 0) {
                    $("#trNewInfo").remove();
                    var row, cel
                    for (var i = 0; i < entity.length; i++) {
//                        if (allocateIdStr.indexOf(entity[i].Id) >= 0) {
//                            alert("<%=Resources.Messages.RecordExists %>");
//                            return false;
//                        }
                        allocateIdStr += entity[i].Id + ","; //ID
                        //invCodeStr += entity[i].ItemCode + ","; //ItemCode
                        //
                        row = tableList.insertRow(i + 1);
                        row.className = i % 2 == 0 ? "ListTableEvenRow" : "ListTableOddRow";
                        cel = row.insertCell(0);
                        cel.align = "center";
                        cel.className = "Field";
                        cel.innerHTML = i + 1;
                        cel.innerHTML += '<input type="hidden" class ="AllocateIdStr" value = "' + entity[i].ModtlNo + '" />'; //行号
                        cel.innerHTML += '<input type="hidden" class ="moIdStr" value = "' + entity[i].MOID + '" />'; //工单ID
                        cel.innerHTML += '<input type="hidden" class ="moDIdStr" value = "' + entity[i].ModtlId + '" />'; //工单明细ID
                        cel.innerHTML += '<input type="hidden" class ="itemIdStr" value = "' + entity[i].ItemCode + '" />'; //ItemID
                        cel.innerHTML += '<input type="hidden" class ="StandardQtyStr" value = "' + entity[i].SourceQty.toString() + '" />'; //标准用量
                        cel.innerHTML += '<input type="hidden" class ="requisQtyStr" value = "' + entity[i].Qty.toString() + '" />'; //已发数量
                        cel.innerHTML += '<input type="hidden" id ="canAppQty' + i + '" value = "' + entity[i].SourceQty.toString() + '" />'//标准用量
                        //生产订单号 
                        cel = row.insertCell(1);
                        cel.align = "center";
                        cel.className = "Field";
                        cel.innerHTML = entity[i].MOCode;
                        //物料编码
                        cel = row.insertCell(2);
                        cel.align = "center";
                        cel.className = "Field";
                        cel.innerHTML = entity[i].ItemCode;
                        //物料名称
                        cel = row.insertCell(3);
                        cel.align = "center";
                        cel.className = "Field";
                        cel.innerHTML = entity[i].ItemName;
                        //工单标准量
                        cel = row.insertCell(4);
                        cel.align = "center";
                        cel.className = "Field";
                        cel.innerHTML = entity[i].SourceQty.toString();
                        //已备料数量
                        cel = row.insertCell(5);
                        cel.align = "center";
                        cel.className = "Field";
                        cel.innerHTML = entity[i].SourceQty.toString();
                        //可备料数量
                        cel = row.insertCell(6);
                        cel.align = "center";
                        cel.className = "Field";
                        cel.innerHTML = "<input type='text' name='canNumber'  style= 'width:90%;' id ='canAppQtyStr" + i + "' class='canAppQtyStr' value='" + entity[i].Qty + "'/>";
                        //备注
                        cel = row.insertCell(7);
                        cel.align = "center";
                        cel.className = "Field";
                        cel.innerHTML = "<input type='text'  style= 'width:90%;'  id='remarkStr'  class ='remarkStr' value ='" + entity[i].Remark + "' />";
                        //操作
                        if (prepareListId == -1) {
                            cel = row.insertCell(8);
                            cel.align = "center";
                            cel.className = "Field";
                            cel.innerHTML = "<span style=\"CURSOR: pointer; COLOR: #0000ff;\" onclick=\"deleteItem(this,'" + entity[i].Id.toString() + "')\"><%= Resources.Buttons.COM_Delete %></span>";
                        } else {
                            cel = row.insertCell(8);
                            cel.align = "center";
                            cel.className = "Field";
                            cel.innerHTML = "<%= Resources.Buttons.COM_Delete %>";
                        }
                    }
                    if (prepareListId == -1) {
                        $("#hdnAllocateIdStr").val(allocateIdStr);
                        $("#txtItemCode").val(invCodeStr);
                    }
                    else {
                        $("#hdnAllocateIdStr").val($("#hdnAllocateIdStr").val() + allocateIdStr);
                    }
                }
            }
        }
        function deleteItem(obj, AllocateId) {
            tableList.deleteRow(obj.parentElement.parentElement.rowIndex);
            allocateIdStr = allocateIdStr.replace(AllocateId + ",", "");
            $("#hdnAllocateIdStr").val(allocateIdStr);
        }
        //清空表数据
        function clearTableInfo() {
            $("#tblRecHistory tr:not(:first)").each(function () {
                $(this).remove();
            });
        }
        //保存
        function Save() {
            var forFlag = 0;
            var isFlage = true;
            var txtMoCode = $("#txtMoCode").val();
            if (txtMoCode == "") {
                alert("请选择生产订单号!");
                return false;
            }
            var whCode = $("#hdnWhCode").val(); //仓库编码
            var txtCode = $("#txtWhCode").val();
            if (txtCode == "") {
                alert("请选择对应的仓库编码信息!");
                return false;
            }
            $("#tblExpand tr").each(function () {
                if ($(this).children("td:eq(3)").text() != null && $(this).children("td:eq(3)").text() != "") {
                    forFlag += 1;
                    var canApp = parseFloat($("#canAppQty" + (forFlag - 1).toString()).val());
                    var canAppRealQty = parseFloat($("#canAppQtyStr" + (forFlag - 1).toString()).val());
                    if (canAppRealQty > canApp) {
                        alert('备料数量不能大于可备料数量' + canApp);
                        isFlage = false;
                        return false;
                    }
                }
            })
            if (isFlage) {
                var allocateIdStr = GetArrValue($(".AllocateIdStr"));
                var canAppQtyStr = GetArrValue($(".canAppQtyStr"));    // 可备料数量
                var startdQtyStr = GetArrValue($(".StandardQtyStr"));  // 工单基本数量
                var requisQtyStr = GetArrValue($(".requisQtyStr"));    // 已备料数量
                var remarkStr = GetArrValue($(".remarkStr"));
                var moIdStr = GetArrValue($(".moIdStr"));
                var moDIdStr = GetArrValue($(".moDIdStr"));
                var itemIdStr = GetArrValue($(".itemIdStr"));
                var deptCode = $("#hdnDeptCode").val(); //部门编码
                var userDate = $("#<%=this.txtUserDate.ClientID %>").val();
                var userName = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';
                var remark = $("#<%=this.txtRemark.ClientID %>").val();
                if (allocateIdStr == "") {
                    alert("请选择对应的备料子件信息!");
                    return false;
                }
                showWaiting(); //添加加载提示
                setTimeout(function () {
                    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.SavePrepareFormList(txtMoCode,sourceCode, prepareListId, deptCode, whCode, userDate, userName,
                         moIdStr, moDIdStr, allocateIdStr, itemIdStr, startdQtyStr, requisQtyStr, canAppQtyStr, remarkStr, remark);
                    if (ajax.error != null) {
                        alert(ajax.error.Message);
                        return false;
                    }
                    alert('<%=Resources.Messages.SaveSuccess %>');
                    parent.window.UpdateList(prepareListId);
                    closeWaiting(); //关闭加载提示
                }, 50);
            }
        }
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
