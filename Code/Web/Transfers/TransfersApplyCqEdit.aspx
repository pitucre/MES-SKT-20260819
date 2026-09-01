<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="TransfersApplyCqEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Transfers.TransfersApplyCqEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <table id="FTable" class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">复检单号<em>*<em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtInspectionNo" runat="server" IsRequired='1' CssClass="TextBox" ClientIDMode="Static" Enabled="false"></asp:TextBox>
                <input id="button5" class="ButtonBox" type="button" onclick="selectMollocateInCode()"
                    value="..." title="选择复检单号" />
            </td>
            <td class="Label2">检验结果<em>*<em>
            </td>
            <td class="Field2">
                <select id="selType" onchange="changeType();">
                    <option value="1">不合格</option>
                    <%-- <option value="2">报废</option>--%>
                </select>
            </td>
        </tr>
        <tr>
            <td class="Label2">调拨部门<em>*<em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtDeptName" runat="server" IsRequired='1' CssClass="TextBox" Enabled="false"></asp:TextBox>
                <input id="button2" class="ButtonBox" type="button" onclick="openChoosePage()" value="..." />
                <asp:HiddenField ID="hdnDeptID" runat="server" Value="-1" />
            </td>
            <td class="Label2">补充说明&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtRemark" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">调入仓库<em>*<em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtInWhName" runat="server" IsRequired='1' CssClass="TextBox" Enabled="false"></asp:TextBox>
                <input type="button" id="scanPos" class="ButtonBox" value="..." style="font-weight: bold; text-transform: uppercase;"
                    onclick="selectInWhCodeList()" />
                <asp:HiddenField ID="txtInWhCode" runat="server" Value="-1" />
            </td>
            <td class="Label2">调出仓库<em>*<em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtOutWhName" runat="server" IsRequired='1' CssClass="TextBox" Enabled="false"></asp:TextBox>
                <input type="button" id="Button1" class="ButtonBox" value="..." style="font-weight: bold; text-transform: uppercase;"
                    onclick="selectOutWhCodeList()" />
                <asp:HiddenField ID="txtOutWhCode" runat="server" Value="-1" />
            </td>
        </tr>
        <tr>

            <td class="Label2">NG数量<em>*<em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtQty" runat="server" IsRequired='1' CssClass="TextBox" ClientIDMode="Static" Enabled="false"></asp:TextBox>
            </td>
            <td class="Label2">
                <%--  物料编码<em>*<em>--%>
            </td>
            <td class="Field2">
                <%--<asp:TextBox ID="txtItemCode" runat="server" IsRequired='1' CssClass="TextBox" ClientIDMode="Static" Enabled="false"></asp:TextBox>--%>
            </td>
        </tr>
    </table>
    <table id="tblExpand" cellspacing="0" cellpadding="4" style="border-width: 0px; width: 100%; border-collapse: collapse; margin-top: 5px;"
        class="EditeContentTable">
        <tr class="ListTableHeader">
            <th scope="col" style="width: 40px;">序号
            </th>
            <th scope="col" style="width: 110px;">物料编码
            </th>
            <th scope="col">物料名称
            </th>
            <th scope="col" style="width: 150px;">调入仓库
            </th>
            <th scope="col" style="width: 150px;">调出仓库
            </th>
            <th scope="col" style="width: 60px;">调拨数量<em>*<em>
            </th>
            <th scope="col" style="width: 200px;">备注
            </th>
        </tr>
    </table>
    <asp:HiddenField ID="hdnFormSource" runat="server" Value="" />
    <input type="hidden" value="" id="hdnPararms" name="hdnPararms" />
    <input type="hidden" value="" id="hdnPararmValue" name="hdnPararmValue" />
    <input type="hidden" value="" id="hdnOperation" name="hdnOperation" />
    <input type="hidden" value="" id="hdnFileName" name="hdnFileName" />
    <script type="text/javascript">
        var transfersId = '<%=Request.QueryString["ID"]%>'; //编辑时传过来的ID
        //物料列表
        var List = [];
        var rowCount = 0;
        var okQty = 0;
        var ngQty = 0;
        var hdnInspectionId = 0;
        var curOpenPageElement = null;
        $(function () {
            //编辑模式显示对应的信息
            if (transfersId != '-1') {
                showMoallocateDetailInfo(transfersId);
            }
        });

        //复检单信息
        function selectMollocateInCode() {
            dialog({
                title: "复检单信息",
                src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=803&Multiple=true&CallBackFunc=setInvCode&rnd=" + Math.random(), width: 600, height: 400
            });
        }

        //存货编码返回值
        function setInvCode(list) {
            var have = 0;
            if (list.length <= 0) {
                return;
            }
            if (list[0][0] != "-1") {
                $("#<%=this.txtInspectionNo.ClientID%>").val(list[0][1]);
                    <%--         $("#<%=this.txtItemCode.ClientID%>").val(list[0][2]);--%>
                    ngQty = list[0][2];
                    okQty = list[0][3];
                    hdnInspectionId = list[0][0];
                    $("#<%=this.txtQty.ClientID%>").val(ngQty);
                if ($.trim(list[0][5]) == "")
                {
                    $("#<%=this.txtOutWhName.ClientID %>").val("");
                    $("#<%=this.txtOutWhCode.ClientID%>").val("");
                }
                else{
                    $("#<%=this.txtOutWhName.ClientID %>").val(list[0][4] + "(" + list[0][5] + ")");
                    $("#<%=this.txtOutWhCode.ClientID%>").val(list[0][5]);
                }
                //选择复检单后，不合格的明细显示
                //先清空
                rowCount = 0;
                List = [];
                $("#txtItemCode").val("");
                $("#<%=this.txtRemark.ClientID %>").val("");
                $("#tblExpand tr:not(:first)").each(function () {
                    $(this).remove();
                });
                //后添加显示
                var entity = {};
                entity.ReinspectionNo = list[0][1]; //复检单号
                var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("upsGetReinspectionDtlByNo", JSON.stringify(entity));
                var en = $.parseJSON(ajax.value);
                List = en.data;
                for (var i = 0; i < List.length; i++) {
                    rowCount++;
                    List[i].TransfersDtlId = -1;
                    List[i].InWhouse = "";
                    List[i].OutWhouse = "";
                    List[i].RowCount = rowCount;
                    addDetail(List[i], i);
                }
            }
        }
        function changeType() {
            var selType = $("#selType").val();
            if (selType == 1) {
                $("#<%=this.txtQty.ClientID%>").val(ngQty);
            }
            if (selType == 2) {
                $("#<%=this.txtQty.ClientID%>").val(scrapQty);
            }
            if (selType == 0) {
                $("#<%=this.txtQty.ClientID%>").val(okQty);
            }
        }

        //编辑时显示子件明细
        var tableList = document.getElementById("tblExpand");
        function showMoallocateDetailInfo(transfersId) {
            var entity = {};
            entity.TransfersId = transfersId; //调拨单ID
            var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("upsGetTransfersById", JSON.stringify(entity));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            var en = $.parseJSON(ajax.value);
            //表头添加
            if (en.data != null && en.data.length > 0) {
                $("#button5").attr("disabled", "disabled");
                $("#selType").attr("disabled", "disabled");
                $("#<%=this.txtInspectionNo.ClientID%>").val(en.data[0].SourceNo);
                $("#<%=this.txtRemark.ClientID%>").val(en.data[0].Remark);
                $("#<%=this.txtDeptName.ClientID %>").val(en.data[0].DepartName + "(" + en.data[0].DepCode + ")");
                $("#<%=this.hdnDeptID.ClientID%>").val(en.data[0].DepCode); //部门编码
                $("#<%=this.txtInWhName.ClientID %>").val(en.data[0].InWhName + "(" + en.data[0].InWhouse + ")");
                $("#<%=this.txtInWhCode.ClientID%>").val(en.data[0].InWhouse);
                $("#<%=this.txtOutWhName.ClientID %>").val(en.data[0].OutWhName + "(" + en.data[0].OutWhouse + ")");
                $("#<%=this.txtOutWhCode.ClientID%>").val(en.data[0].OutWhouse);
            }
            //表身
            List = en.data1;
            for (var i = 0; i < List.length; i++) {
              <%--  $("#<%=this.txtItemCode.ClientID%>").val(List[0].ItemCode);--%>
                $("#<%=this.txtQty.ClientID%>").val(List[0].ApplyQty);
                var selType = List[0].SourceDtlId;
                $("#selType").val(selType);
                rowCount++;
                List[i].RowCount = rowCount;
                addDetail(List[i], i);
            }
        }

        //明细显示
        function addDetail(e, i) {
            row = tableList.insertRow(i + 1);
            row.className = i % 2 == 0 ? "ListTableEvenRow" : "ListTableOddRow";
            $(row).data(e);
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

            
            //调入仓库
            cel = row.insertCell(3);
            cel.align = "center";
            cel.className = "Field";
            cel.innerHTML = "<input type='text' name='inWhouse'  style= 'width:70%;' value='" + (e.InWhouse ? e.InWhName + "(" + e.InWhouse + ")" : "") + "' readonly='true' /> <input type='button' value='...' class='ButtonBox' onclick='selectDetailInWhCodeList(this)' />";

            //调出仓库
            cel = row.insertCell(4);
            cel.align = "center";
            cel.className = "Field";
            cel.innerHTML = "<input type='text' name='outWhouse'  style= 'width:70%;' value='" + (e.OutWhouse ? e.OutWhName + "(" + e.OutWhouse + ")" : "") + "' readonly='true' /> <input type='button' value='...' class='ButtonBox' onclick='selectDetailOutWhCodeList(this)' />";

            //调拨数量
            cel = row.insertCell(5);
            cel.align = "center";
            cel.className = "Field";
            cel.innerHTML = e.ApplyQty;


            //备注
            cel = row.insertCell(6);
            cel.align = "center";
            cel.className = "Field";
            cel.innerHTML = e.Remark;

        }

        //保存
        function Save() {
            var qty = $.trim($("#<%=this.txtQty.ClientID%>").val());
            if (qty == "") {
                alert("数量不能为空");
                return;
            } if (qty > 0) {
            } else {
                alert("数量必须大于0");
                return;
            }
            if ($("#<%=this.txtInWhCode.ClientID%>").val() == $("#<%=this.txtOutWhCode.ClientID%>").val()) {
                alert("【调入仓库】和【调出仓库】不能一致！");
                return false;
            }

            var isCheck = true;
            $.each(List, function (j, o) {
                if (o.InWhouse != "" && o.InWhouse == o.OutWhouse) {
                    alert("物料明细的【调入仓库】和【调出仓库】不能一致！");
                    isCheck = false;
                    return false;
                };
            });
            if (!isCheck) return false;

            var entity = {};
            entity.TransfersId = transfersId; //调拨单ID，新增时为-1
            entity.SourceNo = $.trim($("#<%=this.txtInspectionNo.ClientID%>").val());; //来源单号
            entity.DepCode = $("#<%=this.hdnDeptID.ClientID%>").val();
            entity.Remark = $("#<%=this.txtRemark.ClientID %>").val(); //主表备注
            entity.CreateBy = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>"; //制单人
            entity.InWhouse = $("#<%=this.txtInWhCode.ClientID%>").val(); //调入仓库
            entity.OutWhouse = $("#<%=this.txtOutWhCode.ClientID%>").val(); //调出仓库
            entity.ApplyType = $("#selType").val(); //类型(1-不合格，2-报废，-合格)
            entity.ItemList = JSON.stringify(List);
            entity.TempColumns = "ItemList";
            var ajax = SKT.AjaxCommon.DBService.ExcuteSpcByTemp("Prod_TransfersCQ_Edit", JSON.stringify(entity));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert('<%=Resources.Messages.SaveInSuccess%>');
            parent.window.Refresh();
        }

        //调拨部门
        function openChoosePage() {
            dialog({
                title: "部门列表",
                src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=13&Multiple=true&CallBackFunc=setDepCode&rnd=" + Math.random(), width: 800, height: 400
            });
        }
        function setDepCode(list) {
            if (list[0][0] == "-1") {
                $("#<%=this.txtDeptName.ClientID %>").val("");
                $("#<%=this.hdnDeptID.ClientID%>").val("");
            }
            else {
                $("#<%=this.txtDeptName.ClientID %>").val(list[0][2] + "(" + list[0][1] + ")");
                $("#<%=this.hdnDeptID.ClientID%>").val(list[0][1]); //部门编码
            }
        }

        //选择仓库
        function selectInWhCodeList() {
                dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=14&Multiple=false&CallBackFunc=setInWhCode&rnd=" + Math.random(), width: 500, height: 300 });
        }
        function setInWhCode(list) {
            var whCodes = list[0][2] + "(" + list[0][1] + ")";
            if (list[0][0] == "-1") {
                whCodes = "";
            }
            $("#<%=this.txtInWhName.ClientID%>").val(whCodes);
            $("#<%=this.txtInWhCode.ClientID%>").val(list[0][1]);
        }
        //选择仓库
        function selectOutWhCodeList() {
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=14&Multiple=false&CallBackFunc=setOutWhCode&rnd=" + Math.random(), width: 500, height: 300 });
        }
        function setOutWhCode(list) {
            var whCodes = list[0][2] + "(" + list[0][1] + ")";
            if (list[0][0] == "-1") {
                whCodes = "";
            }
            $("#<%=this.txtOutWhName.ClientID%>").val(whCodes);
            $("#<%=this.txtOutWhCode.ClientID%>").val(list[0][1]);
        }

        //选择明细调入仓库
        function selectDetailInWhCodeList(element) {
            curOpenPageElement = element;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=14&Multiple=false&CallBackFunc=setDetailInWhCode&rnd=" + Math.random(), width: 500, height: 300 });
        }
        function setDetailInWhCode(list) {
            var whCodes = list[0][2] + "(" + list[0][1] + ")";
            if (list[0][0] == "-1") {
                whCodes = "";
            }
            if (curOpenPageElement) {
                var $inWhouse = $(curOpenPageElement).prev();
                var $row = $inWhouse.parent().parent();
                var rowNum = $row.data().RowCount;
                $inWhouse.val(whCodes);
                //修改值
                $.each(List, function (j, o) {
                    if (o.RowCount == rowNum) {
                        o.InWhouse = $.trim(list[0][1]);
                        return false;
                    };
                });
                //主表未设置调入仓库时，默认明细调入仓库
                var $mainInWhouseName = $("#<%=this.txtInWhName.ClientID%>");
                var $mainInWhouseCode = $("#<%=this.txtInWhCode.ClientID%>");
                if (!$mainInWhouseName.val()) {
                    $mainInWhouseName.val(whCodes);
                    $mainInWhouseCode.val(list[0][1]);
                }
            }
        }

         //选择明细调出仓库
        function selectDetailOutWhCodeList(element) {
            curOpenPageElement = element;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=14&Multiple=false&CallBackFunc=setDetailOutWhCode&rnd=" + Math.random(), width: 500, height: 300 });
        }
        function setDetailOutWhCode(list) {
            var whCodes = list[0][2] + "(" + list[0][1] + ")";
            if (list[0][0] == "-1") {
                whCodes = "";
            }
            if (curOpenPageElement) {
                var $outWhouse = $(curOpenPageElement).prev();
                var $row = $outWhouse.parent().parent();
                var rowNum = $row.data().RowCount;
                $outWhouse.val(whCodes);
                //修改值
                $.each(List, function (j, o) {
                    if (o.RowCount == rowNum) {
                        o.OutWhouse = $.trim(list[0][1]);
                        return false;
                    };
                });
                //主表未设置调出仓库时，默认明细调出仓库
                var $mainOutWhouseName = $("#<%=this.txtOutWhName.ClientID%>");
                var $mainOutWhouseCode = $("#<%=this.txtOutWhCode.ClientID%>");
                if (!$mainOutWhouseName.val()) {
                    $mainOutWhouseName.val(whCodes);
                    $mainOutWhouseCode.val(list[0][1]);
                }
            }
        }
    </script>
</asp:Content>

