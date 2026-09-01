<%@ Page Language="C#" MasterPageFile="~/Masters/ListMaster.master"
    AutoEventWireup="true" CodeBehind="FixedBarcodeList.aspx.cs" Inherits="SKT.LeanMES.Web.ProductionDataConfig.FixedBarcodeList" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1">查询类型
            </td>
            <td class="Field1">
                <asp:DropDownList runat="server" ID="ddlConfigType">
                    <asp:ListItem Value="-1">请选择</asp:ListItem>
                    <asp:ListItem Value="903">SMT是否启动Feeder扫描</asp:ListItem>
                    <asp:ListItem Value="904">SMT物料预警时间（单位：分钟）</asp:ListItem>
                    <asp:ListItem Value="905">报废是否算产出</asp:ListItem>
                    <asp:ListItem Value="906">产品最大不良维修次数</asp:ListItem>
                    <asp:ListItem Value="900">NG字符串</asp:ListItem>
                    <asp:ListItem Value="901">OK字符串</asp:ListItem>
                    <asp:ListItem Value="902">用户名</asp:ListItem>
                    <asp:ListItem Value="907">排产需要检查齐套</asp:ListItem>
                    <asp:ListItem Value="908">GRN转移检查制造日期</asp:ListItem>
                    <asp:ListItem Value="909">GRN转移检查批次号</asp:ListItem>
                    <asp:ListItem Value="910">排产确认是否校验领料单</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1"
        OnRowDataBound="GridView1_RowDataBound">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="ConfigType" HeaderText="配置类型" />
            <asp:BoundField DataField="ConfigResult" HeaderText="配置数据" />
            <asp:BoundField DataField="IsGlobal" HeaderText="系统内置" />
            <asp:BoundField DataField="Remark" HeaderText="备注" />
            <asp:BoundField DataField="CreateBy" HeaderText="创建人" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="<%$ Resources:lang, CreateDateTime %>" />
            <asp:BoundField DataField="ModifyBy" HeaderText="修改人" />
            <asp:BoundField DataField="ModifyDateTime" HeaderText="<%$ Resources:lang, ModifyDateTime %>" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.MaterialConfig.BLL.MaterialSysConfig"
        SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <script type="text/javascript">
        isMultiple = false;
        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");
        function Add() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/ProductionDataConfig/FixedBarcodeEdit.aspx?name=FixedBarcodeAdd&ID=-1";
            dialog({ title: mesLang("新增生产数据设置"), src: openWinUrl, width: 650, height: 400 });
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            var name = $(".ListTable  input[type='checkbox']:checked").parent().next().text();            
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/ProductionDataConfig/FixedBarcodeEdit.aspx?name=FixedBarcodeEdit&ID=" + idStr + "&value=" + escape(name);
            dialog({ title: mesLang("编辑生产数据设置"), src: openWinUrl, width: 600, height: 400 });
        }

        function Delete() {
            //xiang.yan 2024-4-28  列取值由索引改为列明
            // 3 改为 IsGlobal
            var IsGlobal = getOneRecordCellTextByFiled("IsGlobal");
            if (IsGlobal=="是") {
                alert("系统内置数据,不能删除！");
                return false;
            }
            var idStr = getDeletingRecordIdString();
            if (idStr == "") return false;
            hdnOperate.val("delete");
            hdnIdString.val(idStr);
            document.forms[0].submit();
        }

        function Refresh() {
            document.forms[0].submit();
        }

        function UpdateList(typeId) {
            $("#<%=this.ddlConfigType.ClientID %>").val(typeId);
            document.forms[0].submit();
        }
    </script>
</asp:Content>
