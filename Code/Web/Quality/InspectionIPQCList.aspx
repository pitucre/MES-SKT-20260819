<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" CodeBehind="InspectionIPQCList.aspx.cs" Inherits="SKT.LeanMES.Web.Quality.InspectionIPQCList" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">
                检验类型
            </td>
            <td class="Field2">
                <select name="selIQCType" id="selIQCType" runat="server">
                    <option value="">请选择</option>
                    <option value="0">待检验</option>
                    <option value="1">已检验</option>
                </select>
            </td>
            <td class="Label2">
               检验单号
            </td>
            <td class="Field2">
                <asp:TextBox runat="server" ID="txtIqcBatchNO" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                物料编码
            </td>
            <td class="Field2">
                <asp:TextBox runat="server" ID="txtItemCode" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label2">
                物料名称
            </td>
            <td class="Field2">
                <asp:TextBox runat="server" ID="txtItemName" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" 
        onrowdatabound="GridView1_RowDataBound">
        <Columns>
            <asp:BoundField DataField="ProductIPQCNo" HeaderText="检验单号" />
            <asp:BoundField DataField="OrderNO" HeaderText="工单编号" />
            <asp:BoundField DataField="ItemCode" HeaderText="<%$ Resources:lang, ItemCode %>" />
            <asp:BoundField DataField="ItemName" HeaderText="<%$ Resources:lang, ItemName %>" />
            <asp:BoundField DataField="InspectionQty" HeaderText="检查数量" />
            <asp:BoundField DataField="ShiftType" HeaderText="班别" />
            <asp:BoundField DataField="Statue" HeaderText="状态" />
            <asp:BoundField DataField="CreateBy" HeaderText="创建人" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="创建时间" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.DBservice.BLL.DbService"
        SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:HiddenField ID="hdnOperate" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="hdShiftType" runat="server" ClientIDMode="Static" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <script language="javascript" type="text/javascript">
        $(document).ready(function () {
            $("#ckbMultipleSelected").parent().hide();
        })

        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");
        var hdShiftType = $("#hdShiftType");

        function Add() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Quality/InspectionIPQCAdd.aspx?name=Material_IPQCFormAdd&ID=-1";
            dialog({ title: "新增IPQC检验单", src: openWinUrl, width: 500, height: 250 });
        }

        function View() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;

            dialog({ title: "检验单检验",
                src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Quality/InspectionPQCCheck.aspx?name=Material_PQCFormView&TypeId=2&InspectionTypeId=1&IOrderId=" + idStr + "&rnd=" + Math.random(), width: 1200, height: 600
            });
        }

        function Edit() {
            OQCcheck()
        }

        function Delete() {
            var idStr = getDeletingRecordIdString();

            if (idStr == "") return false;
            hdnOperate.val("delete");
            hdnIdString.val(idStr);
            document.forms[0].submit();
        }

        function UpdateList(txtIqcBatchNO) {
            $("#<%=this.txtIqcBatchNO.ClientID %>").val(txtIqcBatchNO);
            document.forms[0].submit();
        }

        function Check() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;

//            dialog({ title: "检验单检验",
//                src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Quality/InspectionIPQCCheck.aspx?name=Material_IPQCFormCheck&TypeId=2&InspectionTypeId=1&IOrderId=" + idStr + "&rnd=" + Math.random(), width: 1200, height: 600
//            });
            window.open("<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Quality/InspectionIPQCCheck.aspx?name=Material_IPQCFormCheck&TypeId=2&InspectionTypeId=1&IOrderId=" + idStr + "&rnd=" + Math.random()); 
        }

        function PQCPrint() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;

            var url = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Quality/InspectionIQCFormPrint.aspx?name=Material_IQCFormPrint&ID=" + idStr + "&rnd=" + Math.random();
            window.open(url);
        }

        //检验报告
        function PQCReportPrint() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;

            var url = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Quality/InspectionIQCReportPrint.aspx?name=Material_IQCFormPrint&ID=" + idStr + "&rnd=" + Math.random();
            window.open(url);
        }

        function Refresh() {
            hdnOperate.val("");
            document.forms[0].submit();
        }

        // 导出PDF文件
        function PdfPrint() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            hdnOperate.val("OQCPdfPrint");
            hdnIdString.val(idStr);
            document.forms[0].submit();
        }
        // 导出PDF文件
        function ReportPdfPrint() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            hdnOperate.val("IPQCReportPdfPrint");
            //xiang.yan 2024-4-28  列取值由索引改为列明,菜单已无此页面
            // 6 改为 ShiftType
            var result = getOneRecordCellTextByFiled("ShiftType");
            hdShiftType.val(result);
            hdnIdString.val(idStr);
            document.forms[0].submit();
        }
    </script>
</asp:Content>


