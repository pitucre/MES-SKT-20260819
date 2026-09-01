<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/EditMaster.master"
    CodeBehind="MaterialApplyEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Material.MaterialApplyEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <table id="FTable" class="EditeContentTable" width="100%">
        <%--        <tr>
            <td class="Label" align="left" colspan="4">
                <span class="information16"></span>请选择生产投料单编号,物料编码
            </td>
        </tr>--%>
        <tr>
            <td class="infoTips" colspan="4">
                <%=Resources.Messages.WithAsteriskIsRequired %>
            </td>
        </tr>
        <tr class="clear5">
        </tr>
        <tr>
            <td class="Label2">工单号码<em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtMoCode" runat="server" IsRequired='1' CssClass="TextBox" ClientIDMode="Static"></asp:TextBox><input id="button2" class="ButtonBox" type="button" onclick="selectMoallocateList()"
                    value="..." title="生产投料单号" />
                <asp:HiddenField ID="hdnMoId" runat="server" Value="-1" ClientIDMode="Static" />
            </td>
            <td class="Label2">物料编码
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtItemCode" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox><input id="button5" class="ButtonBox" type="button" onclick="selectMollocateInCode()"
                    value="..." title="选择物料编码" />
                <asp:HiddenField ID="hdnAllocateIdStr" runat="server" Value="" ClientIDMode="Static" />
            </td>
        </tr>
        <tr>
            <td class="Label2">生产部门<em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtDeptCode" runat="server" IsRequired='1' CssClass="TextBox" ClientIDMode="Static"
                    ReadOnly="true"></asp:TextBox><input id="button3" class="ButtonBox" type="button" onclick="selectDeptCode()" value="..."
                        title="选择部门" />
                <asp:HiddenField ID="hdnDeptCode" runat="server" Value="-1" ClientIDMode="Static" />
            </td>
            <td class="Label2">仓库
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtWhCode" runat="server" CssClass="TextBox" ClientIDMode="Static"
                    ReadOnly="true"></asp:TextBox><input id="button1" class="ButtonBox" type="button" onclick="selectWhCodeList()"
                        value="..." title="选择仓库" />
                <asp:HiddenField ID="hdnWhCode" runat="server" Value="" ClientIDMode="Static" />
                <asp:HiddenField ID="hdnWhID" runat="server" Value="" ClientIDMode="Static" />
            </td>
        </tr>
        <tr>
            <td class="Label2">使用日期<em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtUserDate" runat="server" CssClass="DateTimeBox" Enabled="false"
                    IsRequired='1' ClientIDMode="Static"></asp:TextBox>
            </td>
            <td class="Label2">备注
            </td>
            <td class="Field2" colspan="3">
                <asp:TextBox ID="txtRemark" runat="server" CssClass="TextBox" MaxLength="50" ClientIDMode="Static"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">选择全部物料
            </td>
            <td class="Field2" colspan="3">
                <input id="selAllMaterial" type="checkbox" onclick="selAllMaterialClick()" />
            </td>
        </tr>
    </table>
    <table id="tblExpand" cellspacing="0" cellpadding="4" style="border-width: 0px; width: 100%; border-collapse: collapse; margin-top: 5px;"
        class="EditeContentTable">
        <tr class="ListTableHeader">
            <th scope="col" style="width: 4%;">序号
            </th>
            <th scope="col" style="width: 12%;">物料编码
            </th>
            <th scope="col" style="width: 20%;">物料名称
            </th>
            <th scope="col" style="width: 8%;">工单标准量
            </th>
            <th scope="col" style="width: 8%;">已备料数量
            </th>
            <th scope="col" style="width: 8%;">已领未备料数量
            </th>
            <th scope="col" style="width: 8%;">领料数量<em>*</em>
            </th>
            <th scope="col" style="width: 8%;">当前库存
            </th>
            <th scope="col" style="width: 7%;">是否齐套
            </th>
            <th scope="col" style="width: 12%;">备注
            </th>
            <th scope="col" style="color: #0066CC; width: 6%;">操作
            </th>
        </tr>
    </table>
    <asp:HiddenField ID="hdnFormSource" runat="server" Value="" />
    <input type="hidden" value="" id="hdnPararms" name="hdnPararms" />
    <input type="hidden" value="" id="hdnPararmValue" name="hdnPararmValue" />
    <input type="hidden" value="" id="hdnOperation" name="hdnOperation" />
    <input type="hidden" value="" id="hdnFileName" name="hdnFileName" />
    <script type="text/javascript">

        var prepareListId = '<%=Request.QueryString["ID"]%>'; //编辑时传过来的备料ID
        var orderState = '<%=Request.QueryString["orderState"]%>'; //编辑时传过来的备料
        var allocateIdStr = "";
        var allocateNoStr = "";

        //物料列表
        var List = [];
        var rowCount = 0;

        $(function () {
            //编辑模式显示对应的信息
            if (prepareListId != '-1') {
                $("#txtMoCode").attr("disabled", "disabled");
                $("#button2").attr("disabled", "disabled");
                showMoallocateDetailInfo(prepareListId);
            }
        });

        //选中生产工单
        function selectMoallocateList() {
            dialog({
                title: "<%=Resources.Common.ChooseWindow %>",
                src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=81&Multiple=false&rnd=" + Math.random(), width: 700, height: 400
            });
        }
        //备料工单返回的值
        function getChooseValue(list) {
            clearTableInfo(); //清空表数据
            $("#txtItemCode").val("");
            allocateIdStr = "";
            allocateNoStr = "";
            $("#selAllMaterial").attr("checked", false);

            $("#txtMoCode").val(list[0][1]);
            $("#hdnMoId").val(list[0][1]);
        }

        //选择物料编码
        function selectMollocateInCode() {
            var txtMoCode = $("#txtMoCode").val();
            if (txtMoCode == "") {
                alert("请选择生产投料单号!");
                return false;
            }
            if (txtMoCode != "") {
                searchCondition = " MoCode  ='" + txtMoCode + "' ";
            }
            else {
                searchCondition = "";
            }
            dialog({
                title: "工单用料信息",
                src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=82&PageCondition="
                + escape(searchCondition) + "&Multiple=true&CallBackFunc=setInvCode&rnd=" + Math.random(), width: 800, height: 400
            });
            }

            //选择全部物料
            function selAllMaterialClick() {
                var txtMoCode = $("#txtMoCode").val();

                if ($.trim(txtMoCode) == "") {
                    alert("请选择投料单");
                    return;
                }
                if ($("#selAllMaterial").attr("checked") != "checked") {
                    return;
                }

                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialApply.MaterialApplyAllItem(txtMoCode);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }
                else {
                    if (ajax.value != null) {
                        $("#txtItemCode").val("");
                        allocateIdStr = "";
                        allocateNoStr = "";

                        setInvCode(ajax.value)
                    }
                }
            }
            //存货编码返回值
        function setInvCode(list) {
                var have = 0;
                if (list.length <= 0) {
                    return;
                }
                if (list[0][0] != "-1") {
                    for (var i = 0; i < list.length; i++) {
                        have = 0;
                        //修改值
                        $.grep(List, function (o, j) {
                            //BirongLiang  2017-1-24增加ItemCode条件
                            //if (o.ApplyDtlId == list[i][0] && o.RowId == list[i][2] && o.ItemCode == list[i][3]) {
                            if (o.ItemCode == list[i][3]) {
                                have = 1;
                                return;
                            };
                        });
                        if (have == 0) {
                            rowCount++;
                            var e = {};
                            e.ApplyDtlId = -1;
                            e.RowId = list[i][2];
                            e.ApplyDtlId = list[i][0];
                            e.Statue = 0;
                            e.ItemId = -1;
                            e.ItemCode = list[i][3];
                            e.ItemName = list[i][4];
                            //领料数量
                            e.ApplyQty = 0;
                            if (list[i][5] - list[i][6] - list[i][8] > 0) {
                                e.ApplyQty = parseFloat(list[i][5] - list[i][6] - list[i][8]);
                            }
                            e.SourceQty = list[i][5];
                            e.ActiQty = list[i][6] !== '' ? list[i][6] : 0;
                            e.Qty = list[i][7];
                            e.ApplyQtySum = list[i][8];
                            e.Remark = '';
                            addDetail(e, List.length);
                            List.push(e);
                        }
                    }
                }
                else {//清空
                    $("#txtItemCode").val("");
                    var trList = $("#tblExpand").find("tr");
                    for (var i = trList.length - 1; i > 0; i--) {
                        tableList.deleteRow(i);
                        List = [];
                    }
                }
            }

            //选择仓库
            function selectWhCodeList() {
                dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=14&Multiple=false&CallBackFunc=setWhCode&rnd=" + Math.random(), width: 500, height: 300 });
        }
        function setWhCode(list) {
            var whCodes = list[0][1] + "|" + list[0][2];
            if (list[0][0] == "-1") {
                whCodes = "";
            }
            $("#<%=this.txtWhCode.ClientID %>").val(whCodes);
            $("#hdnWhID").val(list[0][0]);
            $("#hdnWhCode").val(list[0][1]);
        }
        //选择部门
        function selectDeptCode() {
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=13&Multiple=false&CallBackFunc=setDeptCode&rnd=" + Math.random(), width: 500, height: 300 });
        }
        function setDeptCode(list) {
            var DeptCodes = list[0][1] + "|" + list[0][2];
            if (list[0][0] == "-1") {
                DeptCodes = "";
            }
            $("#<%=this.txtDeptCode.ClientID %>").val(DeptCodes);
            $("#hdnDeptCode").val(list[0][1]);
        }

        //编辑时显示子件明细
        var tableList = document.getElementById("tblExpand");
        function showMoallocateDetailInfo(prepareListId) {
            $("#tblExpand tr:not(:first)").each(function () {
                $(this).remove();
            });
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialApply.GetMaterialApply(prepareListId);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var en = $.parseJSON(ajax.value);
            //表头添加
            if (en.data != null && en.data.length > 0) {
                $("#<%=this.txtDeptCode.ClientID %>").val(en.data[0]["DepCode"] + "|" + en.data[0]["DepName"]);
                $("#<%=this.hdnDeptCode.ClientID %>").val(en.data[0]["DepCode"]);
                $("#<%=this.txtWhCode.ClientID %>").val(en.data[0]["WhCode"] + "|" + en.data[0]["WhName"]);
                $("#<%=this.hdnWhCode.ClientID%>").val(en.data[0]["WhCode"]);
                $("#<%=this.txtUserDate.ClientID %>").val(en.data[0]["UseDateTime"]);
                $("#<%=this.txtRemark.ClientID%>").val(en.data[0]["Remark"]);
                $("#<%=this.txtMoCode.ClientID%>").val(en.data[0]["MOCode"]);
            }
            //表身
            List = en.data1;
            //console.info(List);
            var row, cel;
            rowCount = 0;
            for (var i = 0; i < List.length; i++) {
                rowCount++;
                addDetail(List[i], i);
            }
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
            //已添加项
            if (List.length == 0) {
                alert("请添加申请项!");
                return false;
            }
            var today = new Date();
            today = today.toDateString();
            var useDate = $("#txtUserDate").val();
            useDate = new Date(useDate);
            if (Date.parse(today) - Date.parse(useDate) > 0) {
                alert("使用日期需大于今天");
                return false;
            }


            var whCode = "";
            var whID = 0;
            var txtWh = $("#txtWhCode").val();
            if (txtWh != "") {
                var whArr = txtWh.split('|');
                whCode = whArr[0];
                if (whArr[0] == $("#hdnWhCode").val()) {
                    whID = parseInt($("#hdnWhID").val()); //仓库ID  
                }
                // whCode = $("#hdnWhCode").val() == "" ? $("#txtWhCode").val() : $("#hdnWhCode").val(); //仓库编码,有可能是直接输入仓库代码，这样就要去文本框的值
            }
            var txtDeptCode = $("#txtDeptCode").val();
            var depCodeNo = txtDeptCode.split('|')[0]; //部门编码          

            var entity = {};
            entity.ApplyId = prepareListId;
            entity.ApplyType = 1; //工单生成
            entity.MOCode = txtMoCode; //投料单号
            entity.DepCode = depCodeNo; //部门编码
            entity.WhCode = whCode;     //仓库编码
            entity.UseDateTime = $("#<%=this.txtUserDate.ClientID %>").val(); //使用日期
            entity.Remark = $("#<%=this.txtRemark.ClientID %>").val(); //主表备注
            entity.CreateBy = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';

            var enJSON = JSON.stringify(entity);
            var applyDtl = JSON.stringify(List);
            var index = 1;

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialApply.ApplyEdit(enJSON, applyDtl);

            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert('<%=Resources.Messages.SaveInSuccess%>');
            parent.window.Refresh();

        }


        //领料数量申请改变
        function ChangeApplyQty(id, t, itemCode) {
            //是否为正整数验证
            var s = $.trim($(t).val());
            var re = /^[1-9]*[1-9][0-9]*$/;
            if (isNaN(s * 1) || s <= 0) {
                alert('请输入大于0的数字');
                $(t).val("");
                $(t).focus();
                return false;
            }
            //BirongLiang 2017-3-6
            var orderQty = $(t).parent().parent().find(".OrderQty").html(); //工单需求量
            var haveQty = $(t).parent().parent().find(".HaveQty").html(); //已备数量
            if (parseFloat(s) > orderQty * 1 - haveQty * 1) {
                alert("领料数量大于工单数量");
                return false;
            }

            //修改值    
            console.log(List)
            console.log(id)
            $.grep(List, function (o, j) {
                //bug    BirongLiang2017-7-10
                //if (o.MODtlId == id && o.MODtlNo == No && o.ItemCode == itemCode) {
                if (o.ApplyDtlId == id && o.ItemCode == itemCode) {
                    o.ApplyQty = s * 1;
                };
            });
        }

        //备注改变
        function ChangeRemark(id, t, itemCode) {
            //修改值
            $.grep(List, function (o, j) {
                if (o.ApplyDtlId == id && o.ItemCode == itemCode) {
                    o.Remark = $.trim($(t).val());
                };
            });
        }

        //删除行操作
        function deleteItem(id, t, itemCode) {
            var index = -1;
            $.grep(List, function (o, j) {
                if (o.ApplyDtlId == id && o.ItemCode == itemCode) {
                    index = j;
                }
            });
            $(t).parent().parent().remove();
            List.splice(index, 1);
        }

        //明细添加
        function addDetail(e, i) {
            row = tableList.insertRow(i + 1);
            row.className = i % 2 == 0 ? "ListTableEvenRow" : "ListTableOddRow";
            cel = row.insertCell(0);
            cel.align = "center";
            cel.className = "Field";
            cel.innerHTML = rowCount;

            //物料编码 
            cel = row.insertCell(1);
            cel.align = "center";
            cel.className = "Field";
            cel.innerHTML = e.ItemCode;
            //物料名称
            cel = row.insertCell(2);
            cel.align = "center";
            cel.className = "Field";
            cel.innerHTML = e.ItemName;
            //工单标准量
            cel = row.insertCell(3);
            cel.align = "center";
            cel.className = "Field OrderQty";
            cel.innerHTML = parseFloat(e.SourceQty);
            //已备料数量
            cel = row.insertCell(4);
            cel.align = "center";
            cel.className = "Field HaveQty";
            cel.innerHTML = e.ActiQty !== '' ? parseFloat(e.ActiQty) : 0;
            //已领未备料数量
            cel = row.insertCell(5);
            cel.align = "center";
            cel.className = "Field";
            cel.innerHTML = parseFloat(e.ApplyQtySum);
            //领料数量
            cel = row.insertCell(6);
            cel.align = "center";
            cel.className = "Field";
            cel.innerHTML = "<input type='text' name='canNumber' IsRequired='1'  style= 'width:70%;'  onchange=\"ChangeApplyQty(" + e.ApplyDtlId + ", this ,'" + e.ItemCode + "')\" value='" + e.ApplyQty + "'/>";
            //当前库存
            cel = row.insertCell(7);
            cel.align = "center";
            cel.className = "Field";
            cel.innerHTML = parseFloat(e.Qty);
            //是否齐套
            cel = row.insertCell(8);
            cel.align = "center";
            cel.className = "Field";
            if (e.ApplyQty > e.Qty) {
                cel.innerHTML = "<span style='color:red'>否</span>";
            }
            else {
                cel.innerHTML = "是";
            }
            //备注
            cel = row.insertCell(9);
            cel.align = "center";
            cel.className = "Field";
            cel.innerHTML = "<input type='text' style= 'width:90%;' maxlength='20' onchange=\"ChangeRemark(" + e.ApplyDtlId + ", this,'" + e.ItemCode + "')\" value ='" + e.Remark + "' />";

            //操作
            var sta = e.Statue;
            if (sta != 0) {//已发料，已接受，已完结，不可再删除
                cel = row.insertCell(10);
                cel.align = "center";
                cel.className = "Field";
                cel.innerHTML = "";
            } else {
                cel = row.insertCell(10);
                cel.align = "center";
                cel.className = "Field";
                cel.innerHTML = "<span style=\"CURSOR: pointer; COLOR: #0000ff;\" onclick=\"deleteItem(" + e.ApplyDtlId + ", this,'" + e.ItemCode + "')\"><%= Resources.Buttons.COM_Delete %></span>";
            }
        }

        //清空表数据
        function clearTableInfo() {
            rowCount = 0;
            List = [];
            $("#tblExpand tr:not(:first)").each(function () {
                $(this).remove();
            });
        }
    </script>
</asp:Content>
