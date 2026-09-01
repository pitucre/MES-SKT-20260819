<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master"
    AutoEventWireup="true" CodeBehind="ItemContainerEdit.aspx.cs" Inherits="SKT.LeanMES.Web.MaterialConfig.ItemContainerEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %>
    </div>
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label1">产品<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtItemCode" runat="server" CssClass="TextBox" IsRequired='1' ReadOnly="true"
                    ClientIDMode="Static"></asp:TextBox><input type="button" id="btnSelectItem" class="ButtonBox" value="..." title="Select"
                        onclick="openChoosePageItem();" />
                <asp:HiddenField ID="hdnItemId" runat="server" Value="-1" ClientIDMode="Static" />
            </td>
        </tr>
        <tr>
            <td class="Label1">备注
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtRemark" runat="server" CssClass="TextArea" TextMode="MultiLine"></asp:TextBox>
            </td>
        </tr>
    </table>
    <table class="ListTable" cellspacing="0" cellpadding="4" style="border-width: 0px; min-width: 760px; width: 100%; overflow: auto; border-collapse: collapse;"
        id="tbPackLevel">
        <tr class="ListTableHeader">
            <th scope="col" align="center">包装层级
            </th>
            <th scope="col" align="center">包装数量<em>*</em>
            </th>
            <th scope="col" align="center">长
            </th>
            <th scope="col" align="center">宽
            </th>
            <th scope="col" align="center">高
            </th>
            <th scope="col" align="center">备注
            </th>
            <th scope="col" onclick="addPackLevelDetail(null,true);" style="color: #0066CC; cursor: pointer; width: 100px; vertical-align: middle;"
                align="center">
                <img src="../Content/images/icon/Add.png" class="imgText" />
                <%= Resources.Buttons.COM_Add%>
            </th>
        </tr>
        <tr class='ListTableEmptyDataRow' id="showTitile">
            <td colspan='7'>点击“新增”按钮来设置包装层级。</td>
        </tr>

    </table>

    <script type="text/javascript">
        var ContainerId = '<%=Request.QueryString["ID"]%>';
        var flag = -1;

        $(function () {
            if (ContainerId != "-1") {
                EditShowInfo();
            }
        });

        function openChoosePageItem() {
            flag = 1;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=1&Multiple=false&rnd=" + Math.random(), width: 700, height: 400 });
        }

        //进入编辑，显示数据
        function EditShowInfo() {
            var entity = {};
            entity.ContainerId = ContainerId;
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPrint.ExecuteSpc("uspGetContainInfo", JSON.stringify(entity));
            var dataOne = $.parseJSON(ajax.value).data;
            if (dataOne != null) {
                $("#<%=this.txtItemCode.ClientID%>").val(dataOne[0].ItemCode);
                $("#<%=this.txtRemark.ClientID%>").val(dataOne[0].Remark);
                $("#hdnItemId").val(dataOne[0].ItemId);
            }
            var dataTwo = $.parseJSON(ajax.value).data1;
            if (dataTwo != null) {
                $("#tbPackLevel .ListTableEmptyDataRow").remove();
                var html = ""
                for (var i = 0; i < dataTwo.length; i++) {
                    html += "<tr class=\"ListTableOddRow\"><td>" + dataTwo[i].ContainerLevel + "层" + "</td>"
                    html += "<td><input type=\"text\" IsRequired='1' onchange = isPositiveNum(this) value=\'" + dataTwo[i].ContainerQty + "\' /></td>"
                    html += "<td><input type=\"text\" value=\'" + dataTwo[i].ContainerLong + "\' /></td>"
                    html += "<td><input type=\"text\" value=\'" + dataTwo[i].ContainerWidth + "\'/></td><td><input type=\"text\"  value=\'" + dataTwo[i].ContainerHeight + "\'/></td>"
                    html += "<td><input type=\"text\" value =\'" + dataTwo[i].Remark + "\'/></td>"
                    html += "<td><span style=\"cursor: pointer; color: #0000ff;\" onclick=\"deleteItem(this)\">删除</span></td> </tr>";
                }
                $("#tbPackLevel").append(html);
            }
        }

        function getChooseValue(list) {
            if (flag == 1) {
                if (list[0][0] != "-1") {
                    $("#<%=this.txtItemCode.ClientID%>").val(list[0][2]);
                    $("#hdnItemId").val(list[0][0]);
                }
            }
            else if (flag == 4) {
                if (list[0][1] != "") {
                    rowObj.cells[2].children[0].value = list[0][1];
                    rowObj.cells[2].children[2].value = list[0][0];
                }
            }
            flag = -1;
        }

        //新增数据
        function addPackLevelDetail(entity, IsBoolAdd) {
            $("#tbPackLevel .ListTableEmptyDataRow").remove();
            if (entity == null) {
                if (IsBoolAdd) {//新增模式
                    //不能超过十层：
                    if ($("#tbPackLevel tr").length == 11) {
                        alert("包装层级不能超过十层,请知悉!");
                        return false;
                    }
                    var html = "<tr class=\"ListTableOddRow\"><td></td><td><input type=\"text\" IsRequired='1' onchange = isPositiveNum(this) /></td>"
                    html += "<td><input type=\"text\" /></td>";
                    html += "<td><input type=\"text\" /></td><td><input type=\"text\" /></td><td><input type=\"text\" /></td>"
                    html += "<td><span style=\"cursor: pointer; color: #0000ff;\" onclick=\"deleteItem(this)\">删除</span></td> </tr>";
                    $("#tbPackLevel").append(html);
                    //重新排序：序号就是层级
                    AgainSorting();

                }
            }
        }

        //重新排序
        function AgainSorting() {
            $("#tbPackLevel tr").each(function (index) {
                $(this).find("td").eq(0).text(index + "层");
            })
        }

        //删除数据
        var tab = document.getElementById("tbPackLevel");
        function deleteItem(obj) {
            tab.deleteRow(obj.parentElement.parentElement.rowIndex);
            //重新排序：
            AgainSorting();
        }

        //保存数据
        function Save() {
            var ItemId = $("#hdnItemId").val();
            var Remark = $.trim($("#<%=this.txtRemark.ClientID%>").val());
            var ItemCode = $("#<%=this.txtItemCode.ClientID%>").val();
            var ContainerLevel = [];
            $("#tbPackLevel tr:gt(0)").each(function (index) {
                var containLevel = (index + 1);  //层级
                var containQty = $($(this).find("td").eq(1).find("input")[0]).val(); //包装数量
                var containLong = $($(this).find("td").eq(2).find("input")[0]).val(); //长
                var containWidth = $($(this).find("td").eq(3).find("input")[0]).val(); //宽
                var containHeight = $($(this).find("td").eq(4).find("input")[0]).val(); //高
                var containRemark = $($(this).find("td").eq(5).find("input")[0]).val(); //备注
                ContainerLevel.push({ "containLevel": containLevel, "containQty": containQty, "containLong": containLong, "containWidth": containWidth, "containHeight": containHeight, "containRemark": containRemark });
            });
            var entity = {};
            entity.ContainerId = ContainerId;
            entity.ItemId = ItemId;
            entity.Remark = Remark;
            entity.UserName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
            entity.ContainLevelDetail = JSON.stringify(ContainerLevel);
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPrint.ExecuteSpc("uspSaveContainerLevel", JSON.stringify(entity));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            else {
                if (ContainerId == "-1") {
                    //新增模式
                    alert('<%=Resources.Messages.SaveSuccess %>');
                    clearInfo();
                }
                else {
                    parent.window.UpdateList(ItemCode);
                }
            }
        }
        //清空数据
        function clearInfo() {
            $("#<%=this.txtItemCode.ClientID%>").val("");
            $("#<%=this.txtRemark.ClientID%>").val("");
            $("#hdnItemId").val("-1");
            $("#tbPackLevel tr:gt(0)").remove();
            $("#tbPackLevel").append("<tr class='ListTableEmptyDataRow'><td colspan='7'>点击“新增”按钮来设置包装层级。</td></tr>");
        }

        function isPositiveNum(obj) {//是否为正整数
            var s = $(obj).val();
            var re = /^[1-9]\d*\,\d*|[1-9]\d*$/;
            if (!re.test(s)) {
                alert("请输入正确的数字！");
                $(obj).val("");
                $(obj).css("background-color", "rgb(255, 255, 0)");
                setTimeout(function () { $(obj).select().focus(); }, 100);
                return false;
            } else {
                $(obj).css("background-color", "");
                return true;
            }
        }
    </script>
</asp:Content>
