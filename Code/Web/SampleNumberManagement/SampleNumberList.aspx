<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SampleNumberList.aspx.cs" MasterPageFile="~/Masters/ListMaster.master"
    Inherits="SKT.LeanMES.Web.SampleNumberManagement.SampleNumberList" %>


<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">产品编码
            </td>
            <td class="Field2">
                <asp:TextBox runat="server" ID="txtItemCode" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox><input type="button" class="ButtonBox" onclick="openChoosePage(1)" value="..." />
            </td>
            <td class="Label2">样品编码
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtSampleNumber" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1">
        <Columns>
            <asp:BoundField DataField="ItemCode" HeaderText="<%$ Resources:lang,ItemCode %>" ItemStyle-CssClass="ItemCode" />
            <asp:BoundField DataField="ItemName" HeaderText="产品名称" />
            <asp:BoundField DataField="ItemSpec" HeaderText="产品规格" />
            <asp:BoundField DataField="SampleNumber" HeaderText="样品条码" ItemStyle-CssClass="SampleNumber" />
            <asp:BoundField DataField="SampleName" HeaderText="样品名称" />
            <asp:BoundField DataField="Station" HeaderText="工序" />
            <asp:BoundField DataField="ExpirationDate" HeaderText="失效日期" SortExpression="ExpirationDate" ItemStyle-CssClass="ExpirationDate" />
            <asp:BoundField DataField="NextExpirationDate" HeaderText="下一失效日期" SortExpression="NextExpirationDate" ItemStyle-CssClass="NextExpirationDate" />
            <asp:BoundField DataField="PrototypeAttrName" HeaderText="样机属性" SortExpression="PrototypeAttrName" />
            <asp:BoundField DataField="NcCodes" HeaderText="不良代码" />
            <asp:BoundField DataField="ScrapFlagName" HeaderText="是否报废" SortExpression="ScrapFlagName" />
            <asp:BoundField DataField="CreateBy" HeaderText="创建人" SortExpression="CreateBy" />
            <asp:BoundField DataField="CreateTime" HeaderText="<%$ Resources:lang,CreateTime %>" SortExpression="CreateTime" />
            <asp:BoundField DataField="ModifyBy" HeaderText="修改人" SortExpression="ModifyBy" />
            <asp:BoundField DataField="ModifyTime" HeaderText="修改时间" SortExpression="ModifyTime" />
            <asp:BoundField DataField="SubId" HeaderText="SubId">
                <HeaderStyle CssClass="hidden" />
                <ItemStyle CssClass="hidden" />
                <FooterStyle CssClass="hidden" />
            </asp:BoundField>
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.SampleNumberManagement.BLL.SampleNumber"
        SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <style type="text/css">
        .hidden { display: none; }
    </style>
    <script type="text/javascript">
        isMultiple = false;
        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");
        var flag = -1;
        function Add() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SampleNumberManagement/SampleNumberListEdit.aspx?name=SampleNumberListAdd&ID=-1&ItemCode=";
            dialog({ title: "<%=Resources.Pages.SampleNumberListAdd %>", src: openWinUrl, width: 900, height: 480 });
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            var itemCode = getTextByClass("ItemCode");
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SampleNumberManagement/SampleNumberListEdit.aspx?name=SampleNumberListEdit&ID=" + idStr + "&ItemCode=" + itemCode;
            dialog({ title: "<%=Resources.Pages.SampleNumberListEdit %>", src: openWinUrl, width: 900, height: 550 });
        }

        //报废
        function Scrap() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            var SampleNumber = getTextByClass("SampleNumber");
            hdnOperate.val("scrap");
            hdnIdString.val(SampleNumber);
            document.forms[0].submit();
        }

        //重检
        function ReCheck() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            var SampleNumber = getTextByClass("SampleNumber");
            var ExpirationDate = getTextByClass("ExpirationDate");
            var NextExpirationDate = getTextByClass("NextExpirationDate");
            if (NextExpirationDate != "") {
                ExpirationDate = NextExpirationDate;
            }
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SampleNumberManagement/SampleNumberReCheck.aspx?name=SampleNumberListReCheck&SampleNumber=" + SampleNumber + "&ExpirationDate=" + ExpirationDate;
            dialog({ title: "<%=Resources.Pages.SampleNumberListEdit %>", src: openWinUrl, width: 900, height: 550 });
        }

        function Delete() {
            var idStr = getDeletingRecordIdString();
            if (idStr == "") return false;
            //var subID = getOneRecordCellText(13);
            //var subID = getSelectedSubIdValues();
            hdnOperate.val("delete");
            hdnIdString.val(idStr);
            document.forms[0].submit();
        }
        //function getSelectedSubIdValues() {
        //    var selValues = "";
        //    var checkboxs = document.getElementsByName("chkSelect");
        //    var checkboxCount = checkboxs.length;
        //    //var subIdDom=$('input[name="chkSelect"]:checked').parent().parent().find("td:eq(4)").html();

        //    for (var i = 0; i < checkboxCount; i++) {
        //        if (checkboxs[i].checked) {
        //            if (selValues != "") {
        //                selValues += ",";
        //            }
        //            selValues += $(checkboxs[i]).parent().parent().find("td:eq(14)").html();
        //        }
        //    }
        //    return selValues;
        //}
        function UpdateList(namestr) {
            $("#<%=this.txtItemCode.ClientID %>").val(namestr);
            document.forms[0].submit();
        }

        function Download() {
            return downLoadField('<%=SKT.LeanMES.Web.WebHelper.ExcelTemplateRoot+"样品模板.xlsx" %>');
        }
        function downLoadField(fieldPath) {
            window.open(fieldPath);
            return null;
        }
        function openChoosePage(flags) {
            var condition = "";
            flag = flags;
            dialog({ title: "选择窗口", src: "../Framework/ChoosePage.aspx?PageId=" + flags + "&Multiple=false&SearchCondition=" + condition + "&rnd=" + Math.random(), width: 650, height: 350 });
        }

        function getChooseValue(list) {
            if (flag == 1) {	//选择产品编码
                $("#txtItemCode").val(list[0][2]);
            }
        }
        //根据样式名获取文本
        function getTextByClass(cls) {
            return $.trim($("#<%=this.GridView1.ClientID%> tbody input[name=\"chkSelect\"]:checked").parent().siblings("." + cls).text());
        }
        //导出到EXCEL
        function Export() {
            hdnOperate.val("exportexcel");
            document.forms[0].submit();
            hdnOperate.val("");
        }
        //导入
        function Import() {
            var src = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/SampleNumberManagement/SampleNumberImport.aspx?name=SampleNumberImport";
            dialog({ title: "导入", src: src, width: 850, height: 600 });
        }
    </script>
</asp:Content>
