<%@ Page Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="True"
    CodeBehind="WarehouseCheckOrderList.aspx.cs" Inherits="SKT.LeanMES.Web.MaterialCheck.WarehouseCheckOrderList" ValidateRequest="false" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server" ViewStateMode="Enabled">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">仓库盘点单号</td>
            <td class="Field2">
                <asp:TextBox ID="txtWhCheckOrder" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label2">仓库
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtWhCode" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
                <input id="button1" class="ButtonBox" type="button" onclick="selectWhCodeList()"
                    value="..." title="选择仓库" />
                <input type="hidden" id="hdnWhID"  value="" runat="server" clientidmode="Static" />
            </td>
        </tr>
        <tr>
            <td class="Label2">盘点类型
            </td>
            <td class="Field2">
                <asp:DropDownList runat="server" ID="tdSelCheckType">
                </asp:DropDownList>
            </td>
            <td class="Label2">状态
            </td>
            <td class="Field2">
                <asp:DropDownList runat="server" ID="tdOrderStatus">
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="Label2">计划时间
            </td>
            <td class="Field2" colspan="3">
                <input type="text" id="txtDateFrom" class="DateTimeBox" runat="server" readonly="readonly" clientidmode="Static" />
                -
                <input type="text" id="txtDateTo" class="DateTimeBox" runat="server" readonly="readonly"
                    clientidmode="Static" />
            </td>

        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1">
        <Columns>
            <asp:BoundField DataField="CheckOrder" HeaderText="盘点单号" />
            <asp:BoundField DataField="CheckOrderName" HeaderText="盘点单名称" />
            <asp:BoundField DataField="CheckType" HeaderText="盘点类型" />
            <asp:BoundField DataField="StatusDesc" HeaderText="状态" />
            <asp:BoundField DataField="BeginTime" HeaderText="计划日期" />
            <asp:BoundField DataField="FinishDate" HeaderText="完成时间" />
            <asp:BoundField DataField="IsChange" HeaderText="是否平帐" />
            <asp:BoundField DataField="HandleStyle" HeaderText="平帐处理方式" />
            <asp:BoundField DataField="ChangeBy" HeaderText="平帐人" />
            <asp:BoundField DataField="ChangeTime" HeaderText="平帐时间" />
            <asp:BoundField DataField="CreateBy" HeaderText="创建人" />
            <asp:BoundField DataField="CreateTime" HeaderText="创建时间" />
            <asp:BoundField DataField="UpdateBy" HeaderText="修改人" />
            <asp:BoundField DataField="UpdateTime" HeaderText="修改时间" />
            <asp:BoundField DataField="CheckBy" HeaderText="审核人" />
            <asp:BoundField DataField="CheckTime" HeaderText="审核时间" />
            <asp:BoundField DataField="Remark" HeaderText="备注" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true"
        StartRowIndexParameterName="startRow" MaximumRowsParameterName="maxRows" SortParameterName="sortExpression"
        TypeName="SKT.LeanMES.Material.BLL.WarehouseCheckOrder" SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <asp:HiddenField ID="hfCheckTypeList" runat="server" Value="" ClientIDMode="Static" />
    <asp:HiddenField ID="hfOrderStatus" runat="server" Value="" ClientIDMode="Static" />
    <asp:HiddenField ID="hfSelType" runat="server" Value="-1" ClientIDMode="Static" />
    <asp:HiddenField ID="hfSelStatus" runat="server" Value="-1" ClientIDMode="Static" />
    <script type="text/javascript">
        isMultiple = false;
        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");

        $(document)
            .ready(function () {
                initSelControls(); //绑定下拉控件

            });

        function initSelControls() {
        }

        function Add() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/MaterialCheck/WarehouseCheckOrderEdit.aspx?name=WarehouseCheckOrderEdit&ID=-1";
          //  dialog({ title: "<%=Resources.Pages.WarehouseCheckOrderAdd %>", src: openWinUrl, width: (windowWidth - 200), height: (windowHeigth - 200) });
            window.parent.openLeftMenu(this, "<%=Resources.Pages.WarehouseCheckOrderAdd %>", openWinUrl, 'WarehouseCheckOrderAdd');
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            //checkStatus 验证
            //xiang.yan 2024-4-28  列取值由索引改为列明,功能已去除
            // 4 改为 StatusDesc
            if (getOneRecordCellTextByFiled("StatusDesc") !== '已创建') {
                alert("只能编辑状态为“已创建”的盘点单");
                return;
            }
            window.parent.openTab(this, "盘点单编辑", "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/MaterialCheck/WarehouseCheckOrderEdit.aspx?name=WarehouseCheckOrderEdit&ID=" + idStr, Date.parse(new Date()), "<%=SKT.LeanMES.Web.WebHelper.ImageRoot %>icon/eqpttype.png");
            //  openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/MaterialCheck/WarehouseCheckOrderEdit.aspx?name=WarehouseCheckOrderEdit&ID=" + idStr;
            //dialog({ title: "<%=Resources.Pages.WarehouseCheckOrderEdit %>", src: openWinUrl, width: 1020, height: 600 });
            //  window.parent.openLeftMenu(this, "<%=Resources.Pages.WarehouseCheckOrderEdit %>", openWinUrl, 'WarehouseCheckOrderEdit');

        }

        function Cancel() {
            var idStr = getDeletingRecordIdString();
            if (idStr == "") return false;
            hdnOperate.val("delete");
            hdnIdString.val(idStr);
            document.forms[0].submit();
        }

        function Approve() {
            var idStr = getOneRecordId();
            if (idStr === "") return false;
            //checkStatus 验证
            //xiang.yan 2024-4-28  列取值由索引改为列明
            // 4 改为 StatusDesc
            if ($.trim(getOneRecordCellTextByFiled("StatusDesc")) !== '已创建') {
                alert("只能审核状态为“已创建”的盘点单");
                return false;
            }
            hdnOperate.val("approve");
            hdnIdString.val(idStr);
            document.forms[0].submit();
        }

        function CancelApprove() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            //checkStatus 验证
            //xiang.yan 2024-4-28  列取值由索引改为列明
            // 4 改为 StatusDesc
            if ($.trim(getOneRecordCellTextByFiled("StatusDesc")) !== '已审核') {
                alert("只能更改状态为“已审核”的盘点单");
                return;
            }
            hdnOperate.val("disapprove");
            hdnIdString.val(idStr);
            document.forms[0].submit();
        }

        function Refresh() {
            document.forms[0].submit();
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
        }

        //查看GRN
        function ViewGRN() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            //获取盘点单号
            //xiang.yan 2024-4-28  列取值由索引改为列明
            // 1 改为 CheckOrder
            var CheckOrderNo = getOneRecordCellTextByFiled("CheckOrder");
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/MaterialCheck/WarehouseCheckGRN.aspx?name=WarehouseViewOrderGRN&OrderName=" + CheckOrderNo;
            dialog({ title: mesLang("查看盘点单明细GRN"), src: openWinUrl, width: (windowWidth - 200), height: (windowHeigth - 100) });
        }

        //查看盘点物料编码
        function ViewItem() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            //获取盘点单号
            //xiang.yan 2024-4-28  列取值由索引改为列明
            // 1 改为 CheckOrder
            var CheckOrderNo = getOneRecordCellTextByFiled("CheckOrder");
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/MaterialCheck/WarehouseCheckItem.aspx?name=WarehouseViewOrderItem&OrderName=" + CheckOrderNo;
            dialog({ title: mesLang("查看盘点物料编码"), src: openWinUrl, width: (windowWidth - 200), height: (windowHeigth - 100) });
        }
    </script>
</asp:Content>

