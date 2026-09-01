<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    CodeBehind="MaterialApplyHandEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Material.MaterialApplyHandEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <table id="FTable" class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">
                生产部门<em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtDeptName" runat="server" CssClass="TextBox" IsRequired='1' Enabled="false"></asp:TextBox><input id="button2" class="ButtonBox" type="button" onclick="openChoosePage(13)"
                    value="..." />
                <asp:HiddenField ID="hdnDeptID" runat="server" Value="-1" />
            </td>
            <td class="Label2">
                仓库<em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtWhName" runat="server" CssClass="TextBox" IsRequired='1' Enabled="false"></asp:TextBox><input id="button1" class="ButtonBox" type="button" onclick="openChoosePage(14)"
                    value="..." />
                <asp:HiddenField ID="hdnWhID" runat="server" Value="-1" />
            </td>
        </tr>
        <tr>
            <td class="Label2">
                使用日期<em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtUserDate" runat="server" CssClass="DateTimeBox" IsRequired='1'
                    Width="140"></asp:TextBox>
            </td>
            <td class="Label2">
                备注
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtRemark" runat="server" MaxLength="50"  CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
    </table>
    <table id="tblExpand" cellspacing="0" cellpadding="4" style="border-width: 0px; width: 100%;
        border-collapse: collapse; margin-top: 5px;" class="EditeContentTable">
        <tr class="ListTableHeader">
            <th scope="col" style="width: 4%;">
                行号
            </th>
            <th scope="col" style="width: 15%;">
                产品编码
            </th>
            <th scope="col" style="width: 20%;">
                产品名称
            </th>
            <th scope="col" style="width: 8%;">
                领料数量
            </th>
            <th scope="col" style="width: 8%;">
                备注
            </th>
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
    <script type="text/javascript">
        _isHms = true; /*日期控件开启时分秒*/
        var flag = -1;

        var applyId = '<%=Request.QueryString["ID"]%>';

        //入口
        $(function () {
            if (applyId != '-1') {
                //显示调拨信息列表
                showMaterialRequestInfo(applyId);
            }
        });

        //编辑
        function showMaterialRequestInfo(applyId) {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialApply.GetMaterialApply(applyId);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var data = $.parseJSON(ajax.value);
            var en = $.parseJSON(ajax.value);

            if (en.data != null && en.data.length > 0) {

                var entity = en.data[0];
                $("#<%=this.txtDeptName.ClientID %>").val(entity["DepName"] + "(" + entity["DepCode"] + ")");
                $("#<%=this.hdnDeptID.ClientID %>").val(entity["DepCode"]);
                $("#<%=this.txtWhName.ClientID %>").val(entity["WhName"] + "(" + entity["WhCode"] + ")");
                $("#<%=this.hdnWhID.ClientID%>").val(entity["WhCode"]);
                $("#<%=this.txtUserDate.ClientID %>").val(entity["UseDateTime"]);
                $("#<%=this.txtRemark.ClientID%>").val(entity["Remark"]);

                //表身
                var List = en.data1;
                var row, cel;
                rowCount = 0;
                for (var i = 0; i < List.length; i++) {
                    rowCount++;
                    addDetail(List[i], i);
                }
            }
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

        //新增
        var tab = document.getElementById("tblExpand");
        var i = 0;
        function addDetail(entity) {
            if (entity == null) {
                entity = {};
                entity.ItemId = -1;
                entity.ItemCode = "";
                entity.ItemName = "";
                entity.ItemSpec = "";
                entity.ApplyQty = "0";
                entity.Units = "";
                entity.Remark = "";
                entity.Statue = "";
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

            //领料数量
            cell = row.insertCell(3);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = "<input type='text' MaxLength='9' IsNumber='1' IsRequired='1' style='width:90%;' value='" + parseFloat(entity.ApplyQty) + "' class='txtQty'  onblur='isPositiveNum(this);'/>";

            //备注
            cell = row.insertCell(4);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = "<input type='text' style='width:90%;' MaxLength='20' value='" + entity.Remark + "' class='txtRemarkS' />";

            //操作
            var sta = entity.Statue;
            if (sta != 0) {//已发料，已接受，已完结，不可再删除
                cel = row.insertCell(5);
                cel.align = "center";
                cel.className = "Field";
                cel.innerHTML = "";
            } else {
                cel = row.insertCell(5);
                cel.align = "center";
                cel.className = "Field";
                cel.innerHTML = "<span style=\"CURSOR: pointer; COLOR: #0000ff;\" onclick=\"deleteItem(this,'" + entity.ItemId + "')\"><%= Resources.Buttons.COM_Delete %></span>";
            }
        }

        //删除行数据
        function deleteItem(obj, ItemId) {
            i = i - 1;
            tab.deleteRow(obj.parentElement.parentElement.rowIndex);
        }

        //选择产品编码
        function selectItemCode(obj) {
            var $obj = $(obj);
            rowObj = obj.parentElement.parentElement;
            rowIndex = rowObj.rowIndex;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=1&CallBackFunc=getChooseValueMaterial&Multiple=false&rnd=" + Math.random(), width: 600, height: 300 });
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
                rowObj.cells[1].children[1].value = list[0][2]; //产品编码

                rowObj.cells[2].children[0].value = list[0][1]; //产品名称
            }
        }

        //打开选择视窗
        function openChoosePage(flags) {
            var searchCondition = "";
            flag = flags;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=" + flag + "&PageCondition=" + escape(searchCondition) + "&Multiple=false&DataInit=No&rnd=" + Math.random(), width: 630, height: 360 });
        }

        function getChooseValue(list) {
            if (flag == 13) {
                $("#<%=this.txtDeptName.ClientID %>").val(list[0][2] + "(" + list[0][1] + ")");
                $("#<%=this.hdnDeptID.ClientID%>").val(list[0][1]); //部门编码
            }
            if (flag == 14) {
                $("#<%=this.txtWhName.ClientID %>").val(list[0][2] + "(" + list[0][1] + ")");
                $("#<%=this.hdnWhID.ClientID%>").val(list[0][1]); //仓库编码
            }
            flag = -1;
        }

        function Save() {
            var hdnDeptID = $("#<%=this.hdnDeptID.ClientID%>").val();  //生产部门
            var hdnWhID = $("#<%=this.hdnWhID.ClientID%>").val();  //仓库
            var txtUserDate = $("#<%=this.txtUserDate.ClientID%>").val(); //使用日期
            var txtRemark = $("#<%=this.txtRemark.ClientID%>").val(); //备注

            var List = [];
            if (hdnDeptID === '' || hdnWhID === '' || txtUserDate==='') {
                alert('请选择必要信息');
                return false;
            }

            $("#tblExpand tr:not(:first)").each(function (index, element) {
                var model = {};
                model.ApplyDtlId = -1;
                model.MODtlNo = -1;
                model.MODtlId = -1;
                model.Statue = 0;

                model.ItemId = $(this).children("td:eq(1)").find("[name='hdItemId']").val();
                model.ItemCode = $(this).children("td:eq(1)").find("[name='txtItem']").val();
                model.ItemName = $(this).children("td:eq(2)").find('input').val();
                model.ApplyQty = $(this).children("td:eq(3)").find('input').val();

                model.SourceQty = -1;
                model.ActiQty = -1;
                model.Qty = -1;
                model.ApplyQtySum = -1;
                model.Remark = $(this).children("td:eq(4)").find('input').val();

                List.push(model);
            });

            if (List.length == 0 || typeof List[0].ItemId == 'undefined') {
                alert("请添加要申请的物料!");
                return false;
            }
            var entity = {};
            entity.ApplyId = applyId;
            entity.ApplyType = 0; //手工增加
            entity.MOCode = "";
            entity.DepCode = hdnDeptID.toString();
            entity.WhCode = hdnWhID.toString();
            entity.UseDateTime = txtUserDate; //使用日期
            entity.Remark = txtRemark.toString();
            entity.CreateBy = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';
            //entity.applyDtl = JSON.stringify(List);
            var enJSON = JSON.stringify(entity);
            var applyDtl = JSON.stringify(List);

            //var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialApply.MaterialApplyEdit(JSON.stringify(entity));
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialApply.ApplyEdit(enJSON, applyDtl);

            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert('<%=Resources.Messages.SaveInSuccess%>');
            parent.window.Refresh();
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

        function isPositiveNum(obj) {//是否为正整数
            var s = $(obj).val();
            var re = /^[1-9]*[1-9][0-9]*$/;
            if (isNaN(s * 1)) {
                alert('请输入数字格式');   
                return false;
            }
            //if (!re.test(s)) {
            //    alert("请输入正整数！");
            //    $(obj).val(1);
            //    $(obj).focus();
            //}
        } 
    </script>
</asp:Content>
