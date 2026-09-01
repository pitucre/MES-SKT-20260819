<%@ Page Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true"
    CodeBehind="MaterialSysConfigList.aspx.cs" Inherits="SKT.LeanMES.Web.MaterialConfig.MaterialSysConfigList" %>

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
                    <asp:ListItem Value="1">供应商是否启用物料条码规则</asp:ListItem>
                 <%--   <asp:ListItem Value="2">仓库收料</asp:ListItem>--%>
                    <asp:ListItem Value="3">是否备料确认</asp:ListItem>
                    <asp:ListItem Value="4">发料是否交接确认</asp:ListItem>
                    <asp:ListItem Value="5">是否进行IQC检验</asp:ListItem>
                    <asp:ListItem Value="6">供应商是否交期维护</asp:ListItem>
                    <asp:ListItem Value="7">先进先出备料规则</asp:ListItem>
                    <asp:ListItem Value="8">IQC退料扫描确认</asp:ListItem>
                    <asp:ListItem Value="9">是否进行IQC交接确认</asp:ListItem>
                    <asp:ListItem Value="10">不良仓选择</asp:ListItem>
                    <asp:ListItem Value="11">JIT首套发料时间</asp:ListItem>
                    <asp:ListItem Value="12">JIT预警时间</asp:ListItem>
                    <asp:ListItem Value="13">生产配送时间</asp:ListItem>
                    <asp:ListItem Value="14">SMT料站表计算用量方式</asp:ListItem>
                <%--    <asp:ListItem Value="15">看板欢迎词</asp:ListItem>--%>
                  <%--  <asp:ListItem Value="16">平帐处理方式</asp:ListItem>--%>
                    <asp:ListItem Value="17">线边仓是否按GRN接收</asp:ListItem>
                    <asp:ListItem Value="18">仓库库位条码中间符设定</asp:ListItem>
              <%--      <asp:ListItem Value="19">辅料解冻/使用次数配置</asp:ListItem>--%>
                    <asp:ListItem Value="22">仓库备料是否自动分料</asp:ListItem>
                    <asp:ListItem Value="23">是否启用调拨出库</asp:ListItem>
                    <asp:ListItem Value="24">是否启用历史物料打印到产线</asp:ListItem>
                    <%--<asp:ListItem Value="25">打印历史物料是否选择仓库</asp:ListItem>--%>
                    <asp:ListItem Value="26">电子货架对接</asp:ListItem>
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
            <asp:BoundField DataField="ConfigDesc" HeaderText="配置数据源" />
            <asp:BoundField DataField="IsGlobal" HeaderText="系统内置" />
            <asp:BoundField DataField="Remark" HeaderText="备注" />
            <asp:BoundField DataField="CreateBy" HeaderText="<%$ Resources:lang,CreateBy%>"
                SortExpression="CreateBy" HeaderStyle-Width="60px" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="<%$ Resources:lang,CreateDateTime%>"
                SortExpression="CreateDateTime" HeaderStyle-Width="140px" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
            <asp:BoundField DataField="ModifyBy" HeaderText="<%$ Resources:lang,ModifyBy%>"
                SortExpression="ModifyBy" HeaderStyle-Width="60px" />
            <asp:BoundField DataField="ModifyDateTime" HeaderText="<%$ Resources:lang,ModifyDateTime%>"
                SortExpression="ModifyDateTime" HeaderStyle-Width="140px" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
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
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/MaterialConfig/MaterialSysConfigEdit.aspx?name=MaterialConfigAdd&ID=-1";
            dialog({ title: "<%=Resources.Pages.MaterialConfigAdd %>", src: openWinUrl, width: 650, height: 400 });
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/MaterialConfig/MaterialSysConfigEdit.aspx?name=MaterialConfigEdit&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.MaterialConfigEdit %>", src: openWinUrl, width: 600, height: 400 });
        }

        function Delete() {
            //xiang.yan 2024-4-28  列取值由索引改为列明
            // 3 改为 IsGlobal
            var IsGlobal = getOneRecordCellTextByFiled("IsGlobal");
            if (IsGlobal == "是") {
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
