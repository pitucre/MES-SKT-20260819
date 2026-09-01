<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    CodeBehind="TransfersApplyEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Transfers.TransfersApplyEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <table id="FTable" class="EditeContentTable" width="100%">
 <%--       <tr>
            <td class="Label2">
                物料编码
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtItemCode" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
                <input id="button5" class="ButtonBox" type="button" onclick="selectMollocateInCode()"
                    value="..." title="选择物料编码" />
                <asp:HiddenField ID="hdnAllocateIdStr" runat="server" Value="" ClientIDMode="Static" />
            </td>
            <td class="Label2">
                补充说明
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtRemark" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
            </td>
        </tr>--%>
        <tr>
            <td class="Label2">
                <span>调入仓库</span><em>*<em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtInWhName" runat="server" IsRequired='1' CssClass="TextBox" Enabled="false"></asp:TextBox>
                <input type="button" id="scanPos" class="ButtonBox" value="..." style="font-weight: bold;
                    text-transform: uppercase;" onclick="selectInWhCodeList()" />
                <asp:HiddenField ID="txtInWhCode" runat="server" Value="-1" />
            </td>
            <td class="Label2">
                <span>调出仓库</span><em>*<em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtOutWhName" runat="server" IsRequired='1' CssClass="TextBox" Enabled="false"></asp:TextBox>
                <input type="button" id="Button1" class="ButtonBox" value="..." style="font-weight: bold;
                    text-transform: uppercase;" onclick="selectOutWhCodeList()" />
                <asp:HiddenField ID="txtOutWhCode" runat="server" Value="-1" />
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <span>调拨部门</span><em>*<em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtDeptName" runat="server" IsRequired='1' CssClass="TextBox" Enabled="false"></asp:TextBox>
                <input id="button2" class="ButtonBox" type="button" onclick="openChoosePage()" value="..." />
                <asp:HiddenField ID="hdnDeptID" runat="server" Value="-1" />
            </td>
               <td class="Label2">
                补充说明
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtRemark" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
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
            <th scope="col" style="width: 150px;">
                调入仓库
            </th>
            <th scope="col" style="width: 150px;">
                调出仓库
            </th>
            <th scope="col" style="width: 60px;">
                <span>调拨数量</span><em>*<em>
            </th>
            <th scope="col" style="width: 200px;">
                备注
            </th>
            <th scope="col" style="color: #0066CC; cursor: pointer; width: 60px;">
                <div onclick="selectMollocateInCode()">
                <span>添加</span>
                <div class="icon-16-add"></div>
                </div>
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
        var curOpenPageElement = null;
        $(function () {
            $("#txtItemCode").focus();
            //扫描调拨单
            //$("#txtItemCode").keydown(function () {
            //    var curKey = 0, e = e || window.event;
            //    curKey = e.keyCode || e.which || e.charCode;
            //    if (curKey == 13) {
            //        if($.trim($("#txtItemCode").val()!=""))
            //        {
            //            var e = {}, conList = [];
            //            e.name = "ItemCode";
            //            e.value = $.trim($("#txtItemCode").val());
            //            conList.push(e);
            //            var ajax = SKT.AjaxCommon.DBService.GetViewList("Basal_Item", JSON.stringify(conList));
            //            if (ajax.error != null) {
            //                alert(ajax.error.Message);
            //                $("#txtItemCode").val("");
            //                $("#txtItemCode").focus();
            //                return false;
            //            }
            //            var en = $.parseJSON(ajax.value).data;
            //            if (en == null || en[0] == null) {
            //                alert("物料编码不存在!");
            //                $("#txtItemCode").val("");
            //                $("#txtItemCode").focus();
            //                return false;
            //            }
            //            var have = 0;
            //            if (have == 0) {
            //                rowCount++;
            //                var e = {};
            //                e.SourceDtlId = en[0].ItemID;
            //                e.ItemCode = en[0].ItemCode;
            //                e.ItemName = en[0].ItemName;
            //                e.ApplyQty = 0;
            //                e.Remark = '';
            //                e.OutWhouse = "";
            //                e.InWhouse = "";
            //                e.RowCount = rowCount;
            //                addDetail(e, List.length);
            //                List.push(e);
            //            }
            //            $("#txtItemCode").val("");
            //            $("#txtItemCode").focus();
            //        }
            //    }
            //});
            //编辑模式显示对应的信息
            if (transfersId != '-1') {
                showMoallocateDetailInfo(transfersId);
            }
        });

        //选择物料编码
        function selectMollocateInCode() {
            dialog({ title: "物料信息",
                src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=1&Multiple=true&CallBackFunc=setInvCode&rnd=" + Math.random(), width: 800, height: 400
            });
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
                    $.each(List, function (j, o) {
                        if (o.ItemCode == list[i][1]) {
                            have = 1;
                            return false;
                        };
                    });
                    if (have == 0) {
                        rowCount++;
                        var e = {};
                        e.TransfersDtlId = -1;
                        e.SourceDtlId = list[i][0];
                        e.ItemCode = list[i][2];
                        e.ItemName = list[i][1];
                        e.ApplyQty = 0;
                        e.Remark = '';
                        e.OutWhouse = "";
                        e.InWhouse = "";
                        e.RowCount = rowCount;
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
                rowCount++;
                List[i].RowCount = rowCount;
                addDetail(List[i], i);
            }
        }

        //保存
        function Save() {
            //已添加项
            if (List.length == 0) {
                alert("请先添加物料明细");
                return false;
            }
            if ( $("#<%=this.txtInWhCode.ClientID%>").val()== $("#<%=this.txtOutWhCode.ClientID%>").val()) {
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
                }
            });
            if (!isCheck) return false;

            var entity = {};
            entity.TransfersId = transfersId; //调拨单ID，新增时为-1
            entity.TransfersType = 0; //调拨类型
            entity.SourceNo = ""; //来源单号
            entity.SaleType = -1; //销售订单类型
            entity.VendorId = -1; //承运商
            entity.TransportType = -1; //运输方式
            entity.DepCode = $("#<%=this.hdnDeptID.ClientID%>").val();
            entity.Remark = $("#<%=this.txtRemark.ClientID %>").val(); //主表备注
            entity.CreateBy = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>"; //制单人
            entity.ArrivalDate = "9999-12-31";
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
        function ChangeApplyQty(rowNum, t) {
            //是否为正整数验证
            var s = $.trim($(t).val());
            if (isNaN(s) || s == 0 || s<0) {
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
        function addDetail(e, i) {
            row = tableList.insertRow(i + 1);
            row.className = i % 2 == 0 ? "ListTableEvenRow" : "ListTableOddRow";
            $(row).data(e);//行保存数据实体
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
            cel.innerHTML = "<input type='text' name='canNumber' IsRequired='1'  style= 'width:70%;' onchange=\"ChangeApplyQty(" + e.RowCount + ", this)\" value='" + e.ApplyQty + "'/>";

            //备注
            cel = row.insertCell(6);
            cel.align = "center";
            cel.className = "Field";
            cel.innerHTML = "<input type='text'  style= 'width:90%;' onchange=\"ChangeRemark(" + e.RowCount + ", this)\" value ='" + e.Remark + "' />";

            //操作
            cel = row.insertCell(7);
            cel.align = "center";
            cel.className = "Field";
            cel.innerHTML = "<span style=\"CURSOR: pointer; COLOR: #0000ff;\" onclick=\"deleteItem(" + e.RowCount + ", this)\"><%= Resources.Buttons.COM_Delete %></span>";
        }

        //清空表数据
        function clearTableInfo() {
            rowCount = 0;
            List = [];
            $("#txtItemCode").val("");
            $("#<%=this.txtRemark.ClientID %>").val("");
            $("#tblExpand tr:not(:first)").each(function () {
                $(this).remove();
            });
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
