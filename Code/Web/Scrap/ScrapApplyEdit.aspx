<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    CodeBehind="ScrapApplyEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Scrap.ScrapApplyEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <table id="FTable" class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">仓库<em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtWhName" runat="server" IsRequired='1' CssClass="TextBox" Enabled="false"></asp:TextBox>
                <input type="button" id="scanPos" class="ButtonBox" value="..." style="font-weight: bold; text-transform: uppercase;"
                    onclick="selectWhCodeList()" />
                <asp:HiddenField ID="txtWhCode" runat="server" Value="-1" />
            </td>
            <td class="Label2">报废部门<em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtDeptName" runat="server" IsRequired='1' CssClass="TextBox" Enabled="false"></asp:TextBox>
                <input id="button2" class="ButtonBox" type="button" onclick="openChoosePage()" value="..." />
                <asp:HiddenField ID="hdnDeptID" runat="server" Value="-1" />
            </td>
        </tr>
        <tr>
            <td class="Label2">物料编码
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtItemCode" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
                <input id="button5" class="ButtonBox" type="button" onclick="selectMollocateInCode()"
                    value="..." title="选择物料编码" />
                <asp:HiddenField ID="hdnAllocateIdStr" runat="server" Value="" ClientIDMode="Static" />
            </td>
            <td class="Label2">补充说明
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtRemark" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
            </td>
        </tr>

    </table>
    <table id="tblExpand" cellspacing="0" cellpadding="4" style="border-width: 0px; width: 100%; border-collapse: collapse; margin-top: 5px;"
        class="EditeContentTable">
        <tr class="ListTableHeader">
            <th scope="col" style="width: 40px;">序号
            </th>
            <th scope="col" style="width: 180px;">物料编码
            </th>
            <th scope="col" style="width: 145px;">物料名称
            </th>
            <th scope="col" style="width: 60px;">报废数量<em>*</em>
            </th>
            <th scope="col" style="width: 200px;">备注
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
        var ScrapId = '<%=Request.QueryString["ID"]%>'; //编辑时传过来的ID
        //物料列表
        var List = [];
        var rowCount = 0;
        $(function () {
            $("#txtItemCode").focus();
            //扫描报废单
            $("#txtItemCode").keydown(function () {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    if ($.trim($("#txtItemCode").val() != "")) {
                        var e = {}, conList = [];
                        e.name = "ItemCode";
                        e.value = $.trim($("#txtItemCode").val());
                        conList.push(e);
                        var ajax = SKT.AjaxCommon.DBService.GetViewList("Basal_Item", JSON.stringify(conList));
                        if (ajax.error != null) {
                            alert(ajax.error.Message);
                            $("#txtItemCode").val("");
                            $("#txtItemCode").focus();
                            return false;
                        }
                        var en = $.parseJSON(ajax.value).data;
                        if (en == null || en[0] == null) {
                            alert("物料编码不存在!");
                            $("#txtItemCode").val("");
                            $("#txtItemCode").focus();
                            return false;
                        }
                        var have = 0;
                        $.grep(List, function (o, j) {
                            if (o.ItemCode == en[0].ItemCode) {
                                have = 1;
                                return;
                            };
                        });
                        if (have == 0) {
                            rowCount++;
                            var e = {};
                            e.SourceDtlId = en[0].ItemID;
                            e.ItemCode = en[0].ItemCode;
                            e.ItemName = en[0].ItemName;
                            e.ApplyQty = 0;
                            e.Remark = '';
                            addDetail(e, List.length);
                            List.push(e);
                        }
                        $("#txtItemCode").val("");
                        $("#txtItemCode").focus();
                    }
                }
            });
            //编辑模式显示对应的信息
            if (ScrapId != '-1') {
                showMoallocateDetailInfo(ScrapId);
            }
        });

        //选择物料编码
        function selectMollocateInCode() {
            dialog({
                title: "物料信息",
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
                    $.grep(List, function (o, j) {
                        if (o.ItemCode == list[i][2]) {
                            have = 1;
                            return;
                        };
                    });
                    if (have == 0) {
                        rowCount++;
                        var e = {};
                        e.SourceDtlId = list[i][0];
                        e.ItemCode = list[i][2];
                        e.ItemName = list[i][1];
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
        function showMoallocateDetailInfo(ScrapId) {
            $("#tblExpand tr:not(:first)").each(function () {
                $(this).remove();
            });

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxScrapApply.GetScrapInfoById(ScrapId);

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
                $("#<%=this.txtWhName.ClientID %>").val(en.data[0].InWhName + "(" + en.data[0].Whouse + ")");
                $("#<%=this.txtWhCode.ClientID%>").val(en.data[0].Whouse);

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
                alert("报废数量必须大于0");
                return;
            }

            var entity = {};
            entity.ScrapId = ScrapId; //报废单ID，新增时为-1
            entity.DepCode = $("#<%=this.hdnDeptID.ClientID%>").val();
            entity.Remark = $("#<%=this.txtRemark.ClientID %>").val(); //主表备注
            entity.CreateBy = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserId %>"; //制单人
            entity.ModifyBy = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>"; //修改人
            entity.ArrivalDate = "9999-12-31";
            entity.Whouse = $("#<%=this.txtWhCode.ClientID%>").val(); //调入仓库
            entity.ItemList = JSON.stringify(List);
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxScrapApply.ScrapApplyEdit(JSON.stringify(entity));

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
                if (isNaN(s) || s == 0 || s < 0) {
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

                //var IsRepeat = false;
                //// 验证 不能添加同一物料编码
                //$("#tblExpand").find("tr").each(function () {

                //    if ($(this).attr("class") != "ListTableHeader") {
                //        if (($(this).children().eq(1).text()) == e.ItemCode)
                //        {
                //            IsRepeat = true;
                //        }
                //    }


                //});
                //if (IsRepeat) {
                //    alert("不能添加相同物料！");
                //    return;
                //}

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


                //报废数量
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
            $("#txtItemCode").val("");
            $("#<%=this.txtRemark.ClientID %>").val("");
            $("#tblExpand tr:not(:first)").each(function () {
                $(this).remove();
            });
        }

        //报废部门
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

        //选择仓库
        function selectWhCodeList() {
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=14&Multiple=false&CallBackFunc=setInWhCode&rnd=" + Math.random(), width: 500, height: 300 });
        }
        function setInWhCode(list) {
            var whCodes = list[0][1] + "|" + list[0][2];
            if (list[0][0] == "-1") {
                whCodes = "";
            }
            $("#<%=this.txtWhName.ClientID%>").val(whCodes);
            $("#<%=this.txtWhCode.ClientID%>").val(list[0][1]);
        }

    </script>
</asp:Content>
