<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="TransfersApplyPoEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Transfers.TransfersApplyPoEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <table id="FTable" class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">委外订单号<em>*<em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtMoCode" runat="server" IsRequired='1' CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
                <input id="button2" class="ButtonBox" type="button" onclick="selectMoallocateList()"
                    value="..." title="委外订单号" />
                <asp:HiddenField ID="hdnMoId" runat="server" Value="-1" ClientIDMode="Static" />
            </td>
            <td class="Label2">物料编码
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtItemCode" runat="server" CssClass="TextBox" ClientIDMode="Static"
                    Enabled="false"></asp:TextBox>
                <input id="button5" class="ButtonBox" type="button" onclick="selectMollocateInCode()"
                    value="..." title="选择物料编码" />
                <asp:HiddenField ID="hdnAllocateIdStr" runat="server" Value="" ClientIDMode="Static" />
            </td>
        </tr>
        <tr>
            <td class="Label2">调拨部门<em>*<em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtDeptName" runat="server" IsRequired='1' CssClass="TextBox" Enabled="false"></asp:TextBox>
                <input id="button1" class="ButtonBox" type="button" onclick="openChoosePage()"
                    value="..." />
                <asp:HiddenField ID="hdnDeptID" runat="server" Value="-1" />
            </td>
            <td class="Label2">补充说明
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
                <input type="button" id="Button3" class="ButtonBox" value="..." style="font-weight: bold; text-transform: uppercase;"
                    onclick="selectOutWhCodeList()" />
                <asp:HiddenField ID="txtOutWhCode" runat="server" Value="-1" />
            </td>
        </tr>
        <tr>
            <td class="Label2">选择全部物料
            </td>
            <td class="Field2">
                <input id="selAllMaterial" type="checkbox" onclick="selAllMaterialClick()" />
            </td>
        </tr>
    </table>
    <table id="tblExpand" cellspacing="0" cellpadding="4" style="border-width: 0px; width: 100%; border-collapse: collapse; margin-top: 5px;"
        class="EditeContentTable">
        <tr class="ListTableHeader">
            <th scope="col" align="center" style="width: 40px;">
                <input type="checkbox" id="CheckedAll" />
            </th>
            <%--<th scope="col" style="width: 40px;">
                序号
            </th>--%>
            <th scope="col" style="width: 110px;">物料编码
            </th>
            <th scope="col">物料名称
            </th>
            <th scope="col" style="width: 100px;">调入仓库
            </th>
            <th scope="col" style="width: 100px;">调出仓库
            </th>
            <th scope="col" style="width: 60px;">标准用量
            </th>
            <th scope="col" style="width: 60px;">已申请数量
            </th>
            <th scope="col" style="width: 60px;">调拨数量<em>*<em>
            </th>
            <th scope="col" style="width: 150px;">备注
            </th>
            <th scope="col" style="color: #0066CC; cursor: pointer; width: 60px;">操作
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
        $(function () {
            /*扫描委外订单号*/
            //$("#txtMoCode").keydown(function () {
            //    var curKey = 0, e = e || window.event;
            //    curKey = e.keyCode || e.which || e.charCode;
            //    if (curKey == 13) {
            //        if ($.trim($("#txtMoCode").val()) != "") {
            //            var e = {}, conList = [];
            //            e.name = "MOCode";
            //            e.value = $.trim($("#txtMoCode").val());
            //            conList.push(e);
            //            var ajax = SKT.AjaxCommon.DBService.GetViewList("vwMaterialApplyWWSelMO", JSON.stringify(conList));
            //            if (ajax.error != null) {
            //                alert(ajax.error.Message);
            //                $("#txtMoCode").val("");
            //                $("#hdnMoId").val("");
            //                clearTableInfo();
            //                $("#txtMoCode").focus();
            //                return false;
            //            }
            //            var en = $.parseJSON(ajax.value).data;
            //            if (en == null || en[0] == null) {
            //                alert("委外订单不存在");
            //                $("#txtMoCode").val("");
            //                $("#hdnMoId").val("");
            //                clearTableInfo();
            //                $("#txtMoCode").focus();
            //                return false;
            //            }
            //            return false;
            //        }
            //    }
            //});
            //编辑模式显示对应的信息
            if (transfersId != '-1') {
                $("#txtMoCode").attr("disabled", "disabled");
                $("#button2").attr("disabled", "disabled");
                showMoallocateDetailInfo(transfersId);
            }
        });
        //选中委外订单
        function selectMoallocateList() {
            dialog({
                title: "<%=Resources.Common.ChooseWindow %>",
                src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=103&Multiple=false&rnd=" + Math.random(), width: 700, height: 400
            });
        }
        //委外订单返回的值
        function getChooseValue(list) {
            clearTableInfo(); //清空表数据
            $("#txtMoCode").val(list[0][1]);
        }

        //选择物料编码
        function selectMollocateInCode() {
            var searchCondition = "";
            var txtMoCode = $.trim($("#txtMoCode").val());
            if (txtMoCode == "") {
                alert("请选择委外订单号");
                return false;
            }
            if (txtMoCode != "") {
                searchCondition = "  POCode='" + txtMoCode + "' ";
            }
            else {
                searchCondition = "";
            }

            dialog({
                title: "物料信息",
                src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=203&PageCondition="
              + escape(searchCondition) + "&Multiple=true&CallBackFunc=setInvCode&rnd=" + Math.random(), width: 800, height: 400
          });

          }

          //选择全部物料
          function selAllMaterialClick() {
              var txtMoCode = $("#txtMoCode").val();
              if ($.trim(txtMoCode) == "") {
                  alert("请选择委外订单号");
                  $("#selAllMaterial").attr("checked", false);
                  return;
              }
              if ($("#selAllMaterial").attr("checked") != "checked") {
                  return;
              }
              $("#txtItemCode").val("");

 
              var entity = {};
              entity.POCode = txtMoCode; //委外订单号
              var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspGetTransfersApplySelItem", JSON.stringify(entity));
              if (ajax.error != null) {
                  alert(ajax.error.Message);
                  return false;
              }
              var en = $.parseJSON(ajax.value).data;
              for (var i = 0; i < en.length; i++) {
                  var have = 0;
                  if (have == 0) {
                      rowCount++;
                      var e = {};
                      e.TransfersDtlId = -1;
                      e.ItemCode = en[i].ItemCode;
                      e.SourceDtlId = en[i].AutoID;
                      e.ItemName = en[i].ItemName;
                      e.ApplyQty = 0;
                      e.AuxQtyMust = en[i].AuxQtyMust;
                      e.ApplyQtySum = en[i].ApplyQtySum;
                      var applyQty = 0;
                      if (parseFloat(en[i].AuxQtyMust) - parseFloat(en[i].ApplyQtySum) > 0) {
                          applyQty = parseFloat(en[i].AuxQtyMust) - parseFloat(en[i].ApplyQtySum);
                      }
                      e.ApplyQty = applyQty;
                      e.Remark = '';
                      e.InWhouse = "";
                      e.OutWhouse = "";
                      e.RowCount = rowCount;
                      addDetail(e, List.length, 0);
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
                      if (have == 0) {
                          rowCount++;
                          var e = {};
                          e.TransfersDtlId = -1;
                          e.SourceDtlId = list[i][0];
                          e.ItemName = list[i][1];
                          e.ItemCode = list[i][2];
                          e.AuxQtyMust = 0;
                          e.ApplyQtySum = 0;
                          var applyQty = 0;
                          if (parseFloat(list[i][3]) - parseFloat(list[i][4]) > 0) {
                              applyQty = parseFloat(list[i][3]) - parseFloat(list[i][4]);
                          }
                          e.ApplyQty = applyQty;
                          e.Remark = '';
                          e.InWhouse = "";
                          e.OutWhouse = "";
                          e.RowCount = rowCount;
                          addDetail(e, List.length, 1);
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
                rowCount++;
                List[i].RowCount = rowCount;
                addDetail(List[i], i, 1);
            }
        }

        //保存
        function Save() {
            var txtMoCode = $.trim($("#txtMoCode").val());
            if (txtMoCode == "") {
                alert("请先选择委外订单号");
                return false;
            }
            //已添加项
            if (List.length == 0) {
                alert("请先添加物料明细");
                return false;
            }
            var ListNew = [];

            $("#tblExpand tr:not(:first)").each(function (index, element) {
                var $checkbox = $(this).children("td:eq(0)").find("input[type='checkbox']");
                if ($checkbox.is(":checked")) {
                    var rowNum = $(this).data().RowCount;
                    var match = [];
                    $.each(List, function (j, o) {
                        if (o.RowCount == rowNum) {
                            match.push(o);
                            return false;
                        }
                    });
                    if (match.length > 0) {
                        ListNew.push(match[0]);
                    }
                }
            });
            //已添加项
            if (ListNew.length == 0) {
                alert("请先勾选需要调拨的物料明细");
                return false;
            }
            if ($("#<%=this.txtInWhCode.ClientID%>").val() == $("#<%=this.txtOutWhCode.ClientID%>").val()) {
                alert("【调入仓库】和【调出仓库】不能一致！");
                return false;
            }
            var isCheck = true;
            $.each(List, function (j, o) {
                if (isNaN(o.ApplyQty) || o.ApplyQty == 0) {
                    alert("调拨数量必须大于0");
                    isCheck = false;
                    return false;
                };
                if (o.InWhouse != "" && o.InWhouse == o.OutWhouse) {
                    alert("物料明细的【调入仓库】和【调出仓库】不能一致！");
                    isCheck = false;
                    return false;
                };
            });
            if (!isCheck) return false;

            var entity = {};
            entity.TransfersId = transfersId; //调拨单ID，新增时为-1
            entity.TransfersType = 1; //调拨类型
            entity.SourceNo = txtMoCode; //来源单号
            entity.SaleType = -1; //销售订单类型
            entity.VendorId = -1; //承运商
            entity.TransportType = -1; //运输方式
            entity.DepCode = $("#<%=this.hdnDeptID.ClientID%>").val();
            entity.Remark = $("#<%=this.txtRemark.ClientID %>").val(); //主表备注
            entity.CreateBy = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>"; //制单人
            entity.ArrivalDate = "9999-12-31";
            entity.InWhouse = $("#<%=this.txtInWhCode.ClientID%>").val(); //调入仓库
            entity.OutWhouse = $("#<%=this.txtOutWhCode.ClientID%>").val(); //调出仓库
            entity.ItemList = JSON.stringify(ListNew);
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
        function ChangeApplyQty(rowNum, t) {
            //是否为正整数验证
            var s = $.trim($(t).val());
            if (isNaN(s) || s == 0) {
                alert("请输入大于0的数字");
                $(t).val("");
                $(t).focus();
                return;
            }
            //修改值
            $.each(List, function (j, o) {
                if (o.RowCount == rowNum) {
                    o.ApplyQty = s;
                    return false;
                };
            });
        }

        //备注改变
        function ChangeRemark(rowNum, t) {
            //修改值
            $.each(List, function (j, o) {
                if (o.RowCount == rowNum) {
                    o.Remark = $.trim($(t).val());
                    return false;
                };
            });
        }

        //删除行操作
        function deleteItem(rowNum, t) {
            var index = -1;
            $.each(List, function (j, o) {
                if (o.RowCount == rowNum) {
                    index = j;
                    return false;
                }
            });
            $(t).parent().parent().remove();
            List.splice(index, 1);
            rowCount--;
        }

        //明细添加
        function addDetail(e, i, typeChecked) {
            row = tableList.insertRow(i + 1);
            row.className = i % 2 == 0 ? "ListTableEvenRow" : "ListTableOddRow";
            $(row).data(e);
            cel = row.insertCell(0);
            cel.align = "center";
            cel.className = "Field";
            if (typeChecked == 1) {
                cel.innerHTML = "<input type='checkbox' name='checkName' checked='checked' onclick='checkClick(this)'/>";
            }
            else {
                cel.innerHTML = "<input type='checkbox' name='checkName' checked='checked' onclick='checkClick(this)'/>";
            }

            //物料编码 
            cel = row.insertCell(1);
            cel.align = "center";
            cel.className = "Field";
            cel.innerHTML = "<input type='hidden' name='hdItemCode' value='" + e.ItemCode + "' />" + e.ItemCode;

            //物料名称
            cel = row.insertCell(2);
            cel.align = "center";
            cel.className = "Field";
            cel.innerHTML = "<input type='hidden' name='hdSourceDtlId' value='" + e.SourceDtlId + "' />" + e.ItemName;

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

            cel = row.insertCell(5);
            cel.align = "center";
            cel.className = "Field";
            cel.innerHTML = e.AuxQtyMust;

            cel = row.insertCell(6);
            cel.align = "center";
            cel.className = "Field";
            cel.innerHTML = e.ApplyQtySum;

            //领料数量
            cel = row.insertCell(7);
            cel.align = "center";
            cel.className = "Field";
            cel.innerHTML = "<input type='text' name='canNumber' IsRequired='1'  style= 'width:70%;' onchange=\"ChangeApplyQty('" + e.RowCount + "', this)\" value='" + e.ApplyQty + "'/>";

            //备注
            cel = row.insertCell(8);
            cel.align = "center";
            cel.className = "Field";
            cel.innerHTML = "<input type='text'  style= 'width:90%;' onchange=\"ChangeRemark('" + e.RowCount + "', this)\" value ='" + e.Remark + "' />";

            //操作
            cel = row.insertCell(9);
            cel.align = "center";
            cel.className = "Field";
            cel.innerHTML = "<span style=\"CURSOR: pointer; COLOR: #0000ff;\" onclick=\"deleteItem('" + e.RowCount + "', this)\"><%= Resources.Buttons.COM_Delete %></span>";
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
        //调拨部门
        function openChoosePage() {
            dialog({
                title: "部门列表",
                src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=13&Multiple=true&CallBackFunc=setDepCode&rnd=" + Math.random(), width: 800, height: 400
            });
            }
            function setDepCode(list) {
                $("#<%=this.txtDeptName.ClientID %>").val(list[0][2] + "(" + list[0][1] + ")");
            $("#<%=this.hdnDeptID.ClientID%>").val(list[0][1]); //部门编码
        }
        function checkClick(obj) {
            if ($(obj).attr("checked") == "checked") {
            }
            else {
            }
        }
        $("#CheckedAll").click(function () {
            if ($(this).is(":checked")) {
                $("[name=checkName]:checkbox").attr("checked", true);
            } else {
                $("[name=checkName]:checkbox").attr("checked", false);
            }
        });

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

