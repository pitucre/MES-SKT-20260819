<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="TransfersApplySaleEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Transfers.TransfersApplySaleEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <table id="FTable" class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">
                销售订单号<em>*<em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtMoCode" runat="server" IsRequired='1' CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
                <input id="button2" class="ButtonBox" type="button" onclick="selectMoallocateList()"
                    value="..." title="销售订单号" />
            </td>
            <td class="Label2">
                物料编码
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtItemCode" runat="server" CssClass="TextBox" ClientIDMode="Static"
                    Enabled="false"></asp:TextBox>
                <input id="button5" class="ButtonBox" type="button" onclick="selectMollocateInCode()"
                    value="..." title="选择物料编码" />
            </td>
        </tr>
        <tr>
            <td class="Label2">
                销售订单类型
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtSaleType" runat="server" CssClass="TextBox" ClientIDMode="Static" Enabled="false"></asp:TextBox>
                <input id="button1" class="ButtonBox" type="button" onclick="selectSaleType()"
                    value="..." title="销售订单类型" />
                <asp:HiddenField ID="txtSaleTypeId" runat="server" Value="-1" ClientIDMode="Static" />
            </td>
            <td class="Label2">
                承运商
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtVendor" runat="server" CssClass="TextBox" ClientIDMode="Static"
                    Enabled="false"></asp:TextBox>
                <input id="button3" class="ButtonBox" type="button" onclick="selectVendor()"
                    value="..." title="承运商" />
                <asp:HiddenField ID="txtVendorId" runat="server" Value="-1" ClientIDMode="Static" />
            </td>
        </tr>
        <tr>
            <td class="Label2">
                运输方式
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtTransportType" runat="server" CssClass="TextBox" ClientIDMode="Static" Enabled="false"></asp:TextBox>
                <input id="button4" class="ButtonBox" type="button" onclick="selectTransportType()"
                    value="..." title="运输方式" />
                <asp:HiddenField ID="txtTransportTypeId" runat="server" Value="-1" ClientIDMode="Static" />
            </td><td class="Label2">
                调拨部门<em>*<em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtDeptName" runat="server" IsRequired='1' CssClass="TextBox" Enabled="false"></asp:TextBox>
                <input id="button6" class="ButtonBox" type="button" onclick="openChoosePage()"
                    value="..." />
                <asp:HiddenField ID="hdnDeptID" runat="server" Value="-1" />
            </td>
        </tr>
        <tr>
            <td class="Label2">
                调入仓库<em>*<em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtInWhName" runat="server" IsRequired='1' CssClass="TextBox" Enabled="false"></asp:TextBox>
                <input type="button" id="scanPos" class="ButtonBox" value="..." style="font-weight: bold;
                    text-transform: uppercase;" onclick="selectInWhCodeList()" />
                <asp:HiddenField ID="txtInWhCode" runat="server" Value="-1" />
            </td>
            <td class="Label2">
                调出仓库<em>*<em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtOutWhName" runat="server" IsRequired='1' CssClass="TextBox" Enabled="false"></asp:TextBox>
                <input type="button" id="Button7" class="ButtonBox" value="..." style="font-weight: bold;
                    text-transform: uppercase;" onclick="selectOutWhCodeList()" />
                <asp:HiddenField ID="txtOutWhCode" runat="server" Value="-1" />
            </td>        
        </tr>
        <tr>
            <td class="Label2">
                选择全部物料
            </td>
            <td class="Field2">
                <input id="selAllMaterial" type="checkbox" onclick="selAllMaterialClick()" />
            </td>
            <td class="Label2">
                预计到货日期
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtArrivalDate" runat="server" CssClass="DateTimeBox" ClientIDMode="Static"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                补充说明
            </td>
            <td class="Field2" colspan="3">
                <asp:TextBox ID="txtRemark" runat="server" CssClass="TextBox" ClientIDMode="Static" Width="300px"></asp:TextBox>
            </td>        
        </tr>
    </table>
    <table id="tblExpand" cellspacing="0" cellpadding="4" style="border-width: 0px; width: 100%;
        border-collapse: collapse; margin-top: 5px;" class="EditeContentTable">
        <tr class="ListTableHeader">
            <th scope="col" style="width: 40px;">
                序号
            </th>
            <th scope="col" style="width: 110px;">
                物料编码
            </th>
            <th scope="col">
                物料名称
            </th>
            <th scope="col" style="width: 60px;">
                调拨数量<em>*<em>
            </th>
            <th scope="col" style="width: 200px;">
                备注
            </th>
            <th scope="col" style="color: #0066CC; cursor: pointer; width: 60px;">
                操作
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
        _minDate = 0;
        //物料列表
        var List = [];
        var rowCount = 0;
        $(function () {
            /*扫描销售订单号*/
            $("#txtMoCode").keydown(function () {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    if ($.trim($("#txtMoCode").val()) != "") {
                        var en = {};
                        en.MOCode = $.trim($("#txtMoCode").val());
                        var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("upsSaleTransfersCheck", JSON.stringify(en));
                        if (ajax.error != null) {
                            alert(ajax.error.Message);
                            $("#txtMoCode").val("");
                            clearTableInfo();
                            return false;
                        }
                        var en = $.parseJSON(ajax.value).data;
                        if (en[0]) {
                        }
                        return false;
                    }
                }
            });
            //编辑模式显示对应的信息
            if (transfersId != '-1') {
                $("#txtMoCode").attr("disabled", "disabled");
                $("#button2").attr("disabled", "disabled");
                showMoallocateDetailInfo(transfersId);
            }
        });
        //选中销售订单
        function selectMoallocateList() {
            dialog({ title: "<%=Resources.Common.ChooseWindow %>",
                src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=110&Multiple=false&rnd=" + Math.random(), width: 700, height: 400
            });
        }
        //销售订单返回的值
        function getChooseValue(list) {
            clearTableInfo(); //清空表数据
            $("#txtMoCode").val(list[0][1]);
        }

        //选择物料编码
        function selectMollocateInCode() {
            var searchCondition = "";
            var txtMoCode = $.trim($("#txtMoCode").val());
            if (txtMoCode == "") {
                alert("请选择销售订单号");
                return false;
            }
            if (txtMoCode != "") {
                searchCondition = " Code  ='" + txtMoCode + "' ";
            }
            dialog({ title: "物料信息",
                src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=111&PageCondition="
                + escape(searchCondition) + "&Multiple=true&CallBackFunc=setInvCode&rnd=" + Math.random(), width: 800, height: 400
            });
        }

        //选择全部物料
        function selAllMaterialClick() {
            var txtMoCode = $("#txtMoCode").val();
            if ($.trim(txtMoCode) == "") {
                alert("请选择销售订单号");
                $("#selAllMaterial").attr("checked", false);
                return;
            }
            if ($("#selAllMaterial").attr("checked") != "checked") {
                return;
            }
            $("#txtItemCode").val("");
            var entity = {};
            entity.Code = txtMoCode; //来源单号
            var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspGetSaleTransfersAllItem", JSON.stringify(entity));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var en = $.parseJSON(ajax.value).data;
            for (var i = 0; i < en.length; i++) {
                var have = 0;
                $.grep(List, function (o, j) {
                    if (o.ItemCode == en[i].ItemCode) {
                        have = 1;
                        return;
                    };
                });
                if (have == 0) {
                    rowCount++;
                    var e = {};
                    e.SourceDtlId = en[i].AutoID;
                    e.ItemCode = en[i].ItemCode;
                    e.ItemName = en[i].ItemName;
                    e.ApplyQty = 0;
                    e.Remark = '';
                    addDetail(e, List.length);
                    List.push(e);
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
                        if (o.ItemCode == list[i][1]) {
                            have = 1;
                            return;
                        };
                    });
                    if (have == 0) {
                        rowCount++;
                        var e = {};
                        e.SourceDtlId = list[i][0];
                        e.ItemCode = list[i][1];
                        e.ItemName = list[i][2];
                        e.ApplyQty = 0;
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
        //编辑时显示子件明细
        var tableList = document.getElementById("tblExpand");
        function showMoallocateDetailInfo(transfersId) {
            $("#tblExpand tr:not(:first)").each(function () {
                $(this).remove();
            });
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
                $("#txtMoCode").attr("disabled", "disabled");
                $("#button2").attr("disabled", "disabled");
                $("#<%=this.txtRemark.ClientID%>").val(en.data[0].Remark);
                $("#<%=this.txtMoCode.ClientID%>").val(en.data[0].SourceNo);
                $("#<%=this.txtSaleType.ClientID%>").val(en.data[0].SaleTypeName);
                $("#<%=this.txtSaleTypeId.ClientID%>").val(en.data[0].SaleType);
                $("#<%=this.txtVendor.ClientID%>").val(en.data[0].VendorName);
                $("#<%=this.txtVendorId.ClientID%>").val(en.data[0].VendorId);
                $("#<%=this.txtTransportType.ClientID%>").val(en.data[0].TransportTypeName);
                $("#<%=this.txtTransportTypeId.ClientID%>").val(en.data[0].TransportType);
                $("#<%=this.txtDeptName.ClientID %>").val(en.data[0].DepartName + "(" + en.data[0].DepCode + ")");
                $("#<%=this.hdnDeptID.ClientID%>").val(en.data[0].DepCode); //部门编码
                $("#<%=this.txtArrivalDate.ClientID%>").val(en.data[0].ArrivalDate); //部门编码
                $("#<%=this.txtInWhName.ClientID %>").val(en.data[0].InWhName + "(" + en.data[0].InWhouse + ")");
                $("#<%=this.txtInWhCode.ClientID%>").val(en.data[0].InWhouse);
                $("#<%=this.txtOutWhName.ClientID %>").val(en.data[0].OutWhName + "(" + en.data[0].OutWhouse + ")");
                $("#<%=this.txtOutWhCode.ClientID%>").val(en.data[0].OutWhouse); 
            }
            //表身
            List = en.data1;
            for (var i = 0; i < List.length; i++) {
                rowCount++;
                addDetail(List[i], i);
            }
        }

        //保存
        function Save() {
            var txtMoCode = $.trim($("#txtMoCode").val());
            if (txtMoCode == "") {
                alert("请先选择销售订单号");
                return false;
            }
            //已添加项
            if (List.length == 0) {
                alert("请先添加物料明细");
                return false;
            }
            var index = 1;
            $.grep(List, function (o, j) {
                if (isNaN(o.ApplyQty) || o.ApplyQty == 0) {
                    index = 0;
                };
            });
            if (index == 0) {
                alert("调拨数量必须大于0");
                return;
            }
            var entity = {};
            entity.TransfersId = transfersId; //调拨单ID，新增时为-1
            entity.TransfersType = 2; //调拨类型
            entity.SourceNo = txtMoCode; //来源单号
            entity.SaleType = $("#txtSaleTypeId").val(); //销售订单类型
            entity.VendorId = $("#txtVendorId").val(); //承运商
            entity.TransportType = $("#txtTransportTypeId").val(); //运输方式
            entity.DepCode = $("#<%=this.hdnDeptID.ClientID%>").val();
            entity.Remark = $("#<%=this.txtRemark.ClientID %>").val(); //主表备注
            entity.CreateBy = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserId %>"; //制单人
            entity.ArrivalDate = $("#<%=this.txtArrivalDate.ClientID %>").val(); //使用日期
            entity.InWhouse = $("#<%=this.txtInWhCode.ClientID%>").val(); //调入仓库
            entity.OutWhouse = $("#<%=this.txtOutWhCode.ClientID%>").val(); //调出仓库
            entity.ItemList = JSON.stringify(List);
            entity.TempColumns = "ItemList";
            var ajax = SKT.AjaxCommon.DBService.ExcuteSpcByTemp("Prod_Transfers_Edit", JSON.stringify(entity));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert('<%=Resources.Messages.SaveInSuccess%>');
            parent.window.Refresh();
        }

        //领料数量申请改变
        function ChangeApplyQty(itemCode, t) {
            //是否为正整数验证
            var s = $.trim($(t).val());
            if (isNaN(s) || s == 0) {
                alert("请输入大于0的数字");
                $(t).val("");
                $(t).focus();
                return;
            }
            //修改值
            $.grep(List, function (o, j) {
                if (o.ItemCode == itemCode) {
                    o.ApplyQty = s;
                };
            });
        }

        //备注改变
        function ChangeRemark(itemCode, t) {
            //修改值
            $.grep(List, function (o, j) {
                if (o.ItemCode == itemCode) {
                    o.Remark = $.trim($(t).val());
                };
            });
        }

        //删除行操作
        function deleteItem(itemCode, t) {
            var index = -1;
            $.grep(List, function (o, j) {
                if (o.ItemCode == itemCode) {
                    index = j;
                }
            });
            $(t).parent().parent().remove();
            List.splice(index, 1);
            rowCount--;
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

            //领料数量
            cel = row.insertCell(3);
            cel.align = "center";
            cel.className = "Field";
            cel.innerHTML = "<input type='text' name='canNumber' IsRequired='1'  style= 'width:70%;' onchange=\"ChangeApplyQty('" + e.ItemCode + "', this)\" value='" + e.ApplyQty + "'/>";

            //备注
            cel = row.insertCell(4);
            cel.align = "center";
            cel.className = "Field";
            cel.innerHTML = "<input type='text'  style= 'width:90%;' onchange=\"ChangeRemark('" + e.ItemCode + "', this)\" value ='" + e.Remark + "' />";

            //操作
            cel = row.insertCell(5);
            cel.align = "center";
            cel.className = "Field";
            cel.innerHTML = "<span style=\"CURSOR: pointer; COLOR: #0000ff;\" onclick=\"deleteItem('" + e.ItemCode + "', this)\"><%= Resources.Buttons.COM_Delete %></span>";
        }

        //清空表数据
        function clearTableInfo() {
            rowCount = 0;
            List = [];
            $("#txtMoCode").val("");
            $("#txtItemCode").val("");
            $("#<%=this.txtRemark.ClientID %>").val("");
            $("#selAllMaterial").attr("checked", false);
            $("#tblExpand tr:not(:first)").each(function () {
                $(this).remove();
            });
        }
        
        //选中销售订单类型
        function selectSaleType() {
            dialog({ title: "<%=Resources.Common.ChooseWindow %>",
                src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=112&Multiple=false&CallBackFunc=setSaleType&rnd=" + Math.random(), width: 700, height: 400
            });
        }
        //销售订单类型返回的值
        function setSaleType(list) {
            $("#txtSaleType").val(list[0][2]);
            $("#txtSaleTypeId").val(list[0][1]);
        }

        //选中承运商
        function selectVendor() {
            dialog({ title: "<%=Resources.Common.ChooseWindow %>",
                src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=113&Multiple=false&CallBackFunc=setVendor&rnd=" + Math.random(), width: 700, height: 400
            });
        }
        //承运商返回的值
        function setVendor(list) {
            $("#txtVendor").val(list[0][2]);
            $("#txtVendorId").val(list[0][1]);
        }

        //选中运输方式
        function selectTransportType() {
            dialog({ title: "<%=Resources.Common.ChooseWindow %>",
                src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=114&Multiple=false&CallBackFunc=setTransportType&rnd=" + Math.random(), width: 700, height: 400
            });
        }
        //运输方式返回的值
        function setTransportType(list) {
            $("#txtTransportType").val(list[0][2]);
            $("#txtTransportTypeId").val(list[0][1]);
        }
        //调拨部门
        function openChoosePage() {
            dialog({ title: "部门列表",
                src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=13&Multiple=true&CallBackFunc=setDepCode&rnd=" + Math.random(), width: 800, height: 400
            });
        }
        function setDepCode(list) {
            $("#<%=this.txtDeptName.ClientID %>").val(list[0][2] + "(" + list[0][1] + ")");
            $("#<%=this.hdnDeptID.ClientID%>").val(list[0][1]); //部门编码
        }
        //选择仓库
        function selectInWhCodeList() {
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=14&Multiple=false&CallBackFunc=setInWhCode&rnd=" + Math.random(), width: 500, height: 300 });
        }
        function setInWhCode(list) {
            var whCodes = list[0][1] + "|" + list[0][2];
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
            var whCodes = list[0][1] + "|" + list[0][2];
            if (list[0][0] == "-1") {
                whCodes = "";
            }
            $("#<%=this.txtOutWhName.ClientID%>").val(whCodes);
            $("#<%=this.txtOutWhCode.ClientID%>").val(list[0][1]);
        }
    </script>
</asp:Content>


