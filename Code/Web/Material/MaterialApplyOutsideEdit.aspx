<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MaterialApplyOutsideEdit.aspx.cs"
    MasterPageFile="~/Masters/EditMaster.master" Inherits="SKT.LeanMES.Web.Material.MaterialApplyOutsideEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <table id="FTable" class="EditeContentTable" width="100%">
        <tr>
            <td class="infoTips" colspan="4">
                <%=Resources.Messages.WithAsteriskIsRequired %>
            </td>
        </tr>
        <tr class="clear5">
        </tr>
        <tr>
            <td class="Label2">委外订单<em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtPurOrder" runat="server" IsRequired='1' CssClass="TextBox" ClientIDMode="Static"></asp:TextBox><input id="button2" class="ButtonBox" type="button" onclick="selectPurOrderList()"
                    value="..." title="委外订单号" />
                <asp:HiddenField ID="hdnPO" runat="server" Value="-1" ClientIDMode="Static" />
            </td>
            <td class="Label2">供应商
            </td>
            <td class="Field2" id="tdVendor"></td>
        </tr>
        <tr>
            <td class="Label2">物料编码
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtItemCode" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox><input id="button5" class="ButtonBox" type="button" onclick="selectItem()"
                    value="..." title="选择物料编码" />
                <asp:HiddenField ID="hdnAllocateIdStr" runat="server" Value="" ClientIDMode="Static" />
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
            <td class="Label2">需求日期<em>*</em>
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


    <script type="text/javascript">
        var itemList = [];
        var rowCount = 0;
        //编辑时显示子件明细
        var tableList = document.getElementById("tblExpand");
        $(function () {

        })

        function selectPurOrderList() {
            var SearchCondition = " IsPeriod = 0 ";
            dialog({
                title: "<%=Resources.Common.ChooseWindow %>",
                src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=106&CallBackFunc=setPurValue&Multiple=false&PageCondition="
               + escape(SearchCondition) + "&rnd=" + Math.random(), width: 720, height: 368
            });
        }

        function setPurValue(list) {
            $("#txtPurOrder").val(list[0][1]);
            $("#hdnPO").val(list[0][1]);
            $("#tdVendor").html(list[0][3]); //供应商名称
        }

        //选择物料编码
        function selectItem() {
            var txtPoCode = $("#txtPurOrder").val();
            if (txtPoCode == "") {
                alert("请选择采购单号!");
                return false;
            }
            searchCondition = " POCode  ='" + txtPoCode + "' ";

            dialog({
                title: "工单用料信息",
                src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=203&PageCondition="
                + escape(searchCondition) + "&Multiple=true&CallBackFunc=getItemInfo&rnd=" + Math.random(), width: 800, height: 400
            });
        }

        function getItemInfo(list) {
            if (list.length <= 0) {
                return;
            }
            if (list[0][0] != "-1") {
                for (var i = 0; i < list.length; i++) {
                    var have = 0;
                    //修改值
                    $.grep(itemList, function (o, j) {
                        if (o.ItemId == list[i][0] && o.ItemName == list[i][1] && o.ItemCode == list[i][2]) {
                            have = 1;
                            return;
                        };
                    });
                    if (have == 0) {
                        rowCount++;
                        var e = {};
                        e.ApplyDtlId = -1;
                        e.Statue = 0;
                        e.ItemId = -1;
                        e.ItemCode = list[i][3];
                        e.ItemName = list[i][4];
                        //领料数量
                        e.ApplyQty = 0;
                        if (list[i][5] - list[i][6] - list[i][8] > 0) {
                            e.ApplyQty = list[i][5] - list[i][6] - list[i][8];
                        }
                        e.SourceQty = list[i][5];
                        e.ActiQty = list[i][6] !== '' ? list[i][6] : 0;
                        e.Qty = list[i][7];
                        e.ApplyQtySum = list[i][8];
                        e.Remark = '';
                        addDetail(e, itemList.length);
                        itemList.push(e);
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
        //明细添加
        function addDetail(data, i) {
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
            cel.innerHTML = data.ItemCode;
            //物料名称
            cel = row.insertCell(2);
            cel.align = "center";
            cel.className = "Field";
            cel.innerHTML = data.ItemName;
            //工单标准量
            cel = row.insertCell(3);
            cel.align = "center";
            cel.className = "Field OrderQty";
            cel.innerHTML = data.SourceQty;
            //已备料数量
            cel = row.insertCell(4);
            cel.align = "center";
            cel.className = "Field HaveQty";
            cel.innerHTML = data.ActiQty !== '' ? data.ActiQty : 0;
            //已领未备料数量
            cel = row.insertCell(5);
            cel.align = "center";
            cel.className = "Field";
            cel.innerHTML = data.ApplyQtySum;
            //领料数量
            cel = row.insertCell(6);
            cel.align = "center";
            cel.className = "Field";
            cel.innerHTML = "<input type='text' name='canNumber' IsRequired='1'  style= 'width:70%;'  onchange=\"ChangeApplyQty(" + data.ApplyDtlId + ", this ,'" + data.ItemCode + "')\" value='" + data.ApplyQty + "'/>";
            //当前库存
            cel = row.insertCell(7);
            cel.align = "center";
            cel.className = "Field";
            cel.innerHTML = data.Qty;
            //是否齐套
            cel = row.insertCell(8);
            cel.align = "center";
            cel.className = "Field";
            if (data.ApplyQty > data.Qty) {
                cel.innerHTML = "<span style='color:red'>否</span>";
            }
            else {
                cel.innerHTML = "是";
            }
            //备注
            cel = row.insertCell(9);
            cel.align = "center";
            cel.className = "Field";
            cel.innerHTML = "<input type='text' style= 'width:90%;' maxlength='20' onchange=\"ChangeRemark(" + data.ApplyDtlId + ", this,'" + data.ItemCode + "')\" value ='" + data.Remark + "' />";

            //操作
            var sta = data.Statue;
            if (sta != 0) {//已发料，已接受，已完结，不可再删除
                cel = row.insertCell(10);
                cel.align = "center";
                cel.className = "Field";
                cel.innerHTML = "";
            } else {
                cel = row.insertCell(10);
                cel.align = "center";
                cel.className = "Field";
                cel.innerHTML = "<span style=\"CURSOR: pointer; COLOR: #0000ff;\" onclick=\"deleteItem(" + data.ApplyDtlId + ", this,'" + data.ItemCode + "')\"><%= Resources.Buttons.COM_Delete %></span>";
            }
        }

    </script>
</asp:Content>
