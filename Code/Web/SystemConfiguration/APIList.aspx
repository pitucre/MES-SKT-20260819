<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" 
    CodeBehind="APIList.aspx.cs" Inherits="SKT.LeanMES.Web.SystemConfiguration.APIList" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1">业务名称</td>
            <td class="Field1">
                <asp:TextBox ID="txtBusinessName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" OnRowDataBound="GridView1_RowDataBound" RowStyle-VerticalAlign="Middle">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="BusinessName" HeaderText="业务名称" />
            <asp:BoundField DataField="FuncName" HeaderText="处理函数" />
            <asp:BoundField DataField="SapParam" HeaderText="传入参数" />
            <asp:BoundField DataField="SapParamDesc" HeaderText="参数描述" />
            <asp:BoundField DataField="SapTabName" HeaderText="SAP内表名" />
            <asp:BoundField DataField="SapFields" HeaderText="SAP读取列"/>
            <asp:BoundField DataField="TargetTabName" HeaderText="目标库表名" />
            <asp:BoundField DataField="TargetTabFields" HeaderText="目标表对应列" />
            <asp:BoundField DataField="AutoHZ" HeaderText="自动同步频率" />
            <asp:BoundField DataField="Remark" HeaderText="备注" />

            <asp:BoundField DataField="ModifyBy" HeaderText="修改人" />
            <asp:BoundField DataField="ModifyTime" HeaderText="修改时间" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" 
        StartRowIndexParameterName="startRow" MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" 
        TypeName="SKT.LeanMES.CommonDataSource.BLL.SAPAPI" SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value=""/>
    <input type="hidden" id="hdnIdString" name="hdnIdString"  value=""/>

    <script type="text/javascript">
        isMultiple = false;
        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");
        function View() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SystemConfiguration/APIView.aspx?name=System_APIListView&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.System_APIListEdit %>", src: openWinUrl, width: 600, height: 350 });
        }

        function Add() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SystemConfiguration/APIEdit.aspx?name=System_APIListAdd&ID=-1";
            dialog({ title: "<%=Resources.Pages.System_APIListAdd %>", src: openWinUrl, width: 650, height: 350 });
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SystemConfiguration/APIEdit.aspx?name=System_APIListEdit&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.System_APIListEdit %>", src: openWinUrl, width: 600, height: 350 });
        }

        function Synchronous() {
            var idStr = getOneRecordId();
            if (idStr == "") { return false; }
            //xiang.yan 2024-4-28  列取值由索引改为列明
            // 2 改为 FuncName
            // 3 改为 SapParam
            // 4 改为 SapParamDesc
            // 5 改为 SapTabName
            // 6 改为 SapFields
            // 7 改为 TargetTabName
            // 8 改为 TargetTabFields
            var sapFunc = getOneRecordCellTextByFiled("FuncName");//处理函数
            var sapParams = getOneRecordCellTextByFiled("SapParam");//传入参数
            var sapParamDesc = getOneRecordCellTextByFiled("SapParamDesc");//参数描述
            var sapTabName = getOneRecordCellTextByFiled("SapTabName");//SAP内表名
            var sapFields = getOneRecordCellTextByFiled("SapFields"); //SAP读取列
            var tarTabName = getOneRecordCellTextByFiled("TargetTabName");//目标库表名
            var tarTabFields = getOneRecordCellTextByFiled("TargetTabFields");//目标表对应列

            if ($.trim(sapTabName) != "") {
                if ($.trim(sapParams) == "") { alert("传入参数为空，请检查接口配置."); return; }
                if ($.trim(tarTabName) == "") { alert("目标库表名为空，请检查接口配置."); return; }
                if ($.trim(tarTabFields) == "") { alert("目标表对应列为空，请检查接口配置."); return; }

                //判断sapFields 与 tarTabFields的列数是否匹配
                sapFields = sapFields.replace(/，/g, ",");
                tarTabFields = sapFields.replace(/，/g, ",");
                var arysapFields = sapFields.split(",");
                var arytarTabFields = tarTabFields.split(",");
                if (arysapFields.length != arytarTabFields.length) {
                    alert("SAP读取列与目标表对应列个数不匹配，请检查接口配置.");
                    return;
                }

                openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SystemConfiguration/APISync.aspx?name=Data_SapInterfaceSync&Type=0&ID=" + idStr;
                dialog({ title: "<%=Resources.Pages.System_APIListSync %>", src: openWinUrl, width: 600, height: 350 });

            } else {
                openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SystemConfiguration/APISync.aspx?name=Data_SapInterfaceSync&Type=1&ID=" + idStr;
                dialog({ title: "<%=Resources.Pages.System_APIListSync %>", src: openWinUrl, width: 600, height: 350 });
            }
        }

        function Delete() {
            var idStr = getDeletingRecordIdString();
            if (idStr == "") return false;
            hdnOperate.val("delete");
            hdnIdString.val(idStr);
            document.forms[0].submit();
        }

        function Refresh() {
            document.forms[0].submit();
        }
    </script>
</asp:Content>
